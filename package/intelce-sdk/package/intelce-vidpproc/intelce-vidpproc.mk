################################################################################
#
# intelce-vidpproc
#
################################################################################
INTELCE_VIDPPROC_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDPPROC_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_VIDPPROC_SITE_METHOD = local
INTELCE_VIDPPROC_LICENSE = PROPRIETARY
INTELCE_VIDPPROC_REDISTRIBUTE = NO
INTELCE_VIDPPROC_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-vidpproc_fw intelce-platform_config intelce-intel_ce_pm

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_VIDPPROC_DEPENDENCIES += intelce-fw_load 
endif


INTELCE_VIDPPROC_INSTALL_STAGING = YES

INTELCE_VIDPPROC_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_VIDPPROC_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_VIDPPROC_CONFIGURE_CMDS
   
endef

define INTELCE_VIDPPROC_BUILD_CMDS
    if [ -d "${INTELCE_VIDPPROC_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_VIDPPROC_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_VIDPPROC_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_VIDPPROC_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_VIDPPROC_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_VIDPPROC_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_VIDPPROC_BUILD_ENV} ${INTELCESDK-BUILD} vidpproc
endef

define INTELCE_VIDPPROC_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_VIDPPROC_DIR}/build_i686/staging_dir) 
endef

define INTELCE_VIDPPROC_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_VIDPPROC_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
