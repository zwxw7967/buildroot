################################################################################
#
# intelce-htuple
#
################################################################################
INTELCE_HTUPLE_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_HTUPLE_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_HTUPLE_SITE_METHOD = local
INTELCE_HTUPLE_LICENSE = PROPRIETARY
INTELCE_HTUPLE_REDISTRIBUTE = NO
INTELCE_HTUPLE_DEPENDENCIES = intelce-sdk linux intelce-SMD_Common
INTELCE_HTUPLE_INSTALL_STAGING = YES

INTELCE_HTUPLE_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_HTUPLE_DIR} \
    BUILD_SMD_COMMOM=true 
    
define INTELCE_HTUPLE_CONFIGURE_CMDS
   
endef

define INTELCE_HTUPLE_BUILD_CMDS
    if [ -d "${INTELCE_HTUPLE_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_HTUPLE_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_HTUPLE_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_HTUPLE_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_HTUPLE_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_HTUPLE_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_HTUPLE_BUILD_ENV} ${INTELCESDK-BUILD} htuple
endef

define INTELCE_HTUPLE_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_HTUPLE_DIR}/build_i686/staging_dir) 
endef

define INTELCE_HTUPLE_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_HTUPLE_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
