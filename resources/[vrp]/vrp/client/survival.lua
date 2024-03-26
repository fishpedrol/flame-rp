-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getHealth()
	return GetEntityHealth(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setHealth(health)
	TriggerEvent('bl:ExcecaoVida')
	SetEntityHealth(PlayerPedId(),parseInt(health))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETFRIENDLYFIRE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setFriendlyFire(flag)
	NetworkSetFriendlyFireOption(flag)
	SetCanAttackFriendly(PlayerPedId(),flag,flag)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCAUTEVAR
-----------------------------------------------------------------------------------------------------------------------------------------
local nocauteado = false
local deathtimer = 300
local armasguardadas = false
local obito = false
local obitop = false
local police = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCAUTEADO
-----------------------------------------------------------------------------------------------------------------------------------------

function tvRP.CheckSegundosMorto()
	return deathtimer
end

function tvRP.SetSegundosMorto(seg)
	deathtimer = seg
end

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if GetEntityHealth(ped) <= 101 and deathtimer >= 0 then
			timeDistance = 4
			if not nocauteado then
				local x,y,z = table.unpack(GetEntityCoords(ped))
				NetworkResurrectLocalPlayer(x,y,z,true,true,false)
				deathtimer = 300
				nocauteado = true
				vRPserver._updateHealth(101)
				SetEntityHealth(ped,101)
				SetEntityInvincible(ped,true)
				if IsPedInAnyVehicle(ped) then
					TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
				end
				TriggerEvent("radio:outServers")
			else
				if deathtimer > 0 then
					drawTxt("VOCÊ TEM ~r~"..deathtimer.." ~w~SEGUNDOS DE VIDA, AGUARDE POR SOCORRO MÉDICO",4,0.5,0.93,0.50,255,255,255,255)
				else
					drawTxt("PRESSIONE ~g~E ~w~PARA IR AO HOSPITAL SUL",4,0.5,0.87,0.50,255,255,255,255)
					drawTxt("PRESSIONE ~b~H ~w~PARA IR AO HOSPITAL NORTE",4,0.5,0.90,0.50,255,255,255,255)
					drawTxt("PRESSIONE ~p~U ~w~PARA IR PARA A BASE",4,0.5,0.93,0.50,255,255,255,255)
					drawTxt("OU AGUARDE POR SOCORRO MÉDICO",4,0.5,0.96,0.50,255,255,255,255)

					if IsControlJustPressed(0,38) then -- E
						TriggerServerEvent('bl:Aeroporto:Server', 1)
						TriggerServerEvent('bl:GuardarArmasMorte')
					end

					if IsControlJustPressed(0,74) then -- H
						TriggerServerEvent('bl:Aeroporto:Server', 2)
						TriggerServerEvent('bl:GuardarArmasMorte')
					end

					if IsControlJustPressed(0,303) then -- u
						TriggerServerEvent('bl:Aeroporto:Client2', source)
						TriggerServerEvent('bl:GuardarArmasMorte')
						TriggerServerEvent('bl:nascerbase')
						DoScreenFadeOut(1000)
						SetEntityHealth(ped,398)
						SetTimeout(5000,function()
							Citizen.Wait(1000)
							tvRP.killGod(ped)
							SetEntityHealth(ped,398)
							DoScreenFadeIn(1000)					
						end)
					end

				end
			--	SetFollowPedCamViewMode(4)
				SetEntityHealth(ped,101)
				BlockWeaponWheelThisFrame()
				DisablePlayerFiring(PlayerId(),true)
				DisableControlAction(0,21,true)
				DisableControlAction(0,22,true)
				DisableControlAction(0,23,true)
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true)
				DisableControlAction(0,29,true)
				DisableControlAction(0,32,true)
				DisableControlAction(0,33,true)
				DisableControlAction(0,34,true)
				DisableControlAction(0,35,true)
				DisableControlAction(0,47,true)
				DisableControlAction(0,56,true)
				DisableControlAction(0,58,true)
				DisableControlAction(0,73,true)
				DisableControlAction(0,75,true)
				DisableControlAction(0,137,true)
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
				DisableControlAction(0,143,true)
				DisableControlAction(0,166,true)
				DisableControlAction(0,167,true)
				DisableControlAction(0,168,true)
				DisableControlAction(0,169,true)
				DisableControlAction(0,170,true)
				DisableControlAction(0,177,true)
				DisableControlAction(0,182,true)
				DisableControlAction(0,187,true)
				DisableControlAction(0,188,true)
				DisableControlAction(0,189,true)
				DisableControlAction(0,190,true)
				DisableControlAction(0,243,true)
				--DisableControlAction(0,245,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,263,true)
				DisableControlAction(0,264,true)
				DisableControlAction(0,268,true)
				DisableControlAction(0,269,true)
				DisableControlAction(0,270,true)
				DisableControlAction(0,271,true)
				DisableControlAction(0,288,true)
				DisableControlAction(0,289,true)
				DisableControlAction(0,311,true)
				DisableControlAction(0,344,true)
				-- if not IsEntityPlayingAnim(ped,"misslamar1dead_body", "dead_idle",3) then
					-- tvRP.playAnim(false,{{"misslamar1dead_body", "dead_idle"}},true)
				-- end
				SetPedToRagdoll(ped,2000,2000,0,0,0,0)
			end
		end
		
		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ local NaoRespawn = false
