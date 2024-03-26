-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest",src)
vSERVER = Tunnel.getInterface("vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chestTimer = 0
local chestOpen = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chestClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	vSERVER.chestClose(tostring(chestOpen))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(chestOpen),data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
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
	vSERVER.storeItem(tostring(chestOpen),data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:UpdateChest")
AddEventHandler("Creative:UpdateChest",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestChest",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2 = vSERVER.openChest(tostring(chestOpen))
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADE DOS BAÚS
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
    { "Policia",626.33, -23.01, 82.78 },
    { "Ballas",124.13,-1947.41,20.76 },
    { "Vagos",371.56,-2040.97,22.2 },
	{ "Scripted",-133.01, 312.97, 98.48},
    { "Grove",-150.31,-1625.65,36.85 },
    { "russkaya",1075.29,-2008.85,32.09},
    { "yardie",-1497.31,845.62,181.6 },
	{ "Israelita",1075.35,-2008.81,32.09},
    { "Bloods",-1080.4,-1678.21,4.58 },
    { "Crips",1268.57,-1710.32,54.78 },
    { "Bahamas",-1383.88,-616.53,30.82 },
    { "LifeInvader",-1062.82,-250.12,44.03 },
	{ "Native",-1144.54,-2004.62,13.19 },
	{ "Driftking",725.54,-1066.98,28.32 },
    { "Hospital",310.77,-599.77,43.3 },
	{ "DriftKing",-448.65,-2176.09,11.45 },
	{ "LifeInvader", -1052.13,-232.55,44.03 },
	{ "Legitz",-579.19, 229.87, 74.9 },
	{ "Mecanico",-238.32, -1317.42, 30.89},
	{ "NineThree",-112.17,-7.88,70.52 },
	{ "GrooveFarm", -1103.84,4953.61,218.65},
	{ "BallasFarm", 102.73,6329.2,31.38 },
	{ "VagosFarm", 1491.17,6396.26,20.79 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		if chestTimer > 0 then
			chestTimer = chestTimer - 3
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chest",function(source,args)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(chest) do
		local distance = Vdist(x,y,z,v[2],v[3],v[4])
		if distance <= 2.0 and chestTimer <= 0 then
			chestTimer = 3
			if vSERVER.checkIntPermissions(v[1]) then
				TriggerEvent('Notify','sucesso','Abrindo baú...')
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
				chestOpen = v[1]
			end
		end
	end
end)

RegisterCommand("chestadm",function(source,args)
	if args[1] then
		if vSERVER.checkIntStaff() then
			chestTimer = 3
			TriggerEvent('Notify','sucesso','Abrindo baú <b>'..args[1]..'</b>')
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu" })
			chestOpen = tostring(args[1])
		end
	end
end)