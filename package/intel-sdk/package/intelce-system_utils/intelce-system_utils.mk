################################################################################
#
# intelce-system_utils
#
################################################################################
INTELCE_SYSTEM_UTILS_VERSION = ${INTEL_SDK_VERSION}
INTELCE_SYSTEM_UTILS_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_SYSTEM_UTILS_SITE_METHOD = local
INTELCE_SYSTEM_UTILS_LICENSE = PROPRIETARY
INTELCE_SYSTEM_UTILS_REDISTRIBUTE = NO
INTELCE_SYSTEM_UTILS_DEPENDENCIES = intel-sdk intelce-osal linux intelce-SMD_Common intelce-pal intelce-sven
INTELCE_SYSTEM_UTILS_INSTALL_STAGING = YES

INTELCE_SYSTEM_UTILS_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_SYSTEM_UTILS_DIR} \
    BUILD_SMD_COMMOM=true 
    
define INTELCE_SYSTEM_UTILS_CONFIGURE_CMDS
   
endef

define INTELCE_SYSTEM_UTILS_BUILD_CMDS
    if [ -d "${INTELCE_SYSTEM_UTILS_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_SYSTEM_UTILS_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_SYSTEM_UTILS_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_SYSTEM_UTILS_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_SYSTEM_UTILS_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_SYSTEM_UTILS_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_SYSTEM_UTILS_BUILD_ENV} ${INTELSDK-BUILD} system_utils
endef

define INTELCE_SYSTEM_UTILS_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_SYSTEM_UTILS_DIR}/build_i686/staging_dir) 
endef

define INTELCE_SYSTEM_UTILS_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_SYSTEM_UTILS_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
