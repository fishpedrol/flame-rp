-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY CSS,MENSAGEM,TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify", function(css, message, delay)
    if not delay then
        delay = 13000
    end
    SendNUIMessage({ css = css, message = message, delay = delay })
end)

-- RegisterCommand("teste",function(source,args)
-- 	TriggerEvent('Notify', 'sucesso',"MAMA BRASIL HAHAHAHAHAHAHAHAHAHA")
-- 	TriggerEvent('Notify', 'negado',"MAMA BRASIL HAHAHAHAHAHAHAHAHAHA")
-- 	TriggerEvent('Notify', 'importante',"MAMA BRASIL HAHAHAHAHAHAHAHAHAHA")	
-- 	TriggerEvent('Notify', 'aviso',"MAMA BRASIL HAHAHAHAHAHAHAHAHAHA")	
-- 	TriggerEvent('Notify', 'financeiro',"MAMA BRASIL HAHAHAHAHAHAHAHAHAHA")	
-- 	TriggerEvent('Notify', 'vtuning',"MAMA BRASIL HAHAHAHAHAHAHAHAHAHA")	
-- end)