################################################################################
#
# intelce-@@PACKAGE_NAME@@
#
################################################################################
INTELCE_@@PACKAGE_VAR@@_VERSION = ${INTEL_SDK_VERSION}
INTELCE_@@PACKAGE_VAR@@_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_@@PACKAGE_VAR@@_SITE_METHOD = local
INTELCE_@@PACKAGE_VAR@@_LICENSE = PROPRIETARY
INTELCE_@@PACKAGE_VAR@@_REDISTRIBUTE = NO
INTELCE_@@PACKAGE_VAR@@_DEPENDENCIES = intel-sdk
INTELCE_@@PACKAGE_VAR@@_INSTALL_STAGING = YES

INTELCE_@@PACKAGE_VAR@@_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_@@PACKAGE_VAR@@_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_@@PACKAGE_VAR@@_CONFIGURE_CMDS
   
endef

define INTELCE_@@PACKAGE_VAR@@_BUILD_CMDS
    if [ -d "${INTELCE_@@PACKAGE_VAR@@_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_@@PACKAGE_VAR@@_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_@@PACKAGE_VAR@@_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_@@PACKAGE_VAR@@_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_@@PACKAGE_VAR@@_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_@@PACKAGE_VAR@@_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_@@PACKAGE_VAR@@_BUILD_ENV} ${INTELSDK-BUILD} @@PACKAGE_NAME@@
endef

define INTELCE_@@PACKAGE_VAR@@_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_@@PACKAGE_VAR@@_DIR}/build_i686/staging_dir) 
endef

define INTELCE_@@PACKAGE_VAR@@_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_@@PACKAGE_VAR@@_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
