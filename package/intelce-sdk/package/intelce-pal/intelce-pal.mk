################################################################################
#
# intelce-pal
#
################################################################################
INTELCE_PAL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_PAL_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_PAL_SITE_METHOD = local
INTELCE_PAL_LICENSE = PROPRIETARY
INTELCE_PAL_REDISTRIBUTE = NO
INTELCE_PAL_DEPENDENCIES = intelce-sdk linux
INTELCE_PAL_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
INTELCE_PAL_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_PAL_DIR} \
    BUILD_SMD_COMMOM=true
    
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
INTELCE_PAL_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_PAL_DIR} \
    BUILD_SMD_COMMOM=false 
endif
    
define INTELCE_PAL_CONFIGURE_CMDS
   
endef

define INTELCE_PAL_BUILD_CMDS
    if [ -d "${INTELCE_PAL_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_PAL_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_PAL_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_PAL_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_PAL_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_PAL_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_PAL_BUILD_ENV} ${INTELCESDK-BUILD} pal
endef

define INTELCE_PAL_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_PAL_DIR}/build_i686/staging_dir) 
endef

define INTELCE_PAL_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_PAL_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
