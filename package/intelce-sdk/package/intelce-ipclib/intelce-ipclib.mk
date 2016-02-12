################################################################################
#
# intelce-ipclib
#
################################################################################
INTELCE_IPCLIB_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IPCLIB_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_IPCLIB_SITE_METHOD = local
INTELCE_IPCLIB_LICENSE = PROPRIETARY
INTELCE_IPCLIB_REDISTRIBUTE = NO
INTELCE_IPCLIB_DEPENDENCIES = intelce-sdk linux intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven intelce-SMD_Common
INTELCE_IPCLIB_INSTALL_STAGING = YES

INTELCE_IPCLIB_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_IPCLIB_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_IPCLIB_CONFIGURE_CMDS
   
endef

define INTELCE_IPCLIB_BUILD_CMDS
    if [ -d "${INTELCE_IPCLIB_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_IPCLIB_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_IPCLIB_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_IPCLIB_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_IPCLIB_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_IPCLIB_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_IPCLIB_BUILD_ENV} ${INTELCESDK-BUILD} ipclib
endef

define INTELCE_IPCLIB_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_IPCLIB_DIR}/build_i686/staging_dir) 
endef

define INTELCE_IPCLIB_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_IPCLIB_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
