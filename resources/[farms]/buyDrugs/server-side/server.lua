local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("buyDrugs", src)
vCLIENT = Tunnel.getInterface("buyDrugs")


--[[ 
    CHECK ESTOQUE 
    ]]

function VerificarMembro(fac, perm)
    if fac == "families" then
        return true
    elseif fac == "vagos" then
        return true
    elseif fac == "Ballas" then
        return true
    end
    return false
end
function checkEstoque(fac)
    local source = source
    local user_id = vRP.getUserId(source)
    local value = vRP.getSData("EstoqueDroga" .. fac)
    local saldofac = json.decode(value) or 0
    if saldofac > 0 then
        return true
    else
        TriggerClientEvent("Notify", source, "sucesso", "Sucesso", "Sem Estoque de Droga No Momento")
        return false
    end
end

--[[ 
    ADIÇÃO ESTOQUE 
    ]]

function src.addEstoque()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id, "droga.menu") then
        return false
    end
    local qtd = vRP.prompt(source, "Quantas Unidades Deseja Adicionar:", "")
    if qtd == "" then
        return
    end

    if vRP.hasPermission(user_id, "families.permissao") then
        local value = vRP.getSData("EstoqueDroga" .. "families")
        local saldofac = json.decode(value) or 0
        qtd = tonumber(qtd)
        if vRP.tryGetInventoryItem(user_id, "maconha", qtd) then
            vRP.setSData("EstoqueDroga" .. "families", saldofac + qtd)
            TriggerClientEvent("Notify", source, "aviso", "Estoque de Maconha atual >>> " .. saldofac)
        end

    elseif vRP.hasPermission(user_id, "ballas.permissao") then
        local value = vRP.getSData("EstoqueDroga" .. "Ballas")
        local saldofac = json.decode(value) or 0
        qtd = tonumber(qtd)
        if vRP.tryGetInventoryItem(user_id, "lsd", qtd) then
            vRP.setSData("EstoqueDroga" .. "Ballas", saldofac + qtd)
            TriggerClientEvent("Notify", source, "aviso", "Estoque de Lsd atual >>> " .. saldofac)
        end

    elseif vRP.hasPermission(user_id, "vagos.permissao") then
        local value = vRP.getSData("EstoqueDroga" .. "Vagos")
        local saldofac = json.decode(value) or 0
        qtd = tonumber(qtd)
        if vRP.tryGetInventoryItem(user_id, "cocaina", qtd) then
            vRP.setSData("EstoqueDroga" .. "Vagos", saldofac + qtd)
            TriggerClientEvent("Notify", source, "aviso", "Estoque de Cocaina atual >>> " .. saldofac)
        end
    end
end

--[[ 
    RETIRADA DE ESTOQUE
     ]]

function retirarQTD(fac, valor)
    local value = vRP.getSData("EstoqueDroga" .. fac)
    local saldofac = json.decode(value) or 0
    valor = tonumber(valor)
    if tonumber(valor) > saldofac then
        return false
    else
        vRP.setSData("EstoqueDroga" .. fac, saldofac - valor)
        return true
    end
end
RegisterCommand(
    "droga",
    function(source, args, rawCommand)
        local user_id = vRP.getUserId(source)
        local families2 = vRP.getSData("EstoqueDrogaFamilies")
        local families = json.decode(families2) or 0
        local vagos2 = vRP.getSData("EstoqueDrogaVagos")
        local vagos = json.decode(vagos) or 0
        local ballas2 = vRP.getSData("EstoqueDrogaBallas")
        local ballas = json.decode(ballas2) or 0
        TriggerClientEvent(
            "Notify",
            source,
            "aviso",
            "Estoque disponivel de cada facção: </b><br><b></b><br>families: <b> " ..
                families .. "</b><br>VAGOS: <b>" .. vagos .. "</b><br>BALLAS: <b>" .. ballas .. ""
        )
    end
)

--[[ 
    VENDA DE DROGAS
 ]]
local delayVMochila = {}
local PrecoDaDroga = 2500
function src.buyDrugs(TipoDaVenda)
    local user_id = vRP.getUserId(source)
    TriggerClientEvent("Notify",source,"aviso","O preço de cada droga será: " ..vRP.format(parseInt(PrecoDaDroga)) .. "$. Para ver a quantidade de droga disponivel digite /droga.")
    local qtd = vRP.prompt(source, "Quantas Unidades Deseja Comprar:", "")
    if qtd == "" then
        return
    end
    if not delayVMochila[user_id] or os.time() > (delayVMochila[user_id] + 1) then
        delayVMochila[user_id] = os.time()
        if user_id then
            if vRP.tryFullPayment(user_id, qtd * PrecoDaDroga) then
                local pagamento = qtd * PrecoDaDroga
                TriggerClientEvent("cancelando", source, true)
                if TipoDaVenda == "families" then
                    if checkEstoque("families") then
                        if retirarQTD("families", qtd) then
                            paymentFac("families", pagamento)
                            vRP.giveInventoryItem(user_id, "maconha", qtd)
                        else
                            TriggerClientEvent("Notify",source,"aviso","Dinheiro Insuficiente")
                        end 
                    end
                elseif TipoDaVenda == "ballas" then
                    if checkEstoque("Ballas") then
                        if retirarQTD("Ballas", qtd) then
                            paymentFac("Ballas", pagamento)
                            vRP.giveInventoryItem(user_id, "lsd", qtd)
                        else
                            TriggerClientEvent("Notify",source,"aviso","Dinheiro Insuficiente")
                        end
                    end
                elseif TipoDaVenda == "vagos" then
                    if checkEstoque("Vagos") then
                        if retirarQTD("Vagos", qtd) then
                            paymentFac("Vagos", pagamento)
                            vRP.giveInventoryItem(user_id, "cocaina", qtd)
                        else
                            TriggerClientEvent("Notify",source,"aviso","Dinheiro Insuficiente")
                        end
                    end
                    TriggerClientEvent("cancelando", source, false)
                end
            end
        end
    end
