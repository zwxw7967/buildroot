################################################################################
#
# intelce-bufmon
#
################################################################################
INTELCE_BUFMON_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_BUFMON_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_BUFMON_SITE_METHOD = local
INTELCE_BUFMON_LICENSE = PROPRIETARY
INTELCE_BUFMON_REDISTRIBUTE = NO
INTELCE_BUFMON_DEPENDENCIES = intelce-sdk intelce-api intelce-core intelce-pal intelce-osal intelce-auto_eas intelce-sven intelce-htuple intelce-system_utils intelce-platform_config intelce-common intelce-smd_tools linux intelce-SMD_Common intelce-clock_recovery
INTELCE_BUFMON_INSTALL_STAGING = YES

INTELCE_BUFMON_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_BUFMON_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_BUFMON_CONFIGURE_CMDS
   
endef

define INTELCE_BUFMON_BUILD_CMDS
    if [ -d "${INTELCE_BUFMON_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_BUFMON_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_BUFMON_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_BUFMON_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_BUFMON_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_BUFMON_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_BUFMON_BUILD_ENV} ${INTELCESDK-BUILD} bufmon
endef

define INTELCE_BUFMON_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_BUFMON_DIR}/build_i686/staging_dir) 
endef

define INTELCE_BUFMON_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_BUFMON_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
