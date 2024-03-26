local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("cllt_weapons", src)
vCLIENT = Tunnel.getInterface("cllt_weapons")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ itemReq = 'pecadearma', qtdReq = 5, item = 'wbody_WEAPON_PISTOL_MK2', qtd = 1, perm = 'armas.permissao', dinheiroReq = 75000  }, --- FIVE 
	{ itemReq = 'pecadesub', qtdReq = 1, item = 'wbody_WEAPON_APPISTOL', qtd = 1, perm = 'armas.permissao', dinheiroReq = 85000  }, --- MP5 / APPISTOL
	{ itemReq = 'pecadesub', qtdReq = 1, item = 'wbody_WEAPON_SMG_MK2', qtd = 1, perm = 'armas.permissao', dinheiroReq = 90000  }, --- MP5 / APPISTOL
	{ itemReq = 'pecadeak', qtdReq = 1, item = 'wbody_WEAPON_ASSAULTRIFLE_MK2', qtd = 1, perm = 'armas.permissao', dinheiroReq = 175000  }, --- AK
	{ itemReq = 'pecadeg3', qtdReq = 1, item = 'wbody_WEAPON_SPECIALCARBINE_MK2', qtd = 1, perm = 'armas.permissao', dinheiroReq = 210000  }, --- G3
	{ itemReq = 'pecadeparafal', qtdReq = 1, item = 'wbody_WEAPON_SPECIALCARBINE', qtd = 1, perm = 'armas.permissao', dinheiroReq = 250000  }, --- G3
}

local craft = ''


function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("cllt:ArmasTransformar")
AddEventHandler("cllt:ArmasTransformar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.hasPermission(user_id, v.perm) or vRP.hasGroup(user_id,'Admin') then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.qtd <= vRP.getInventoryMaxWeight(user_id) then
							local garibas1 = vRP.getInventoryItemAmount(user_id,v.itemReq)
							local garibas2 = vRP.getInventoryItemAmount(user_id,'dinheirosujo')
							if garibas1 >= v.qtdReq then
								if not v.dinheiroReq then
									if vRP.tryGetInventoryItem(user_id,v.itemReq,v.qtdReq) then
										TriggerClientEvent('cllt:ArmasFecharNui', source)
										TriggerClientEvent('cancelando', source, true)
										TriggerClientEvent('cllt:TravarPed', source, true)
										TriggerClientEvent('progress', source, 5000)
										TriggerClientEvent('armas:anin', source, true)
										Wait(5000)
										TriggerClientEvent('cancelando', source, false)
										TriggerClientEvent('cllt:TravarPed', source, false)
										vRP.giveInventoryItem(user_id, v.item, v.qtd)
										TriggerClientEvent("Notify",source,'sucesso',"Convertido: \n<b>"..v.qtdReq .. 'x ' .. vRP.itemNameList(v.itemReq).."</b> >> <b>"..v.qtd .. 'x ' .. vRP.itemNameList(v.item).."</b>")
									else
										TriggerClientEvent("Notify",source,'negado',"Falha na criação. " )
									end
								elseif garibas2 >= v.dinheiroReq then

									if item == 'armacaodeak' then
											return
									end

									if vRP.tryGetInventoryItem(user_id,'dinheirosujo',v.dinheiroReq) and vRP.tryGetInventoryItem(user_id,v.itemReq,v.qtdReq) then

										

										TriggerClientEvent('cllt:ArmasFecharNui', source)
										TriggerClientEvent('cancelando', source, true)
										TriggerClientEvent('cllt:TravarPed', source, true)
										TriggerClientEvent('progress', source, 5000)
										TriggerClientEvent('armas:anin', source, true)
										Wait(5000)
										TriggerClientEvent('cancelando', source, false)
										TriggerClientEvent('cllt:TravarPed', source, false)
										vRP.giveInventoryItem(user_id, v.item, v.qtd)
										TriggerClientEvent("Notify",source,'sucesso',"Convertido: \n<b>"..v.qtdReq .. 'x ' .. vRP.itemNameList(v.itemReq).."</b> >> <b>"..v.qtd .. 'x ' .. vRP.itemNameList(v.item).."</b>")
									else
										TriggerClientEvent("Notify",source,'negado',"Falha na criação. " )
									end
								else
									print(v.itemReq)
									TriggerClientEvent("Notify",source,'negado',"Você não possui o dinheiro sujo necessário para isso. " )
								end
							else
								TriggerClientEvent("Notify",source,'negado',"Você não possui os componentes necessários para isso. " )
							end
						else
							TriggerClientEvent("Notify",source,'negado',"Espaço insuficiente.")
						end
				else
					TriggerClientEvent("Notify",source,'negado',"Você não tem permissão para isso.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAR PERMISSAO PRA ABRIR O MENU
-----------------------------------------------------------------------------------------------------------------------------------------
function src.permApply()
	local source = source
	local user_id= vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'armas.permissao') or vRP.hasPermission(user_id, 'suporte.permissao') then
		return true
	end
end
