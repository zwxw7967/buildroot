################################################################################
#
# intelce-smd_tools
#
################################################################################
INTELCE_SMD_TOOLS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SMD_TOOLS_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_SMD_TOOLS_SITE_METHOD = local
INTELCE_SMD_TOOLS_LICENSE = PROPRIETARY
INTELCE_SMD_TOOLS_REDISTRIBUTE = NO
INTELCE_SMD_TOOLS_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-sven linux intelce-SMD_Common
INTELCE_SMD_TOOLS_INSTALL_STAGING = YES

INTELCE_SMD_TOOLS_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_SMD_TOOLS_DIR} \
    BUILD_SMD_COMMOM=true  
    
define INTELCE_SMD_TOOLS_CONFIGURE_CMDS
   
endef

define INTELCE_SMD_TOOLS_BUILD_CMDS
    if [ -d "${INTELCE_SMD_TOOLS_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_SMD_TOOLS_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_SMD_TOOLS_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_SMD_TOOLS_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_SMD_TOOLS_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_SMD_TOOLS_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_SMD_TOOLS_BUILD_ENV} ${INTELCESDK-BUILD} smd_tools
endef

define INTELCE_SMD_TOOLS_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_SMD_TOOLS_DIR}/build_i686/staging_dir) 
endef

define INTELCE_SMD_TOOLS_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_SMD_TOOLS_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
