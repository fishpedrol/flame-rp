local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_trunkchest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local invOpen = false
local delayers = 0 
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data)
	StopScreenEffect("MenuMGSelectionIn")
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
	vRPNserver.chestClose()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN TRUNK CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:Open")
AddEventHandler("trunkchest:Open",function()
	if not invOpen then
		StartScreenEffect("MenuMGSelectionIn", 0, true)
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu" })
		invOpen = true
	end
end)

RegisterCommand('trunk', function(source, args, rawCmd)
	local ped = PlayerPedId()
	SetNuiFocus(false,false)
	if not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(PlayerId()) and GetEntityHealth(PlayerPedId()) > 101 then
		vRPNserver.chestOpen()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	TriggerEvent('cancelando', true)
	vRP.playAnim(false, {{"amb@world_human_security_shine_torch@male@exit", "exit"}}, false)
	vRPNserver.takeItem(data.item,data.amount)
	Wait(1000)
	TriggerEvent('cancelando', false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	print(data.item)
    if data.item == "test" or
    data.item == "wbody_WEAPON_STUNGUN" or
    data.item == "wbody_WEAPON_FLASHLIGHT" or
    data.item == "wbody_WEAPON_NIGHTSTICK" or
    data.item == "wbody_WEAPON_COMBATPISTOL" or
    data.item == "wbody_WEAPON_HEAVYPISTOL" or
    data.item == "wbody_WEAPON_COMBATPDW" or
    data.item == "wbody_WEAPON_CARBINERIFLE" or
    data.item == "wbody_WEAPON_CARBINERIFLE_MK2" or
    data.item == "wbody_WEAPON_SMG" or
    data.item == "wbody_WEAPON_PUMPSHOTGUN" or
    data.item == "wammo_WEAPON_COMBATPISTOL" or
    data.item == "wammo_WEAPON_HEAVYPISTOL" or
    data.item == "wammo_WEAPON_COMBATPDW" or
    data.item == "wammo_WEAPON_CARBINERIFLE" or
    data.item == "wammo_WEAPON_CARBINERIFLE_MK2" or
    data.item == "wammo_WEAPON_SMG" and
    data.item == "wammo_WEAPON_PUMPSHOTGUN" then
        TriggerEvent("Notify","negado","Você não pode guardar itens do arsenal policial.")
            return
        end
	TriggerEvent('cancelando', true)
	vRP.playAnim(false,{{"mp_common","givetake1_a"}},false)
	vRPNserver.storeItem(data.item,data.amount)
	Wait(1000)
	TriggerEvent('cancelando', false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2 = vRPNserver.Mochila()
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:UpdateTrunk")
AddEventHandler("Creative:UpdateTrunk",function(action)
	SendNUIMessage({ action = action })
end)