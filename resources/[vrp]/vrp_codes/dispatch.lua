-----------------------------------------------------------------------------------------------------------------------------------------
-- DENSITY NPCS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
			
    	SetVehicleDensityMultiplierThisFrame(0.0)
		SetPedDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		
		local playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed) 
		RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
    	
		Citizen.Wait(1)
	end

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,120 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TANK HS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Wait(4)

        SetPedSuffersCriticalHits(PlayerPedId(-1), true)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STAMINA INFINITA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        RestorePlayerStamina(PlayerId(), 1.0)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local RusherSleep = 1000
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsPedInAnyVehicle(ped) then
			local speed = GetEntitySpeed(vehicle)*3.6
			if GetPedInVehicleSeat(vehicle,-1) == ped 
				and (GetEntityModel(vehicle) ~= GetHashKey("coach") 
					and GetEntityModel(vehicle) ~= GetHashKey("bus") 
					and GetEntityModel(vehicle) ~= GetHashKey("taxi") 
					and GetEntityModel(vehicle) ~= GetHashKey("boxville4") 
					and GetEntityModel(vehicle) ~= GetHashKey("trash2") 
					and GetEntityModel(vehicle) ~= GetHashKey("rebel")    
					and GetEntityModel(vehicle) ~= GetHashKey("paramedicoambu")) then
					RusherSleep = 100
					if speed <= 100.0 then
					if IsControlPressed(1,21) then
						SetVehicleReduceGrip(vehicle,true)
					else
						SetVehicleReduceGrip(vehicle,false)
					end
				end    
			end
		end
		Citizen.Wait(RusherSleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR X NA MOTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if (GetPedInVehicleSeat(vehicle, -1) == ped or GetPedInVehicleSeat(vehicle, 0) == ped) and GetVehicleClass(vehicle) == 8 then
                timeDistance = 4
                DisableControlAction(0, 345, true)
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR A CORONHADA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = PlayerPedId()
        if IsPedArmed(ped,6) then
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR AUTO-CAPACETE NA MOTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
	while true do
		Citizen.Wait(5)  
		local veh = GetVehiclePedIsUsing(PlayerPedId())
		if veh ~= 0 then 
			SetPedConfigFlag(PlayerPedId(),35,false) 
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESABILITAR O Q
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        if health >= 101 then
        	DisableControlAction(0,44,true)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO 
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local ORTiming = 500
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            -- BLOQUEIA QUALQUER ARMA DE ATIRAR
            SetPlayerCanDoDriveBy(PlayerId(),false)

            local vehicle = GetVehiclePedIsIn(ped)
            local speed = GetEntitySpeed(vehicle)*3.6

            -- CONDIÇÃO P2
            if GetPedInVehicleSeat(vehicle,0) == ped then
                if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_STUNGUN") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") then
                    SetPlayerCanDoDriveBy(PlayerId(),true)
                end
            elseif GetPedInVehicleSeat(vehicle,-1) == ped then
                if speed <= 0 then
				ORTiming = 4
                    if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_STUNGUN") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") then
                        SetPlayerCanDoDriveBy(PlayerId(),true)
                    end
                end
            else
                if IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("as350")) then
                    SetPlayerCanDoDriveBy(PlayerId(),true)
                end
            end
        end
		Citizen.Wait(ORTiming)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLDOWN BUNNYHOP
-----------------------------------------------------------------------------------------------------------------------------------------
local bunnyhop = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if bunnyhop > 0 then
            bunnyhop = bunnyhop - 5
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedJumping(ped) and bunnyhop <= 0 then
            bunnyhop = 5
        end
        if bunnyhop > 0 then
            DisableControlAction(0,22,true)
        end
        Citizen.Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------

