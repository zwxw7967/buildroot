################################################################################
#
# intelce-pic24_uart
#
################################################################################
INTELCE_PIC24_UART_VERSION = ${INTEL_SDK_VERSION}
INTELCE_PIC24_UART_SITE = ${INTEL_SDK_DIR}/empty
INTELCE_PIC24_UART_SITE_METHOD = local
INTELCE_PIC24_UART_LICENSE = PROPRIETARY
INTELCE_PIC24_UART_REDISTRIBUTE = NO
INTELCE_PIC24_UART_DEPENDENCIES = intel-sdk intelce-osal intelce-idts_common
INTELCE_PIC24_UART_INSTALL_STAGING = YES

INTELCE_PIC24_UART_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_PIC24_UART_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_PIC24_UART_CONFIGURE_CMDS
   
endef

define INTELCE_PIC24_UART_BUILD_CMDS
    if [ -d "${INTELCE_PIC24_UART_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_PIC24_UART_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_PIC24_UART_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_PIC24_UART_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_PIC24_UART_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_PIC24_UART_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_PIC24_UART_BUILD_ENV} ${INTELSDK-BUILD} pic24_uart
endef

define INTELCE_PIC24_UART_INSTALL_STAGING_CMDS
    $(call INTEL_SDK_INSTALL_TO_STAGING,${INTELCE_PIC24_UART_DIR}/build_i686/staging_dir) 
endef

define INTELCE_PIC24_UART_INSTALL_TARGET_CMDS
    $(call INTEL_SDK_INSTALL_TO_TARGET,${INTELCE_PIC24_UART_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
