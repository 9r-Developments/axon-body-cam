-- 9K_AXON: Bodycam Script
-- Refactored client-side script

-- Local variables
local activeBodycamType = nil -- Current active bodycam type (nil, 3 or 4)
local periodicSoundThread = nil -- Thread handle for periodic sound
local lastUsedType = nil -- Store last used type for toggle command

-- Debug print function
local function debugPrint(...)
    if Config.Debug then
        print("[9K_AXON:DEBUG]", ...)
    end
end

-- Generate random device ID based on config
local function generateRandomDeviceID()
    -- 使用配置中的前缀作为第一个字母
    local result = Config.DeviceID.Prefix
    
    -- 计算剩余长度
    local remainingLength = Config.DeviceID.Length - 1 -- 减去前缀已占用的1个字母位置
    
    -- 决定第二个字母的随机位置 (在剩余位置中)
    local secondLetterPosition = math.random(1, remainingLength)
    
    -- 生成所有剩余位置的字符
    local letterCharset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local digitCharset = "0123456789"
    
    -- 填充剩余位置
    for i = 1, remainingLength do
        if i == secondLetterPosition then
            -- 在随机位置放置字母
            local randomLetterIndex = math.random(1, #letterCharset)
            result = result .. string.sub(letterCharset, randomLetterIndex, randomLetterIndex)
        else
            -- 其他位置放置数字
            local randomDigitIndex = math.random(1, #digitCharset)
            result = result .. string.sub(digitCharset, randomDigitIndex, randomDigitIndex)
        end
    end
    
    return result
end

-- Play animation when toggling bodycam
local function playAnimation()
    local playerPed = PlayerPedId()
    
    -- Skip animation if player is in vehicle and config says so
    if Config.Animation.DisableInVehicle and IsPedInAnyVehicle(playerPed, false) then
        return
    end
    
    -- Request animation dictionary
    RequestAnimDict(Config.Animation.Dict)
    
    -- Wait for animation to load with timeout
    local timeout = 0
    while not HasAnimDictLoaded(Config.Animation.Dict) do
        Citizen.Wait(10)
        timeout = timeout + 10
        if timeout > 2000 then 
            debugPrint("Animation dictionary load timeout")
            return
        end
    end
    
    -- Play animation with configured flags
    TaskPlayAnim(playerPed, Config.Animation.Dict, Config.Animation.Name, 
                 8.0, 8.0, -1, Config.Animation.Flags, 0, false, false, false)
    
    -- Wait for configured duration
    Citizen.Wait(Config.Animation.Duration)
    
    -- Stop animation
    StopAnimTask(playerPed, Config.Animation.Dict, Config.Animation.Name, 1.0)
    Citizen.Wait(50) -- Short wait to ensure animation stops properly
end

-- Play sound
local function playSound(soundType)
    if not Config.Sounds[soundType] or not Config.Sounds[soundType].Enabled then
        return
    end
    
    SendNUIMessage({ 
        type = 'playSound', 
        sound = Config.Sounds[soundType].File, 
        volume = Config.Sounds[soundType].Volume 
    })
    
    debugPrint("Playing sound:", soundType)
end

-- Show notification in chat
local function showChatNotification(message)
    if Config.Notifications.EnableChatMessages then
        TriggerEvent('chat:addMessage', {
            multiline = false, 
            args = {message}
        })
    end
end

-- Format timestamp for chat messages
local function formatChatTimestamp()
    local hour, minute, second = GetClockHours(), GetClockMinutes(), GetClockSeconds()
    return string.format("^7[%02d:%02d:%02d]^3[AXON]", hour, minute, second)
end

-- Helper function to activate bodycam
local function showBodycam(type)
    -- Check if type is enabled in config
    if not Config.BodycamTypes[type] or not Config.BodycamTypes[type].Enabled then
        debugPrint("Bodycam type", type, "is not enabled in config")
        return
    end
    
    -- Check if another bodycam is already active
    if activeBodycamType then
        local alreadyActiveMessage = Lang.Get("already_active", Config.Commands.Off)
        showChatNotification(alreadyActiveMessage)
        return
    end
    
    -- Set active type
    activeBodycamType = type
    lastUsedType = type
    
    -- Generate device ID
    local randomIdPart = generateRandomDeviceID()
    local bodycamId = Config.BodycamTypes[type].Label .. " " .. randomIdPart
    
    -- Show UI with all configuration options
    SendNUIMessage({
        type = "showBodycam",
        deviceId = bodycamId,
        uiConfig = Config.UI, -- Send complete UI config
        debug = Config.Debug -- Send debug mode setting
    })
    
    -- Play sound
    playSound("Start")
    
    -- Format and send chat message
    local chatMessage = Lang.Get("bodycam_on", type)
    showChatNotification(chatMessage)
    
    -- Play animation
    playAnimation()

    -- Stop existing periodic sound thread if exists
    if periodicSoundThread then
        periodicSoundThread = nil
        Citizen.Wait(10) 
    end

    -- Start new periodic sound thread if enabled
    if Config.Sounds.Periodic.Enabled then
    periodicSoundThread = Citizen.CreateThread(function()
            Citizen.Wait(Config.PeriodicSoundInterval)
            
            while activeBodycamType == type do
                if Config.Sounds.Periodic.UseStartSound then
                    playSound("Start")
                else
                    playSound("Periodic")
                end
                Citizen.Wait(Config.PeriodicSoundInterval)
            end
            
            periodicSoundThread = nil
    end)
end

    debugPrint("Bodycam activated: Type", type)
end

-- Helper function to deactivate bodycam
local function hideBodycam()
    -- If no bodycam is active, do nothing
    if not activeBodycamType then
        local noActiveMessage = Lang.Get("no_active")
        showChatNotification(noActiveMessage)
        return
    end
    
    -- Stop periodic sound thread
    if periodicSoundThread then
        periodicSoundThread = nil
        Citizen.Wait(10)
    end

    -- Hide UI
    SendNUIMessage({ type = "hideBodycam" })
    
    -- Play sound
    playSound("Stop")
    
    -- Store closing type for chat message
    local closingType = activeBodycamType
    
    -- Reset active type
    activeBodycamType = nil
    
    -- Format and send chat message
    local chatMessage = Lang.Get("bodycam_off", closingType)
    showChatNotification(chatMessage)
    
    -- Play animation
    playAnimation()
    
    debugPrint("Bodycam deactivated: Type", closingType)
end

-- AXON3 Command Handler
RegisterCommand(Config.Commands.Axon3, function(source, args, rawCommand)
    showBodycam(3)
end, false)

-- AXON4 Command Handler
RegisterCommand(Config.Commands.Axon4, function(source, args, rawCommand)
    showBodycam(4)
end, false)

-- Turn off command handler
RegisterCommand(Config.Commands.Off, function(source, args, rawCommand)
    hideBodycam()
end, false)

-- Help command
RegisterCommand(Config.Commands.Help, function(source, args, rawCommand)
    local helpMessage = Lang.Get("help_title")
    helpMessage = helpMessage .. "\n" .. Lang.Get("help_axon3", Config.Commands.Axon3)
    helpMessage = helpMessage .. "\n" .. Lang.Get("help_axon4", Config.Commands.Axon4)
    helpMessage = helpMessage .. "\n" .. Lang.Get("help_off", Config.Commands.Off)
    helpMessage = helpMessage .. "\n" .. Lang.Get("help_help", Config.Commands.Help)
    
    showChatNotification(helpMessage)
end, false)

-- Time sync thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.Server.SyncInterval)
        
        if activeBodycamType and Config.Server.SyncTime then
            TriggerServerEvent('9k_axon:requestServerTime')
        end
    end
end)

-- Handle server time response
RegisterNetEvent('9k_axon:receiveServerTime')
AddEventHandler('9k_axon:receiveServerTime', function(timeData)
    if activeBodycamType then 
        SendNUIMessage({
            type = "updateTime",
            year = timeData.year,
            month = timeData.month,
            day = timeData.day,
            hour = timeData.hour,
            minute = timeData.minute,
            second = timeData.second,
            offset = Config.TimeZoneOffset 
        })
    end
end)

-- Resource start initialization
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    
    -- Apply default locale
    Lang.Locale = Config.DefaultLocale
    
    debugPrint("Resource started")
end)

-- Resource stop cleanup
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    
    -- Hide bodycam UI if active when resource stops
    if activeBodycamType then
        SendNUIMessage({ type = "hideBodycam" })
    end
    
    debugPrint("Resource stopped")
end) 