local blips = {

	{ 265.05,-1262.65,29.3,361,41,"Posto de Gasolina",0.4 },
	{ 819.02,-1027.96,26.41,361,41,"Posto de Gasolina",0.4 },
	{ 1208.61,-1402.43,35.23,361,41,"Posto de Gasolina",0.4 },
	{ 1181.48,-330.26,69.32,361,41,"Posto de Gasolina",0.4 },
	{ 621.01,268.68,103.09,361,41,"Posto de Gasolina",0.4 },
	{ 2581.09,361.79,108.47,361,41,"Posto de Gasolina",0.4 },
	{ 175.08,-1562.12,29.27,361,41,"Posto de Gasolina",0.4 },
	{ -319.76,-1471.63,30.55,361,41,"Posto de Gasolina",0.4 },
	{ 1782.33,3328.46,41.26,361,41,"Posto de Gasolina",0.4 },
	{ 49.42,2778.8,58.05,361,41,"Posto de Gasolina",0.4 },
	{ 264.09,2606.56,44.99,361,41,"Posto de Gasolina",0.4 },
	{ 1039.38,2671.28,39.56,361,41,"Posto de Gasolina",0.4 },
	{ 1207.4,2659.93,37.9,361,41,"Posto de Gasolina",0.4 },
	{ 2539.19,2594.47,37.95,361,41,"Posto de Gasolina",0.4 },
	{ 2679.95,3264.18,55.25,361,41,"Posto de Gasolina",0.4 },
	{ 2005.03,3774.43,32.41,361,41,"Posto de Gasolina",0.4 },
	{ 1687.07,4929.53,42.08,361,41,"Posto de Gasolina",0.4 },
	{ 1701.53,6415.99,32.77,361,41,"Posto de Gasolina",0.4 },
	{ 180.1,6602.88,31.87,361,41,"Posto de Gasolina",0.4 },
	{ -94.46,6419.59,31.48,361,41,"Posto de Gasolina",0.4 },
	{ -2555.17,2334.23,33.08,361,41,"Posto de Gasolina",0.4 },
	{ -1800.09,803.54,138.72,361,41,"Posto de Gasolina",0.4 },
	{ -1437.0,-276.8,46.21,361,41,"Posto de Gasolina",0.4 },
	{ -2096.3,-320.17,13.17,361,41,"Posto de Gasolina",0.4 },
	{ -724.56,-935.97,19.22,361,41,"Posto de Gasolina",0.4 },
	{ -525.26,-1211.19,18.19,361,41,"Posto de Gasolina",0.4 },
	{ -70.96,-1762.21,29.54,361,41,"Posto de Gasolina",0.4 },

	{ -209.0,-1322.56,30.9,402,17,"Bennys",0.6 },

	{ 317.25,2623.14,44.46,50,4,"Garagem",0.4 },
	{ -773.34,5598.15,33.60,50,4,"Garagem",0.4 },
	{ 596.40,90.65,93.12,50,4,"Garagem",0.4 },
	{ -340.76,265.97,85.67,50,4,"Garagem",0.4 },
	{ -2030.01,-465.97,11.60,50,4,"Garagem",0.4 },
	{ -1184.92,-1510.00,4.64,50,4,"Garagem",0.4 },
	{ -73.44,-2004.99,18.27,50,4,"Garagem",0.4 },
	{ -348.88,-874.02,31.31,50,4,"Garagem",0.4 },
	{ 67.74,12.27,69.21,50,4,"Garagem",0.4 },
	{ 361.90,297.81,103.88,50,4,"Garagem",0.4 },
	{ 1156.90,-453.73,66.98,50,4,"Garagem",0.4 },
	{ -102.21,6345.18,31.57,50,4,"Garagem",0.4 },
	{ 1300.95,4319.0,38.18,50,4,"Garagem",0.4 },

	{ 4519.84,-4515.06,4.5,50,4,"Garagem",0.4 },
	{ 5099.9,-5721.52,15.78,50,4,"Garagem",0.4 },

	{ 605.4,-1.07,82.75,526,1,"Department Police Flame",0.4 },
	{ -440.37,6020.18,31.5,526,1,"Department Police Flame",0.4 },
	{ 1858.82,3678.83,33.71,526,1,"Department Police Flame",0.4 },
	{ 25.65,-1346.58,29.49,52,4,"Mercado",0.4 },
	{ 2556.75,382.01,108.62,52,4,"Mercado",0.4 },
	{ 1163.54,-323.04,69.20,52,4,"Mercado",0.4 },
	{ -707.37,-913.68,19.21,52,4,"Mercado",0.4 },
	{ -47.73,-1757.25,29.42,52,4,"Mercado",0.4 },
	{ 373.90,326.91,103.56,52,4,"Mercado",0.4 },
	{ -3243.10,1001.23,12.83,52,4,"Mercado",0.4 },
	{ 1729.38,6415.54,35.03,52,4,"Mercado",0.4 },
	{ 547.90,2670.36,42.15,52,4,"Mercado",0.4 },
	{ 1960.75,3741.33,32.34,52,4,"Mercado",0.4 },
	{ 2677.90,3280.88,55.24,52,4,"Mercado",0.4 },
	{ 1698.45,4924.15,42.06,52,4,"Mercado",0.4 },
	{ -1820.93,793.18,138.11,52,4,"Mercado",0.4 },
	{ 1392.46,3604.95,34.98,52,4,"Mercado",0.4 },
	{ -3040.10,585.44,7.90,52,4,"Mercado",0.4 },

	{ 4972.73,-5598.54,23.71,52,4,"Mercado",0.4 },
	{ 4958.71,-4471.97,10.66,52,4,"Mercado",0.4 },

	{ -1222.78,-907.22,12.32,93,27,"Loja de Bebidas",0.4 },
	{ -2967.82,390.93,15.04,93,27,"Loja de Bebidas",0.4 },
	{ 1165.91,2709.41,38.15,93,27,"Loja de Bebidas",0.4 },
	{ 1135.56,-982.20,46.41,93,27,"Loja de Bebidas",0.4 },
	{ -1487.18,-379.02,40.16,93,27,"Loja de Bebidas",0.4 },
	{ -560.17,286.79,82.17,93,4,"Bar",0.4 },
	{ 128.11,-1284.99,29.27,93,4,"Bar",0.4 },
	{ 1985.80,3053.68,47.21,93,4,"Bar",0.4 },
	{ -80.89,214.78,96.55,93,4,"Bar",0.4 },
	{ 224.60,-1511.02,29.29,93,4,"Bar",0.4 },
	{ -1387.82,-587.80,30.31,121,48,"Bahamas",0.4 },
	{ 296.16,-583.79,43.15,51,49,"Hospital",0.4 },
	{ 1830.12,3662.13,33.84,51,49,"Hospital",0.4 },
	{ 75.40,-1392.92,29.37,73,4,"Loja de Roupas",0.4 },
	{ -709.40,-153.66,37.41,73,4,"Loja de Roupas",0.4 },
	{ -163.20,-302.03,39.73,73,4,"Loja de Roupas",0.4 },
	{ 425.58,-806.23,29.49,73,4,"Loja de Roupas",0.4 },
	{ -822.34,-1073.49,11.32,73,4,"Loja de Roupas",0.4 },
	{ -1193.81,-768.49,17.31,73,4,"Loja de Roupas",0.4 },
	{ -1450.85,-238.15,49.81,73,4,"Loja de Roupas",0.4 },
	{ 4.90,6512.47,31.87,73,4,"Loja de Roupas",0.4 },
	{ 1693.95,4822.67,42.06,73,4,"Loja de Roupas",0.4 },
	{ 126.05,-223.10,54.55,73,4,"Loja de Roupas",0.4 },
	{ 614.26,2761.91,42.08,73,4,"Loja de Roupas",0.4 },
	{ 1196.74,2710.21,38.22,73,4,"Loja de Roupas",0.4 },
	{ -3170.18,1044.54,20.86,73,4,"Loja de Roupas",0.4 },
	{ -1101.46,2710.57,19.10,73,4,"Loja de Roupas",0.4 },
	{ 1692.62,3759.50,34.70,76,4,"Ammunation",0.4 },
	{ 252.89,-49.25,69.94,76,4,"Ammunation",0.4 },
	{ 843.28,-1034.02,28.19,76,4,"Ammunation",0.4 },
	{ -331.35,6083.45,31.45,76,4,"Ammunation",0.4 },
	{ -663.15,-934.92,21.82,76,4,"Ammunation",0.4 },
	{ -1305.18,-393.48,36.69,76,4,"Ammunation",0.4 },
	{ -1118.80,2698.22,18.55,76,4,"Ammunation",0.4 },
	{ 2568.83,293.89,108.73,76,4,"Ammunation",0.4 },
	{ -3172.68,1087.10,20.83,76,4,"Ammunation",0.4 },
	{ 21.32,-1106.44,29.79,76,4,"Ammunation",0.4 },
	{ 811.19,-2157.67,29.61,76,4,"Ammunation",0.4 },
	{ -815.59,-182.16,37.56,71,4,"Barbeiro",0.4 },
	{ 139.21,-1708.96,29.30,71,4,"Barbeiro",0.4 },
	{ -1282.00,-1118.86,7.00,71,4,"Barbeiro",0.4 },
	{ 1934.11,3730.73,32.85,71,4,"Barbeiro",0.4 },
	{ 1211.07,-475.00,66.21,71,4,"Barbeiro",0.4 },
	{ -34.97,-150.90,57.08,71,4,"Barbeiro",0.4 },
	{ -280.37,6227.01,31.70,71,4,"Barbeiro",0.4 },
	{ -1213.44,-331.02,37.78,207,82,"Banco",0.4 },
	{ -351.59,-49.68,49.04,207,82,"Banco",0.4 },
	{ 235.12,216.84,106.28,207,82,"Banco",0.4 },
	{ 313.47,-278.81,54.17,207,82,"Banco",0.4 },
	{ 149.35,-1040.53,29.37,207,82,"Banco",0.4 },
	{ -2962.60,482.17,15.70,207,82,"Banco",0.4 },
	{ -112.81,6469.91,31.62,207,82,"Banco",0.4 },
	{ 1175.74,2706.80,38.09,207,82,"Banco",0.4 },
	{ 1322.64,-1651.97,52.27,75,48,"Estúdio de Tatuagem",0.4 },
	{ -1153.67,-1425.68,4.95,75,48,"Estúdio de Tatuagem",0.4 },
	{ 322.13,180.46,103.58,75,48,"Estúdio de Tatuagem",0.4 },
	{ -3170.07,1075.05,20.82,75,48,"Estúdio de Tatuagem",0.4 },
	{ 1864.63,3747.73,33.03,75,48,"Estúdio de Tatuagem",0.4 },
	{ -293.71,6200.04,31.48,75,48,"Estúdio de Tatuagem",0.4 },
	{ -1612.35,-1180.02,0.31,266,4,"Pier",0.4 },
	{ -1522.91,1501.84,110.65,266,4,"Pier",0.4 },
	{ 1336.21,4278.94,31.05,266,4,"Pier",0.4 },
	{ -183.69,795.89,197.35,266,4,"Pier",0.4 },

	{ 5095.68,-4655.92,1.74,266,4,"Pier",0.4 },
	{ 5153.45,-4656.01,1.44,266,4,"Pier",0.4 },

	{ -48.5,-1112.74,26.44,225,1,"Flame Import's",0.4 },
	{ 946.68,-990.2,39.24,402,1,"Mecânica",0.5 },
	{ 118.94,6616.97,31.84,402,1,"Mecânica",0.5 },
	{ 1178.76,2651.47,37.81,402,1,"Mecânica",0.5 },
	{ -560.47, 280.83, 82.19, 522,1,"Emprego | Pizza",0.5 },
	{ 453.55,-607.58,28.58, 513,1,"Emprego | Ônibus",0.5 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip,v[4])
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v[5])
		SetBlipScale(blip,v[7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v[6])
		EndTextCommandSetBlipName(blip)
	end
end)

