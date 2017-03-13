################################################################################
#
# WPEWebKit
#
################################################################################

WPEWEBKIT_VERSION = 3ba32633268e76631849564c5eb576aa007937a0
WPEWEBKIT_SITE = $(call github,WebPlatformForEmbedded,WPEWebKit,$(WPEWEBKIT_VERSION))

WPEWEBKIT_INSTALL_STAGING = YES

WPEWEBKIT_BUILD_WEBKIT=y
WPEWEBKIT_BUILD_JSC=n
WPEWEBKIT_USE_PORT=WPE
ifeq ($(BR2_PACKAGE_WPEWEBKIT_JSC),y)
WPEWEBKIT_BUILD_JSC=y
ifeq ($(BR2_PACKAGE_WPEWEBKIT_ONLY_JSC),y)
WPEWEBKIT_BUILD_WEBKIT=n
WPEWEBKIT_USE_PORT=JSCOnly
endif
endif

WPEWEBKIT_DEPENDENCIES = host-bison host-cmake host-flex host-gperf host-ruby icu pcre

ifeq ($(WPEWEBKIT_BUILD_WEBKIT),y)
WPEWEBKIT_DEPENDENCIES += wpebackend libgcrypt libgles libegl cairo freetype fontconfig \
	harfbuzz libxml2 libxslt sqlite libsoup jpeg libpng
endif

WPEWEBKIT_EXTRA_FLAGS = -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

ifeq ($(BR2_PACKAGE_NINJA),y)
WPEWEBKIT_DEPENDENCIES += host-ninja
WPEWEBKIT_EXTRA_FLAGS += \
	-G Ninja
ifeq ($(VERBOSE),1)
WPEWEBKIT_EXTRA_OPTIONS += -v
endif
endif

ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
WPEWEBKIT_EXTRA_FLAGS += \
	-D__UCLIBC__=ON
endif

ifeq ($(BR2_PACKAGE_LIBINPUT),y)
WPEWEBKIT_DEPENDENCIES += libinput
endif

ifeq ($(WPEWEBKIT_BUILD_WEBKIT),y)
WPEWEBKIT_FLAGS = \
	-DENABLE_ACCELERATED_2D_CANVAS=ON \
	-DENABLE_GEOLOCATION=ON \
	-DENABLE_DEVICE_ORIENTATION=ON \
	-DENABLE_GAMEPAD=ON \
	-DENABLE_SUBTLE_CRYPTO=ON \
	-DENABLE_FULLSCREEN_API=ON \
	-DENABLE_NOTIFICATIONS=ON \
	-DENABLE_DATABASE_PROCESS=ON \
	-DENABLE_INDEXED_DATABASE=ON \
	-DENABLE_FETCH_API=ON

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
WPEWEBKIT_FLAGS += -DENABLE_SAMPLING_PROFILER=OFF
else
WPEWEBKIT_FLAGS += -DENABLE_SAMPLING_PROFILER=ON
endif

ifeq ($(BR2_PACKAGE_WEBP),y)
WPEWEBKIT_DEPENDENCIES += webp
endif

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON),y)
WPEWEBKIT_DEPENDENCIES += libxkbcommon xkeyboard-config
else
WPEWEBKIT_FLAGS += -DUSE_KEY_INPUT_HANDLING_LINUX_INPUT=ON
endif

