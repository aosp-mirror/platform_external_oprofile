LOCAL_PATH:= $(call my-dir)

# Build libutil++ on host
ifeq ($(HAVE_LIBBFD),true)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	bfd_support.cpp \
	bfd_spu_support.cpp \
	child_reader.cpp \
	cverb.cpp \
	file_manip.cpp \
	glob_filter.cpp \
	op_bfd.cpp \
	op_exception.cpp \
	op_spu_bfd.cpp \
	path_filter.cpp \
	stream_util.cpp \
	string_filter.cpp \
	string_manip.cpp \
	xml_output.cpp

LOCAL_C_INCLUDES := \
	external/oprofile \
	external/oprofile/libutil \
	external/oprofile/libop \
	external/oprofile/libpp

LOCAL_CFLAGS := -fexceptions -DANDROID_HOST
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libutil++

include $(BUILD_HOST_STATIC_LIBRARY)
endif
