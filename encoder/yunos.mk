include $(CLEAR_VARS)
include $(LIBYAMICODEC_PATH)/common.mk

LOCAL_SRC_FILES := \
        encoder/vaapicodedbuffer.cpp \
        encoder/vaapiencpicture.cpp \
        encoder/vaapiencoder_base.cpp \
        encoder/vaapiencoder_host.cpp \

LOCAL_SRC_FILES += \
        encoder/vaapiencoder_h264.cpp

LOCAL_SRC_FILES += \
        encoder/vaapiencoder_jpeg.cpp

LOCAL_SRC_FILES += \
        encoder/vaapiencoder_vp8.cpp

#LOCAL_SRC_FILES += \
#        vaapiencoder_hevc.cpp

LOCAL_C_INCLUDES+= \
        $(LOCAL_PATH)/.. \
        $(LOCAL_PATH)/../common \
        $(LOCAL_PATH)/../vaapi \
        $(LOCAL_PATH)/../codecparsers \
        external/libcxx/include 

LOCAL_MODULE := libyami_encoder
include $(BUILD_STATIC_LIBRARY)
