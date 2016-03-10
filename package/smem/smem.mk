################################################################################
#
# smem
#
################################################################################

SMEM_VERSION = 1.4
SMEM_SITE = https://www.selenic.com/smem/download
SMEM_SOURCE = smem-$(SMEM_VERSION).tar.gz

#SMEM_VERSION = 2ab5040d5633
#SMEM_SITE_METHOD = hg
#SMEM_SITE = http://selenic.com/repo/smem

SMEM_LICENSE =  GPLv2
SMEM_LICENSE_FILES = COPYING

SMEM_INSTALL_STAGING = NO
SMEM_INSTALL_TARGET = YES

define SMEM_BUILD_CMDS
       $(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC)" CPPFLAGS="$(TARGET_CPPFLAGS)" CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" -C $(@D)/
endef

define SMEM_INSTALL_STAGING_CMDS
endef

define SMEM_INSTALL_TARGET_CMDS
       mkdir -p $(TARGET_DIR)/usr/bin/
       $(INSTALL) -m 755 $(@D)/smem $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
