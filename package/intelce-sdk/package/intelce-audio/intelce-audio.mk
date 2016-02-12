################################################################################
#
# intelce-audio
#
################################################################################
INTELCE_AUDIO_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_AUDIO_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_AUDIO_SITE_METHOD = local
INTELCE_AUDIO_LICENSE = PROPRIETARY
INTELCE_AUDIO_REDISTRIBUTE = NO
INTELCE_AUDIO_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-htuple intelce-clock intelce-clock_recovery intelce-clock_control intelce-display intelce-avcap intelce-intel_ce_pm
INTELCE_AUDIO_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_AUDIO_DEPENDENCIES +=  intelce-iosf intelce-fw_load intelce-audio_fw_bin
endif

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_AUDIO_DEPENDENCIES += intelce-audio_fw
endif

INTELCE_AUDIO_BUILD_ENV = \
	BUILD_TARGET_DIR=${INTELCE_AUDIO_DIR} \
	BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true

define INTELCE_AUDIO_CONFIGURE_CMDS
endef

define INTELCE_AUDIO_BUILD_CMDS
	if [ -d "${INTELCE_AUDIO_DIR}/build_i686" ]; then \
		 rm -rf "${INTELCE_AUDIO_DIR}/build_i686"; \
	fi
	if [ -d "${INTELCE_AUDIO_DIR}/binaries" ]; then \
		 rm -rf "${INTELCE_AUDIO_DIR}/binaries"; \
	fi
	if [ -d "${INTELCE_AUDIO_DIR}/project_build_i686" ]; then \
		 rm -rf "${INTELCE_AUDIO_DIR}/project_build_i686"; \
	fi
	${INTELCE_AUDIO_BUILD_ENV} ${INTELCESDK-BUILD} audio
endef

define INTELCE_AUDIO_INSTALL_STAGING_CMDS
	$(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_AUDIO_DIR}/build_i686/staging_dir) 
endef

define INTELCE_AUDIO_INSTALL_TARGET_CMDS
	$(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_AUDIO_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
