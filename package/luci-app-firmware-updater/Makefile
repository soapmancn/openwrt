include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI App for Firmware Updater
LUCI_DESCRIPTION:=Allows custom firmware URL and one-click sysupgrade with config preservation.
LUCI_DEPENDS:=+wget +libcurl +ubox
LUCI_PKGARCH:=all
define Package/luci-app-firmware-updater
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Firmware Updater (Custom URL)
  DEPENDS:=+luci-base +wget
endef

define Package/luci-app-firmware-updater/conffiles
/etc/config/firmware_updater
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/luci-app-firmware-updater/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./root/etc/config/firmware_updater $(1)/etc/config/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/firmware_updater.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./luasrc/model/cbi/firmware_updater.lua $(1)/usr/lib/lua/luci/model/cbi/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model
	$(INSTALL_DATA) ./luasrc/model/firmware_updater.lua $(1)/usr/lib/lua/luci/model/
endef

$(eval $(call BuildPackage,luci-app-firmware-updater))