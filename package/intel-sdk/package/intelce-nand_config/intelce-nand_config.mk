################################################################################
#
# intelce-nand_config
#
################################################################################
INTELCE_NAND_CONFIG_VERSION = ${INTEL_SDK_VERSION}
INTELCE_NAND_CONFIG_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_NAND_CONFIG_SITE_METHOD = local
INTELCE_NAND_CONFIG_LICENSE = PROPRIETARY
INTELCE_NAND_CONFIG_REDISTRIBUTE = NO
INTELCE_NAND_CONFIG_DEPENDENCIES = intel-sdk linux intelce-osal
INTELCE_NAND_CONFIG_INSTALL_STAGING = YES

INTELCE_NAND_CONFIG_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_NAND_CONFIG_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_NAND_CONFIG_CONFIGURE_CMDS
   
endef

define INTELCE_NAND_CONFIG_BUILD_CMDS
    if [ -d "${INTELCE_NAND_CONFIG_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_NAND_CONFIG_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_NAND_CONFIG_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_NAND_CONFIG_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_NAND_CONFIG_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_NAND_CONFIG_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_NAND_CONFIG_BUILD_ENV} ${INTELSDK-BUILD} nand_config
endef

define INTELCE_NAND_CONFIG_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_NAND_CONFIG_DIR}/build_i686/staging_dir) 
endef

define INTELCE_NAND_CONFIG_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_NAND_CONFIG_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
