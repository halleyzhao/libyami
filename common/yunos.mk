LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
include $(LOCAL_PATH)/../common.mk

LOCAL_SRC_FILES := \
        log.cpp \
        utils.cpp \
        nalreader.cpp \
        surfacepool.cpp

LOCAL_C_INCLUDES += \
        $(LOCAL_PATH)/.. \
        external/libcxx/include

LOCAL_SHARED_LIBRARIES := \
        libva

LOCAL_MODULE := libyami_common
include $(BUILD_STATIC_LIBRARY)
