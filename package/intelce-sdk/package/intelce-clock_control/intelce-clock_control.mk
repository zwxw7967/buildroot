################################################################################
#
# intelce-clock_control
#
################################################################################
INTELCE_CLOCK_CONTROL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_CLOCK_CONTROL_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_CLOCK_CONTROL_SITE_METHOD = local
INTELCE_CLOCK_CONTROL_LICENSE = PROPRIETARY
INTELCE_CLOCK_CONTROL_REDISTRIBUTE = NO
INTELCE_CLOCK_CONTROL_DEPENDENCIES = intelce-sdk intelce-sven linux intelce-idl intelce-osal intelce-pal intelce-platform_config
INTELCE_CLOCK_CONTROL_INSTALL_STAGING = YES

INTELCE_CLOCK_CONTROL_BUILD_ENV = \
	BUILD_TARGET_DIR=${INTELCE_CLOCK_CONTROL_DIR} \
	BUILD_SMD_COMMOM=false

define INTELCE_CLOCK_CONTROL_CONFIGURE_CMDS
endef

define INTELCE_CLOCK_CONTROL_BUILD_CMDS
	if [ -d "${INTELCE_CLOCK_CONTROL_DIR}/build_i686" ]; then \
		 rm -rf "${INTELCE_CLOCK_CONTROL_DIR}/build_i686"; \
	fi
	if [ -d "${INTELCE_CLOCK_CONTROL_DIR}/binaries" ]; then \
		 rm -rf "${INTELCE_CLOCK_CONTROL_DIR}/binaries"; \
	fi
	if [ -d "${INTELCE_CLOCK_CONTROL_DIR}/project_build_i686" ]; then \
		 rm -rf "${INTELCE_CLOCK_CONTROL_DIR}/project_build_i686" ; \
	fi
	${INTELCE_CLOCK_CONTROL_BUILD_ENV} ${INTELCESDK-BUILD} clock_control
endef

define INTELCE_CLOCK_CONTROL_INSTALL_STAGING_CMDS
	$(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_CLOCK_CONTROL_DIR}/build_i686/staging_dir) 
endef

define INTELCE_CLOCK_CONTROL_INSTALL_TARGET_CMDS
	$(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_CLOCK_CONTROL_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
