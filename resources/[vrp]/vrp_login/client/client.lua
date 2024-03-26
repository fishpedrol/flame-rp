local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
FishLogin = Tunnel.getInterface("vrp_login")
FishLoginP = Tunnel.getInterface("vrp_login")
vSERVER = Tunnel.getInterface("vrp_login")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "garagem01" then
		vRP.teleport(-347.33,-874.77,31.09)
	elseif data == "garagem02" then
		vRP.teleport(318.82,2622.06,44.47)
	elseif data == "garagem03" then
		vRP.teleport(-772.81,5596.25,33.48)
	elseif data == "hospital01" then
		vRP.teleport(295.83,-612.3,43.39)
	elseif data == "metro" then
		vRP.teleport(-206.11,-1013.50,30.13)
	elseif data == "delegacia" then
		if FishLoginP.CheckPolice() then
			vRP.teleport(649.22,-10.1,82.78)
		else
			TriggerEvent('Notify','negado','AVISO!','Somente policias podem spawnar na delegacia.')
		end
	elseif data == "base" then
		vSERVER.base()
	elseif data == "casa" then
		TriggerServerEvent('blzr:Login:SpawnCasa')
	end
	ToggleActionMenu()
	TriggerEvent("ToogleBackCharacter")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp:ToogleLoginMenu')
AddEventHandler('vrp:ToogleLoginMenu',function()
	ToggleActionMenu()
end)
