################################################################################
#
# intelce-osal
#
################################################################################
INTELCE_OSAL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_OSAL_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_OSAL_SITE_METHOD = local
INTELCE_OSAL_LICENSE = PROPRIETARY
INTELCE_OSAL_REDISTRIBUTE = NO
INTELCE_OSAL_DEPENDENCIES = intelce-sdk linux
INTELCE_OSAL_INSTALL_STAGING = YES
INTELCE_OSAL_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_OSAL_DIR}
    
ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
INTELCE_OSAL_DEPENDENCIES += intelce-SMD_Common
endif

define INTELCE_OSAL_BUILD_CMDS
    if [ -d "${INTELCE_OSAL_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_OSAL_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_OSAL_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_OSAL_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_OSAL_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_OSAL_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_OSAL_BUILD_ENV} ${INTELCESDK-BUILD} osal
endef

define INTELCE_OSAL_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_OSAL_DIR}/build_i686/staging_dir) 
endef

define INTELCE_OSAL_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_OSAL_DIR}/project_build_i686/IntelCE/root)
    
	if [ "x$(BR2_PACKAGE_INTELCE_SDK_V36)" = "xy" ] ; then \
		$(INSTALL) -m 750 -D ${INTELCE_OSAL_DIR}/project_build_i686/IntelCE/root/lib/udev/osal_fw_hotplug.sh "${TARGET_DIR}/lib/udev/osal_fw_hotplug.sh" ; \
	fi
endef

$(eval $(generic-package))
