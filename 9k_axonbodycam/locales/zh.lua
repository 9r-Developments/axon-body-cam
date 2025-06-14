-- 9K_AXON: Chinese Locale
Locales = Locales or {}

Locales["zh"] = {
    -- 使用说明
    ["usage"] = "用法: /%s [3|4] [on|off]",
    
    -- 状态消息
    ["no_active"] = "^3没有激活的摄像头",
    ["already_active"] = "^3已有摄像头激活中，请先使用 ^7/%s ^3关闭",
    ["bodycam_on"] = "^3AXON BODYCAM %d ^7已 ^1开启",
    ["bodycam_off"] = "^3AXON BODYCAM %d ^7已 ^2关闭",
    ["wrong_type"] = "无效的记录仪类型。请使用 3 或 4。",
    
    -- 命令帮助消息
    ["help_title"] = "^3AXON 随身摄像头命令:",
    ["help_axon3"] = "^3/%s: ^7激活 AXON BODY 3 摄像头",
    ["help_axon4"] = "^3/%s: ^7激活 AXON BODY 4 摄像头",
    ["help_off"] = "^3/%s: ^7关闭当前激活的摄像头",
    ["help_help"] = "^3/%s^7 - 显示此帮助信息",
    
    -- 设置消息
    ["locale_changed"] = "语言已更改为: %s",
    ["invalid_locale"] = "无效的语言。可用语言: %s",
}

return Locales 