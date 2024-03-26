local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookprender = ''
local webhookmultas = ''
local webhookdetido = ''
local webhookpoliciaapreendidos = ''
local webhooktoogle = ''

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
------------------------------------------------------------------------------
-- 30s ----------
------------------------------------------------------------------------------
RegisterCommand('30s',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.getNearestPlayer(source,2)
    local nuser_id = vRP.getUserId(nplayer)
    if vRP.hasPermission(user_id,"policia.permissao") then
        TriggerClientEvent("Notify",source,"negado","Importante","Contagem dos 30 segundos de ação")
        TriggerClientEvent("Notify",nplayer,"importante","Contagem dos 30 segundos de ação")
        TriggerClientEvent("progress",source,30000,"trinta")
        TriggerClientEvent("progress",nplayer,30000,"trinta")
    else
        TriggerClientEvent("Notify",source,"negado","Você não tem permissão para acessar esse comando.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('placa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") then
		if args[1] then
			local user_id = vRP.getUserByRegistration(args[1])
			if user_id then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent('chatMessage',source,"Dispatch",{65,130,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
				end
			else
				TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
			end
		else
			local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
			local placa_user = vRP.getUserByRegistration(placa)
			if placa then
				if placa_user then
					local identity = vRP.getUserIdentity(placa_user)
					if identity then
						local vehicleName = vRP.vehicleName(vname)
						vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
						TriggerClientEvent('chatMessage',source,"Dispatch",{65,130,255},"^1Passaporte: ^0"..identity.user_id.."   ^2|   ^1Placa: ^0"..identity.registration.."   ^2|   ^1Proprietário: ^0"..identity.name.." "..identity.firstname.."   ^2|   ^1Modelo: ^0"..vehicleName.."   ^2|   ^1Idade: ^0"..identity.age.." anos   ^2|   ^1Telefone: ^0"..identity.phone)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
				end
			end
		end
	end
end)
-- cafeziinho 
local UserMatz = {
    {622.45, 7.37, 82.78},  -- CAFE ( LOCAL ALTERAVEL )
}
RegisterCommand('cafezinho',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"policia.permissao") then -- SÓ PARA POLÍCIA EM TOOGLE
       if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer,400)
                vRP.varyThirst(nplayer,-100)
                vRP.varyHunger(nplayer,-100)
                TriggerClientEvent("matz_resetBleeding",nplayer)
                TriggerClientEvent("matz_resetDiagnostic",nplayer)
            end
        else
            vRPclient.killGod(source)
            vRPclient.setHealth(source,400)
            vRP.varyThirst(user_id,-100)
            vRP.varyHunger(user_id,-100)
            TriggerClientEvent("Notify",source,"aviso", "CAFÉZINHO", "<b>CAFÉ</b> Aplicado com sucesso, cuidado com abuso!") -- NOTIFY EDITAVEL
            TriggerClientEvent("matz_resetBleeding",source)
            TriggerClientEvent("matz_resetDiagnostic",source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PTR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ptr', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local oficiais = vRP.getUsersByPermission("policia.permissao")
    local policia = 0
    local oficiais_nomes = ""
    if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        for k,v in ipairs(oficiais) do
            local identity = vRP.getUserIdentity(parseInt(v))
            oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            policia = policia + 1
        end
        TriggerClientEvent("Notify",source,"importante","Atualmente <b>"..policia.." Oficiais</b> em serviço.")
        if parseInt(policia) > 0 then
            TriggerClientEvent("Notify",source,"importante", oficiais_nomes)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PTR2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ptr2', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local oficiais = vRP.getUsersByPermission("policiaacao.permissao")
    local policia = 0
    local oficiais_nomes = ""
    if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"staff.permissao") then
        for k,v in ipairs(oficiais) do
            local identity = vRP.getUserIdentity(parseInt(v))
            oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            policia = policia + 1
        end
        TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..policia.." Oficiais</b> em policiaacao.")
        if parseInt(policia) > 0 then
            TriggerClientEvent("Notify",source,"importante", oficiais_nomes)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMS
 ----------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand('ems', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("paramedico.permissao")
	local paramedicos = 0
	local paramedicos_nomes = ""
	if vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"staff.permissao") then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			paramedicos_nomes = paramedicos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"importante","Sistema", "Atualmente <b>"..paramedicos.." Paramédicos</b> em serviço.")
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"importante","Sistema", paramedicos_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mecs', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("mecanico.permissao")
	local paramedicos = 0
	local oficiais_nomes = ""
	if vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"staff.permissao") then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"importante","Sistema", "Atualmente <b>"..paramedicos.." Mecânicos</b> em serviço.")
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"importante","Sistema", oficiais_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- P
-----------------------------------------------------------------------------------------------------------------------------------------
local policia = {}
RegisterServerEvent('police:Pressed')
AddEventHandler('police:Pressed',function()
    local source = source
    local user_id = vRP.getUserId(source)
    local uplayer = vRP.getUserSource(user_id)
    local identity = vRP.getUserIdentity(user_id)
    local x,y,z = vRPclient.getPosition(source)
    if vRPclient.getHealth(source) > 101 then
        if vRP.hasPermission(user_id,"policia.permissao") then
            local soldado = vRP.getUsersByPermission("policia.permissao")
            for l,w in pairs(soldado) do
                local player = vRP.getUserSource(parseInt(w))
                if player and player ~= uplayer then
                    async(function()
                        local id = idgens:gen()
                        policia[id] = vRPclient.addBlip(player,x,y,z,153,84,"Localização de "..identity.name.." "..identity.firstname,0.5,false)
                        TriggerClientEvent("Notify",player,"importante","Localização recebida de <b>"..identity.name.." "..identity.firstname.."</b>.")
                        vRPclient._playSound(player,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
                        SetTimeout(60000,function() vRPclient.removeBlip(player,policia[id]) idgens:free(id) end)
                    end)
                end
            end
            TriggerClientEvent("Notify",source,"sucesso","Localização enviada com sucesso.")
            vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pd',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"policia.permissao") then
			local soldado = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, "CENTRAL - "..identity.name.." "..identity.firstname.." ("..user_id..")",{64,179,255},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id, "policia.permissao")  then
			if user_id then
				TriggerClientEvent('chatMessage',-1,"POLICE | "..identity.name.." "..identity.firstname.." ("..user_id..") ",{65,130,255},rawCommand:sub(4))
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('toogle',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerEvent("vrp_blipsystem:serviceExit",source)
		vRP.addUserGroup(user_id,"paisanapolicia")
		vRP.tryGetInventoryItem(user_id,"distintivopolicial",1)
		--vRPclient.giveWeapons(source,{},true)
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	elseif vRP.hasPermission(user_id,"paisanapolicia.permissao") then
		TriggerEvent("vrp_blipsystem:serviceEnter",source,"Policial",77)
		vRP.addUserGroup(user_id,"policia")
		vRP.tryGetInventoryItem(user_id,"distintivopolicial",1)
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	
	elseif vRP.hasPermission(user_id,"paramedico.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"PaisanaParamedico")
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[PARAMEDICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	elseif vRP.hasPermission(user_id,"paisanaparamedico.permissao") then
		TriggerEvent('eblips:add',{ name = "Paramedico", src = source, color = 61 })
		vRP.addUserGroup(user_id,"Paramedico")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhookparamedico,"```prolog\n[PARAMEDICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	
	elseif vRP.hasPermission(user_id,"mecanico.permissao") then
		vRP.addUserGroup(user_id,"PaisanaMecanico")
		TriggerClientEvent("Notify",source,"aviso","Você saiu de serviço.")
		SendWebhookMessage(webhookmecanico,"```prolog\n[MECANICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE SERVICO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	elseif vRP.hasPermission(user_id,"paisanamecanico.permissao") then
		vRP.addUserGroup(user_id,"Mecanico")
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		SendWebhookMessage(webhookmecanico,"```prolog\n[MECANICO]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM SERVICO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('toogle2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"policiaacao.permissao") then
		TriggerEvent("vrp_blipsystem:serviceEnter",source,"Policial",77)
		vRP.addUserGroup(user_id,"policia")
		vRP.tryGetInventoryItem(user_id,"distintivopolicial",1)
		TriggerClientEvent("Notify",source,"aviso","Você voltou para patrulha.")
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========SAIU DE AÇÃO==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	elseif vRP.hasPermission(user_id,"policia.permissao") then
		TriggerEvent("vrp_blipsystem:serviceExit",source)
		vRP.addUserGroup(user_id,"policiaacao")
		vRP.giveInventoryItem(user_id,"distintivopolicial",1)
		TriggerClientEvent("Notify",source,"sucesso","Você entrou em ação.")
		TriggerClientEvent("toogle:police",source,true)
		SendWebhookMessage(webhooktoogle,"```prolog\n[POLICIAL]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[==========ENTROU EM AÇÃO=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end)

--[[ RegisterCommand('toogle2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local vida = vRPclient.getHealth(source)
    if vRP.hasPermission(user_id,"policiacao.permissao")  or vida <= 101 then
        TriggerEvent('eblips:remove',source)
        vRP.addUserGroup(user_id,"Policia")
        vRP.tryGetInventoryItem(user_id,"distintivopolicial",1)
        TriggerClientEvent("toogle:police",source,false)
        TriggerClientEvent("Notify","importante","Você voltou para patrulha.")
    elseif vRP.hasPermission(user_id,"policia.permissao")   or vida <= 101 then
        TriggerEvent('eblips:add',{ name = "Policial em ação", src = source, color = 46 })
        vRP.addUserGroup(user_id,"policiaacao")
        vRP.giveInventoryItem(user_id,"distintivopolicial",1)
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em ação.")
        TriggerClientEvent("toogle:police",source,true)
    end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- MULTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('multar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"staff.permissao") then
		local id = vRP.prompt(source,"Passaporte:","")
		local valor = vRP.prompt(source,"Valor:","")
		local motivo = vRP.prompt(source,"Motivo:","")
		if id == "" or valor == "" or motivo == "" then
			return
		end
		local value = vRP.getUData(parseInt(id),"vRP:multas")
		local multas = json.decode(value) or 0
		vRP.setUData(parseInt(id),"vRP:multas",json.encode(parseInt(multas)+parseInt(valor)))
		local oficialid = vRP.getUserIdentity(user_id)
		local identity = vRP.getUserIdentity(parseInt(id))
		local nplayer = vRP.getUserSource(parseInt(id))
		SendWebhookMessage(webhookmultas,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============MULTOU==============] \n[PASSAPORTE]: "..id.." "..identity.name.." "..identity.firstname.." \n[VALOR]: $"..vRP.format(parseInt(valor)).." \n[MOTIVO]: "..motivo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

		randmoney = math.random(1,3)
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("Notify",source,"sucesso","Multa aplicada com sucesso.")
		TriggerClientEvent("Notify",source,"importante","Sistema","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
		TriggerClientEvent("Notify",nplayer,"importante","Você foi multado em <b>$"..vRP.format(parseInt(valor)).." dólares</b>.<br><b>Motivo:</b> "..motivo..".")
		vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DETIDO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('detido',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") then
        local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,5)
        local motivo = vRP.prompt(source,"Motivo:","")
        if motivo == "" then
			return
		end
		local oficialid = vRP.getUserIdentity(user_id)
        if vehicle then
            local puser_id = vRP.getUserByRegistration(placa)
            local rows = vRP.query("creative/get_vehicles",{ user_id = parseInt(puser_id), vehicle = vname })
            if rows[1] then
                if parseInt(rows[1].detido) == 1 then
                    TriggerClientEvent("Notify",source,"importante","Este veículo já se encontra detido.",8000)
                else
                	local identity = vRP.getUserIdentity(puser_id)
                	local nplayer = vRP.getUserSource(parseInt(puser_id))
                	SendWebhookMessage(webhookdetido,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============PRENDEU==============] \n[CARRO]: "..vname.." \n[PASSAPORTE]: "..puser_id.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: "..motivo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                    vRP.execute("creative/set_detido",{ user_id = parseInt(puser_id), vehicle = vname, detido = 1, time = parseInt(os.time()) })

					randmoney = math.random(90,150)
					vRP.giveMoney(user_id,parseInt(randmoney))
					TriggerClientEvent("Notify",source,"sucesso","Carro apreendido com sucesso.")
					TriggerClientEvent("Notify",source,"importante","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
					TriggerClientEvent("Notify",nplayer,"importante","Seu Veículo foi <b>Detido</b>.<br><b>Motivo:</b> "..motivo..".")
					vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
                end
            end
        end
    end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('prender',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"ceo.permissao") or vRP.hasPermission(user_id,"policia.permissao") then
		local crimes = vRP.prompt(source,"Crimes:","")
		if crimes == "" then
			return
		end

		local player = vRP.getUserSource(parseInt(args[1]))
		if player then
			vRP.setUData(parseInt(args[1]),"vRP:prisao",json.encode(parseInt(args[2])))
			vRPclient.setHandcuffed(player,false)
			TriggerClientEvent('prisioneiro',player,true)
			vRPclient.teleport(player,1680.1,2513.0,45.5)
			prison_lock(parseInt(args[1]))
			TriggerClientEvent('removealgemas',player)
			TriggerClientEvent("vrp_sound:source",player,'jaildoor',0.7)
			TriggerClientEvent("vrp_sound:source",source,'jaildoor',0.7)

			
			local oficialid = vRP.getUserIdentity(user_id)
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			SendWebhookMessage(webhookprender,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============PRENDEU==============] \n[PASSAPORTE]: "..(args[1]).." "..identity.name.." "..identity.firstname.." \n[TEMPO]: "..vRP.format(parseInt(args[2])).." Meses \n[CRIMES]: "..crimes.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			
			randmoney = math.random(90,150)
			vRP.giveMoney(user_id,parseInt(randmoney))
			TriggerClientEvent("Notify",source,"sucesso","Prisão efetuada com sucesso.")
			TriggerClientEvent("Notify",source,"importante","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
			TriggerClientEvent("Notify",nplayer,"importante","Você foi preso por <b>"..vRP.format(parseInt(args[2])).." meses</b>.<br><b>Motivo:</b> "..crimes..".")
			vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
		end 
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKAR RG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rg',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"policia.permissao") then
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
				local banco = vRP.getBankMoney(nuser_id)
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #5AC3FF; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		else
			local nplayer = vRPclient.getNearestPlayer(source,2)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local value = vRP.getUData(nuser_id,"vRP:multas")
				local valormultas = json.decode(value) or 0
				local identityv = vRP.getUserIdentity(user_id)
				local identity = vRP.getUserIdentity(nuser_id)
				local carteira = vRP.getMoney(nuser_id)
				local banco = vRP.getBankMoney(nuser_id)
				TriggerClientEvent("Notify",nplayer,"importante","Seu documento está sendo verificado por <b>"..identityv.name.." "..identityv.firstname.."</b>.")
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #5AC3FF; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('al',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if not vRPclient.isHandcuffed(source) then
			if vRP.getInventoryItemAmount(user_id,"algemas") >= 1 then
				if vRPclient.isHandcuffed(nplayer) then
					TriggerClientEvent('carregar',nplayer,source)
					vRPclient._playAnim(source,false,{{"mp_arresting","a_uncuff"}},false)
					SetTimeout(5000,function()
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent('carregar',nplayer,source)
						TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
						TriggerClientEvent('removealgemas',nplayer)
					end)
				else
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('cancelando',nplayer,true)
					TriggerClientEvent('carregar',nplayer,source)
					vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
					vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
					SetTimeout(3500,function()
						vRPclient._stopAnim(source,false)
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent('carregar',nplayer,source)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('cancelando',nplayer,false)
						TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
						TriggerClientEvent('setalgemas',nplayer)
					end)
				end
			else
				if vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"policia.permissao") then
					if vRPclient.isHandcuffed(nplayer) then
						TriggerClientEvent('carregar',nplayer,source)
						vRPclient._playAnim(source,false,{{"mp_arresting","a_uncuff"}},false)
						SetTimeout(5000,function()
							vRPclient.toggleHandcuff(nplayer)
							TriggerClientEvent('carregar',nplayer,source)
							TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
							TriggerClientEvent('removealgemas',nplayer)
						end)
					else
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent('cancelando',nplayer,true)
						TriggerClientEvent('carregar',nplayer,source)
						vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
						vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
						SetTimeout(3500,function()
							vRPclient._stopAnim(source,false)
							vRPclient.toggleHandcuff(nplayer)
							TriggerClientEvent('carregar',nplayer,source)
							TriggerClientEvent('cancelando',source,false)
							TriggerClientEvent('cancelando',nplayer,false)
							TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
							TriggerClientEvent('setalgemas',nplayer)
						end)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('c',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") then	
		if nplayer then
			if not vRPclient.isHandcuffed(source) then
				TriggerClientEvent('carregar',nplayer,source)
			end
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CINTO 
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cinto',function(source, args, rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"polpar.permissao") then	
		if nplayer then
			TriggerClientEvent('rusher:ColocarCinto',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rmascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"staff.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rmascara',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rchapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rchapeu',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rcapuz',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isCapuz(nplayer) then
				vRPclient.setCapuz(nplayer)
				TriggerClientEvent("Notify",source,"sucesso","Capuz retirado com sucesso.")
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa não está com o capuz na cabeça.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") and not vRPclient.isInVehicle(source) then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.putInNearestVehicleAsPassenger(nplayer,7,parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.ejectVehicle(nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYEXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryextras")
AddEventHandler("tryextras",function(index,extra)
    TriggerClientEvent("syncextras",-1,index,parseInt(extra))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cone',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"conce.permissao") or vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"bennys.permissao") then
		TriggerClientEvent('cone',source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('barreira',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"conce.permissao") or vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"bennys.permissao") then
		TriggerClientEvent('barreira',source,args[1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPIKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('spike',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		TriggerClientEvent('spike',source,args[1])
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('atirando')
AddEventHandler('atirando',function(x,y,z,infos)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") then
			local policiais = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(policiais) do
				local player = vRP.getUserSource(w)
				if player then
					TriggerClientEvent('notificacao',player,x,y,z,user_id,infos)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('anuncio',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"staff.permissao") or vRP.hasPermission(user_id,"adm.permissao") then
			local mensagem = vRP.prompt(source,"Mensagem:","")
			local nome = vRP.prompt(source,"Nome:","")
			if mensagem == "" or nome == "" then
				return
			end
			TriggerClientEvent("Notify",-1,"importante",mensagem.."<br><b>Mensagem enviada por:</b> "..nome,60000)
		end
	end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local player = vRP.getUserSource(parseInt(user_id))
	if player then
		SetTimeout(30000,function()
			local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
			local tempo = json.decode(value) or -1

			if tempo == -1 then
				return
			end

			if tempo > 0 then
				TriggerClientEvent('prisioneiro',player,true)
				vRPclient.teleport(player,1680.1,2513.0,46.5)
				prison_lock(parseInt(user_id))
			end
		end)
	end
end)

function prison_lock(target_id)
	local player = vRP.getUserSource(parseInt(target_id))
	if player then
		SetTimeout(60000,function()
			local value = vRP.getUData(parseInt(target_id),"vRP:prisao")
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 1 then
				TriggerClientEvent("Notify",player,"importante","Ainda vai passar <b>"..parseInt(tempo).." meses</b> preso.")
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(parseInt(tempo)-1))
				prison_lock(parseInt(target_id))
			elseif parseInt(tempo) == 0 then
				TriggerClientEvent('prisioneiro',player,false)
				vRPclient.teleport(player,1850.5,2604.0,45.5)
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(-1))
				TriggerClientEvent("Notify",player,"importante","Sua sentença terminou, esperamos não ve-lo novamente.")
			end
			vRPclient.PrisionGod(player)
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUIR PENA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("diminuirpena2121")
AddEventHandler("diminuirpena2121",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
	local tempo = json.decode(value) or 0
	if tempo >= 10 then
		vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo)-2))
		TriggerClientEvent("Notify",source,"importante","Sistema","Sua pena foi reduzida em <b>2 meses</b>, continue o trabalho.")
	else
		TriggerClientEvent("Notify",source,"importante","Sistema","Atingiu o limite da redução de pena, não precisa mais trabalhar.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	"dinheirosujo",
	"algemas",
	"lockpick",
	"cartao-desmanche",
	"capuz",
	"placa",
	"c4",
	"acidobateria",
	"composito-alta",
	"nitrato-amonia",
	"pecadearma",
	"materialmunicaopesada",
	"materialmunicao",
	"hidroxido-sodio",
	"pseudoefedrina",
	"eter",
	"anfetamina",
	"metanfetamina",
	"cocamisturada",
	"cocaina",
	"folhadecoca",
	"querosene",
	"maconha",
	"folhademaconha",
	"maconhamacerada",
	"pecadearma",
	"pecadominacao",
	"lsd",
	"materialmunicao",
	"fertilizante",
	"adubo",
	"corpo-ak47",
	"corpo-m4",
	"corpo-m4spec",
	"corpo-tec9",
	"corpo-fs",
	"corpo-sns",
	"molas",
	"placa-metal",
	"gatilho",
	"capsulas",
	"polvora",
	"wbody_WEAPON_FLARE",
	"wbody_WEAPON_KNIFE",
	"wbody_WEAPON_DAGGER",
	"wbody_WEAPON_KNUCKLE",
	"wbody_WEAPON_MACHETE",
	"wbody_WEAPON_SWITCHBLADE",
	"wbody_WEAPON_WRENCH",
	"wbody_WEAPON_HAMMER",
	"wbody_WEAPON_GOLFCLUB",
	"wbody_WEAPON_CROWBAR",
	"wbody_WEAPON_HATCHET",
	"wbody_WEAPON_FLASHLIGHT",
	"wbody_WEAPON_BAT",
	"wbody_WEAPON_BOTTLE",
	"wbody_WEAPON_BATTLEAXE",
	"wbody_WEAPON_POOLCUE",
	"wbody_WEAPON_STONE_HATCHET",
	"wbody_WEAPON_NIGHTSTICK",
	"wbody_WEAPON_COMBATPISTOL",
	"wbody_WEAPON_PISTOL_MK2",
	"wbody_WEAPON_SNSPISTOL",
	"wbody_WEAPON_STUNGUN",
	"wbody_WEAPON_ASSAULTRIFLE_MK2",
	"wbody_WEAPON_CARBINERIFLE",
	"wbody_WEAPON_CARBINERIFLE_MK2",
	"wbody_WEAPON_SPECIALCARBINE_MK2",
	"wbody_WEAPON_SMG",
	"wbody_WEAPON_SMG_MK2",
	"wbody_WEAPON_MACHINEPISTOL",
	"wammo_WEAPON_FLARE",
	"wammo_WEAPON_COMBATPISTOL",
	"wammo_WEAPON_PISTOL_MK2",
	"wammo_WEAPON_SNSPISTOL",
	"wammo_WEAPON_PISTOL50",
	"wammo_WEAPON_STUNGUN",
	"wammo_WEAPON_ASSAULTRIFLE_MK2",
	"wammo_WEAPON_CARBINERIFLE",
	"wammo_WEAPON_CARBINERIFLE_MK2",
	"wammo_WEAPON_SPECIALCARBINE_MK2",
	"wammo_WEAPON_SMG",
	"wammo_WEAPON_SMG_MK2",
	"wammo_WEAPON_MACHINEPISTOL",
	"wammo_WEAPON_PUMPSHOTGUN_MK2",
	"wammo_WEAPON_MUSKET"

}

RegisterCommand('apreender',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local user_id = vRP.getUserId(source)

		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local identity = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local nidentity = vRP.getUserIdentity(nuser_id)
				local itens_apreendidos = {}
				local weapons = vRPclient.replaceWeapons(nplayer,{})

				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"oddjobs@shop_robbery@rob_till","loop"}},true)
				TriggerClientEvent("progress",source,5000,"apreendendo")
				SetTimeout(5000,function()

					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody_"..k,1)
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo_"..k,v.ammo)
						end
					end

					local inv = vRP.getInventory(nuser_id)
					for k,v in pairs(itemlist) do
						local sub_items = { v }
						if string.sub(v,1,1) == "*" then
							local idname = string.sub(v,2)
							sub_items = {}
							for fidname,_ in pairs(inv) do
								if splitString(fidname,"_")[1] == idname then
									table.insert(sub_items,fidname)

								end
							end
						end

						for _,idname in pairs(sub_items) do
							local amount = vRP.getInventoryItemAmount(nuser_id,idname)
							if amount > 0 then
								local item_name,item_weight = vRP.getItemDefinition(idname)
								if item_name then
									if vRP.tryGetInventoryItem(nuser_id,idname,amount,true) then
										vRP.giveInventoryItem(user_id,idname,amount)
										table.insert(itens_apreendidos, "[ITEM]: "..vRP.itemNameList(idname).." [QUANTIDADE]: "..amount)
									end
								end
							end
						end
					end
					local apreendidos = table.concat(itens_apreendidos, "\n")
					TriggerClientEvent("Notify",nplayer,"importante","Todos os seus pertences foram apreendidos.")
					TriggerClientEvent("Notify",source,"importante","Sistema","Apreendeu todos os pertences da pessoa.")
					SendWebhookMessage(webhookpoliciaapreendidos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[APREENDEU DE]:  "..nuser_id.." "..nidentity.name.." "..nidentity.firstname.."\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
				end)
			end
		end
	end
end)