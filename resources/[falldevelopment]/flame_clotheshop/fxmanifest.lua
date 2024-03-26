fx_version 'cerulean'
game 'gta5'

name "clotheshop"
description "Cloth shop "
author "Zhawty"
version "1.0.0"
lua54 '' 

ui_page "web/index.html"

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'@vrp/lib/utils.lua',
	'client/*.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server/*.lua'
}

files {
	'web/*',
	'web/**/*'
}