################################################################################
#
# intelce-api
#
################################################################################
INTELCE_API_VERSION = ${INTEL_SDK_VERSION}
INTELCE_API_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_API_SITE_METHOD = local
INTELCE_API_LICENSE = PROPRIETARY
INTELCE_API_REDISTRIBUTE = NO
INTELCE_API_DEPENDENCIES = intel-sdk intelce-SMD_Common
INTELCE_API_INSTALL_STAGING = YES

INTELCE_API_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_API_DIR} \
    BUILD_SMD_COMMOM=true 
    
define INTELCE_API_CONFIGURE_CMDS
   
endef

define INTELCE_API_BUILD_CMDS
    if [ -d "${INTELCE_API_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_API_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_API_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_API_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_API_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_API_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_API_BUILD_ENV} ${INTELSDK-BUILD} api
endef

define INTELCE_API_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_API_DIR}/build_i686/staging_dir) 
endef

define INTELCE_API_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_API_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
