################################################################################
#
# intelce-graphics
#
################################################################################
INTELCE_GRAPHICS_VERSION = ${INTEL_SDK_VERSION}
INTELCE_GRAPHICS_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_GRAPHICS_SITE_METHOD = local
INTELCE_GRAPHICS_LICENSE = PROPRIETARY
INTELCE_GRAPHICS_REDISTRIBUTE = NO
INTELCE_GRAPHICS_DEPENDENCIES = intel-sdk linux intelce-osal intelce-pal intelce-display intelce-freedesktop intelce-bison intelce-flex
INTELCE_GRAPHICS_INSTALL_STAGING = YES

INTELCE_GRAPHICS_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_GRAPHICS_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_GRAPHICS_CONFIGURE_CMDS
   
endef

define INTELCE_GRAPHICS_BUILD_CMDS
    if [ -d "${INTELCE_GRAPHICS_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_GRAPHICS_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_GRAPHICS_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_GRAPHICS_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_GRAPHICS_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_GRAPHICS_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_GRAPHICS_BUILD_ENV} ${INTELSDK-BUILD} graphics
endef

define INTELCE_GRAPHICS_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_GRAPHICS_DIR}/build_i686/staging_dir) 
endef

define INTELCE_GRAPHICS_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_GRAPHICS_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
