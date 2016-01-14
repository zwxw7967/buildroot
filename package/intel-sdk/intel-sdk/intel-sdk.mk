################################################################################
#
# Intel sdk target
#
################################################################################
INTEL_SDK_VERSION = eef93375337a2aa2252d2b828d4b2cfa6db6b658
INTEL_SDK_SITE_METHOD = git
INTEL_SDK_SITE = git@github.com:Metrological/intel-sdk.git

define INTEL_SDK_PREPARE_ENVIRONMENT
    mkdir -p ${INTEL_SDK_DIR}/empty
    
    mkdir -p ${STAGING_DIR}/usr/include/intelce
    mkdir -p ${STAGING_DIR}/usr/lib/intelce
    mkdir -p ${STAGING_DIR}/lib/kernel/intelce
    
    cp package/intel-sdk/buildroot_make.sh ${INTEL_SDK_DIR}/.
    cp package/intel-sdk/.config* ${INTEL_SDK_DIR}/.
endef

define INTEL_SDK_CONFIGURE_CMDS
    $(call INTEL_SDK_PREPARE_ENVIRONMENT) 
endef

$(eval $(generic-package))
