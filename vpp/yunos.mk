LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
include $(LIBYAMICODEC_PATH)/common.mk

LOCAL_SRC_FILES := \
        vaapipostprocess_base.cpp \
        vaapipostprocess_host.cpp \
        vaapipostprocess_scaler.cpp \
        vaapivpppicture.cpp

LOCAL_C_INCLUDES+= \
        $(LOCAL_PATH)/.. \
        $(LOCAL_PATH)/../interface \
        external/libcxx/include

LOCAL_SHARED_LIBRARIES := \
        libva

LOCAL_CPPFLAGS += \
        --rtti

LOCAL_ALLOW_UNDEFINED_SYMBOLS := true

LOCAL_MODULE := libyami_vpp
include $(BUILD_STATIC_LIBRARY)
