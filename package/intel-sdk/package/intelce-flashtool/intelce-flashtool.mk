################################################################################
#
# intelce-flashtool
#
################################################################################
INTELCE_FLASHTOOL_VERSION = ${INTEL_SDK_VERSION}
INTELCE_FLASHTOOL_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_FLASHTOOL_SITE_METHOD = local
INTELCE_FLASHTOOL_LICENSE = PROPRIETARY
INTELCE_FLASHTOOL_REDISTRIBUTE = NO
INTELCE_FLASHTOOL_DEPENDENCIES = intel-sdk linux
INTELCE_FLASHTOOL_INSTALL_STAGING = YES

INTELCE_FLASHTOOL_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_FLASHTOOL_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_FLASHTOOL_CONFIGURE_CMDS
   
endef

define INTELCE_FLASHTOOL_BUILD_CMDS
    if [ -d "${INTELCE_FLASHTOOL_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_FLASHTOOL_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_FLASHTOOL_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_FLASHTOOL_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_FLASHTOOL_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_FLASHTOOL_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_FLASHTOOL_BUILD_ENV} ${INTELSDK-BUILD} flashtool
endef

define INTELCE_FLASHTOOL_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_FLASHTOOL_DIR}/build_i686/staging_dir) 
endef

define INTELCE_FLASHTOOL_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_FLASHTOOL_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
