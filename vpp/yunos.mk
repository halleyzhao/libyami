include $(CLEAR_VARS)
include $(LIBYAMICODEC_PATH)/common.mk

LOCAL_SRC_FILES := \
        vpp/vaapipostprocess_base.cpp \
        vpp/vaapipostprocess_host.cpp \
        vpp/vaapipostprocess_scaler.cpp \
        vpp/vaapivpppicture.cpp

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
