################################################################################
#
# intelce-SMD_Common
#
################################################################################
INTELCE_SMD_COMMON_VERSION = ${INTEL_SDK_VERSION}
INTELCE_SMD_COMMON_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_SMD_COMMON_SITE_METHOD = local
INTELCE_SMD_COMMON_LICENSE = PROPRIETARY
INTELCE_SMD_COMMON_REDISTRIBUTE = NO
INTELCE_SMD_COMMON_DEPENDENCIES = intel-sdk
INTELCE_SMD_COMMON_INSTALL_STAGING = YES

INTELCE_SMD_COMMON_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_SMD_COMMON_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_SMD_COMMON_CONFIGURE_CMDS
   
endef

define INTELCE_SMD_COMMON_BUILD_CMDS
    if [ -d "${INTELCE_SMD_COMMON_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_SMD_COMMON_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_SMD_COMMON_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_SMD_COMMON_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_SMD_COMMON_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_SMD_COMMON_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_SMD_COMMON_BUILD_ENV} ${INTELSDK-BUILD} SMD_Common
endef

define INTELCE_SMD_COMMON_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_SMD_COMMON_DIR}/build_i686/staging_dir) 
endef

define INTELCE_SMD_COMMON_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_SMD_COMMON_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
