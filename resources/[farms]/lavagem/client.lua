local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
juan = Tunnel.getInterface("vrp_lavagem",juan)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIZAÇÃO DAS LAVAGENS DE DINHEIRO --
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ -1375.82,-626.17,30.82,"bahamas.permissao" },
	{ -1053.79,-230.6,44.03,"lifeinvader.permissao" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO PARA LAVAR O DINHEIRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('lavar',function(source,args,rawCommand)
	local ped = PlayerPedId()
	for _,v in pairs(locais) do
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local distance = Vdist(v[1],v[2],v[3],x,y,z)
		if distance <= 3.5 then
			if juan.PermissaoPlayer(v[4]) then
				if juan.ChecarPagamento() then
					if args[1] == "s" then
						if juan.VerificarComponente("alvejante",10) then
							juan.EnviarPagamento("lavagemsimples")
						end
					elseif args[1] == "a" then 
						if juan.VerificarComponente("alvejantemodificado",1) then
							juan.EnviarPagamento("lavagemavancada")
						end
					end 

				end
			end
		end
	end
end)