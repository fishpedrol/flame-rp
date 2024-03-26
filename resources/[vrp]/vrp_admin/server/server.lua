local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local src = {}
--Tunnel.bindInterface("vrp_admin",src)
Tunnel.bindInterface(GetCurrentResourceName(),src)
vCLIENT = Tunnel.getInterface("vrp_admin")
vGARAGE = Tunnel.getInterface("vrp_garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK 
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookitem = ""
local webhookclearchest = ""
local webhookset = ""
local webhookgod = ""
local crashWebhook = ''
local webhookkick = ''
local webhookrename = ''
local webhookfix = ''
local webhookaddcasa = ''
local webhookremcasa = ''
local webhookcobraradm = ''
local webhookenviaradm = ''
local webhookitemplayer = ''
local webhookmoney = ''
local webhooksetar = ''
local webhooktirarset = ''
local webhookban = ''
local webhookunban = ''
local webhookwl = ''
local webhookunwl = ''
local webhookaddcar = ''
local webhookremcar = ''
local webhookarma = ''
local webhookkill = ''
local webhookarlimparinv = ''
local webhookplaca = ''
local webhooknumero = ''
local webhooksetinv = ''
local webhooknoclip = ''
local webhookney = ''
local webhooktapa = ''
local webhookdevtools = ''
local webhookapertoue = ''
local webhookspawncar = ''
local webhookadmin = ''
local webhookmultasadm = '' 
local webhookobitoadm = ''
local webhookobito2 = ''
local webhookbantemp = ''

function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

RegisterServerEvent('fall:LoggarAeroporto')
AddEventHandler('fall:LoggarAeroporto', function(source,x,y,z)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	SendWebhookMessage(webhookapertoue,'```prolog\n[ID]: ' .. user_id .. ' ' .. identity.name .. ' ' .. identity.firstname .. '\nAPERTOU [E] PARA VOLTAR AO AEROPORTO\n[POS]: ' .. tD(x) .. ', ' .. tD(y) .. ', ' .. tD(z) .. '```')
end)

--------------------------------------------------------------------------------------------------------------------------------
-- DROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped', function (reason)
	print('' .. GetPlayerName(source) .. ' Saiu (Motivo:: ' .. reason .. ')')
	if string.match(reason, 'CrashCommand') or string.match(reason, 'Reloading game') or string.match(reason, '!memcpy') then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		vRP.setBanned(user_id, 1)
		SendWebhookMessage(crashWebhook,"```prolog\n"..user_id.." "..identity.name.." "..identity.firstname.." foi banido por utilizar o comando de " .. reason ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```<@887157379895009291>")
	end
end)
--[[
	 Fila 
	 ]]

RegisterCommand('fila',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,'admin.permissao') then
	TriggerClientEvent("Notify",source,"importante","Importante",(#Queue.QueueList).." pessoas na fila da alfandega.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEVTOOLS
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ function src.ban()
    local user_id = vRP.getUserId(source)
	if user_id then
        vRP.kick(source,"Você foi expulso da cidade.")
        vRP.setBanned(user_id,true)
        SendWebhookMessage(webhookdevtools, "ANTI DEVTOOLS     [ID]: "..user_id.."  [KICKADO]		[MOTIVO: ACESSANDO O DEVTOOLS]	")
    end 
end ]]

-----------------------------------------------------------------------------------------------------------------------------------------
-- ZERAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare('vrp/get_datatable', 'SELECT * FROM vrp_user_data WHERE user_id = @user_id AND dkey = @dkey')
vRP._prepare('vrp/update_datatable', 'UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id AND dkey = @dkey')

RegisterCommand('limparinv',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		local tuser_id = tonumber(args[1])
		local tplayer = vRP.getUserSource(tonumber(tuser_id))
		local tplayerID = vRP.getUserId(tonumber(tplayer))
		if tplayerID ~= nil then
			local identity = vRP.getUserIdentity(user_id)
            if vRP.request(source,"Deseja limpar o inventário do Passaporte <b>"..args[1].."</b> ?",30) then
			vRP.clearInventory(tplayerID)
            vRPclient.giveWeapons(tplayer,{},true)
			TriggerClientEvent("Notify",source,"sucesso","Limpou inventario do ID <b>"..args[1].."</b>.")
			SendWebhookMessage(webhookarlimparinv,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[LIMPOU O INV]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
            local nplayer = tonumber(args[1])
            local nsource = vRP.getUserSource(nplayer)
            local pesquisa = PegarDatatable(nplayer)
			if pesquisa[1] and pesquisa[1] ~= nil then
                local result = json.decode(pesquisa[1].dvalue)
                if result.weapons then
                    result.weapons = nil
                end
                if result.inventory then
                    result.inventory = nil
                end
                AtualizarDatatable(nplayer, result)
                TriggerClientEvent('Notify', source, 'sucesso','Você limpou o inventario do '..args[1])
                SendWebhookMessage(webhookarlimparinv,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[LIMPOU O INV]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                end
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MOC
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setinv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if user_id then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				local nuser_id = vRP.getUserId(nplayer)
				local nuidentity = vRP.getUserIdentity(user_id)
				if vRP.hasPermission(user_id,"adm.permissao") then
					if args[2] == "1" then
						vRP.setExp(nuser_id,"physical","strength",20) -- 6KG
					elseif args[2] == "2" then
						vRP.setExp(nuser_id,"physical","strength",670) -- 51KG
					elseif args[2] == "3" then
						vRP.setExp(nuser_id,"physical","strength",1320) -- 75KG
					elseif args[2] == "4" then
						vRP.setExp(nuser_id,"physical","strength",1900) -- 90KG
					elseif args[2] == "5" then
						vRP.setExp(nuser_id,"physical","strength",3400) -- 120KG
					elseif args[2] == "6" then
						vRP.setExp(nuser_id,"physical","strength",2240000) -- 1002KG
					else
						TriggerClientEvent("Notify",source,"negado","<b>6KG = 1  51KG = 2  75KG = 3  90KG = 4  120KG< = 5  10000KG = 6</b>")
					end
					TriggerClientEvent("Notify",source,"sucesso","Sistema!","Voce setou uma mochila nível <b>"..args[2].."</b> no jogador <b>"..nuidentity.name.." "..nuidentity.firstname.."</b>.")
					PerformHttpRequest(moc, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 	------------------------------------------------------------
								title = "REGISTRO DE SETAGEM DE MOCHILA⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",
								thumbnail = {
									url = "https://media.discordapp.net/attachments/871580967649808414/871819029931782244/9HuyLXu.png?width=676&height=676"
								}, 
								fields = {
									{ 
										name = "**COLABORADOR DA EQUIPE:**",
										value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]\n⠀"
									},
									{
										name = "SETOU UMA MOCHILA NÍVEL **"..args[2].."** NO JOGADOR: ",
										value = ""..nuidentity.name.." "..nuidentity.firstname.." ["..nuser_id.."]\n⠀"
									}
								}, 
								footer = { 
									text = "Flame Evolved - "..os.date("%d/%m/%Y | %H:%M:%S"),
									icon_url = "https://media.discordapp.net/attachments/871580967649808414/871819029931782244/9HuyLXu.png?width=676&height=676"
								},
								color = 15906321 
							}
						}
					}), { ['Content-Type'] = 'application/json' })
				end
			else
				TriggerClientEvent("Notify",source,"negado","O jogador não está online.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLIST
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare('vrp/procurandoset', "SELECT * FROM vrp_user_data WHERE dvalue REGEXP @grupo")

RegisterCommand('setlist', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'adm.permissao') or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then

			local resultado = vRP.query('vrp/procurandoset', {grupo = args[1]})
			if resultado ~= nil then
				local result = ''
				for k, v in pairs(resultado) do 
					local identity = vRP.getUserIdentity(v.user_id)
					result = result .. v.user_id .. ' ' .. identity.name .. ' ' .. identity.firstname .. '\n'
				end
				vRP.prompt(source, args[1]..' (' .. #resultado .. '):', result)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DADOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dados',function(source,args,rawCommand)
    local ip = GetPlayerEndpoint(source)
    local steamhex = GetPlayerIdentifier(source)
    local ping = GetPlayerPing(source)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                local ip2 = GetPlayerEndpoint(nplayer)
                local steamhex2 = GetPlayerIdentifier(nplayer)
                local ping2 = GetPlayerPing(nplayer)
               TriggerClientEvent("Notify",source,'aviso',"IP do player:"  ..ip2.."")
               TriggerClientEvent("Notify",source,'aviso',"Player Hex:" ..steamhex2.."")
               TriggerClientEvent("Notify",source,'aviso',"Ping do player:" ..ping2.."")
            end
        else
            TriggerClientEvent("Notify",source,'aviso',"Seu IP:"  ..ip.."")
            TriggerClientEvent("Notify",source,'aviso',"Sua hex:"  ..steamhex.."")
            TriggerClientEvent("Notify",source,'aviso',"Seu ping:"  ..ping.."")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEAR CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('clearchest',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"adm.permissao") then
        if args[1] then
            local identity2 = vRP.getUserIdentity(parseInt(args[2]))
            if vRP.request(source,"Deseja limpar o baú <b>"..args[1].."</b> ?",30) then
                vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(args[1]) })
                TriggerClientEvent("Notify",source,"sucesso","Você limpou o baú <b>"..args[1].."</b>.")
                SendWebhookMessage(webhookclearchest,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[LIMPOU BAU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET HEALTH --[[ (101-400) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('sethealth',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id,"adm.permissao") then
--        if args[1] then
--            vRPclient.setHealth(source,args[1])
--		end
--	end
--end)

RegisterCommand('hp',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if user_id == 0 or user_id == 1 then
		if args[1] then
			local vida = parseInt(args[2])
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				TriggerClientEvent('fall:ExcecaoVida', nplayer)
				vRPclient.setHealth(nplayer,vida)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
			if args[1] then

				if string.lower(args[1]) == 'delexue' then
					if user_id ~= 1 and user_id ~= 5 then
						return
					end
				end

				if string.lower(args[1]) == 'mr300sel' or string.lower(args[1]) == 'porschestart' then

					if user_id ~= 1 then 
						TriggerClientEvent('Notify', source, 'negado', 'Esse carro é somente para o Elite.') 
						return 
					end

				end
				SendWebhookMessage(webhookspawncar,"```prolog\n[=========CAR=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU]: "..(args[1]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				--TriggerClientEvent('spawnarveiculo',source,args[1],identity.registration)
				vCLIENT.spawnVeh(source,args[1],identity.registration)
				TriggerEvent("setPlateEveryone",identity.registration)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('radm',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"suporte.permissao") then
		if #args == 1 then
			local nuser_id = parseInt(args[1])
			local nsource = vRP.getUserSource(nuser_id)
			local identity = vRP.getUserIdentity(user_id)
			local nidentity = vRP.getUserIdentity(nuser_id)

			if nuser_id then

				local resposta = vRP.prompt(source,"Resposta particular:","")
				if resposta == "" then
					return
				end

				for k, v in pairs(vRP.getUsersByPermission('suporte.permissao')) do
					TriggerClientEvent('chatMessage', vRP.getUserSource(v),"[ATENDIMENTO] "..identity.name.." "..identity.firstname.." respondeu " .. nidentity.name .. " " .. nidentity.firstname .. " (" .. nuser_id .. ")",{0,114,190}, resposta)
				end
				SendWebhookMessage(webhookadmin,"```prolog\n[=========RESPOSTA ADM=========] \n[ID]: "..user_id.." " .. "\n[RESPONDEU]: " .. nidentity.name .. " " .. nidentity.firstname .. " " .. nuser_id .."\n[RESPOSTA]: "..resposta.. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```") 
				TriggerClientEvent('chatMessage',nsource,"[ATENDIMENTO] Recebida de "..identity.name.." "..identity.firstname .. " (" .. user_id .. ")",{0,114,190}, resposta)
			end
		end
	end
end)


RegisterCommand('admins',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local admin = vRP.getUsersByPermission("adm.permissao")
    local mod = vRP.getUsersByPermission("mod.permissao")
    local sup = vRP.getUsersByPermission("suporte.permissao")
    local escravo2 = vRP.getUsersByPermission("aprovador.permissao")
	local escravo = vRP.getUsersByPermission("mecanico.permissao")
    local coxa = vRP.getUsersByPermission("policia.permissao")
    local medicosul = vRP.getUsersByPermission("medico.permissao")
    if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if user_id then
            TriggerClientEvent('chatMessage',source,"ADMIN ONLINE:",{0,0,0},admin)
            TriggerClientEvent('chatMessage',source,"MODERADOR ONLINE:",{0,255,255},mod)
            TriggerClientEvent('chatMessage',source,"SUPORTE ONLINE:",{255,115,0},sup)
            TriggerClientEvent('chatMessage',source,"APROVADOR WL ONLINE:",{60,179,113},escravo2)
			TriggerClientEvent('chatMessage',source,"MECANICO ONLINE:",{255,128,0},escravo)
			TriggerClientEvent('chatMessage',source,"POLICIA ONLINE:",{65,130,255},coxa)
			TriggerClientEvent('chatMessage',source,"MEDICO ONLINE:",{255,0,0},medicosul)
        end
    end
end)

RegisterCommand('facs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local crips = vRP.getUsersByPermission("crips.permissao")
    local bloods = vRP.getUsersByPermission("blood.permissao")
    local vagos = vRP.getUsersByPermission("vagos.permissao")
    local grove = vRP.getUsersByPermission("grove.permissao")
    local ballas = vRP.getUsersByPermission("ballas.permissao")
    local russkaya = vRP.getUsersByPermission("russkaya.permissao")
    local yardie = vRP.getUsersByPermission("yardie.permissao")
    local lifeinvader = vRP.getUsersByPermission("lifeinvader.permissao")
    local bahamas = vRP.getUsersByPermission("bahamas.permissao")
    if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if user_id then
            TriggerClientEvent('chatMessage',source,"CRIPS ONLINE:",{0,0,255},crips)
            TriggerClientEvent('chatMessage',source,"BLOODS ONLINE:",{255,0,0},bloods)
            TriggerClientEvent('chatMessage',source,"VAGOS ONLINE:",{255,255,0},vagos)
            TriggerClientEvent('chatMessage',source,"GROVE ONLINE:",{0,255,0},grove)
            TriggerClientEvent('chatMessage',source,"BALLAS ONLINE:",{255,0,255},ballas)
            TriggerClientEvent('chatMessage',source,"RUSSKAYA ONLINE:",{0,0,0},russkaya)
            TriggerClientEvent('chatMessage',source,"YARDIE ONLINE:",{255,255,255},yardie)
            TriggerClientEvent('chatMessage',source,"BAHAMAS ONLINE:",{0,250,154},bahamas)
            TriggerClientEvent('chatMessage',source,"LIFEINVADER ONLINE:",{255,228,225},lifeinvader)
            
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- VIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vips',function(source,args,rawCommand)
    
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		local elite = vRP.getUsersByPermission("ultimate.permissao")
		local sexo = vRP.getUsersByPermission("master.permissao")
        local vip = vRP.getUsersByPermission("rental.permissao")

		TriggerClientEvent('chatMessage',source,"VIPS Flame ELITE ONLINE",{255, 60, 51},elite)
		TriggerClientEvent('chatMessage',source,"VIPS Flame ELITE ONLINE",{255, 60, 51},sexo)
		TriggerClientEvent('chatMessage',source,"RENTAL ONLINE",{51, 255, 70},vip)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPINCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpin', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		if args[1] then
			local nsource = vRP.getUserSource(parseInt(args[1]))
			TriggerClientEvent('Flame:SetarDentroDocarro',source, nsource)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('idp',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if vRP.hasPermission(user_id, 'adm.permissao') then	
		if nplayer then
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id == 1 or nuser_id == 0 then nuser_id = user_id end
			TriggerClientEvent("Notify",source,"importante","Jogador próximo: <b>ID:"..nuser_id.."</b>.")
		else
			TriggerClientEvent("Notify",source,'aviso',"<b>Nenhum Jogador Próximo</b>")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('adm', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'adm.permissao') or vRP.hasPermission(user_id,"mod.permissao")  or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local tipo = args[1]
			if (tipo == 'normal') or (tipo == 'verm') or (tipo == 'ai') then
				
                local titulo = vRP.prompt(source, 'Título da mensagem', 'AVISO ADMIN')
				if titulo == '' then TriggerClientEvent("Notify",source,'aviso','Você não especificou um título.',10000) return	end

				local msg = vRP.prompt(source, 'Mensagem', '')
				if msg == '' then TriggerClientEvent("Notify",source,'aviso','Você não especificou uma mensagem.',10000) return end

				TriggerClientEvent('startUi:MostrarNotAdm', -1, {titulo, msg, tipo})
			end
		else
			TriggerClientEvent("Notify",source,'aviso','O tipo precisa ser válido. Tipos válidos: [normal|verm|ai]',10000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD VEHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"adm.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nsource)
            local nsource = vRP.getUserSource(parseInt(args[2]))
            local identity2 = vRP.getUserIdentity(parseInt(args[2]))
            if vRP.request(source,"Deseja adicionar o veículo <b>"..vRP.vehicleName(args[1]).."</b> para o Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b> ?",30) then
                vRP.execute("creative/add_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) })
                TriggerClientEvent("Notify",source,"sucesso","Informaçoes","Você adicionou o veículo <b>"..vRP.vehicleName(args[1]).."</b> para o Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b>.")
                if nsource then
                    TriggerClientEvent("Notify",nsource,"sucesso","Informaçoes","Foi adicionado o veículo <b>"..vRP.vehicleName(args[1]).."</b> na sua garagem.",10000)
                end
                SendWebhookMessage(webhookaddcar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ADICIONOU]: "..vRP.vehicleName(args[1]).." \n[PARA O ID]: "..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM VEHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"adm.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nsource)
            local nsource = vRP.getUserSource(parseInt(args[2]))
            local identity2 = vRP.getUserIdentity(parseInt(args[2]))
            if vRP.request(source,"Deseja remover o veículo <b>"..vRP.vehicleName(args[1]).."</b> do Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b> ?",30) then
    			vRP.execute("creative/rem_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1] })
                TriggerClientEvent("Notify",source,"sucesso","Informaçoes","Você removeu o veículo <b>"..vRP.vehicleName(args[1]).."</b> do Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b>.")
                if nsource then
                    TriggerClientEvent("Notify",nsource,"aviso","Informaçoes","Foi removido o veículo <b>"..vRP.vehicleName(args[1]).."</b> da sua garagem.",10000)
                end
                SendWebhookMessage(webhookremcar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..vRP.vehicleName(args[1]).." \n[DO ID]: "..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UNCUFF
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('alg',function(source,args,rawCommand)
   local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") then
       if args[1] then
           local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("admcuff",nplayer)
            end
        else
            TriggerClientEvent("admcuff",source)
        end
    end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- ALGEMAR ADM 
-------------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('admalg', function(source, args, rawCmd)
--    
--	local user_id = vRP.getUserId(source)
--	if vRP.hasGroup(user_id,'admin') then
--		if args[1] then
--			local nplayer = vRP.getUserSource(parseInt(args[1]))
--			vRPclient.toggleHandcuff(nplayer)
--		else
--			vRPclient.toggleHandcuff(source)
--		end
--	end
--end)
RegisterCommand('aladm',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRP.getUserSource(parseInt(args[1]))
	if nplayer then
		if not vRPclient.isHandcuffed(source) then
            if vRP.hasPermission(user_id,"adm.permissao")then
                if vRPclient.isHandcuffed(nplayer) then
                    vRPclient.toggleHandcuff(nplayer)
                    TriggerClientEvent('removealgemas',nplayer)
                else
                    vRPclient.toggleHandcuff(nplayer)
                    TriggerClientEvent('setalgemas',nplayer)
                end
            end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKIN
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand("trunkin",function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	if user_id then
--		if vRP.hasPermission(user_id,"adm.permissao") then
--			TriggerClientEvent("vrp_admin:EnterTrunk",source)
--		end
--	end
--end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- CHECKTRUNK
-------------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand("checktrunk",function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	if user_id then
--        if vRP.hasPermission(user_id,"adm.permissao") then
--            local nplayer = vRPclient.getNearestPlayer(source,2)
--            if nplayer then
--                TriggerClientEvent("vrp_admin:CheckTrunk",nplayer)
--            end
--        end
--	end
--end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NEY
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ney',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local nuser_id = tonumber(args[1])
    local nsource = vRP.getUserSource(nuser_id)
	if user_id then
		if vRP.hasPermission(user_id, 'adm.permissao') or vRP.hasPermission(user_id,"mod.permissao") then
			vCLIENT.neyMar(nsource)
            SendWebhookMessage(webhookney,"```prolog\n[ID]: "..user_id.." \n[DEU NEY NO]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)

--RegisterCommand('start',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id, 'src.permissao') then
--
--		local users = vRP.getUsers()
--		local players = ""
--		local quantidade = 0
--		
--		print(source .. ' esta usando o comando')
--
--		if source ~= 0 then return end
--
--		if args[1] == 'status' then
--			for k,v in pairs(users) do
--				if k ~= #users then
--					players = players..", "
--				end
--				players = players..k
--				quantidade = quantidade + 1
--			end
--			print("TOTAL ONLINE: "..quantidade)
--
--		elseif args[1] == 'ids' then
--			for k,v in pairs(users) do
--				if k ~= #users then
--					players = players..", "
--				end
--				players = players..k
--				quantidade = quantidade + 1
--			end
--			print("ID's ONLINE: "..players)
--
--		elseif args[1] == 'ban' and args[2] ~= nil then
--			vRP.setBanned(parseInt(args[2]),true)
--			print("Você baniu o ID: "..args[2])
--
--		elseif args[1] == 'kick' and args[2] ~= nil then
--			local id = vRP.getUserSource(parseInt(args[2]))
--			vRP.kick(id,"Timed out after 60 seconds.")
--			print("Você kickou o ID "..id)
--		end
--	end
--end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TAPA
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tapa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if args[1] then
			if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
                local nsource = vRP.getUserSource(parseInt(args[1]))
                vCLIENT.makeFly(nsource)
                SendWebhookMessage(webhooktapa,"```prolog\n[ID]: "..user_id.." \n[DEU TAPA NO]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PNEUADM
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('furarpneu', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		if args[2] then
			local nsource = vRP.getUserSource(parseInt(args[1]))
			TriggerClientEvent('fall:FurarPneuTeleguiado',nsource, parseInt(args[2]))
		else
			TriggerClientEvent('fall:FurarPneuTeleguiado',source, parseInt(args[1]))
		end
	end
end)

RegisterServerEvent('fall:AskABCSync')
AddEventHandler('fall:AskABCSync', function(a,b)
	vCLIENT.SyncPneuFurado(-1,a,b)
end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vCLIENT.applySkinAdmin(nplayer,args[2])
                TriggerClientEvent("Notify",source,"sucesso","Voce setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.")
            end
        end
    end
end)

--RegisterCommand("objetos",function(source,args,rawCommand)
--    
--	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id,"suporte.permissao") then
--		if user_id then
--			if not vRPclient.isInVehicle(source) then
--				local x,y,z = vRPclient.getPosition(source)
--				local data = vRP.getUserDataTable(user_id)
--				if data then
--					vRPclient._setCustomization(source,data.customization)
--					--TriggerClientEvent("syncarea",-1,x,y,z,2)
--					vCLIENT.syncArea(-1,x,y,z,2)
--					TriggerClientEvent("Notify",source,"sucesso","Você limpou todos Obejetos.")
--				end
--			end
--		end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
    TriggerClientEvent("syncdeleteobj",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if not args[1] then
			local vehicle = vRPclient.getNearestVehicle(source,7)
			if vehicle then
				TriggerClientEvent('reparar',source,vehicle)
				PerformHttpRequest(webhookfix, function(err, text, headers) end, 'POST', json.encode({username = botusername, content = "```prolog\n[ID]: "..user_id.." \n[USOU FIX] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```"}), { ['Content-Type'] = 'application/json' })
			end
		else 
			local nuser_id = parseInt(args[1])
			local nsource = vRP.getUserSource(nuser_id)
			local vehicle = vRPclient.getNearestVehicle(nsource,7)
			if vehicle then
				TriggerClientEvent('reparar',nsource,vehicle)
				SendWebhookMessage(webhookfix,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DEU FIX NO CARRO DO]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"streamer.permissao") then
		--if parseInt(args[1]) == 5 or parseInt(args[1]) == 388 or parseInt(args[1]) == 1270 or parseInt(args[1]) == 25 or parseInt(args[1]) == 416 or parseInt(args[1]) == 1270 or parseInt(args[1]) == 23 or parseInt(args[1]) == 2861 or parseInt(args[1]) == 199 or parseInt(args[1]) == 124 or parseInt(args[1]) == 352 or parseInt(args[1]) == 651 then 
		--	if user_id ~= -1 and user_id ~= 5 then 
		--		return 
		--	end
		--end
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,400)
                TriggerEvent('fall:ExcecaoGod')
                TriggerEvent('fall:ExcecaoVida')
                SendWebhookMessage(webhookgod,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DEU GOD NO]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            vRPclient.killGod(source)
			vRPclient.setHealth(source,400)
            TriggerEvent('fall:ExcecaoGod')
            TriggerEvent('fall:ExcecaoVida')
			SendWebhookMessage(webhookgod,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DEU GOD EM SI MESMO]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD ALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('godall',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ceo.permissao") then
    	local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
            	vRPclient.killGod(id)
				vRPclient.setHealth(id,400)
				--print(id)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"mod.permissao") then
			local vehicle = vRPclient.getNearVehicle(source,7)
			if vehicle then
				vCLIENT.vehicleHash(source,vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nuser_id = tonumber(args[1])
    local nsource = vRP.getUserSource(nuser_id)

    if not args[1] then
        if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
            vCLIENT.vehicleTuning(source)
            TriggerClientEvent("Notify",source,"sucesso","Você tunou o <b>veículo</b> Tuning sucesso.")
        else
            TriggerClientEvent("Notify",source,'negado','Você não tem acesso a esse comando')
        end
    else
        if vRP.hasPermission(user_id,"suporte.permissao") then
            local vehicle = vRPclient.getNearestVehicle(nsource,7)
            if vehicle then
                vCLIENT.vehicleTuning2(nsource,vehicle)
                TriggerClientEvent("Notify",source,"sucesso","Você tunou o <b>veículo</b> Tuning2 sucesso.")
            end
        end
    end
end)
--RegisterCommand('tuning2',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--    local nuser_id = tonumber(args[1])
--    local nsource = vRP.getUserSource(nuser_id)
--	if vRP.hasPermission(user_id,"suporte.permissao") then
--        local vehicle = vRPclient.getNearestVehicle(nsource,7)
--        if vehicle then
--            vCLIENT.vehicleTuning2(nsource,vehicle)
--            TriggerClientEvent("Notify",source,"sucesso","Você tunou o <b>veículo</b> Tuning2 sucesso.")
--       end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAPUZADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('capuzadm', function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.setCapuz(nplayer)
                vRP.closeMenu(nplayer)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCAPUZADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rcapuzadm', function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.setCapuz(nplayer)
			end
		else
			vRPclient.setCapuz(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN RG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rg2',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mod.permissao") or  vRP.hasPermission(user_id,"suporte.permissao")  then
        local nuser_id = parseInt(args[1])
        local identity = vRP.getUserIdentity(nuser_id)
        local bankMoney = vRP.getBankMoney(nuser_id)
        local walletMoney = vRP.getMoney(nuser_id)
        local sets = json.decode(vRP.getUData(nuser_id,"vRP:datatable"))        
        if args[1] then
           TriggerClientEvent("Notify",source,"importante","ID: <b>"..parseInt(nuser_id).."</b><br>Nome: <b>"..identity.name.." "..identity.firstname.."</b><br>Idade: <b>"..identity.age.."</b><br>Telefone: <b>"..identity.phone.."</b><br>Carteira: <b>"..vRP.format(parseInt(walletMoney)).."</b><br>Banco: <b>"..vRP.format(parseInt(bankMoney)).."</b><br>Sets: <b>"..json.encode(sets.groups).."</b>",5000)    
        else
            TriggerClientEvent("Notify",source,'negado',"Digite o ID desejado!")

        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpararea',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        vCLIENT.syncArea(-1,x,y,z)
        TriggerClientEvent("Notify",source,"sucesso","Você limpou a área com sucesso.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('setreset',function(source,args,rawCommand)
--    local user_id = vRP.getUserId(source)
--    if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
--        if user_id then
--            if args[1] then
--                local identity = vRP.getUserIdentity(parseInt(args[1]))
--                if vRP.request(source,"Deseja resetar o Passaporte: <b>"..parseInt(args[1]).." "..identity["name"].." "..identity["firstname"].."</b> ?",30) then
--                    local id = vRP.getUserSource(parseInt(args[1]))
--
--                    if id ~= nil then  
--                        vRP.kick(id,"Você foi expulso da cidade.")
--                    end
--
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "currentCharacterMode" })
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "vRP:datatable" })
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "vRP:multas" })
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "vRP:prisao" })
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "vRP:spawnController" })
--                    vRP.execute("vRP/rem_user_dkey",{ user_id = parseInt(args[1]), dkey = "vRP:tattoos" })
--                    TriggerClientEvent("Notify",source,"sucesso",'CIRURGIA:',"Você resetou o Passaporte: <b>"..parseInt(args[1]).." "..identity["name"].." "..identity["firstname"].."</b>.")
--                end          
--            end
--        end
--    end
--end)
RegisterCommand('setreset',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if user_id then
            if args[1] then
                local identity = vRP.getUserIdentity(parseInt(args[1]))
                local id = vRP.getUserSource(parseInt(args[1]))
                vRP.setUData(parseInt(args[1]),"vRP:datatable",json.encode(vRP.getUserDataTable(parseInt(args[1]))))
                vRP.setUData(parseInt(args[1]),"vRP:spawnController",parseInt(0))
                vRP.setUData(parseInt(args[1]),"vRP:tattoos",json.encode(vRP.getUserDataTable(parseInt(args[1])))) 
                vRP.kick(id,"Você foi kickado para Resetar a Aparência !")
                TriggerClientEvent("Notify",source,"importante","Você resetou a Aparência de(a): <b>"..parseInt(args[1]).." "..identity.name.." "..identity.firstname.."</b>.")
            end
        end
    end
end)



