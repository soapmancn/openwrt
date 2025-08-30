local fs = require "nixio.fs"
local firmware = require "luci.model.firmware_updater"

m = Map("firmware_updater", translate("Custom Firmware Updater"))
m.description = translate("Configure a custom firmware URL and perform system upgrade with preserved configuration.")

s = m:section(TypedSection, "firmware_updater", "")
s.anonymous = true

url = s:option(Value, "url", translate("Firmware URL"))
url.rmempty = false
url.datatype = "string"

check_btn = s:option(Button, "_check", translate("Check Firmware"))
check_btn.inputtitle = translate("Check")
check_btn.template = "firmware_updater/check_button"

upgrade_btn = s:option(Button, "_upgrade", translate("Upgrade Now"))
upgrade_btn.inputtitle = translate("Upgrade System")
upgrade_btn.template = "firmware_updater/upgrade_button"

return m