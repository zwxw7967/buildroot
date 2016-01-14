INTEL_SDK_MAKE_FLAGS = \
	HOSTCC="$(HOSTCC)" \
	HOSTCFLAGS="$(HOSTCFLAGS)" \
	ARCH="$(KERNEL_ARCH)" \
	CROSS_COMPILE="$(TARGET_CROSS)"
        
INTEL_SDK_MAKE_ENV = \
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
	BUILD_ROOT_DIR="${INTEL_SDK_DIR}"
	
INTEL_SDK_MAKE_OPTS = \
    MAKE_OPTS="\
        CROSS_COMPILE="$(TARGET_CROSS)" \
        V=1 \
        LOUD=1 \
        "
    
INTELSDK-BUILD = ${INTEL_SDK_MAKE_ENV} ${INTEL_SDK_MAKE_OPTS} ${INTEL_SDK_DIR}/buildroot_make.sh

define INTEL_SDK_INSTALL_TO_STAGING
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



define INTEL_SDK_INSTALL_TO_TARGET
    if [ -d "${1}/usr" ] ; then \
        cp -av "${1}/usr" "${TARGET_DIR}/usr"; \
    fi

    if [ -d "${1}/lib" ] ; then \
        cp -av "${1}/lib" "${TARGET_DIR}/lib"; \
    fi

    if [ -d "${1}/etc" ] ; then \
        cp -av "${1}/etc" "${TARGET_DIR}/etc"; \
    fi

    if [ -d "${1}/bin" ] ; then \
        cp -av "${1}/bin" "${TARGET_DIR}/bin"; \
    fi
endef
