################################################################################
#
# Intelce sdk target
#
################################################################################

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_SDK_VERSION = eef93375337a2aa2252d2b828d4b2cfa6db6b658
else ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_SDK_VERSION = 78fc9325b4a3d85eadb450f4bb7b758c4a6be1f4
endif

INTELCE_SDK_SITE_METHOD = git
INTELCE_SDK_SITE = git@github.com:Metrological/intel-sdk.git
INTELCE_SDK_DEPENDENCIES = host-doxygen host-dos2unix

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
