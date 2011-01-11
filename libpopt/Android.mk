LOCAL_PATH:= $(call my-dir)

common_src := \
	findme.c \
	popt.c \
	poptconfig.c \
	popthelp.c \
	poptparse.c

# Build libpopt on target
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= $(common_src)
LOCAL_CFLAGS += -DHAVE_CONFIG_H
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libpopt

include $(BUILD_STATIC_LIBRARY)

# Build libpopt on host
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= $(common_src)
LOCAL_CFLAGS += -DHAVE_CONFIG_H
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libpopt

include $(BUILD_HOST_STATIC_LIBRARY)

