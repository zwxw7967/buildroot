################################################################################
#
# Intelce loaddrivers
#
################################################################################
INTELCE_LOADDRIVERS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_LOADDRIVERS_SITE_METHOD = local
INTELCE_LOADDRIVERS_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_LOADDRIVERS_LICENSE = PROPRIETARY
INTELCE_LOADDRIVERS_REDISTRIBUTE = NO
INTELCE_LOADDRIVERS_DEPENDENCIES = intelce-sdk

define INTELCE_LOADDRIVERS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 package/intelce-sdk/intelce-loaddrivers/init_${INTELCE_SDK_RELEASE} $(TARGET_DIR)/etc/init.d/S20loaddrivers
	$(INSTALL) -m 755 package/intelce-sdk/intelce-loaddrivers/init_utilities $(TARGET_DIR)/etc/init.d/init_utilities
endef

$(eval $(generic-package))
