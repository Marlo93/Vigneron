fx_version('cerulean')
lua54 'yes'
game('gta5')

client_scripts {
    'libs/RageUI//RMenu.lua',
    'libs/RageUI//menu/RageUI.lua',
    'libs/RageUI//menu/Menu.lua',
    'libs/RageUI//menu/MenuController.lua',
    'libs/RageUI//components/*.lua',
    'libs/RageUI//menu/elements/*.lua',
    'libs/RageUI//menu/items/*.lua',
    'libs/RageUI//menu/panels/*.lua',
    'libs/RageUI/menu/windows/*.lua',
    
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
    'shared/server/config.lua'
}

shared_scripts {
    'shared/client/config.lua',
    'shared/shared.lua'
}