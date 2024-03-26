local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("arsenal",src)

function src.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"ceo.permissao") then
        print(1)
        return true
    else
        TriggerClientEvent('Notify',source,'aviso','aviso','Você não possui permissão.')
        return false
    end
end

local items = {
    ["mp5"]  = "weapon_smg",
    ["glock"]  = "weapon_combatpistol",
    ["mpx"] = "weapon_carbinerifle_mk2",
    ["scar"] = "weapon_carbinerifle",
    ["sig"] = "weapon_combatpdw",
    ["shotgun"] = "weapon_pumpshotgun_mk2",
    ["taser"] = "weapon_stungun",
}


function src.buy(name)
    local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
        if name ~= "kit" then
            TriggerClientEvent("Notify", source, "sucesso","Você equipou 1x <b>"..name.."</b>")
            vRPclient.giveWeapons(source,{[items[name]] = { ammo = 250 }})
        else
            TriggerClientEvent("Notify", source, "sucesso","Você pegou um <b>Kit</b>")
            vRP.giveInventoryItem(user_id,"radio",1)
            vRP.giveInventoryItem(user_id,"bandagem",10)
            vRP.giveInventoryItem(user_id,"energetico",10)

        end
        
    end
end