include $(CLEAR_VARS)
include $(LIBYAMICODEC_PATH)/common.mk

LOCAL_SRC_FILES := \
        decoder/vaapidecoder_base.cpp \
        decoder/vaapidecoder_host.cpp \
        decoder/vaapidecsurfacepool.cpp \
        decoder/vaapidecpicture.cpp \

LOCAL_SRC_FILES += \
        decoder/vaapidecoder_mpeg2.cpp

LOCAL_SRC_FILES += \
        decoder/vaapidecoder_h264.cpp

# LOCAL_SRC_FILES += vaapidecoder_h265.cpp

LOCAL_SRC_FILES += \
        decoder/vaapidecoder_vp8.cpp

LOCAL_SRC_FILES += \
        decoder/vaapidecoder_vp9.cpp

LOCAL_SRC_FILES += \
        decoder/vaapidecoder_vc1.cpp

LOCAL_SRC_FILES += \
        decoder/vaapiDecoderJPEG.cpp

LOCAL_SRC_FILES += \
        decoder/vaapidecoder_fake.cpp

LOCAL_C_INCLUDES += \
        $(LOCAL_PATH)/.. \
        $(LOCAL_PATH)/../common \
        external/libcxx/include 

LOCAL_ALLOW_UNDEFINED_SYMBOLS := true

LOCAL_MODULE := libyami_decoder
include $(BUILD_STATIC_LIBRARY)
