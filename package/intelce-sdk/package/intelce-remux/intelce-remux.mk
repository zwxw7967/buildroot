################################################################################
#
# intelce-remux
#
################################################################################
INTELCE_REMUX_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_REMUX_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_REMUX_SITE_METHOD = local
INTELCE_REMUX_LICENSE = PROPRIETARY
INTELCE_REMUX_REDISTRIBUTE = NO
INTELCE_REMUX_DEPENDENCIES = intelce-sdk intelce-api intelce-core intelce-pal intelce-osal intelce-auto_eas intelce-sven intelce-htuple intelce-system_utils intelce-platform_config intelce-common intelce-smd_tools linux intelce-SMD_Common
INTELCE_REMUX_INSTALL_STAGING = YES

INTELCE_REMUX_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_REMUX_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_REMUX_CONFIGURE_CMDS
   
endef

define INTELCE_REMUX_BUILD_CMDS
    if [ -d "${INTELCE_REMUX_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_REMUX_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_REMUX_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_REMUX_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_REMUX_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_REMUX_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_REMUX_BUILD_ENV} ${INTELCESDK-BUILD} remux
endef

define INTELCE_REMUX_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_REMUX_DIR}/build_i686/staging_dir) 
endef

define INTELCE_REMUX_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_REMUX_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
