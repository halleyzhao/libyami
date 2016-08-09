## static libs for each module
LOCAL_PATH := $(call my-dir)
LIBYAMICODEC_PATH := $(LOCAL_PATH)
include $(CLEAR_VARS)
include $(LIBYAMICODEC_PATH)/common.mk

include $(LIBYAMICODEC_PATH)/common/yunos.mk
include $(LIBYAMICODEC_PATH)/codecparsers/yunos.mk
include $(LIBYAMICODEC_PATH)/vaapi/yunos.mk
include $(LIBYAMICODEC_PATH)/decoder/yunos.mk
include $(LIBYAMICODEC_PATH)/encoder/yunos.mk
include $(LIBYAMICODEC_PATH)/vpp/yunos.mk
# include $(LIBYAMICODEC_PATH)/v4l2/yunos.mk

## libyami
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
include $(LIBYAMICODEC_PATH)/common.mk

LOCAL_SHARED_LIBRARIES := \
        libva \
        libva_wayland
LOCAL_LDFLAGS += -lstdc++

LOCAL_WHOLE_STATIC_LIBRARIES := \
        libcodecparser

LOCAL_MODULE := libyami

include $(BUILD_SHARED_LIBRARY)

## include $(CLEAR_VARS)
## include $(LIBYAMICODEC_PATH)/common.mk
## include $(LIBYAMICODEC_PATH)/examples/yunos.mk
## include $(LIBYAMICODEC_PATH)/tests/yunos.mk
