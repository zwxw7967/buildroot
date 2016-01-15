################################################################################
#
# intelce-pic24
#
################################################################################
INTELCE_PIC24_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_PIC24_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_PIC24_SITE_METHOD = local
INTELCE_PIC24_LICENSE = PROPRIETARY
INTELCE_PIC24_REDISTRIBUTE = NO
INTELCE_PIC24_DEPENDENCIES = intelce-sdk
INTELCE_PIC24_INSTALL_STAGING = YES

INTELCE_PIC24_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_PIC24_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_PIC24_CONFIGURE_CMDS
   
endef

define INTELCE_PIC24_BUILD_CMDS
    if [ -d "${INTELCE_PIC24_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_PIC24_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_PIC24_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_PIC24_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_PIC24_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_PIC24_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_PIC24_BUILD_ENV} ${INTELCESDK-BUILD} pic24
endef

define INTELCE_PIC24_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_PIC24_DIR}/build_i686/staging_dir) 
endef

define INTELCE_PIC24_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_PIC24_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
