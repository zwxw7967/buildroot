################################################################################
#
# intelce-8051_SDK
#
################################################################################
INTELCE_8051_SDK_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_8051_SDK_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_8051_SDK_SITE_METHOD = local
INTELCE_8051_SDK_LICENSE = PROPRIETARY
INTELCE_8051_SDK_REDISTRIBUTE = NO
INTELCE_8051_SDK_DEPENDENCIES = intelce-sdk
INTELCE_8051_SDK_INSTALL_STAGING = YES

INTELCE_8051_SDK_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_8051_SDK_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_8051_SDK_CONFIGURE_CMDS
   
endef

define INTELCE_8051_SDK_BUILD_CMDS
    if [ -d "${INTELCE_8051_SDK_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_8051_SDK_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_8051_SDK_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_8051_SDK_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_8051_SDK_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_8051_SDK_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_8051_SDK_BUILD_ENV} ${INTELCESDK-BUILD} 8051_SDK
endef

define INTELCE_8051_SDK_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_8051_SDK_DIR}/build_i686/staging_dir) 
endef

define INTELCE_8051_SDK_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_8051_SDK_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
