BUILDDIR:=$(shell pwd)
OUTPUT_DIR = $(BUILDDIR)/output

BUILDROOT=$(BUILDDIR)/buildroot
BUILDROOT_EXTERNAL=$(BUILDDIR)/br-external
DEFCONFIG_DIR = $(BUILDROOT_EXTERNAL)/configs

TARGETS := $(notdir $(patsubst %_defconfig,%,$(wildcard $(DEFCONFIG_DIR)/*_defconfig)))
TARGETS_CONFIG := $(notdir $(patsubst %_defconfig,%-config,$(wildcard $(DEFCONFIG_DIR)/*_defconfig)))

.PHONY: $(TARGETS) $(TARGETS_CONFIG) clean

$(TARGETS): %: $(OUTPUT_DIR) %-config
	$(MAKE) -C $(BUILDROOT) BR2_EXTERNAL=$(BUILDROOT_EXTERNAL)

$(TARGETS_CONFIG): %-config:
	$(MAKE) -C $(BUILDROOT) BR2_EXTERNAL=$(BUILDROOT_EXTERNAL) "$*_defconfig"

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

clean:
	$(MAKE) -C $(BUILDROOT) BR2_EXTERNAL=$(BUILDROOT_EXTERNAL) clean
