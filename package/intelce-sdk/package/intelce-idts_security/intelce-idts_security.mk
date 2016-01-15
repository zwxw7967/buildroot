################################################################################
#
# intelce-idts_security
#
################################################################################
INTELCE_IDTS_SECURITY_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IDTS_SECURITY_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_IDTS_SECURITY_SITE_METHOD = local
INTELCE_IDTS_SECURITY_LICENSE = PROPRIETARY
INTELCE_IDTS_SECURITY_REDISTRIBUTE = NO
INTELCE_IDTS_SECURITY_DEPENDENCIES = intelce-sdk intelce-pal intelce-osal intelce-nand_config intelce-flash_appdata intelce-sec openssl intelce-idts_common intelce-idtsal
INTELCE_IDTS_SECURITY_INSTALL_STAGING = YES

INTELCE_IDTS_SECURITY_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_IDTS_SECURITY_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_IDTS_SECURITY_CONFIGURE_CMDS
   
endef

define INTELCE_IDTS_SECURITY_BUILD_CMDS
    if [ -d "${INTELCE_IDTS_SECURITY_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_IDTS_SECURITY_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_IDTS_SECURITY_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_IDTS_SECURITY_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_IDTS_SECURITY_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_IDTS_SECURITY_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_IDTS_SECURITY_BUILD_ENV} ${INTELCESDK-BUILD} idts_security
endef

define INTELCE_IDTS_SECURITY_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_IDTS_SECURITY_DIR}/build_i686/staging_dir) 
endef

define INTELCE_IDTS_SECURITY_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_IDTS_SECURITY_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
