INTELCE_SDK_MAKE_FLAGS = \
	HOSTCC="$(HOSTCC)" \
	HOSTCFLAGS="$(HOSTCFLAGS)" \
	ARCH="$(KERNEL_ARCH)" \
	CROSS_COMPILE="$(TARGET_CROSS)"
        
INTELCE_SDK_MAKE_ENV = \
	TARGET_SYSROOT="$(STAGING_DIR)" \
	TOOLCHAIN_OPTIONS=" --sysroot=${STAGING_DIR}" \
	TARGET_AS_ARCH=" " \
	TARGET_CC_ARCH=" -m32 -march=core2 -mtune=core2 -msse3 -mfpmath=sse" \
	TARGET_LD_ARCH=" " \
	TARGET_PREFIX="$(TARGET_CROSS)" \
	STAGING_KERNEL_DIR="${LINUX_DIR}" \
	STAGING_KERNEL_BUILDDIR="" \
	DEFAULT_BUILD_TARGET="configure" \
	DEPENDS_ON_IDTS_COMMON="false" \
	DEPENDS_ON_SMD_TOOLS="false" \
	BUILD_ROOT_DIR="${INTELCE_SDK_DIR}"
	
INTELCE_SDK_MAKE_OPTS = \
    MAKE_OPTS="\
        CROSS_COMPILE="$(TARGET_CROSS)" \
        V=1 \
        "
    
INTELCESDK-BUILD = ${INTELCE_SDK_MAKE_ENV} ${INTELCE_SDK_MAKE_OPTS} ${INTELCE_SDK_DIR}/buildroot_make.sh

define INTELCE_SDK_INSTALL_TO_STAGING
    if [ -d "${1}/include" ] ; then \
      cd ${1} && find include/ -type d -exec mkdir -p ${1}/usr/{} \; ; \
      cd ${1} && find include/ -type f -exec cp -av {} ${1}/usr/{} \; ; \
    fi

    if [ -d "${1}/usr/include" ] ; then \
      cd ${1}/usr/include && find . -type d -exec mkdir -p "${STAGING_DIR}/usr/include/intelce/{}" \; ; \
      cd ${1}/usr/include && find . -type f -exec cp -av {} "${STAGING_DIR}/usr/include/intelce/{}" \; ; \
    fi

    if [ -d "${1}/lib" ] ; then \
      cd ${1}/lib && find . -type f -name "*.a"  -exec cp -av {} "${STAGING_DIR}/usr/lib/intelce" \; ; \
      cd ${1}/lib && find . -type f -name "*.so" -exec cp -av {} "${STAGING_DIR}/lib" \; ; \
    fi

    if [ -d "${1}/usr/lib" ] ; then \
      cd ${1}/usr/lib && find . -type f -name "*.a"  -exec cp -av {} "${STAGING_DIR}/usr/lib/intelce" \; ; \
      cd ${1}/usr/lib && find . -type f -name "*.so" -exec cp -av {} "${STAGING_DIR}/lib" \; ; \
    fi

    if [ -d "${1}/lib/modules" ] ; then \
      cd ${1}/lib/modules && find . -type f -name "*.a" -exec cp -av {} "${STAGING_DIR}/lib/kernel/intelce" \;  ; \
    fi
endef



define INTELCE_SDK_INSTALL_TO_TARGET
    if [ -d "${1}/usr" ] ; then \
        cd ${1}/usr && find . -type d -exec mkdir -p ${TARGET_DIR}/usr/{} \; ; \
        cd ${1}/usr && find . -type f -exec cp -av {} "${TARGET_DIR}/usr/{}" \; ; \
    fi

    if [ -d "${1}/lib" ] ; then \
        cd ${1}/lib && find . -type d -exec mkdir -p ${TARGET_DIR}/lib/{} \; ; \
        cd ${1}/lib && find . -type f -exec cp -av {} "${TARGET_DIR}/lib/{}" \; ! -name "*.a"; \
    fi

    if [ -d "${1}/etc" ] ; then \
        cd ${1}/etc && find . -type d -exec mkdir -p ${TARGET_DIR}/etc/{} \; ; \
        cd ${1}/etc && find . -type f -exec cp -av {} "${TARGET_DIR}/etc/{}" \; ; \
    fi

    if [ -d "${1}/bin" ] ; then \
        cd ${1}/bin && find . -type d -exec mkdir -p ${TARGET_DIR}/bin/{} \; ; \
        cd ${1}/bin && find . -type f -exec cp  -av {} "${TARGET_DIR}/bin/{}" \; ; \
    fi
endef
