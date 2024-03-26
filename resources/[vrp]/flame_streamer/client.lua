local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("streamer", src)
vSERVER = Tunnel.getInterface("streamer")

RegisterCommand('DHNasjkDHSHJHJKhdsjdhakdjhakdasd', function(rawCommand, type, title, description, id)
    if vSERVER.CheckPermission() then
		if GetEntityHealth(PlayerPedId()) > 101 then
			if not IsPedInAnyVehicle(PlayerPedId()) then 
				SendNUIMessage({ type = "setShow", detail = true })
				SetNuiFocus(true,true)
			else
				TriggerEvent('Notify', 'negado', 'Você não pode digitar isso em um veículo.')
			end
		else
			TriggerEvent('Notify', 'negado', 'Você não pode fazer isso morto.')
		end
    end
end)

RegisterKeyMapping('DHNasjkDHSHJHJKhdsjdhakdjhakdasd', 'peaga', 'keyboard', 'F4')

RegisterNUICallback('setCarro', function(data, cb)
	vSERVER.spawnLancer()
	SetNuiFocus(false,false)
	Wait(2000)
end)

RegisterNUICallback('setMoto', function(data, cb)
	vSERVER.spawnH2carb()
	SetNuiFocus(false,false)
	Wait(2000)
end)

RegisterNUICallback('setGun', function(data, cb)
	vSERVER.kitStreamer()
	SetNuiFocus(false,false)
	Wait(2000)
end)

RegisterNUICallback('closeNui', function(data, cb)
	SetNuiFocus(false,false)
end)