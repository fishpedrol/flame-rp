local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
--------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
--------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("cllt_weapons", src)
vSERVER = Tunnel.getInterface("cllt_weapons")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
    menuactive = not menuactive
    if menuactive then
        SetNuiFocus(true, true)
        SendNUIMessage({ showMenu = true })
    else
        SetNuiFocus(false)
        SendNUIMessage({ hideMenu = true })
    end
end

RegisterNUICallback("CloseNui", function(data, cb)
    SetNuiFocus(false)
    SendNUIMessage({ hideMenu = true })
end)


RegisterNetEvent('cllt:TravarPed')
AddEventHandler('cllt:TravarPed', function(status)
	FreezeEntityPosition(PlayerPedId(), status)
end)

RegisterNetEvent('armas:anin')
AddEventHandler('armas:anin', function()
	vRP.playAnim(false, {{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}}, true)
	Wait(5000)
	vRP._stopAnim(source,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick", function(data, cb)
    -- FIVE / SHOTGHUN
	if data.data == "utilidades-comprar-five" then
		TriggerServerEvent("cllt:ArmasTransformar","wbody_WEAPON_PISTOL_MK2")
        
	elseif data.data == "utilidades-comprar-sawn" then
		TriggerServerEvent("cllt:ArmasTransformar","wbody_WEAPON_SAWNOFFSHOTGUN")
	--TEC
	elseif data.data == "utilidades-comprar-glock" then
		TriggerServerEvent("cllt:ArmasTransformar","wbody_WEAPON_APPISTOL")
    --MP5
	elseif data.data == "utilidades-comprar-mp5" then
		TriggerServerEvent("cllt:ArmasTransformar","wbody_WEAPON_SMG_MK2")
	--AK
	elseif data.data == "utilidades-comprar-ak" then
		TriggerServerEvent("cllt:ArmasTransformar","wbody_WEAPON_ASSAULTRIFLE_MK2")
    --PARAFAL
	elseif data.data == "utilidades-comprar-parafal" then
		TriggerServerEvent("cllt:ArmasTransformar","wbody_WEAPON_SPECIALCARBINE")
    --BULLPUP
	elseif data.data == "utilidades-comprar-g3" then
		TriggerServerEvent("cllt:ArmasTransformar","wbody_WEAPON_SPECIALCARBINE_MK2")
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------

    elseif data.data == "utilidades-comprar-pecadearma" then
		TriggerServerEvent("cllt:ArmasTransformar","pecadearma")

    elseif data.data == "utilidades-comprar-pecadesub" then
		TriggerServerEvent("cllt:ArmasTransformar","pecadesub")

  elseif data.data == "utilidades-comprar-pecadeak" then
		TriggerServerEvent("cllt:ArmasTransformar","pecadeak")

    elseif data.data == "utilidades-comprar-pecadeg3" then
		TriggerServerEvent("cllt:ArmasTransformar","pecadeg3")

	elseif data.data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
    { -1075.2,-1678.68,4.58}, -- bloods
    { 1308.06,-1681.97,47.9 } -- crips
}
  
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(marcacoes) do
		table.insert(innerTable,{ v[1],v[2],v[3],2.5,"/","FABRICAÇÃO DE ARMAS","Digite /farmas" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)

RegisterCommand("farmas",function(source,args,rawCommand)
    SetNuiFocus(false, false)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for _, v in pairs(marcacoes) do
        local vec3 = vec3(v[1], v[2], v[3])
        local distance = #(coords - vec3)
        if distance <= 2.0 then
            if vSERVER.permApply() then
                ToggleActionMenu()
            end
        end
    end
end)

