LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
include $(LOCAL_PATH)/../common.mk

LOCAL_SRC_FILES := \
        v4l2_codecbase.cpp \
        v4l2_decode.cpp \
        v4l2_encode.cpp \
        v4l2_wrapper.cpp

LOCAL_C_INCLUDES:= \
        $(LOCAL_PATH)/.. \
        $(LOCAL_PATH)/../interface \
        external/libcxx/include

LOCAL_SHARED_LIBRARIES := \
        libva \
        libva_wayland

ifeq ($(ENABLE-V4L2-OPS),true)
LOCAL_CFLAGS += -D__ENABLE_V4L2_OPS__
endif

LOCAL_ALLOW_UNDEFINED_SYMBOLS := true

LOCAL_MODULE := libyami_v4l2
include $(BUILD_STATIC_LIBRARY)
