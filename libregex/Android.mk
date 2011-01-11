LOCAL_PATH:= $(call my-dir)

# Build libregex on host
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	op_regex.cpp \
	demangle_symbol.cpp \
	demangle_java_symbol.cpp

LOCAL_C_INCLUDES := \
	external/oprofile \
	external/oprofile/libutil++

LOCAL_CFLAGS := -fexceptions -DANDROID_HOST
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libop_regex

include $(BUILD_HOST_STATIC_LIBRARY)

