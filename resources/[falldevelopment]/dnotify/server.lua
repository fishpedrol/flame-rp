local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")

vRP = Proxy.getInterface("vRP")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")


start = {}
Tunnel.bindInterface("dnotify",start)
vCLIENT = Tunnel.getInterface("dnotify")

RegisterCommand('dnotify',function(source,args,rawCommand)
	local source = source
    local user_id = vRP.getUserId(source)
     if vRP.hasPermission(user_id,"suporte.permissao") then
        vCLIENT.tAdm(source)
    end
end)

function startlogs(webhook,message)
	if webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MATHLEGTH
-----------------------------------------------------------------------------------------------------------------------------------------
function mathLegth(n)
    n = math.ceil(n * 100) / 100
    return n
end


local webhookarcadius = ''


function synterinho(corzinha, titulopika, logfull)
    local synter = {
      {
        ["color"] = corzinha,
        ["title"] = titulopika,
        ["description"] = logfull,
        ["footer"] = {
            ["text"] = marcadagua,
            ["icon_url"] = img,
        },
    }
  }
	PerformHttpRequest(webhookarcadius, function(err, text, headers) end, 'POST', json.encode({avatar_url = img, username = marcadagua, embeds = synter}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent('Flame-common:killed')
AddEventHandler('Flame-common:killed',function(killer,weapon)
    local source = source
    local user_id = vRP.getUserId(source)
    local killer_id = vRP.getUserId(killer)

    local identityK = vRP.getUserIdentity(killer_id)
    local identityV = vRP.getUserIdentity(user_id)

    local x, y, z = vRPclient.getPosition(source)
    
    if killer_id ~= nil then
        synterinho(3553599,"🔫 LOG DE KILL", "> **__QUEM MATOU:__** \n```yaml\n"..killer_id.." " .. identityK.name .. " " .. identityK.firstname .. " ```\n> **__QUEM MORREU:__** \n```yaml\n"..user_id.." "..identityV.name.." "..identityV.firstname.." ```\n> **__ARMA:__** \n```yaml\n "..weapon.." ```\n> **__COORDENADAS:__** \n```yaml\n " .. mathLegth(x) .. "," .. mathLegth(y) .. "," .. mathLegth(z) .. "  "..'```')
        local amountStaff = vRP.getUsersByPermission("id.permissao")
        for k,v in pairs(amountStaff) do 
            local player = vRP.getUserSource(parseInt(v))
            TriggerClientEvent("start:DeathNotify",player,weapon,identityK.name.." "..identityK.firstname,identityV.name.." "..identityV.firstname)
        end
    else
        synterinho(3553599,"💀 LOG DE KILL", "> **__MORREU:__** \n```yaml\n"..user_id.." " .. identityV.name .. " " .. identityV.firstname .. "```\n> **__ARMA:__** \n```yaml\n "..weapon.." ```\n> **__COORDENADAS:__** \n```yaml\n " .. mathLegth(x) .. "," .. mathLegth(y) .. "," .. mathLegth(z) .. "  "..'```')
    end
end)