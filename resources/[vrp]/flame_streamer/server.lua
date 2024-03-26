local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("streamer", src)
vCLIENT = Tunnel.getInterface("streamer")
vGARAGE = Tunnel.getInterface("vrp_garages")
vADMIN = Tunnel.getInterface('vrp_admin')

local Cooldowns = {}
local Cooldowns2 = {}
local Cooldowns3 = {}
---------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNAR O LANCER
---------------------------------------------------------------------------------------------------------------------------------------
function src.spawnLancer()
	local user_id = vRP.getUserId(source)
    if user_id then
        if src.CooldownLiberado() then
            src.SetCooldown()
            vADMIN.spawnVeh(source,'lancerevolutionx')
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNAR A H2CARB
---------------------------------------------------------------------------------------------------------------------------------------
function src.spawnH2carb()
	local user_id = vRP.getUserId(source)
    if user_id then
        if src.CooldownLiberado2() then
            src.SetCooldown2()
            vADMIN.spawnVeh(source,'cbr17')
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------
-- RECEBER O KIT STREAMER
---------------------------------------------------------------------------------------------------------------------------------------
function src.kitStreamer()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if src.CooldownLiberado3() then
            src.SetCooldown3()
                vRPclient.giveWeapons(source,{["WEAPON_ASSAULTRIFLE_MK2"] = { ammo = 250 }})
                vRP.giveInventoryItem(user_id, 'wammo|WEAPON_ASSAULTRIFLE_MK2', 250)
                vRP.giveInventoryItem(user_id, 'melzinho', 10)
                vRP.giveInventoryItem(user_id, 'radio', 3)
                vRP.giveInventoryItem(user_id, 'mochila', 3)
                vRP.giveInventoryItem(user_id, 'compattach',3)
            TriggerClientEvent('Notify', source, 'SUCESSO', '<b>KIT</b> recebido, você poderá pegar novamente em 1h.')
        end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PERMISSAO PARA ABRIR A NUI
---------------------------------------------------------------------------------------------------------------------------------------
function src.CheckPermission()
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'influencer.permissao') or vRP.hasPermission(user_id, "suporte.permissao") then
		return true
	else
		return false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION PARA SETAR COOLDOWN - CARRO
---------------------------------------------------------------------------------------------------------------------------------------
function src.SetCooldown()
    local source = source
    local user_id = vRP.getUserId(source)
    Cooldowns[user_id] = os.time()
end

function src.CooldownLiberado()
    local source = source
    local user_id = vRP.getUserId(source)
    if not Cooldowns[user_id] or os.time() > Cooldowns[user_id] + 15 then
        return true
    end
    TriggerClientEvent('Notify', source, 'negado', 'Você deve aguardar para puxar um veículo.')
    return false
end
---------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION PARA SETAR COOLDOWN - MOTO
---------------------------------------------------------------------------------------------------------------------------------------
function src.SetCooldown2()
    local source = source
    local user_id = vRP.getUserId(source)
    Cooldowns2[user_id] = os.time()
end

function src.CooldownLiberado2()
    local source = source
    local user_id = vRP.getUserId(source)
    if not Cooldowns2[user_id] or os.time() > Cooldowns2[user_id] + 15 then
        return true
    end
    TriggerClientEvent('Notify', source, 'negado', 'Você deve aguardar para puxar um veículo.')
    return false
end
---------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION PARA SETAR COOLDOWN - KIT BASICO
---------------------------------------------------------------------------------------------------------------------------------------
function src.SetCooldown3()
    local source = source
    local user_id = vRP.getUserId(source)
    Cooldowns3[user_id] = os.time()
end

function src.CooldownLiberado3()
    local source = source
    local user_id = vRP.getUserId(source)
    if not Cooldowns3[user_id] or os.time() > Cooldowns3[user_id] + 3600 then
        return true
    end
    TriggerClientEvent('Notify', source, 'negado', 'Você deve aguardar para receber o KIT.')
    return false
end