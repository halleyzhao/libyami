/*
 *  encodeInputSurface.cpp - android surface buffer for encode input
 *
 *  Copyright (C) 2014 Intel Corporation
 *    Author: Halley Zhao<aihua.zah@alibaba-inc.com>
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public License
 *  as published by the Free Software Foundation; either version 2.1
 *  of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free
 *  Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 *  Boston, MA 02110-1301 USA
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include "common/log.h"
#include "common/utils.h"
#include "encodeinput.h"

#include <gui/SurfaceComposerClient.h>
#include <gui/ISurfaceComposer.h>
#include <ui/DisplayInfo.h>
#include <ufo/gralloc.h>
#include <ui/GraphicBufferMapper.h>
#include <ufo/graphics.h>
#include <ui/GraphicBuffer.h>

#define GET_ANATIVEWINDOW(w) w.get()
#define CAST_ANATIVEWINDOW(w)   (w)

#define CHECK_RET(ret, str) do {                    \
        if (ret) {                                  \
            ERROR("%s failed: (%d)\n", str, ret);   \
            return false;                           \
        }                                           \
    } while(0)

bool EncodeInputSurface::init(const char* inputFileName, uint32_t fourcc, int width, int height)
{
    m_width = width;
    m_height = height;

    int surfaceWidth = width;
    int surfaceHeight = height;
    static sp<SurfaceComposerClient> client = new SurfaceComposerClient();
    //create surface
    static sp<SurfaceControl> surfaceCtl = client->createSurface(String8("testsurface"),
        surfaceWidth, surfaceHeight, HAL_PIXEL_FORMAT_NV12_Y_TILED_INTEL, 0);
    DEBUG("create surface with size %dx%d, format: 0x%x", surfaceWidth, surfaceHeight, HAL_PIXEL_FORMAT_NV12_Y_TILED_INTEL);
    
    // configure surface
    SurfaceComposerClient::openGlobalTransaction();
    surfaceCtl->setLayer(100000);
    surfaceCtl->setPosition(100, 100);
    surfaceCtl->setSize(surfaceWidth, surfaceHeight);
    SurfaceComposerClient::closeGlobalTransaction();

    m_surface = surfaceCtl->getSurface();
    mNativeWindow = m_surface;

    int bufWidth = width;
    int bufHeight = height;
    int ret;

    INFO("set buffers geometry %dx%d\n", width, height);
    ret = native_window_set_buffers_dimensions(GET_ANATIVEWINDOW(mNativeWindow), width, height);
    CHECK_RET(ret, "native_window_set_buffers_dimensions");

    uint32_t format = HAL_PIXEL_FORMAT_NV12_Y_TILED_INTEL;
    INFO("set buffers format %x\n", format);
    ret = native_window_set_buffers_format(GET_ANATIVEWINDOW(mNativeWindow),format);
    CHECK_RET(ret, "native_window_set_buffers_format");

    INFO("set buffer usage\n");
    ret = native_window_set_usage(GET_ANATIVEWINDOW(mNativeWindow),
            GRALLOC_USAGE_HW_VIDEO_ENCODER | GRALLOC_USAGE_HW_TEXTURE);
    CHECK_RET(ret, "native_window_set_usage");

    INFO("set buffer count %d\n", m_bufferCount);
    ret = native_window_set_buffer_count(GET_ANATIVEWINDOW(mNativeWindow), m_bufferCount);
    CHECK_RET(ret, "native_window_set_buffer_count");

    prepareInputBuffer();
    return true;
}

static int NV12_Generator_Planar(int width, int height,
        uint8_t *Y_start, int Y_pitch, uint8_t *UV_start, int UV_pitch)
{
    static int row_shift = 0;
    int block_width = 8;
    int row=0, col=0;
    uint8_t uv_color = 0;
    uint8_t uv_step = 8 * 256 / height + 1;

    /* create Y plane data */
    for (row=0;row<height;row++) {
        uint8_t *Y_row = Y_start + row * Y_pitch;
        int xpos, ypos;

        ypos = (row / block_width) & 0x1;
        for (col=0; col<width; col++) {
            xpos = ((row_shift + col) / block_width) & 0x1;
            if ((xpos == ypos))
                Y_row[col] = 0xeb;
            else
                Y_row[col] = 0x10;
        }
    }

    /* create UV plane data */
    for( row =0; row < height/2; row++) {
        uint8_t *UV_row = UV_start + row * UV_pitch;
        uv_color += uv_step;
        memset (UV_row,uv_color,width);
    }

    row_shift++;
    if (row_shift==16) row_shift = 0;

    return 0;
}


