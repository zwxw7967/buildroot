################################################################################
#
# intelce-gsven
#
################################################################################
INTELCE_GSVEN_VERSION = ${INTEL_SDK_VERSION}
INTELCE_GSVEN_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_GSVEN_SITE_METHOD = local
INTELCE_GSVEN_LICENSE = PROPRIETARY
INTELCE_GSVEN_REDISTRIBUTE = NO
INTELCE_GSVEN_DEPENDENCIES = intel-sdk intelce-htuple intelce-auto_eas intelce-osal intelce-pal intelce-platform_config intelce-SMD_Common intelce-sven intelce-LibVNCServer intelce-iosf
INTELCE_GSVEN_INSTALL_STAGING = YES

INTELCE_GSVEN_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_GSVEN_DIR} \
    BUILD_SMD_COMMOM=true 
    
define INTELCE_GSVEN_CONFIGURE_CMDS
   
endef

define INTELCE_GSVEN_BUILD_CMDS
    if [ -d "${INTELCE_GSVEN_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_GSVEN_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_GSVEN_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_GSVEN_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_GSVEN_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_GSVEN_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_GSVEN_BUILD_ENV} ${INTELSDK-BUILD} gsven
endef

define INTELCE_GSVEN_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_GSVEN_DIR}/build_i686/staging_dir) 
endef

define INTELCE_GSVEN_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_GSVEN_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
