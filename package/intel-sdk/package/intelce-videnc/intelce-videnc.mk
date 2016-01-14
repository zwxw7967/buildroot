################################################################################
#
# intelce-videnc
#
################################################################################
INTELCE_VIDENC_VERSION = ${INTEL_SDK_VERSION}
INTELCE_VIDENC_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_VIDENC_SITE_METHOD = local
INTELCE_VIDENC_LICENSE = PROPRIETARY
INTELCE_VIDENC_REDISTRIBUTE = NO
INTELCE_VIDENC_DEPENDENCIES = intel-sdk intelce-video_ces intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-intel_ce_pm
INTELCE_VIDENC_INSTALL_STAGING = YES

INTELCE_VIDENC_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_VIDENC_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_VIDENC_CONFIGURE_CMDS
   
endef

define INTELCE_VIDENC_BUILD_CMDS
    if [ -d "${INTELCE_VIDENC_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_VIDENC_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_VIDENC_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_VIDENC_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_VIDENC_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_VIDENC_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_VIDENC_BUILD_ENV} ${INTELSDK-BUILD} videnc
endef

define INTELCE_VIDENC_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_VIDENC_DIR}/build_i686/staging_dir) 
endef

define INTELCE_VIDENC_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_VIDENC_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
