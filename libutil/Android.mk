LOCAL_PATH:= $(call my-dir)

common_src := \
	op_cpufreq.c \
	op_deviceio.c \
	op_file.c \
	op_fileio.c \
	op_get_time.c \
	op_growable_buffer.c \
	op_libiberty.c \
	op_lockfile.c \
	op_popt.c \
	op_string.c \
	op_version.c

common_includes := \
	external/oprofile

# Build libutil on target
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= $(common_src)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libutil

include $(BUILD_STATIC_LIBRARY)

# Build libutil on host
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= $(common_src)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := -fexceptions -DANDROID_HOST -DHAVE_XCALLOC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libutil

include $(BUILD_HOST_STATIC_LIBRARY)

