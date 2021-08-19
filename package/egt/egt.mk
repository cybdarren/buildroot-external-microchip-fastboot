################################################################################
#
# egt graphics library for microchip sam9x and sama5 soc's
#
################################################################################

EGT_VERSION = fastboot
EGT_SITE = https://github.com/cybdarren/egt-fastboot.git
EGT_SITE_METHOD = git
EGT_GIT_SUBMODULES = YES
EGT_LICENSE = Apache-2.0
EGT_INSTALL_TARGET = YES
EGT_INSTALL_STAGING = YES
EGT_DEPENDENCIES = cairo

PACKAGE_EGT_EXTRA_CONFIG_OPTIONS = $(call qstrip,$(BR2_PACKAGE_EGT_EXTRA_CONFIG_OPTIONS))
EGT_CONF_OPTS = --program-prefix='egt_' --disable-debug
EGT_CONF_OPTS += $(PACKAGE_EGT_EXTRA_CONFIG_OPTIONS)
EGT_CONF_OPTS += --without-readline
EGT_CONF_OPTS += --without-filesystem

EGT_CONF_ENV += AR=$(TARGET_CC)-ar RANLIB=true
EGT_MAKE_ENV += AR=$(TARGET_CC)-ar RANLIB=true

EGT_CONF_OPTS += --enable-examples

ifeq ($(BR2_PACKAGE_EGT_INSTALL_ICONS),y)
EGT_CONF_OPTS += --enable-icons
else
EGT_CONF_OPTS += --disable-icons
endif

EGT_CONF_OPTS += --without-plplot

ifeq ($(BR2_PACKAGE_LIBDRM),y)
EGT_CONF_OPTS += --with-libdrm
EGT_DEPENDENCIES += libdrm
else
EGT_CONF_OPTS += --without-libdrm
endif

ifeq ($(BR2_PACKAGE_LIBPLANES),y)
EGT_CONF_OPTS += --with-libplanes
EGT_DEPENDENCIES += libplanes
else
EGT_CONF_OPTS += --without-libplanes
endif

EGT_CONF_OPTS += --without-libcurl

ifeq ($(BR2_PACKAGE_LIBRSVG),y)
EGT_CONF_OPTS += --with-librsvg
EGT_DEPENDENCIES += librsvg
else
EGT_CONF_OPTS += --without-librsvg
endif

EGT_CONF_OPTS += --without-gstreamer

EGT_CONF_OPTS += --without-libjpeg

EGT_CONF_OPTS += --without-tslib

EGT_CONF_OPTS += --without-alsa

EGT_CONF_OPTS += --without-sndfile

EGT_CONF_OPTS += --without-zlib

EGT_CONF_OPTS += --without-libinput

EGT_CONF_OPTS += --without-lua

EGT_CONF_OPTS += --without-xkbcommon

EGT_CONF_OPTS += --without-x11

EGT_CONF_OPTS += --without-libmagic

define EGT_RUN_AUTOGEN
        cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
EGT_POST_PATCH_HOOKS += EGT_RUN_AUTOGEN

define EGT_MAKE_CHECK
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) check
endef
#EGT_POST_BUILD_HOOKS += EGT_MAKE_CHECK

$(eval $(autotools-package))
