-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("fsh_farm")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDENADAS
-----------------------------------------------------------------------------------------------------------------------------------------
local Coordenadas = {
	{ -1381.97,-632.74,30.82}, -- ROUTE 
	{-1051.92, -233.07, 44.03}, -- ROUTE LIFE INVADER 
	{-569.24, 227.62, 74.9}, -- ROUTE LEGITZ
	{-233.96, -1317.59, 30.89}, -- ROUTE MECANICA
    {724.29, -1071.67, 23.13}, -- ROUTE DK
    {-1139.83, -2005.6, 13.19}, -- ROUTE NATIVE
	{1272.33,-1711.65,54.77}, -- ROUTE CRIPS
	{-1079.79,-1679.49,4.58}, -- ROUTE BLOODS
	{-140.97, 302.32, 98.48}, -- ROUTE SCRIPTED
	{-1493.1,843.66,181.6}, -- ROUTE Yardie
	{1071.01,-2006.23,32.09}, -- ROUTE Russkaya 
	{-1876.15, 2062.61, 145.58} -- ROUTE CARTEL 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIO/FIM
-----------------------------------------------------------------------------------------------------------------------------------------
local inicio = 0
local fim = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIZACAO 
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
    [1] = {['x'] = -1327.99, ['y'] = -1173.17, ['z'] = 4.54}, -- ROTA BLOODS (MARQUES)
    [2] = {['x'] = -1382.77, ['y'] = -858.84, ['z'] = 15.7},
    [3] = {['x'] = -1199.98, ['y'] = -652.67, ['z'] = 23.09},
    [4] = {['x'] = -430.39, ['y'] = -24.1, ['z'] = 46.23},
    [5] = {['x'] = 301.59, ['y'] = -883.4, ['z'] = 29.29},
    [6] = {['x'] = 68.21, ['y'] = -1399.15, ['z'] = 29.38},
    [7] = {['x'] = -450.24, ['y'] = -793.81, ['z'] = 30.67},
    [8] = {['x'] = -742.02, ['y'] = -206.46, ['z'] = 37.28},
    [9] = {['x'] = -737.82, ['y'] = 189.74, ['z'] = 73.92},
    [10] = {['x'] = -1273.87, ['y'] = 316.03, ['z'] = 65.52},
    [11] = {['x'] = -1652.76, ['y'] = -372.04, ['z'] = 45.33},
    [12] = {['x'] = -1477.23, ['y'] = -674.46, ['z'] = 29.05},
    [13] = {['x'] = -777.75, ['y'] = -1049.49, ['z'] = 12.99},
    [14] = {['x'] = -169.19, ['y'] = -1026.98, ['z'] = 27.29},
    [15] = {['x'] = 196.81, ['y'] = -162.69, ['z'] = 56.61},
    [16] = {['x'] = 704.91, ['y'] = -303.63, ['z'] = 59.25},
    [17] = {['x'] = 456.34, ['y'] = -1062.01, ['z'] = 29.49},
    [18] = {['x'] = 474.13, ['y'] = -1718.76, ['z'] = 29.33},
    [19] = {['x'] = -296.07, ['y'] = -1353.2, ['z'] = 31.32},
    [20] = {['x'] = -647.07, ['y'] = -1148.38, ['z'] = 9.62},
    --  =============================================================================================--
    [21] = {['x'] = -428.33, ['y'] = -454.6, ['z'] = 32.53}, -- ROTA LIFE
    [22] = {['x'] = -505.67, ['y'] = -43.0, ['z'] = 44.52},
    [23] = {['x'] = -175.54, ['y'] = -9.97, ['z'] = 58.22},
    [24] = {['x'] = -28.94, ['y'] = -234.05, ['z'] = 46.3},
    [25] = {['x'] = -263.28, ['y'] = -904.31, ['z'] = 32.32},
    [26] = {['x'] = -501.33, ['y'] = -693.65, ['z'] = 33.22},
    [27] = {['x'] = -239.05, ['y'] = -1397.87, ['z'] = 31.29},
    [28] = {['x'] = 934.37, ['y'] = -1908.19, ['z'] = 31.13},
    [29] = {['x'] = 549.89, ['y'] = 122.04, ['z'] = 98.43},
    [30] = {['x'] = -41.52, ['y'] = -181.61, ['z'] = 54.28},
    [31] = {['x'] = -635.68, ['y'] = 44.05, ['z'] = 42.7},
    [32] = {['x'] = -604.05, ['y'] = -783.39, ['z'] = 25.41},
    [33] = {['x'] = 305.84, ['y'] = -1348.78, ['z'] = 31.97},
    [34] = {['x'] = 322.34, ['y'] = -940.19, ['z'] = 29.4},
    [35] = {['x'] = 332.74, ['y'] = -180.72, ['z'] = 58.18},
    [36] = {['x'] = 649.73, ['y'] = 246.56, ['z'] = 103.43},
    [37] = {['x'] = -1296.49, ['y'] = -664.09, ['z'] = 26.31}, 
    [38] = {['x'] = -1391.67, ['y'] = -732.29, ['z'] = 24.7}, 
    [39] = {['x'] = -1696.92, ['y'] = -422.2, ['z'] = 46.03}, 
    --====================================================================================================--
	  --====================================================================================================--
	  [40] = {['x'] = 151.61, ['y'] = -1478.3, ['z'] = 29.36}, -- ROTA aztecas
	  [41] = {['x'] = 978.05, ['y'] = -1488.21, ['z'] = 31.45},
	  [42] = {['x'] = 808.5, ['y'] = -1631.38, ['z'] = 31.17},
	  [43] = {['x'] = 850.31, ['y'] = -1995.61, ['z'] = 29.99},
	  [44] = {['x'] = 739.36, ['y'] = -970.23, ['z'] = 24.62},
	  [45] = {['x'] = 758.89, ['y'] = -909.36, ['z'] = 25.44},
	  [46] = {['x'] = 1178.87, ['y'] = -1464.05, ['z'] = 34.96},
	  [47] = {['x'] = 746.54, ['y'] = -1399.39, ['z'] = 26.63},
	  [48] = {['x'] = 1383.8, ['y'] = -2079.05, ['z'] = 52.01},
	  [49] = {['x'] = 1338.39, ['y'] = -1524.24, ['z'] = 54.59},
	  [50] = {['x'] = 1389.51, ['y'] = -1545.73, ['z'] = 56.71},
	  [51] = {['x'] = 1270.97, ['y'] = -683.13, ['z'] = 66.04},
	  [52] = {['x'] = 1121.13, ['y'] = -645.45, ['z'] = 56.82},
	  [53] = {['x'] = 919.63, ['y'] = -569.56, ['z'] = 58.37},
	  [54] = {['x'] = 1054.05, ['y'] = -1952.79, ['z'] = 32.1},
	  [55] = {['x'] = 1043.56, ['y'] = -2158.01, ['z'] = 31.62},
	  [56] = {['x'] = 1027.72, ['y'] = -2204.52, ['z'] = 31.89},
	  [57] = {['x'] = 1441.26, ['y'] = -1669.09, ['z'] = 66.65},
	  [58] = {['x'] = 980.19, ['y'] = -1396.67, ['z'] = 31.69},
	  [59] = {['x'] = 1724.67, ['y'] = -1470.48, ['z'] = 113.95},
	--======================================================================================================--
    [60] = {['x'] = 357.42, ['y'] = -1868.66, ['z'] = 26.94}, -- ROTA MUNI
    [61] = {['x'] = 307.13, ['y'] = -1432.61, ['z'] = 29.97},
    [62] = {['x'] = 449.57, ['y'] = -705.26, ['z'] = 27.36},
    [63] = {['x'] = -259.01, ['y'] = -710.68, ['z'] = 34.28},
    [64] = {['x'] = -315.48, ['y'] = -2.91, ['z'] = 48.15},
    [65] = {['x'] = -725.19, ['y'] = 124.11, ['z'] = 56.58},
    [66] = {['x'] = -1306.25, ['y'] = 240.54, ['z'] = 59.0},
    [67] = {['x'] = -1456.3, ['y'] = -164.65, ['z'] = 49.1},
    [68] = {['x'] = -1285.67, ['y'] = -566.97, ['z'] = 31.72},
    [69] = {['x'] = -1178.09, ['y'] = -891.43, ['z'] = 13.77},
    [70] = {['x'] = -177.46, ['y'] = -1178.15, ['z'] = 23.12},
    [71] = {['x'] = -8.79, ['y'] = -1090.92, ['z'] = 26.68},
    [72] = {['x'] = 286.92, ['y'] = -1148.64, ['z'] = 29.3},
    [73] = {['x'] = 442.69, ['y'] = -1480.9, ['z'] = 29.47},
    [74] = {['x'] = 886.08, ['y'] = -1579.37, ['z'] = 30.79},
    [75] = {['x'] = 876.7, ['y'] = -2040.13, ['z'] = 30.51},
    [76] = {['x'] = 434.6, ['y'] = -2088.5, ['z'] = 21.57},
    [77] = {['x'] = 101.79, ['y'] = -2060.87, ['z'] = 18.18},
    [78] = {['x'] = 318.43, ['y'] = -1476.33, ['z'] = 29.97},
    [79] = {['x'] = 467.62, ['y'] = -1275.0, ['z'] = 29.59}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL PARA INICIAR COLETA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local Otimizar = 1000
		if not servico then
			for _,mark in pairs(Coordenadas) do
				local x,y,z = table.unpack(mark)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
				if distance <= 30.0 then
					Otimizar = 5
					DrawMarker(21,x,y,z,0,0,0,0,0,0,0.5,0.5,0.5,255,255,255,150,1,0,0,1)
					if distance <= 1.2 then
						Otimizar = 1
						drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR COLETA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) and emP.checkPermission() then
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), -1381.97,-632.74,30.82,true) <= 1.2 then -- Bahamas
								servico = true
								inicio = 1
								fim = 20
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.")
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1051.92, -233.07, 44.03,true) <= 1.2 then -- Life
								servico = true
								inicio = 1
								fim = 20
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.")
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1272.33,-1711.65,54.77,true) <= 1.2 then -- Crips
								servico = true
								inicio = 40
								fim = 59
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.")
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1079.79,-1679.49,4.58,true) <= 1.2 then -- Bloods
								servico = true
								inicio = 40
								fim = 59
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.")
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1493.1,843.66,181.6,true) <= 1.2 then -- Yardie
								servico = true
								inicio = 60
								fim = 79
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.")
							elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1071.01,-2006.23,32.09,true) <= 1.2 then -- Russkaya
								servico = true						
								inicio = 60
								fim = 79					
								selecionado = inicio
								CriandoBlip(locs,selecionado)
								TriggerEvent("Notify","importante","Você iniciou o serviço.")
							end
						end
					end
				end
			end
		end
		Citizen.Wait(Otimizar)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLETA DE COMPONENTES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
            if distance <= 100.0 then
                timeDistance = 5
                DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z,0,0,0,0,0,0,0.5,0.5,0.5,255,255,255,150,1,0,0,1)
                if distance <= 1.6 then
                    timeDistance = 4
                    drawTxt("PRESSIONE ~b~E~w~  PARA COLETAR",4,0.5,0.93,0.50,255,255,255,180)
                    if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
                        if emP.checkPayment() then
                            TriggerEvent('progress',1000,'PEGANDO')
							TriggerEvent('cancelando',true)
							vRP._playAnim(false,{{"pickup_object","pickup_low"}},true)
							Citizen.Wait(1000)
							vRP._stopAnim(false)
							TriggerEvent('cancelando',false)
							RemoveBlip(blips)
							selecionado = selecionado + 1
							if selecionado > fim then
								selecionado = inicio
							end
                            CriandoBlip(locs,selecionado)
                        end
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você finalizou o serviço.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
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

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Componentes")
	EndTextCommandSetBlipName(blips)
end

