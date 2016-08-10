# LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
include $(LIBYAMICODEC_PATH)/common.mk

LOCAL_SRC_FILES := \
        codecparsers/bitReader.cpp \
        codecparsers/bitWriter.cpp \
        codecparsers/nalReader.cpp \
        codecparsers/dboolhuff.c \
        codecparsers/jpegParser.cpp \
        codecparsers/h264Parser.cpp \
        codecparsers/mpeg2_parser.cpp \
        codecparsers/vp8_bool_decoder.cpp \
        codecparsers/vp8_parser.cpp \
        codecparsers/h265Parser.cpp \
        codecparsers/vc1Parser.cpp \
        codecparsers/vp9quant.c \
        codecparsers/vp9parser.cpp

LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/.. \

LOCAL_MODULE := libcodecparser
include $(BUILD_STATIC_LIBRARY)
