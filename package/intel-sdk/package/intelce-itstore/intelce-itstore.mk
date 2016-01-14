################################################################################
#
# intelce-itstore
#
################################################################################
INTELCE_ITSTORE_VERSION = ${INTEL_SDK_VERSION}
INTELCE_ITSTORE_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_ITSTORE_SITE_METHOD = local
INTELCE_ITSTORE_LICENSE = PROPRIETARY
INTELCE_ITSTORE_REDISTRIBUTE = NO
INTELCE_ITSTORE_DEPENDENCIES = intel-sdk intelce-sec intelce-osal
INTELCE_ITSTORE_INSTALL_STAGING = YES

INTELCE_ITSTORE_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_ITSTORE_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_ITSTORE_CONFIGURE_CMDS
   
endef

define INTELCE_ITSTORE_BUILD_CMDS
    if [ -d "${INTELCE_ITSTORE_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_ITSTORE_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_ITSTORE_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_ITSTORE_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_ITSTORE_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_ITSTORE_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_ITSTORE_BUILD_ENV} ${INTELSDK-BUILD} itstore
endef

define INTELCE_ITSTORE_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_ITSTORE_DIR}/build_i686/staging_dir) 
endef

define INTELCE_ITSTORE_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_ITSTORE_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
