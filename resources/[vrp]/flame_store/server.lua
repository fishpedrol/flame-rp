local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)



function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

local webhookdup = "https://discord.com/api/webhooks/984254067025018890/uxtm4-pwEmdhbSxU-MqXWFoNPW2_Pd2TGlukiC2Tqy3E4JxgmbBJxIf5oTzQdwDCrSbK"

function src.getItens(item, price, name) 
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if parseInt(price) < 999 then
        DropPlayer(source,"VOCE NAO PODE MEXER NO DEV TOOLS!!!!.")
        vRP.setBanned(user_id, 1)
        -- print(user_id)
        -- TriggerClientEvent("Notify", source, "sucesso","Sai do DEV TOOLS seu doente!!!")
        -- TriggerClientEvent("Notify", source, "sucesso","Sai do DEV TOOLS seu doente!!!")
        -- TriggerClientEvent("Notify", source, "sucesso","Sai do DEV TOOLS seu doente!!!")
        -- TriggerClientEvent("Notify", source, "sucesso","Sai do DEV TOOLS seu doente!!!")
        -- TriggerClientEvent("Notify", source, "sucesso","Sai do DEV TOOLS seu doente!!!")
        SendWebhookMessage(webhookdup, "@everyone \n\nO usuario **#"..user_id.." "..identity.name.." "..identity.firstname.."** foi **KICKADO** e automaticamente **BANIDO** por manipular o valor de um item na loja..")
        return false
    end

    if vRP.tryFullPayment(user_id, parseInt(price)) then 
        vRP.giveInventoryItem(user_id, item, 1)
        SendWebhookMessage(webhookdup, "O usuario **#"..user_id.." "..identity.name.." "..identity.firstname.."** comprou um "..name.." por "..vRP.format(price).." dólares.")
        TriggerClientEvent("Notify", source, "sucesso","Você comprou um "..name.." por "..vRP.format(price).." dólares.")
    else
        TriggerClientEvent("Notify", source, "negado","Você não possui "..vRP.format(price).." dólares.")
    end
end

function src.getinfo()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local carteira = vRP.getMoney(user_id)
		local banco = vRP.getBankMoney(user_id)
		local identity = vRP.getUserIdentity(user_id)
	end
end
    
function src.getinfo()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local carteira = vRP.getMoney(user_id)
    local banco = vRP.getBankMoney(user_id)
    local identity = vRP.getUserIdentity(user_id)
    if identity then 
        return vRP.format(parseInt(carteira)),vRP.format(parseInt(banco))
    end
end

