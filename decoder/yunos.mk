LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
include $(LOCAL_PATH)/../common.mk

LOCAL_SRC_FILES := \
        vaapidecoder_base.cpp \
        vaapidecoder_host.cpp \
        vaapidecsurfacepool.cpp \
        vaapidecpicture.cpp \

LOCAL_SRC_FILES += \
        vaapidecoder_mpeg2.cpp

LOCAL_SRC_FILES += \
        vaapidecoder_h264.cpp

# LOCAL_SRC_FILES += vaapidecoder_h265.cpp

LOCAL_SRC_FILES += \
        vaapidecoder_vp8.cpp

LOCAL_SRC_FILES += \
        vaapidecoder_vp9.cpp

LOCAL_SRC_FILES += \
        vaapidecoder_vc1.cpp

LOCAL_SRC_FILES += \
        vaapiDecoderJPEG.cpp

LOCAL_SRC_FILES += \
        vaapidecoder_fake.cpp

LOCAL_C_INCLUDES += \
        $(LOCAL_PATH)/.. \
        $(LOCAL_PATH)/../common \
        external/libcxx/include 

LOCAL_ALLOW_UNDEFINED_SYMBOLS := true

LOCAL_MODULE := libyami_decoder
include $(BUILD_STATIC_LIBRARY)
