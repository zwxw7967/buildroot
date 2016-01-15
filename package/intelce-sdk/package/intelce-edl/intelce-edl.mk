################################################################################
#
# intelce-edl
#
################################################################################
INTELCE_EDL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_EDL_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_EDL_SITE_METHOD = local
INTELCE_EDL_LICENSE = PROPRIETARY
INTELCE_EDL_REDISTRIBUTE = NO
INTELCE_EDL_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-idl intelce-audio intelce-SMD_Common intelce-smd_tools intelce-pal intelce-flash_appdata intelce-system_utils
INTELCE_EDL_INSTALL_STAGING = YES

INTELCE_EDL_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_EDL_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_EDL_CONFIGURE_CMDS
   
endef

define INTELCE_EDL_BUILD_CMDS
    if [ -d "${INTELCE_EDL_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_EDL_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_EDL_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_EDL_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_EDL_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_EDL_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_EDL_BUILD_ENV} ${INTELCESDK-BUILD} edl
endef

define INTELCE_EDL_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_EDL_DIR}/build_i686/staging_dir) 
endef

define INTELCE_EDL_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_EDL_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
