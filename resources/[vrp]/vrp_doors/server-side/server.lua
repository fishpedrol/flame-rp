-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("doors",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
local doors = {
	[1] = { ["x"] = 601.19, ["y"] = -7.27, ["z"] = 82.79, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 0.1, ["perm"] = "policia.permissao", ["sound"] = true },
	[2] = { ["x"] = 604.92, ["y"] = -8.65, ["z"] = 82.79, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 0.1, ["perm"] = "policia.permissao", ["sound"] = true },
	[3] = { ["x"] = 608.91, ["y"] = -9.97, ["z"] = 82.79, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 0.1, ["perm"] = "policia.permissao", ["sound"] = true },
	[4] = { ["x"] = 612.66, ["y"] = -11.43, ["z"] = 82.79, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 0.1, ["perm"] = "policia.permissao", ["sound"] = true },
	[5] = { ["x"] = 613.9, ["y"] = -2.11, ["z"] = 82.79, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 0.1, ["perm"] = "policia.permissao", ["sound"] = true }

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsStatistics(doorNumber,doorStatus)
	local source = source

	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("doors:doorsUpdate",-1,doors)

	if doors[parseInt(doorNumber)].sound then
		TriggerClientEvent("sound:source",source,"doorlock",0.1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("doors:doorsStatistics")
AddEventHandler("doors:doorsStatistics",function(doorNumber,doorStatus)
	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("doors:doorsUpdate",-1,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if doors[parseInt(doorNumber)].perm ~= nil then
			if vRP.hasPermission(user_id,doors[parseInt(doorNumber)].perm) then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("doors:doorsUpdate",source,doors)
end)