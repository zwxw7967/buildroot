################################################################################
#
# intelce-video_ces
#
################################################################################
INTELCE_VIDEO_CES_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDEO_CES_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_VIDEO_CES_SITE_METHOD = local
INTELCE_VIDEO_CES_LICENSE = PROPRIETARY
INTELCE_VIDEO_CES_REDISTRIBUTE = NO
INTELCE_VIDEO_CES_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-intel_ce_pm intelce-sec
INTELCE_VIDEO_CES_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_VIDPPROC_DEPENDENCIES += intelce-fw_load 
endif

INTELCE_VIDEO_CES_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_VIDEO_CES_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_VIDEO_CES_CONFIGURE_CMDS
   
endef

define INTELCE_VIDEO_CES_BUILD_CMDS
    if [ -d "${INTELCE_VIDEO_CES_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_VIDEO_CES_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_VIDEO_CES_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_VIDEO_CES_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_VIDEO_CES_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_VIDEO_CES_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_VIDEO_CES_BUILD_ENV} ${INTELCESDK-BUILD} video_ces
endef

define INTELCE_VIDEO_CES_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_VIDEO_CES_DIR}/build_i686/staging_dir) 
endef

define INTELCE_VIDEO_CES_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_VIDEO_CES_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
