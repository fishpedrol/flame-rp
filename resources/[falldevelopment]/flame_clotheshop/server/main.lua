local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
zZ = {}
Tunnel.bindInterface(GetCurrentResourceName(),zZ)

function zZ.PayClothes(price)
    local user_id = vRP.getUserId(source)
    if vRP.tryFullPayment(user_id,price) then
       return true 
    end
    return false
end

RegisterNetEvent("clotheshop:save",function(clothingData)
    local user_id = vRP.getUserId(source)
    if not clothingData then return end
    vRP.setUData(user_id,"clothingData",json.encode(clothingData))
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source)
    local clothingData = vRP.getUData(user_id,"clothingData")
    local data = json.decode(clothingData)
    if not data then return end
    TriggerClientEvent("clotheshop:apply", source, data)
end)

RegisterCommand("tutu", function(source)
    local user_id = vRP.getUserId(source)
    local clothingData = vRP.getUData(user_id,"clothingData")
    local data = json.decode(clothingData)
    if not data then return end
    TriggerClientEvent("clotheshop:apply", source, data)
end)