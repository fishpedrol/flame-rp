-----------------------------------------------------------------------------------------------------------------------------------------
-- networkPVP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
networkPVP = Proxy.getInterface("networkPVP")
networkPVPclient = Tunnel.getInterface("networkPVP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("gvt-tattoos",cRP)
vCLIENT = Tunnel.getInterface("gvt-tattoos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getTattoo()
	local source = source
	local user_id = networkPVP.getUserId(source)
	if user_id then
		local consult = networkPVP.getUData(user_id,"networkPVP:tattoos")
		local result = json.decode(consult)
		if result then
			TriggerClientEvent("gvt-tattoos:setTattoos",source,result)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateTattoo(status)
	local source = source
	local user_id = networkPVP.getUserId(source)
	if user_id then
		networkPVP.setUData(user_id,"networkPVP:tattoos",json.encode(status))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("networkPVP:playerSpawn",function(user_id,source)
	local source = source
	local consult = networkPVP.getUData(user_id,"networkPVP:tattoos")
	local result = json.decode(consult)
	if result then 
		Citizen.Wait(5000)
		TriggerClientEvent("gvt-tattoos:setTattoos",source,result)
	end
end)