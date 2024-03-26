local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
--------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
--------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("craftAmmo", src)
vSERVER = Tunnel.getInterface("craftAmmo")
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


RegisterNetEvent('voult:TravarPed')
AddEventHandler('voult:TravarPed', function(status)
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
		TriggerServerEvent("voult:ArmasTransformar","wammo_WEAPON_PISTOL_MK2")
	elseif data.data == "vestuario-comprar-doze" then
		TriggerServerEvent("voult:ArmasTransformar","wammo_WEAPON_SAWNOFFSHOTGUN")
	--TEC
	elseif data.data == "utilidades-comprar-glock" then
		TriggerServerEvent("voult:ArmasTransformar","wammo_WEAPON_APPISTOL")
	--MP5
	elseif data.data == "utilidades-comprar-smg" then
		TriggerServerEvent("voult:ArmasTransformar","wammo_WEAPON_SMG_MK2")
	--AK
	elseif data.data == "utilidades-comprar-ak" then
		TriggerServerEvent("voult:ArmasTransformar","wammo_WEAPON_ASSAULTRIFLE_MK2")
	--PARAFAL
--	elseif data.data == "utilidades-comprar-parafal" then
--		TriggerServerEvent("voult:ArmasTransformar","wammo_WEAPON_SPECIALCARBINE")
    --BULLPUP
	elseif data.data == "utilidades-comprar-g3" then
		TriggerServerEvent("voult:ArmasTransformar","wammo_WEAPON_SPECIALCARBINE_MK2")

    elseif data.data == "utilidades-comprar-polvora9mm" then
		TriggerServerEvent("voult:ArmasTransformar","polvora9mm")

    elseif data.data == "utilidades-comprar-polvora762" then
		TriggerServerEvent("voult:ArmasTransformar","polvora762")

	elseif data.data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
    { -1486.32,835.88,177.0 },  -- italiana
    { 569.83,-3126.71,18.77 } -- yardie
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(marcacoes) do
		table.insert(innerTable,{ v[1],v[2],v[3],2.5,"/","FABRICAÇÃO DE MUNIÇÃO","Digite /fmunicao" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)


RegisterCommand("fmunicao",function(source,args,rawCommand)
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