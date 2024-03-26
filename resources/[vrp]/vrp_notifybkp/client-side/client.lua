-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY CSS,PREFIX,MENSAGEM,TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,prefix,message,delay)
	if message == nil then
		message = prefix
		prefix = string.upper(css)
	end

	if not delay then delay = 9000 end
	SendNUIMessage({ css = css, prefix = prefix, message = message, delay = delay })
end)
