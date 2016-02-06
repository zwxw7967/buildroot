################################################################################
#
# Intelce sdk target
#
################################################################################
INTELCE_SDK_VERSION = eef93375337a2aa2252d2b828d4b2cfa6db6b658
INTELCE_SDK_SITE_METHOD = git
INTELCE_SDK_SITE = git@github.com:Metrological/intel-sdk.git

define INTELCE_SDK_PREPARE_ENVIRONMENT
	mkdir -p ${INTELCE_SDK_DIR}/empty
	mkdir -p ${STAGING_DIR}/usr/include/intelce
	mkdir -p ${STAGING_DIR}/usr/lib/intelce
	mkdir -p ${STAGING_DIR}/lib/kernel/intelce
	cp package/intelce-sdk/buildroot_make.sh ${INTELCE_SDK_DIR}/.
	cp package/intelce-sdk/.config* ${INTELCE_SDK_DIR}/.
endef

define INTELCE_SDK_CONFIGURE_CMDS
	$(call INTELCE_SDK_PREPARE_ENVIRONMENT)
endef

$(eval $(generic-package))