static void fillSourceBuffer(uint8_t *data, int width, int height /* assumed pitch*/)
{

    uint8_t *y_start, *uv_start;
    int y_pitch, uv_pitch;

    // FIXME, we don't use the real picth
    y_start = data;
    uv_start = data + width * height;
    y_pitch = width;
    uv_pitch = width;

    NV12_Generator_Planar(width, height, y_start, y_pitch, uv_start, uv_pitch);
}

bool EncodeInputSurface::prepareInputBuffer()
{
    int i;
    int ret;
    ANativeWindowBuffer *anb = NULL;
    INFO("init %d input surfaces, this can take some time\n", m_bufferCount);

    for (i = 0; i < m_bufferCount; i++) {
        void *ptr = NULL;
        anb = NULL;
        ret = native_window_dequeue_buffer_and_wait(GET_ANATIVEWINDOW(mNativeWindow), &anb);
        if (ret != 0) {
            ERROR("native_window_dequeue_Buffer failed: (%d)\n", ret);
            return false;
        }

        sp<GraphicBuffer> graphicBuffer = new GraphicBuffer(anb, false);
        graphicBuffer->lock(GraphicBuffer::USAGE_SW_WRITE_OFTEN, &ptr);

        DEBUG("ptr: %p, m_width: %d, m_height: %d\n", ptr, m_width, m_height);
        fillSourceBuffer((uint8_t*)ptr, m_width, m_height);

        graphicBuffer->unlock();
        DEBUG("%d, fille anb: %p done\n", i, anb);

        mBufferInfo.push(anb);
    }

    anb = mBufferInfo.front();
    mBufferInfo.pop();
    ret = CAST_ANATIVEWINDOW(mNativeWindow)->cancelBuffer(GET_ANATIVEWINDOW(mNativeWindow), anb, -1);

    anb = mBufferInfo.front();
    mBufferInfo.pop();
    ret |= CAST_ANATIVEWINDOW(mNativeWindow)->cancelBuffer( GET_ANATIVEWINDOW(mNativeWindow),anb, -1);

    if (ret != 0) {
        WARNING("can not return buffer to native window");
        return false;
    }

    INFO("init input surface finished\n");

    return true;
}


bool EncodeInputSurface::getOneFrameInput(VideoFrameRawData &inputBuffer)
{
    ANativeWindowBuffer *anb = NULL;
    memset(&inputBuffer, 0, sizeof(inputBuffer));
    inputBuffer.memoryType = VIDEO_DATA_MEMORY_TYPE_ANDROID_NATIVE_BUFFER;

    anb = mBufferInfo.front();
    mBufferInfo.pop();
    DEBUG("queue anb: %p\n", anb);
    int ret = GET_ANATIVEWINDOW(mNativeWindow)->queueBuffer(
              GET_ANATIVEWINDOW(mNativeWindow), anb, -1);
    if (ret != 0) {
        ERROR("queueBuffer failed: %s (%d)", strerror(-ret), -ret);
        return false;
    }

    ret = native_window_dequeue_buffer_and_wait(
              GET_ANATIVEWINDOW(mNativeWindow), &anb);
    if (ret != 0) {
        ERROR("native_window_dequeue_Buffer failed: (%d)\n", ret);
        return false;
    }

    inputBuffer.handle = (intptr_t)anb;
    DEBUG("get ANativeWindowBuffer: %p from surface to encode\n", anb);
    // FIXME, push it to queue after finish encoding
    mBufferInfo.push(anb);

    return true;
}


