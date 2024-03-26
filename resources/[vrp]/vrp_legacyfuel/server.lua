local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("vrp_legacyfuel:pagamento5")
AddEventHandler("vrp_legacyfuel:pagamento5",function(price,galao,vehicle,fuel,fuel2)
	local user_id = vRP.getUserId(source)
	if user_id and price > 0 then
		if vRP.tryFullPayment(user_id,price) then
			TriggerClientEvent('syncfuel',-1,vehicle,fuel)
			TriggerClientEvent("Notify",source,"sucesso","Pagou <b>$"..vRP.format(price).." dólares</b> em combustível.",8000)
		else
			TriggerClientEvent('vrp_legacyfuel:insuficiente5',source,vehicle,fuel2)
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",8000)
		end
	end
end)