fx_version "bodacious"
game { "gta5" }

author "Avg dev team <https://github.com/avg-pvp>"
version "Develop 1.0"

ui_page "ui/index.html"

client_scripts {
	'@vrp/lib/utils.lua',
	"client/*"
}

server_scripts {
	'@vrp/lib/utils.lua',
	"server/*"
}

files {
	"ui/*",
	"ui/**/*"
}                                                        