ifeq ($(BR2_PACKAGE_GLUELOGIC_VIRTUAL_KEYBOARD),y)
WPEWEBKIT_DEPENDENCIES += gluelogic 
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_VIRTUAL_KEYBOARD=ON
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
ifeq ($(BR2_PACKAGE_WAYLAND),y)
WPEWEBKIT_DEPENDENCIES += wayland
ifeq ($(BR2_PACKAGE_WESTEROS),y)
WPEWEBKIT_FLAGS +=-DUSE_WPEWEBKIT_BACKEND_WESTEROS=ON -DUSE_KEY_INPUT_HANDLING_LINUX_INPUT=OFF -DUSE_HOLE_PUNCH_GSTREAMER=OFF -DUSE_WESTEROS_SINK=OFF
WPEWEBKIT_DEPENDENCIES += westeros libxkbcommon
else
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_BACKEND_WAYLAND=ON -DUSE_WPEWEBKIT_BUFFER_MANAGEMENT_BCM_RPI=ON
endif
else
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_BACKEND_BCM_RPI=ON
endif
else ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
WPEWEBKIT_EXTRA_CFLAGS += -DBROADCOM_PLATFORM
ifeq ($(BR2_PACKAGE_BCM_WESTON),y)
WPEWEBKIT_DEPENDENCIES += bcm-weston
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_BACKEND_BCM_NEXUS_WAYLAND=ON
else
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_BACKEND_BCM_NEXUS=ON
endif
else
ifeq ($(BR2_PACKAGE_WAYLAND),y)
WPEWEBKIT_DEPENDENCIES += wayland
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_BACKEND_WAYLAND=ON
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_BUFFER_MANAGEMENT_GBM=ON
endif
ifeq ($(BR2_PACKAGE_LIBDRM)$(BR2_PACKAGE_INTELCE_SDK),yn)
WPEWEBKIT_DEPENDENCIES += libdrm
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_BACKEND_DRM=ON
ifeq ($(BR2_PACKAGE_LIBDRM_TEGRA),y)
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_BACKEND_DRM_TEGRA=ON
endif
endif
ifeq ($(BR2_PACKAGE_XLIB_LIBX11),)
WPEWEBKIT_EXTRA_CFLAGS += -DMESA_EGL_NO_X11_HEADERS
endif
endif
ifeq ($(BR2_PACKAGE_HORIZON_SDK),y)
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_BACKEND_INTEL_CE=ON
endif
ifeq ($(BR2_PACKAGE_INTELCE_SDK),y)
WPEWEBKIT_FLAGS += -DUSE_WPEWEBKIT_BACKEND_INTEL_CE=ON
endif
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_LOGGING),y)
WPEWEBKIT_EXTRA_CFLAGS += -DLOG_DISABLED=0
endif

ifeq ($(BR2_ENABLE_DEBUG),y)
WPEWEBKIT_BUILD_TYPE = Debug
WPEWEBKIT_EXTRA_FLAGS += \
	-DCMAKE_C_FLAGS_DEBUG="-O0 -g -Wno-cast-align $(WPEWEBKIT_EXTRA_CFLAGS)" \
	-DCMAKE_CXX_FLAGS_DEBUG="-O0 -g -Wno-cast-align $(WPEWEBKIT_EXTRA_CFLAGS)"
ifeq ($or $(BR2_BINUTILS_VERSION_2_25_X),$(BR2_BINUTILS_VERSION_2_26_X),y)
WPEWEBKIT_EXTRA_FLAGS += \
	-DDEBUG_FISSION=TRUE
endif
else
WPEWEBKIT_BUILD_TYPE = Release
ifeq ($(BR2_PACKAGE_WPEWEBKIT_DEBUG_SYMBOLS),y)
WPEWEBKIT_EXTRA_FLAGS += \
	-DCMAKE_C_FLAGS_RELEASE="-O2 -g -DNDEBUG -Wno-cast-align $(WPEWEBKIT_EXTRA_CFLAGS)" \
	-DCMAKE_CXX_FLAGS_RELEASE="-O2 -g -DNDEBUG -Wno-cast-align $(WPEWEBKIT_EXTRA_CFLAGS)"
else
WPEWEBKIT_EXTRA_FLAGS += \
	-DCMAKE_C_FLAGS_RELEASE="-O2 -DNDEBUG -Wno-cast-align $(WPEWEBKIT_EXTRA_CFLAGS)" \
	-DCMAKE_CXX_FLAGS_RELEASE="-O2 -DNDEBUG -Wno-cast-align $(WPEWEBKIT_EXTRA_CFLAGS)"
endif
endif

ifeq ($(WPEWEBKIT_BUILD_WEBKIT),y)

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_NATIVE_VIDEO),y)
WPEWEBKIT_FLAGS += -DENABLE_NATIVE_VIDEO=ON
else
WPEWEBKIT_FLAGS += -DENABLE_NATIVE_VIDEO=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_TEXT_SINK),y)
WPEWEBKIT_FLAGS += -DENABLE_TEXT_SINK=ON
else
WPEWEBKIT_FLAGS += -DENABLE_TEXT_SINK=OFF
endif

ifeq ($(BR2_PACKAGE_GSTREAMER1),y)
WPEWEBKIT_DEPENDENCIES += gstreamer1 gst1-plugins-base gst1-plugins-good gst1-plugins-bad
WPEWEBKIT_FLAGS += \
	-DENABLE_VIDEO=ON \
	-DENABLE_VIDEO_TRACK=ON
