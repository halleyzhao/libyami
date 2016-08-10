LOCAL_CFLAGS := -D__ENABLE_DEBUG__ -Wno-sign-compare -Wno-unused-parameter -O2 -std=c++11
LOCAL_CPPFLAGS := -D__ENABLE_DEBUG__ -Wno-sign-compare -Wno-unused-parameter -O2 -std=c++11

ENABLE-V4L2-OPS=true

## for yunos.mk
LOCAL_LDFLAGS += -lpthread -lstdc++
LOCAL_C_INCLUDES += $(LIBYAMICODEC_PATH)/../libva/
