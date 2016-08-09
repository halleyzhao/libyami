## libyami
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

LOCAL_C_INCLUDES+= \
            ./                              \
            $(LIBYAMICODEC_PATH)/codecparsers \
            $(LIBYAMICODEC_PATH)/common     \
            $(LIBYAMICODEC_PATH)/vaapi      \
            $(LIBYAMICODEC_PATH)/interface  \
            $(LIBYAMICODEC_PATH)/decoder    \
            $(LIBYAMICODEC_PATH)/encoder    \
            $(LIBYAMICODEC_PATH)/vpp        \
            $(LIBYAMICODEC_PATH)/v4l2       \
            $(LIBYAMICODEC_PATH)/../libva   \
            external/libcxx/include
LOCAL_CPPFLAGS += --rtti

LOCAL_SHARED_LIBRARIES := \
        libva \
        libva_wayland

LOCAL_LDFLAGS += -lstdc++

LOCAL_MODULE := libyami
include $(BUILD_SHARED_LIBRARY)

## include $(CLEAR_VARS)
## include $(LIBYAMICODEC_PATH)/common.mk
## include $(LIBYAMICODEC_PATH)/examples/yunos.mk
## include $(LIBYAMICODEC_PATH)/tests/yunos.mk
