local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
FishLogin = {}
FishLoginP = {}
vRPclient = Tunnel.getInterface("vRP")
Tunnel.bindInterface("vrp_login", FishLogin)

function FishLogin.base()
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if user_id then
        if vRP.hasPermission(user_id,"ballas.permissao") then
            vRPclient._teleport(source,108.35,-1963.63,20.93)
        elseif vRP.hasPermission(user_id,"families.permissao") then
            vRPclient._teleport(source,-157.07,-1626.85,33.65)
        elseif vRP.hasPermission(user_id,"vagos.permissao") then
            vRPclient._teleport(source,385.55,-2028.93,23.12)
        elseif vRP.hasPermission(user_id,"crips.permissao") then
            vRPclient._teleport(source,1284.88,-1734.19,52.66)
        elseif vRP.hasPermission(user_id,"bloods.permissao") then
            vRPclient._teleport(source,-1065.28,-1671.52,4.51)
        elseif vRP.hasPermission(user_id,"mafiarussa.permissao") then
            vRPclient._teleport(source,583.76,-3118.31,6.07)
        elseif vRP.hasPermission(user_id,"mafiaitaliana.permissao") then
            vRPclient._teleport(source,-1532.8,852.65,181.57)
        elseif vRP.hasPermission(user_id,"lifeinvader.permissao") then
            vRPclient._teleport(source,-1065.75,-246.99,39.74)
        elseif vRP.hasPermission(user_id,"bahamas.permissao") then
            vRPclient._teleport(source,-1386.3,-627.34,30.82)
        elseif vRP.hasPermission(user_id,"scorp.permissao") then
            vRPclient._teleport(source,742.57,-1913.31,29.3)
        end
    end
end

function FishLoginP.CheckPolice()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return vRP.hasPermission(user_id,'policia.permissao') or vRP.hasPermission(user_id,'paisanapolicia.permissao') or vRP.hasPermission(user_id,'policiaacao.permissao')
    end
end