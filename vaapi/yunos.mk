include $(CLEAR_VARS)
include $(LIBYAMICODEC_PATH)/common.mk


LOCAL_SRC_FILES := \
        vaapi/vaapipicture.cpp \
        vaapi/VaapiBuffer.cpp \
        vaapi/VaapiSurface.cpp\
        vaapi/VaapiUtils.cpp \
        vaapi/vaapidisplay.cpp \
        vaapi/vaapicontext.cpp \
        vaapi/vaapisurfaceallocator.cpp

LOCAL_C_INCLUDES+= \
        $(LOCAL_PATH)/.. \
        external/libcxx/include

LOCAL_SHARED_LIBRARIES := \
        liblog \
        libva \
        libva_wayland

LOCAL_CPPFLAGS += \
        --rtti

LOCAL_MODULE := libyami_vaapi
include $(BUILD_STATIC_LIBRARY)
