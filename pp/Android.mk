LOCAL_PATH:= $(call my-dir)

common_src := common_option.cpp

common_includes := \
	external/oprofile \
	external/oprofile/libutil \
	external/oprofile/libop \
	external/oprofile/libdb \
	external/oprofile/libopt++ \
	external/oprofile/libutil++ \
	external/oprofile/libregex \
	external/oprofile/libpp

common_libs := \
	libpp \
	libop \
	libutil \
	libdb \
	libop_regex \
	libopt++ \
	libutil++ \
	libpopt \
	libz

common_cflags := -fexceptions -DANDROID_HOST
common_ldlibs := -lbfd -liberty -lintl -liconv

ifeq ($(HAVE_LIBBFD),true)

# Build opreport
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	$(common_src) \
	opreport.cpp \
	opreport_options.cpp

LOCAL_STATIC_LIBRARIES := $(common_libs)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := $(common_cflags)
LOCAL_LDLIBS := $(common_ldlibs)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE:= opreport

include $(BUILD_HOST_EXECUTABLE)

# Build opannotate
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	$(common_src) \
	opannotate.cpp \
	opannotate_options.cpp

LOCAL_STATIC_LIBRARIES := $(common_libs)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := $(common_cflags)
LOCAL_LDLIBS := $(common_ldlibs)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE:= opannotate

include $(BUILD_HOST_EXECUTABLE)

# Build opgprof
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	$(common_src) \
	opgprof.cpp \
	opgprof_options.cpp

LOCAL_STATIC_LIBRARIES := $(common_libs)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := $(common_cflags)
LOCAL_LDLIBS := $(common_ldlibs)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE:= opgprof

include $(BUILD_HOST_EXECUTABLE)

# Build oparchive
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	$(common_src) \
	oparchive.cpp \
	oparchive_options.cpp

LOCAL_STATIC_LIBRARIES := $(common_libs)
LOCAL_C_INCLUDES := $(common_includes)
LOCAL_CFLAGS := $(common_cflags)
LOCAL_LDLIBS := $(common_ldlibs)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE:= oparchive

include $(BUILD_HOST_EXECUTABLE)

endif
