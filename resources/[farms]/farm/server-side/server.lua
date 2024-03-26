-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
emP = {}
Tunnel.bindInterface("fsh_farm",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO 
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"lifeinvader.permissao") or vRP.hasPermission(user_id,"bahamas.permissao") or vRP.hasPermission(user_id,"cartel.permissao") or vRP.hasPermission(user_id,"mecanico.permissao") or vRP.hasPermission(user_id,"blood.permissao") or vRP.hasPermission(user_id,"yardie.permissao") or vRP.hasPermission(user_id,"crips.permissao") or vRP.hasPermission(user_id,"russkaya.permissao") or vRP.hasPermission(user_id,"italiana.permissao")  or vRP.hasPermission(user_id, "ninethree.permissao") or vRP.hasPermission(user_id, "legitz.permissao") or vRP.hasPermission(user_id, "driftking.permissao") or vRP.hasPermission(user_id, "native.permissao") then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem acesso.")
			return false
		end						
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROGA----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"lavagem.permissao") then
			local itens = math.random(100)
			local quantidade = math.random(11,13)
			if itens <= 100 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("alvejante")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(11,13)
					vRP.giveInventoryItem( user_id,"alvejante",quantidade)
					if parseInt(math.random(1000)) < 30 then
						local weaponsort = math.random(1,4)
						if parseInt(weaponsort) == 1 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",2)
						elseif parseInt(weaponsort) == 2 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",1)
						elseif parseInt(weaponsort) == 3 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",3)
						elseif parseInt(weaponsort) == 4 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",4)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end	

		elseif vRP.hasPermission(user_id,"lavagem.permissao") then
			local itens = math.random(100)
			local quantidade = math.random(11,13)
			if itens <= 100 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("alvejante")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(11,13)
					vRP.giveInventoryItem( user_id,"alvejante",quantidade)
					if parseInt(math.random(1000)) < 30 then
						local weaponsort = math.random(1,4)
						if parseInt(weaponsort) == 1 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",2)
						elseif parseInt(weaponsort) == 2 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",1)
						elseif parseInt(weaponsort) == 3 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",3)
						elseif parseInt(weaponsort) == 4 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",4)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end		

--[[ 		elseif vRP.hasPermission(user_id,"mecanico.permissao") then
			local itens = math.random(100)
			local quantidade = math.random(3,5)
			if itens <= 100 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("militec")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(2,5)
					vRP.giveInventoryItem( user_id,"militec",quantidade)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end	

		elseif vRP.hasPermission(user_id,"legitz.permissao") then
			local itens = math.random(100)
			local quantidade = math.random(11,13)
			if itens <= 100 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("alvejante")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(6,8)
					vRP.giveInventoryItem( user_id,"alvejante",quantidade)
					if parseInt(math.random(1000)) < 30 then
						local weaponsort = math.random(1,4)
						if parseInt(weaponsort) == 1 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",2)
						elseif parseInt(weaponsort) == 2 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",1)
						elseif parseInt(weaponsort) == 3 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",3)
						elseif parseInt(weaponsort) == 4 then
							vRP.giveInventoryItem(user_id,"alvejantemodificado",4)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end ]]		

          -----------------------------------------------------------------------------------------------------------------------------------------
          --ARMA----------------------------------------------------------------------------------------------------------------------------------
		  -----------------------------------------------------------------------------------------------------------------------------------------
		
		elseif vRP.hasPermission(user_id,"crips.permissao") then
			local itens = math.random(60)
			local quantidade = math.random(5,6)
			local pagamento = math.random(1000,1600)
			if itens <= 500 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("armacaodearma")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(5,6)
					vRP.giveInventoryItem( user_id,"armacaodearma",quantidade)
					vRP.giveInventoryItem( user_id,"dinheirosujo",pagamento)
					if parseInt(math.random(1000)) < 5 then
						local weaponsort = math.random(1,4)
						if parseInt(weaponsort) == 1 then
							vRP.giveInventoryItem(user_id,"armacaodeak",1)
						elseif parseInt(weaponsort) == 2 then
							vRP.giveInventoryItem(user_id,"armacaodemp5",1)
						elseif parseInt(weaponsort) == 3 then
							vRP.giveInventoryItem(user_id,"armacaodeg3",1)
						elseif parseInt(weaponsort) == 4 then
							vRP.giveInventoryItem(user_id,"armacaodetec",1)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end	
		elseif vRP.hasPermission(user_id,"blood.permissao") then
			local itens = math.random(60)
			local quantidade = math.random(5,6)
			local pagamento = math.random(1000,1600)
			if itens <= 500 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("armacaodearma")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(5,6)
					vRP.giveInventoryItem( user_id,"armacaodearma",quantidade)
					vRP.giveInventoryItem( user_id,"dinheirosujo",pagamento)
					if parseInt(math.random(1000)) < 5 then
						local weaponsort = math.random(1,4)
						if parseInt(weaponsort) == 1 then
							vRP.giveInventoryItem(user_id,"armacaodeak",1)
						elseif parseInt(weaponsort) == 2 then
							vRP.giveInventoryItem(user_id,"armacaodemp5",1)
						elseif parseInt(weaponsort) == 3 then
							vRP.giveInventoryItem(user_id,"armacaodeg3",1)
						elseif parseInt(weaponsort) == 4 then
							vRP.giveInventoryItem(user_id,"armacaodetec",1)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end	
