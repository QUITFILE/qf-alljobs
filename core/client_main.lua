ESX = exports["es_extended"]:getSharedObject()

local jobCountCache = {}
local clientPhone = nil
local clientName = nil
local onlinePlayers = 0

local debug = function(...)
    if cfg['debug'] then
        print(...)
    end
end


-- ใช้ namespace prefix
GetName = function(eventName)
    return 'qf.allcheck:' .. eventName
end

-- รับข้อมูลจำนวนอาชีพจาก server
RegisterNetEvent(GetName('IsLoadCount'))
AddEventHandler(GetName('IsLoadCount'), function(data)
    debug("[DEBUG] Received job count data:", json.encode(data))
    jobCountCache = data
end)

-- รับข้อมูลผู้เล่นจาก server
RegisterNetEvent(GetName('SaveToClien'))
AddEventHandler(GetName('SaveToClien'), function(data)
    debug(("[DEBUG] Received client data: phone = %s, name = %s"):format(data.phone, data.name))
    clientPhone = data.phone
    clientName = data.name
end)

-- รับจำนวนผู้เล่นออนไลน์
RegisterNetEvent(GetName('Online'))
AddEventHandler(GetName('Online'), function(count)
    debug("[DEBUG] Received online player count:", count)
    onlinePlayers = count
end)

-- ตรวจสอบจำนวนคนในอาชีพ
function ClientCheckJob(jobName)
    local count = jobCountCache[jobName]
    debug(("[DEBUG] Checked job '%s' → count = %s"):format(jobName, tostring(count)))
    return count
end
exports('ClientCheckJob', ClientCheckJob)

-- ดึงเบอร์โทรศัพท์ผู้เล่น
function ClientPhone()
    debug("[DEBUG] Requested client phone:", clientPhone)
    return clientPhone
end
exports('ClientPhone', ClientPhone)

-- ดึงชื่อผู้เล่น
function ClientName()
    debug("[DEBUG] Requested client name:", clientName)
    return clientName
end
exports('ClientName', ClientName)

-- ดึงจำนวนผู้เล่นออนไลน์
function ClientOnline()
    debug("[DEBUG] Requested online players:", onlinePlayers)
    return onlinePlayers
end
exports('ClientOnline', ClientOnline)
