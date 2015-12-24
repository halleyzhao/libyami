LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MULTILIB = 64

LOCAL_SRC_FILES := \
        v4l2_codecbase.cpp \
        v4l2_decode.cpp \
        v4l2_encode.cpp \
        v4l2_wrapper.cpp

LOCAL_C_INCLUDES:= \
        $(LOCAL_PATH)/.. \
        $(LOCAL_PATH)/../interface \
        external/libcxx/include \
        $(TARGET_OUT_HEADERS)/libva \

LOCAL_SHARED_LIBRARIES := \
        liblog \
        libc++ \
        libva \
        libva-android

LOCAL_WHOLE_STATIC_LIBRARIES := \
        libyami_common \
        libcodecparser \
        libyami_vaapi \
        libyami_vpp \
        libyami_decoder \
        libyami_encoder

LOCAL_CFLAGS := \
         -O2 -Wno-sign-compare

ifeq ($(ENABLE-V4L2-OPS),true)
LOCAL_CFLAGS += -D__ENABLE_V4L2_OPS__
endif

LOCAL_MODULE := libyami_v4l2
include $(BUILD_SHARED_LIBRARY)
