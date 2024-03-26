local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("fsh_entrega",src)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local pagamento = {}
local total = 0

local quantidade = {}
local quantidade2 = {}

function src.Quantidade()
	local source = source

	if quantidade[source] == nil then
	   quantidade[source] = math.random(2,4)	
	end
	TriggerClientEvent("quantidade-drogas",source,parseInt(quantidade[source]))
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id, 'maconha') <= 0 and vRP.getInventoryItemAmount(user_id, 'cocaina') <= 0 
		and vRP.getInventoryItemAmount(user_id, 'metanfetamina') <= 0 and vRP.getInventoryItemAmount(user_id, 'ecstasy') <= 0 and vRP.getInventoryItemAmount(user_id, 'lsd') <= 0 then
			TriggerClientEvent("Notify",source,"negado","Número insuficiente de <b>Drogas</b>.")
		else
			local policia = vRP.getUsersByPermission("policia.permissao")
			local valorDroga = math.random(2000,4000) 
			local valorLSD = math.random(5000,7000)
				if #policia < 10 then 
                    valorDroga = math.random(4500,6000) 
					valorLSD = math.random(7000,10000)
                elseif #policia < 20 then
                    valorDroga = math.random(7000,9000) 
					valorLSD = math.random(10000,12000)
                elseif #policia < 30 then
                    valorDroga = math.random(10000,12000)
					valorLSD = math.random(13000,15000)
                else
                    valorDroga = math.random(2000,4000)
					valorLSD = math.random(5000,7000)
                end

			local totalPagamento = 0
			if vRP.getInventoryItemAmount(user_id, 'maconha') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"maconha",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorDroga * total
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end
			if vRP.getInventoryItemAmount(user_id, 'cocaina') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"cocaina",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorDroga * total
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end
			if vRP.getInventoryItemAmount(user_id, 'metanfetamina') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"metanfetamina",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorDroga * total
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end
			if vRP.getInventoryItemAmount(user_id, 'lsd') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"lsd",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorLSD * total
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end
			if vRP.getInventoryItemAmount(user_id, 'ecstasy') >= quantidade[source] then
				if vRP.tryGetInventoryItem(user_id,"ecstasy",quantidade[source]) then
					total = parseInt(quantidade[source])
					pagamento[source] = valorDroga * total
					totalPagamento = totalPagamento + pagamento[source]
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
					vRPclient._playAnim(source, true, {{"mp_common","givetake1_a"}}, false)
				end
			end
			if totalPagamento > 0 then
				vRP.giveInventoryItem(user_id, "dinheirosujo", totalPagamento)
				quantidade[source] = math.random(1,2)
				return true
			end			
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
function src.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local soldado = vRP.getUsersByPermission("policia.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent("NotifyPush",player,{ code = 64, title = "Denuncia de Trafico, dirija-se até o local.", x = x, y = y, z = z, badge = "Registo de Trafico" })
					SetTimeout(20000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
		PerformHttpRequest(webhookdrugs, function(err, text, headers) end, 'POST', json.encode({
			embeds = {
				{ 
					title = "REGISTRO DE DROGAS",
					thumbnail = {
					url = "https://i.imgur.com/dn0BXL9.png"
					}, 
					fields = {
						{ 
							name = "**QUEM FOI DENUNCIADO:**", 
							value = "` "..identity.name.." "..identity.firstname.." ["..user_id.."] `"
						}
					}, 
					footer = { 
						text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
						icon_url = "https://i.imgur.com/dn0BXL9.png" 
					},
					color = 15914080 
				}
			}
		}), { ['Content-Type'] = 'application/json' })
	end
end