################################################################################
#
# intelce-smd_avcap_shim
#
################################################################################
INTELCE_SMD_AVCAP_SHIM_VERSION = ${INTEL_SDK_VERSION}
INTELCE_SMD_AVCAP_SHIM_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_SMD_AVCAP_SHIM_SITE_METHOD = local
INTELCE_SMD_AVCAP_SHIM_LICENSE = PROPRIETARY
INTELCE_SMD_AVCAP_SHIM_REDISTRIBUTE = NO
INTELCE_SMD_AVCAP_SHIM_DEPENDENCIES = intel-sdk intelce-system_utils intelce-api intelce-auto_eas intelce-osal intelce-common intelce-sven linux intelce-core intelce-avcap intelce-SMD_Common intelce-clock_recovery intelce-clock
INTELCE_SMD_AVCAP_SHIM_INSTALL_STAGING = YES

INTELCE_SMD_AVCAP_SHIM_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_SMD_AVCAP_SHIM_DIR} \
    BUILD_SMD_COMMOM=true 
    
define INTELCE_SMD_AVCAP_SHIM_CONFIGURE_CMDS
   
endef

define INTELCE_SMD_AVCAP_SHIM_BUILD_CMDS
    if [ -d "${INTELCE_SMD_AVCAP_SHIM_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_SMD_AVCAP_SHIM_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_SMD_AVCAP_SHIM_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_SMD_AVCAP_SHIM_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_SMD_AVCAP_SHIM_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_SMD_AVCAP_SHIM_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_SMD_AVCAP_SHIM_BUILD_ENV} ${INTELSDK-BUILD} smd_avcap_shim
endef

define INTELCE_SMD_AVCAP_SHIM_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_SMD_AVCAP_SHIM_DIR}/build_i686/staging_dir) 
endef

define INTELCE_SMD_AVCAP_SHIM_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_SMD_AVCAP_SHIM_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
