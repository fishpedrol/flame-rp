local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-- CONNECTION
local src = {}
Tunnel.bindInterface("vrp_facs",src)
vSERVER = Tunnel.getInterface("vrp_facs")


--[[ 
    Chat Fac 
 ]]
 
--[[  RegisterCommand('tpfarm', function(source, args, rawCmd)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)

    if GetEntityHealth(ped) <= 101 then TriggerEvent('Notify', 'negado', 'Você não pode fazer isso em coma.') return end
    if IsPedInAnyVehicle(ped, false) then TriggerEvent('Notify', 'negado','Você não pode fazer isso em um veículo.') return end

    if vSERVER.groove() then
    local grove = Vdist2(pedCoords, 101.16,6329.69,31.38 ) --- BASE GROOVE
    local grove2 = Vdist2(pedCoords, -150.23,-1625.56,36.85 ) --- BASE FARM GROOVE

    if grove <= 1.5 then
        SetEntityCoords(ped, -150.23,-1625.56,36.85-0.96) --- BASE FARM GROOVE
    elseif grove2 <= 1.5 then
        SetEntityCoords(ped, 101.16,6329.69,31.38-0.96) --- BASE GROOVE
        end
    end

    if vSERVER.vagos() then
    local vagos1 = Vdist2(pedCoords, -1098.41,4948.69,218.65 ) --- BASE VAGOS
    local vagos2 = Vdist2(pedCoords, 371.37,-2040.73,22.21 ) --- BASE FARM VAGOS

    if vagos1 <= 1.5 then
        SetEntityCoords(ped, 371.37,-2040.73,22.21-0.96) --- BASE FARM VAGOS
    elseif vagos2 <= 1.5 then
        SetEntityCoords(ped, -1098.41,4948.69,218.65-0.96) --- BASE VAGOS
        end
    end

    if vSERVER.ballas() then
    local ballas1 = Vdist2(pedCoords, 78.91,-1975.11,20.93) --- BASE BALLAS
    local ballas2 = Vdist2(pedCoords, 1482.76,6392.29,22.99) --- BASE FARM BALLAS

    if ballas1 <= 1.5 then
        SetEntityCoords(ped, 1482.76,6392.29,22.99-0.96) --- BASE FARM BALLAS
    elseif ballas2 <= 1.5 then
        SetEntityCoords(ped, 78.91,-1975.11,20.93-0.96) --- BASE BALLAS
        end
    end
end)  ]]

