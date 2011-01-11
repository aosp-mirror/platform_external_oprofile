LOCAL_PATH:= $(call my-dir)

common_src := \
	op_alloc_counter.c \
	op_config.c \
	op_cpu_type.c \
	op_events.c \
	op_get_interface.c \
	op_mangle.c \
	op_parse_event.c \
	op_xml_events.c \
	op_xml_out.c

common_includes := \
	external/oprofile \
	external/oprofile/libutil

# Build libop on target
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= $(common_src)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := -fexceptions -DANDROID_HOST
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libop

include $(BUILD_STATIC_LIBRARY)

# Build libop on host
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= $(common_src)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := -DANDROID_HOST
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libop

include $(BUILD_HOST_STATIC_LIBRARY)

