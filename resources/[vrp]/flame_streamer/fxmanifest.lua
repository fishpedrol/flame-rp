

fx_version 'adamant'
game 'gta5'

ui_page 'nui/index.html'

files {
	'nui/index.html',
	'nui/**/*',
	'nui/**/**/*'
}

client_scripts {
    '@vrp/lib/utils.lua',
    'client.lua',
    'entityiter.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
    'server.lua',
}                                                                                                                                                                                                                                                                                                                    