--[[ 		elseif vRP.hasPermission(user_id,"scripted.permissao") then
			local itens = math.random(60)
			local quantidade = math.random(5,6)
			local pagamento = math.random(1500,2400)
			if itens <= 500 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("armacaodearma")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(5,6)
					vRP.giveInventoryItem( user_id,"armacaodearma",quantidade)
					vRP.giveInventoryItem( user_id,"dinheirosujo",pagamento)
					if parseInt(math.random(1000)) < 5 then
						local weaponsort = math.random(1,4)
						if parseInt(weaponsort) == 1 then
							vRP.giveInventoryItem(user_id,"armacaodeak",1)
						elseif parseInt(weaponsort) == 2 then
							vRP.giveInventoryItem(user_id,"armacaodemp5",1)
						elseif parseInt(weaponsort) == 3 then
							vRP.giveInventoryItem(user_id,"armacaodeg3",1)
						elseif parseInt(weaponsort) == 4 then
							vRP.giveInventoryItem(user_id,"armacaodetec",1)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end	 ]]
		   -----------------------------------------------------------------------------------------------------------------------------------------
           --METAL 1----------------------------------------------------------------------------------------------------------------------------------
		   -----------------------------------------------------------------------------------------------------------------------------------------
			
--[[ 		elseif vRP.hasPermission(user_id,"driftking.permissao") or vRP.hasPermission(user_id,"native.permissao") then
			local itens = math.random(60)
			local quantidade = math.random(5,9)
			if itens <= 500 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("metal")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(5,9)
					vRP.giveInventoryItem( user_id,"metal",quantidade)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end	

		elseif vRP.hasPermission(user_id,"driftking.permissao") or vRP.hasPermission(user_id,"native.permissao") then
			local itens = math.random(60)
			local quantidade = math.random(5,9)
			if itens <= 500 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("metal")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(5,9)
					vRP.giveInventoryItem( user_id,"metal",quantidade)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end ]]
		   -----------------------------------------------------------------------------------------------------------------------------------------
           --MUNI 1----------------------------------------------------------------------------------------------------------------------------------
		   -----------------------------------------------------------------------------------------------------------------------------------------
			
		elseif vRP.hasPermission(user_id,"yardie.permissao") then
			local itens = math.random(60)
			local quantidade = math.random(4,6)
			local pagamento = math.random(1000,1600)
			if itens <= 500 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("materialmunicao")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(4,6)
					vRP.giveInventoryItem( user_id,"materialmunicao",quantidade)
					vRP.giveInventoryItem( user_id,"dinheirosujo",pagamento)
					if parseInt(math.random(1000)) < 5 then
						local weaponsort = math.random(1,4)
						if parseInt(weaponsort) == 1 then
							vRP.giveInventoryItem(user_id,"materialak",1)
						elseif parseInt(weaponsort) == 2 then
							vRP.giveInventoryItem(user_id,"materialmp5",1)
						elseif parseInt(weaponsort) == 3 then
							vRP.giveInventoryItem(user_id,"materialg3",1)
						elseif parseInt(weaponsort) == 4 then
							vRP.giveInventoryItem(user_id,"materialtec",1)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end	

		elseif vRP.hasPermission(user_id,"russkaya.permissao") then
			local itens = math.random(60)
			local quantidade = math.random(4,6)
			local pagamento = math.random(1000,1600)
			if itens <= 500 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("materialmunicao")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(4,6)
					vRP.giveInventoryItem( user_id,"materialmunicao",quantidade)
					vRP.giveInventoryItem( user_id,"dinheirosujo",pagamento)
					if parseInt(math.random(1000)) < 5 then
						local weaponsort = math.random(1,4)
						if parseInt(weaponsort) == 1 then
							vRP.giveInventoryItem(user_id,"materialak",1)
						elseif parseInt(weaponsort) == 2 then
							vRP.giveInventoryItem(user_id,"materialmp5",1)
						elseif parseInt(weaponsort) == 3 then
							vRP.giveInventoryItem(user_id,"materialg3",1)
						elseif parseInt(weaponsort) == 4 then
							vRP.giveInventoryItem(user_id,"materialtec",1)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end	

		elseif vRP.hasPermission(user_id,"cartel.permissao") then
			local itens = math.random(60)
			local quantidade = math.random(4,6)
			local pagamento = math.random(1000,1600)
			if itens <= 500 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("materialmunicao")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(4,6)
					vRP.giveInventoryItem( user_id,"materialmunicao",quantidade)
					vRP.giveInventoryItem( user_id,"dinheirosujo",pagamento)
					if parseInt(math.random(1000)) < 5 then
						local weaponsort = math.random(1,4)
						if parseInt(weaponsort) == 1 then
							vRP.giveInventoryItem(user_id,"materialak",1)
						elseif parseInt(weaponsort) == 2 then
							vRP.giveInventoryItem(user_id,"materialmp5",1)
						elseif parseInt(weaponsort) == 3 then
							vRP.giveInventoryItem(user_id,"materialg3",1)
						elseif parseInt(weaponsort) == 4 then
							vRP.giveInventoryItem(user_id,"materialtec",1)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end	
		end

	elseif vRP.hasPermission(user_id,"k.permissao") then
		local itens = math.random(60)
		local quantidade = math.random(4,6)
		local pagamento = math.random(1000,1600)
		if itens <= 500 then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("materialmunicao")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
				quantidade = math.random(4,6)
				vRP.giveInventoryItem( user_id,"materialmunicao",quantidade)
				vRP.giveInventoryItem( user_id,"dinheirosujo",pagamento)
				if parseInt(math.random(1000)) < 30 then
					local weaponsort = math.random(1,4)
					if parseInt(weaponsort) == 1 then
						vRP.giveInventoryItem(user_id,"materialak",1)
					elseif parseInt(weaponsort) == 2 then
						vRP.giveInventoryItem(user_id,"materialmp5",1)
					elseif parseInt(weaponsort) == 3 then
						vRP.giveInventoryItem(user_id,"materialg3",1)
					elseif parseInt(weaponsort) == 4 then
						vRP.giveInventoryItem(user_id,"materialtec",1)
					end
				end
			else
				TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
			end
		end	
	end		
		return true			
	end