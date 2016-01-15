################################################################################
#
# intelce-sven
#
################################################################################
INTELCE_SVEN_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SVEN_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_SVEN_SITE_METHOD = local
INTELCE_SVEN_LICENSE = PROPRIETARY
INTELCE_SVEN_REDISTRIBUTE = NO
INTELCE_SVEN_DEPENDENCIES = intelce-sdk linux intelce-htuple intelce-auto_eas intelce-osal intelce-pal intelce-platform_config intelce-SMD_Common intelce-iosf
INTELCE_SVEN_INSTALL_STAGING = YES

INTELCE_SVEN_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_SVEN_DIR} \
    BUILD_SMD_COMMOM=true 
    
define INTELCE_SVEN_CONFIGURE_CMDS
   
endef

define INTELCE_SVEN_BUILD_CMDS
    if [ -d "${INTELCE_SVEN_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_SVEN_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_SVEN_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_SVEN_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_SVEN_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_SVEN_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_SVEN_BUILD_ENV} ${INTELCESDK-BUILD} sven
endef

define INTELCE_SVEN_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_SVEN_DIR}/build_i686/staging_dir) 
endef

define INTELCE_SVEN_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_SVEN_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
