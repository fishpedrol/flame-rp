RegisterNetEvent('feijonts:NotificacaoPolicia')
AddEventHandler('feijonts:NotificacaoPolicia', function(type, data, length)
	SendNUIMessage({action = 'display', style = type, info = data, length = length})
	PlaySound(-1, "SELECT", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1);
end)