#!/bin/bash
set -e -x
# ----------------------------------------------------------------------------
# Set-up exports required by buildroot
# Mostly replacements for toolchain/IntelCE-toolchain/Makefile.in (which isn't included if using external toolchain)
# Fixme: does KERNEL_VER need to be hardcoded? Or could we use module-base.bbclass -> KERNEL_VERSION ?
export BUILD_ROOT="${BUILD_ROOT_DIR}"
export LOGGING_DIR="${BUILD_TARGET_DIR}/log"
export BUILD_DEST="${BUILD_ROOT_DIR}/build_i686/staging_dir"
export TARGETDEST="${BUILD_ROOT}/binaries/IntelCE"
export FSROOT="${BUILD_ROOT}/project_build_i686/IntelCE/root"
export KERNEL_VER="linux-3.12.17"
# If STAGING_KERNEL_BUILDDIR is not defined, then we are building with OE dizzy
# and the kernel build directory is the same as the kernel source directory.
# If STAGING_KERNEL_BUILDDIR is defined, then we are building with OE fido (or
# later) and the kernel build is done outside the kernel source directory.
if [ -z "${STAGING_KERNEL_BUILDDIR}" ]
then
	unset KERNEL_SOURCE_DIR
	export KERNEL_BUILD_DIR="${STAGING_KERNEL_DIR}"
else
	export KERNEL_SOURCE_DIR="${STAGING_KERNEL_DIR}"
	export KERNEL_BUILD_DIR="${STAGING_KERNEL_BUILDDIR}"
fi
# ---------------------------------------------------------------------------
export TARGET_STRIP="true"

export TARGETAR="${TARGET_PREFIX}ar"
export TARGETAS="${TARGET_PREFIX}as ${TARGET_AS_ARCH}"
export TARGETCC="${TARGET_PREFIX}gcc ${TOOLCHAIN_OPTIONS} ${TARGET_CC_ARCH}"
export TARGETCXX="${TARGET_PREFIX}g++ ${TOOLCHAIN_OPTIONS} ${TARGET_CC_ARCH}"
export TARGETGCC="${TARGET_PREFIX}gcc ${TOOLCHAIN_OPTIONS} ${TARGET_CC_ARCH}"
export TARGETGXX="${TARGET_PREFIX}g++ ${TOOLCHAIN_OPTIONS} ${TARGET_CC_ARCH}"
export TARGETLD="${TARGET_PREFIX}ld ${TOOLCHAIN_OPTIONS} ${TARGET_LD_ARCH}"
export TARGETNM="${TARGET_PREFIX}nm"
export TARGETOBJCOPY="${TARGET_PREFIX}objcopy"
export TARGETSTRIP="true"
export TARGETADDR2LINE="${TARGET_PREFIX}addr2line"
export TARGETCPP="${TARGET_PREFIX}gcc -E ${TOOLCHAIN_OPTIONS} ${TARGET_CC_ARCH}"
export TARGETCXXFILT="${TARGET_PREFIX}c++filt"
export TARGETGPROF="${TARGET_PREFIX}gprof"
export TARGETOBJDUMP="${TARGET_PREFIX}objdump"
export TARGETRANLIB="${TARGET_PREFIX}ranlib"
export TARGETREADELF="${TARGET_PREFIX}readelf"
export TARGETSIZE="${TARGET_PREFIX}size"
export TARGETSTRINGS="${TARGET_PREFIX}strings"

export TARGETBISON="false"
export TARGETM4="false"
export TARGETYACC="false"

# ----------------------------------------------------------------------------
export INTELCE_HEADERS="${TARGET_SYSROOT}/usr/include/intelce" 
export INTELCE_USERSPACE_PRIVATE_LIBS="${TARGET_SYSROOT}/usr/lib/intelce"
export INTELCE_KERNELSPACE_PRIVATE_LIBS="${TARGET_SYSROOT}/lib/kernel/intelce"

export INTELCE_FREETYPE2_INCLUDE_PATH="${TARGET_SYSROOT}/usr/include/freetype2"
export INTELCE_OPENGLES_INCLUDE_PATH="${TARGET_SYSROOT}/usr/include"
# ----------------------------------------------------------------------------

# Tweak build to ignore package dependencies (most packages depend on toolchain and/or kernel, which we don't want to build from here)

export INTELCE_FORCE_DISABLE_DEPS="true"
# ----------------------------------------------------------------------------
# Create log dir
# ----------------------------------------------------------------------------
mkdir -p "${BUILD_TARGET_DIR}/log"
# ----------------------------------------------------------------------------

# Prevent extraction of pre-built libs or headers for packages which we can rebuild from source.

