################################################################################
#
# keepalived
#
################################################################################

KEEPALIVED_VERSION = 1.3.2
KEEPALIVED_SITE = http://www.keepalived.org/software
KEEPALIVED_DEPENDENCIES = host-pkgconf openssl popt
KEEPALIVED_LICENSE = GPLv2+
KEEPALIVED_LICENSE_FILES = COPYING
KEEPALIVED_CONF_OPTS += --disable-dbus

ifeq ($(BR2_PACKAGE_LIBNL),y)
KEEPALIVED_DEPENDENCIES += libnfnetlink
endif

ifeq ($(BR2_PACKAGE_IPSET),y)
KEEPALIVED_DEPENDENCIES += ipset
KEEPALIVED_CONF_OPTS += --enable-libipset
else
KEEPALIVED_CONF_OPTS += --disable-libipset
endif

ifeq ($(BR2_PACKAGE_IPTABLES),y)
KEEPALIVED_DEPENDENCIES += iptables
KEEPALIVED_CONF_OPTS += --enable-libiptc
else
KEEPALIVED_CONF_OPTS += --disable-libiptc
endif

$(eval $(autotools-package))
