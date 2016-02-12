################################################################################
#
# intelce-idts_common
#
################################################################################
INTELCE_IDTS_COMMON_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IDTS_COMMON_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_IDTS_COMMON_SITE_METHOD = local
INTELCE_IDTS_COMMON_LICENSE = PROPRIETARY
INTELCE_IDTS_COMMON_REDISTRIBUTE = NO
ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_IDTS_COMMON_DEPENDENCIES = intelce-sdk intelce-pal intelce-osal intelce-idl openssl intelce-graphics
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_IDTS_COMMON_DEPENDENCIES = intelce-sdk intelce-pal intelce-osal intelce-idl openssl intelce-idtsal
endif
INTELCE_IDTS_COMMON_INSTALL_STAGING = YES

INTELCE_IDTS_COMMON_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_IDTS_COMMON_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_IDTS_COMMON_CONFIGURE_CMDS
   
endef

define INTELCE_IDTS_COMMON_BUILD_CMDS
    if [ -d "${INTELCE_IDTS_COMMON_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_IDTS_COMMON_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_IDTS_COMMON_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_IDTS_COMMON_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_IDTS_COMMON_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_IDTS_COMMON_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_IDTS_COMMON_BUILD_ENV} ${INTELCESDK-BUILD} idts_common
endef

define INTELCE_IDTS_COMMON_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_IDTS_COMMON_DIR}/build_i686/staging_dir) 
endef

define INTELCE_IDTS_COMMON_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_IDTS_COMMON_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
