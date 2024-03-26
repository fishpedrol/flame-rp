local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- SRC
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_player",src)
vCHAT = Tunnel.getInterface("chat")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookgarmas = ''
local webhookgarmas250 = ''
local webhookenviardinheiro = ''
local webhooksaquear = ''

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVISTAR ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer == nil then
				TriggerClientEvent("Notify",source,"aviso","Passaporte <b>"..vRP.format(args[1]).."</b> indisponível no momento.")
				return
			end
			nuser_id = vRP.getUserId(nplayer)
		if nuser_id then
			local weapons = vRPclient.getWeapons(nplayer)
			local money = vRP.getMoney(nuser_id)
			local data = vRP.getUserDataTable(nuser_id)
			local identity = vRP.getUserIdentity(nuser_id)

			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  de ["..nuser_id.."] "..identity.name.." " .. identity.firstname.. " [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
			if data and data.inventory then
				for k,v in pairs(data.inventory) do
					TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody_"..k))
				else
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody_"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
		end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('attachs', function(source,args) 
	local source = source
    local user_id = vRP.getUserId(source)
    if checkAttachs(user_id) or checkVip(user_id) then
        TriggerClientEvent("command:Attachs", source, args)
    else
        TriggerClientEvent('Notify', source, 'negado','Você não possui um kit de componentes.<br><br>OBS: Membros <b>VIP</b> não necessitam deste item para usar o comando.')
    end
end)

function checkAttachs(user_id)
	if vRP.getInventoryItemAmount(user_id, 'compattach') >= 1 then return true end
end

function checkVip(user_id)
	return (vRP.hasPermission(user_id,"attachs.permissao") or vRP.hasPermission(user_id,"staff.permissao"))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rag',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"influencer.permissao") then
        if args[1] then
            TriggerClientEvent('derrubarwebjogador',source,args[1])
        end
    end
end)

local blips = {}

local AdminsBloqueados = {}

RegisterCommand('call',function(source,args,rawCommand)


	local source = source

	local answered = false

	local user_id = vRP.getUserId(source)

	local uplayer = vRP.getUserSource(user_id)

	local vida = vRPclient.getHealth(source)



	if string.lower(args[1]) ~= 'adm' then TriggerClientEvent('Notify', source, 'negado','Você só pode efetuar chamados assim para a administração.') return end


	if user_id then

		local descricao = vRP.prompt(source,"Descrição:","")

		if descricao == "" then

			return

		end



	
		if string.match(descricao, 'limb') then

			TriggerClientEvent("Notify",source,"importante","Chamados desse tipo <b>NÃO</b> podem ser realizados.")

			return

		end



		if string.match(descricao, 'set') then

			TriggerClientEvent("Notify",source,"importante","Chamados desse tipo <b>NÃO</b> podem ser realizados.")

			return

		end


		local x,y,z = vRPclient.getPosition(source)

		local players = vRP.getUsersByPermission("suporte.permissao")

		local especialidade = "Administradores"
		

		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")

		if #players <= 0 then

			TriggerClientEvent("Notify",source,"importante","Não há administrador disponível.")

		else

			local identitys = vRP.getUserIdentity(user_id)

			TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")

			for l,w in pairs(players) do
				
				local player = vRP.getUserSource(parseInt(w))
				
				local nuser_id = vRP.getUserId(player)

				if player and player ~= uplayer then

					if not AdminsBloqueados[nuser_id] then

						async(function()

							vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")

							TriggerClientEvent('chatMessage',player,string.upper(especialidade),{19,197,43},"["..user_id.."] ^1"..identitys.name.." "..identitys.firstname.."^0: "..descricao)

							local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)

							if ok then

								if not answered then

									answered = true

									local identity = vRP.getUserIdentity(nuser_id)

									TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")

									TriggerEvent('start:AvisarTodos', players, especialidade, identitys.name.." "..identitys.firstname, identity.name.." "..identity.firstname)

									vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")

									vRPclient._setGPS(player,x,y)

								else

									TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")

									vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")

								end

							end


							local id = idgens:gen()

							blips[id] = vRPclient.addBlip(player,x,y,z,153,58,"Chamado admin",0.6,false)

							SetTimeout(120000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)

						end)

					end

				end

			end

		end

	end

end)