else
WPEWEBKIT_FLAGS += \
	-DENABLE_VIDEO=OFF \
	-DENABLE_VIDEO_TRACK=OFF
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_DORNE),y)
WPEWEBKIT_FLAGS += -DENABLE_WEB_AUDIO=OFF
else
ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_WEB_AUDIO),y)
WPEWEBKIT_FLAGS += -DENABLE_WEB_AUDIO=ON
else
WPEWEBKIT_FLAGS += -DENABLE_WEB_AUDIO=OFF
endif
endif
ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_TV_CONTROL), y)
WPEWEBKIT_FLAGS += -DENABLE_TV_CONTROL=ON
ifeq ($(BR2_PACKAGE_DVB_APPS),y)
define WPE_POST_TARGET_INITD
    $(INSTALL) -D -m 0755 package/wpe/S90Playback $(TARGET_DIR)/etc/init.d
endef
WPEWEBKIT_POST_INSTALL_TARGET_HOOKS += WPE_POST_TARGET_INITD
WPEWEBKIT_FLAGS +=-DUSE_WPE_TVCONTROL_BACKEND_LINUX_DVB=ON
WPEWEBKIT_DEPENDENCIES += dvb-apps
endif
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_GOOD_PLUGIN_ISOMP4),y)
WPEWEBKIT_FLAGS += -DENABLE_MEDIA_SOURCE=ON
else
WPEWEBKIT_FLAGS += -DENABLE_MEDIA_SOURCE=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_ENCRYPTED_MEDIA_V1),y)
WPEWEBKIT_FLAGS += -DENABLE_LEGACY_ENCRYPTED_MEDIA_V1=ON
endif
ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_ENCRYPTED_MEDIA_V2),y)
WPEWEBKIT_FLAGS += -DENABLE_LEGACY_ENCRYPTED_MEDIA=ON
endif
ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_ENCRYPTED_MEDIA_V3),y)
WPEWEBKIT_FLAGS += -DENABLE_ENCRYPTED_MEDIA=ON
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_PLAYREADY),y)
WPEWEBKIT_DEPENDENCIES += playready
WPEWEBKIT_FLAGS += -DENABLE_PLAYREADY=ON
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_OPENCDM),y)
WPEWEBKIT_DEPENDENCIES += opencdm
WPEWEBKIT_FLAGS += -DENABLE_OCDM=ON
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ENABLE_MEDIA_STREAM),y)
WPEWEBKIT_DEPENDENCIES += openwebrtc
WPEWEBKIT_FLAGS += -DENABLE_MEDIA_STREAM=ON
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_GSTREAMER_GL),y)
WPEWEBKIT_FLAGS += -DUSE_GSTREAMER_GL=ON
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_GSTREAMER_WEBKIT_HTTP_SRC),y)
WPEWEBKIT_FLAGS += -DUSE_GSTREAMER_WEBKIT_HTTP_SRC=ON
else
WPEWEBKIT_FLAGS += -DUSE_GSTREAMER_WEBKIT_HTTP_SRC=OFF
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_FUSION_API),y)
WPEWEBKIT_FLAGS += -DUSE_FUSION_SINK=ON
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_PUNCH_HOLE_GSTREAMER),y)
WPEWEBKIT_FLAGS += -DUSE_HOLE_PUNCH_GSTREAMER=ON
else ifeq ($(BR2_PACKAGE_WPEWEBKIT_USE_PUNCH_HOLE_EXTERNAL),y)
WPEWEBKIT_FLAGS += -DUSE_HOLE_PUNCH_EXTERNAL=ON
endif

endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_ONLY_JSC), y)
WPEWEBKIT_FLAGS += -DENABLE_STATIC_JSC=ON
endif

WPEWEBKIT_CONF_OPTS = \
	-DPORT=$(WPEWEBKIT_USE_PORT) \
	-DCMAKE_BUILD_TYPE=$(WPEWEBKIT_BUILD_TYPE) \
	$(WPEWEBKIT_EXTRA_FLAGS) \
	$(WPEWEBKIT_FLAGS)

WPEWEBKIT_BUILDDIR = $(@D)/build-$(WPEWEBKIT_BUILD_TYPE)

ifeq ($(BR2_PACKAGE_NINJA),y)

