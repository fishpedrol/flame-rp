local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_inventory",vRPN)
Proxy.addInterface("vrp_inventory",vRPN)

client = Tunnel.getInterface("vrp_inventory_client")

local idgens = Tools.newIDGenerator()

vGARAGE = Tunnel.getInterface("vrp_garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookequipar = ""
local webhookenviaritem = ""
local webhookdropar = ""
local webhookadrenalina = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
    
function vRPN.getinfo()
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local carteira = vRP.getMoney(user_id)
    local banco = vRP.getBankMoney(user_id)
    local identity = vRP.getUserIdentity(user_id)
    if identity then 
        return vRP.format(parseInt(carteira)),vRP.format(parseInt(banco))
    end
end


function vRPN.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	local inventario = {}
	if data and data.inventory then
		for k,v in pairs(data.inventory) do
			if vRP.itemBodyList(k) then
				table.insert(inventario,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
			end
		end
		return inventario,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.sendItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(nplayer)
		local identity = vRP.getUserIdentity(user_id)
		local identitynu = vRP.getUserIdentity(nuser_id)
		local job = vRP.getUserGroupByType(user_id,"job")
		local job2 = vRP.getUserGroupByType(nuser_id,"job")
		if nuser_id and vRP.itemIndexList(itemName) and item ~= vRP.itemIndexList("identidade") then
			if parseInt(amount) > 0 then
				if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,itemName,amount) then
						vRP.giveInventoryItem(nuser_id,itemName,amount)
						vRPclient._playAnim(source,true,{"mp_common","givetake1_a"},false)
						TriggerClientEvent("Notify",source,'sucesso',"Enviou <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						SendWebhookMessage(webhookenviaritem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: "..vRP.format(amount).." "..vRP.itemNameList(itemName).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." \n[SET ENVIOU]: "..job.." \n[SET RECEBEU]: "..job2.."  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
						TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						vRPclient._playAnim(nplayer,true,{"mp_common","givetake1_a"},false)
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
						return true
					end
				end
			else
				local data = vRP.getUserDataTable(user_id)
				for k,v in pairs(data.inventory) do
					if itemName == k then
						if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * parseInt(v.amount) <= vRP.getInventoryMaxWeight(nuser_id) then
							if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
								vRP.giveInventoryItem(nuser_id,itemName,parseInt(v.amount))
								vRPclient._playAnim(source,true,{"mp_common","givetake1_a"},false)
								TriggerClientEvent("Notify",source,'sucesso',"Enviou <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								SendWebhookMessage(webhookenviaritem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." \n[SET]: "..job.." \n[SET RECEBEU]: "..job2.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								vRPclient._playAnim(nplayer,true,{"mp_common","givetake1_a"},false)
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
end
------------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local BlacklistDelete = {
	"dinheirosujo",
	"capsula9mm",
	"capsula762",
	"capuz",
	"lockpick",
	"funcionalpol",
	"polvora9mm",
	"polvora762",
	"masterpick",
	"orgao",
	"relogioroubado",
	"pulseiraroubada",
	"anelroubado",
	"colarroubado",
	"brincoroubado",
	"carteiraroubada",
	"tabletroubado",
	"sapatosroubado",
	"armacaodearma",
	"armacaodetec",
	"pecadearma",
	"pecadetec",
	"funcionalpol",
	"materialarmas",
	"materialtec",
	"armacaodemp5",
	"armacaodeak",
	"materialmp5",
	"pecademp5",
	"pecadeak",
	"materialak",
	"materialg3",
	"pecadeg3",
	"armacaodeg3",
	"materiallsd",
	"material762",
	"materialmaconha",
	"materialcocaina",
	"material9mm",
	"materiallanca",
	"cartaodesmanche",
	"kiteletronico",
	"baseado",
	"maconhamacerada",
	"folhademaconha",
	"complsd",
	"compeletronico",
	"acidolisergico",
	"lsd",
	"metanfetamina",
	"folhadecoca",
	"cocamisturada",
	"cocaina",
	"complanca",
	"compferramenta",
	"eterecloroformio",
	"lancaperfume",
	"metanfetamina",
	"logsinvasao",
	"acessodeepweb",
	"fivequebrada",
    "desertquebrada",
    "glockquebrada",
    "m4quebrada",
    "mpxquebrada",
    "escopetaquebrada",
    "shotgunquebrada",
    "g36quebrada",
    "fajutaquebrada",
    "akquebrada",
    "tec9quebrada",
    "mp5quebrada",
    "mp5mk2quebrada",
    "sigsauerquebrada",
	"keysinvasao",
	"pendriveinformacoes",
	"keycard",
	"c4",
	"serra",
	"furadeira",

	
	"wbody_WEAPON_DAGGER",
	"wbody_WEAPON_BAT",
	"wbody_WEAPON_BOTTLE",
	"wbody_WEAPON_CROWBAR",
	"wbody_WEAPON_FLASHLIGHT",
	"wbody_WEAPON_GOLFCLUB",
	"wbody_WEAPON_HAMMER",
	"wbody_WEAPON_HATCHET",
	"wbody_WEAPON_KNUCKLE",
	"wbody_WEAPON_KNIFE",
	"wbody_WEAPON_MACHETE",
	"wbody_WEAPON_SWITCHBLADE",
	"wbody_WEAPON_NIGHTSTICK",
	"wbody_WEAPON_WRENCH",
	"wbody_WEAPON_BATTLEAXE",
	"wbody_WEAPON_POOLCUE",
	"wbody_WEAPON_STONE_HATCHET",
	"wbody_WEAPON_PISTOL",
	"wbody_WEAPON_COMBATPISTOL",
	"wbody_WEAPON_CARBINERIFLE",
	"wbody_WEAPON_SMG",
	"wbody_WEAPON_SAWNOFFSHOTGUN",
	"wbody_WEAPON_STUNGUN",
	"wbody_WEAPON_NIGHTSTICK",
	"wbody_WEAPON_SNSPISTOL",
	"wbody_WEAPON_MICROSMG",
	"wbody_WEAPON_ASSAULTRIFLE_MK2",
	"wbody_WEAPON_COMBATPDW",
	"wbody_WEAPON_FIREEXTINGUISHER",
	"wbody_WEAPON_FLARE",
	"wbody_WEAPON_REVOLVER",
	"wbody_WEAPON_PISTOL_MK2",
	"wbody_WEAPON_HEAVYPISTOL",
	"wbody_WEAPON_VINTAGEPISTOL",
	"wbody_WEAPON_MUSKET",
	"wbody_WEAPON_GUSENBERG",
	"wbody_WEAPON_ASSAULTSMG",
	"wbody_WEAPON_SMG_MK2",
	"wbody_WEAPON_PUMPSHOTGUN",
	"wbody_WEAPON_COMPACTRIFLE",
	"wbody_WEAPON_CARBINERIFLE_MK2",
	"wbody_WEAPON_MACHINEPISTOL",
	 

	"wammo_WEAPON_DAGGER",
	"wammo_WEAPON_BAT",
	"wammo_WEAPON_BOTTLE",
	"wammo_WEAPON_CROWBAR",
	"wammo_WEAPON_FLASHLIGHT",
	"wammo_WEAPON_GOLFCLUB",
	"wammo_WEAPON_HAMMER",
	"wammo_WEAPON_HATCHET",
	"wammo_WEAPON_KNUCKLE",
	"wammo_WEAPON_KNIFE",
	"wammo_WEAPON_MACHETE",
	"wammo_WEAPON_SWITCHBLADE",
	"wammo_WEAPON_NIGHTSTICK",
	"wammo_WEAPON_WRENCH",
	"wammo_WEAPON_BATTLEAXE",
	"wammo_WEAPON_POOLCUE",
	"wammo_WEAPON_STONE_HATCHET",
	"wammo_WEAPON_PISTOL",
	"wammo_WEAPON_COMBATPISTOL",
	"wammo_WEAPON_CARBINERIFLE",
	"wammo_WEAPON_SMG",
	"wammo_WEAPON_PUMPSHOTGUN",
	"wammo_WEAPON_SAWNOFFSHOTGUN",
	"wammo_WEAPON_STUNGUN",
	"wammo_WEAPON_NIGHTSTICK",
	"wammo_WEAPON_SNSPISTOL",
	"wammo_WEAPON_MICROSMG",
	"wammo_WEAPON_ASSAULTRIFLE_MK2",
	"wammo_WEAPON_FIREEXTINGUISHER",
	"wammo_WEAPON_FLARE",
	"wammo_WEAPON_REVOLVER",
	"wammo_WEAPON_PISTOL_MK2",
	"wammo_weapon_specialcarbine_mk2",
	"wammo_WEAPON_COMBATPDW",
	"wammo_WEAPON_HEAVYPISTOL",
	"wammo_WEAPON_VINTAGEPISTOL",
	"wammo_WEAPON_MUSKET",
	"wammo_WEAPON_GUSENBERG",
	"wammo_WEAPON_ASSAULTSMG",
	"wammo_WEAPON_SMG_MK2",
	"wammo_WEAPON_MACHINEPISTOL",
	"wammo_WEAPON_CARBINERIFLE_MK2",
	"wammo_WEAPON_COMPACTRIFLE"
}

function vRPN.dropItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local x,y,z = vRPclient.getPosition(source)
		-- BLOQUEIA A DESTRUIÇÃO DE CERTOS ITENS
		for k, v in pairs(BlacklistDelete) do
			if itemName == v then 
				TriggerClientEvent('Notify', source, 'negado','Você não pode destruir esse tipo de item.')
				return
			end
		end

		if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,itemName,amount) then
			vRPclient._playAnim(source,true,{"pickup_object","pickup_low"},false)
			SendWebhookMessage(webhookdropar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DESTRUIU]: "..vRP.itemNameList(itemName).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			TriggerClientEvent('Creative:Update',source,'updateMochila')
			return true
		else
			local data = vRP.getUserDataTable(user_id)
			for k,v in pairs(data.inventory) do
				if itemName == k then
					if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
						vRPclient._playAnim(source,true,{"pickup_object","pickup_low"},false)
						SendWebhookMessage(webhookdropar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DESTRUIU]: "..vRP.itemNameList(itemName).." \n[QUANTIDADE]: "..vRP.format(parseInt(v.amount)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						return true
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
local bandagem = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(bandagem) do
			if v > 0 then
				bandagem[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local pick = {}
local blips = {}
local usando = {}
function vRPN.useItem(itemName,type,ramount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and ramount ~= nil and parseInt(ramount) >= 0 and not actived[user_id] and actived[user_id] == nil then
		if type == "usar" then
			if itemName == "bandagem" then
				if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 399 then
	
					if bandagem[user_id] == 0 or not bandagem[user_id] then
						if vRP.tryGetInventoryItem(user_id,"bandagem",1) then
							bandagem[user_id] = 120
							actived[user_id] = true
							vRPclient._CarregarObjeto(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)
							TriggerClientEvent('Creative:Update',source,'updateMochila')
							TriggerClientEvent('rusher:DesativarAtirar', source, true)
							TriggerClientEvent("cancelando",source,true)
							TriggerClientEvent("progress",source,4000)
							SetTimeout(8000,function()
								actived[user_id] = nil
								TriggerClientEvent('rusherbandagem',source)
								TriggerClientEvent("cancelando",source,false)
								TriggerClientEvent('rusher:DesativarAtirar', source, false)
								vRPclient._DeletarObjeto(source)
								TriggerClientEvent("Notify",source,'sucesso',"Bandagem utilizada com sucesso.",8000)
							end)
						end
					else
						TriggerClientEvent("Notify",source,'negado',"Aguarde "..vRPclient.getTimeFunction(source,parseInt(bandagem[user_id]))..".",8000)
					end
				else
				TriggerClientEvent("Notify",source,'aviso',"Você não pode utilizar de vida cheia ou nocauteado.",8000)
			end
            elseif itemName == "xerelto" then
                if vRP.tryGetInventoryItem(user_id,"xerelto",1) then
                	vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","ng_proc_drug01a002",49,60309)
                	TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('rusher:DesativarAtirar', source, true)
                    TriggerClientEvent("progress",source,20500,"xerelto")
                    SetTimeout(20500,function()
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('rusher:DesativarAtirar', source, false)
                        TriggerClientEvent("resetBleeding",source)
                        vRPclient._DeletarObjeto(source)
                        TriggerClientEvent("Notify",source,'sucesso',"xerelto utilizado com sucesso.",8000)
                    end)
                end
            elseif itemName == "coumadin" then
                if vRP.tryGetInventoryItem(user_id,"coumadin",1) then
                	vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","ng_proc_drug01a002",49,60309)
                	TriggerClientEvent('Creative:Update',source,'updateMochila')	
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('rusher:DesativarAtirar', source, true)
                    TriggerClientEvent("progress",source,20500,"coumadin")
                    SetTimeout(20500,function()
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('rusher:DesativarAtirar', source, false)
                        TriggerClientEvent("resetBleeding",source)
                        vRPclient._DeletarObjeto(source)
                        TriggerClientEvent("Notify",source,'sucesso',"Coumadin utilizado com sucesso.",8000)
                    end)
                end
            elseif itemName == "corda" then
				local nsource = vRPclient.getNearestPlayer(source, 2)
				if nsource then
					if not vRPclient.isHandcuffed(source) and vRPclient.isHandcuffed(nsource) then
						if vRP.tryGetInventoryItem(user_id,'corda',1) then
							TriggerClientEvent('carregar',nsource,source)
							SetTimeout(20000,function()
								TriggerClientEvent('carregar',nsource,source)
							end)
						end
					end
				end
			elseif itemName == "kittid" then
				local nplayer = vRPclient.getNearestPlayer(source, 3)
				if nplayer then
					if vRP.getInventoryItemAmount(user_id,'kittid') > 0 then
						client.FecharInventario(source)
						Wait(200)
						TriggerClientEvent('rusher:AbrirKitAnalise',source)
					end
				else
					TriggerClientEvent("Notify",source,'negado',"Não há ninguém por perto para ser analisado.",8000)
				end
            elseif itemName == "celular" then
                TriggerEvent('rusher:GcPhone:ToggleAviao', user_id)
			elseif itemName == "dorflex" or itemName == "cicatricure" or itemName == "dipiroca" or itemName == "nocucedin" or itemName == "paracetanal" or itemName == "decupramim" or itemName == "buscopau" or itemName == "navagina" or itemName == "analdor" or itemName == "sefodex" or itemName == "nokusin" or itemName == "glicoanal" then
				if (vRP.tryGetInventoryItem(user_id,"dorflex",1) or vRP.tryGetInventoryItem(user_id,"cicatricure",1) or vRP.tryGetInventoryItem(user_id,"dipiroca",1) or vRP.tryGetInventoryItem(user_id,"nocucedin",1) or vRP.tryGetInventoryItem(user_id,"paracetanal",1) or vRP.tryGetInventoryItem(user_id,"decupramim",1) or vRP.tryGetInventoryItem(user_id,"buscopau",1) or vRP.tryGetInventoryItem(user_id,"navagina",1) or vRP.tryGetInventoryItem(user_id,"analdor",1) or vRP.tryGetInventoryItem(user_id,"sefodex",1) or vRP.tryGetInventoryItem(user_id,"nokusin",1) or vRP.tryGetInventoryItem(user_id,"glicoanal",1)) then
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_intdrink","loop_bottle"}},true)	
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('rusher:DesativarAtirar', source, true)
					TriggerClientEvent("progress",source,5000,"remedio")
					SetTimeout(5000,function()
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('rusher:DesativarAtirar', source, false)
						TriggerClientEvent("Notify",source,'sucesso',"Remédio utilizado com sucesso.",8000)
					end)
				end	
			elseif itemName == "mochila" then
				if vRP.tryGetInventoryItem(user_id,"mochila",1) then
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					-- vRP.varyExp(user_id,"physical","strength",650)
					vRP.varyExp(user_id, "physical", "strength", 650)
					TriggerClientEvent("Notify",source,'sucesso',"Mochila utilizada com sucesso.",8000)
				end
			elseif itemName == "cerveja" then
				if vRP.tryGetInventoryItem(user_id,"cerveja",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,30000,"bebendo")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,'sucesso',"Cerveja utilizada com sucesso.",8000)
					end)
				end
			elseif itemName == "tequila" then
				if vRP.tryGetInventoryItem(user_id,"tequila",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,30000,"bebendo")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,'sucesso',"Tequila utilizada com sucesso.",8000)
					end)
				end
			elseif itemName == "vodka" then
				if vRP.tryGetInventoryItem(user_id,"vodka",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,30000,"bebendo")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,'sucesso',"Vodka utilizada com sucesso.",8000)
					end)
				end
			elseif itemName == "whisky" then
				if vRP.tryGetInventoryItem(user_id,"whisky",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,30000,"bebendo")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,'sucesso',"Whisky utilizado com sucesso.",8000)
					end)
				end
			elseif itemName == "conhaque" then
				if vRP.tryGetInventoryItem(user_id,"conhaque",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,30000,"bebendo")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,'sucesso',"Conhaque utilizado com sucesso.",8000)
					end)
				end
			elseif itemName == "absinto" then
				if vRP.tryGetInventoryItem(user_id,"absinto",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,30000,"bebendo")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,'sucesso',"Absinto utilizado com sucesso.",8000)
					end)
				end

			elseif itemName == "baseado" then
				if vRP.tryGetInventoryItem(user_id,"baseado",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{task='WORLD_HUMAN_DRUG_DEALER'},true)
					-- vRPclient._playAnim(false,{task='WORLD_HUMAN_DRUG_DEALER'},false)
					TriggerClientEvent("progress",source,10000,"subindo balao")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,'sucesso',"Maconha utilizada com sucesso.",8000)
					end)
				end
			elseif itemName == "aliancaouro" then
				TriggerEvent('rusher:Relacionamento:Casar', user_id)
			elseif itemName == "aliancaprata" then
				TriggerEvent('rusher:Relacionamento:Namorar', user_id)
			elseif itemName == "cocaina" then
				if vRP.tryGetInventoryItem(user_id,"cocaina",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{"mp_player_int_uppersmoke","mp_player_int_smoke"},true)
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('rusher:DesativarAtirar', source, true)
					TriggerClientEvent("progress",source,10000,"dando um teco")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						--TriggerClientEvent('energeticos',source,true)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('rusher:DesativarAtirar', source, false)
						vRPclient.playScreenEffect(source,"RaceTurbo",120)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",120)
						TriggerClientEvent("Notify",source,'sucesso',"Cocaína utilizada com sucesso.",8000)
					end)
					SetTimeout(120000,function()
						TriggerClientEvent('energeticos',source,false)
						TriggerClientEvent("Notify",source,'aviso',"Aviso","O efeito da cocaína passou e o coração voltou a bater normalmente.",8000)
					end)
				end
			elseif itemName == "krokodil" then
				if vRP.tryGetInventoryItem(user_id,"krokodil",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{"mp_player_int_uppersmoke","mp_player_int_smoke"},true)
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('rusher:DesativarAtirar', source, true)
					TriggerClientEvent("progress",source,10000,"dando um teco")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						--TriggerClientEvent('energeticos',source,true)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('rusher:DesativarAtirar', source, false)
						vRPclient.playScreenEffect(source,"RaceTurbo",120)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",120)
						TriggerClientEvent("Notify",source,'sucesso',"Krokodil utilizada com sucesso.",8000)
						SetTimeout(5000, function()
							vRPclient._setHealth(source, 101)
						end)
					end)
				end
			elseif itemName == "metanfetamina" then
				if vRP.tryGetInventoryItem(user_id,"metanfetamina",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{"mp_player_int_uppersmoke","mp_player_int_smoke"},true)
					TriggerClientEvent("progress",source,10000,"fumando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,'sucesso',"Metanfetamina utilizada com sucesso.",8000)
					end)
				end	
			elseif itemName == "lancaperfume" then
				if vRP.tryGetInventoryItem(user_id,"lancaperfume",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient.CarregarObjeto(source, "amb@world_human_drinking@beer@male@idle_a","idle_a","j_lancaperf",49,28422)
					TriggerClientEvent("progress",source,10000,"baforando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,'sucesso',"Lança perfume utilizada com sucesso.",8000)
					end)
				end	
			elseif itemName == "lsd" then
				if vRP.tryGetInventoryItem(user_id,"lsd",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{"mp_player_int_uppersmoke","mp_player_int_smoke"},true)
					TriggerClientEvent("progress",source,10000,"dropando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,'sucesso',"LSD utilizado com sucesso.",8000)
					end)
				end		
			elseif itemName == "rebite" then
				if vRP.tryGetInventoryItem(user_id,"rebite",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('rusher:DesativarAtirar', source, true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"bebendo")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",90)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",90)
						TriggerClientEvent('energeticos',source)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('rusher:DesativarAtirar', source, false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,'sucesso',"Rebite utilizado com sucesso.",8000)
					end)
				end
			elseif itemName == "capuz" then
				if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
					local nplayer = vRPclient.getNearestPlayer(source,2)
					if nplayer then
						vRPclient.setCapuz(nplayer)
						vRP.closeMenu(nplayer)
						TriggerClientEvent("Notify",source,'sucesso',"Capuz utilizado com sucesso.",8000)
					end
				end
			elseif itemName == "energetico" then
				if usando[user_id] then TriggerClientEvent("Notify",source,'negado',"Você já está realizando uma ação!",8000) return end
				usando[user_id] = true
				if vRP.tryGetInventoryItem(user_id,"energetico",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					--TriggerClientEvent('rusher:DesativarAtirar', source, true)
					--vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","prop_energy_drink",49,60309,0.0,0.0,0.0,0.0,0.0,130.0)
					TriggerClientEvent("progress",source,4000,"bebendo")
					SetTimeout(7000,function()
						actived[user_id] = nil
						TriggerClientEvent('energeticos',source)
						TriggerClientEvent('cancelando',source,false)
						--TriggerClientEvent('rusher:DesativarAtirar', source, false)

						TriggerClientEvent("Notify",source,'sucesso',"Energético utilizado com sucesso.",8000)
					end)
					usando[user_id] = false
				end
			elseif itemName == "melzinho" then
				if usando[user_id] then TriggerClientEvent("Notify",source,'negado',"Você já está realizando uma ação!",8000) return end
				usando[user_id] = true
				if vRP.tryGetInventoryItem(user_id,"melzinho",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					--TriggerClientEvent('rusher:DesativarAtirar', source, true)
					--vRPclient._CarregarObjeto(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)
					TriggerClientEvent("progress",source,6000,"usando")
					SetTimeout(7000,function()
						actived[user_id] = nil
						TriggerClientEvent('melzinho',source)
						TriggerClientEvent('rusherbandagem',source)
						TriggerClientEvent('cancelando',source,false)
						--TriggerClientEvent('rusher:DesativarAtirar', source, false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,'sucesso',"Melzinho utilizado com sucesso.",8000)
					end)
					usando[user_id] = false
				end
			elseif itemName == "lockpick" then
				local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
				
				if vRP.vehicleType(vname) == 'exclusive' then
					TriggerClientEvent('Notify', source, 'negado', 'Lockpick comum não funciona em veículos exclusivo!') 
					return
				end

				if vRP.vehicleType(vname) == 'import' then 
					TriggerClientEvent('Notify', source, 'negado', 'Lockpick comum não funciona em veículos importados!') 
					return 
				end

				if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and vRP.tryGetInventoryItem(user_id,"lockpick",1) and vehicle then
					actived[user_id] = true

					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
					TriggerClientEvent("progress",source,8000,"roubando")
					SetTimeout(8000,function()
						actived[user_id] = nil
						TriggerClientEvent('cancelando',source,false)
						if not vRPclient.FazendoAnim(source, "amb@prop_human_parking_meter@female@idle_a", "idle_a_female") then 
							return 
						end

						vRPclient._stopAnim(source,false)

						local iddoroubado = vRP.getUserByRegistration(placa)
						local nuser_id = vRP.getUserSource(iddoroubado)
						if iddoroubado then
							TriggerClientEvent("Notify",nuser_id,"aviso","Veículo <b>"..vRP.vehicleName(vname).."</b> foi roubado.",7000)
						end

						if math.random(100) >= 60 then
							TriggerEvent("setPlateEveryone",placa)
							vGARAGE.vehicleClientLock(-1,vnetid,lock)
							TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
						else
							TriggerClientEvent("Notify",source,'negado',"Roubo do veículo falhou e as autoridades foram acionadas.",8000)
							local policia = vRP.getUsersByPermission("policia.permissao")
							local x,y,z = vRPclient.getPosition(source)
							for k,v in pairs(policia) do
								local player = vRP.getUserSource(parseInt(v))
								if player then
									async(function()
										local id = idgens:gen()
										TriggerClientEvent("NotifyPush",player,{ code = 31, title = "Roubo de Veículo", x = x, y = y, z = z, badge = model.." - "..placa })
										pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
										SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
									end)
								end
							end
						end

					end)
				end
			elseif itemName == "masterpick" then
				local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
				if vRP.getInventoryItemAmount(user_id,"masterpick") >= 1 and vehicle then
					actived[user_id] = true

					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
					TriggerClientEvent("progress",source,12000)
					SetTimeout(12000,function()
						actived[user_id] = nil
						TriggerClientEvent('cancelando',source,false)
						if not vRPclient.FazendoAnim(source, "amb@prop_human_parking_meter@female@idle_a", "idle_a_female") then 
							return 
						end

						vRPclient._stopAnim(source,false)

						if parseInt(math.random(1000)) >= 950 then
							vRP.tryGetInventoryItem(user_id,itemName,1)
						end

						local iddoroubado = vRP.getUserByRegistration(placa)
						local nuser_id = vRP.getUserSource(iddoroubado)
						if iddoroubado then
							TriggerClientEvent("Notify",nuser_id,"aviso","Veículo <b>"..vRP.vehicleName(vname).."</b> foi roubado.",7000)
						end

						if math.random(100) >= 20 then
							TriggerEvent("setPlateEveryone",placa)
							vGARAGE.vehicleClientLock(-1,vnetid,lock)
							TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
						else
							TriggerClientEvent("Notify",source,'negado',"Roubo do veículo falhou e as autoridades foram acionadas.",8000)
							local policia = vRP.getUsersByPermission("policia.permissao")
							local x,y,z = vRPclient.getPosition(source)
							for k,v in pairs(policia) do
								local player = vRP.getUserSource(parseInt(v))
								if player then
									async(function()
										local id = idgens:gen()
										TriggerClientEvent("NotifyPush",player,{ code = 31, title = "Roubo de Veículo", x = x, y = y, z = z, badge = model.." - "..placa })
										pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
										SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
									end)
								end
							end
						end
					end)
				end
			elseif itemName == "militec" then
				local mecanicos = vRP.getUsersByPermission('mecanico.permissao')
				if #mecanicos > 1 and not vRP.hasPermission(user_id, 'mecanico.permissao') then TriggerClientEvent('Notify', source, 'negado', 'Há mecânicos na cidade, chame um!') return end
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.hasPermission(user_id,"mecanico.permissao") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,7000,"reparando motor")
							SetTimeout(7000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('repararmotor',source,vehicle)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"militec",1) then
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,7000,"reparando motor")
								SetTimeout(7000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('repararmotor',source,vehicle)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				else
					TriggerClientEvent('Notify', source, 'negado', 'Você precisa estar fora do veículo para utilizá-lo.')
				end	
			elseif itemName == "repairkit" then
				local mecanicos = vRP.getUsersByPermission('mecanico.permissao')
				if #mecanicos > 2 and not vRP.hasPermission(user_id, 'mecanico.permissao') then TriggerClientEvent('Notify', source, 'negado', 'Há mecânicos na cidade, chame um!') return end
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.hasPermission(user_id,"mecanico.permissao") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{"mini@repair","fixing_a_player"},true)
							TriggerClientEvent("progress",source,9000,"reparando veículo")
							SetTimeout(9000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								if vRPclient.FazendoAnim(source,"mini@repair","fixing_a_player") then
									TriggerClientEvent('reparar',source)
								else
									TriggerClientEvent('Notify',source,'negado','Você não estava reparando seu veículo, portanto o veículo não foi reparado.')
								end
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{"mini@repair","fixing_a_player"},true)
								TriggerClientEvent("progress",source,9000,"reparando veículo")
								SetTimeout(9000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									if vRPclient.FazendoAnim(source, "mini@repair","fixing_a_player") then
										TriggerClientEvent('reparar',source)
									else
										TriggerClientEvent('Notify',source,'negado','Você não estava reparando seu veículo, portanto seu kit foi inútil.')
									end
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end	
			elseif itemName == "pneus" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3)
					if vehicle then
						if vRP.hasPermission(user_id,"mecanico.permissao") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
							TriggerClientEvent("progress",source,9000)
							SetTimeout(9000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('repararpneus',source,vehicle)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"pneus",1) then
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
								TriggerClientEvent("progress",source,9000)
								SetTimeout(9000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('repararpneus',source,vehicle)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end	
			elseif itemName == "notebook" then
				if vRPclient.isInVehicle(source) then
					local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
					if vehicle and placa then
						actived[user_id] = true
						vGARAGE.freezeVehicleNotebook(source,vehicle)
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("progress",source,59500,"removendo rastreador")
						SetTimeout(60000,function()
							actived[user_id] = nil
							TriggerClientEvent('cancelando',source,false)
							local placa_user_id = vRP.getUserByRegistration(placa)
							if placa_user_id then
								local player = vRP.getUserSource(placa_user_id)
								if player then
									vGARAGE.removeGpsVehicle(player,vname)
								end
							end
						end)
					end
				end
			elseif itemName == "secador" then
				local dinheiromolhado = vRP.getInventoryItemAmount(user_id, 'dinheiromolhado')
					if dinheiromolhado > 0 then
						if usando[user_id] then TriggerClientEvent("Notify",source,'negado',"Você já está realizando uma ação!",8000) return end
						usando[user_id] = true
						if vRP.tryGetInventoryItem(user_id,"secador",1) then
							if dinheiromolhado >= 5000 then
								if vRP.tryGetInventoryItem(user_id,"dinheiromolhado",5000) then
									TriggerClientEvent("progress",source,15000,"secando dinheiro")
									TriggerClientEvent('Creative:Update',source,'updateMochila')
									SetTimeout(15000,function()
										TriggerClientEvent("Notify",source,'sucesso',"Dinheiro seco com sucesso.",8000)
										vRP.giveMoney(user_id,5000)
									end)
								end
							else
								if vRP.tryGetInventoryItem(user_id,"dinheiromolhado",dinheiromolhado) then
									TriggerClientEvent("progress",source,15000,"secando dinheiro")
									TriggerClientEvent('Creative:Update',source,'updateMochila')
									SetTimeout(15000,function()
										TriggerClientEvent("Notify",source,'sucesso',"Dinheiro seco com sucesso.",8000)
										vRP.giveMoney(user_id,dinheiromolhado)
									end)
								end
							end
							usando[user_id] = false
						end
					end
                elseif itemName == "adrenalina" then
                    local nplayer = vRPclient.getNearestPlayer(source,2)
                    local vida = vRPclient.getHealth(nplayer)
                    local user_id = vRP.getUserId(source)
                    local identity = vRP.getUserIdentity(user_id)
					local identity2 = vRP.getUserIdentity(nplayer)
					local x,y,z = vRPclient.getPosition(source)
                    if nplayer then
                        if vRPclient.isInComa(nplayer) then
                        if vRP.tryGetInventoryItem(user_id,"adrenalina",1) then
							TriggerClientEvent('Creative:Update',source,'updateMochila')
                            TriggerClientEvent('cancelando',source,true)
                            vRPclient._playAnim(source,false,{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
                            TriggerClientEvent('chatMessage',nplayer,"SISTEMA",{255,0,0}, 'Você esta tomando um choque de adrenalina aplicado por ' .. identity.name .. ' ' .. identity.firstname .. ', você em breve sera reanimado.' )
                            TriggerClientEvent("progress",source,8000,"reanimando")
                            TriggerClientEvent("progress",nplayer,8000,"reanimando")
                            SetTimeout(8000,function()
                            vRPclient.killGod(nplayer)
                            vRPclient._stopAnim(source,false)
                            TriggerClientEvent('cancelando',source,false)
							SendWebhookMessage(webhookadrenalina, "O **ID** ``#"..nplayer.." " .. identity2.name .. " " .. identity2.firstname .."`` foi revivido pelo **ID** ``#"..user_id.." " .. identity.name .. " " .. identity.firstname .."``.")
                        end)
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Você so pode fazer isso em alguem que esteja em coma.') return false end
                end
			elseif itemName == "gasosavazia" then
				local carro = client.PegarCarro(source, 5)
				if carro and carro ~= 0 then
					local gasolina = client.GetGasosaDoCarro(source, carro)
					if gasolina > 30 then
						if vRP.tryGetInventoryItem(user_id,'gasosavazia',1) then
							TriggerClientEvent('rusher:RoubarGasolina', source, carro, gasolina)
						end
					else
						TriggerClientEvent('Notify', source, 'negado', 'Este carro está sem <b>gasolina</b>.')
					end
				end
			elseif itemName == "gasosacheia" then
				local carro = client.PegarCarro(source, 5)
				if carro and carro ~= 0 then
					local gasolina = client.GetGasosaDoCarro(source, carro)
					local adicionar = 30
					if gasolina > 70 then
						adicionar = 100 - gasolina
					end
					if vRP.tryGetInventoryItem(user_id,'gasosacheia',1) then		
						TriggerClientEvent('rusher:AbastecerCarro', source, carro, gasolina+adicionar)
					end
				end
			end
		elseif type == "equipar" then
			if vRP.tryGetInventoryItem(user_id,itemName,1) then
				local weapons = {}
				local identity = vRP.getUserIdentity(user_id)
				weapons[string.gsub(itemName,"wbody_","")] = { ammo = 0 }
				vRPclient._giveWeapons(source,weapons)
				SendWebhookMessage(webhookequipar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[EQUIPOU]: "..vRP.itemNameList(itemName).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				TriggerClientEvent('Creative:Update',source,'updateMochila')
			end
		elseif type == "recarregar" then
			local uweapons = vRPclient.getWeapons(source)
			local weaponuse = string.gsub(itemName,"wammo_","")
			local weaponusename = "wammo_"..weaponuse
				local identity = vRP.getUserIdentity(user_id)
			if uweapons[weaponuse] then
				local itemAmount = 0
				local data = vRP.getUserDataTable(user_id)
				for k,v in pairs(data.inventory) do
				if weaponusename == k then
					if v.amount > 249 then
					v.amount = 249
					end

					itemAmount = v.amount

					if vRP.tryGetInventoryItem(user_id, weaponusename, parseInt(v.amount)) then
					local weapons = {}
					weapons[weaponuse] = { ammo = v.amount }
					itemAmount = v.amount
					vRPclient._giveWeapons(source,weapons,false)
					SendWebhookMessage(webhookequipar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RECARREGOU]: "..vRP.itemNameList(itemName).." \n[MUNICAO]: "..parseInt(v.amount).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					end
				end
				end
			end
		end
	end
end
RegisterCommand('bandagem', function(source, args, rawCmd)
	 
	local source = source
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if bandagem[user_id] == 0 or not bandagem[user_id] then
			if vRP.tryGetInventoryItem(user_id,"bandagem",1) then
				bandagem[user_id] = 180
				actived[user_id] = true
				vRPclient._CarregarObjeto(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)
				TriggerClientEvent('cancelando',source,true)
				TriggerClientEvent('rusher:DesativarAtirar', source, true)
				TriggerClientEvent("progress",source,5000,"bandagem")
				SetTimeout(5000,function()
					actived[user_id] = nil
					TriggerClientEvent('rusherbandagem',source)
					TriggerClientEvent('cancelando',source,false)
					TriggerClientEvent('rusher:DesativarAtirar', source, false)
					vRPclient._DeletarObjeto(source)
					TriggerClientEvent("Notify",source,'sucesso',"Bandagem utilizada com sucesso.",8000)
					--client.SetBandagem(source, 99)
				end)
			else
				TriggerClientEvent("Notify",source,'negado',"Você não possui bandagem em sua mochila.",8000)
			end
		else
			TriggerClientEvent("Notify",source,'negado',"Aguarde "..vRPclient.getTimeFunction(source,parseInt(bandagem[user_id]))..".",8000)
		end
	else
		TriggerClientEvent("Notify",source,'aviso',"Você não pode utilizar de vida cheia ou nocauteado.",8000)
	end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------
-- USE ENERGETICO
-------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('energetico', function(source, args, rawCmd)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.tryGetInventoryItem(user_id,"energetico",1) then
		if usando[user_id] then TriggerClientEvent("Notify",source,'negado',"Você já está realizando uma ação!",8000) return end
		usando[user_id] = true
		actived[user_id] = true
		TriggerClientEvent('cancelando',source,true)
		TriggerClientEvent("progress",source,4000,"bebendo")
		SetTimeout(4000,function()
			actived[user_id] = nil
			TriggerClientEvent('energeticos',source)
			TriggerClientEvent('cancelando',source,false)
			vRPclient._DeletarObjeto(source)
			TriggerClientEvent("Notify",source,'sucesso',"Energético utilizado com sucesso.",8000)
			usando[user_id] = false
		end)
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------
-- USE MELZINHO
-------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('melzinho', function(source, args, rawCmd)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.tryGetInventoryItem(user_id,"melzinho",1) then
		if usando[user_id] then TriggerClientEvent("Notify",source,'negado',"Você já está realizando uma ação!",8000) return end
		usando[user_id] = true
		actived[user_id] = true
		TriggerClientEvent('cancelando',source,true)
		TriggerClientEvent("progress",source,5000,"comendo")
		SetTimeout(5000,function()
			actived[user_id] = nil
			TriggerClientEvent('melzinho',source)
			TriggerClientEvent('cancelando',source,false)
			vRPclient._DeletarObjeto(source)
			TriggerClientEvent("Notify",source,'sucesso',"Melzinho utilizado com sucesso.",8000)
			usando[user_id] = false
		end)
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------------
-- ROUBAR GASOLINA
-------------------------------------------------------------------------------------------------------------------------------------------------
--RegisterServerEvent('rusher:ReceberGasolina')
--AddEventHandler('rusher:ReceberGasolina', function()
--	local source = source
--	local user_id = vRP.getUserId(source)
--
--	local carro = client.PegarCarro(source, 5)
--	if carro and carro ~= 0 then
--		local gasolina = client.GetGasosaDoCarro(source, carro)
--		if gasolina > 30 then
--			local NovaGasolina = gasolina - 30
--			TriggerClientEvent('rusher:SyncGasolinaNocarro', -1, carro, NovaGasolina)
--			if vRP.getInventoryWeight(user_id) + vRP.getItemWeight('gasosacheia') <= vRP.getInventoryMaxWeight(user_id) then
--				vRP.giveInventoryItem(user_id,'gasosacheia',1)
--			else
--				TriggerClientEvent('Notify', source, 'negado', 'ERRO AO PEGAR GASOLINA!', 'Sua mochila não possui espaço pra um galão.')
--			end
--		end
--	end
--end)
--
--RegisterServerEvent('rusher:AskFuelSync')
--AddEventHandler('rusher:AskFuelSync', function(carro, gasolina)
--	TriggerClientEvent('rusher:SyncGasolinaNocarro', -1, carro, gasolina)
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	actived[user_id] = nil
end)
