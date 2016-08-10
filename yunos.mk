## static libs for each module
LOCAL_PATH := $(call my-dir)
LIBYAMICODEC_PATH := $(LOCAL_PATH)
#include $(CLEAR_VARS)

include $(LIBYAMICODEC_PATH)/common/yunos.mk
include $(LIBYAMICODEC_PATH)/codecparsers/yunos.mk
include $(LIBYAMICODEC_PATH)/vaapi/yunos.mk
include $(LIBYAMICODEC_PATH)/decoder/yunos.mk
include $(LIBYAMICODEC_PATH)/encoder/yunos.mk
include $(LIBYAMICODEC_PATH)/vpp/yunos.mk

## libyami
#LOCAL_PATH := $(LIBYAMICODEC_PATH)
include $(CLEAR_VARS)
include $(LIBYAMICODEC_PATH)/common.mk

LOCAL_SRC_FILES := my_dummy.cpp

LOCAL_SHARED_LIBRARIES := \
        libva \
        libva_wayland
LOCAL_LDFLAGS += -lstdc++

LOCAL_WHOLE_STATIC_LIBRARIES := \
        libyami_common

LOCAL_MODULE := libyami

include $(BUILD_SHARED_LIBRARY)

