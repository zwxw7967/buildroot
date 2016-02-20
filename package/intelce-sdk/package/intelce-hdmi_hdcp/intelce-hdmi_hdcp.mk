################################################################################
#
# intelce-hdmi_hdcp
#
################################################################################
INTELCE_HDMI_HDCP_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_HDMI_HDCP_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_HDMI_HDCP_SITE_METHOD = local
INTELCE_HDMI_HDCP_LICENSE = PROPRIETARY
INTELCE_HDMI_HDCP_REDISTRIBUTE = NO
INTELCE_HDMI_HDCP_DEPENDENCIES = intelce-sdk openssl intelce-flashtool intelce-sec intelce-osal intelce-pal intelce-flash_appdata
INTELCE_HDMI_HDCP_INSTALL_STAGING = YES

INTELCE_HDMI_HDCP_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_HDMI_HDCP_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_HDMI_HDCP_CONFIGURE_CMDS
   
endef

define INTELCE_HDMI_HDCP_BUILD_CMDS
    if [ -d "${INTELCE_HDMI_HDCP_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_HDMI_HDCP_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_HDMI_HDCP_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_HDMI_HDCP_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_HDMI_HDCP_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_HDMI_HDCP_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_HDMI_HDCP_BUILD_ENV} ${INTELCESDK-BUILD} hdmi_hdcp
endef

define INTELCE_HDMI_HDCP_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_HDMI_HDCP_DIR}/build_i686/staging_dir) 
	$(INSTALL) -m 644 ${INTELCE_HDMI_HDCP_DIR}/build_i686/staging_dir/lib/libsec_hdcp.so $(STAGING_DIR)/lib/libsec_hdcp.so
endef

define INTELCE_HDMI_HDCP_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_HDMI_HDCP_DIR}/project_build_i686/IntelCE/root)
	$(INSTALL) -m 644 ${INTELCE_HDMI_HDCP_DIR}/build_i686/staging_dir/lib/libsec_hdcp.so $(TARGET_DIR)/lib/libsec_hdcp.so
endef

$(eval $(generic-package))
