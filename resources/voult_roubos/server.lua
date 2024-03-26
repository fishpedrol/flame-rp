local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()

fishbolcat = {}
Tunnel.bindInterface("Roubos", fishbolcat)

vCLIENT = Tunnel.getInterface("Roubos")

local Cooldowns = {}
local police = {}
--local escalando = false
local PermissoesBloqueadas = {
    'policia.permissao',
    'policiaacao.permissao',
    'paisanapolicia.permissao',
    'medico.permissao',
    'bennys.permissao',
    'mecanico.permissao',
}

local webhookderoubos = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local CooldownAcao = {}

function shuffle(tbl)
    local temp = {}
    for k, v in pairs(tbl) do
        table.insert(temp, k)
    end
    for i = #temp, 2, -1 do
        local j = math.random(i)
        temp[i], temp[j] = temp[j], temp[i]
    end
    return temp
end

function fishbolcat.CheckCooldown(Lugar, TempoCooldown, ItemNecessario, MinPolicia, PermDosPm, Estabelecimento, x, y, z, MaxPolicia, Prioridade, time)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local horaAgora = os.time()

    for k, v in pairs(PermissoesBloqueadas) do
        if vRP.hasPermission(user_id, v) then
            TriggerClientEvent('Notify', source, 'negado', 'Você não pode fazer isso.')
            return false
        end
    end

    if not Cooldowns[Lugar] or horaAgora >= Cooldowns[Lugar] + TempoCooldown then

        local policia = vRP.getUsersByPermission(PermDosPm)
        -- CHECA MIN POLICIA
        if MinPolicia and MinPolicia > 0 then
            if #policia < MinPolicia then
                TriggerClientEvent('Notify', source, 'negado', 'Não há contingente policial para isso, aguarde.')
                return false
            end
        end
        
        for k,v in pairs(policia) do
            local player = vRP.getUserSource(parseInt(v))
            if player then
                async(function()
                    local id = idgens:gen()
                    TriggerClientEvent("NotifyPushRoubos",player,{ code = '157', user_idd = user_id, name = identity.name, firstname = identity.firstname, title = "Roubo a(o) "..Estabelecimento, x = x, y = y, z = z, time = time})
		            --TriggerEvent("NotifyPush",{ code = '10-71', title = "Disparos de arma de fogo", x = x, y = y, z = z, time = time})
                    police[id] = vRPclient.addBlip(player,x,y,z,437,1,"Roubo a(o) " .. Estabelecimento,0.8,false)
                    SetTimeout(80000,function() vRPclient.removeBlip(player,police[id]) idgens:free(id) end)
                end)
            end
        end

        -- RETORNA OK
        --vRPclient.setStandBY(source,parseInt(500)) -- Seta procurado
        --vCLIENT.SetMochila(source)
        Cooldowns[Lugar] = horaAgora
        SendWebhookMessage(webhookderoubos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.."\n[INICIOU " .. Estabelecimento .. "]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        vRPclient.playAnim(source, false, {"anim@heists@ornate_bank@grab_cash", "grab"}, true)
        Citizen.Wait(50)
        --escalando = false
        return true

    end
    TriggerClientEvent('Notify', source, 'negado', 'Roubo em espera, aguarde <b>' .. (Cooldowns[Lugar]+TempoCooldown) - horaAgora .. 's</b>.')
    --escalando = false
    return false
end


function fishbolcat.sexodeanao(Estabelecimento, Recompensa)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local item = 'dinheirosujo'
    if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(item)*parseInt(Recompensa) <= vRP.getInventoryMaxWeight(user_id) then
        vRP.giveInventoryItem(user_id,item,Recompensa)
        TriggerEvent('ranking:update', source, 1, Recompensa)
        SendWebhookMessage(webhookderoubos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.. "\n[RECEBEU]: $" .. vRP.format(Recompensa) .. 'x Dinheiro Sujo' .. "\n[FINALIZOU " .. Estabelecimento .. "]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        return
    end
    TriggerClientEvent('Notify', source, 'negado', 'O dinheiro não cabe na sua mochila.')
    return false
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end