-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("vrp_radio",src)
vCLIENT = Tunnel.getInterface("vrp_radio")

local radios = {
	[911] = {
		name = "Police",
		permissions = {
			"policia.permissao"
		}
	},
}

function src.playanim()
	vRPclient._CarregarObjeto(source,"cellphone@","cellphone_text_in","prop_cs_hand_radio",50,28422)
end

function src.stopanim()
	vRPclient._stopAnim(source,false)
	vRPclient._DeletarObjeto(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.activeFrequency(freq)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) <= 101 then 
			local identity = vRP.getUserIdentity(user_id)

			TriggerClientEvent("Notify",source,"negado","Você precisa estar <b>consciente</b> para se conectar à uma rádio :(")
			return 
		end

		if parseInt(freq) >= 1 and parseInt(freq) <= 999 then
			local radio = radios[parseInt(freq)]
			if radio then
				local allowed = false
				for k, v in pairs(radio.permissions) do
					if vRP.hasPermission(user_id, v) then
						allowed = true
					end
				end

				if allowed then
					TriggerClientEvent("Notify",source,"sucesso","Você agora está conectado na rádio <b>"..radio.name.." ("..freq..")</b>")
					vCLIENT.startFrequency(source,parseInt(freq))
				else
					TriggerClientEvent("Notify",source,"aviso","Você não tem permissão para entrar nesta rádio",8000)
				end
			else
				vCLIENT.startFrequency(source,parseInt(freq))
				TriggerClientEvent("Notify",source,"sucesso","Entrou na frequência <b>"..parseInt(freq).."</b>.",8000)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Frequência não encontrada.",8000)
		end
	end
end

function src.logDiscord()
	local source = source
	local user_id = vRP.getUserId(source)
	print("^3[Rádio] ^7O usuário ^3" .. user_id .. " ^7foi desconectado da rádio por estar sem nenhum rádio no inventário")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkRadio()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"radio") >= 1 then
		return true
	else
		TriggerClientEvent("Notify",source,"importante","Você precisa comprar um <b>Rádio</b> na <b>Loja de Departamento</b>.",8000)
		return false
	end
end

function src.checkRadio2()
	local source = source
	local user_id = vRP.getUserId(source)
	return (vRP.getInventoryItemAmount(user_id,"radio") >= 1)
end