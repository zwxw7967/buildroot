################################################################################
#
# intelce-clock_recovery
#
################################################################################
INTELCE_CLOCK_RECOVERY_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_CLOCK_RECOVERY_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_CLOCK_RECOVERY_SITE_METHOD = local
INTELCE_CLOCK_RECOVERY_LICENSE = PROPRIETARY
INTELCE_CLOCK_RECOVERY_REDISTRIBUTE = NO
INTELCE_CLOCK_RECOVERY_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-clock
INTELCE_CLOCK_RECOVERY_INSTALL_STAGING = YES

INTELCE_CLOCK_RECOVERY_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_CLOCK_RECOVERY_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_CLOCK_RECOVERY_CONFIGURE_CMDS
   
endef

define INTELCE_CLOCK_RECOVERY_BUILD_CMDS
    if [ -d "${INTELCE_CLOCK_RECOVERY_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_CLOCK_RECOVERY_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_CLOCK_RECOVERY_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_CLOCK_RECOVERY_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_CLOCK_RECOVERY_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_CLOCK_RECOVERY_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_CLOCK_RECOVERY_BUILD_ENV} ${INTELCESDK-BUILD} clock_recovery
endef

define INTELCE_CLOCK_RECOVERY_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_CLOCK_RECOVERY_DIR}/build_i686/staging_dir) 
endef

define INTELCE_CLOCK_RECOVERY_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_CLOCK_RECOVERY_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