WPEWEBKIT_BUILD_TARGETS=
ifeq ($(WPEWEBKIT_BUILD_JSC),y)
WPEWEBKIT_BUILD_TARGETS += jsc
endif
ifeq ($(WPEWEBKIT_BUILD_WEBKIT),y)
WPEWEBKIT_BUILD_TARGETS += libWPEWebKit.so libWPEWebInspectorResources.so \
	WPE{Database,Network,Web}Process libWPEBackend-rdk.so

endif

define WPEWEBKIT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/ninja -C $(WPEWEBKIT_BUILDDIR) $(WPEWEBKIT_EXTRA_OPTIONS) $(WPEWEBKIT_BUILD_TARGETS)
endef

ifeq ($(WPEWEBKIT_BUILD_JSC),y)
define WPEWEBKIT_INSTALL_STAGING_CMDS_JSC
	pushd $(WPEWEBKIT_BUILDDIR) && \
	cp bin/jsc $(STAGING_DIR)/usr/bin/ && \
	popd > /dev/null
endef
else
WPEWEBKIT_INSTALL_STAGING_CMDS_JSC = true
endif

ifeq ($(WPEWEBKIT_BUILD_WEBKIT),y)
define WPEWEBKIT_INSTALL_STAGING_CMDS_WEBKIT
	cp $(WPEWEBKIT_BUILDDIR)/bin/WPE{Database,Network,Web}Process $(STAGING_DIR)/usr/bin/ && \
	cp -d $(WPEWEBKIT_BUILDDIR)/lib/libWPE* $(STAGING_DIR)/usr/lib/ && \
	DESTDIR=$(STAGING_DIR) $(HOST_DIR)/usr/bin/cmake -DCOMPONENT=Development -P $(WPEWEBKIT_BUILDDIR)/Source/JavaScriptCore/cmake_install.cmake > /dev/null && \
	DESTDIR=$(STAGING_DIR) $(HOST_DIR)/usr/bin/cmake -DCOMPONENT=Development -P $(WPEWEBKIT_BUILDDIR)/Source/WebKit2/cmake_install.cmake > /dev/null
endef
else
WPEWEBKIT_INSTALL_STAGING_CMDS_WEBKIT = true
endif

ifeq ($(BR2_PACKAGE_WPEWEBKIT_SELFCOMPRESS),y)
WPEWEBKIT_DEPENDENCIES += host-upx
define SELFCOMPRESSCMD
	$(HOST_DIR)/usr/bin/upx
endef
else
define SELFCOMPRESSCMD
	true
endef
endif

define WPEWEBKIT_INSTALL_STAGING_CMDS
	($(WPEWEBKIT_INSTALL_STAGING_CMDS_JSC) && \
	$(WPEWEBKIT_INSTALL_STAGING_CMDS_WEBKIT))
endef

ifeq ($(WPEWEBKIT_BUILD_JSC),y)
define WPEWEBKIT_INSTALL_TARGET_CMDS_JSC
	cp $(WPEWEBKIT_BUILDDIR)/bin/jsc $(TARGET_DIR)/usr/bin/ && \
	$(STRIPCMD) $(TARGET_DIR)/usr/bin/jsc
endef
else
WPEWEBKIT_INSTALL_TARGET_CMDS_JSC = true
endif

ifeq ($(WPEWEBKIT_BUILD_WEBKIT),y)
define WPEWEBKIT_INSTALL_TARGET_CMDS_WEBKIT
	cp $(WPEWEBKIT_BUILDDIR)/bin/WPE{Database,Network,Web}Process $(TARGET_DIR)/usr/bin/ && \
	cp -d $(WPEWEBKIT_BUILDDIR)/lib/libWPE* $(TARGET_DIR)/usr/lib/ && \
	$(STRIPCMD) $(TARGET_DIR)/usr/lib/libWPEWebKit.so.0.0.* && \
	$(SELFCOMPRESSCMD) $(TARGET_DIR)/usr/lib/libWPEWebKit.so.0.0.* && \
	ln -sf libWPEBackend-rdk.so $(TARGET_DIR)/usr/lib/libWPEBackend-default.so
endef
else
WPEWEBKIT_INSTALL_TARGET_CMDS_WEBKIT = true
endif

define WPEWEBKIT_INSTALL_TARGET_CMDS
	($(WPEWEBKIT_INSTALL_TARGET_CMDS_JSC) && \
	$(WPEWEBKIT_INSTALL_TARGET_CMDS_WEBKIT))
endef

endif

RSYNC_VCS_EXCLUSIONS += --exclude LayoutTests --exclude WebKitBuild

$(eval $(cmake-package))
