LOCAL_PATH:= $(call my-dir)

# Build libopt++ on host
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= popt_options.cpp
LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/.. \
	$(LOCAL_PATH)/../libutil \
	$(LOCAL_PATH)/../libutil++
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libopt++

include $(BUILD_HOST_STATIC_LIBRARY)

