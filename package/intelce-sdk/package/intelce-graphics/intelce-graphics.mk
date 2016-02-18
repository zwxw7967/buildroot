################################################################################
#
# intelce-graphics
#
################################################################################
INTELCE_GRAPHICS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_GRAPHICS_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_GRAPHICS_SITE_METHOD = local
INTELCE_GRAPHICS_LICENSE = PROPRIETARY
INTELCE_GRAPHICS_REDISTRIBUTE = NO
INTELCE_GRAPHICS_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal intelce-display host-bison host-flex 
INTELCE_GRAPHICS_INSTALL_STAGING = YES

INTELCE_GRAPHICS_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_GRAPHICS_DIR} \
    BUILD_SMD_COMMOM=false

INTELCE_GRAPHICS_PROVIDES = libegl libgles
    
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
    
    ${INTELCE_GRAPHICS_BUILD_ENV} ${INTELCESDK-BUILD} graphics
endef

define INTELCE_GRAPHICS_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_GRAPHICS_DIR}/build_i686/staging_dir)
    $(INSTALL) -m 644 package/intelce-sdk/package/intelce-graphics/egl.pc $(STAGING_DIR)/usr/lib/pkgconfig/egl.pc
	$(INSTALL) -m 644 package/intelce-sdk/package/intelce-graphics/glesv2.pc $(STAGING_DIR)/usr/lib/pkgconfig/glesv2.pc
    
endef

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
define INTELCE_GRAPHICS_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_GRAPHICS_DIR}/project_build_i686/IntelCE/root)
endef
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
define INTELCE_GRAPHICS_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_GRAPHICS_DIR}/project_build_i686/IntelCE/root)
    $(INSTALL) -m 750 -D ${INTELCE_GRAPHICS_DIR}/project_build_i686/IntelCE/root/usr/local/graphics-sgx535-release/bin/pvrsrvctl "${TARGET_DIR}/usr/local/graphics-sgx535-release/bin/pvrsrvctl" 
    $(INSTALL) -m 750 -D ${INTELCE_GRAPHICS_DIR}/project_build_i686/IntelCE/root/usr/local/graphics-sgx545-release/bin/pvrsrvctl "${TARGET_DIR}/usr/local/graphics-sgx545-release/bin/pvrsrvctl" 
endef
endif



$(eval $(generic-package))
