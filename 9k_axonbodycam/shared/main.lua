-- 9K_AXON: Bodycam Script
-- Refactored shared script

-- Initialize the Lang object
Lang = {}

-- Default locale based on config (fallback to English)
Lang.Locale = Config and Config.DefaultLocale or "en"

-- Add debug option
Lang.Debug = Config and Config.Debug or false

-- Debug print function
local function debugPrint(...)
    if Lang.Debug then
        print("[9K_AXON:LANG:DEBUG]", ...)
    end
end

-- Get localized string with parameter substitution
function Lang.Get(key, ...)
    -- If locale exists and has the key, return it with format
    if Locales[Lang.Locale] and Locales[Lang.Locale][key] then
        return string.format(Locales[Lang.Locale][key], ...)
    end
    
    -- If the key doesn't exist in selected locale, fall back to English
    if Locales["en"] and Locales["en"][key] then
        debugPrint("Missing translation key:", key, "for locale:", Lang.Locale)
        return string.format(Locales["en"][key], ...)
    end
    
    -- If the key doesn't exist at all, return the key itself as fallback
    debugPrint("Missing translation key:", key, "in all locales")
    return key .. " [MISSING TRANSLATION]"
end

-- Function to set locale at runtime
function Lang.SetLocale(locale)
    if Locales[locale] then
        Lang.Locale = locale
        debugPrint("Locale set to:", locale)
        return true
    else
        debugPrint("Invalid locale:", locale)
        return false
    end
end

-- Function to add new locale
function Lang.AddLocale(locale, translations)
    if not Locales[locale] then
        Locales[locale] = translations
        debugPrint("Added new locale:", locale)
        return true
    else
        debugPrint("Locale already exists:", locale)
        return false
    end
end

-- Display available locales
function Lang.GetAvailableLocales()
    local locales = {}
    for k, _ in pairs(Locales) do
        table.insert(locales, k)
    end
    return locales
end 