RegisterNetEvent('bgd:NaoRespawn')
AddEventHandler('bgd:NaoRespawn', function(status)
	NaoRespawn = status
end) ]]

function tvRP.AeroportoClient(lugar, policialSul)
	local ped = PlayerPedId()

	TriggerEvent('bl:ExcecaoTp')
	TriggerEvent('bl:ExcecaoVida')
	TriggerEvent("resetBleeding")
	TriggerEvent("resetDiagnostic")
	deathtimer = 300
	nocauteado = false
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	DoScreenFadeOut(1000)
	SetEntityHealth(ped,395)
	Citizen.Wait(1000)
	
	if lugar == 1 then
		if policialSul then
			SetEntityCoords(ped,638.02,-3.18,82.79,1,0,0,1)
		else
			SetEntityCoords(ped,342.98,-1397.93,32.51,1,0,0,1)
		end
	else
		SetEntityCoords(ped,1819.52,3689.76,34.23,1,0,0,1)
	end
	FreezeEntityPosition(ped,true)
	SetTimeout(5000,function()
		SetEntityHealth(ped,395)
		FreezeEntityPosition(ped,false)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
	end)
end

--[[RegisterNetEvent('bl:Aeroporto:Client')
AddEventHandler('bl:Aeroporto:Client', function(lugar,policialSul)
	local ped = PlayerPedId()

	TriggerEvent('bl:ExcecaoTp')
	TriggerEvent('bl:ExcecaoVida')
	TriggerEvent("resetBleeding")
	TriggerEvent("resetDiagnostic")
	deathtimer = 1000
	nocauteado = false
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	DoScreenFadeOut(1000)
	SetEntityHealth(ped,395)
	Citizen.Wait(1000)
	
	if lugar == 1 then
		if policialSul then
			SetEntityCoords(ped,605.2,-8.83,82.75,1,0,0,1)
		else
			SetEntityCoords(ped,342.98,-1397.93,32.51,1,0,0,1)
		end
	else
		SetEntityCoords(ped,1819.18,3664.06,34.28,1,0,0,1)
	end
	FreezeEntityPosition(ped,true)
	SetTimeout(5000,function()
		SetEntityHealth(ped,395)
		FreezeEntityPosition(ped,false)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
	end)
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		Citizen.Wait(100)
	end
end)

RegisterNetEvent("toogle:police")
AddEventHandler("toogle:police", function(status)
    police = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ DEATHTIMER ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if nocauteado and deathtimer > 0 then
			deathtimer = deathtimer - 1
		end
		if obito and deathtimer > 0 then
			deathtimer = 5
			obito = false
		end
		if police and deathtimer > 91 then
			deathtimer = 90
			obitop = false
		end
	end
end)

function tvRP.AeroportoClient2()
	local ped = PlayerPedId()
	TriggerEvent('bl:ExcecaoTp')
	TriggerEvent('bl:ExcecaoVida')
	TriggerEvent("resetBleeding")
	TriggerEvent("resetDiagnostic")
	deathtimer = 300
	nocauteado = false
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	DoScreenFadeOut(1000)
	SetEntityHealth(ped,398)
	Citizen.Wait(1000)
	FreezeEntityPosition(ped,true)
	SetTimeout(5000,function()
		SetEntityHealth(ped,398)
		FreezeEntityPosition(ped,false)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISINCOMA
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.isInComa()
	return nocauteado
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NETWORKRESSURECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.killGod()
	armasguardadas = false
	nocauteado = false
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	NetworkResurrectLocalPlayer(x,y,z,true,true,false)
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	SetEntityHealth(ped,102)
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NETWORKPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PrisionGod()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		nocauteado = false
		ClearPedBloodDamage(ped)
		SetEntityInvincible(ped,false)
		SetEntityHealth(ped,201)
		ClearPedTasks(ped)
		ClearPedSecondaryTask(ped)
	end
end