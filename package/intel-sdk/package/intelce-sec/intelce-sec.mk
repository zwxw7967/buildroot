################################################################################
#
# intelce-sec
#
################################################################################
INTELCE_SEC_VERSION = ${INTEL_SDK_VERSION}
INTELCE_SEC_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_SEC_SITE_METHOD = local
INTELCE_SEC_LICENSE = PROPRIETARY
INTELCE_SEC_REDISTRIBUTE = NO
INTELCE_SEC_DEPENDENCIES = intel-sdk intelce-auto_eas linux intelce-osal intelce-pal intelce-sven intelce-clock_control intelce-system_utils intelce-intel_ce_pm intelce-iosf
INTELCE_SEC_INSTALL_STAGING = YES

INTELCE_SEC_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_SEC_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_SEC_CONFIGURE_CMDS
   
endef

define INTELCE_SEC_BUILD_CMDS
    if [ -d "${INTELCE_SEC_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_SEC_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_SEC_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_SEC_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_SEC_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_SEC_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_SEC_BUILD_ENV} ${INTELSDK-BUILD} sec
endef

define INTELCE_SEC_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_SEC_DIR}/build_i686/staging_dir) 
endef

define INTELCE_SEC_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_SEC_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