# export INTELCE_SKIP_DEV_PACKAGES__8051_SDK="true"
# export INTELCE_SKIP_DEV_PACKAGES__avcap="true"
# export INTELCE_SKIP_DEV_PACKAGES__cosai="true"
# export INTELCE_SKIP_DEV_PACKAGES__devmem="true"
# export INTELCE_SKIP_DEV_PACKAGES__expbus="true"
export INTELCE_SKIP_DEV_PACKAGES__flash_appdata="true"
export INTELCE_SKIP_DEV_PACKAGES__flashtool="true"
# export INTELCE_SKIP_DEV_PACKAGES__fw_load="true"
# export INTELCE_SKIP_DEV_PACKAGES__generic_timer="true"
export INTELCE_SKIP_DEV_PACKAGES__gpio="true"
# export INTELCE_SKIP_DEV_PACKAGES__graphics="true"
# export INTELCE_SKIP_DEV_PACKAGES__graphics_2d="true"
# export INTELCE_SKIP_DEV_PACKAGES__gsven="true"
# export INTELCE_SKIP_DEV_PACKAGES__hdmi_hdcp="true"
export INTELCE_SKIP_DEV_PACKAGES__idl="true"
# export INTELCE_SKIP_DEV_PACKAGES__idtsal="true"
# export INTELCE_SKIP_DEV_PACKAGES__idts_common="true"
export INTELCE_SKIP_DEV_PACKAGES__iosf="true"
# export INTELCE_SKIP_DEV_PACKAGES__keyrefresh="true"
# export INTELCE_SKIP_DEV_PACKAGES__mfhlib="true"
export INTELCE_SKIP_DEV_PACKAGES__mux="true"
# export INTELCE_SKIP_DEV_PACKAGES__nand_config="true"
# export INTELCE_SKIP_DEV_PACKAGES__nsprpub_mw_dep="true"
export INTELCE_SKIP_DEV_PACKAGES__osal="true"
export INTELCE_SKIP_DEV_PACKAGES__pal="true"
export INTELCE_SKIP_DEV_PACKAGES__pic24_uart="true"
export INTELCE_SKIP_DEV_PACKAGES__pic24_uart_drv="true"
export INTELCE_SKIP_DEV_PACKAGES__platform_config="true"
# export INTELCE_SKIP_DEV_PACKAGES__pwm="true"
# export INTELCE_SKIP_DEV_PACKAGES__sec="true"
export INTELCE_SKIP_DEV_PACKAGES__thermal="true"
export INTELCE_SKIP_DEV_PACKAGES__transcoder_common="true"
export INTELCE_SKIP_DEV_PACKAGES__transcoder_device="true"
export INTELCE_SKIP_DEV_PACKAGES__transcoder_pipeline="true"
export INTELCE_SKIP_DEV_PACKAGES__transcoder_server="true"
export INTELCE_SKIP_DEV_PACKAGES__videnc="true"
export INTELCE_SKIP_DEV_PACKAGES__video_ces="true"

MAKEOPTS=${MAKE_OPTS}
# ----------------------------------------------------------------------------
BUILD_TARGET="$1"
# ----------------------------------------------------------------------------
# BUILD_TARGET here is expected to be an Intel SDK build target, ie one of the
# directories under packages (e.g. osal, pal, transcoder_common, viddec_fw, etc)
# and not an OE build target (which all have the prefix "intelce-").
stamp=`date +%Y%M%d_%H%M%S`

echo "${LOGGING_DIR}/${BUILD_TARGET}.${stamp}.log.txt"

if [ "x${BUILD_SMD_COMMOM}" = "xtrue" ]
then
    make ${MAKEOPTS} -C ${BUILD_ROOT} SMD_Common
fi

if [ "x${BUILD_SMD_TOOLS}" = "xtrue" ]
then
   mkdir -p ${BUILD_ROOT_DIR}/build_i686/staging_dir/internal/
   cp -av ${BUILD_ROOT_DIR}/package/smd_tools/smd_tools-None-SRC-36.0.14495.347773.tgz_unpacked/project_build_i686/IntelCE/smd_tools-36.0.14495.347773/autoapi/src/* ${BUILD_ROOT_DIR}/build_i686/staging_dir/internal/
fi

if [ "x${BUILD_IDTS_COMMON}" = "xtrue" ]
then
   	mkdir -p ${BUILD_ROOT_DIR}/build_i686/staging_dir/idts_common
	cp -av ${BUILD_ROOT_DIR}/package/idts_common/idts_common-INTEL-DEV-36.0.14495.347773.tgz_unpacked/build_i686/staging_dir/idts_common/* ${BUILD_ROOT_DIR}/build_i686/staging_dir/idts_common/
fi

if [ "x${MAKE_STAGING_LIB_DIR}" = "xtrue" ]
then
   	mkdir -p ${BUILD_ROOT_DIR}/build_i686/staging_dir/lib
fi


make ${MAKEOPTS} -C ${BUILD_ROOT} ${BUILD_TARGET} &> "${LOGGING_DIR}/${BUILD_TARGET}.${stamp}.log.txt"
# ----------------------------------------------------------------------------
# Move result to component
# ----------------------------------------------------------------------------
if [ -d "${BUILD_ROOT_DIR}/build_i686" ] 
then 
    mv  "${BUILD_ROOT_DIR}/build_i686" "${BUILD_TARGET_DIR}"
fi

if [ -d "${BUILD_ROOT_DIR}/binaries" ] 
then
    mv  "${BUILD_ROOT_DIR}/binaries" "${BUILD_TARGET_DIR}"
fi
    
if [ -d "${BUILD_ROOT_DIR}/project_build_i686" ] 
then 
    mv  "${BUILD_ROOT_DIR}/project_build_i686" "${BUILD_TARGET_DIR}"
fi
    
