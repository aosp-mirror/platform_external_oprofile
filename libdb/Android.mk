LOCAL_PATH:= $(call my-dir)

common_src := \
	db_debug.c \
	db_insert.c \
	db_manage.c \
	db_stat.c \
	db_travel.c

common_includes := \
	external/oprofile \
	external/oprofile/libutil

# Build libdb on target
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= $(common_src)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libdb

include $(BUILD_STATIC_LIBRARY)

# Build libdb on host
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= $(common_src)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := -fexceptions -DANDROID_HOST

ifneq ($(HOST_OS),linux)
LOCAL_CFLAGS += -DMISSING_MREMAP
endif

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libdb

include $(BUILD_HOST_STATIC_LIBRARY)
