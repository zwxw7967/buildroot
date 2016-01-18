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
      cd ${1} && find include/ -type f -exec $(INSTALL) -m 644 -D {} ${1}/usr/{} \; ; \
    fi

    if [ -d "${1}/usr/include" ] ; then \
      cd ${1}/usr/include && find . -type f -exec $(INSTALL) -m 644 -D {} "${STAGING_DIR}/usr/include/intelce/{}" \; ; \
    fi

    if [ -d "${1}/lib" ] ; then \
      cd ${1}/lib && find . -type f -name "*.a"  -exec $(INSTALL) -m 644 -D {} "${STAGING_DIR}/usr/lib/intelce" \; ; \
      cd ${1}/lib && find . -type f -name "*.so" -exec $(INSTALL) -m 644 -D {} "${STAGING_DIR}/lib" \; ; \
    fi

    if [ -d "${1}/usr/lib" ] ; then \
      cd ${1}/usr/lib && find . -type f -name "*.a"  -exec $(INSTALL) -m 644 -D {} "${STAGING_DIR}/usr/lib/intelce" \; ; \
      cd ${1}/usr/lib && find . -type f -name "*.so" -exec $(INSTALL) -m 644 -D {} "${STAGING_DIR}/lib" \; ; \
    fi

    if [ -d "${1}/lib/modules" ] ; then \
      cd ${1}/lib/modules && find . -type f -name "*.a" -exec $(INSTALL) -m 644 -D {} "${STAGING_DIR}/lib/kernel/intelce" \;  ; \
    fi
endef

define INTELCE_SDK_INSTALL_TO_TARGET
      if [ -d "${1}/usr" ] ; then \
        cd ${1} && find usr -type f -exec $(INSTALL) -m 644 -D {} "${TARGET_DIR}/{}" \; ; \
      fi
      if [ -d "${1}/usr/dtsbin" ] ; then \
        cd ${1} && find usr/dtsbin -type f -exec $(INSTALL) -m 750 -D {} "${TARGET_DIR}/{}" \; ; \
      fi
      if [ -d "${1}/lib" ] ; then \
        cd ${1} && find lib -type f -exec $(INSTALL) -m 644 -D {} "${TARGET_DIR}/{}" \;  ! -name "*.a" ; \
      fi
      if [ -d "${1}/etc" ] ; then \
        cd ${1} && find etc -type f -exec $(INSTALL) -m 644 -D {} "${TARGET_DIR}/{}" \; ; \
      fi
      if [ -d "${1}/etc/init.d" ] ; then \
        cd ${1} && find etc/init.d -type f -exec $(INSTALL) -m 750 -D {} "${TARGET_DIR}/{}" \; ; \
      fi
      if [ -d "${1}/bin" ] ; then \
        cd ${1} && find bin -type f -exec $(INSTALL) -m 750 -D {} "${TARGET_DIR}/{}" \; ; \
      fi
    
endef
