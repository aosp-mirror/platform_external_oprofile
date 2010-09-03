ifeq ($(TARGET_SIMULATOR),false)
    include $(call all-subdir-makefiles)
endif
