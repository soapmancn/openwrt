local sys = require "luci.sys"
local fs = require "nixio.fs"

M = {}

-- 检查固件 URL 是否可访问
function M.check_firmware(url)
    local tmpfile = "/tmp/firmware.bin.check"
    local code = sys.call(string.format("wget --spider -q '%s'", url))
    if code == 0 then
        return true, "Firmware URL is reachable."
    else
        return false, "Cannot reach firmware URL. Check network or URL."
    end
end

-- 开始升级流程
function M.start_upgrade()
    local url = luci.config.firmware_updater.settings.url
    if not url or url == "" then
        return false, "No firmware URL configured."
    end

    local tmpfile = "/tmp/firmware.bin"

    -- 清理旧文件
    sys.call("rm -f " .. tmpfile)

    -- 下载固件
    local ret = sys.exec(string.format("wget -O %s '%s'", tmpfile, url))
    if not fs.access(tmpfile) then
        return false, "Download failed: " .. ret
    end

    -- 验证是否为合法固件（可选）
    local valid = sys.exec("sysupgrade -t " .. tmpfile)
    if valid:match("suitable") == nil then
        return false, "Firmware is not suitable for this device."
    end

    -- 执行升级（会自动保留配置）
    sys.exec("sysupgrade -v " .. tmpfile .. " &")
    return true, "Upgrade started. Device will reboot shortly."
end

return M