LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
include $(LIBYAMICODEC_PATH)/common.mk

LOCAL_SRC_FILES := \
        bitReader.cpp \
        bitWriter.cpp \
        nalReader.cpp \
        dboolhuff.c \
        jpegParser.cpp \
        h264Parser.cpp \
        mpeg2_parser.cpp \
        vp8_bool_decoder.cpp \
        vp8_parser.cpp \
        h265Parser.cpp \
        vc1Parser.cpp \
        vp9quant.c \
        vp9parser.cpp

LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/.. \

LOCAL_MODULE := libcodecparser
include $(BUILD_STATIC_LIBRARY)
