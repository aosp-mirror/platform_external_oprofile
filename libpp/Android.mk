LOCAL_PATH:= $(call my-dir)

# Build libpp on host
ifeq ($(HAVE_LIBBFD),true)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	arrange_profiles.cpp \
	callgraph_container.cpp \
	diff_container.cpp \
	filename_spec.cpp \
	format_output.cpp \
	image_errors.cpp \
	locate_images.cpp \
	name_storage.cpp \
	op_header.cpp \
	symbol.cpp \
	parse_filename.cpp \
	populate.cpp \
	profile.cpp \
	profile_container.cpp \
	profile_spec.cpp \
	sample_container.cpp \
	symbol_container.cpp \
	symbol_functors.cpp \
	symbol_sort.cpp \
	xml_utils.cpp \
	populate_for_spu.cpp

LOCAL_C_INCLUDES := \
	external/oprofile \
	external/oprofile/libop \
	external/oprofile/libutil \
	external/oprofile/libdb \
	external/oprofile/libopt++ \
	external/oprofile/libutil++ \
	external/oprofile/libop++ \
	external/oprofile/libregex

LOCAL_CFLAGS := -fexceptions -DANDROID_HOST
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libpp

include $(BUILD_HOST_STATIC_LIBRARY)
endif
