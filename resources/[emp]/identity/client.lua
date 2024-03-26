-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("identity")

-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
RegisterCommand('+identidade', function()
    menuactive = not menuactive
    if menuactive then
        local info = vRPNserver.Identidade()
        SendNUIMessage({ action = "show", id = info.userid, name = info.name, age = info.age, identity = info.identity, phone = info.phone, job = info.job, job2 = info.job2, vip = info.vip, wallet = info.cash, bank = info.bank, staff = info.staff })
    else
        SendNUIMessage({ action = "hide" })
    end
end)

RegisterKeyMapping('+identidade', '[xt] Abrir Identidade', 'keyboard', 'F11')
