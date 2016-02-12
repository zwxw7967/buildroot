################################################################################
#
# intelce-mfhlib
#
################################################################################
INTELCE_MFHLIB_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_MFHLIB_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_MFHLIB_SITE_METHOD = local
INTELCE_MFHLIB_LICENSE = PROPRIETARY
INTELCE_MFHLIB_REDISTRIBUTE = NO
ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_MFHLIB_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal intelce-nand_config intelce-flashtool openssl
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_MFHLIB_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal intelce-nand_config intelce-flashtool openssl intelce-idtsal
endif
INTELCE_MFHLIB_INSTALL_STAGING = YES

INTELCE_MFHLIB_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_MFHLIB_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_MFHLIB_CONFIGURE_CMDS
   
endef

define INTELCE_MFHLIB_BUILD_CMDS
    if [ -d "${INTELCE_MFHLIB_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_MFHLIB_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_MFHLIB_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_MFHLIB_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_MFHLIB_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_MFHLIB_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_MFHLIB_BUILD_ENV} ${INTELCESDK-BUILD} mfhlib
endef

define INTELCE_MFHLIB_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_MFHLIB_DIR}/build_i686/staging_dir) 
endef

define INTELCE_MFHLIB_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_MFHLIB_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
