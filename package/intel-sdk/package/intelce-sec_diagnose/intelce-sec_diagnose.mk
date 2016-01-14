################################################################################
#
# intelce-sec_diagnose
#
################################################################################
INTELCE_SEC_DIAGNOSE_VERSION = ${INTEL_SDK_VERSION}
INTELCE_SEC_DIAGNOSE_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_SEC_DIAGNOSE_SITE_METHOD = local
INTELCE_SEC_DIAGNOSE_LICENSE = PROPRIETARY
INTELCE_SEC_DIAGNOSE_REDISTRIBUTE = NO
INTELCE_SEC_DIAGNOSE_DEPENDENCIES = intel-sdk intelce-osal intelce-pal intelce-flashtool intelce-flash_appdata intelce-sec intelce-hdmi_hdcp
INTELCE_SEC_DIAGNOSE_INSTALL_STAGING = YES

INTELCE_SEC_DIAGNOSE_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_SEC_DIAGNOSE_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_SEC_DIAGNOSE_CONFIGURE_CMDS
   
endef

define INTELCE_SEC_DIAGNOSE_BUILD_CMDS
    if [ -d "${INTELCE_SEC_DIAGNOSE_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_SEC_DIAGNOSE_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_SEC_DIAGNOSE_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_SEC_DIAGNOSE_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_SEC_DIAGNOSE_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_SEC_DIAGNOSE_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_SEC_DIAGNOSE_BUILD_ENV} ${INTELSDK-BUILD} sec_diagnose
endef

define INTELCE_SEC_DIAGNOSE_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_SEC_DIAGNOSE_DIR}/build_i686/staging_dir) 
endef

define INTELCE_SEC_DIAGNOSE_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_SEC_DIAGNOSE_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