RegisterCommand('chamados', function(source, args, rawCmd)
    


	local user_id = vRP.getUserId(source)

	if vRP.hasPermission(user_id, "suporte.permissao") then

		if args[1] then

			if args[1] == 'off' then

				AdminsBloqueados[user_id] = true

				TriggerClientEvent('Notify', source, 'sucesso','Você <b>desligou</b> os chamados para <b>administração</b>.')

			elseif args[1] == 'on' then

				AdminsBloqueados[user_id] = false

				TriggerClientEvent('Notify', source, 'sucesso','Você <b>ligou</b> os chamados para <b>administração</b>.')

			end

		end

	end

end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkBooster()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"attachs.permissao") then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Booster ou VIP</b> para fazer essa ação.") 
			return false
		end
	end
end

RegisterCommand('reparar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if not vRPclient.isInVehicle(source) then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vRP.hasPermission(user_id,"mecanico.permissao") then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
			TriggerClientEvent("progress",source,30000,"reparando")
			SetTimeout(30000,function()
				TriggerClientEvent('cancelando',source,false)
				TriggerClientEvent('reparar',source,vehicle)
				vRPclient._stopAnim(source,false)
			end)
		end
	else
		TriggerClientEvent("Notify",source,"negado","Precisa estar próximo ou fora do veículo para efetuar os reparos.")
	end
end)

RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkAttachs()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"compattach") >= 1 or vRP.hasPermission(user_id,"attachs.permissao") or vRP.hasPermission(user_id,"influencer.permissao") then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Modificador de Armas</b> para fazer essa ação.") 
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkRoupas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,"roupas.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"influencer.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Roupas Secundárias</b> na mochila.")
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	["mochila"] = { index = "mochila", nome = "Mochila" },
	["pendrive"] = { index = "pendrive", nome = "Pendrive" },
	["celular"] = { index = "celular", nome = "Celular" },
	["radio"] = { index = "radio", nome = "Radio" },
	["distintivopolicial"] = { index = "distintivopolicial", nome = "Distintivo Policial" },
	["militec"] = { index = "militec", nome = "Militec" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos" },
	["roupas"] = { index = "roupas", nome = "Roupas", },
	["bandagem"] = { index = "bandagem", nome = "Bandagem", },
	["pecadearma"] = { index = "pecadearma", nome = "Peça De Arma", },
	["materialmunicaopesada"] = { index = "materialmunicaopesada", nome = "Material de Munição Pesada", },
	["materialmunicao"] = { index = "materialmunicao", nome = "Material de Munição", },
	---------------------------------------------------------------------------------------------------
	--[ Ultilitários Ilegais]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["dinheirosujo"] = { index = "dinheirosujo", nome = "Dinheiro Sujo" },
	["dinheiroempacotado"] = { index = "dinheiroempacotado", nome = "Dinheiro Empacotado" },
	["algemas"] = { index = "algemas", nome = "Algema" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick" },
	["masterpick"] = { index = "masterpick", nome = "Masterpick" },
	["cartao-desmanche"] = { index = "cartao-desmanche", nome = "Cartao do desmanche" },
	["compattach"] = { index = "compattach", nome = "Modificador de Armas" },
	["capuz"] = { index = "capuz", nome = "Capuz" },
	["placa"] = { index = "placa", nome = "Placa" },
	["ticket"] = { index = "ticket", nome = "Ticket" },
	["c4"] = { index = "c4", nome = "C4" },
	["serra"] = { index = "serra", nome = "Serra" },
	["furadeira"] = { index = "furadeira", nome = "Furadeira" },
	---------------------------------------------------------------------------------------------------
	--[ Empregos ]-------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["sacodelixo"] = { index = "sacodelixo", nome = "Saco de lixo" },
	["encomenda"] = { index = "encomenda", nome = "Encomenda" },
	["graos"] = { index = "graos", nome = "Graos" },
	["bateria"] = { index = "bateria", nome = "Bateria" },
	["gps"] = { index = "gps", nome = "GPS" },
	["cobre"] = { index = "cobre", nome = "Cobre" },
	["plastico"] = { index = "plastico", nome = "Plastico" },
	["uva"] = { index = "uva", nome = "Uva", },
	["borracha"] = { index = "borracha", nome = "Borracha" },
	["linha"] = { index = "linha", nome = "Linha" },
	["pano"] = { index = "pano", nome = "Pano" },
	["vidro"] = { index = "vidro", nome = "Vidro" },
	["pilha"] = { index = "pilha", nome = "Pilha" },
	["fioeletronico"] = { index = "fioeletronico", nome = "Fio Eletronico" },
	["graosimpuros"] = { index = "graosimpuros", nome = "Graos Impuros" },
	---------------------------------------------------------------------------------------------------
	--[ Bebidas ]-----------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["energetico"] = { index = "energetico", nome = "Energético" },
	["cerveja"] = { index = "cerveja", nome = "Cerveja" },
	["fardo"] = { index = "fardo", nome = "Fardo de Cerveja" },
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa Vazia" },
	--------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 01 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina" },
	["anfetamina"] = { index = "anfetamina", nome = "Anfetamina" },
	["acidobateria"] = { index = "acidobateria", nome = "Acido Bateria" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 02 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["cocamisturada"] = { index = "cocamisturada", nome = "Cocaina" },
	["cocaina"] = { index = "cocaina", nome = "Cocaina Pasta" },
	["folhadecoca"] = { index = "folhadecoca", nome = "Folha de Coca" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Maconha ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["maconha"] = { index = "maconha", nome = "Maconha" },
	["alvejante"] = { index = "alvejante", nome = "Alvejante" },
	["alvejantemodificado"] = { index = "alvejantemodificado", nome = "Alvejante Modificado" },
	["maconhamacerada"] = { index = "maconhamacerada", nome = "Maconha Macerada" },
	["folhademaconha"] = { index = "folhademaconha", nome = "Folha de Maconha" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Ecstasy ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["ecstasy"] = { index = "ecstasy", nome = "Ecstasy" },
	["essenciadeecstasy"] = { index = "essenciadeecstasy", nome = "Essencia de Ecstasy" },
	["pastadeecstasy"] = { index = "pastadeecstasy", nome = "Pasta de Ecstasy" },
	---------------------------------------------------------------------------------------------------
	--[ Dominação itens ]--------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["armacaodeg3"] = { index = "armacaodeg3", nome = "Armação de G36" },
	["armacaodetec"] = { index = "armacaodetec", nome = "Armação de TEC-9" },
	["armacaodeak"] = { index = "armacaodeak", nome = "Armação de AK" },
	["armacaodemp5"] = { index = "armacaodemp5", nome = "Armação de MP5" },
	["materialg3"] = { index = "materialg3", nome = "Material de G36" },
	["materialtec"] = { index = "materialtec", nome = "Material de TEC-9" },
	["materialak"] = { index = "materialak", nome = "Material de AK" },
	["materialmp5"] = { index = "materialmp5", nome = "Material de MP5" },
	["lsd"] = { index = "lsd", nome = "LSD" },
	---------------------------------------------------------------------------------------------------
	--[ Organização Criminosa de Drogas 02 ]-----------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["molas"] = { index = "molas", nome = "Molas" },
	["metal"] = { index = "metal", nome = "Metal" },
	["gatilho"] = { index = "gatilho", nome = "Gatilho", },
	["capsulas"] = { index = "capsulas", nome = "Capsulas" },
	["polvora"] = { index = "polvora", nome = "Polvora" },
	["pecadearma"] = { index = "pecadearma", nome = "Peça de Arma" },
	---------------------------------------------------------------------------------------------------
	--[ ARMAS / OUTROS ]-------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------	
	["wbody_GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas" },
	["wbody_WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador" },
	["wbody_WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor" },
	---------------------------------------------------------------------------------------------------
	--[ CORPO A CORPO ]--------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------	
	["wbody_WEAPON_KNIFE"] = { index = "faca", nome = "Faca" },
	["wbody_WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga" },
	["wbody_WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês" },
	["wbody_WEAPON_MACHETE"] = { index = "machete", nome = "Machete" },
	["wbody_WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete" },
	["wbody_WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo" },
	["wbody_WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo" },
	["wbody_WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf" },
	["wbody_WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra" },
	["wbody_WEAPON_HATCHET"] = { index = "machado", nome = "Machado" },
	["wbody_WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna" },
	["wbody_WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol" },
	["wbody_WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa" },
	["wbody_WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha" },
	["wbody_WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca" },
	["wbody_WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra" },
	["wbody_WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete" },
    ---------------------------------------------------------------------------------------------------
    --[ PISTOLA ]-------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------
    ["wbody_WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock 19" },--
    ["wbody_WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five Seven" },
    ["wbody_WEAPON_SNSPISTOL"] = { index = "pistolhk", nome = "Pistol HK" },
    ["wbody_WEAPON_STUNGUN"] = { index = "taser", nome = "Taser" },
    ---------------------------------------------------------------------------------------------------
    --[ FUZIL ]----------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------
    ["wbody_WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak74", nome = "AK-47 MK2" },
    ["wbody_WEAPON_CARBINERIFLE"] = { index = "m4a4", nome = "M4A4", },
	["wbody_WEAPON_CARBINERIFLE_MK2"] = { index = "mpx", nome = "MPX", },
	["wbody_WEAPON_SPECIALCARBINE_MK2"] = { index = "g36mk2", nome = "G36 MK2", },
    ---------------------------------------------------------------------------------------------------
    --[ SMG ]------------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------
	["wbody_WEAPON_SMG"] = { index = "mp5", nome = "MP5" },
	["wbody_WEAPON_SMG_MK2"] = { index = "mp5mk2", nome = "MP5 MK2" },
    ["wbody_WEAPON_MACHINEPISTOL"] = { index = "tec9", nome = "Tec-9", },
	---------------------------------------------------------------------------------------------------
	--[ SHOTGUN ]--------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody_WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington", nome = "Remington 870" },
	---------------------------------------------------------------------------------------------------
	--[ RIFLES ]---------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------
	["wbody_WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22" },
    ---------------------------------------------------------------------------------------------------
    --[ MUNIÇÕES ]-------------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------------------
    ["wammo_GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "M.Paraquedas" },
    ["wammo_WEAPON_FLARE"] = { index = "m-sinalizador", nome = "M.Sinalizador" },
    ["wammo_WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Extintor" },
    ["wammo_WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "M.Glock 19" },
    ["wammo_WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "M.FN Five Seven" },
    ["wammo_WEAPON_SNSPISTOL"] = { index = "m-pistolhk", nome = "M.Pistol HK" },
    ["wammo_WEAPON_STUNGUN"] = { index = "m-taser", nome = "M.Taser" },
    ["wammo_WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak74", nome = "M.AK47 MK2", },
    ["wammo_WEAPON_CARBINERIFLE"] = { index = "m-m4a4", nome = "M.M4A4", },
	["wammo_WEAPON_CARBINERIFLE_MK2"] = { index = "m-mpx", nome = "M.MPX", },
	["wammo_WEAPON_SPECIALCARBINE_MK2"] = { index = "m-g36mk2", nome = "M.G36 MK2", },
	["wammo_WEAPON_SMG"] = { index = "m-mp5", nome = "M.MP5" },
	["wammo_WEAPON_SMG_MK2"] = { index = "m-mp5mk2", nome = "M.MP5 MK2" },
    ["wammo_WEAPON_MACHINEPISTOL"] = { index = "m-tec9", nome = "M.TEC-9", },
    ["wammo_WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington", nome = "M.Remington 870" },
    ["wammo_WEAPON_MUSKET"] = { index = "m-winchester22", nome = "M.Winchester 22" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- USER VEHS [ADMIN]
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('uservehs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"staff.permissao") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(nuser_id) })
                local car_names = {}
                for k,v in pairs(vehicle) do
                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>")
                end
                car_names = table.concat(car_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Sistema","Veículos de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..car_names,10000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USER HOMES [ADMIN]
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('userhomes',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"dev.permissao") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local homes = vRP.query("creative/get_homes",{ user_id = parseInt(nuser_id) })
                local homes_names = {}
                for k,v in pairs(vehicle) do
                	table.insert(car_names, "<b>" .. vRP.Homes(v.home) .. "</b>")
                end
                homes_names = table.concat(Homes_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Sistema","Casas de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..homes_names,10000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id',function(source,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(nuser_id)
		vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 18%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #5AC3FF; }","<div class=\"local\"><b>Passaporte:</b> ( "..vRP.format(identity.user_id).." )</div>")
		vRP.request(source,"Você deseja fechar o registro geral?",1000)
		vRPclient.removeDiv(source,"completerg")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer == nil then
				TriggerClientEvent("Notify",source,"aviso","Passaporte <b>"..vRP.format(args[1]).."</b> indisponível no momento.")
				return
			end
			nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local value = vRP.getUData(nuser_id,"vRP:multas")
				local valormultas = json.decode(value) or 0
				local identity = vRP.getUserIdentity(nuser_id)
				local carteira = vRP.getMoney(nuser_id)
				local groupv = vRP.getUserGroupByType(nuser_id,"job")
				local groupv2 = vRP.getUserGroupByType(nuser_id,"job2")
				local vip = vRP.getUserGroupByType(nuser_id,"vip")
				local banco = vRP.getBankMoney(nuser_id)
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 18%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #5AC3FF; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div><div class=\"local2\"><b>Emprego:</b> "..groupv.."</div><div class=\"local2\"><b>Emprego2:</b> "..groupv2.."</div></div></div><div class=\"local2\"><b>Vip:</b> "..vip.."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		else
			local nplayer = vRPclient.getNearestPlayer(source,2)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local value = vRP.getUData(nuser_id,"vRP:multas")
				local valormultas = json.decode(value) or 0
				local identity = vRP.getUserIdentity(nuser_id)
				local carteira = vRP.getMoney(nuser_id)
				local groupv = vRP.getUserGroupByType(nuser_id,"job")
				local groupv2 = vRP.getUserGroupByType(nuser_id,"job2")
				local vip = vRP.getUserGroupByType(nuser_id,"vip")
				local banco = vRP.getBankMoney(nuser_id)
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 18%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #5AC3FF; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div><div class=\"local2\"><b>Emprego:</b> "..groupv.."</div></div><div class=\"local2\"><b>Emprego2:</b> "..groupv2.."</div></div><div class=\"local2\"><b>Vip:</b> "..vip.."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------
-- /REVISTAR
------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
	if not vCHAT.statusChat(source) then return end
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)

		TriggerClientEvent('cancelando',source,true)
		TriggerClientEvent('cancelando',nplayer,true)
        vRPclient._playAnim(nplayer,false,{{"random@mugging3","handsup_standing_base"}},false)
		TriggerClientEvent("progress",source,5000,"revistando")
		SetTimeout(5000,function()

			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
			if data and data.inventory then
				for k,v in pairs(data.inventory) do
					TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k))
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody_"..k))
				else
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wammo_"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
				end
			end

			vRPclient._stopAnim(nplayer,false)
			TriggerClientEvent('cancelando',source,false)
			TriggerClientEvent('cancelando',nplayer,false)
			TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
		end)
		TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo <b>Revistado</b>.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- [ SAQUEAR ]
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('saquear',function(source,args,rawCommand)
	if not vCHAT.statusChat(source) then return end
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if vRPclient.isInComa(nplayer) then
			local identity_user = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			local nidentity = vRP.getUserIdentity(nuser_id)
			local policia = vRP.getUsersByPermission("policiasaque.permissao")
			local itens_saque = {}
			if #policia >= 2 then
				local vida = vRPclient.getHealth(nplayer)
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@idle_a","idle_a"}},false)
				TriggerClientEvent("progress",source,8000,"saqueando")
				SetTimeout(8000,function()
					if not vRP.hasPermission(nuser_id, "policiasaque.permissao") then
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
											table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList(k).." [QUANTIDADE]: "..v.amount)
										end
									else 
										print (aaa) 
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody_"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody_"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody_"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody_"..k,1)
									table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wbody_"..k).." [QUANTIDADE]: "..1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody_"..k).."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo_"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo_"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo_"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo_"..k,v.ammo)
										table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wammo_"..k).." [QTD]: "..v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo_"..k).."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
					elseif vRP.tryGetInventoryItem(nuser_id,"distintivopolicial",1) then
						vRP.giveInventoryItem(user_id,"distintivopolicial",1)
					end
					vRPclient.setStandBY(source,parseInt(8000))
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
					local apreendidos = table.concat(itens_saque, "\n")
					TriggerClientEvent("Notify",source,"importante","Saque concluido com sucesso.")
					SendWebhookMessage(webhooksaquear,"```prolog\n[ID]: "..user_id.." "..identity_user.name.." "..identity_user.firstname.."\n[SAQUEOU]: "..nuser_id.." "..nidentity.name.." " ..nidentity.firstname .. "\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					Citizen.Wait(8000)
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você só pode saquear quem está em coma.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKIN
-----------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand("trunkin",function(source,args,rawCommand)
     local user_id = vRP.getUserId(source)
     if user_id then
         if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
             TriggerClientEvent("player:EnterTrunk",source)
         end
     end
 end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------
local salarios = {
	{ ['permissao'] = "ultimate.permissao", ['nome'] = "ULTIMATE", ['payment'] = 15000 },
	{ ['permissao'] = "master.permissao", ['nome'] = "MASTER", ['payment'] = 10000 },
	{ ['permissao'] = "now.permissao", ['nome'] = "NOW", ['payment'] = 5000 },
	{ ['permissao'] = "extended.permissao", ['nome'] = "EXTENDED", ['payment'] = 2500 },
	{ ['permissao'] = "rental.permissao", ['nome'] = "RENTAL", ['payment'] = 1000 },
	{ ['permissao'] = "policia.permissao", ['nome'] = "POLICIA", ['payment'] = 7500 },
	{ ['permissao'] = "paramedico.permissao", ['nome'] = "PARAMEDICO", ['payment'] = 8000 },
	{ ['permissao'] = "mecanico.permissao", ['nome'] = "MECANICO", ['payment'] = 3500 }
}

RegisterServerEvent('ne-player:Salarysystem:560DCA9348F540C0468F2486A776C436')
AddEventHandler('ne-player:Salarysystem:560DCA9348F540C0468F2486A776C436',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(salarios) do
			if vRP.hasPermission(user_id,v.permissao) then
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"importante","Obrigado por colaborar com a cidade, seu salario de <b>$"..vRP.format(parseInt(v.payment)).." dólares</b> foi depositado.")
				vRP.giveBankMoney(user_id,parseInt(v.payment))
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trypneus")
AddEventHandler("trypneus",function(nveh)
	TriggerClientEvent("syncpneus",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SEQUESTRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENVIAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('enviar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
  	local identitynu = vRP.getUserIdentity(nuser_id)
	if nuser_id and parseInt(args[1]) > 0 then
		if vRP.tryPayment(user_id,parseInt(args[1])) then
			vRP.giveMoney(nuser_id,parseInt(args[1]))
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			SendWebhookMessage(webhookenviardinheiro,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: $"..vRP.format(parseInt(args[1])).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
			TriggerClientEvent("Notify",source,"negado","Não tem a quantia que deseja enviar.",8000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ GARMAS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local garmas={} 
RegisterCommand('garmas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    TriggerClientEvent("Notify",source,"aviso","Suas armas estão sendo desequipadas.",9500)
    SetTimeout(7000,function()
        if user_id then
            if not vRP.hasPermission(user_id,"policia.permissao") and not vRP.hasPermission(user_id,"policiaacao.permissao") then 
                local weapons = vRPclient.replaceWeapons(source,{})
                for k,v in pairs(weapons) do
					Citizen.Wait(math.random(4000,10000))
                    vRP.giveInventoryItem(user_id,"wbody_"..k,1)
                    if v.ammo > 0 then
                        vRP.giveInventoryItem(user_id,"wammo_"..k,v.ammo)
                    end
                    SendWebho1Message(webhookgarmas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.itemNameList("wbody_"..k).." \n[QUANTIDADE DE MUNIÇÃO]: "..v.ammo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                end
            end
        end
    end)
    SetTimeout(3000, function()
    end)    
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tow",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"mecanico.permissao") then
			TriggerClientEvent("vTow",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(vehid01,vehid02,mod)
	TriggerClientEvent("synctow",-1,vehid01,vehid02,tostring(mod))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trywins")
AddEventHandler("trywins",function(nveh)
	TriggerClientEvent("syncwins",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
			if user_id then
				TriggerClientEvent('chatMessage',-1,"CMEC | "..identity.name.." "..identity.firstname.." ("..user_id..") ",{255,128,0},rawCommand:sub(4))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "mecanico.permissao"
		if vRP.hasPermission(user_id,permission) then
			local mec = vRP.getUsersByPermission(permission)
			for l,w in pairs(mec) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,191,128},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mascara
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmascara",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setblusa",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setcolete",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mochila
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mochila',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmochila",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setjaqueta",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setmaos",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('calca',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setcalca",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acessorios
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setacessorios",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setsapatos",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /chapeu
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setchapeu",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /oculos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if user_id then
					TriggerClientEvent("setoculos",source,args[1],args[2])
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ME SERVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('ChatMe')
AddEventHandler('ChatMe',function(text)
    local user_id = vRP.getUserId(source)
    if user_id then
        TriggerClientEvent('DisplayMe',-1,text,source)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local roupas = {
    ["mecanico"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 12,0 },
			[4] = { 39,0 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 109,0 },
			[8] = { 89,0 },
			[9] = { 14,0 },
			[10] = { -1,0 },
			[11] = { 66,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 38,0 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 2,0 },
			[8] = { 56,0 },
			[9] = { 35,0 },
			[10] = { -1,0 },
			[11] = { 59,0 }
		}
	},
    ["lixeiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 17,0 },
			[4] = { 36,0 },
			[5] = { -1,0 },
			[6] = { 27,0 },
			[7] = { -1,0 },
			[8] = { 59,0 },
			[10] = { -1,0 },
			[11] = { 57,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 18,0 },
			[4] = { 35,0 },
			[5] = { -1,0 },
			[6] = { 26,0 },
			[7] = { -1,0 },
			[8] = { 36,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 50,0 }
		}
	},
	["carteiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 0,0 },
			[4] = { 17,10 },
			[5] = { 40,0 },
			[6] = { 7,0 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 242,3 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 14,0 },
			[4] = { 14,1 },
			[5] = { 40,0 },
			[6] = { 10,1 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 250,3 }
		}
	},
	["fazendeiro"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 37,0 },
			[4] = { 7,0 },
			[5] = { -1,0 },
			[6] = { 15,6 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 95,2 },
			["p0"] = { 105,23 },
			["p1"] = { 5,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 45,0 },
			[4] = { 25,10 },
			[5] = { -1,0 },
			[6] = { 21,1 },
			[7] = { -1,0 },
			[8] = { 6,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 171,4 },
			["p0"] = { 104,23 },
			["p1"] = { 11,2 }
		}
	},
	["mergulho"] = {
		[1885233650] = {
			[1] = { 122,0 },
			[3] = { 31,0 },
			[4] = { 94,0 },
			[5] = { -1,0 },
			[6] = { 67,0 },
			[7] = { -1,0 },
			[8] = { 123,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 243,0 },			
			["p0"] = { -1,0 },
			["p1"] = { 26,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 122,0 },
			[3] = { 18,0 },
			[4] = { 97,0 },
			[5] = { -1,0 },
			[6] = { 70,0 },
			[7] = { -1,0 },
			[8] = { 153,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 251,0 },
			["p0"] = { -1,0 },
			["p1"] = { 28,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["pelado"] = {
		[1885233650] = {                                      
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 1,0 },
			[5] = { -1,0 },
			[6] = { 34,0 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[10] = { -1,0 },
			[11] = { 15,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 15,0 },
			[4] = { 21,0 },
			[5] = { -1,0 },
			[6] = { 35,0 },
			[7] = { -1,0 },
			[8] = { 15,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 82,0 }
		}
	},
	["leiteiro"] = {
		[1885233650] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 74,0 }, -- maos
			[4] = { 89,22 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 51,0 }, -- sapato
			[7] = { -1,0 }, -- acessorios		
			[8] = { -1,0 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 271,0 }, -- jaqueta		
			["p0"] = { 105,22 }, -- chapeu
			["p1"] = { 23,0 }, -- oculos
		},
		[-1667301416] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 85,0 }, -- maos
			[4] = { 92,22 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 52,0 }, -- sapato
			[7] = { -1,0 },  -- acessorios		
			[8] = { -1,0 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 141,0 }, -- jaqueta
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { 3,9 }, -- oculos
		}
	},
	["motorista"] = {
		[1885233650] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 0,0 }, -- maos
			[4] = { 10,0 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 21,0 }, -- sapato
			[7] = { -1,0 }, -- acessorios		
			[8] = { -1,0 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 242,1 }, -- jaqueta		
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { 7,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 14,0 }, -- maos
			[4] = { 37,0 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 27,0 }, -- sapato
			[7] = { -1,0 },  -- acessorios		
			[8] = { -1,0 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 250,1 }, -- jaqueta
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { -1,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["cacador"] = {
		[1885233650] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 20,0 }, -- maos
			[4] = { 97,18 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 24,0 }, -- sapato
			[7] = { -1,0 }, -- acessorios		
			[8] = { 2,2 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 244,19 }, -- jaqueta		
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { 5,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 20,0 }, -- maos
			[4] = { 100,18 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 24,0 }, -- sapato
			[7] = { -1,0 },  -- acessorios		
			[8] = { 44,1 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 252,19 }, -- jaqueta
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { -1,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["prisioneiro"] = {
		[1885233650] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 0,0 }, -- maos
			[4] = { 5,7 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 6,0 }, -- sapato
			[7] = { -1,0 }, -- acessorios		
			[8] = { 15,0 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 22,0 }, -- jaqueta		
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { -1,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 14,0 }, -- maos
			[4] = { 58,0 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 1,1 }, -- sapato
			[7] = { -1,0 },  -- acessorios		
			[8] = { 15,0 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 73,0 }, -- jaqueta
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { -1,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["pescador"] = {
		[1885233650] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 0,0 }, -- maos
			[4] = { 98,19 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 24,0 }, -- sapato
			[7] = { -1,0 }, -- acessorios		
			[8] = { 85,2 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 247,12 }, -- jaqueta		
			["p0"] = { 104,20 }, -- chapeu
			["p1"] = { 5,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 }, -- máscara
			[3] = { 14,0 }, -- maos
			[4] = { 101,19 }, -- calça
			[5] = { -1,0 }, -- mochila
			[6] = { 24,0 }, -- sapato
			[7] = { -1,0 },  -- acessorios		
			[8] = { 88,1 }, -- blusa
			[9] = { -1,0 }, -- colete
			[10] = { -1,0 }, -- adesivo
			[11] = { 255,13 }, -- jaqueta
			["p0"] = { -1,0 }, -- chapeu
			["p1"] = { 11,0 }, -- oculos
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	}
}

RegisterCommand('roupas',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if not vRP.searchReturn(source,user_id) then
				if args[1] then
					local custom = roupas[tostring(args[1])]
					if custom then
						local old_custom = vRPclient.getCustomization(source)
						local idle_copy = {}

						idle_copy = vRP.save_idle_custom(source,old_custom)
						idle_copy.modelhash = nil

						for l,w in pairs(custom[old_custom.modelhash]) do
							idle_copy[l] = w
						end
						vRPclient._playAnim(source,true,{{"clothingshirt","try_shirt_positive_d"}},false)
						Citizen.Wait(2500)
						vRPclient._stopAnim(source,true)
						vRPclient._setCustomization(source,idle_copy)
					end
				else
					vRPclient._playAnim(source,true,{{"clothingshirt","try_shirt_positive_d"}},false)
					Citizen.Wait(2500)
					vRPclient._stopAnim(source,true)
					vRP.removeCloak(source)
				end
			end
		end
	end
end)

RegisterCommand('roupas2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) > 101 then
		if not vRPclient.isHandcuffed(source) then
			if vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"policia.permissao") then
				local nplayer = vRPclient.getNearestPlayer(source,2)
				if not vRP.searchReturn(nplayer,user_id) then
					if nplayer then
						if args[1] then
							local custom = roupas[tostring(args[1])]
							if custom then
								local old_custom = vRPclient.getCustomization(nplayer)
								local idle_copy = {}

								idle_copy = vRP.save_idle_custom(nplayer,old_custom)
								idle_copy.modelhash = nil

								for l,w in pairs(custom[old_custom.modelhash]) do
									idle_copy[l] = w
								end
								vRPclient._setCustomization(nplayer,idle_copy)
							end
						else
							vRP.removeCloak(nplayer)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /use
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('use',function(source,args,rawCommand)
	if args[1] == nil then
		return
	end
	local user_id = vRP.getUserId(source)
		if args[1] == "energetico" then
		if vRP.tryGetInventoryItem(user_id,"energetico",1) then
			TriggerClientEvent('cancelando',source,true)
			vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
			TriggerClientEvent("progress",source,10000,"bebendo")
			SetTimeout(10000,function()
				TriggerClientEvent('energeticos',source,true)
				TriggerClientEvent('cancelando',source,false)
				vRPclient._DeletarObjeto(source)
				TriggerClientEvent("Notify",source,"sucesso","Energético utilizado com sucesso.")
			end)
			SetTimeout(60000,function()
				TriggerClientEvent('energeticos',source,false)
				TriggerClientEvent("Notify",source,"aviso","O efeito do energético passou e o coração voltou a bater normalmente.")
			end)
		else
			TriggerClientEvent("Notify",source,"negado","Energético não encontrado na mochila.")
		end
	end
end)

RegisterCommand('kitinicial', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local jaPegouKit = parseInt(vRP.getUData(user_id,"vrp:kit")) == 1
        if not jaPegouKit then
            local antDump = vRP.prompt(source, 'Digite SIM para resgatar seu kit inicial.', '')
            if antDump == "SIM" then
                vRP.setUData(user_id,"vrp:kit", 1)
                vRP.giveInventoryItem(user_id,"bandagem",3)
                vRP.giveInventoryItem(user_id,"mochila",3)
                vRP.giveInventoryItem(user_id,"radio",1)
                vRP.giveInventoryItem(user_id,"compattach",1)
                TriggerClientEvent("Notify",source,"sucesso","Você acaba de receber o Kit Inicial")
            end
        else
            TriggerClientEvent("Notify",source,"negado","Você já pegou seu KIT")
    end
end)