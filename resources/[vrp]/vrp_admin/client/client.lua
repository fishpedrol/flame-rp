local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local src = {}
--Tunnel.bindInterface("vrp_admin",src)
Tunnel.bindInterface(GetCurrentResourceName(),src)
vSERVER = Tunnel.getInterface("vrp_admin")

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEVTOOLS
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ RegisterNUICallback('dev_tools',function()
	vSERVER.ban()
end)
 ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- ZERAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('Flame:ZerarInv')
AddEventHandler('Flame:ZerarInv', function()
	TriggerServerEvent('clearInventory')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('adminClothes')
AddEventHandler('adminClothes',function(custom)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if custom[1] == -1 then
			SetPedComponentVariation(ped,1,0,0,2)
		else
			SetPedComponentVariation(ped,1,custom[1],custom[2],2)
		end

		if custom[3] == -1 then
			SetPedComponentVariation(ped,5,0,0,2)
		else
			SetPedComponentVariation(ped,5,custom[3],custom[4],2)
		end

		if custom[5] == -1 then
			SetPedComponentVariation(ped,7,0,0,2)
		else
			SetPedComponentVariation(ped,7,custom[5],custom[6],2)
		end

		if custom[7] == -1 then
			SetPedComponentVariation(ped,3,15,0,2)
		else
			SetPedComponentVariation(ped,3,custom[7],custom[8],2)
		end

		if custom[9] == -1 then
			if GetEntityModel(ped) == GetHashKey('mp_m_freemode_01') then
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey('mp_f_freemode_01') then
				SetPedComponentVariation(ped,4,15,0,2)
			end
		else
			SetPedComponentVariation(ped,4,custom[9],custom[10],2)
		end

		if custom[11] == -1 then
			SetPedComponentVariation(ped,8,15,0,2)
		else
			SetPedComponentVariation(ped,8,custom[11],custom[12],2)
		end

		if custom[13] == -1 then
			if GetEntityModel(ped) == GetHashKey('mp_m_freemode_01') then
				SetPedComponentVariation(ped,6,34,0,2)
			elseif GetEntityModel(ped) == GetHashKey('mp_f_freemode_01') then
				SetPedComponentVariation(ped,6,35,0,2)
			end
		else
			SetPedComponentVariation(ped,6,custom[13],custom[14],2)
		end

		if custom[15] == -1 then
			SetPedComponentVariation(ped,11,15,0,2)
		else
			SetPedComponentVariation(ped,11,custom[15],custom[16],2)
		end

		if custom[17] == -1 then
			SetPedComponentVariation(ped,9,0,0,2)
		else
			SetPedComponentVariation(ped,9,custom[17],custom[18],2)
		end

		if custom[19] == -1 then
			SetPedComponentVariation(ped,10,0,0,2)
		else
			SetPedComponentVariation(ped,10,custom[19],custom[20],2)
		end

		if custom[21] == -1 then
			ClearPedProp(ped,0)
		else
			SetPedPropIndex(ped,0,custom[21],custom[22],2)
		end

		if custom[23] == -1 then
			ClearPedProp(ped,1)
		else
			SetPedPropIndex(ped,1,custom[23],custom[24],2)
		end

		if custom[25] == -1 then
			ClearPedProp(ped,2)
		else
			SetPedPropIndex(ped,2,custom[25],custom[26],2)
		end

		if custom[27] == -1 then
			ClearPedProp(ped,6)
		else
			SetPedPropIndex(ped,6,custom[27],custom[28],2)
		end

		if custom[29] == -1 then
			ClearPedProp(ped,7)
		else
			SetPedPropIndex(ped,7,custom[29],custom[30],2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR NO CARRO TELEGUIADO 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('Flame:SetarDentroDocarro')
AddEventHandler('Flame:SetarDentroDocarro', function(nsource)
	local nplayer = GetPlayerFromServerId(nsource)
	local nped = GetPlayerPed(nplayer)
	local ncarro = GetVehiclePedIsUsing(nped)
	local ped = PlayerPedId()
	if ncarro then
		SetPedIntoVehicle(ped, ncarro, -2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELACINZA
-----------------------------------------------------------------------------------------------------------------------------------------
local locksound = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local ped = PlayerPedId()
        if GetEntityHealth(ped) <= 101 then
            alreadyDead = true
            StartScreenEffect('DeathFailOut', 0, 0)
            if not locksound then
                locksound = true
            end
            ShakeGameplayCam('DEATH_FAIL_IN_EFFECT_SHAKE', 1.0)

            local scaleform = RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')

            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(5) -- TODO 0
            end

            if HasScaleformMovieLoaded(scaleform) then
                Citizen.Wait(5) -- TODO 0

                Citizen.Wait(500)

                PlaySoundFrontend(-1, 'TextHit', 'WastedSounds', 1)
                while GetEntityHealth(PlayerPedId()) <= 101 do
                    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                    Citizen.Wait(5) -- TODO 0
                end

                StopScreenEffect('DeathFailOut')
                locksound = false
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
-----------------------------------------------------------------------------------------------------------------------------------------
function src.syncArea(x,y,z)
    ClearAreaOfVehicles(x,y,z,2000.0,false,false,false,false,false)
    ClearAreaOfEverything(x,y,z,2000.0,false,false,false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.applySkinAdmin(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        SetPlayerModel(PlayerId(),mhash)
        SetModelAsNoLongerNeeded(mhash)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEADING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("h",function(source,args)
    vRP.prompt("Heading:",GetEntityHeading(PlayerPedId()))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.vehicleHash(vehicle)
	vRP.prompt("Hash:",GetEntityModel(vehicle))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.spawnVeh(name)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		local ped = PlayerPedId()
		local nveh = CreateVehicle(mhash,GetEntityCoords(ped),GetEntityHeading(ped),true,false)

		NetworkRegisterEntityAsNetworked(nveh)
		while not NetworkGetEntityIsNetworked(nveh) do
			NetworkRegisterEntityAsNetworked(nveh)
			Citizen.Wait(1)
		end

		SetVehicleOnGroundProperly(nveh)
		SetVehicleAsNoLongerNeeded(nveh)
		SetVehicleIsStolen(nveh,false)
		SetPedIntoVehicle(ped,nveh,-1)
		SetVehicleNeedsToBeHotwired(nveh,false)
		SetEntityInvincible(nveh,false)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetVehRadioStation(nveh,"OFF")

		SetModelAsNoLongerNeeded(mhash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- efeitinhonoclip
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('efeitinholgbt')
AddEventHandler('efeitinholgbt',function()
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
    local particleDictionary = "scr_rcbarry2"
    local particleName = "scr_clown_death"
    RequestNamedPtfxAsset(particleDictionary)
    while not HasNamedPtfxAssetLoaded(particleDictionary) do
    Citizen.Wait(0)
    end
    SetPtfxAssetNextCall(particleDictionary)
    local effect = StartParticleFxLoopedOnPedBone("scr_clown_death",v,0.0,0.0,-0.6,0.0,0.0,20.0,GetPedBoneIndex(v,11816),2.0,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY 
-----------------------------------------------------------------------------------------------------------------------------------------
function src.tptoWay()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		ped = GetVehiclePedIsUsing(ped)
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped,x,y,height,1,0,0)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(ped) do
			Citizen.Wait(1)
		end

		Citizen.Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(ped,0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(ped) do
		Citizen.Wait(1)
	end

	SetEntityCoordsNoOffset(ped,x,y,z,1,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TROLLS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.makeFly()
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))

    SetEntityCoords(ped,x,y,z+1000)
	vRP.giveWeapons({["GADGET_PARACHUTE"] = { ammo = 1000 }})
end

function src.neyMar(ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
	SetPedToRagdollWithFall(PlayerPedId(),1500,2000,0,ForwardVector,1.0,0.0,0.0,0.0,0.0,0.0,0.0)
end

function src.ExplodirPessoa(x,y,z)
	AddExplosion(x,y,z, 6, 100.0, true, false, 5.0)
end

RegisterNetEvent('fall:FurarPneuTeleguiado')
AddEventHandler('fall:FurarPneuTeleguiado', function(roda)
	if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1)  == PlayerPedId() then
		SetVehicleTyreBurst(GetVehiclePedIsIn(PlayerPedId(), false), roda, true, 1000.0)
	end
end)

function src.SyncPneuFurado(veh,index)
	local carro = NetToVeh(veh)
	if veh and carro then
		SetVehicleTyreBurst(carro, index, true, 1000.0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncdeleteobj")
AddEventHandler("syncdeleteobj",function(index)
    if NetworkDoesNetworkIdExist(index) then
        local v = NetToEnt(index)
        if DoesEntityExist(v) then
            SetEntityAsMissionEntity(v,false,false)
            DeleteEntity(v)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
function src.vehicleTuning()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,0,GetNumVehicleMods(vehicle,0)-1,false)
		SetVehicleMod(vehicle,1,GetNumVehicleMods(vehicle,1)-1,false)
		SetVehicleMod(vehicle,2,GetNumVehicleMods(vehicle,2)-1,false)
		SetVehicleMod(vehicle,3,GetNumVehicleMods(vehicle,3)-1,false)
		SetVehicleMod(vehicle,4,GetNumVehicleMods(vehicle,4)-1,false)
		SetVehicleMod(vehicle,5,GetNumVehicleMods(vehicle,5)-1,false)
		SetVehicleMod(vehicle,6,GetNumVehicleMods(vehicle,6)-1,false)
		SetVehicleMod(vehicle,7,GetNumVehicleMods(vehicle,7)-1,false)
		SetVehicleMod(vehicle,8,GetNumVehicleMods(vehicle,8)-1,false)
		SetVehicleMod(vehicle,9,GetNumVehicleMods(vehicle,9)-1,false)
		SetVehicleMod(vehicle,10,GetNumVehicleMods(vehicle,10)-1,false)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,14,16,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-2,false)
		SetVehicleMod(vehicle,16,GetNumVehicleMods(vehicle,16)-1,false)
		ToggleVehicleMod(vehicle,17,true)
		ToggleVehicleMod(vehicle,18,true)
		ToggleVehicleMod(vehicle,19,true)
		ToggleVehicleMod(vehicle,20,true)
		ToggleVehicleMod(vehicle,21,true)
		ToggleVehicleMod(vehicle,22,true)
		SetVehicleMod(vehicle,24,1,false)
		SetVehicleMod(vehicle,25,GetNumVehicleMods(vehicle,25)-1,false)
		SetVehicleMod(vehicle,27,GetNumVehicleMods(vehicle,27)-1,false)
		SetVehicleMod(vehicle,28,GetNumVehicleMods(vehicle,28)-1,false)
		SetVehicleMod(vehicle,30,GetNumVehicleMods(vehicle,30)-1,false)
		SetVehicleMod(vehicle,34,GetNumVehicleMods(vehicle,34)-1,false)
		SetVehicleMod(vehicle,35,GetNumVehicleMods(vehicle,35)-1,false)
		SetVehicleMod(vehicle,38,GetNumVehicleMods(vehicle,38)-1,true)
        SetVehicleWindowTint(vehicle,1)
	end
end

function src.vehicleTuning2(vehicle)
	local ped = PlayerPedId()
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-1,false)
		ToggleVehicleMod(vehicle,18,true)
	end
end

------------------------------------------------------------------------------------------------------------------------------
-- COR FAROL
------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('fall:CorFarolCl')
AddEventHandler('fall:CorFarolCl',function(vehicle, cor)
	TriggerServerEvent("fall:SyncCorFarol",VehToNet(vehicle), cor)
end)

RegisterNetEvent("fall:SyncCorFarolCl")
AddEventHandler("fall:SyncCorFarolCl",function(index, cor)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				ToggleVehicleMod(v, 22, true)
				SetVehicleHeadlightsColour(v, cor)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINUPDATECOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admupdate',function(source, args, rawCmd)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,'suporte.permissao') then
        return 
    end

    serverSync()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('foguinho')
AddEventHandler('foguinho',function(source)
    local ped = PlayerPedId(-1)
    if not blutzadafire then
        blutzadafire = true
        Citizen.Wait(100)
        StartEntityFire(ped);
    else
        blutzadafire = false
        StopEntityFire(ped);
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source,args,rawCommand)
	vSERVER.noclipActive()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('bigar')
AddEventHandler('bigar',function()
	local ped = PlayerPedId()
    vRP._stopAnim(true)
    FreezeEntityPosition(ped,true)
    TriggerEvent("cancelando",true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESBIGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('desbigar')
AddEventHandler('desbigar',function()
	local ped = PlayerPedId()
    vRP._stopAnim(false)
    FreezeEntityPosition(ped,false)
    TriggerEvent("cancelando",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICAÇÃO /ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('startUi:MostrarNotAdm')
AddEventHandler('startUi:MostrarNotAdm', function (args)
	local title = args[1]
	local message = args[2]
	local type = args[3]
	SendNUIMessage({ action = 'sendNotification', title = title, message = message, type = type })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('fall:AdminSetPlaca')
AddEventHandler('fall:AdminSetPlaca', function(nveh, placa)
	SetVehicleNumberPlateText(nveh,placa)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINFUEL2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admfuel2")
AddEventHandler("admfuel2",function(fuel)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local fuel = fuel + 0.0
    SetVehicleFuelLevel(vehicle,fuel)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('admcuff')
AddEventHandler('admcuff',function()
	local ped = PlayerPedId()
	if vRP.isHandcuffed() then
		vRP._setHandcuffed(source,false)
		SetPedComponentVariation(PlayerPedId(),7,0,0,2)
	end
end)

local showMe = {}
RegisterNetEvent("vrp_showme:pressMe")
AddEventHandler("vrp_showme:pressMe",function(source,text,v)
	local pedSource = GetPlayerFromServerId(source)
	if pedSource ~= -1 then
		showMe[GetPlayerPed(pedSource)] = { text,v[1],v[2],v[3],v[4],v[5] }
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOWMEDISPLAY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(showMe) do
			local coordsMe = GetEntityCoords(k)
			local distance = #(coords - coordsMe)
			if distance <= 5 then
				timeDistance = 4
				if HasEntityClearLosToEntity(ped,k,17) then
					showMe3D(coordsMe.x,coordsMe.y,coordsMe.z+0.90,string.upper(v[1]),v[3],v[4],v[5],v[6])
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRHEADSHOWMETIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(showMe) do
			if v[2] > 0 then
				v[2] = v[2] - 1
				if v[2] <= 0 then
					showMe[k] = nil
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWME3D
-----------------------------------------------------------------------------------------------------------------------------------------
function showMe3D(x,y,z,text,h,back,color,opacity)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(color,color,color,opacity)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / h
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,back,back,back,150)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Jogadores = {}
local ModoAdminAtivado = false
local admdist = 1500
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local biguos = {}
local ModoDominas = false
local distanciaAdm = 1500 
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
function src.adminReset()
    players = {}
    ModoDominas = false
    print('Admin reseted')
end--------------------------------------------------------------------------------------------------------------------------------
-- UPDATELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateList(status)
    biguos = status
    --print('Player list has been synced')
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEAM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.ModoDominasAd()
    if ModoDominas then
        TriggerEvent('Notify', 'aviso','Modo dominas <b>desativado</b>.')
        ModoDominas = false
        return false
    else
        TriggerEvent('Notify', 'aviso','Modo dominas <b>ativado</b>.')
        ModoDominas = true
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AM : THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 5000
        if ModoDominas then
            timeDistance = 1
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            
            for k,v in pairs(GetActivePlayers()) do 
                local nsource = GetPlayerServerId(v)
                local nped = GetPlayerPed(v)
                local ncoords = GetEntityCoords(nped)
                if ped ~= nped then
                    if biguos[nsource] and biguos[nsource] ~= nil and nped and nped ~= nil then
                        if Vdist(coords,ncoords) <= distanciaAdm then
                            local data = biguos[nsource]
                            if GetEntityHealth(nped) <= 101 then
                                dwText(ncoords.x,ncoords.y,ncoords.z+0.85,"(~b~"..data.user_id.."~w~) "..data.name.." (~r~MORTO~w~)")
                            else
                                dwText(ncoords.x,ncoords.y,ncoords.z+0.85,"(~b~"..data.user_id.."~w~) "..data.name.." (~b~"..GetEntityHealth(nped).."~w~)")
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(timeDistance) 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function dwText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.3, 0.3)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 150)
        SetTextDropshadow()
        SetTextOutline()
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ZERAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('fall:ZerarArmas')
AddEventHandler('fall:ZerarArmas', function()
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR NO CARRO TELEGUIADO 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('fall:SetarDentroDocarro')
AddEventHandler('fall:SetarDentroDocarro', function(nsource)
	local nplayer = GetPlayerFromServerId(nsource)
	local nped = GetPlayerPed(nplayer)
	local ncarro = GetVehiclePedIsUsing(nped)
	local ped = PlayerPedId()
	if ncarro then
		SetPedIntoVehicle(ped, ncarro, -2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTRAR NO CARRO TELEGUIADO 2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('fall:SetarDentroDocarro2')
AddEventHandler('fall:SetarDentroDocarro2', function()
	local ped = PlayerPedId()
	local ncarro = vRP.getNearestVehicle(15)
	if IsVehicleSeatFree(ncarro, -1) then
		SetPedIntoVehicle(ped, ncarro, -1)
	else
		SetPedIntoVehicle(ped, ncarro, -2)
	end
end)

RegisterNetEvent('fall:VerCustom:MostrarCl')
AddEventHandler('fall:VerCustom:MostrarCl', function()
	local ped = PlayerPedId()
	local custom = {}
	custom[1] = { GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1) }
	custom[3] = { GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3) }
	custom[4] = { GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4) }
	custom[5] = { GetPedDrawableVariation(ped,5),GetPedTextureVariation(ped,5) }
	custom[6] = { GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6) }
	custom[7] = { GetPedDrawableVariation(ped,7),GetPedTextureVariation(ped,7) }
	custom[8] = { GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8) }
	custom[9] = { GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9) }
	custom[10] = { GetPedDrawableVariation(ped,10),GetPedTextureVariation(ped,10) }
	custom[11] = { GetPedDrawableVariation(ped,11),GetPedTextureVariation(ped,11) }
	custom["p0"] = { GetPedPropIndex(ped,0),math.max(GetPedPropTextureIndex(ped,0),0) }
	custom["p1"] = { GetPedPropIndex(ped,1),math.max(GetPedPropTextureIndex(ped,1),0) }
	custom["p2"] = { GetPedPropIndex(ped,2),math.max(GetPedPropTextureIndex(ped,2),0) }
	custom["p6"] = { GetPedPropIndex(ped,6),math.max(GetPedPropTextureIndex(ped,6),0) }
	custom["p7"] = { GetPedPropIndex(ped,7),math.max(GetPedPropTextureIndex(ped,7),0) }
	TriggerServerEvent('fall:VerCustom:Mostrar', custom) 
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VCOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('carroCor')
AddEventHandler('carroCor',function(vehicle, r, g, b)
	TriggerServerEvent("trycorveh",VehToNet(vehicle), r, g, b)
end)
RegisterNetEvent("synccorveh")
AddEventHandler("synccorveh",function(index, r, g, b)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				SetVehicleCustomPrimaryColour(v, r, g, b)
				SetVehicleCustomSecondaryColour(v, r, g, b)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PINTAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('pintarveiculo')
AddEventHandler('pintarveiculo',function(vehicle, tipo, valor)
	TriggerServerEvent("trypintarveh",VehToNet(vehicle), tipo, valor)
end)
RegisterNetEvent("syncpintarveh")
AddEventHandler("syncpintarveh",function(index, tipo, valor)
	Citizen.CreateThread(function()
		if NetworkDoesNetworkIdExist(index) then
			local v = NetToVeh(index)
			if DoesEntityExist(v) then
				SetVehicleModColor_1(v, tipo, valor, 0)
				SetVehicleModColor_2(v, tipo, valor)
			end
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPAR PLAYER - /marcar
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('fall:MarcarPlayer')
AddEventHandler('fall:MarcarPlayer',function(x,y,z,id)
	jogador = AddBlipForCoord(x,y,z)
	SetBlipSprite(jogador,126)
	SetBlipColour(jogador,43)
	SetBlipScale(jogador,0.4)
	SetBlipAsShortRange(jogador,false)
	SetBlipRoute(jogador,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("ID " .. id)
	EndTextCommandSetBlipName(jogador)
	Wait(60000)
	if jogador then
		RemoveBlip(jogador)
	end
end)

RegisterNetEvent('fall:rMarcarPlayer')
AddEventHandler('fall:rMarcarPlayer',function()
	RemoveBlip(jogador)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('fall:MarcarGps')
AddEventHandler('fall:MarcarGps', function (x,y)
	SetNewWaypoint(x+0.0001,y+0.0001)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("fall:RepararMotor")
AddEventHandler("fall:RepararMotor",function(vida)
    SetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), false), vida)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('fall:AdmAviso')
AddEventHandler('fall:AdmAviso',function(titulo, msg, tempo)
	Citizen.CreateThread(function()
        local scaleform =  RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
        while not HasScaleformMovieLoaded(scaleform) do Citizen.Wait(0) end
        BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
        PushScaleformMovieMethodParameterString(titulo)
        PushScaleformMovieMethodParameterString(msg)
        EndScaleformMovieMethod()
        PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS")

        while tempo > 0 do
            Citizen.Wait(1)
            tempo = tempo - 0.01

            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
        end

		SetScaleformMovieAsNoLongerNeeded(scaleform)
		
	end)
end)

local wasd = false
local drifttroll = false
function src.CheckWasd()
	wasd = not wasd
	return wasd
end

function src.CheckDrift()
	drifttroll = not drifttroll
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsIn(ped, false)
		SetVehicleReduceGrip(veh,drifttroll)
	end
	return drifttroll
end

Citizen.CreateThread(function() 
	while true do
		local ThreadDelay = 2000
		local ped = PlayerPedId()
		if drifttroll then
			ThreadDelay = 5
			if IsPedInAnyVehicle(ped, false) then
				local veh = GetVehiclePedIsIn(ped, false)
				SetVehicleReduceGrip(veh,true)
			end
		end

		if wasd then
			ThreadDelay = 5
			for i = 0, 357 do
				DisableControlAction(0, i, true)
			end
		end
		Citizen.Wait(ThreadDelay)
	end
end)


-------------------------------------------------------------------------------
-- COMPRA BANDAGEM  -----------------------------------------------------------
-------------------------------------------------------------------------------

local CdsBandagem = {
    {307.12,-594.97,43.29}
}

Citizen.CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        for k,v in pairs(CdsBandagem) do
            local distance = Vdist(x,y,z,v[1],v[2],v[3])
            if distance <= 20 then
                timeDistance = 4
                if distance <= 1.2 then
                    DrawText3D(v[1],v[2],v[3],"PRESSIONE  ~g~E~w~  PARA COMPRAR 10 BANDAGEM",255,255,255)
                    if IsControlJustPressed(0,38) then
                        src.FishComprar()
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)

function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.35, 0.35)
        SetTextColour(r, g, b, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 55, 55, 55, 68)
    end
end