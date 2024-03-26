local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)

vSERVER = Tunnel.getInterface("arsenal")

local menuactive = false
function ToggleActionMenu()
    menuactive = not menuactive
	
    if menuactive then
        SetNuiFocus(true,true)
        SendNUIMessage({arsenal = true})
    else
        SetNuiFocus(false)
        SendNUIMessage({arsenal = false})
    end
end

local markers = {
	{621.48,-18.88,82.8}
}

RegisterNUICallback("buy",function(data,cb)
	if data.name then
		vSERVER.buy(data.name)

	end
end)



RegisterCommand('arsenal',function(source,args)
	for _,mark in pairs(markers) do
		local x,y,z = table.unpack(mark)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
		if distance <= 3 then
			if vSERVER.checkPermissao() then
				ToggleActionMenu()
			else
				TriggerEvent('Notify', 'negado', 'Você não tem permissão para acessar o arsenal.')
			end
		end
	end
end)




RegisterNUICallback("fechar2", function(data)
	ToggleActionMenu()
end)