local Robberys = {
	{ 1197.05,-3253.15,7.1,431,17,"Ação | Departamento de Cargas",0.5 },
	{ -424.11,-2789.91,6.54,431,17,"Ação | Mini Porto",0.5 },
	{ 185.39,1214.0,225.6,431,17,"Ação | Auditório",0.5 },
	{ 1019.17,-2511.71,28.49,431,17,"Ação | Cypress",0.5 },
	{ -1537.11,130.73,57.38,431,17,"Ação | Mansão Playboy",0.5 },
	{ -99.98,-2232.12,7.8,431,17,"Ação | Caixa d'Água",0.5 },
	{ 589.07,-468.36,24.75,431,17,"Ação | Galpão",0.5 },
	{ -450.93,6011.42,31.72,431,17,"Ação | Delegacia Paleto Bay",0.5 },
	{ 1850.07,3686.02,34.27,431,17,"Ação | Delegacia Sandy Shores",0.5 },
	{ 1459.31,1133.82,114.33,431,17,"Ação | Fazenda",0.5 },
	{ 2403.64,3127.98,48.16,431,17,"Ação | Aeroporto Abandonado",0.5 },
	{ 802.84,2174.88,53.08,431,17,"Ação | Mini Fazenda",0.5 },
	{ 849.26,2383.68,54.16,431,17,"Ação | Motocross",0.5 },
	{ 2424.68,4961.18,46.21,431,17,"Ação | Fazenda Norte",0.5 },
	{ 670.95,580.21,130.46,431,17,"Ação | Observatório",0.5 },
	{ 66.49,3726.72,39.72,431,17,"Ação | Motoclub Norte",0.5 },
	{ -1116.61,-502.28,35.8,431,17,"Ação | Teatro",0.5 },
	{ 247.57,-3315.71,5.8,431,17,"Ação | Porto",0.5 },
	{ -2194.94,4289.03,49.18,431,17,"Ação | Bar Hookies",0.5 },
	{ 1219.73,333.55,82.0,431,17,"Ação | Estábulo",0.5 },
	{ 442.92,-978.1,30.69,431,17,"Ação | Delegacia Praça",0.5 },
	{ 181.75,2780.29,45.71,431,17,"Ação | Shipping Ser  vices",0.5 },
	{ -429.64,1109.46,327.69,431,17,"Ação | Palácio",0.5 },
	{ 1508.36,3560.86,35.32,431,17,"Ação | Motel",0.5 },
	{ 1308.91,4362.3,41.55,431,17,"Ação | Milliars Boat",0.5 },
	{ -1668.05,190.06,61.75,431,17,"Ação | Universidade",0.5 },
	{ -244.23,-2028.85,29.95,431,17,"Ação | Estádio",0.5 },
	{ 2336.31,2566.99,47.75,431,17,"Ação | Trailer Magic",0.5 },
	{ 1093.02,-2251.45,31.24,431,17,"Ação | Parking Bilgeco",0.5 },
	{ 287.77,2843.78,44.71,431,17,"Ação | Fábrica",0.5 },
	{ -2299.71,336.85,174.61,431,17,"Ação | Faculdade",0.5 },
	{ 1395.3,3614.04,34.99,431,17,"Ação | Liquors Ace",0.5 },
	{ -424.57,284.07,83.2,431,17,"Ação | Comedy Club",0.5 },
	{ -1886.54,2050.09,140.99,431,17,"Ação | Vinhedo",0.5 },
	{ -2953.28,49.24,11.61,431,17,"Ação | Resort",0.5 },
	{ 445.12,-222.64,56.02,431,17,"Ação | Clube de Tênis",0.5 },

}
local blips = {}
local roubos = false
RegisterCommand("roubos",function(source,args)
	roubos = not roubos

	if roubos then
		TriggerEvent("Notify","sucesso","Adicionado a marcacao das ações.",3000)
		for k,v in pairs(Robberys) do
			blips[k] = AddBlipForCoord(v[1],v[2],v[3])
			SetBlipSprite(blips[k],v[4])
			SetBlipColour(blips[k],v[5])
			SetBlipScale(blips[k],v[7])
			SetBlipAsShortRange(blips[k],true)
			BeginTextCommandSetBlipName("STRING")
		    AddTextComponentString(v[6])
		    EndTextCommandSetBlipName(blips[k])
		end
	else
		TriggerEvent("Notify","aviso","Removido a marcacao das ações.",3000)
		for k,v in pairs(blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end
		blips = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESATIVA O ROUBO DO VEÍCULO SEGURANDO F [ CAR JACKING ]
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
    local timeDistance = 500
    local ped = PlayerPedId()
	if IsPedJacking(ped) then
		timeDistance = 4
      local veh = GetVehiclePedIsIn(ped)
      SetPedIntoVehicle(ped, veh, 0)
      ClearPedTasks(ped)
		end
		Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function dwText(text,height)
	SetTextFont(4)
	SetTextScale(0.50,0.50)
	SetTextColour(255,255,255,180)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.5,height)
end