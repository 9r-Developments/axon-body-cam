-- 9K_AXON: English Locale
Locales = Locales or {}

Locales["en"] = {
    -- Usage instructions
    ["usage"] = "Usage: /%s [3|4] [on|off]",
    
    -- Status messages
    ["already_active"] = "^3Bodycam already active, use ^7/%s ^3to turn it off first",
    ["bodycam_on"] = "^3AXON BODYCAM %d ^7is ^1ON",
    ["bodycam_off"] = "^3AXON BODYCAM %d ^7is ^2OFF",
    ["wrong_type"] = "Invalid bodycam type. Use 3 or 4.",
    ["no_active"] = "^3No active bodycam",
    
    -- Command help messages
    ["help_title"] = "^3AXON Bodycam Commands:",
    ["help_axon3"] = "^3/%s: ^7Activate AXON BODY 3 camera",
    ["help_axon4"] = "^3/%s: ^7Activate AXON BODY 4 camera",
    ["help_off"] = "^3/%s: ^7Turn off active camera",
    ["help_help"] = "^3/%s: ^7Show this help message",
    
    -- Settings messages
    ["locale_changed"] = "Locale changed to: %s",
    ["invalid_locale"] = "Invalid locale. Available locales: %s",
}

return Locales 