----------------------------------------------------------------------------------------------------------------------------------------
-- Client.lua ---- aim  ---  Criado Por Arcano
----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
arc = Tunnel.getInterface("aim")

local aimlock = false 
local permission = false

RegisterCommand("davidgay",function()
    if not arc.getPermissao() then
        return
    end

    if arc.getPermissao() then
       aimlock = not aimlock
    end
    if aimlock then
		drawNotification("~g~aim Ativado.")
		print("^2aim Ativado!")
		PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0)
	else
		drawNotification("~r~aim Desativado.")
		print("^1aim Desativado!")
	end
end)
local h = {
    ThisIsSliders = {
        [1] = {max = 255, min = 0, value = 247},
        [2] = {max = 255, min = 0, value = 255},
        [3] = {max = 255, min = 0, value = 0},
        [4] = {max = 255, min = 0, value = 255},
        [5] = {max = 255, min = 0, value = 255},
        [6] = {max = 255, min = 0, value = 255},
        [7] = {max = 255, min = 0, value = 0},
        [8] = {max = 255, min = 0, value = 0},
        [9] = {max = 255, min = 0, value = 0},
        [10] = {max = 255, min = 0, value = 255},
        [11] = {max = 255, min = 0, value = 255},
        [12] = {max = 255, min = 0, value = 255},
        [13] = {max = 255, min = 0, value = 255},
        [14] = {max = 255, min = 0, value = 0},
        [15] = {max = 255, min = 0, value = 0},
        [16] = {max = 255, min = 0, value = 255},
        [17] = {max = 255, min = 0, value = 255},
        [18] = {max = 255, min = 0, value = 255},
        [19] = {max = 255, min = 0, value = 0},
        [20] = {max = 255, min = 0, value = 76},
        [21] = {max = 255, min = 0, value = 255},
        [22] = {max = 255, min = 0, value = 255},
        [23] = {max = 255, min = 0, value = 0},
        [24] = {max = 255, min = 0, value = 0}
    }
}
local function bX(bY, bZ, b_)
    return coroutine.wrap(
        function()
            local c0, c1 = bY()
            if not c1 or c1 == 0 then
                b_(c0)
                return
            end
            local c2 = {handle = c0, destructor = b_}
            setmetatable(c2, entityEnumerator)
            local c3 = true
            repeat
                coroutine.yield(c1)
                c3, c1 = bZ(c0)
            until not c3
            c2.destructor, c2.handle = nil, nil
            b_(c0)
        end
    )
end
function lerp(n, o, p)
    if n > 1 then
        return p
    end
    if n < 0 then
        return o
    end
    return o + (p - o) * n
end
function EnumeratePeds()
    return bX(FindFirstPed, FindNextPed, EndFindPed)
end
Citizen.CreateThread(function()
    while true do
        local HazeStore = 1
        if aimlock then 
            local HazeStore = 1
            for cI in EnumeratePeds() do
                for k, id in ipairs(GetActivePlayers()) do
                    local cJ = GetPedBoneCoords(cI, 31086)
                    R = IsPedAPlayer(cI)
                    B = cI
                    local x, y, z = table.unpack(GetEntityCoords(cI))
                    local T, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
                    local cK = 1.15
                    local cL, cM = GetFinalRenderedCamCoord(), GetEntityRotation(PlayerPedId(), 2)
                    local cN, cO, cP = (cJ - cL).x, (cJ - cL).y, (cJ - cL).z
                    local cQ, aX, cR =
                        -math.deg(math.atan2(cN, cO)) - cM.z,
                        math.deg(math.atan2(cP, #vector3(cN, cO, 0.0))),
                        1.0
                    local cQ = lerp(1.0, 0.0, cQ)
                    if cI ~= PlayerPedId() and IsEntityOnScreen(cI) and R then
                        if _x > 0.5 - cK / 2 and _x < 0.5 + cK / 2 and _y > 0.5 - cK / 2 and _y < 0.5 + cK / 2 then
                            if IsDisabledControlPressed(0, 21) and IsDisabledControlPressed(0, 25) then
                                if HasEntityClearLosToEntity(PlayerPedId(), id, 19) then
                                    if GetEntityHealth(GetPlayerPed(id)) >= 102 and IsEntityVisible(GetPlayerPed(id)) then
                                        SetGameplayCamRelativeRotation(cQ, aX, cR)
                                    elseif GetEntityHealth(GetPlayerPed(id)) <= 101 and not IsEntityVisible(GetPlayerPed(id)) then
                                        SetGameplayCamRelativeRotation()
                                    end
                                end
                            end
                        end
                    end
                    if cI ~= PlayerPedId() and IsEntityOnScreen(cI) and B then
                        if _x > 0.5 - cK / 2 and _x < 0.5 + cK / 2 and _y > 0.5 - cK / 2 and _y < 0.5 + cK / 2 then
                            if IsDisabledControlPressed(0, 21) and IsDisabledControlPressed(0, 25) then
                                if HasEntityClearLosToEntity(PlayerPedId(), cI, 19) then
                                    if GetEntityHealth(cI) >= 102 and IsEntityVisible(cI) then
                                        SetGameplayCamRelativeRotation(cQ, aX, cR)
                                    elseif GetEntityHealth(cI) <= 101 and not IsEntityVisible(cI) then
                                        SetGameplayCamRelativeRotation()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(HazeStore)
    end
end)
RegisterNetEvent("drawnotification2")
AddEventHandler("drawnotification2",function(string)
    if aimlock then
        SetNotificationTextEntry("STRING")
        AddTextComponentString(string)
        DrawNotification(true, false)
    end
end)
function drawNotification(string)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(string)
	DrawNotification(true, false)
end
Citizen.CreateThread(function()
	while true do
        local HazeStore = 1000
		permission = arc.getPermissao() 
        Citizen.Wait(HazeStore)
	end
end)