end

--[[ 
    PAYMENT 
    ]]

function paymentFac(QualFac, qtd)
    local source = source
    local user_id = vRP.getUserId(source)
    local value = vRP.getSData("EstoqueDroga" .. QualFac)
    local resultado = json.decode(value) or 0

    if QualFac == "families" then
        vRP.setSData("salario" .. "families", resultado + qtd)
    elseif QualFac == "Vagos" then
        vRP.setSData("salario" .. "Vagos", resultado + qtd)
    elseif QualFac == "Ballas" then
        vRP.setSData("salario" .. "Ballas", resultado + qtd)
    end
end

--[[ 
    SACAR
     ]]

function src.sacarDinDin()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, "families.permissao") then
        local value = vRP.getSData("salario" .. "families")
        local resultado = json.decode(value) or 0
        local saldoantes = resultado
        TriggerClientEvent("Notify", source, "aviso", "Saldo De Vendas: $" .. vRP.format(parseInt(resultado)))
        local qtd = vRP.prompt(source, "Digite o valor  que deseja Sacar:", "")
        qtd = tonumber(qtd)
        if string.sub(tonumber(qtd), 1, 1) == "-" then
            TriggerClientEvent("Notify", source, "aviso", "Quantia inválida (valor negativo).")
            return
        end
        if resultado >= qtd then
            resultado = saldoantes - qtd
            vRP.setSData("salario" .. "families", resultado)
            vRP.giveMoney(user_id, qtd)
            TriggerClientEvent("Notify", source, "aviso", "Você Sacou: $" .. vRP.format(parseInt(qtd)))
        else
            TriggerClientEvent("Notify", source, "aviso", "Quantia inválida.")
        end
    elseif vRP.hasPermission(user_id, "ballas.permissao") then
        local value = vRP.getSData("salario" .. "Ballas")
        local resultado = json.decode(value) or 0
        local saldoantes = resultado
        TriggerClientEvent("Notify", source, "aviso", "Saldo De Vendas: $" .. vRP.format(parseInt(resultado)))
        local qtd = vRP.prompt(source, "Digite o valor  que deseja Sacar:", "")
        qtd = tonumber(qtd)
        if string.sub(tonumber(qtd), 1, 1) == "-" then
            TriggerClientEvent("Notify", source, "aviso", "Quantia inválida (valor negativo).")
            return
        end
        if resultado >= qtd then
            resultado = saldoantes - qtd
            vRP.setSData("salario" .. "Ballas", resultado)
            vRP.giveMoney(user_id, qtd)
            TriggerClientEvent("Notify", source, "aviso", "Você Sacou: $" .. vRP.format(parseInt(qtd)))
        else
            TriggerClientEvent("Notify", source, "aviso", "Quantia inválida.")
        end
    elseif vRP.hasPermission(user_id, "vagos.permissao") then
        local value = vRP.getSData("salario" .. "Vagos")
        local resultado = json.decode(value) or 0
        local saldoantes = resultado
        TriggerClientEvent("Notify", source, "aviso", "Saldo De Vendas: $" .. vRP.format(parseInt(resultado)))
        local qtd = vRP.prompt(source, "Digite o valor  que deseja Sacar:", "")
        qtd = tonumber(qtd)
        if string.sub(tonumber(qtd), 1, 1) == "-" then
            TriggerClientEvent("Notify", source, "aviso", "Quantia inválida (valor negativo).")
            return
        end
        if resultado >= qtd then
            resultado = saldoantes - qtd
            vRP.setSData("salario" .. "Vagos", resultado)
            vRP.giveMoney(user_id, qtd)
            TriggerClientEvent("Notify", source, "aviso", "Você Sacou: $" .. vRP.format(parseInt(qtd)))
            SendWebhookMessage(vagos,"```prolog\n[ID]: " ..user_id .. "\n[RETIROU]: " ..qtd .."$\n[FACCAO]: VAGOS \n[SALDO ANTIGO]: " ..resultado .. "" .. os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```")
        else
            TriggerClientEvent("Notify", source, "aviso", "Quantia inválida.")
        end
    end
end
