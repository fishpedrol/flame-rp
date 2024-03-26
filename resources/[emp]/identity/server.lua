-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local cfg = module("vrp", "cfg/groups")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
vRPN = {}
Tunnel.bindInterface("identity", vRPN)
Proxy.addInterface("identity", vRPN)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local groups = cfg.groups
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Identidade()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local cash = vRP.getMoney(user_id)
        local bank = vRP.getBankMoney(user_id)
        local identity = vRP.getUserIdentity(user_id)
        local job = vRPN.getUserGroupByType(user_id, "job")
        local jobdois = vRPN.getUserGroupByType(user_id, "jobdois")
        local vip = vRPN.getUserGroupByType(user_id, "vip")
        local gerente = vRPN.getUserGroupByType(user_id, "gerente")
        if identity then
            return {
                cash = vRP.format(parseInt(cash)),
                bank = vRP.format(parseInt(bank)),
                name = identity.name .. " " .. identity.firstname,
                age = identity.age,
                userid = identity.user_id,
                identity = identity.registration,
                phone = identity.phone,
                job = job,
                job2 = jobdois,
                vip = vip,
                staff = gerente
            }
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.getUserGroupByType(user_id, gtype)
    local user_groups = vRP.getUserGroups(user_id)
    for k, v in pairs(user_groups) do
        local kgroup = groups[k]
        if kgroup then
            if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
                return kgroup._config.title
            end
        end
    end
    return nil
end
