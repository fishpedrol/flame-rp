local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("vrp_radio",src)
vSERVER = Tunnel.getInterface("vrp_radio")

local inRadio = false

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
	vSERVER.stopanim()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /INV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:toggleinterface")
AddEventHandler("radio:toggleinterface", function()
	if vSERVER.checkRadio() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu" })
	end
end)

RegisterCommand("radiod",function(source,args)
	if vSERVER.checkRadio() then
		TriggerEvent("radio:outServers")
		TriggerEvent("Notify", "sucesso", "Você desligou seu rádio com sucesso!", 8000)
	end
end)
RegisterCommand("radiof",function(source,args)
	if vSERVER.checkRadio() and args[1] and parseInt(args[1]) then
		if parseInt(args[1]) >= 1 and parseInt(args[1]) <= 999 then
			vSERVER.activeFrequency(parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("activeFrequency",function(data)
	if parseInt(data.freq) >= 1 and parseInt(data.freq) <= 999 then
		vSERVER.activeFrequency(data.freq)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("inativeFrequency",function(data)
	TriggerEvent("radio:outServers")
	TriggerEvent("Notify","importante","Você saiu de todas as frequências.",8000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startFrequency(frequency)
	if GetEntityHealth(PlayerPedId()) > 101 then
		TriggerEvent("radio:outServers")
		exports["pma-voice"]:setVoiceProperty("radioEnabled", true)		
		TriggerEvent("vrp_hud:RadioDisplay", frequency)
		exports['pma-voice']:setRadioChannel(frequency)
		inRadio = true
	end
end

Citizen.CreateThread(function()
	while true do
		if inRadio and (not vSERVER.checkRadio2()) then
			local isInAnyRadio = (LocalPlayer.state.radioChannel ~= 0)
			if isInAnyRadio then
				vSERVER.logDiscord()
				TriggerEvent("radio:outServers")
			end
			inRadio = false
		end
		Wait(15000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTSERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:outServers")
AddEventHandler("radio:outServers",function()
	local radioChannel = LocalPlayer.state.radioChannel
	if radioChannel ~= 0 then
		exports['pma-voice']:setRadioChannel(0)
	end
	exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
	TriggerEvent("vrp_hud:RadioDisplay", 0)
	inRadio = false
end)

