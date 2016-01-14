################################################################################
#
# intelce-viddec
#
################################################################################
INTELCE_VIDDEC_VERSION = ${INTEL_SDK_VERSION}
INTELCE_VIDDEC_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_VIDDEC_SITE_METHOD = local
INTELCE_VIDDEC_LICENSE = PROPRIETARY
INTELCE_VIDDEC_REDISTRIBUTE = NO
INTELCE_VIDDEC_DEPENDENCIES = intel-sdk intelce-viddec_fw intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-video_ces intelce-intel_ce_pm
INTELCE_VIDDEC_INSTALL_STAGING = YES

INTELCE_VIDDEC_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_VIDDEC_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_VIDDEC_CONFIGURE_CMDS
   
endef

define INTELCE_VIDDEC_BUILD_CMDS
    if [ -d "${INTELCE_VIDDEC_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_VIDDEC_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_VIDDEC_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_VIDDEC_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_VIDDEC_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_VIDDEC_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_VIDDEC_BUILD_ENV} ${INTELSDK-BUILD} viddec
endef

define INTELCE_VIDDEC_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_VIDDEC_DIR}/build_i686/staging_dir) 
endef

define INTELCE_VIDDEC_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_VIDDEC_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