-- 



-----------------------------------------------------------------------------------------------------------------------------------------
-- RENOMEAR PERSONAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rename',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		local idjogador = vRP.prompt(source, "Qual id do jogador?", "")
		local nome = vRP.prompt(source, "Novo nome", "")
		local firstname = vRP.prompt(source, "Novo sobrenome", "")
		local idade = vRP.prompt(source, "Nova idade", "")
		local identity = vRP.getUserIdentity(parseInt(idjogador))
		vRP.execute("vRP/update_user_identity",{
			user_id = idjogador,
			firstname = firstname,
			name = nome,
			age = idade,
			registration = identity.registration,
			phone = identity.phone
		})
	end
end)

RegisterCommand('setnum',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        local idjogador = vRP.prompt(source, "Qual id do jogador?", "")
        local phone = vRP.prompt(source, "Novo Telefone (6 Digitos Exemplo = 777-777)", "")
        local identity = vRP.getUserIdentity(parseInt(idjogador))
        vRP.execute("vRP/update_user_identity",{
            user_id = idjogador,
            firstname = identity.firstname,
            name = identity.name,
            age = identity.age,
            registration = identity.registration,
            phone = phone
        })
		TriggerEvent("identity:atualizar",idjogador)
        SendWebhookMessage(webhooknumero,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[TROCOU]: "..idjogador.." \n[O Numero]: "..phone.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
    end
end)

RegisterCommand('setplaca',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "ceo.permissao")  then
        local idjogador = vRP.prompt(source, "Qual id do jogador?", "")
        local rg = vRP.prompt(source, "Novo RG (8 Digitos)", "")
        local identity = vRP.getUserIdentity(parseInt(idjogador))
        vRP.execute("vRP/update_user_identity",{
            user_id = idjogador,
            firstname = identity.firstname,
            name = identity.name,
            age = identity.age,
            registration = rg,
            phone = identity.phone
        })
		TriggerEvent("identity:atualizar",idjogador)
        SendWebhookMessage(webhookplaca,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[TROCOU]: "..idjogador.." \n[A PLACA]: "..rg.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
		--TriggerEvent("identity:atualizar",nuser_id)
    end
end)

RegisterCommand('setplate',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"ceo.permissao") then
		local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
		if args[1] and string.lower(args[1]) == 'id' and args[2] then
			local nuser_id = parseInt(args[2])
			local nidentity = vRP.getUserIdentity(nuser_id)
			TriggerClientEvent('fall:AdminSetPlaca',-1, vehicle, nidentity.registration)
			TriggerClientEvent('Notify', source, 'sucesso', 'PLACA SETADA: <br>ID: '.. nidentity.name .. ' ' .. nidentity.firstname .. ' (' .. nuser_id..')<br>PLACA (RG): '..nidentity.registration)
		elseif args[1] and not args[2] then
			TriggerClientEvent('fall:AdminSetPlaca',-1, vehicle, args[1])
			TriggerClientEvent('Notify', source, 'sucesso', 'PLACA SETADA: '..args[1])
			TriggerEvent("identity:atualizar",nuser_id)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cvadm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if nplayer then
			vRPclient.putInNearestVehicleAsPassenger(nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rvadm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if nplayer then
			vRPclient.ejectVehicle(nplayer)
		end
	end
end)

RegisterCommand('revall', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'adm.permissao') then
		local users = vRP.getUsers()
		for k, v in pairs(users) do 
			local id = vRP.getUserSource(v)
			vRPclient._setHealth(id, 400)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wl',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"aprovador.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            vRP.setWhitelisted(parseInt(args[1]),true)
            TriggerClientEvent("Notify",source,"sucesso","Voce aprovou o passaporte <b>"..args[1].."</b> na whitelist.")
            SendWebhookMessage(webhookwl,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[APROVOU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"aprovadorwl.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Voce retirou o passaporte <b>"..args[1].."</b> da whitelist.")
			SendWebhookMessage(webhookunwl,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"Você foi expulso da cidade.")
				TriggerClientEvent("Notify",source,"sucesso","Voce kickou o passaporte <b>"..args[1].."</b> da cidade.")
				SendWebhookMessage(webhookkick,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)

RegisterCommand('kick2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,args[2])
				TriggerClientEvent("Notify",source,"sucesso","Voce kickou o passaporte <b>"..args[1].."</b> da cidade.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),true)
            vRP.kick(args[1],"Você foi expulso da cidade.")
			TriggerClientEvent("Notify",source,"sucesso","Voce baniu o passaporte <b>"..args[1].."</b> da cidade.")
			SendWebhookMessage(webhookban,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[BANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Voce desbaniu o passaporte <b>"..args[1].."</b> da cidade.")
			SendWebhookMessage(webhookunban,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DESBANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('money',function(source,args,rawCommand)
--	local user_id = vRP.getUserId(source)
--	local identity = vRP.getUserIdentity(user_id)
--	if vRP.hasPermission(user_id,"adm.permissao") then
--		if args[1] then
--			vRP.giveMoney(user_id,parseInt(args[1]))
--            TriggerClientEvent("Notify",source,"financeiro","sucesso","Você pegou quantidade de $: "..vRP.format(args[1]))
--			SendWebhookMessage(webhookmoney,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FEZ]: $"..vRP.format(parseInt(args[1])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
--		end
--	end
--end)
RegisterCommand('money',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	--if user_id == 1 or user_id == 0 or user_id == 2 then
	if vRP.hasPermission(user_id,"adm.permissao") then
		if args[1] then
			if string.sub(args[1], 1, 1) ~= "-" then
				vRP.giveMoney(user_id,parseInt(args[1]))
				SendWebhookMessage(webhookmoney,"```prolog\n[=========MONEY=========]\n[ID]: "..user_id.." \n[NOME]: "..identity.name.." "..identity.firstname.." \n[FEZ]: $"..vRP.format(parseInt(args[1])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				TriggerClientEvent('Notify', source, 'financeiro','Sucesso', 'Adicionado ' .. args[1] .. ' à sua conta.')
			else
				local dinheiro = string.sub(args[1],2)
				SendWebhookMessage(webhookmoney,"```prolog\n[=========UNMONEY=========]\n[ID]: "..user_id.." \n[NOME]: "..identity.name.." "..identity.firstname.." \n[REMOVEU]: $"..vRP.format(parseInt(args[1])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				vRP.tryFullPayment(user_id, parseInt(dinheiro))
				TriggerClientEvent('Notify', source, 'financeiro','Sucesso', 'Debitado ' .. args[1] .. ' de sua conta.')
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
function src.noclipActive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"streamer.permissao") then
			vRPclient.toggleNoclip(source)
            PerformHttpRequest(webhooknoclip, function(err, text, headers) end, 'POST', json.encode({username = botusername, content = "```prolog\n[ID]: "..user_id.." \n[USOU NOCLIP] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```"}), { ['Content-Type'] = 'application/json' })
			TriggerClientEvent('efeitinholgbt',source)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)

RegisterCommand('motor',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		TriggerClientEvent('fall:RepararMotor', source, parseInt(args[1]))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		local x,y,z = vRPclient.getPosition(source)
        vRP.prompt(source,"Cordenadas:",tD(x)..","..tD(y)..","..tD(z))
	end
end)

RegisterCommand('cds2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:","['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
	end
end)

RegisterCommand('cds3',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		local lugar = vRP.prompt(source,"Lugar:","")
		local heading = vRPclient.getUserHeading(source)
		if lugar == "" then
			return
		end
		vRP.prompt(source,"Lugar:","[1] = { ['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z)..", ['h'] = "..tD(heading).." }\n},")
	end
end)

RegisterCommand('cdsr',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") then
        local x,y,z = vRPclient.getPosition(source)
        local heading = vRPclient.getUserHeading(source)
        local Numeracao = math.random(150,250)
        local numeroCol = math.random(800,1200)
        local lugar = vRP.prompt(source,"Lugar:","")
        local nomecold = vRP.prompt(source,"Nome do Cooldown (Exemplo: AeroTrevor):","")
        local minimo = vRP.prompt(source,"Minimo de Policia:","")
        local maximo = vRP.prompt(source,"Maximo de Policia:","")
        if lugar == "" and nomecold == "" and minimo == "" and maximo == "" then
            return
        end
        vRP.prompt(source,"Coordenadas:"," ['"..lugar.."'] = { -- Nome do estabelecimento \n  ['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z)..", ['h'] = "..tD(heading)..", -- Posição  \n  ['TempoRoubo'] = "..Numeracao..", -- Tempo que demorará pra terminar o roubo \n  ['Recompensa'] = math.random("..math.random(100000,190000)..","..math.random(200000,290000).."), -- Recompensa de dinheiro sujo no roubo  \n  ['TipoCooldown'] = '"..nomecold.."', -- Cooldown, use a mesma palavra para ter o MESMO COOLDOWN \n  ['Cooldown'] = "..numeroCol..",  -- Cooldown pra realizar o roubo com O MESMO TIPO DE COOLDOWN  \n  ['ItemReq'] = 'notebook',  -- Item necessário pra iniciar o roubo, nil = não precisa de item \n  ['MinPoliciais'] = "..minimo..",  -- Mínimo de policiais em serviço pra iniciar o roubo  \n  ['MaxPoliciais'] = "..maximo..", \n  ['PermDosPm'] = 'policia.permissao', -- O que o sistema considerará policial \n  ['Prioridade'] = 'sul' \n},")
    end
end)


function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ local webhookchat = ""

RegisterCommand('aa',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "suporte.permissao"
		if vRP.hasPermission(user_id,permission) then
			local toguro = vRP.getUsersByPermission(permission)
			for l,w in pairs(toguro) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[STAFF CHAT] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{255, 255, 255}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT STAFF]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end) ]]

RegisterCommand('oo',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "Influenciador"
		if vRP.hasPermission(user_id,permission) then
			local toguro = vRP.getUsersByPermission(permission)
			for l,w in pairs(toguro) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[STAFF CHAT] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{255, 255, 255}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT STAFF]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT PM
----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cpd',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "policia.permissao"
		if vRP.hasPermission(user_id,permission) then
			local pd = vRP.getUsersByPermission(permission)
			for l,w in pairs(pd) do
				local police = vRP.getUserSource(parseInt(w))
				if police then
					async(function()
						TriggerClientEvent('chatMessage',police, '[PD CHAT] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{52, 174, 235}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						SendWebhookMessage(webhookchatpd,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT Police]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOQUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('estoque',function(source,args,rawCommand)
    
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") then
        if args[1] and args[2] then
            vRP.execute("creative/set_estoque",{ vehicle = args[1], quantidade = args[2] })
			TriggerClientEvent("Notify",source,"sucesso","Você colocou mais <b>"..args[2].."</b> no estoque, para o veículo <b>"..args[1].."</b>.") 
			SendWebhookMessage(webhookadmin,"```prolog\n[=========ESTOQUE=========] \n[ID]: "..user_id.." " .. "\n[ADICIONOU]: " .. args[2] .. " \n[VEICULO] " ..args[1]..  os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```") 
        end
    end
end)

vRP.prepare('vrp/get_datatable', 'SELECT * FROM vrp_user_data WHERE user_id = @user_id AND dkey = @dkey')
vRP.prepare('vrp/update_datatable', 'UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id AND dkey = @dkey')

function PegarDatatable(user_id)
    local pesquisa = vRP.query('vrp/get_datatable', {user_id = user_id, dkey = 'vRP:datatable'})
    return pesquisa
end

function AtualizarDatatable(user_id, tabela)
    vRP.execute('vrp/update_datatable', {user_id = user_id, dkey = 'vRP:datatable', dvalue = json.encode(tabela)})
end


RegisterCommand('group', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id, 'adm.permissao') or vRP.hasPermission(user_id,"suporte.permissao") or user_id == 0 then
        if args[1] then
            local opcao = args[1]
            
            if opcao == 'add' then

                if args[2] then

                    if args[3] then

                        local nuser_id = parseInt(args[2])
                        local nsource = vRP.getUserSource(nuser_id)
						local grupo = args[3]
						if string.upper(args[3]) == 'ceo' or string.upper(args[3]) == 'cmn' or string.upper(args[3]) == 'adm' or string.upper(args[3]) == 'mod' or string.upper(args[3]) == 'sup' or string.upper(args[3]) == 'Aprovador' or string.upper(args[3]) == 'Influencer' or string.upper(args[3]) == 'FlameElite' or string.upper(args[3]) == 'Flame' then
							if user_id ~= 0 and user_id ~= 1 and user_id ~= 2 then
								TriggerClientEvent('Notify', source, 'negado','Somente CEOS podem executar comando nesses grupos.')
								return
							end
						end

                        if nsource then
							vRP.addUserGroup(nuser_id,grupo)
							TriggerClientEvent('Notify', source, 'sucesso','ID <b>'.. nuser_id .. '</b> adicionado ao grupo <b>'..grupo..'</b>.')
							SendWebhookMessage(groupadd,"```prolog\n[=========ADD GROUP ONLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]: "..nuser_id.." \n[GRUPO]: "..grupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                        else
                            local pesquisa = PegarDatatable(nuser_id)
                            if pesquisa[1] and pesquisa[1] ~= nil then
                                local result = json.decode(pesquisa[1].dvalue)

                                if not result.groups[grupo] then

                                    result.groups[grupo] = true

                                    AtualizarDatatable(nuser_id, result)

									TriggerClientEvent('Notify', source, 'sucesso','ID <b>'.. nuser_id .. '</b> adicionado ao grupo <b>'..grupo..'</b>.')
									SendWebhookMessage(groupadd,"```prolog\n[=========ADD GROUP OFF=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]: "..nuser_id.." \n[GRUPO]: "..grupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

                                else
                                    TriggerClientEvent('Notify', source, 'negado','Esse jogador já possui esse grupo.')
                                end

                            end
                        end

                    else
                        TriggerClientEvent('Notify', source, 'negado','Especifique um GRUPO.')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado','Especifique um ID.')
                end

            elseif opcao == 'rem' then

                if args[2] then

                    if args[3] then

                        local nuser_id = parseInt(args[2])
                        local nsource = vRP.getUserSource(nuser_id)
                        local grupo = args[3]
						if string.upper(args[3]) == 'ELITE' or string.upper(args[3]) == 'VIP' or string.upper(args[3]) == 'TREINADOR' or string.upper(args[3]) == 'ADMIN' or string.upper(args[3]) == 'SUPORTE' or string.upper(args[3]) == 'MOD' or string.upper(args[3]) == 'BIGAS22' then
							if user_id ~= 0 and user_id ~= 1 and user_id ~= 2 and user_id ~= 22 then
								TriggerClientEvent('Notify', source, 'negado','Somente biluzera & bigode podem executar comando nesses grupos.')
								return
							end
						end

                        if nsource then
							vRP.removeUserGroup(nuser_id,grupo)
							TriggerClientEvent('Notify', source, 'sucesso','ID <b>'.. nuser_id .. '</b> removido do grupo <b>'..grupo..'</b>.')
							SendWebhookMessage(grouprem,"```prolog\n[=========REM GROUP ONLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..nuser_id.." \n[GRUPO]: "..grupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							SendWebhookMessage('',"```prolog\n[=========GRUPO REMOVIDO=========]\n[ADM]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ID PLAYER]: "..nuser_id.." \n[REMOVIDO]: "..grupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                        else
                            local pesquisa = PegarDatatable(nuser_id)

                            if pesquisa[1] and pesquisa[1] ~= nil then

                                local result = json.decode(pesquisa[1].dvalue)

                                if result.groups[grupo] then

                                    result.groups[grupo] = nil

                                    AtualizarDatatable(nuser_id, result)

									TriggerClientEvent('Notify', source, 'sucesso','ID <b>'.. nuser_id .. '</b> removido do grupo <b>'..grupo..'</b>.')
									SendWebhookMessage(grouprem,"```prolog\n[=========REM GROUP ONLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..nuser_id.." \n[GRUPO]: "..grupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
									SendWebhookMessage('',"```prolog\n[=========GRUPO REMOVIDO=========]\n[ADM]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ID PLAYER]: "..nuser_id.." \n[REMOVIDO]: "..grupo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

                                else
                                    TriggerClientEvent('Notify', source, 'negado','Esse jogador não possui esse grupo.')
                                end
                            end
                        end
                    else
                        TriggerClientEvent('Notify', source, 'negado','Especifique um GRUPO.')
                    end
                else
                    TriggerClientEvent('Notify', source, 'negado','Especifique um ID.')
                end

            elseif opcao == 'listar' then

                if args[2] then

                    local nuser_id = parseInt(args[2])

                    local pesquisa = PegarDatatable(nuser_id)

                    if pesquisa[1] and pesquisa[1] ~= nil then

                        local result = json.decode(pesquisa[1].dvalue)
                        local grupos = ''
                        if result.groups then
                            for k , v in pairs(result.groups) do
                                grupos = grupos .. ' - <b>' .. k .. '</b><br>'
                            end
                            TriggerClientEvent('Notify', source, 'aviso', 'LISTA DE SETS ID <b>'..nuser_id..'</b>', grupos)
                        end
                    end

                end

            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if parseInt(args[1]) == 0 or parseInt(args[1]) == 1 then 
			return 
			TriggerClientEvent('Notify', source, 'negado',"Você não pode puxar um CEO.") 
		end
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				TriggerClientEvent('fall:ExcecaoTp', tplayer)
				vRPclient.teleport(tplayer,x,y,z)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		--if parseInt(args[1]) == 0 or parseInt(args[1]) == 1 then return TriggerClientEvent('Notify', source, 'negado', "Você não pode se teleportar até um CEO.") end
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		vCLIENT.tptoWay(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"suporte.permissao") then
        local users = vRP.getUsers()
        local players = ""
        local quantidade = 0
        for k,v in pairs(users) do
            if k ~= #users then
                players = players.." "
            end
            players = players..k
            quantidade = quantidade + 1
        end
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{255,153,51},players)
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{255,153,51},quantidade)
    end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- ZERAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('zerarinv', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		if not args[1] then TriggerClientEvent('Notify', source, 'negado', 'Especifique um ID.') return end
		local nuser_id = parseInt(args[1])
		local nsource = vRP.getUserSource(nuser_id)
		if nsource then
			TriggerClientEvent('Flame:ZerarInv', nsource)
		else
			local data = vRP.getUData(nuser_id,'vRP:datatable') or {}
			data = json.decode(data) or {}

			data.weapons = {}
			data.inventory = {}

			vRP.setUData(nuser_id,'vRP:datatable',json.encode(data))
		end
		SendWebhookMessage(webhookadmin,"```prolog\n[ADMINISTRADOR]: "..user_id .. "\n[ZEROU INVENTARIO DE]: " .. nuser_id .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		SendWebhookMessage('https://discord.com/api/webhooks/882481690432376832/V0y1vL0eGv8KZb0dD_UwdP_3rFaZWwBRhFhUtJh1MN2kitT_TUYF_RZLzgsI2aG0G_nS',"```prolog\n[ADMINISTRADOR]: "..user_id .. "\n[ZEROU INVENTARIO DE]: " .. parseInt(args[1]) .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end)

RegisterCommand('zerararmas', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,'ceon') or vRP.hasGroup(user_id,'admn') or vRP.hasGroup(user_id,'dev') then
		if not args[1] then TriggerClientEvent('Notify', source, 'negado', 'Especifique um ID.') return end
		local nsource = vRP.getUserSource(parseInt(args[1]))
		TriggerClientEvent('fall:ZerarArmas', nsource)
		SendWebhookMessage(webhookadmin,"```prolog\n[ADMINISTRADOR]: "..user_id .. "\n[ZEROU INVENTARIO DE]: " .. parseInt(args[1]) .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setinv', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,'ceon') or vRP.hasGroup(user_id,'admn') or vRP.hasGroup(user_id,'dev') then
		if not args[1] then TriggerClientEvent('Notify', source, 'negado', 'Especifique um ID.') return end
		local nuser_id = parseInt(args[1])
		local valorInv = parseInt(args[2]) 
		vRP.setExp(nuser_id, "physical", "strength", valorInv)
		SendWebhookMessage(webhooksetinv,"```prolog\n[ADMINISTRADOR]: "..user_id .. "\n[SETOU INVENTARIO DE]: " .. nuser_id .. "\n[PARA]: " .. valorInv .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KILL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kill',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"adm.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer,0)
                TriggerClientEvent("Notify",source,"importante","Você matou o passaporte "..args[1])
                SendWebhookMessage(webhookkill,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DEU Kill NO ID:]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        else
            vRPclient.killGod(source)
            vRPclient.setHealth(source,0)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
--AddEventHandler("vRP:playerLeave",function(user_id,source)
--	local source = source
--	local user_id = vRP.getUserId(source)
--	if user_id then
--        if source ~= nil then 
--		    print('^1[ + ] start LOGOUT > ^7[ID]: '..vRP.format(user_id)..' [STEAM]: '..GetPlayerName(source)..' [IP]: '..GetPlayerEndpoint(source)..' [HORA]: '..os.date("%H:%M:%S"))
--        end
--        
--		local identity = vRP.getUserIdentity(user_id)
--
--		TriggerEvent("discordLogs","playerLeave","```\nPASSAPORTE: "..vRP.format(user_id).."\nHORÁRIO: "..os.date("%H:%M:%S").."\n```")
--	end
--end)
-------------------------------------------------------------------------------------------------------------------------------------------
---- PLAYERJOIN
-------------------------------------------------------------------------------------------------------------------------------------------
--AddEventHandler("vRP:playerJoin",function(user_id,source)
--	local source = source
--    if user_id then
--        if source ~= nil then 
--		    print('^2[ + ] start LOGIN > ^7[ID]: '..vRP.format(user_id)..' [STEAM]: '..GetPlayerName(source)..' [IP]: '..GetPlayerEndpoint(source)..' [HORA]: '..os.date("%H:%M:%S"))
--        end
--		local identity = vRP.getUserIdentity(user_id)
--		
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if user_id ~= nil then
        if source ~= nil then
            if vRP.hasGroup(user_id,"ceo") then
                TriggerClientEvent("Notify",source,"sucesso","Você foi autêntificado como <b>Ceo</b>.",5000)
            elseif vRP.hasGroup(user_id,"admin") then 
                TriggerClientEvent("Notify",source,"sucesso","Você foi autêntificado como <b>Admin</b>.",5000)
            elseif vRP.hasGroup(user_id,"mod") then 
                TriggerClientEvent("Notify",source,"sucesso","Você foi autêntificado como <b>Moderador</b>.",5000)
            elseif vRP.hasGroup(user_id,"suporte") then 
                TriggerClientEvent("Notify",source,"sucesso","Você foi autêntificado como <b>Suporte</b>.",5000)
			elseif vRP.hasGroup(user_id,"dev") then 
                TriggerClientEvent("Notify",source,"sucesso","Você foi autêntificado como <b>Developer</b>.",5000)
            end
        end
    end
end)
--[[ Foguinho ]]
RegisterCommand('foguinho', function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				TriggerClientEvent('foguinho', nplayer)
			end
		else
			TriggerClientEvent('foguinho', source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
	  	if vRP.hasPermission(user_id,"adm.permissao") then
			if args[1] then
			 	local nuser_id = vRP.getUserId(parseInt(args[1]))
			 	local nsource = vRP.getUserSource(parseInt(args[1]))
			 	if nsource then
			   	vRP.prompt(source,"Informations:","Steam Hex: "..GetPlayerIdentifier(parseInt(nsource),0))
			   	if GetPlayerIdentifier(parseInt(nsource),4) then
				 	TriggerClientEvent("Notify",source,'aviso',"<b>Usuário:</b> "..args[1].." <br><b>License:</b>"..GetPlayerIdentifier(parseInt(nsource),1).."<br><b>Discord Id:</b> "..GetPlayerIdentifier(parseInt(nsource),4).."<br><b>Steam Hex:</b> "..GetPlayerIdentifier(parseInt(nsource),0),8000)
			   	else
				 	TriggerClientEvent("Notify",source,'aviso',"<b>Usuário:</b> "..args[1].." <br><b>License:</b>"..GetPlayerIdentifier(parseInt(nsource),1).."<br><b>Steam Hex:</b> "..GetPlayerIdentifier(parseInt(nsource),0),8000)
			  	end
			 	else
			   		TriggerClientEvent("Notify",source,'negado',"Este jogador precisa estar online, para mais informações chame um desenvolvedor",8000)
			 	end
		  	end
	  	end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPEC
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand("spec",function(source,args,rawCmd)
--	local user_id = vRP.getUserId(source)
--	local identity = vRP.getUserIdentity(user_id)
--	if vRP.hasPermission(user_id,"adm.permissao") then
--		if args[1] then
--			local tplayer = vRP.getUserSource(parseInt(args[1]))
--			vCLIENT.specMode(source,tplayer)
--		end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TODOS CARROS DA BASE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('allcars',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") then
        local all = vRP.vehicleGlobal()
        local cars = ""
        for k,v in pairs(all) do
            cars = cars .. "," .. k
        end
        vRP.prompt(source,"Carros",cars)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD CASA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcasa',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") then
        if args[1] and args[2] then
            local nuser_id = parseInt(args[1])
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("homes/rem_allpermissions",{ home = tostring(args[2]) })
            vRP.execute("homes/buy_permissions",{ home = tostring(args[2]), user_id = nuser_id, tax = os.time() })
            TriggerClientEvent("Notify",source,"sucesso","Voce adicionou a casa <b>"..args[2].."</b> para o Passaporte: <b>"..parseInt(args[1]).."</b>.") 
            SendWebhookMessage(webhookaddcasa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ADICIONOU A CASA]: "..parseInt(args[2]).." \n[PARA O ID]: "..parseInt(nuser_id).." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM CASA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcasa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"adm.permissao") then
		if args[1] then
            local identity2 = vRP.getUserIdentity(parseInt(args[2]))
            if vRP.request(source,"Deseja remover a casa <b>"..args[1].."</b> do Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b> ?",30) then
                vRP.execute("creative/rem_srv_data",{ dkey = "chest:"..tostring(args[1]) })
                vRP.execute("creative/rem_srv_data",{ dkey = "outfit:"..tostring(args[1]) })
                vRP.execute("homes/rem_allpermissions",{ home = tostring(args[1]) })
    			TriggerClientEvent("Notify",source,"sucesso","Você removeu a casa <b>"..args[1].."</b> do Passaporte: <b>"..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.."</b>.")
                SendWebhookMessage(webhookremcasa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..tostring(args[1]).." \n[DO ID]: "..parseInt(args[2]).." "..identity2.name.." "..identity2.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DM (MENSAGEM PRIVADA)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dm',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id,"mod.permissao") then
        if args[1] == nil then
            TriggerClientEvent("Notify",source,'negado',"Necessário passar o ID após o comando, exemplo: <b>/dm 1</b>")
            return
        elseif nplayer == nil then
            TriggerClientEvent("Notify",source,'negado',"O jogador não está online!")
            return
        end
        local mensagem = vRP.prompt(source,"Digite a mensagem:","")
        if mensagem == "" then
            return
        end
        TriggerClientEvent("Notify",source,"sucesso","Mensagem enviada com sucesso!")
        TriggerClientEvent('chatMessage',nplayer,"MENSAGEM DA ADMINISTRAÇÃO:",{50,205,50},mensagem)
        TriggerClientEvent("Notify",nplayer,'aviso',"<b>Mensagem da Administração:</b> "..mensagem.."",30000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bigar',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("bigar",nplayer)
            end
        else
            TriggerClientEvent("bigar",source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESBIGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('desbigar',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("desbigar",nplayer)
            end
        else
            TriggerClientEvent("desbigar",source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_ADM COBRAR
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare('admcobraroffline', 'UPDATE vrp_user_moneys SET wallet = @wallet, bank = @bank WHERE user_id = @user_id')
vRP._prepare('admcobrargetinfo', 'SELECT * FROM vrp_user_moneys WHERE user_id = @user_id')
-----------------------------------------------------------------------------------------------------------------------------------------
---ADM COBRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('admcobrar', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        local nuser_id = parseInt(args[1])
        local nsource = vRP.getUserSource(nuser_id)
        local quantidade = tonumber(args[2])
        local identity = vRP.getUserIdentity(user_id)
        if nsource then
            vRP.tryFullPayment(nuser_id,quantidade)
            TriggerClientEvent("Notify",nsource,"financeiro","A Tropa tomou $"..vRP.format(quantidade).." de sua conta bancária.")
            TriggerClientEvent("Notify",source,'financeiro',"[ONLINE] A Tropa tomou $"..vRP.format(quantidade).." da conta bancária do ID " .. args[1])
            SendWebhookMessage(webhookcobraradm,"```prolog\n[=========COBRAR ADM ONLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU DO ID]: "..nuser_id.." \n[QUANTIDADE]: $"..quantidade.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        else
            local pesquisa = vRP.query('admcobrargetinfo', {user_id = nuser_id})
            local carteira, banco = parseInt(pesquisa[1].wallet), parseInt(pesquisa[1].bank)
            if carteira + banco >= quantidade then
                if carteira >= quantidade then
                    carteira = 0
                else
                    quantidade = quantidade - carteira
                    carteira = 0
                    banco = banco - quantidade
                end
                vRP.execute('admcobraroffline', {user_id = nuser_id, wallet = carteira, bank = banco})
                TriggerClientEvent("Notify",source,'financeiro',"[OFFLINE] A Tropa tomou $"..vRP.format(quantidade).." da conta bancária do ID " .. args[1])
                SendWebhookMessage(webhookcobraradm,"```prolog\n[=========COBRAR ADM OFFLINE=========]\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU DO ID]: "..nuser_id.." \n[QUANTIDADE]: $"..quantidade.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            else
                TriggerClientEvent('Notify', source, 'negado','O jogador não possui toda essa quantia.')
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemadm",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
	if nplayer then
		if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
			if args[1] and args[2] and args[3] and vRP.itemNameList(args[2]) ~= nil then
				vRP.giveInventoryItem(nuser_id,args[2],parseInt(args[3]))
                TriggerClientEvent("Notify",source,"sucesso","Voce spawnou o item "..args[2].." para o ID "..args[1].."")
                TriggerClientEvent("Notify",nplayer,"sucesso","Voce recebeu o item "..args[2].."")
				SendWebhookMessage(webhookitemplayer,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU]: "..args[2].." \n[QUANTIDADE]: "..vRP.format(parseInt(args[3])).." \n[PARA O ID]: "..vRP.format(parseInt(args[1]))..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		else
            TriggerClientEvent("Notify",source,"negado","Voce nao tem permissao para executar este comando")
        end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('console',function(source,args,rawCommand)
    if source == 0 then
        if args[1] then
            TriggerClientEvent('chatMessage',-1,"Fall CONSOLE | ",{200, 200, 200},rawCommand:sub(8))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("copypreset",function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,'adm.permissao') or vRP.hasPermission(user_id,'mod.permissao') or vRP.hasPermission(user_id,'suporte.permissao') then
        if user_id then       
            local data = vRP.getUserSource(tonumber(args[1]))
            local nsource = vRP.getUserId(data)
            local data2 = vRP.getUserIdentity(nsource)
            if data then
                local custom_outfit = vRPclient.getCustomPlayer(data)
                TriggerClientEvent("adminClothes",source,custom_outfit)
                TriggerClientEvent('Notify',source,'sucesso','Você copiou a roupa do <b>Passaporte '..vRP.format(parseInt(args[1]))..' '..data2.name..' '..data2.firstname..'</b>.') 
            end
        end
    end
end)

RegisterCommand('setpreset',function(source,args,rawCmd)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,'suporte.permissao') then
        return 
    end

    if not args[1] then return end

    local nsource = vRP.getUserSource(parseInt(args[1]))
    if nsource then
        local custom_outfit = vRPclient.getCustomPlayer(source)
        TriggerClientEvent('adminClothes',nsource,custom_outfit)
        TriggerClientEvent('Notify',source,'sucesso','Você setou seu outfit para o user_id '..vRP.format(parseInt(args[1]))) 
    end
end)

--RegisterCommand('clearpreset',function(source,args,rawCommand)
--    
--	local user_id = vRP.getUserId(source)
--	if vRP.hasPermission(user_id, 'adm.permissao') then
--		if args[1] then
--			local nuser_id = parseInt(args[1])
--			local nsource = vRP.getUserSource(nuser_id)
--			vRP.removeCloak(nsource)
--			TriggerClientEvent('Notify', source, 'sucesso', 'SUCESSO', 'Preset zerado do ID ' .. nuser_id)
--		end
--	end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCARRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcar', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local nsource = vRP.getUserSource(parseInt(args[1]))
			TriggerClientEvent('fall:SetarDentroDocarro',source, nsource)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPINCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcar2', function(source, args, rawCmd)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"suporte.permissao") then
		TriggerClientEvent('fall:SetarDentroDocarro2',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('marcar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		if args[1] then
			local nid = parseInt(args[1])
			local tplayer = vRP.getUserSource(nid)
			if tplayer then
				local x,y,z = vRPclient.getPosition(tplayer)
				TriggerClientEvent('fall:MarcarGps', source, x, y)
				vRPclient.playSound(source,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				TriggerClientEvent('chatMessage',source,"[ADMIN]",{255,0,0},"Você marcou a posição do ID " .. nid .. ".")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setinv', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasGroup(user_id,'ceon') or vRP.hasGroup(user_id,'admn') or vRP.hasGroup(user_id,'dev') then
		if not args[1] then TriggerClientEvent('Notify', source, 'negado', 'Especifique um ID.') return end
		local nuser_id = parseInt(args[1])
		local valorInv = parseInt(args[2]) 
		vRP.setExp(nuser_id, "physical", "strength", valorInv)
		SendWebhookMessage(webhooksetinv,"```prolog\n[ADMINISTRADOR]: "..user_id .. "\n[SETOU INVENTARIO DE]: " .. nuser_id .. "\n[PARA]: " .. valorInv .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVISTAR ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistaradm',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,'mod.permissao')  then
        return 
    end

    if not args[1] then return end

    local nsource = vRP.getUserSource(parseInt(args[1]))
    if nsource == nil then
        TriggerClientEvent('Notify',source,'negado','Usuário indisponível.')
        return 
    end


    local nuser = vRP.getUserId(nsource)

    local data = vRP.getUserDataTable(nuser)
    local weapons = vRPclient.getWeapons(nsource)

    local weaponStr = ''
    local inventoryStr = ''

    for k,v in pairs(weapons) do
        weaponStr = weaponStr..' <b>'..k..'</b> : '..vRP.format(v.ammo)..'<br>'
    end

    for k,v in pairs(data.inventory) do
        inventoryStr = inventoryStr..' <b>'..k..'</b> : '..v.amount..'<br>'
    end


    TriggerClientEvent('Notify',source,'sucesso','Informações de jogador ID: '..vRP.format(nuser)..'<br><br><b>Armas: </b><br><br>'..weaponStr..'<br><b>Inventário: </b><br><br>'..inventoryStr)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('item',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"mod.permissao") then
		--if args[1] and args[2] and itemlist[args[1]] ~= nil then

			--if string.lower(args[1]) == 'bandagem' and user_id ~= -1 then
			--	return
			--end

			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
			SendWebhookMessage(webhookitem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[PEGOU]: "..args[1].." \n[QUANTIDADE]: "..vRP.format(parseInt(args[2])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		--end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USER VEHS [ADMIN]
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('uservehs',function(source,args,rawCommand)
    
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"adm.permissao") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(nuser_id) })
                local car_names = {}
                for k,v in pairs(vehicle) do
                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>")
                    --TriggerClientEvent("Notify",source,"importante","<b>Modelo:</b> "..v.vehicle,10000)
                end
                car_names = table.concat(car_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Veículos de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..car_names,10000)
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SETFUEL
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setfuel',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"adm.permissao") then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                if parseInt(args[2]) == 0 then
                    TriggerClientEvent("admfuel2",nplayer,1.0)
                elseif parseInt(args[2]) then
                    TriggerClientEvent("admfuel2",nplayer,parseInt(args[2]))
                else
                    TriggerClientEvent("admfuel2",nplayer,100.0)
                end
            end
		end	
	end
end)


RegisterCommand('admexp', function(source, args, rawCmd)
    
	if source == 0 or vRP.hasPermission(vRP.getUserId(source), 'ceo.permissao') then
		local nid = parseInt(args[1])
		local nsource = vRP.getUserSource(nid)
		local x,y,z = vRPclient.getPosition(nsource) 
		vCLIENT.ExplodirPessoa(nsource, x,y,z)
	end
end)


vRP.prepare('startdebugdinsujo', 'SELECT * FROM vrp_srv_data')
vRP.prepare('startdebughousesbyid', 'SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id')
vRP.prepare('startdebughousesbyhouse', 'SELECT * FROM vrp_homes_permissions WHERE home = @home')
RegisterCommand('printdinheiros', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'dev.permissao') then
	local query = vRP.query('startdebugdinsujo', {})
	print('Localizando')
	for k, v in pairs (query) do
		local index, bau = v.dkey, json.decode(v.dvalue)
		if type(bau) ~= 'number' then
			for x,y in pairs(bau) do
                if string.match(x, 'wbody_WEAPON_ASSAULTRIFLE_MK2') then
                    print(index, vRP.itemNameList(x), vRP.format(y.amount))
               		end
				end
			end
		end
	end
	print('Pesquisa finalizada')
end)

RegisterCommand('casa', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'suporte.permissao') then
		if args[1] then
			if args[1] == 'ids' then -- PRINTA A PARTIR DO NOME DA CASA
				if args[2] then
					local query = vRP.query('startdebughousesbyhouse', {home = args[2]})
					local resultado = ''
					for k, v in pairs(query) do
						local status = 'DONO'
						if parseInt(v.owner) == 0 then 
							status = 'MORADOR'
						end
						local nuser_id = parseInt(v.user_id)
						local identity = vRP.getUserIdentity(nuser_id)
						resultado = resultado .. nuser_id .. ' ' .. identity.name .. ' ' .. identity.firstname .. ' [' .. status .. ']\n'
					end
					vRP.prompt(source, 'CASA ' .. args[2], resultado)
				end
			elseif args[1] == 'id' then -- PRINTA A PARTIR DO ID DO JOGADOR
				if args[2] then
					local nuser_id = parseInt(args[2])
					local identity = vRP.getUserIdentity(nuser_id)
					local query = vRP.query('startdebughousesbyid', {user_id = nuser_id})
					local resultado = ''
					for k, v in pairs(query) do
						local status = 'DONO'
						local garajado = 'SIM'
						if parseInt(v.owner) == 0 then 
							status = 'MORADOR'
						end
						if parseInt(v.garage) == 0 then 
							garajado = 'NÃO'
						end

						resultado = resultado .. v.home .. ' [' .. status .. '][GARAGEM: ' .. garajado .. ']\n'
					end
					vRP.prompt(source, 'INFO CASAS ' .. nuser_id .. ' ' .. identity.name .. ' ' .. identity.firstname, resultado)
				end
			end
		end
	end
end)

vRP.prepare('vrp/resetar_boneco', 'DELETE FROM vrp_user_data WHERE user_id = @user_id AND dkey = @dkey')
RegisterCommand('cirurgia', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if user_id == 0 or user_id == 1 then
		if args[1] then
			local nuser_id = parseInt(args[1])
			local nsource = vRP.getUserSource(nuser_id)
			vRP.execute('vrp/resetar_boneco', {user_id = nuser_id, dkey = 'vRP:spawnController'})
			TriggerClientEvent('Notify', source, 'sucesso', 'CIRURGIA:', 'Você resetou o personagem do <b>ID ' .. vRP.format(nuser_id) .. '</b>.')
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,args,rawCommand)
    if not exports["chat"]:statusChatServer(source) then return end
	local user_id = vRP.getUserId(source)
	if user_id then
	    	if args[1] then
                if vRPclient.getHealth(source) > 101 and not vCLIENT.getHandcuff(source) then
	    		TriggerClientEvent("vrp_showme:pressMe",-1,source,rawCommand:sub(4),{ 10,250,0,255,100 })
	    	end
	    end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET PROCURADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setproc', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'adm.permissao') then
		if args[1] then
			if args[2] then
				local nsource = vRP.getUserSource(parseInt(args[1])) 
				local proc = parseInt(args[2])
				if proc >= 0 then
					if nsource then
						vRPclient.AdminSetStandBY(nsource,proc)
						TriggerClientEvent('Notify', source, 'aviso','Você definiu o tempo de procurado do <b>ID ' .. parseInt(args[1]) .. '</b> para <b>' .. vRP.format(proc) .. 's</b>.')
					else
						TriggerClientEvent('Notify', source, 'negado','Esse jogador se encontra <b>indisponível</b>.')
					end

				else
					TriggerClientEvent('Notify', source, 'negado','Você não especificou um <b>TEMPO VÁLIDO ( 0 - X )</b>.')
				end
			else
				TriggerClientEvent('Notify', source, 'negado','Você não especificou um <b>TEMPO VÁLIDO ( 0 - X )</b>.')
			end
		else
			TriggerClientEvent('Notify', source, 'negado','Você não especificou um <b>PASSAPORTE VÁLIDO</b>.')
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- MODO ADM
-----------------------------------------------------------------------------------------------------------------------------------------
local players = {}
local sources = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRST SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('vRP:playerSpawn',function(user_id,source,first_spawn)
    local identity = vRP.getUserIdentity(user_id)
    local playerName = identity.name..' '..identity.firstname

    players[source] = { user_id = user_id, name = playerName }

    for k,v in pairs(sources) do
        vCLIENT.SyncPlayerlist(v,players)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER DROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped',function(user_id,source,first_spawn)
    if players[source] then
        players[source] = {}
        for k,v in pairs(sources) do
            vCLIENT.SyncPlayerlist(v,players)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
function serverSync()
    local users = vRP.getUsers()

    for k,v in pairs(users) do
        local identity = vRP.getUserIdentity(k)
        local playerName = identity.name..' '..identity.firstname
        
        players[v] = { user_id = k, name = playerName }
    end

    for k,v in pairs(sources) do
        vCLIENT.SyncPlayerlist(v,players)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('onResourceStart', function(resName)

    Wait(5000)

    -- Deixa o evento somente pra essa resource
    if (GetCurrentResourceName() ~= resName) then
      return
    end

    serverSync()
	print("^3[+] ^7Script reiniciado, iniciando sincronização de jogadores.")

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("add",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserIdentity(user_id)
	if user_id then
		if parseInt(args[2]) > 0 then
			if args[1] == "Policia" then
				if vRP.hasGroup(user_id,"policiaftu") then
					if vRP.request(source,"Deseja adicionar o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.addUserGroup(parseInt(args[2]),"paisanapolicia")
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
					end
				end
			end

			if args[1] == "Medico" then
				if vRP.hasGroup(user_id,"diretor") then
					if vRP.request(source,"Deseja adicionar o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.addUserGroup(parseInt(args[2]),"medico")
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
					end
				end
			end

			if args[1] == "Mecanico" then
				if vRP.hasGroup(user_id,"chefemec") then
					if vRP.request(source,"Deseja adicionar o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.addUserGroup(parseInt(args[2]),"mecanico")
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> adicionado com sucesso.",5000)
					end
				end
			end
			SendWebhookMessage(webhookset,"```prolog\n[ID]: "..user_id.." "..data.name.." "..data.firstname.." \n[SETOU]:"..parseInt(args[2]).." \n[GRUPO]: "..args[1].." \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rem",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserIdentity(user_id)
    local nsource = vRP.getUserSource(parseInt(args[2]))
	if user_id then
		if parseInt(args[2]) > 0 then
			if args[1] == "Policia" then
				if vRP.hasGroup(user_id,"policiaftu") then
					if vRP.request(source,"Deseja remover o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.removeUserGroup(parseInt(args[2]),"policia")
						vRP.removeUserGroup(parseInt(args[2]),"paisanapolicia")
						vRP.clearInventory(parseInt(args[2]))
						vRPclient.giveWeapons(nsource,{},true)
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> removido com sucesso.",5000)
					end
				end
			end

			if args[1] == "Medico" then
				if vRP.hasGroup(user_id,"diretor") then
					if vRP.request(source,"Deseja remover o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.removeUserGroup(parseInt(args[2]),"medico")
						vRP.removeUserGroup(parseInt(args[2]),"paisanamedico")
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> removido com sucesso.",5000)
					end
				end
			end

			if args[1] == "Mecanico" then
				if vRP.hasGroup(user_id,"chefemec") then
					if vRP.request(source,"Deseja remover o Passaporte: <b>"..vRP.format(parseInt(args[2])).."</b> ?",30) then
						vRP.removeUserGroup(parseInt(args[2]),"mecanico")
						vRP.removeUserGroup(parseInt(args[2]),"paisanamecanico")
						TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[2])).."</b> removido com sucesso.",5000)
					end
				end
			end
			SendWebhookMessage(webhookset,"```prolog\n[ID]: "..user_id.." "..data.name.." "..data.firstname.." \n[REMOVEU]:"..parseInt(args[2]).." \n[GRUPO]: "..args[1].." \nData e Hora : "..os.date("%d/%m/%Y %H:%M:%S").." \r```")
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COR FAROL
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vfarol',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		if not args[1] then return end
		local carro = vRPclient.getNearestVehicle(source,7)
		local cor = tonumber(args[1])
		TriggerClientEvent('fall:CorFarolCl', source, carro, cor)
	end
end)

RegisterServerEvent("fall:SyncCorFarol")
AddEventHandler("fall:SyncCorFarol",function(index, cor)
	TriggerClientEvent("fall:SyncCorFarolCl",-1,index, cor)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SOLTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('soltar',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"adm.permissao") then
		local nuser_id = parseInt(args[1])
		local player = vRP.getUserSource(nuser_id)
		if nuser_id then

			TriggerClientEvent('startprisioneiro',player,false)
			TriggerClientEvent('fall:VirarPrisioneiro',player,false)
			vRPclient.teleport(player,1847.91,2585.75,45.68)
			vRP.setUData(nuser_id,"vRP:prisao",json.encode(-1))
			TriggerClientEvent("Notify",player,"importante","Sua sentença terminou, esperamos não ve-lo novamente.")
			vRPclient.PrisionGod(player)			
			SendWebhookMessage(webhookadmin,"```prolog\n[=========SOLTAR=========] \n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SOLTOU]: "..nuser_id.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS DE PRISÃO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('setprisao',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		if args[1] then
			local nuser_id = parseInt(args[1])
			if args[2] then
				local tempoPrisao = parseInt(args[2])
				vRP.setUData(nuser_id,"vRP:prisao", json.encode(tempoPrisao) )
				TriggerClientEvent('Notify', source, 'importante','Prisão realizada com sucesso!<br>USER ID: <b>' .. nuser_id .. '</b><br>Tempo: <b>'..tempoPrisao..'</b>')
				SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." " .. "\n[SET PRISAO ID]: " .. nuser_id .. "\n[TEMPO]:"..tempoPrisao..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```") 
			else
				TriggerClientEvent('Notify', source, 'negado','Você deve especificar um tempo válido: /prisaoadm [ID] [TEMPO]')
			end
		else
			TriggerClientEvent('Notify', source, 'negado','Você deve utilizar o comando da seguinte forma: /prisaoadm [ID] [TEMPO]')
		end
	end
end)

RegisterCommand('addprisao',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		if args[1] then
			local nuser_id = parseInt(args[1])
			if args[2] then
				local value = vRP.getUData(nuser_id,"vRP:prisao")
				local valorPreso = json.decode(value) or 0
				local tempoPrisao = parseInt(args[2])
				vRP.setUData(nuser_id,"vRP:prisao", json.encode(tempoPrisao+parseInt(valorPreso)) )
				TriggerClientEvent('Notify', source, 'importante','Importante', 'Prisão realizada com sucesso!<br>USER ID: <b>' .. nuser_id .. '</b><br>Tempo: <b>'..parseInt(valorPreso) .. ' + ' .. tempoPrisao .. ' = ' .. tempoPrisao + parseInt(valorPreso) ..'</b>')
				SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." " .. "\n[ADD PRISAO ID]: " .. nuser_id .. "\n[TEMPO]:"..parseInt(valorPreso) .. ' + ' .. tempoPrisao .. ' = ' .. (tempoPrisao + parseInt(valorPreso)) ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```") 
			else
				TriggerClientEvent('Notify', source, 'negado','Você deve especificar um tempo válido: /addprisao [ID] [TEMPO]')
			end
		else
			TriggerClientEvent('Notify', source, 'negado','Você deve utilizar o comando da seguinte forma: /addprisao [ID] [TEMPO]')
		end
	end
end)

RegisterCommand('checkprisao',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		if args[1] then
			local nuser_id = parseInt(args[1])
			local value = vRP.getUData(nuser_id,"vRP:prisao")
			local valorPreso = json.decode(value) or 0
			TriggerClientEvent('Notify', source, 'importante','Tempo preso:<br>USER ID: <b>' .. nuser_id .. '</b><br>Tempo: <b>'..valorPreso..'</b>')
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." " .. "\n[CHECK PRISAO ID]: " .. nuser_id ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```") 
		else
			TriggerClientEvent('Notify', source, 'negado','Você deve utilizar o comando da seguinte forma: /prisaoadm [ID] [TEMPO]')
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PINTAR CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trypintarveh")
AddEventHandler("trypintarveh",function(index, tipo, valor)
	TriggerClientEvent("syncpintarveh",-1,index, tipo, valor)
end)
RegisterCommand('pintar',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		local tinta = 0
		if #args == 0 then
			TriggerClientEvent('chatMessage', source, "", {255,0,0}, "[ERRO] Utilize: /pintar [metalico - normal - perolado - fosco - metal - cromo] [nº cor]")
		elseif args[1] == "metalico" then
			tinta = 1
		elseif args[1] == "normal" then
			tinta = 0
		elseif args[1] == "perolado" then
			tinta = 2
		elseif args[1] == "fosco" then
			tinta = 3
		elseif args[1] == "metal" then
			tinta = 4
		elseif args[1] == "cromo" then
			tinta = 5
		end

		local carro = vRPclient.getNearestVehicle(source,7)
		if carro then
			TriggerClientEvent("pintarveiculo", source, carro, parseInt(tinta), parseInt(args[2]))
			SendWebhookMessage(webhookadmin,"```prolog\n[=========PINTAR=========] \n[ID]: "..user_id.. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```") 
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR COLOR -- Cor primaria e secundária são as mesmas
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("trycorveh")
AddEventHandler("trycorveh",function(index, cor1, cor2, cor3)
	TriggerClientEvent("synccorveh",-1,index, cor1, cor2, cor3)
end)
RegisterCommand('vcor',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		local fcoords = vRP.prompt(source,"Cor(r,g,b):","")
		if fcoords == "" then
			return
		end
		local cores = {}
		for cor in string.gmatch(fcoords or "255,255,255","[^,]+") do
			table.insert(cores,parseInt(cor))
		end
		local carro = vRPclient.getNearestVehicle(source,7)
		if carro then
			TriggerClientEvent("carroCor", source, carro, cores[1], cores[2], cores[3])
		end
	end
end)


RegisterCommand('vercustom',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'adm.permissao') or user_id == 0 or user_id == 1 then
		TriggerClientEvent('fall:VerCustom:MostrarCl', source)
	end
end)

RegisterServerEvent('fall:VerCustom:Mostrar')
AddEventHandler('fall:VerCustom:Mostrar', function(custom)
	local content = ""
	for k,v in pairs(custom) do
		if string.match(k, 'p') then
			content = content.. '["' .. k .. '"] = {' .. v[1] .. ', ' .. v[2] .. '}, \n' 
		else
			content = content.. '[' .. k .. '] = {' .. v[1] .. ', ' .. v[2] .. '}, \n' 
		end
	end
	vRP.prompt(source, "Customização", content)
end)

RegisterCommand('printpreset',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if not args[1] then
		local custom = vRPclient.getCustomization(source)
		local content = ""
		for k,v in pairs(custom) do
			if k == 1 then
				content = content .. 'mascara ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 3 then
				content = content .. 'maos ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 4 then
				content = content .. 'calca ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 5 then
				content = content .. 'mochila ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 6 then
				content = content .. 'sapatos ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 7 then
				content = content .. 'acessorios ' .. v[1] .. '; '
			elseif k == 8 then
				content = content .. 'blusa ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 9 then
				content = content .. 'colete ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 11 then
				content = content .. 'jaqueta ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 'p0' then
				content = content .. 'chapeu ' .. v[1] .. ' ' .. v[2] .. '; '
			elseif k == 'p1' then
				content = content .. 'oculos ' .. v[1] .. ' ' .. v[2] .. '; '
			end
		end
		vRP.prompt(source, 'Roupas prontas:', content)
	elseif args[1] then
		if vRP.hasPermission(user_id, 'adm.permissao') then
			local nuser_id = parseInt(args[1])
			local nsource = vRP.getUserSource(nuser_id)
			if not nsource then TriggerClientEvent('Notify', source, 'negado','Esse ID não está online.') return end
			local custom = vRPclient.getCustomization(nsource)
			local content = ""
			for k,v in pairs(custom) do
				if k == 1 then
					content = content .. 'mascara ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 3 then
					content = content .. 'maos ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 4 then
					content = content .. 'calca ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 5 then
					content = content .. 'mochila ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 6 then
					content = content .. 'sapatos ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 7 then
					content = content .. 'acessorios ' .. v[1] .. '; '
				elseif k == 8 then
					content = content .. 'blusa ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 9 then
					content = content .. 'colete ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 11 then
					content = content .. 'jaqueta ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 'p0' then
					content = content .. 'chapeu ' .. v[1] .. ' ' .. v[2] .. '; '
				elseif k == 'p1' then
					content = content .. 'oculos ' .. v[1] .. ' ' .. v[2] .. '; '
				end
			end
			vRP.prompt(source, 'Roupas prontas:', content)
		end
	end
end)

RegisterCommand('respawnar', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'adm.permissao') then
		if args[1] then
			local nsource = vRP.getUserSource(parseInt(args[1]))
			TriggerEvent('fall:SyncDebugPlayer', nsource)
			TriggerClientEvent('Notify', source, 'aviso','ID ' .. parseInt(args[1]) .. ' respawnado.')
			TriggerClientEvent('Notify', nsource, 'aviso','Você foi respawnado.')
		end
	end
end)

RegisterServerEvent('fall:SyncDebugPlayer')
AddEventHandler('fall:SyncDebugPlayer', function(debugid)
	local source = debugid
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	vRPclient._setFriendlyFire(source,true)

	if data.customization == nil then
		data.customization = cfg.default_customization
	end

	if data.position then
		vRPclient.teleport(source,data.position.x,data.position.y,data.position.z)
	end

	if data.customization then
		vRPclient.setCustomization(source,data.customization) 
		if data.weapons then
			vRPclient.giveWeapons(source,data.weapons,true)

			if data.health then
				vRPclient.setHealth(source,data.health)
				SetTimeout(5000,function()
					if vRPclient.isInComa(source) then
						vRPclient.killComa(source)
					end
				end)
			end
		end
	end

	if data.weapons then
		vRPclient.giveWeapons(source,data.weapons,true)
	end

	if data.health then
		vRPclient.setHealth(source,data.health)
	end
end)

RegisterCommand('multar',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"suporte.permissao") then
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
		SendWebhookMessage(webhookmultasadm,"```prolog\n[ADMINISTRADOR]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============MULTOU==============] \n[PASSAPORTE]: "..id.." "..identity.name.." "..identity.firstname.." \n[VALOR]: $"..vRP.format(parseInt(valor)).." \n[MOTIVO]: "..motivo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

		TriggerClientEvent("Notify",source,"sucesso","Multa aplicada com sucesso.")
	--	TriggerClientEvent("Notify",nplayer,"importante","Você foi multado em <b>$"..vRP.format(parseInt(valor)).." dólares</b>.<br><b>Motivo:</b> "..motivo..".")
		TriggerClientEvent('smartphone:createSMS', nplayer, '0811', 'Você recebeu uma multa no valor de $'..vRP.format(parseInt(valor))..' dólares. | Motivo: '..motivo..'.')
		vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- OBITO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('obitoadm',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.SetSegundosMorto(nplayer, 10) 
                TriggerClientEvent('Notify',source,'sucesso','Obito concluido com sucesso')
				SendWebhookMessage(webhookobitoadm,"```prolog\n[ID]: "..user_id.." \n[DEU OBITO] \n[PASSAPORTE]: "..nplayer.."  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            end
        end
    end
end)

RegisterCommand('obitopm',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"policiaacao.permissao") then
        local nplayer = vRP.getUserSource(user_id)
        if nplayer then
            vRPclient.SetSegundosMorto(nplayer, 60) 
			TriggerClientEvent('Notify',source,'sucesso','Obito Policial concluido com sucesso')
			SendWebhookMessage(webhookobitoadm,"```prolog\n[ID]: "..user_id.." \n[DEU OBITO] \n[PASSAPORTE]: "..nplayer.."  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- arma
------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand('a',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if args[1] == "taser" and vRP.hasPermission(user_id,"mod.permissao") then
            vRPclient.giveWeapons(source,{["WEAPON_STUNGUN"] = { ammo = 0 }})
        elseif args[1] == "arminha" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_raypistol"] = { ammo = 1 }})
		elseif args[1] == "ak" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_assaultrifle_mk2"] = { ammo = 250 }})
        elseif args[1] == "tec" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_machinepistol"] = { ammo = 250 }})
		elseif args[1] == "g3" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_specialcarbine_mk2"] = { ammo = 250 }})
        elseif args[1] == "m4" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_carbinerifle"] = { ammo = 250 }})
        elseif args[1] == "mpx" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_carbinerifle_mk2"] = { ammo = 250 }})
		elseif args[1] == "sig" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_combatpdw"] = { ammo = 250 }})
		elseif args[1] == "glock" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_combatpistol"] = { ammo = 250 }})
		elseif args[1] == "da" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_doubleaction"] = { ammo = 250 }})
		elseif args[1] == "gas" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_petrolcan"] = { ammo = 4500 }})
		elseif args[1] == "rpg" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_rpg"] = { ammo = 25 }})
        elseif args[1] == "paraquedas" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["gadget_parachute"] = { ammo = 1 }})
		elseif args[1] == "tg" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_hominglauncher"] = { ammo = 10 }})
		elseif args[1] == "uzi" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_microsmg"] = { ammo = 250 }})
		elseif args[1] == "ap" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_appistol"] = { ammo = 250 }})
		elseif args[1] == "five" and vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"streamer.permissao") then
			vRPclient.giveWeapons(source,{["weapon_pistol_mk2"] = { ammo = 250 }})
        elseif args[1] == "smg" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_smg_mk2"] = { ammo = 250 }})
        elseif args[1] == "sniper" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_heavysniper_mk2"] = { ammo = 250 }})
		elseif args[1] == "fogos" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_firework"] = { ammo = 25 }})
		elseif args[1] == "luz" and vRP.hasPermission(user_id,"ceo.permissao") then
			vRPclient.giveWeapons(source,{["weapon_flashlight"] = { ammo = 250 }})
        elseif args[1] == "colete" and vRP.hasPermission(user_id,"ceo.permissao") then
            vRPclient.setArmour(source,100)
        elseif args[1] == "limpar" and vRP.hasPermission(user_id,"ceo.permissao") then
            vRPclient.giveWeapons(source,{},true)
        elseif vRP.hasPermission(user_id,"ceo.permissao") then
            TriggerClientEvent("Notify",source,"negado","Arma não encontrado.")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBITOSTREAMER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('obito2',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"influencer.permissao")  then
        if vRPclient.isInComa(source) then
            TriggerClientEvent('vrp:setObito2')
            TriggerClientEvent('Notify',source,'sucesso','Obito concluido com sucesso')
			SendWebhookMessage(webhookobito2,"```prolog\n[ID]: "..user_id.." \n[SE DEU OBITO]  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    else
        TriggerClientEvent('Notify',source,'negado','Você não tem permissão para executar este comando')
    end
end)


RegisterCommand('kickall',function(source,args,rawCommand)
	if source == 0 then
		local users = vRP.getUsers()
		for k,v in pairs(users) do
			local id = vRP.getUserSource(parseInt(k))
			if id then
				vRP.kick(id,"Você foi desconectado, um RR aconteceu na cidade.")
			end
			Citizen.Wait(10)
			print("^1[Flame] ^7Todos os jogadores foram Kickados.")
		end
	end
end)

RegisterCommand('avisar',function(source,args,rawCommand)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"adm.permissao") then
		local titulo = vRP.prompt(source, 'Título', 'AVISO ADMIN')
		if titulo == nil then return end

		local mensagem = vRP.prompt(source, 'Mensagem', '')
		if mensagem == nil then return end

		local tempo = vRP.prompt(source, 'Tempo (segundos)', '5')
		if tempo == nil then return else tempo = tonumber(tempo) end

		TriggerClientEvent('fall:AdmAviso', -1, titulo, mensagem, tempo)
		
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- OBITOSTREAMER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('obitop',function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policiaacao.permissao")  then
        if vRPclient.isInComa(source) then
            TriggerClientEvent('vrp:setObito2')
            TriggerClientEvent('Notify',source,'sucesso','Obito concluido com sucesso')
			SendWebhookMessage(webhookobito2,"```prolog\n[ID]: "..user_id.." \n[SE DEU OBITO]  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    else
        TriggerClientEvent('Notify',source,'negado','Você não tem permissão para executar este comando')
    end
end)

RegisterCommand('troll', function(source, args, rawCmd)
    
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'dev.permissao') then
		if args[1] and args[2] then
			local nuser_id = parseInt(args[2])
			local nsource = vRP.getUserSource(nuser_id)
			if nsource then
				local status = 'DESLIGADO'
				if args[1] == 'wasd' then
					local wasd = vCLIENT.CheckWasd(nsource)
					if wasd then status = 'LIGADO' end
					TriggerClientEvent('Notify', source, 'aviso','Troll <b>WASD</b> no ID <b>'..nuser_id..'</b> foi <b>' .. status .. '</b>' )
				elseif args[1] == 'drift' then
					local drift = vCLIENT.CheckDrift(nsource)
					if drift then status = 'LIGADO' end
					TriggerClientEvent('Notify', source, 'aviso','Troll <b>DRIFT</b> no ID <b>'..nuser_id..'</b> foi <b>' .. status .. '</b>' )
				else
					TriggerClientEvent('Notify', source, 'aviso','Opções disponíveis: wasd e drift')
				end
			else
				TriggerClientEvent('Notify', source, 'aviso','O jogador especificado não está disponível.')
			end
		end
	end
end)

--------------------------------------------------------------------
-- Venda Bandagem --------------------------------------------------
--------------------------------------------------------------------

local VendaBandagens2 = {}
local delayVMochila = {}
local QtdMaxVendaBandagem2 = 40
local ResetVendasBandagens2 = os.time()

function src.FishComprar()
    local PrecoDaBandagem = 5000

    if os.time() > (ResetVendasBandagens2 + 84600) then
        VendaBandagens2 = {}
    end

    local user_id = vRP.getUserId(source)
    local qtd = vRP.prompt(source, "Quantas Unidades Deseja Comprar:", "")
    if not delayVMochila[user_id] or os.time() > (delayVMochila[user_id] + 1) then
        delayVMochila[user_id] = os.time()
        if user_id then
            if not VendaBandagens2[user_id] then
                VendaBandagens2[user_id] = 0
            end
            if VendaBandagens2[user_id] >= QtdMaxVendaBandagem2 then
                TriggerClientEvent("Notify",source,"negado","HOSPITAL","A pessoa atingiu o limite de bandagens diárias.")
                return
            end
            if VendaBandagens2[user_id] + qtd <= QtdMaxVendaBandagem2 then
                local paramedicos = vRP.getUsersByPermission("medico.permissao")
                if parseInt(#paramedicos) <= 0 then
                    if vRP.tryFullPayment(user_id, qtd * PrecoDaBandagem) then
                        VendaBandagens2[user_id] = VendaBandagens2[user_id] + qtd
                        TriggerClientEvent("cancelando", source, true)
                        vRP.giveInventoryItem(user_id, "bandagem", qtd)
                        TriggerClientEvent("cancelando", source, false)
                        TriggerClientEvent("Notify",source,"sucesso","Você comprou "..qtd.."x bandagens por $"..PrecoDaBandagem)
                        print(VendaBandagens2[user_id])
                    else
                        TriggerClientEvent("Notify", source,"aviso", "HOSPITAL", "Existem paramédicos em serviço no momento.")
                    end
                end
            end
        end
    end
end



