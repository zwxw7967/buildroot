################################################################################
#
# intelce-display
#
################################################################################
INTELCE_DISPLAY_VERSION = ${INTEL_SDK_VERSION}
INTELCE_DISPLAY_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_DISPLAY_SITE_METHOD = local
INTELCE_DISPLAY_LICENSE = PROPRIETARY
INTELCE_DISPLAY_REDISTRIBUTE = NO
INTELCE_DISPLAY_DEPENDENCIES = intel-sdk intelce-api intelce-auto_eas intelce-clock_control intelce-core intelce-hdmi_hdcp intelce-idl linux intelce-osal intelce-pal intelce-platform_config intelce-system_utils intelce-sven intelce-generic_timer intelce-iosf freetype libpng zlib intelce-intel_ce_pm
INTELCE_DISPLAY_INSTALL_STAGING = YES

INTELCE_DISPLAY_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_DISPLAY_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_DISPLAY_CONFIGURE_CMDS
   
endef

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
    
    ${INTELCE_DISPLAY_BUILD_ENV} ${INTELSDK-BUILD} display
endef

define INTELCE_DISPLAY_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_DISPLAY_DIR}/build_i686/staging_dir) 
endef

define INTELCE_DISPLAY_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_DISPLAY_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
