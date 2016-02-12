################################################################################
#
# intelce-display
#
################################################################################
INTELCE_DISPLAY_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_DISPLAY_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_DISPLAY_SITE_METHOD = local
INTELCE_DISPLAY_LICENSE = PROPRIETARY
INTELCE_DISPLAY_REDISTRIBUTE = NO
INTELCE_DISPLAY_INSTALL_STAGING = YES

INTELCE_DISPLAY_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_DISPLAY_DIR} \
    BUILD_SMD_COMMOM=false 
    
ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_DISPLAY_DEPENDENCIES = intelce-sdk intelce-auto_eas intelce-clock_control intelce-hdmi_hdcp intelce-idl intelce-intel_ce_pm linux intelce-osal intelce-pal intelce-platform_config intelce-sec intelce-system_utils intelce-sven intelce-generic_timer freetype libpng zlib intelce-intel_ce_pm
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_DISPLAY_DEPENDENCIES = intelce-sdk intelce-api intelce-auto_eas intelce-clock_control intelce-core intelce-hdmi_hdcp intelce-idl linux intelce-osal intelce-pal intelce-platform_config intelce-system_utils intelce-sven intelce-generic_timer intelce-iosf freetype libpng zlib intelce-intel_ce_pm
endif

define INTELCE_DISPLAY_BUILD_CMDS
    if [ -d "${INTELCE_DISPLAY_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_DISPLAY_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_DISPLAY_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_DISPLAY_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_DISPLAY_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_DISPLAY_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_DISPLAY_BUILD_ENV} ${INTELCESDK-BUILD} display
endef

define INTELCE_DISPLAY_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_DISPLAY_DIR}/build_i686/staging_dir)
	$(INSTALL) -m 644 package/intelce-sdk/package/intelce-display/gdl.pc $(STAGING_DIR)/usr/lib/pkgconfig/gdl.pc
endef

define INTELCE_DISPLAY_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_DISPLAY_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
