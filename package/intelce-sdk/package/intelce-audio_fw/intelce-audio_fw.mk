################################################################################
#
# intelce-audio_fw
#
################################################################################
INTELCE_AUDIO_FW_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_AUDIO_FW_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_AUDIO_FW_SITE_METHOD = local
INTELCE_AUDIO_FW_LICENSE = PROPRIETARY
INTELCE_AUDIO_FW_REDISTRIBUTE = NO
INTELCE_AUDIO_FW_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-clock_control

INTELCE_AUDIO_FW_INSTALL_STAGING = YES

INTELCE_AUDIO_FW_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_AUDIO_FW_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_AUDIO_FW_CONFIGURE_CMDS
   
endef

define INTELCE_AUDIO_FW_BUILD_CMDS
    if [ -d "${INTELCE_AUDIO_FW_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_AUDIO_FW_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_AUDIO_FW_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_AUDIO_FW_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_AUDIO_FW_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_AUDIO_FW_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_AUDIO_FW_BUILD_ENV} ${INTELCESDK-BUILD} audio_fw
endef

define INTELCE_AUDIO_FW_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_AUDIO_FW_DIR}/build_i686/staging_dir) 
endef

define INTELCE_AUDIO_FW_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_AUDIO_FW_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
