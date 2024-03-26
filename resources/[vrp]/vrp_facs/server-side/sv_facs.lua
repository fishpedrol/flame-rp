local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-- CONNECTION
local src = {}
Tunnel.bindInterface("vrp_facs",src)
vCLIENT = Tunnel.getInterface("vrp_facs")

--[[ function vCLIENT.ballas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,'ballas.permissao')
	end
end

function vCLIENT.vagos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,'vagos.permissao')
	end
end

function vCLIENT.groove()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,'families.permissao')
	end
end ]]


-- CHAT FAC

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchat = ""

RegisterCommand('aa',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "suporte.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[CHAT ADMIN] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{4, 0, 255}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						--SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT ADMIN]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT CRIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchat = ""

RegisterCommand('ccrips',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "crips.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[CHAT CRIPS] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{4, 0, 255}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						--SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT CRIPS]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT BLOODS
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchat = ""

RegisterCommand('cbloods',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "blood.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[CHAT BLOODS] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{255, 0, 0}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						--SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT CRIPS]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT GROOVE
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchat = ""

RegisterCommand('cgroove',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "families.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[CHAT GROOVE] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{0, 255, 51}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						--SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT CRIPS]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT VAGOS
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchat = ""

RegisterCommand('cvagos',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "vagos.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[CHAT VAGOS] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{255, 230, 0}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						--SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT CRIPS]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT BALLAS
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchat = ""

RegisterCommand('cninethree',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "NineThree.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[CHAT BALLAS] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{110, 0, 88}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						--SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT CRIPS]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT SICILIANA
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchat = ""

RegisterCommand('csici',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "siciliana.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[CHAT SICILIANA] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{255, 255, 255}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						--SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT CRIPS]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT BRATVA
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchat = ""

RegisterCommand('cbratva',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "bratva.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[CHAT BRATVA] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{0, 0, 0}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						--SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT CRIPS]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT BAHAMAS
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchat = ""

RegisterCommand('cbahamas',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "bahamas.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[CHAT BAHAMAS] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{255, 43, 220}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						--SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT CRIPS]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT LIFEINVADER
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookchat = ""

RegisterCommand('clife',function(source,args,rawCommand)
    
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "lifeinvader.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player, '[CHAT LIFEINVADER] ' .. identity.name.." "..identity.firstname.." ("..identity.user_id..")",{255, 102, 0}, string.sub(rawCommand, 4))
						local Mensagem = args[1]
						if Mensagem == nil then Mensagem = 0 end
						--SendWebhookMessage(webhookchat,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." ("..identity.user_id..") \n[CHAT CRIPS]: "..Mensagem..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				end
			end
		end
	end
end)

RegisterCommand('faccao', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local crips = vRP.getUsersByPermission("crips.permissao")
    local crips2 = 0
    local crips_nomes = ""


    if vRP.hasPermission(user_id,"crips.permissao") then
        for k,v in ipairs(crips) do
            local identity = vRP.getUserIdentity(parseInt(v))
            crips_nomes = crips_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            crips2 = crips2 + 1
        end
        TriggerClientEvent("Notify",source,"importante","Atualmente <b>"..crips2.." Crips</b> em serviço.")
        if parseInt(crips2) > 0 then
        TriggerClientEvent("Notify",source,"importante", crips_nomes)
        end
    end

--[[
	 Faccao BLOODS 

           ]]

	local bloods = vRP.getUsersByPermission("bloods.permissao")
    local bloods2 = 0
    local bloods_nomes = ""


    if vRP.hasPermission(user_id,"bloods.permissao") then
        for k,v in ipairs(bloods) do
            local identity = vRP.getUserIdentity(parseInt(v))
            bloods_nomes = bloods_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            bloods2 = bloods2 + 1
        end

        TriggerClientEvent("Notify",source,"importante","Atualmente <b>"..bloods2.." Bloods</b> em serviço.")
        if parseInt(bloods2) > 0 then
        TriggerClientEvent("Notify",source,"importante", bloods_nomes)
        end
    end

--[[
	 Faccao BALLAS 

           ]]

	local ballas = vRP.getUsersByPermission("ballas.permissao")
    local ballas2 = 0
    local ballas_nomes = ""


    if vRP.hasPermission(user_id,"ballas.permissao") then
        for k,v in ipairs(ballas) do
            local identity = vRP.getUserIdentity(parseInt(v))
            ballas_nomes = ballas_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
            ballas2 = ballas2 + 1
        end

        TriggerClientEvent("Notify",source,"importante","Atualmente <b>"..ballas2.." Ballas</b> em serviço.")
        if parseInt(ballas2) > 0 then
            TriggerClientEvent("Notify",source,"importante", ballas_nomes)
        end
    end

--[[
	 Faccao VAGOS 

           ]]

		   local vagos = vRP.getUsersByPermission("vagos.permissao")

		   local vagos2 = 0
	   
		   local vagos_nomes = ""
	   
		   if vRP.hasPermission(user_id,"vagos.permissao") then
	   
			   for k,v in ipairs(ballas) do
	   
				   local identity = vRP.getUserIdentity(parseInt(v))
	   
				   vagos_nomes = vagos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
	   
				   vagos2 = vagos2 + 1
	   
			   end
	   
			   TriggerClientEvent("Notify",source,"importante","Atualmente <b>"..vagos2.." Vagos</b> em serviço.")
	   
			   if parseInt(vagos2) > 0 then
	   
				   TriggerClientEvent("Notify",source,"importante", vagos_nomes)
	   
			   end
	   
		   end
--[[
	 Faccao GROOVE 

           ]]

local groove = vRP.getUsersByPermission("groove.permissao")
local luqueta = 0
local nome_dosgago = ""
	   
		if vRP.hasPermission(user_id,"groove.permissao") then
			for k,v in ipairs(groove) do
			local identity = vRP.getUserIdentity(parseInt(v))
			nome_dosgago = nome_dosgago .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			luqueta = luqueta + 1
		end
	   
		TriggerClientEvent("Notify",source,"importante","Atualmente <b>"..luqueta.." Ballas</b> em serviço.")
		if parseInt(luqueta) > 0 then
	    TriggerClientEvent("Notify",source,"importante", nome_dosgago)
	   end
 end	

--[[
	 Faccao TRIADE 

           ]]

local triade = vRP.getUsersByPermission("triade.permissao")
local triade2 = 0
local nome_triade = ""
	   
if vRP.hasPermission(user_id,"triade.permissao") then
	   
		for k,v in ipairs(triade) do
	   
		local identity = vRP.getUserIdentity(parseInt(v))
	   
		 nome_triade = nome_triade .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
	   
		 triade2 = triade2 + 1
	   
		end
	   
			TriggerClientEvent("Notify",source,"importante","Atualmente <b>"..triade2.." Ballas</b> em serviço.")
			if parseInt(triade2) > 0 then
			TriggerClientEvent("Notify",source,"importante", nome_triade)
		 end
	   
 end

	
--[[
	 Faccao SICI 

           ]]

local sici = vRP.getUsersByPermission("sici.permissao")
local sici2 = 0
local nome_sici = ""
		
	if vRP.hasPermission(user_id,"sici.permissao") then
			for k,v in ipairs(sici) do
			local identity = vRP.getUserIdentity(parseInt(v))
			nome_sici = nome_sici .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			sici2 = sici2 + 1
		end
		
			TriggerClientEvent("Notify",source,"importante","Atualmente <b>"..sici2.." Ballas</b> em serviço.")
			if parseInt(sici2) > 0 then
		    TriggerClientEvent("Notify",source,"importante", nome_sici)
		end
	end
end)


