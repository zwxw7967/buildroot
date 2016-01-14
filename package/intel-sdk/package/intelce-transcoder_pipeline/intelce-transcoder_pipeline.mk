################################################################################
#
# intelce-transcoder_pipeline
#
################################################################################
INTELCE_TRANSCODER_PIPELINE_VERSION = ${INTEL_SDK_VERSION}
INTELCE_TRANSCODER_PIPELINE_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_TRANSCODER_PIPELINE_SITE_METHOD = local
INTELCE_TRANSCODER_PIPELINE_LICENSE = PROPRIETARY
INTELCE_TRANSCODER_PIPELINE_REDISTRIBUTE = NO
INTELCE_TRANSCODER_PIPELINE_DEPENDENCIES = intel-sdk linux intelce-api intelce-osal intelce-SMD_Common intelce-core intelce-demux intelce-viddec intelce-vidpproc intelce-audio intelce-audio_fw intelce-transcoder_common intelce-video_ces intelce-videnc intelce-mux
INTELCE_TRANSCODER_PIPELINE_INSTALL_STAGING = YES

INTELCE_TRANSCODER_PIPELINE_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_TRANSCODER_PIPELINE_DIR} \
    BUILD_SMD_COMMOM=true 
    
define INTELCE_TRANSCODER_PIPELINE_CONFIGURE_CMDS
   
endef

define INTELCE_TRANSCODER_PIPELINE_BUILD_CMDS
    if [ -d "${INTELCE_TRANSCODER_PIPELINE_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_TRANSCODER_PIPELINE_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_TRANSCODER_PIPELINE_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_TRANSCODER_PIPELINE_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_TRANSCODER_PIPELINE_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_TRANSCODER_PIPELINE_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_TRANSCODER_PIPELINE_BUILD_ENV} ${INTELSDK-BUILD} transcoder_pipeline
endef

define INTELCE_TRANSCODER_PIPELINE_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_TRANSCODER_PIPELINE_DIR}/build_i686/staging_dir) 
endef

define INTELCE_TRANSCODER_PIPELINE_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_TRANSCODER_PIPELINE_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
