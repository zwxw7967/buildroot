################################################################################
#
# intelce-intel_ce_pm
#
################################################################################
INTELCE_INTEL_CE_PM_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_INTEL_CE_PM_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_INTEL_CE_PM_SITE_METHOD = local
INTELCE_INTEL_CE_PM_LICENSE = PROPRIETARY
INTELCE_INTEL_CE_PM_REDISTRIBUTE = NO
INTELCE_INTEL_CE_PM_DEPENDENCIES = intelce-sdk linux intelce-pal intelce-osal intelce-clock_control intelce-system_utils intelce-8051_SDK intelce-iosf
INTELCE_INTEL_CE_PM_INSTALL_STAGING = YES

INTELCE_INTEL_CE_PM_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_INTEL_CE_PM_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_INTEL_CE_PM_CONFIGURE_CMDS
   
endef

define INTELCE_INTEL_CE_PM_BUILD_CMDS
    if [ -d "${INTELCE_INTEL_CE_PM_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_INTEL_CE_PM_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_INTEL_CE_PM_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_INTEL_CE_PM_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_INTEL_CE_PM_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_INTEL_CE_PM_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_INTEL_CE_PM_BUILD_ENV} ${INTELCESDK-BUILD} intel_ce_pm
endef

define INTELCE_INTEL_CE_PM_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_INTEL_CE_PM_DIR}/build_i686/staging_dir) 
endef

define INTELCE_INTEL_CE_PM_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_INTEL_CE_PM_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
