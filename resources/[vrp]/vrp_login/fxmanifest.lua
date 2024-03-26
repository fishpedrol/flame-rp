 fx_version 'bodacious'
game 'gta5'

ui_page "nui/ui.html"
ui_page_preload 'yes'

client_scripts {
	"@vrp/lib/utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server/*"
}

files {
	"nui/ui.html",
	"nui/ui.js",
	"nui/ui.css"
}             