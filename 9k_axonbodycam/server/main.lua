-- 9K_AXON: Bodycam Script
-- Refactored server-side script

-- Debug print function
local function debugPrint(...)
    if Config and Config.Debug then
        print("[9K_AXON:SERVER:DEBUG]", ...)
    end
end

-- Load shared config
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    
    debugPrint("Server started")
end)

-- Time sync handler
RegisterNetEvent('9k_axon:requestServerTime')
AddEventHandler('9k_axon:requestServerTime', function()
    local source = source
    local currentTime = os.date("*t")
    
    TriggerClientEvent('9k_axon:receiveServerTime', source, {
        year = currentTime.year,
        month = currentTime.month,
        day = currentTime.day,
        hour = currentTime.hour,
        minute = currentTime.min,
        second = currentTime.sec
    })
    
    debugPrint("Time sync requested by player " .. source)
end)