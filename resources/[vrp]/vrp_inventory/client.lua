local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_inventory")

client = {}
Tunnel.bindInterface("vrp_inventory_client",client)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local invOpen = false
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
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
end)

function client.FecharInventario()
    StopScreenEffect("MenuMGSelectionIn")
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEANCHOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vehicleanchor')
AddEventHandler('vehicleanchor',function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    FreezeEntityPosition(vehicle,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("moc",function(source,args)
    local ped = PlayerPedId()
    if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() and not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(ped) then
          if not invOpen then
              StartScreenEffect("MenuMGSelectionIn", 0, true)
              invOpen = true
              SetNuiFocus(true,true)
              SendNUIMessage({ action = "showMenu" })
           else
               StopScreenEffect("MenuMGSelectionIn")
               SetNuiFocus(false,false)
               SendNUIMessage({ action = "hideMenu" })
               invOpen = false
          end
     end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("moc","Abrir a mochila","keyboard","oem_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAR FAZENDO ANIMACAO
------------------------------------------ 1 -------- 2 -----------------------------------------------------------------------------------
for i = 0, 5 do print('Inventario autorizado - flame Evolved') end

function client.EstiverFazendoAnimacao(zoio, tandera)
    local ped = PlayerPedId()
    if IsEntityPlayingAnim(ped, zoio, tandera, 3) then 
        return true  
    else 
        return false 
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	vRPNserver.dropItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	vRPNserver.sendItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	vRPNserver.useItem(data.item,data.type,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,peso,maxpeso = vRPNserver.Mochila()
	if inventario then
		cb({ inventario = inventario, peso = peso, maxpeso = maxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:Update")
AddEventHandler("Creative:Update",function(action)
	SendNUIMessage({ action = action })
end)

local CancelandoBotoes = false

RegisterNetEvent('rusher:DesativarAtirar')
AddEventHandler('rusher:DesativarAtirar', function(status)
    CancelandoBotoes = status
end)

Citizen.CreateThread(function() 
    while true do
        local ThreadDelay = 3000
        if CancelandoBotoes then
            ThreadDelay = 4
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 68, true)
            DisableControlAction(0, 69, true)
            DisableControlAction(0, 70, true)
            DisableControlAction(0, 91, true)
            DisableControlAction(0, 92, true)
            DisableControlAction(0, 114, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 144, true)
        end

        Wait(ThreadDelay)
    end
end)

