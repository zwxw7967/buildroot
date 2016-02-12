################################################################################
#
# intelce-flash_appdata
#
################################################################################
INTELCE_FLASH_APPDATA_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_FLASH_APPDATA_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_FLASH_APPDATA_SITE_METHOD = local
INTELCE_FLASH_APPDATA_LICENSE = PROPRIETARY
INTELCE_FLASH_APPDATA_REDISTRIBUTE = NO
INTELCE_FLASH_APPDATA_DEPENDENCIES = intelce-sdk intelce-flashtool intelce-nand_config intelce-osal intelce-pal intelce-mfhlib

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_FLASH_APPDATA_DEPENDENCIES +=  intelce-idtsal
endif

INTELCE_FLASH_APPDATA_INSTALL_STAGING = YES

INTELCE_FLASH_APPDATA_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_FLASH_APPDATA_DIR} \
    BUILD_SMD_COMMOM=false 

define INTELCE_FLASH_APPDATA_BUILD_CMDS
    if [ -d "${INTELCE_FLASH_APPDATA_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_FLASH_APPDATA_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_FLASH_APPDATA_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_FLASH_APPDATA_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_FLASH_APPDATA_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_FLASH_APPDATA_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_FLASH_APPDATA_BUILD_ENV} ${INTELCESDK-BUILD} flash_appdata
endef

define INTELCE_FLASH_APPDATA_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_FLASH_APPDATA_DIR}/build_i686/staging_dir) 
endef

define INTELCE_FLASH_APPDATA_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_FLASH_APPDATA_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
