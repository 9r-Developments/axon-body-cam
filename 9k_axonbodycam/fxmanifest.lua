fx_version 'cerulean'
game 'gta5'
author '9K'
version '1.1.0'
description '9K AXON Body Camera System Discord: https://discord.gg/9rdev'

-- Shared scripts
shared_scripts {
    'config/config.lua',
    'locales/*.lua',
    'shared/main.lua'
}

-- Server scripts
server_scripts {
    'server/main.lua'
}

-- Client scripts
client_scripts {
    'client/main.lua'
}

-- UI
ui_page 'html/index.html'

-- Files
files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/KlartextMonoBold.ttf',
    'html/BodyCamStart.wav',
    'html/BodyCamStop.wav'
}

-- Data
lua54 'yes' 