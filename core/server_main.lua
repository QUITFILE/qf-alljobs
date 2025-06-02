local ESX = exports["es_extended"]:getSharedObject()

local jobStats = {}
local jobCountCache = {}
local onlinePlayers = 0

local debug = function(...)
    if cfg['debug'] then
        print(...)
    end
end

-- ใช้ namespace สำหรับชื่อ event
GetName = function(eventName)
    return 'qf.allcheck:' .. eventName
end

-- เมื่อผู้เล่นโหลดเข้ามา
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local src = source
    Wait(1000)
    local xPlayer = ESX.GetPlayerFromId(src)

    -- print('playerLoaded', src, ESX.DumpTable(xPlayer))
    -- print(ESX.DumpTable(source))

    if not xPlayer then
        debug(('[DEBUG] Failed to get xPlayer for %s'):format(src))
        return
    end

    onlinePlayers = onlinePlayers + 1

    increaseJobCount(xPlayer.job.name)

    debug(('[DEBUG] Player Loaded: %s | Job: %s | Online: %s'):format(src, xPlayer.job.name, onlinePlayers))
    updateClientStats(src)

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @iden LIMIT 1', {
        ['@iden'] = GetPlayerIdentifier(src)
    }, function(result)
        if result[1] ~= nil then
            local playerData = {
                phone = result[1].phone_number or 0,
                name = (result[1].firstname or '') .. ' ' .. (result[1].lastname or '')
            }

            xPlayer.triggerEvent(GetName('SaveToClien'), playerData)
            debug(('[DEBUG] Sent Player Info to Client [%s]: %s (%s)'):format(src, playerData.name, playerData.phone))
        else
            debug(('[DEBUG] No user record found in DB for %s'):format(src))
        end
    end)
end)

-- เมื่อผู้เล่นออกจากเซิร์ฟเวอร์
RegisterNetEvent('esx:playerDropped')
AddEventHandler('esx:playerDropped', function(source)
    local src = source

    local xPlayer = ESX.GetPlayerFromId(src)

    -- print('playerDropped', src, ESX.DumpTable(xPlayer))
    -- print(ESX.DumpTable(source))


    if not xPlayer then
        debug(('[DEBUG] Failed to get xPlayer for %s on drop'):format(src))
        return
    end

    onlinePlayers = onlinePlayers - 1

    decreaseJobCount(xPlayer.job.name)

    debug(('[DEBUG] Player Dropped: %s | Job: %s | Online: %s'):format(src, xPlayer.job.name, onlinePlayers))
    updateClientStats(src)
end)

-- เมื่อเปลี่ยนอาชีพ
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(playerId, oldJob, newJob)
    local xPlayer = ESX.GetPlayerFromId(playerId)

    debug(('[DEBUG] Job Change: %s | %s → %s'):format(playerId, oldJob.name, newJob.name))
    decreaseJobCount(oldJob.name)
    increaseJobCount(newJob.name)
    updateClientStats(playerId)
end)

-- เมื่อ resource เริ่มทำงาน
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    Wait(1000)

    debug("[DEBUG] Resource Starting: Initializing job stats")
    if cfg['CheckDatabase'] then
        local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})
        for _, job in pairs(result) do
            debug('[DEBUG] Job Registered from DB: ' .. job.name)
            table.insert(jobStats, {
                job = job.name,
                count = 0
            })
        end
    else
        for _, jobName in pairs(cfg['JobCheckManual']) do
            debug('[DEBUG] Job Registered (Manual): ' .. jobName)
            table.insert(jobStats, {
                job = jobName,
                count = 0
            })
        end
    end
end)

-- ใช้โหลดซ้ำเมื่อผู้เล่น reconnect
RegisterNetEvent(GetName('ReStartPlayerLoaded'))
AddEventHandler(GetName('ReStartPlayerLoaded'), function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then
        return
    end

    increaseJobCount(xPlayer.job.name)
    debug(('[DEBUG] ReLoaded Player: %s | Job: %s'):format(src, xPlayer.job.name))
    updateClientStats(src)
end)

-- เพิ่มจำนวนอาชีพ
increaseJobCount = function(jobName)
    for _, v in pairs(jobStats) do
        if v.job == jobName then
            v.count = v.count + 1
            debug(('[DEBUG] increaseJobCount: %s → %s'):format(jobName, v.count))
            break
        end
    end
end

-- ลดจำนวนอาชีพ
decreaseJobCount = function(jobName)
    for _, v in pairs(jobStats) do
        if v.job == jobName then
            v.count = math.max(0, v.count - 1)

            debug(('[DEBUG] decreaseJobCount: %s → %s'):format(jobName, v.count))

            break
        end
    end
end

-- อัปเดตข้อมูลไปยัง client
updateClientStats = function(src)
    for _, v in pairs(jobStats) do
        jobCountCache[v.job] = v.count
    end

    debug('[DEBUG] Sending jobCountCache to client:', json.encode(jobCountCache))
    debug('[DEBUG] Online Players:', onlinePlayers)

    Wait(cfg['Transmission'])

    TriggerClientEvent(GetName('IsLoadCount'), -1, jobCountCache)
    TriggerClientEvent(GetName('Online'), -1, onlinePlayers)
end

-- ใช้ server-side ดึงจำนวนอาชีพ
getJobCount = function(jobName)
    for _, v in pairs(jobStats) do
        if v.job == jobName then
            return v.count
        end
    end
end

RegisterCommand('reloadjobstats', function(source, args, rawCommand)
    -- Reset job counts
    if source ~= 0 then
        debug('[DEBUG] Command can only be run by server console.')
        return
    end
    for _, v in pairs(jobStats) do
        v.count = 0
    end

    -- Recount all online players' jobs
    local players = ESX.GetExtendedPlayers()
    onlinePlayers = #players
    for _, xPlayer in pairs(players) do
        increaseJobCount(xPlayer.job.name)
    end

    updateClientStats(-1)
    debug('[DEBUG] Job stats reloaded by command.')
end, true)

exports('getJobCount', getJobCount)

Wait(2000) -- ให้เวลาเซิร์ฟเวอร์โหลดข้อมูลก่อน
local count = exports[GetCurrentResourceName()]:getJobCount("unemployed")
print("Unemployed Count: " .. count)