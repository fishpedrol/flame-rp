local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
pizzA = {}
Tunnel.bindInterface("uber",pizzA)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function pizzA.PegarPlaca()
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	return identity.registration
end

local webhookpizza = "https://discord.com/api/webhooks/984162995569582260/s8jOHQHhEQzKEXGUBybpQY08IkY1lDsOlBvefoyqfI6PZdQ4Q_Pd0QSFNrB6B9GOtYWa"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


function pizzA.x6NiGfpALlLSxRi()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		randmoney = math.random(2000,3500)
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		TriggerClientEvent("Notify",source,"financeiro","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
		SendWebhookMessage(webhookpizza,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GANHOU NO PIZZA]: $"..randmoney.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		return true
	end
end