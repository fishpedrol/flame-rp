-----------------------------------------------------------------------------------------------------------------------------------------
-- vRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("gvt_tattoos",cRP)
vCLIENT = Tunnel.getInterface("gvt_tattoos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getTattoo()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consult = vRP.getUData(user_id,"vRP:tattoos")
		local result = json.decode(consult)
		if result then
			TriggerClientEvent("gvt_tattoos:setTattoos",source,result)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateTattoo(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"vRP:tattoos",json.encode(status))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	local source = source
	local consult = vRP.getUData(user_id,"vRP:tattoos")
	local result = json.decode(consult)
	if result then 
		Citizen.Wait(5000)
		TriggerClientEvent("gvt_tattoos:setTattoos",source,result)
	end
end)