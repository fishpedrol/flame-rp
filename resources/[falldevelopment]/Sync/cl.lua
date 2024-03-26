local Tunnel = module("vrp","lib/Tunnel")

local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")






local minutes = 1
local clima = nil
local dia = nil
local noite = nil
local hours = 0
local actualWeather = "CLEAR"
local weathers = {
    "EXTRASUNNY",
    "CLEAR",
    "NEUTRAL",
    "SMOG",
    "FOGGY",
    "OVERCAST",
    "CLOUDS",
    "CLEARING",
    "RAIN",
    "THUNDER",
    "SNOW",
    "BLIZZARD",
    "SNOWLIGHT",
    "XMAS",
    "HALLOWEEN"
}



RegisterCommand("noite",function(source,args)
    print (noite)
    minutes = parseInt(00)
    hours = parseInt(00)
end)



RegisterCommand("dia",function(source,args)
    print (dia)
    minutes = parseInt(00)
    hours = parseInt(12)
end)



RegisterCommand("hora",function(source,args)
    if args[1] and args[2] then
        hours = parseInt(args[1])
        minutes = parseInt(args[2])
    else
        TriggerEvent('Notify', source, 'negado', 'Utilize: /hora horas minutos')
    end
end)



RegisterCommand('clima', function(source, args)
    if args[1] then
        local weather = parseInt(args[1])
        if weather > 0 then
            if weathers[weather] then
                actualWeather = weathers[weather]
                TriggerEvent('Notify', 'sucesso', 'Você mudou o clima para <b>'..actualWeather..'</b>.')
                print (clima)
            end
        else
            TriggerEvent('Notify', 'negado', 'Você deve especificar um número de <b>1 a ' .. #weathers .. '</b>.')
        end
    else
        TriggerEvent('Notify', 'negado', 'Você deve especificar um número de <b>1 a ' .. #weathers .. '</b>.')
    end
end)







Citizen.CreateThread(function()
    while true do
        SetWeatherTypeNow(actualWeather)
        SetWeatherTypePersist(actualWeather)
        SetWeatherTypeNowPersist(actualWeather)
        NetworkOverrideClockTime(hours,minutes,00)
        Citizen.Wait(4)
    end
end)