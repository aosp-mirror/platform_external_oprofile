LOCAL_PATH:= $(call my-dir)

libabi_common_src := \
	op_abi.c

common_includes := \
	external/oprofile \
	external/oprofile/libdb \
	external/oprofile/libutil \
	external/oprofile/libop \
	external/oprofile/libopt++

# Build libabi on target
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= $(libabi_common_src)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libabi

include $(BUILD_STATIC_LIBRARY)


# Build libabi on host
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	$(libabi_common_src) \
	abi.cpp

LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := -fexceptions -DANDROID_HOST
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libabi

include $(BUILD_HOST_STATIC_LIBRARY)

# Build opimport on host
ifeq ($(HAVE_LIBBFD),true)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= opimport.cpp
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := -fexceptions -DANDROID_HOST
LOCAL_STATIC_LIBRARIES := libabi libdb libopt++ libutil libutil++ libpopt
LOCAL_LDLIBS := -liberty
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := opimport

include $(BUILD_HOST_EXECUTABLE)
endif
