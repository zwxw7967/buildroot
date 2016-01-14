################################################################################
#
# intelce-tsout
#
################################################################################
INTELCE_TSOUT_VERSION = ${INTEL_SDK_VERSION}
INTELCE_TSOUT_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_TSOUT_SITE_METHOD = local
INTELCE_TSOUT_LICENSE = PROPRIETARY
INTELCE_TSOUT_REDISTRIBUTE = NO
INTELCE_TSOUT_DEPENDENCIES = intel-sdk intelce-core intelce-pal intelce-platform_config intelce-auto_eas intelce-osal intelce-htuple intelce-system_utils intelce-common intelce-smd_tools intelce-sven linux intelce-SMD_Common intelce-api intelce-platform_config intelce-clock_control intelce-intel_ce_pm
INTELCE_TSOUT_INSTALL_STAGING = YES

INTELCE_TSOUT_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_TSOUT_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_TSOUT_CONFIGURE_CMDS
   
endef

define INTELCE_TSOUT_BUILD_CMDS
    if [ -d "${INTELCE_TSOUT_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_TSOUT_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_TSOUT_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_TSOUT_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_TSOUT_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_TSOUT_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_TSOUT_BUILD_ENV} ${INTELSDK-BUILD} tsout
endef

define INTELCE_TSOUT_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_TSOUT_DIR}/build_i686/staging_dir) 
endef

define INTELCE_TSOUT_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_TSOUT_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
