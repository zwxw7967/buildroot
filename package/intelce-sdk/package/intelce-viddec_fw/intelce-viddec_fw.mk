################################################################################
#
# intelce-viddec_fw
#
################################################################################
INTELCE_VIDDEC_FW_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDDEC_FW_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_VIDDEC_FW_SITE_METHOD = local
INTELCE_VIDDEC_FW_LICENSE = PROPRIETARY
INTELCE_VIDDEC_FW_REDISTRIBUTE = NO
INTELCE_VIDDEC_FW_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal linux intelce-platform_config intelce-smd_tools intelce-sven intelce-core intelce-SMD_Common intelce-htuple
INTELCE_VIDDEC_FW_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_VIDPPROC_DEPENDENCIES += intelce-fw_load 
endif

INTELCE_VIDDEC_FW_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_VIDDEC_FW_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_VIDDEC_FW_CONFIGURE_CMDS
   
endef

define INTELCE_VIDDEC_FW_BUILD_CMDS
    if [ -d "${INTELCE_VIDDEC_FW_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_VIDDEC_FW_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_VIDDEC_FW_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_VIDDEC_FW_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_VIDDEC_FW_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_VIDDEC_FW_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_VIDDEC_FW_BUILD_ENV} ${INTELCESDK-BUILD} viddec_fw
endef

define INTELCE_VIDDEC_FW_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_VIDDEC_FW_DIR}/build_i686/staging_dir) 
endef

define INTELCE_VIDDEC_FW_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_VIDDEC_FW_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
