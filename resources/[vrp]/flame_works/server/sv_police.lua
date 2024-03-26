local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
policia = {}
Tunnel.bindInterface("emp_policia",policia)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------

local webhookrotapolicia = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function policia.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"policia.permissao")
end

function policia.IcyuiAAvgbU5sDX()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        randmoney = math.random(1000,2432)
        vRP.giveMoney(user_id,parseInt(randmoney))
        TriggerClientEvent("Notify",source,"financeiro","Você recebeu <b>$"..parseInt(randmoney).." dólares</b>.")
        SendWebhookMessage(webhookrotapolicia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GANHOU NO MOTORISTA]: $"..randmoney.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
    end
end