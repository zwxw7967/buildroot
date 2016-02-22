################################################################################
#
# qttests
#
################################################################################
QTTESTS_VERSION = 809b0badee424dcf732669eb316d5d5bd49f958c
QTTESTS_SITE_METHOD = git
QTTESTS_SITE = git@github.com:magomez/qttests.git
QTTESTS_LICENSE = GPLv2
QTTESTS_DEPENDENCIES = qt5base

define QTTESTS_CONFIGURE_CMDS
	(cd $(@D); \
		$(TARGET_MAKE_ENV) \
		$(HOST_DIR)/usr/bin/qmake \
			./qttests.pro \
	)
endef

define QTTESTS_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QTTESTS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/eglimage/eglimage-viewer/eglimage-viewer $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/eglimage/eglimage-renderer/eglimage-renderer $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/stencil/stencil $(TARGET_DIR)/usr/bin
endef

define QTTESTS_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/bin/eglimage-viewer
	rm -f $(TARGET_DIR)/usr/bin/eglimage-renderer
	rm -f $(TARGET_DIR)/usr/bin/stencil
endef

$(eval $(generic-package))
