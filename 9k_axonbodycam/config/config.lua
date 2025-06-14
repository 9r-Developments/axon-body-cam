Config = {}

-- Main settings
Config.Version = '1.1.0'
Config.Debug = false -- Set to true to enable debug messages in console
Config.DefaultLocale = 'en' -- Default language (zh or en)
Config.Standalone = true -- This is a standalone resource with no framework dependencies

-- Time settings
Config.TimeZoneOffset = "-0800" -- Time zone displayed on bodycam
Config.PeriodicSoundInterval = 60000 -- Interval in ms for periodic beeping (60000 = 1 minute)

-- Command settings
Config.Commands = {
    Axon3 = "axon3", -- Command to activate AXON BODY 3
    Axon4 = "axon4", -- Command to activate AXON BODY 4
    Off = "axonoff", -- Command to turn off active bodycam
    Help = "axonhelp" -- Command to show help information
}

-- Bodycam types
Config.BodycamTypes = {
    -- Type 3 bodycam
    [3] = {
        Label = "AXON BODY 3", -- Display name
        Enabled = true -- Enable/disable this type
    },
    -- Type 4 bodycam
    [4] = {
        Label = "AXON BODY 4", -- Display name
        Enabled = true -- Enable/disable this type
    }
}

-- Animation settings when toggling bodycam
Config.Animation = {
    Dict = "clothingtie", -- Animation dictionary
    Name = "try_tie_negative_a", -- Animation name
    Flags = 48, -- 48 = Allow movement (16) + Upper body only (32)
    Duration = 1200, -- Animation duration in ms
    DisableInVehicle = true -- Whether to disable animation when in vehicle
}

-- UI settings
Config.UI = {
    Scale = 1.2, -- UI scale (1.0 = default, higher values = larger UI)
    Position = {
        x = 0, -- X offset (positive = move right, negative = move left)
        y = 0  -- Y offset (positive = move down, negative = move up)
    },
    Logo = {
        Enabled = true, -- Show/hide the Axon logo
        Scale = 1.2, -- Scale (maintaining larger size)
        Position = {
            x = -25, -- X offset (less negative to move logo to the right)
            y = 0    -- Y offset maintained
        }
    },
    TextSpacing = 0.05, -- Vertical spacing between timestamp and device info (in em)
    TextShadow = true, -- Whether to apply text shadow for better visibility
    Background = {
        Enabled = false, -- No background for transparent look
        Opacity = 0 -- Opacity of background (0.0 to 1.0)
    }
}

-- Sound settings
Config.Sounds = {
    -- Start sound (played when bodycam is activated)
    Start = {
        File = "BodyCamStart.wav", -- Sound file name
        Volume = 1.0, -- Volume (0.0 to 1.0)
        Enabled = true -- Enable/disable this sound
    },
    -- Stop sound (played when bodycam is deactivated)
    Stop = {
        File = "BodyCamStop.wav", -- Sound file name
        Volume = 0.4, -- Volume (0.0 to 1.0)
        Enabled = true -- Enable/disable this sound
    },
    -- Periodic sound (played at intervals while bodycam is active)
    Periodic = {
        Enabled = true, -- Enable/disable periodic sound
        UseStartSound = true -- Use the same sound as Start, or set to false to use a different sound
    }
}

-- Server synchronization settings
Config.Server = {
    SyncTime = true, -- Sync time with server
    SyncInterval = 1000, -- Sync interval in ms (1000 = 1 second)
    UseServerTimeFormat = true -- Use server time format, or false to use client time format
}

-- Device ID settings
Config.DeviceID = {
    Prefix = "X", -- Prefix for random device ID
    Length = 9, -- Length of random part of device ID
    Charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" -- Characters to use for random part
}

-- Notifications settings
Config.Notifications = {
    EnableChatMessages = true, -- Show chat messages when toggling bodycam
    EnableScreenNotifications = false -- Show screen notifications (requires additional resource)
}

-- Export this config
return Config 