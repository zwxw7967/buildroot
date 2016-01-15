################################################################################
#
# intelce-vidsink
#
################################################################################
INTELCE_VIDSINK_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDSINK_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_VIDSINK_SITE_METHOD = local
INTELCE_VIDSINK_LICENSE = PROPRIETARY
INTELCE_VIDSINK_REDISTRIBUTE = NO
INTELCE_VIDSINK_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-api intelce-core intelce-osal intelce-auto_eas intelce-sven intelce-smd_tools intelce-common linux intelce-SMD_Common intelce-vidrend intelce-vidpproc
INTELCE_VIDSINK_INSTALL_STAGING = YES

INTELCE_VIDSINK_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_VIDSINK_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_VIDSINK_CONFIGURE_CMDS
   
endef

define INTELCE_VIDSINK_BUILD_CMDS
    if [ -d "${INTELCE_VIDSINK_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_VIDSINK_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_VIDSINK_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_VIDSINK_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_VIDSINK_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_VIDSINK_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_VIDSINK_BUILD_ENV} ${INTELCESDK-BUILD} vidsink
endef

define INTELCE_VIDSINK_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_VIDSINK_DIR}/build_i686/staging_dir) 
endef

define INTELCE_VIDSINK_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_VIDSINK_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
