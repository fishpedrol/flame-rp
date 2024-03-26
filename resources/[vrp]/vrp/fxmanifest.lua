

client_script "lib/lib.lua"
fx_version "bodacious"
game "gta5"
ui_page "gui/index.html"
ui_page_preload "yes"
server_scripts { 
	"lib/utils.lua",
	"base.lua",
	"queue.lua",
	"modules/gui.lua",
	"modules/group.lua",
	"modules/player_state.lua",
	"modules/business.lua",
	"modules/map.lua",
	"modules/money.lua",
	"modules/inventory.lua",
	"modules/identity.lua",
	"modules/aptitude.lua",
	"modules/basic_items.lua",
	"modules/basic_skinshop.lua",
	"modules/cloakroom.lua"
}
client_scripts {
	"lib/utils.lua",
	"client/base.lua",
	"client/basic_garage.lua",
	"client/iplloader.lua",
	"client/gui.lua",
	"client/player_state.lua",
	"client/survival.lua",
	"client/map.lua",
	"client/notify.lua",
	"client/identity.lua",
	"client/police.lua"
}
files {
--[[ 	'loading/index.html',	
    'loading/css.css',
	'loading/style.css',
	'loading/particles.js',
	'loading/loader.gif',
	'loading/app.js',
	'loading/1.css',
	'loading/background.png',
	'loading/meu_audio.mp3',
	'loading/logo.png', ]]
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Luaseq.lua",
	"lib/Tools.lua",
	"lib/Debug.lua",
	"gui/index.html",
	"gui/design.css",
	"gui/main.js",
	"gui/Menu.js",
	"gui/WPrompt.js",
	"gui/RequestManager.js",
	"gui/Div.js",
	"gui/dynamic_classes.js",
	"gui/bebas.ttf"
}
loadscreen "loading/index.html"
server_export "AddPriority"
server_export "RemovePriority"