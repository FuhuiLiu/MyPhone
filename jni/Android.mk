LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_LDLIBS += -lm -llog
LOCAL_MODULE    := MyPhone
LOCAL_SRC_FILES := MyPhone.cpp

include $(BUILD_SHARED_LIBRARY)
