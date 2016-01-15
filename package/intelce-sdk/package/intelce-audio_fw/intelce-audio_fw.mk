################################################################################
#
# intelce-audio_fw
#
################################################################################
INTELCE_AUDIO_FW_VERSION = 9c7b26f9196dbb2a55fe26fd64cbc2374b5b8029
INTELCE_AUDIO_FW_SITE = git@github.com:Metrological/intelce-audio-fw-prebuilt.git
INTELCE_AUDIO_FW_SITE_METHOD = git
INTELCE_AUDIO_FW_LICENSE = PROPRIETARY
INTELCE_AUDIO_FW_REDISTRIBUTE = NO
INTELCE_AUDIO_FW_INSTALL_STAGING = YES

define INTELCE_AUDIO_FW_INSTALL_TARGET_CMDS
    $(INSTALL) -m 644 -D ${INTELCE_AUDIO_FW_DIR}/audio_fw_dsp0.bin ${TARGET_DIR}/lib/firmware/smd/
    $(INSTALL) -m 644 -D ${INTELCE_AUDIO_FW_DIR}/audio_fw_dsp1.bin ${TARGET_DIR}/lib/firmware/smd/
endef

$(eval $(generic-package))
