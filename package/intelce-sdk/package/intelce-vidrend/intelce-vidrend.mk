################################################################################
#
# intelce-vidrend
#
################################################################################
INTELCE_VIDREND_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDREND_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_VIDREND_SITE_METHOD = local
INTELCE_VIDREND_LICENSE = PROPRIETARY
INTELCE_VIDREND_REDISTRIBUTE = NO
INTELCE_VIDREND_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-api intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-platform_config intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-clock intelce-display intelce-SMD_Common intelce-vidpproc
INTELCE_VIDREND_INSTALL_STAGING = YES

INTELCE_VIDREND_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_VIDREND_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_VIDREND_CONFIGURE_CMDS
   
endef

define INTELCE_VIDREND_BUILD_CMDS
    if [ -d "${INTELCE_VIDREND_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_VIDREND_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_VIDREND_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_VIDREND_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_VIDREND_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_VIDREND_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_VIDREND_BUILD_ENV} ${INTELCESDK-BUILD} vidrend
endef

define INTELCE_VIDREND_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_VIDREND_DIR}/build_i686/staging_dir) 
endef

define INTELCE_VIDREND_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_VIDREND_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
