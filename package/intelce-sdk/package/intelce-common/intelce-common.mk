################################################################################
#
# intelce-common
#
################################################################################
INTELCE_COMMON_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_COMMON_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_COMMON_SITE_METHOD = local
INTELCE_COMMON_LICENSE = PROPRIETARY
INTELCE_COMMON_REDISTRIBUTE = NO
INTELCE_COMMON_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-clock intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-api intelce-SMD_Common
INTELCE_COMMON_INSTALL_STAGING = YES

INTELCE_COMMON_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_COMMON_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_COMMON_CONFIGURE_CMDS
   
endef

define INTELCE_COMMON_BUILD_CMDS
    if [ -d "${INTELCE_COMMON_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_COMMON_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_COMMON_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_COMMON_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_COMMON_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_COMMON_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_COMMON_BUILD_ENV} ${INTELCESDK-BUILD} common
endef

define INTELCE_COMMON_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_COMMON_DIR}/build_i686/staging_dir) 
endef

define INTELCE_COMMON_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_COMMON_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
