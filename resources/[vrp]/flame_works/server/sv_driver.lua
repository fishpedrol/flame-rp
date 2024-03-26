-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
driveR = {}
Tunnel.bindInterface("vrp_driver",driveR)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookmotorista = "https://discord.com/api/webhooks/984163044538085396/cQ6Rpg8ESfTOstufF1W4yag_DOAySWTPv6A5QxvtNrgAQh9LpTSh-ORKy7n_rSzGwXu-"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function driveR.wv22jarGwz8RZbl2npU2KfVa50u6DmkazNnn(status,bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local value = (math.random(5000,8000)+bonus)

		if not status then
			vRP.giveMoney(user_id,parseInt(value))
		else
			vRP.giveMoney(user_id,parseInt(value))
		end
		
		TriggerClientEvent("Notify",source,"financeiro","Você recebeu <b>$"..vRP.format(parseInt(value)).." dólares</b>")
		SendWebhookMessage(webhookmotorista,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GANHOU NO MOTORISTA]: $"..value.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		TriggerClientEvent("vrp_sound:source",source,"coin",0.5)
	end
end