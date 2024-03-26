-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local sanitizes = module("cfg/sanitizes")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_homes",src)
vCLIENT = Tunnel.getInterface("vrp_homes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookbaucasas = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("homes/get_homeuser","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home")
vRP._prepare("homes/get_homeuserid","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id")
vRP._prepare("homes/get_homeuserowner","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP._prepare("homes/get_homeuseridowner","SELECT * FROM vrp_homes_permissions WHERE home = @home AND owner = 1")
vRP._prepare("homes/get_homepermissions","SELECT * FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/add_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id) VALUES(@home,@user_id)")
vRP._prepare("homes/buy_permissions","INSERT IGNORE INTO vrp_homes_permissions(home,user_id,owner,tax,garage) VALUES(@home,@user_id,1,@tax,1)")
vRP._prepare("homes/count_homepermissions","SELECT COUNT(*) as qtd FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/upd_permissions","UPDATE vrp_homes_permissions SET garage = 1 WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/rem_permissions","DELETE FROM vrp_homes_permissions WHERE home = @home AND user_id = @user_id")
vRP._prepare("homes/upd_taxhomes","UPDATE vrp_homes_permissions SET tax = @tax WHERE user_id = @user_id, home = @home AND owner = 1")
vRP._prepare("homes/rem_allpermissions","DELETE FROM vrp_homes_permissions WHERE home = @home")
vRP._prepare("homes/get_allhomes","SELECT * FROM vrp_homes_permissions WHERE owner = @owner")
vRP._prepare("homes/get_allvehs","SELECT * FROM vrp_vehicles")
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMESINFO
-----------------------------------------------------------------------------------------------------------------------------------------
local homes = {
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------FORTHILLS-----------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["FH01"] = { 8000000,4,1000 },
	["FH02"] = { 8000000,4,1000 },
	["FH03"] = { 8000000,4,1000 },
	["FH04"] = { 8000000,4,1000 },
	["FH05"] = { 8000000,4,1000 },
	["FH06"] = { 8000000,4,1000 },
	["FH07"] = { 8000000,4,1000 },
	["FH08"] = { 8000000,4,1000 },
	["FH09"] = { 8000000,4,1000 },
	["FH10"] = { 8000000,4,1000 },
	["FH11"] = { 8000000,4,1000 },
	["FH12"] = { 8000000,4,1000 },
	["FH13"] = { 8000000,4,1000 },
	["FH14"] = { 8000000,4,1000 },
	["FH15"] = { 8000000,4,1000 },
	["FH16"] = { 8000000,4,1000 },
	["FH17"] = { 8000000,4,1000 },
	["FH18"] = { 8000000,4,1000 },
	["FH19"] = { 8000000,4,1000 },
	["FH20"] = { 8000000,4,1000 },
	["FH21"] = { 8000000,4,1000 },
	["FH22"] = { 8000000,4,1000 },
	["FH23"] = { 8000000,4,1000 },
	["FH24"] = { 8000000,4,1000 },
	["FH25"] = { 8000000,4,1000 },
	["FH26"] = { 8000000,4,1000 },
	["FH27"] = { 8000000,4,1000 },
	["FH28"] = { 8000000,4,1000 },
	["FH29"] = { 8000000,4,1000 },
	["FH30"] = { 8000000,4,1000 },
	["FH31"] = { 8000000,4,1000 },
	["FH32"] = { 8000000,4,1000 },
	["FH33"] = { 8000000,4,1000 },
	["FH34"] = { 8000000,4,1000 },
	["FH35"] = { 8000000,4,1000 },
	["FH36"] = { 8000000,4,1000 },
	["FH37"] = { 8000000,4,1000 },
	["FH38"] = { 8000000,4,1000 },
	["FH39"] = { 8000000,4,1000 },
	["FH40"] = { 8000000,4,1000 },
	["FH41"] = { 8000000,4,1000 },
	["FH42"] = { 8000000,4,1000 },
	["FH43"] = { 8000000,4,1000 },
	["FH44"] = { 8000000,4,1000 },
	["FH45"] = { 8000000,4,1000 },
	["FH46"] = { 8000000,4,1000 },
	["FH47"] = { 8000000,4,1000 },
	["FH48"] = { 8000000,4,1000 },
	["FH49"] = { 8000000,4,1000 },
	["FH50"] = { 8000000,4,1000 },
	["FH51"] = { 8000000,4,1000 },
	["FH52"] = { 8000000,4,1000 },
	["FH53"] = { 8000000,4,1000 },
	["FH54"] = { 8000000,4,1000 },
	["FH55"] = { 8000000,4,1000 },
	["FH56"] = { 8000000,4,1000 },
	["FH57"] = { 8000000,4,1000 },
	["FH58"] = { 8000000,4,1000 },
	["FH59"] = { 8000000,4,1000 },
	["FH60"] = { 8000000,4,1000 },
	["FH61"] = { 8000000,4,1000 },
	["FH62"] = { 8000000,4,1000 },
	["FH63"] = { 8000000,4,1000 },
	["FH64"] = { 8000000,4,1000 },
	["FH65"] = { 8000000,4,1000 },
	["FH66"] = { 8000000,4,1000 },
	["FH67"] = { 8000000,4,1000 },
	["FH68"] = { 8000000,4,1000 },
	["FH69"] = { 8000000,4,1000 },
	["FH70"] = { 8000000,4,1000 },
	["FH71"] = { 8000000,4,1000 },
	["FH72"] = { 8000000,4,1000 },
	["FH73"] = { 8000000,4,1000 },
	["FH74"] = { 8000000,4,1000 },
	["FH75"] = { 8000000,4,1000 },
	["FH76"] = { 8000000,4,1000 },
	["FH77"] = { 8000000,4,1000 },
	["FH78"] = { 8000000,4,1000 },
	["FH79"] = { 8000000,4,1000 },
	["FH80"] = { 8000000,4,1000 },
	["FH81"] = { 8000000,4,1000 },
	["FH82"] = { 8000000,4,1000 },
	["FH83"] = { 8000000,4,1000 },
	["FH84"] = { 8000000,4,1000 },
	["FH85"] = { 8000000,4,1000 },
	["FH86"] = { 8000000,4,1000 },
	["FH87"] = { 8000000,4,1000 },
	["FH88"] = { 8000000,4,1000 },
	["FH89"] = { 8000000,4,1000 },
	["FH90"] = { 8000000,4,1000 },
	["FH91"] = { 8000000,4,1000 },
	["FH92"] = { 8000000,4,1000 },
	["FH93"] = { 8000000,4,1000 },
	["FH94"] = { 8000000,4,1000 },
	["FH95"] = { 8000000,4,1000 },
	["FH96"] = { 8000000,4,1000 },
	["FH97"] = { 8000000,4,1000 },
	["FH98"] = { 8000000,4,1000 },
	["FH99"] = { 8000000,4,1000 },
	["FH100"] = { 8000000,4,1000 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------LUXURY--------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["LX02"] = { 8000000,4,1000 },
	["LX01"] = { 8000000,4,1000 },
	["LX03"] = { 8000000,4,1000 },
	["LX04"] = { 8000000,4,1000 },
	["LX05"] = { 8000000,4,1000 },
	["LX06"] = { 8000000,4,1000 },
	["LX07"] = { 8000000,4,1000 },
	["LX08"] = { 8000000,4,1000 },
	["LX09"] = { 8000000,4,1000 },
	["LX10"] = { 8000000,4,1000 },
	["LX11"] = { 8000000,4,1000 },
	["LX12"] = { 8000000,4,1000 },
	["LX13"] = { 8000000,4,1000 },
	["LX14"] = { 8000000,4,1000 },
	["LX15"] = { 8000000,4,1000 },
	["LX16"] = { 8000000,4,1000 },
	["LX17"] = { 8000000,4,1000 },
	["LX18"] = { 8000000,4,1000 },
	["LX19"] = { 8000000,4,1000 },
	["LX20"] = { 8000000,4,1000 },
	["LX21"] = { 8000000,4,1000 },
	["LX22"] = { 8000000,4,1000 },
	["LX23"] = { 8000000,4,1000 },
	["LX24"] = { 8000000,4,1000 },
	["LX25"] = { 8000000,4,1000 },
	["LX26"] = { 8000000,4,1000 },
	["LX27"] = { 8000000,4,1000 },
	["LX28"] = { 8000000,4,1000 },
	["LX29"] = { 8000000,4,1000 },
	["LX30"] = { 8000000,4,1000 },
	["LX31"] = { 8000000,4,1000 },
	["LX32"] = { 8000000,4,1000 },
	["LX33"] = { 8000000,4,1000 },
	["LX34"] = { 8000000,4,1000 },
	["LX35"] = { 8000000,4,1000 },
	["LX36"] = { 8000000,4,1000 },
	["LX37"] = { 8000000,4,1000 },
	["LX38"] = { 8000000,4,1000 },
	["LX39"] = { 8000000,4,1000 },
	["LX40"] = { 8000000,4,1000 },
	["LX41"] = { 8000000,4,1000 },
	["LX42"] = { 8000000,4,1000 },
	["LX43"] = { 8000000,4,1000 },
	["LX44"] = { 99999999,4,1000 },
	["LX45"] = { 8000000,4,1000 },
	["LX46"] = { 8000000,4,1000000 },
	["LX47"] = { 8000000,4,1000 },
	["LX48"] = { 8000000,4,1000 },
	["LX49"] = { 8000000,4,1000 },
	["LX50"] = { 8000000,4,1000 },
	["LX51"] = { 8000000,4,1000 },
	["LX52"] = { 8000000,4,1000 },
	["LX53"] = { 8000000,4,1000 },
	["LX54"] = { 8000000,4,1000 },
	["LX55"] = { 8000000,4,1000 },
	["LX56"] = { 8000000,4,1000 },
	["LX57"] = { 8000000,4,1000 },
	["LX58"] = { 8000000,4,1000 },
	["LX59"] = { 8000000,4,1000 },
	["LX60"] = { 8000000,4,1000 },
	["LX61"] = { 8000000,4,1000 },
	["LX62"] = { 8000000,4,1000 },
	["LX63"] = { 8000000,4,1000 },
	["LX64"] = { 8000000,4,1000 },
	["LX65"] = { 8000000,4,1000 },
	["LX66"] = { 8000000,4,1000 },
	["LX67"] = { 8000000,4,1000 },
	["LX68"] = { 8000000,4,1000 },
	["LX69"] = { 8000000,4,1000 },
	["LX70"] = { 8000000,4,1000 },	
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------SAMIR-------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["LS01"] = { 500000,3,300 },
	["LS02"] = { 500000,3,300 },
	["LS03"] = { 500000,3,300 },
	["LS04"] = { 500000,3,300 },
	["LS05"] = { 500000,3,300 },
	["LS06"] = { 500000,3,300 },
	["LS07"] = { 500000,3,300 },
	["LS08"] = { 500000,3,300 },
	["LS09"] = { 500000,3,300 },
	["LS10"] = { 500000,3,300 },
	["LS11"] = { 500000,3,300 },
	["LS12"] = { 500000,3,300 },
	["LS13"] = { 500000,3,300 },
	["LS14"] = { 500000,3,300 },
	["LS15"] = { 500000,3,300 },
	["LS16"] = { 500000,3,300 },
	["LS17"] = { 500000,3,300 },
	["LS18"] = { 500000,3,300 },
	["LS19"] = { 500000,3,300 },
	["LS20"] = { 500000,3,300 },
	["LS21"] = { 500000,3,300 },
	["LS22"] = { 500000,3,300 },
	["LS23"] = { 500000,3,300 },
	["LS24"] = { 500000,3,300 },
	["LS25"] = { 500000,3,300 },
	["LS26"] = { 500000,3,300 },
	["LS27"] = { 500000,3,300 },
	["LS28"] = { 500000,3,300 },
	["LS29"] = { 500000,3,300 },
	["LS30"] = { 500000,3,300 },
	["LS31"] = { 500000,3,300 },
	["LS32"] = { 500000,3,300 },
	["LS33"] = { 500000,3,300 },
	["LS34"] = { 500000,3,300 },
	["LS35"] = { 500000,3,300 },
	["LS36"] = { 500000,3,300 },
	["LS37"] = { 500000,3,300 },
	["LS38"] = { 500000,3,300 },
	["LS39"] = { 500000,3,300 },
	["LS40"] = { 500000,3,300 },
	["LS41"] = { 500000,3,300 },
	["LS42"] = { 500000,3,300 },
	["LS43"] = { 500000,3,300 },
	["LS44"] = { 500000,3,300 },
	["LS45"] = { 500000,3,300 },
	["LS46"] = { 500000,3,300 },
	["LS47"] = { 500000,3,300 },
	["LS48"] = { 500000,3,300 },
	["LS49"] = { 500000,3,300 },
	["LS50"] = { 500000,3,300 },
	["LS51"] = { 500000,3,300 },
	["LS52"] = { 500000,3,300 },
	["LS53"] = { 500000,3,300 },
	["LS54"] = { 500000,3,300 },
	["LS55"] = { 500000,3,300 },
	["LS56"] = { 500000,3,300 },
	["LS57"] = { 500000,3,300 },
	["LS58"] = { 500000,3,300 },
	["LS59"] = { 500000,3,300 },
	["LS60"] = { 500000,3,300 },
	["LS61"] = { 500000,3,300 },
	["LS62"] = { 500000,3,300 },
	["LS63"] = { 500000,3,300 },
	["LS64"] = { 500000,3,300 },
	["LS65"] = { 500000,3,300 },
	["LS66"] = { 500000,3,300 },
	["LS67"] = { 500000,3,300 },
	["LS68"] = { 500000,3,300 },
	["LS69"] = { 500000,3,300 },
	["LS70"] = { 500000,3,300 },
	["LS71"] = { 500000,3,300 },
	["LS72"] = { 500000,3,300 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------BOLLINI------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["BL01"] = { 500000,2,500 },
	["BL02"] = { 500000,2,500 },
	["BL03"] = { 500000,2,500 },
	["BL04"] = { 500000,2,500 },
	["BL05"] = { 500000,2,500 },
	["BL06"] = { 500000,2,500 },
	["BL07"] = { 500000,2,500 },
	["BL08"] = { 500000,2,500 },
	["BL09"] = { 500000,2,500 },
	["BL10"] = { 500000,2,500 },
	["BL11"] = { 500000,2,500 },
	["BL12"] = { 500000,2,500 },
	["BL13"] = { 500000,2,500 },
	["BL14"] = { 500000,2,500 },
	["BL15"] = { 500000,2,500 },
	["BL16"] = { 500000,2,500 },
	["BL17"] = { 500000,2,500 },
	["BL18"] = { 500000,2,500 },
	["BL19"] = { 500000,2,500 },
	["BL20"] = { 500000,2,500 },
	["BL21"] = { 500000,2,500 },
	["BL22"] = { 500000,2,500 },
	["BL23"] = { 500000,2,500 },
	["BL24"] = { 500000,2,500 },
	["BL25"] = { 500000,2,500 },
	["BL26"] = { 500000,2,500 },
	["BL27"] = { 500000,2,500 },
	["BL28"] = { 500000,2,500 },
	["BL29"] = { 500000,2,500 },
	["BL30"] = { 500000,2,500 },
	["BL31"] = { 500000,2,500 },
	["BL32"] = { 500000,2,500 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------LOSVAGOS------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["LV01"] = { 500000,2,500 },
	["LV02"] = { 500000,2,500 },
	["LV03"] = { 500000,2,500 },
	["LV04"] = { 500000,2,500 },
	["LV05"] = { 500000,2,500 },
	["LV06"] = { 500000,2,500 },
	["LV07"] = { 500000,2,500 },
	["LV08"] = { 500000,2,500 },
	["LV09"] = { 500000,2,500 },
	["LV10"] = { 500000,2,500 },
	["LV11"] = { 500000,2,500 },
	["LV12"] = { 500000,2,500 },
	["LV13"] = { 500000,2,500 },
	["LV14"] = { 500000,2,500 },
	["LV15"] = { 500000,2,500 },
	["LV16"] = { 500000,2,500 },
	["LV17"] = { 500000,2,500 },
	["LV18"] = { 500000,2,500 },
	["LV19"] = { 500000,2,500 },
	["LV20"] = { 500000,2,500 },
	["LV21"] = { 500000,2,500 },
	["LV22"] = { 500000,2,500 },
	["LV23"] = { 500000,2,500 },
	["LV24"] = { 500000,2,500 },
	["LV25"] = { 500000,2,500 },
	["LV26"] = { 500000,2,500 },
	["LV27"] = { 500000,2,500 },
	["LV28"] = { 500000,2,500 },
	["LV29"] = { 500000,2,500 },
	["LV30"] = { 500000,2,500 },
	["LV31"] = { 500000,2,500 },
	["LV32"] = { 500000,2,500 },
	["LV33"] = { 500000,2,500 },
	["LV34"] = { 500000,2,500 },
	["LV35"] = { 500000,2,500 },
-----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------KRONDORS------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["KR01"] = { 500000,2,500 },
	["KR02"] = { 500000,2,500 },
	["KR03"] = { 500000,2,500 },
	["KR04"] = { 500000,2,500 },
	["KR05"] = { 500000,2,500 },
	["KR06"] = { 500000,2,500 },
	["KR07"] = { 500000,2,500 },
	["KR08"] = { 500000,2,500 },
	["KR09"] = { 500000,2,500 },
	["KR10"] = { 500000,2,500 },
	["KR11"] = { 500000,2,500 },
	["KR12"] = { 500000,2,500 },
	["KR13"] = { 500000,2,500 },
	["KR14"] = { 500000,2,500 },
	["KR15"] = { 500000,2,500 },
	["KR16"] = { 500000,2,500 },
	["KR17"] = { 500000,2,500 },
	["KR18"] = { 500000,2,500 },
	["KR19"] = { 500000,2,500 },
	["KR20"] = { 500000,2,500 },
	["KR21"] = { 500000,2,500 },
	["KR22"] = { 500000,2,500 },
	["KR23"] = { 500000,2,500 },
	["KR24"] = { 500000,2,500 },
	["KR25"] = { 500000,2,500 },
	["KR26"] = { 500000,2,500 },
	["KR27"] = { 500000,2,500 },
	["KR28"] = { 500000,2,500 },
	["KR29"] = { 500000,2,500 },
	["KR30"] = { 500000,2,500 },
	["KR31"] = { 500000,2,500 },
	["KR32"] = { 500000,2,500 },
	["KR33"] = { 500000,2,500 },
	["KR34"] = { 500000,2,500 },
	["KR35"] = { 500000,2,500 },
	["KR36"] = { 500000,2,500 },
	["KR37"] = { 500000,2,500 },
	["KR38"] = { 500000,2,500 },
	["KR39"] = { 500000,2,500 },
	["KR40"] = { 500000,2,500 },
	["KR41"] = { 500000,2,500 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------GROOVEMOTEL--------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["GR01"] = { 500000,2,500 },
	["GR02"] = { 500000,2,500 },
	["GR03"] = { 500000,2,500 },
	["GR04"] = { 500000,2,500 },
	["GR05"] = { 500000,2,500 },
	["GR06"] = { 500000,2,500 },
	["GR07"] = { 500000,2,500 },
	["GR08"] = { 500000,2,500 },
	["GR09"] = { 500000,2,500 },
	["GR10"] = { 500000,2,500 },
	["GR11"] = { 500000,2,500 },
	["GR12"] = { 500000,2,500 },
	["GR13"] = { 500000,2,500 },
	["GR14"] = { 500000,2,500 },
	["GR15"] = { 500000,2,500 },
-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------ALLSUELLMOTEL------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["AS01"] = { 500000,2,500 },
	["AS02"] = { 500000,2,500 },
	["AS03"] = { 500000,2,500 },
	["AS04"] = { 500000,2,500 },
	["AS05"] = { 500000,2,500 },
	["AS06"] = { 500000,2,500 },
	["AS07"] = { 500000,2,500 },
	["AS08"] = { 500000,2,500 },
	["AS09"] = { 500000,2,500 },
	["AS10"] = { 500000,2,500 },
	["AS12"] = { 500000,2,500 },
	["AS13"] = { 500000,2,500 },
	["AS14"] = { 500000,2,500 },
	["AS15"] = { 500000,2,500 },
	["AS16"] = { 500000,2,500 },
	["AS17"] = { 500000,2,500 },
	["AS18"] = { 500000,2,500 },
	["AS19"] = { 500000,2,500 },
	["AS20"] = { 500000,2,500 },
	["AS21"] = { 500000,2,500 },
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------PINKCAGEMOTEL-----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["PC01"] = { 500000,2,150 },
	["PC02"] = { 500000,2,150 },
	["PC03"] = { 500000,2,150 },
	["PC04"] = { 500000,2,150 },
	["PC05"] = { 500000,2,150 },
	["PC06"] = { 500000,2,150 },
	["PC07"] = { 500000,2,150 },
	["PC08"] = { 500000,2,150 },
	["PC09"] = { 500000,2,150 },
	["PC10"] = { 500000,2,150 },
	["PC11"] = { 500000,2,150 },
	["PC12"] = { 500000,2,150 },
	["PC13"] = { 500000,2,150 },
	["PC14"] = { 500000,2,150 },
	["PC15"] = { 500000,2,150 },
	["PC16"] = { 500000,2,150 },
	["PC17"] = { 500000,2,150 },
	["PC18"] = { 500000,2,150 },
	["PC19"] = { 500000,2,150 },
	["PC20"] = { 500000,2,150 },
	["PC21"] = { 500000,2,150 },
	["PC22"] = { 500000,2,150 },
	["PC23"] = { 500000,2,150 },
	["PC24"] = { 500000,2,150 },
	["PC25"] = { 500000,2,150 },
	["PC26"] = { 500000,2,150 },
	["PC27"] = { 500000,2,150 },
	["PC28"] = { 500000,2,150 },
	["PC29"] = { 500000,2,150 },
	["PC30"] = { 500000,2,150 },
	["PC31"] = { 500000,2,150 },
	["PC32"] = { 500000,2,150 },
	["PC33"] = { 500000,2,150 },
	["PC34"] = { 500000,2,150 },
	["PC35"] = { 500000,2,150 },
	["PC36"] = { 500000,2,150 },
	["PC37"] = { 500000,2,150 },
	["PC38"] = { 500000,2,150 },
-----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------PALETOMOTEL------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["PL01"] = { 500000,2,150 },
	["PL02"] = { 500000,2,150 },
	["PL03"] = { 500000,2,150 },
	["PL04"] = { 500000,2,150 },
	["PL05"] = { 500000,2,150 },
	["PL06"] = { 500000,2,150 },
	["PL07"] = { 500000,2,150 },
	["PL08"] = { 500000,2,150 },
	["PL09"] = { 500000,2,150 },
	["PL11"] = { 500000,2,150 },
	["PL12"] = { 500000,2,150 },
	["PL13"] = { 500000,2,150 },
	["PL14"] = { 500000,2,150 },
	["PL15"] = { 500000,2,150 },
	["PL16"] = { 500000,2,150 },
	["PL17"] = { 500000,2,150 },
	["PL18"] = { 500000,2,150 },
	["PL19"] = { 500000,2,150 },
	["PL20"] = { 500000,2,150 },
	["PL21"] = { 500000,2,150 },
	["PL22"] = { 500000,2,150 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------PALETOBAY-------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["PB01"] = { 500000,2,250 },
	["PB02"] = { 500000,2,250 },
	["PB03"] = { 500000,2,250 },
	["PB04"] = { 500000,2,250 },
	["PB05"] = { 500000,2,250 },
	["PB06"] = { 500000,2,250 },
	["PB07"] = { 500000,2,250 },
	["PB08"] = { 500000,2,250 },
	["PB09"] = { 500000,2,250 },
	["PB10"] = { 500000,2,250 },
	["PB11"] = { 500000,2,250 },
	["PB12"] = { 500000,2,250 },
	["PB13"] = { 500000,2,250 },
	["PB14"] = { 500000,2,250 },
	["PB15"] = { 500000,2,250 },
	["PB16"] = { 500000,2,250 },
	["PB17"] = { 500000,2,250 },
	["PB18"] = { 500000,2,250 },
	["PB19"] = { 500000,2,250 },
	["PB20"] = { 500000,2,250 },
	["PB21"] = { 500000,2,250 },
	["PB22"] = { 500000,2,250 },
	["PB23"] = { 500000,2,250 },
	["PB24"] = { 500000,2,250 },
	["PB25"] = { 500000,2,250 },
	["PB26"] = { 500000,2,250 },
	["PB27"] = { 500000,2,250 },
	["PB28"] = { 500000,2,250 },
	["PB29"] = { 500000,2,250 },
	["PB30"] = { 500000,2,250 },
	["PB31"] = { 500000,2,250 },
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------MANSAO------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["MS01"] = { 99999999,5,1500 },
	["MS02"] = { 99999999,5,1500 },
	["MS03"] = { 99999999,5,1500 },
	["MS04"] = { 99999999,5,1500 },
	["MS05"] = { 99999999,5,1500 },
	["MS06"] = { 99999999,5,1500 },
	["MS07"] = { 99999999,5,1500 },
	["MS08"] = { 99999999,5,1500 },
	["MS09"] = { 99999999,5,1500 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------SANDYSHORE------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["SS01"] = { 99999999,5,1000 },
-----------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------SANDYSHORE------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
	["FZ01"] = { 99999999,5,1500 },

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local blipHomes = {}
local opened = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPHOMES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		blipHomes = {}
		for k,v in pairs(homes) do
			local checkHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(k) })
			if checkHomes[1] == nil then
				table.insert(blipHomes,{ name = tostring(k), price = parseInt(v[1]) })
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(30*60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOMES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('homes',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "add" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local totalResidents = vRP.query("homes/count_homepermissions",{ home = tostring(args[2]) })
				if parseInt(totalResidents[1].qtd) >= parseInt(homes[tostring(args[2])][2]) then
					TriggerClientEvent("Notify",source,"negado","A residência "..tostring(args[2]).." atingiu o máximo de moradores.",10000)
					return
				end

				vRP.execute("homes/add_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					TriggerClientEvent("Notify",source,"sucesso","Permissão na residência <b>"..tostring(args[2]).."</b> adicionada para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
				end
			end
		elseif args[1] == "rem" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
					local identity = vRP.getUserIdentity(parseInt(args[3]))
					if identity then
						TriggerClientEvent("Notify",source,"importante","Permissão na residência <b>"..tostring(args[2]).."</b> removida de <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "garage" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homeuser",{ user_id = parseInt(args[3]), home = tostring(args[2]) })
				if userHomes[1] then
					if vRP.tryFullPayment(user_id,50000) then
						vRP.execute("homes/upd_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]) })
						local identity = vRP.getUserIdentity(parseInt(args[3]))
						if identity then
							TriggerClientEvent("Notify",source,"sucesso","Adicionado a permissão da garagem a <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			end
		elseif args[1] == "list" then
			vCLIENT.setBlipsHomes(source,blipHomes)
		elseif args[1] == "check" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local userHomes = vRP.query("homes/get_homepermissions",{ home = tostring(args[2]) })
				if parseInt(#userHomes) > 1 then
					local permissoes = ""
					for k,v in pairs(userHomes) do
						if v.user_id ~= user_id then
							local identity = vRP.getUserIdentity(v.user_id)
							permissoes = permissoes.."<b>Nome:</b> "..identity.name.." "..identity.firstname.." - <b>Passaporte:</b> "..v.user_id
							if k ~= #userHomes then
								permissoes = permissoes.."<br>"
							end
						end
						Citizen.Wait(10)
					end
					TriggerClientEvent("Notify",source,"importante","Permissões da residência <b>"..tostring(args[2]).."</b>: <br>"..permissoes,19000)
				else
					TriggerClientEvent("Notify",source,"negado","Nenhuma permissão encontrada.",10000)
				end
			end
		elseif args[1] == "transfer" and homes[tostring(args[2])] then
			local myHomes = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = tostring(args[2]) })
			if myHomes[1] then
				local identity = vRP.getUserIdentity(parseInt(args[3]))
				if identity then
					local ok = vRP.request(source,"Transferir a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b> ?",30)
					if ok then
						vRP.execute("homes/rem_allpermissions",{ home = tostring(args[2]) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(args[3]), tax = parseInt(myHomes[1].tax) })
						TriggerClientEvent("Notify",source,"importante","Transferiu a residência <b>"..tostring(args[2]).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>.",10000)
					end
				end
			end
		elseif args[1] == "tax" and homes[tostring(args[2])] then
			local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(args[2]) })
			if ownerHomes[1] then
				--if not vRP.hasGroup(user_id,"Platina") then
					local house_price = parseInt(homes[tostring(args[2])][1])
					local house_tax = 0.10
					if house_price >= 9000000 then
						house_tax = 0.00
					end
					if vRP.tryFullPayment(user_id,parseInt(house_price * house_tax)) then
						vRP.execute("homes/rem_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id) })
						vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = parseInt(ownerHomes[1].user_id), tax = parseInt(os.time()) })
						TriggerClientEvent("Notify",source,"sucesso","Pagamento de <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b> efetuado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				--end
			end
		else
			local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if parseInt(#myHomes) >= 1 then
				for k,v in pairs(myHomes) do
					local ownerHomes = vRP.query("homes/get_homeuseridowner",{ home = tostring(v.home) })
					if ownerHomes[1] then
						local house_price = parseInt(homes[tostring(v.home)][1])
						local house_tax = 0.10
						if house_price >= 9000000 then
							house_tax = 0.00
						end

						if parseInt(os.time()) >= parseInt(ownerHomes[1].tax+24*15*60*60) then
							TriggerClientEvent("Notify",source,"negado","<b>Residência:</b> "..v.home.."<br><b>Property Tax:</b> Atrasado<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",19000)
						else
							TriggerClientEvent("Notify",source,"importante",""..v.home.."<br>Taxa em: "..vRP.getDayHours(parseInt(86400*15-(os.time()-ownerHomes[1].tax))).."<br>Valor: <b>$"..vRP.format(parseInt(house_price * house_tax)).." dólares</b>",19000)
						end
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myHomes = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
		if parseInt(#myHomes) >= 1 then
			for k,v in pairs(myHomes) do
				vCLIENT.setBlipsOwner(source,v.home)
				Citizen.Wait(10)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDOWNTIME
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1999)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 2
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local answered = {}
function src.checkPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			if not vRP.searchReturn(source,user_id) then
				local homeResult = vRP.query("homes/get_homepermissions",{ home = tostring(homeName) })
				if parseInt(#homeResult) >= 1 then
					local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
					local resultOwner = vRP.query("homes/get_homeuseridowner",{ home = tostring(homeName) })
					if myResult[1] then

						if homes[homeName][1] > 9000000 then
							return true
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*18*60*60) then

							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> venceu por <b>3 dias</b> e a casa foi vendida.",10000)
							return false
						elseif parseInt(os.time()) <= parseInt(resultOwner[1].tax+24*10*60*60) then
							return true
						else
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end
					else
						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*13*60*60)then
							local cows = vRP.getSData("chest:"..tostring(homeName))
							local rows = json.decode(cows) or {}
							if rows then
								vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(homeName) })
							end

							vRP.execute("homes/rem_allpermissions",{ home = tostring(homeName) })
							return false
						end

						if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*10*60*60) then
							TriggerClientEvent("Notify",source,"aviso","A <b>Property Tax</b> da residência está atrasada.",10000)
							return false
						end

						answered[user_id] = nil
						for k,v in pairs(homeResult) do
							local player = vRP.getUserSource(parseInt(v.user_id))
							if player then
								if not answered[user_id] then
									TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> tocou o interfone da residência <b>"..tostring(homeName).."</b>.<br>Deseja permitir a entrada do mesmo?",10000)
									local ok = vRP.request(player,"Permitir acesso a residência?",30)
									if ok then
										answered[user_id] = true
										return true
									end
								end
							end
							Citizen.Wait(10)
						end
					end
				else
					local ok = vRP.request(source,"Deseja efetuar a compra da residência <b>"..tostring(homeName).."</b> por <b>R$"..vRP.format(parseInt(homes[tostring(homeName)][1])).."</b> ?",30)
					if ok then
						if vRP.tryPayment(user_id,parseInt(homes[tostring(homeName)][1])) then
							vRP.execute("homes/buy_permissions",{ home = tostring(homeName), user_id = parseInt(user_id), tax = parseInt(os.time()) })
							TriggerClientEvent("Notify",source,"sucesso","A residência <b>"..tostring(homeName).."</b> foi comprada com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
						end
					end
					return false
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkIntPermissions(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
			if myResult[1] or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiagu.permissao") then
			--if myResult[1] then
				return true
			end
		end
	end
	return false
end

RegisterCommand('resethomes',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		opened = {}
		TriggerClientEvent("Notify",source,"sucesso","Os baús das casas foram recarregados.",10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('outfit',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local homeName = vCLIENT.getHomeStatistics(source)
		local myResult = vRP.query("homes/get_homeuser",{ user_id = parseInt(user_id), home = tostring(homeName) })
		if myResult[1] then
			local data = vRP.getSData("outfit:"..tostring(homeName))
			local result = json.decode(data) or {}
			if result then
				if args[1] == "save" and args[2] then
					local custom = vRPclient.getCustomPlayer(source)
					if custom then
						local outname = sanitizeString(rawCommand:sub(13),sanitizes.homename[1],sanitizes.homename[2])
						if result[outname] == nil and string.len(outname) > 0 then
							result[outname] = custom
							vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
							TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> adicionado com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"aviso","Nome escolhido já existe na lista de <b>Outfits</b>.",10000)
						end
					end
				elseif args[1] == "rem" and args[2] then
					local outname = sanitizeString(rawCommand:sub(12),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						result[outname] = nil
						vRP.setSData("outfit:"..tostring(homeName),json.encode(result))
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> removido com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				elseif args[1] == "apply" and args[2] then
					local outname = sanitizeString(rawCommand:sub(14),sanitizes.homename[1],sanitizes.homename[2])
					if result[outname] ~= nil and string.len(outname) > 0 then
						TriggerClientEvent("updateRoupas",source,result[outname])
						TriggerClientEvent("Notify",source,"sucesso","Outfit <b>"..outname.."</b> aplicado com sucesso.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Nome escolhido não encontrado na lista de <b>Outfits</b>.",10000)
					end
				else
					for k,v in pairs(result) do
						TriggerClientEvent("Notify",source,"importante","<b>Outfit:</b> "..k,19000)
						Citizen.Wait(10)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK OPENED CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkOpen(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not opened[homeName] then
			opened[homeName] = true
			return false
		else
			return true
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SET OPENED CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.setClose(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		opened[homeName] = false		
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(homeName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(homes[tostring(homeName)][3])
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.storeItem(homeName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if string.match(itemName,"dolar") or string.match(itemName,"lsd") then
				TriggerClientEvent("Notify",source,"negado","Não pode guardar este item.")
				return
			end

			local data = vRP.getSData("chest:"..tostring(homeName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
					if new_weight <= parseInt(homes[tostring(homeName)][3]) then
						if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
							if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then
								actived[parseInt(user_id)] = 4
								SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								if items[itemName] ~= nil then
									items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
								else
									items[itemName] = { amount = parseInt(amount) }
								end
								vRP.setSData("chest:"..tostring(homeName),json.encode(items))
								TriggerClientEvent('KSRP:UpdateVault',source,'updateVault')
							end
						end
					else
						TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
					end
				else
					local inv = vRP.getInventory(parseInt(user_id))
					for k,v in pairs(inv) do
						if itemName == k then
							local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(v.amount)
							if new_weight <= parseInt(homes[tostring(homeName)][3]) then
								if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
									if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(v.amount)) then
										actived[parseInt(user_id)] = 4
										if items[itemName] ~= nil then
											items[itemName].amount = parseInt(items[itemName].amount) + parseInt(v.amount)
										else
											items[itemName] = { amount = parseInt(v.amount) }
										end
										SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
										vRP.setSData("chest:"..tostring(homeName),json.encode(items))
										TriggerClientEvent('KSRP:UpdateVault',source,'updateVault')
									end
								end
							else
								TriggerClientEvent("Notify",source,"negado","<b>Vault</b> cheio.",8000)
							end
						end
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(homeName,itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			local data = vRP.getSData("chest:"..tostring(homeName))
			local items = json.decode(data) or {}
			if items then
				if parseInt(amount) > 0 then
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
							if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then
								actived[parseInt(user_id)] = 4
								SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(amount))
								items[itemName].amount = parseInt(items[itemName].amount) - parseInt(amount)
								if parseInt(items[itemName].amount) <= 0 then
									items[itemName] = nil
								end
								TriggerClientEvent('KSRP:UpdateVault',source,'updateVault')
								vRP.setSData("chest:"..tostring(homeName),json.encode(items))
							else
								TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
							end
						end
						
					end
				else
					if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
						if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
							if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(items[itemName].amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then
								actived[parseInt(user_id)] = 4
								SendWebhookMessage(webhookbaucasas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(items[itemName].amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..(tostring(homeName)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(items[itemName].amount))
								items[itemName] = nil
								TriggerClientEvent('KSRP:UpdateVault',source,'updateVault')
								vRP.setSData("chest:"..tostring(homeName),json.encode(items))
							else
								TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
							end
						end
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			return true
		end
		return false
	end
end

function src.checkIntStaff(homeName)
	local source = source
	local user_id = vRP.getUserId(source)
		if user_id then
				if vRP.hasPermission(user_id,"adm.permissao") then
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Você não tem permissão.",8000)
				end
		end
	return false
end