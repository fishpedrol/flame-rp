
local Tunnel = module("vrp","lib/Tunnel")

local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")

vRPclient = Tunnel.getInterface("vRP")

DynamicWeather = true

debugprint = false

AvailableWeatherTypes = {

    'EXTRASUNNY', 

    'CLEAR', 

    'NEUTRAL', 

    'SMOG', 

    'FOGGY', 

    'OVERCAST',  

    'SNOW', 

    'BLIZZARD', 

    'SNOWLIGHT', 

    'XMAS', 

    'HALLOWEEN',

}





CurrentWeather = "EXTRASUNNY"

local baseTime = 0

local timeOffset = 0

local freezeTime = false

local blackout = false

local newWeatherTimer = 35




local source = source

local user_id = vRP.getUserId(source)




RegisterServerEvent('vSync:requestSync')

AddEventHandler('vSync:requestSync', function()

    TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)

    TriggerClientEvent('vSync:updateTime', -1, baseTime, timeOffset, freezeTime)

end)




function isAllowedToChange(player)

    local allowed = false

    for i,id in ipairs(admins) do

        for x,pid in ipairs(GetPlayerIdentifiers(player)) do

            if debugprint then print('admin id: ' .. id .. '\nplayer id:' .. pid) end

            if string.lower(pid) == string.lower(id) then

                allowed = true

            end

        end

    end

    return allowed

end






--[[ 
      CONGELAR
        ]]




RegisterCommand('congelar', function(source, args)

	local source = source

	local user_id = vRP.getUserId(source)

    if source ~= 0 then

        if vRP.hasPermission(user_id,'staff.permissao') then

            freezeTime = not freezeTime

            if freezeTime then

                TriggerClientEvent("Notify",source,"sucesso","O tempo agora está congelado.")

            else

                TriggerClientEvent("Notify",source,"negado","O tempo não está mais congelado.")

            end

        else

            TriggerClientEvent("Notify",source,"negado","<b>Erro:</b><br>Você não tem acesso a esse comando.")

        end


    else

        freezeTime = not freezeTime

        if freezeTime then

            --print("Time is now frozen.")

        else

            --print("Time is no longer frozen.")

        end

    end

end)



 --[[ 
     
       DINAMICO 
 
 
 ]]



RegisterCommand('dinamico', function(source, args)

	local source = source

	local user_id = vRP.getUserId(source)

    if source ~= 0 then

        if vRP.hasPermission(user_id,'staff.permissao') then

            DynamicWeather = not DynamicWeather

            if not DynamicWeather then

                TriggerClientEvent("Notify",source,"negado","Mudanças climáticas dinâmicas agora estão <b>desabilitadas</b>.")

            else

                TriggerClientEvent("Notify",source,"sucesso","Mudanças climáticas dinâmicas agora estão <b>habilitadas</b>.")

            end

        else

            TriggerClientEvent("Notify",source,"negado","<b>Erro:</b><br>Você não tem acesso a esse comando.")

        end

    else



        DynamicWeather = not DynamicWeather

        if not DynamicWeather then

            print("Weather is now frozen.")

        else

            print("Weather is no longer frozen.")

        end

    end

end)