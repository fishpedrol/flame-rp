local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("dt_wall",src)
Proxy.addInterface("dt_wall",src)
vRP = Proxy.getInterface("vRP")

Config = {}

function src.getId(sourceplayer)
	if sourceplayer ~= nil and sourceplayer ~= 0 then
		local user_id = vRP.getUserId(sourceplayer)
		if user_id then
			return user_id
		end
	end
end

function src.getPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    local imageurl = "https://cdn.discordapp.com/attachments/913908872681521163/917910414191390770/logo-png.png"
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = ' Vault Evolved - Sistema de Wall ', avatar_url = imageurl, embeds = {
            { 	------------------------------------------------------------
                title = "Um administrador utilizou o comando /am",
                fields = {
                    { 
                        name = "ID do Administrador: "..user_id.."\n",
                        value = "Observação: Sistema desenvolvido pelo Vault Evolved.\n Não oferecemos suporte a esse script Free."
                    },
                }, 
                footer = { 
                    text = "Vault Evolved - Wall - "..os.date("%d/%m/%Y | %H:%M:%S"),
                    icon_url = "https://cdn.discordapp.com/attachments/913908872681521163/917910414191390770/logo-png.png"
                },
                color = 3093194 
            }
        }
    }), { ['Content-Type'] = 'application/json' })
    


    if vRP.hasPermission(user_id,Config.Permissao) then
        return true
    else
        return false
    end
end