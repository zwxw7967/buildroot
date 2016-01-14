################################################################################
#
# intelce-core
#
################################################################################
INTELCE_CORE_VERSION = ${INTEL_SDK_VERSION}
INTELCE_CORE_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_CORE_SITE_METHOD = local
INTELCE_CORE_LICENSE = PROPRIETARY
INTELCE_CORE_REDISTRIBUTE = NO
INTELCE_CORE_DEPENDENCIES = intel-sdk intelce-system_utils intelce-pal intelce-platform_config intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-SMD_Common intelce-api intelce-platform_config intelce-intel_ce_pm
INTELCE_CORE_INSTALL_STAGING = YES

INTELCE_CORE_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_CORE_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_CORE_CONFIGURE_CMDS
   
endef

define INTELCE_CORE_BUILD_CMDS
    if [ -d "${INTELCE_CORE_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_CORE_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_CORE_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_CORE_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_CORE_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_CORE_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_CORE_BUILD_ENV} ${INTELSDK-BUILD} core
endef

define INTELCE_CORE_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_CORE_DIR}/build_i686/staging_dir) 
endef

define INTELCE_CORE_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_CORE_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
