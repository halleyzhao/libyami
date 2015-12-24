LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MULTILIB = 64

LOCAL_CPPFLAGS := \
         -O2 -Wno-sign-compare

LOCAL_SRC_FILES := \
        log.cpp \
        utils.cpp \
        nalreader.cpp

LOCAL_C_INCLUDES:= \
        $(LOCAL_PATH)/.. \
        external/libcxx/include \
        $(TARGET_OUT_HEADERS)/libva \

LOCAL_SHARED_LIBRARIES := \
        liblog \
        libva

LOCAL_MODULE := libyami_common
include $(BUILD_STATIC_LIBRARY)
