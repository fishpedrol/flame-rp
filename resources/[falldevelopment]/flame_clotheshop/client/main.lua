local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

zSERVER = Tunnel.getInterface(GetCurrentResourceName())

local cam = -1
local clothingData = {}

CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for i=1, #clothingCoords do
            local index = clothingCoords[i]
            local distance = #(index - coords)
            if distance <= 4 then
                timeDistance = 4
                DrawMarker( 23, index.x, index.y, index.z-0.9, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, blipColor[1], blipColor[2], blipColor[3], 180, 0, 0, 0, 0)
                if IsControlJustPressed(0, 38) then
                    SetNuiFocus(false, false)
                    OpenMenu() 
                end
            end
        end
        Wait(timeDistance)
    end
end)

RegisterCommand("openshop", function()
    SetNuiFocus(false, false)
    OpenMenu() 
end)

function OpenMenu()
	local ped = PlayerPedId()
	for k,v in pairs(clothingCategorys) do
        if not clothingData[k] then clothingData[k] = {} end
        if v.type == "prop" then
            clothingData[k].item = GetPedPropIndex(ped, v.id)
            clothingData[k].texture = GetPedPropTextureIndex(ped ,v.id)
            clothingData[k].name = v.name
        end
		if v.type == "variation" then   
            clothingData[k].item = GetPedDrawableVariation(ped, v.id)
            clothingData[k].texture = GetPedTextureVariation(ped ,v.id)
            clothingData[k].name = v.name
        end
	end

    enableCam()

    SendNUIMessage({ action = "open", initial = json.encode(clothingData) })
    SetNuiFocus(true, true)
end

function ChangeVariation(name,id,texture)
	local ped = PlayerPedId()
    if not clothingCategorys[name] then return end
    if clothingCategorys[name].type == "prop" then
        SetPedPropIndex(ped,clothingCategorys[name].id,id,texture,1)
    end

    if clothingCategorys[name].type == "variation" then
        SetPedComponentVariation(ped,clothingCategorys[name].id,id,texture,1)
    end
end

RegisterNUICallback("viewPreset", function(data)
    for k,v in pairs (data) do
        ChangeVariation(k,tonumber(v.model),tonumber(v.tag))
    end
end)

RegisterNUICallback("reset", function()
    for k,v in pairs (clothingData) do
        ChangeVariation(k,tonumber(v.item),tonumber(v.texture))
    end
    OpenMenu()
end)

RegisterNUICallback("close", function()
    disableCam()

    SetNuiFocus(false, false)
end)

function CalcPrice()
	local ped = PlayerPedId()
    local price = 0
    for k,v in pairs(clothingCategorys) do
        if not clothingData[k] then clothingData[k] = {} end
        if v.type == "prop" then
            if not (clothingData[k].item == GetPedPropIndex(ped,v.id)) or not (clothingData[k].texture == GetPedPropTextureIndex(ped ,v.id )) then
                price += v.price
            end
        end
        if v.type == "variation" then
            if not (clothingData[k].item == GetPedDrawableVariation(ped,v.id)) or not (clothingData[k].texture == GetPedTextureVariation(ped ,v.id )) then
                price += v.price
            end
        end
	end
    return price
end

RegisterNUICallback("Buy", function(data)
    local price = CalcPrice()
    if zSERVER.PayClothes(price) then
        local data_save = {}
        local ped = PlayerPedId()
        for k,v in pairs(clothingCategorys) do
            if not data_save[k] then data_save[k] = {} end
            if v.type == "prop" then
                data_save[k].item = GetPedPropIndex(ped, v.id)
                data_save[k].texture = GetPedPropTextureIndex(ped ,v.id)
                data_save[k].name = v.name
            end
            if v.type == "variation" then   
                data_save[k].item = GetPedDrawableVariation(ped, v.id)
                data_save[k].texture = GetPedTextureVariation(ped ,v.id)
                data_save[k].name = v.name
            end
        end
        TriggerServerEvent("clotheshop:save", data_save)
    end
end)

RegisterNUICallback('setupCam',function(data)
	local value = data.value

	if value == 1 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,0.75,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.65)
	elseif value == 2 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.2)
	elseif value == 3 then
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,1.0,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+-0.5)
    else
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.5)
	end
end)

function enableCam()
	local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)
	RenderScriptCams(false,false,0,1,0)
	DestroyCam(cam,false)

	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
		SetCamActive(cam,true)
		RenderScriptCams(true,false,0,true,true)
		SetCamCoord(cam,coords.x,coords.y,coords.z+0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId())+180)
	end

	if customCamLocation ~= nil then
		SetCamCoord(cam,customCamLocation.x,customCamLocation.y,customCamLocation.z)
	end
end

function disableCam()
	RenderScriptCams(false,true,250,1,0)
	DestroyCam(cam,false)
end

RegisterNUICallback("rotateRight",function()
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	SetEntityHeading(ped,heading+30)
end)

RegisterNUICallback("rotateLeft",function()
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	SetEntityHeading(ped,heading-30)
end)

RegisterNetEvent("clotheshop:apply",function(data)
    for k,v in pairs (data) do
        ChangeVariation(k,tonumber(v.item),tonumber(v.texture))
    end
end)