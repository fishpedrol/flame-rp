local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local webhookFlamekill = ''

function SendWebhookMessage(webhook,message)
    PerformHttpRequest(webhook, function(E, F, G)end, "POST", json.encode({username = "Mc-Lobisomen",avatar_url = "https://cdn.discordapp.com/attachments/1222325998234763346/1222329452542034102/GDA5W4bWMAAGFfO.png?ex=6615d203&is=66035d03&hm=aa6f17d283894f0b4dc0b26a0c6a4f7439299efcd70f134d7f5642adfe4ffa8d&",embeds = {{color = 16711680,author = {name = 'KillSystem',icon_url = 'https://media.discordapp.net/attachments/761734472612708353/781269420634538034/LOGO_Thunder_Shop_2000x2000_Transparente_-_by_Design_Ideal.png'},description = message,footer = {text = 'Test',}}} }), {["Content-Type"] = "application/json"})
end

RegisterServerEvent('diedplayer')
AddEventHandler('diedplayer',function(killer,reason)
    local source = source
	local user_id = vRP.getUserId(source)
    if user_id ~= nil and webhookFlamekill ~= nil then
        if killer == "**Invalid**" or killer == source then
            SendWebhookMessage(webhookFlamekill,'\n\n[LOG KILL]\n[ID]: '..user_id..' se matou'..os.date('\n\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S')..'') 
        elseif killer == nil then
            SendWebhookMessage(webhookFlamekill,'\n\n[LOG KILL]\n[ID]: '..user_id..' se matou'..os.date('\n\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S')..'')
        elseif killer ~= nil then
            if reason == 1 then
                local killer_id = vRP.getUserId(killer)
                if killer_id then
                    SendWebhookMessage(webhookFlamekill,'\n\n[LOG KILL]\n[ID]: '..killer_id..' matou o '..user_id..''..os.date('\n\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S')..'')  
                end
            end
        end
    end
end)