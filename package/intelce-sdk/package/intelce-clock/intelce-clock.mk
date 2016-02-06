################################################################################
#
# intelce-clock
#
################################################################################
INTELCE_CLOCK_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_CLOCK_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_CLOCK_SITE_METHOD = local
INTELCE_CLOCK_LICENSE = PROPRIETARY
INTELCE_CLOCK_REDISTRIBUTE = NO
INTELCE_CLOCK_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-clock_control intelce-iosf
INTELCE_CLOCK_INSTALL_STAGING = YES

INTELCE_CLOCK_BUILD_ENV = \
	BUILD_TARGET_DIR=${INTELCE_CLOCK_DIR} \
	BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true

define INTELCE_CLOCK_CONFIGURE_CMDS
endef

define INTELCE_CLOCK_BUILD_CMDS
	if [ -d "${INTELCE_CLOCK_DIR}/build_i686" ]; then \
		 rm -rf "${INTELCE_CLOCK_DIR}/build_i686"; \
	fi
	if [ -d "${INTELCE_CLOCK_DIR}/binaries" ]; then \
		 rm -rf "${INTELCE_CLOCK_DIR}/binaries"; \
	fi
	if [ -d "${INTELCE_CLOCK_DIR}/project_build_i686" ]; then \
		 rm -rf "${INTELCE_CLOCK_DIR}/project_build_i686"; \
	fi
	${INTELCE_CLOCK_BUILD_ENV} ${INTELCESDK-BUILD} clock
endef

define INTELCE_CLOCK_INSTALL_STAGING_CMDS
	$(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_CLOCK_DIR}/build_i686/staging_dir) 
endef

define INTELCE_CLOCK_INSTALL_TARGET_CMDS
	$(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_CLOCK_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
