################################################################################
#
# gluelogic
#
################################################################################

GLUELOGIC_VERSION = 35bcdfd121b1698f14d7c36a30ed705870291278
GLUELOGIC_SITE_METHOD = git
GLUELOGIC_SITE = git@github.com:Metrological/gluelogic.git
GLUELOGIC_INSTALL_STAGING = YES

ifeq ($(BR2_ENABLE_DEBUG),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_DEBUG=ON
else ifeq ($(BR2_PACKAGE_CPPSDK_DEBUG),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_DEBUG=ON
endif

ifeq ($(BR2_PACKAGE_GLUELOGIC_QUEUEPLAYER),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_QUEUEPLAYER=ON -DGLUELOGIC_QUEUEPLAYER_TESTS=ON
GLUELOGIC_DEPENDENCIES += cppsdk
endif

ifeq ($(BR2_PACKAGE_GLUELOGIC_VIRTUAL_KEYBOARD),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_VIRTUAL_KEYBOARD=ON
GLUELOGIC_DEPENDENCIES += cppsdk
endif


ifeq ($(BR2_PACKAGE_GLUELOGIC_KEYBOARDSCANNER),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_KEYBOARDSCANNER=ON
GLUELOGIC_DEPENDENCIES += cppsdk
endif

$(eval $(cmake-package))