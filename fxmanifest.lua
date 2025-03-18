fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'SV_Scripts'
description 'VIP/Coin Shop Script'
version '1.0.3'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

shared_scripts {
    'config.lua'
}

files {
    'nui/vipshop.html',
    'nui/vipshop.css',
    'nui/vipshop.js',
    'nui/images/logo/*.*',
    'nui/images/items/*.*'
}

ui_page 'nui/vipshop.html'

escrow_ignore {
    'config.lua',
    'nui/vipshop.html',
    'nui/vipshop.css',
    'nui/vipshop.js',
    'nui/images/logo/*.*',
    'nui/images/items/*.*',
    'readme.md'
}

dependencies {
    'ox_inventory',
    'dilza-notify',
    'es_extended'
}



escrow_ignore {
    'config.lua'
}