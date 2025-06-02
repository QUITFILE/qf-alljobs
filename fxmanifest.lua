fx_version 'cerulean'
games {'gta5'}

author 'tnc47'
description 'Quitfile Production'
version '1.1'
lua54 'yes'

shared_scripts { 'shared/general.lua' }

client_scripts {'core/client_main.lua'}

server_scripts {'@oxmysql/lib/MySQL.lua', 'core/server_main.lua'}

