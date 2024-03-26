----------------------------------------------------------------------------------------------------------------------------------------
-- Client.lua ---- aim  ---  Criado Por Arcano
----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRPclient = Tunnel.getInterface("vRP")
arc = {}
Tunnel.bindInterface("aim",arc)
Proxy.addInterface("aim",arc)
vRP = Proxy.getInterface("vRP")


function arc.getPermissao(toogle)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"staff.permissao") then
        return true
    else
        return false
    end
end