################################################################################
#
# intelce-auto_eas
#
################################################################################
INTELCE_AUTO_EAS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_AUTO_EAS_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_AUTO_EAS_SITE_METHOD = local
INTELCE_AUTO_EAS_LICENSE = PROPRIETARY
INTELCE_AUTO_EAS_REDISTRIBUTE = NO
INTELCE_AUTO_EAS_DEPENDENCIES = intelce-sdk intelce-SMD_Common linux
INTELCE_AUTO_EAS_INSTALL_STAGING = YES

INTELCE_AUTO_EAS_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_AUTO_EAS_DIR} \
    BUILD_SMD_COMMOM=true 
    
define INTELCE_AUTO_EAS_CONFIGURE_CMDS
   
endef

define INTELCE_AUTO_EAS_BUILD_CMDS
    if [ -d "${INTELCE_AUTO_EAS_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_AUTO_EAS_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_AUTO_EAS_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_AUTO_EAS_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_AUTO_EAS_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_AUTO_EAS_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_AUTO_EAS_BUILD_ENV} ${INTELCESDK-BUILD} auto_eas
endef

define INTELCE_AUTO_EAS_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_AUTO_EAS_DIR}/build_i686/staging_dir) 
endef

define INTELCE_AUTO_EAS_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_AUTO_EAS_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
