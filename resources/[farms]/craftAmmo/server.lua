local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("craftAmmo", src)
vCLIENT = Tunnel.getInterface("craftAmmo")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ itemReq = 'materialmunicao', qtdReq = 8, item = 'wammo_WEAPON_PISTOL_MK2', qtd = 250, perm = 'municao.permissao', dinheiroReq = 60000  }, --- FIVE
	{ itemReq = 'materialmunicao', qtdReq = 8, item = 'wammo_WEAPON_SAWNOFFSHOTGUN', qtd = 250, perm = 'municao.permissao', dinheiroReq = 67500  }, --- SHOTGUN
	{ itemReq = 'materialmunicao', qtdReq = 20, item = 'wammo_WEAPON_SMG_MK2', qtd = 250, perm = 'municao.permissao', dinheiroReq = 80000  }, --- SMG
	{ itemReq = 'materialmunicao', qtdReq = 8, item = 'wammo_WEAPON_APPISTOL', qtd = 250, perm = 'municao.permissao', dinheiroReq = 70000  }, --- APPISTOL

	{ itemReq = 'materialtec', qtdReq = 25, item = 'wammo_WEAPON_MACHINEPISTOL', qtd = 250, perm = 'municao.permissao', dinheiroReq = 80000  }, --- TEC
	{ itemReq = 'materialak', qtdReq = 45, item = 'wammo_WEAPON_ASSAULTRIFLE_MK2', qtd = 250, perm = 'municao.permissao', dinheiroReq = 115000  }, --- AK
	{ itemReq = 'materialg3', qtdReq = 45, item = 'wammo_WEAPON_SPECIALCARBINE_MK2', qtd = 250, perm = 'municao.permissao', dinheiroReq = 115000  }, --- G3
	--{ itemReq = 'polvora762', qtdReq = 55, item = 'wammo_WEAPON_SPECIALCARBINE', qtd = 250, perm = 'municao.permissao', dinheiroReq = 130000  } --- G3
}



function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("voult:ArmasTransformar")
AddEventHandler("voult:ArmasTransformar",function(item)
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
										TriggerClientEvent('voult:ArmasFecharNui', source)
										TriggerClientEvent('cancelando', source, true)
										TriggerClientEvent('voult:TravarPed', source, true)
										TriggerClientEvent('progress', source, 5000)
										TriggerClientEvent('armas:anin', source, true)
										Wait(5000)
										TriggerClientEvent('cancelando', source, false)
										TriggerClientEvent('voult:TravarPed', source, false)
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

										

										TriggerClientEvent('voult:ArmasFecharNui', source)
										TriggerClientEvent('cancelando', source, true)
										TriggerClientEvent('voult:TravarPed', source, true)
										TriggerClientEvent('progress', source, 5000)
										TriggerClientEvent('armas:anin', source, true)
										Wait(5000)
										TriggerClientEvent('cancelando', source, false)
										TriggerClientEvent('voult:TravarPed', source, false)
										vRP.giveInventoryItem(user_id, v.item, v.qtd)
										TriggerClientEvent("Notify",source,'sucesso',"Convertido: \n<b>"..v.qtdReq .. 'x ' .. vRP.itemNameList(v.itemReq).."</b> >> <b>"..v.qtd .. 'x ' .. vRP.itemNameList(v.item).."</b>")
									else
										TriggerClientEvent("Notify",source,'negado',"Falha na criação. " )
									end
								else
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
	if vRP.hasPermission(user_id, 'municao.permissao') or vRP.hasPermission(user_id,'suporte.permissao') then
		return true
	end
end
