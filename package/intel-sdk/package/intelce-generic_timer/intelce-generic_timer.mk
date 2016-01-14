################################################################################
#
# intelce-generic_timer
#
################################################################################
INTELCE_GENERIC_TIMER_VERSION = ${INTEL_SDK_VERSION}
INTELCE_GENERIC_TIMER_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_GENERIC_TIMER_SITE_METHOD = local
INTELCE_GENERIC_TIMER_LICENSE = PROPRIETARY
INTELCE_GENERIC_TIMER_REDISTRIBUTE = NO
INTELCE_GENERIC_TIMER_DEPENDENCIES = intel-sdk intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config
INTELCE_GENERIC_TIMER_INSTALL_STAGING = YES

INTELCE_GENERIC_TIMER_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_GENERIC_TIMER_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_GENERIC_TIMER_CONFIGURE_CMDS
   
endef

define INTELCE_GENERIC_TIMER_BUILD_CMDS
    if [ -d "${INTELCE_GENERIC_TIMER_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_GENERIC_TIMER_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_GENERIC_TIMER_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_GENERIC_TIMER_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_GENERIC_TIMER_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_GENERIC_TIMER_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_GENERIC_TIMER_BUILD_ENV} ${INTELSDK-BUILD} generic_timer
endef

define INTELCE_GENERIC_TIMER_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_GENERIC_TIMER_DIR}/build_i686/staging_dir) 
endef

define INTELCE_GENERIC_TIMER_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_GENERIC_TIMER_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
