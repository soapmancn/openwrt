module("luci.controller.firmware_updater", package.seeall)

function index()
    entry({"admin", "system", "firmware_updater"},
          cbi("firmware_updater"),
          _("Firmware Updater"), 90)
          .dependent = true

    entry({"admin", "system", "firmware_updater_action"},
          call("action_handler"),
          nil).leaf = true
end

function action_handler()
    local firmware = require "luci.model.firmware_updater"
    local action = luci.http.formvalue("action")

    if action == "check" then
        local url = luci.http.formvalue("url")
        local status, msg = firmware.check_firmware(url)
        luci.http.prepare_content("application/json")
        luci.http.write_json({
            status = status and "success" or "error",
            message = msg
        })
    elseif action == "upgrade" then
        local ok, err = firmware.start_upgrade()
        luci.http.prepare_content("application/json")
        luci.http.write_json({
            status = ok and "success" or "error",
            message = err or "Upgrade started (will disconnect soon)"
        })
    end
end