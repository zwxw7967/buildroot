################################################################################
#
# intelce-smd_sample_apps
#
################################################################################
INTELCE_SMD_SAMPLE_APPS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SMD_SAMPLE_APPS_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_SMD_SAMPLE_APPS_SITE_METHOD = local
INTELCE_SMD_SAMPLE_APPS_LICENSE = PROPRIETARY
INTELCE_SMD_SAMPLE_APPS_REDISTRIBUTE = NO
INTELCE_SMD_SAMPLE_APPS_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-SMD_Common intelce-platform_config intelce-api intelce-core intelce-audio intelce-audio_fw intelce-clock intelce-clock_recovery intelce-demux intelce-viddec intelce-vidpproc intelce-display intelce-vidrend intelce-bufmon intelce-gstreamer intelce-edl intelce-system_utils intelce-tsout intelce-idl intelce-avcap intelce-smd_avcap_shim intelce-remux intelce-vidsink intelce-videnc intelce-mux intelce-sec
INTELCE_SMD_SAMPLE_APPS_INSTALL_STAGING = YES

INTELCE_SMD_SAMPLE_APPS_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_SMD_SAMPLE_APPS_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_SMD_SAMPLE_APPS_CONFIGURE_CMDS
   
endef

define INTELCE_SMD_SAMPLE_APPS_BUILD_CMDS
    if [ -d "${INTELCE_SMD_SAMPLE_APPS_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_SMD_SAMPLE_APPS_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_SMD_SAMPLE_APPS_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_SMD_SAMPLE_APPS_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_SMD_SAMPLE_APPS_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_SMD_SAMPLE_APPS_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_SMD_SAMPLE_APPS_BUILD_ENV} ${INTELCESDK-BUILD} smd_sample_apps
endef

define INTELCE_SMD_SAMPLE_APPS_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_SMD_SAMPLE_APPS_DIR}/build_i686/staging_dir) 
endef

define INTELCE_SMD_SAMPLE_APPS_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_SMD_SAMPLE_APPS_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
