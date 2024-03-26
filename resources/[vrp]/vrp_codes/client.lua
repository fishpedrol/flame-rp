-----------------------------------------------------------------------------------------------------------------------------------------
-- HOLSTER
-----------------------------------------------------------------------------------------------------------------------------------------
local weapons = {
	"WEAPON_KNIFE", "WEAPON_NIGHTSTICK", "WEAPON_HAMMER", "WEAPON_BAT", "WEAPON_GOLFCLUB",  
    "WEAPON_CROWBAR", "WEAPON_PISTOL", "WEAPON_COMBATPISTOL", "WEAPON_APPISTOL", "WEAPON_PISTOL50",  
    "WEAPON_MICROSMG", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_ASSAULTRIFLE",  
    "WEAPON_CARBINERIFLE", "WEAPON_ADVANCEDRIFLE", "WEAPON_MG", "WEAPON_COMBATMG", "WEAPON_PUMPSHOTGUN",  
    "WEAPON_SAWNOFFSHOTGUN", "WEAPON_ASSAULTSHOTGUN", "WEAPON_BULLPUPSHOTGUN", "WEAPON_STUNGUN", "WEAPON_SNIPERRIFLE",  
    "WEAPON_HEAVYSNIPER", "WEAPON_GRENADELAUNCHER", "WEAPON_GRENADELAUNCHER_SMOKE", "WEAPON_RPG", "WEAPON_MINIGUN",  
    "WEAPON_GRENADE", "WEAPON_STICKYBOMB", "WEAPON_SMOKEGRENADE", "WEAPON_BZGAS", "WEAPON_MOLOTOV",  
    "WEAPON_FIREEXTINGUISHER", "WEAPON_PETROLCAN", "WEAPON_FLARE", "WEAPON_SNSPISTOL", "WEAPON_SPECIALCARBINE",  
    "WEAPON_HEAVYPISTOL", "WEAPON_BULLPUPRIFLE", "WEAPON_HOMINGLAUNCHER", "WEAPON_PROXMINE", "WEAPON_SNOWBALL",  
    "WEAPON_VINTAGEPISTOL", "WEAPON_DAGGER", "WEAPON_FIREWORK", "WEAPON_MUSKET", "WEAPON_MARKSMANRIFLE",  
    "WEAPON_HEAVYSHOTGUN", "WEAPON_GUSENBERG", "WEAPON_HATCHET", "WEAPON_RAILGUN", "WEAPON_COMBATPDW",  
    "WEAPON_KNUCKLE", "WEAPON_MARKSMANPISTOL", "WEAPON_FLASHLIGHT", "WEAPON_MACHETE", "WEAPON_MACHINEPISTOL",  
    "WEAPON_SWITCHBLADE", "WEAPON_REVOLVER", "WEAPON_COMPACTRIFLE", "WEAPON_DBSHOTGUN", "WEAPON_FLAREGUN",  
    "WEAPON_AUTOSHOTGUN", "WEAPON_BATTLEAXE", "WEAPON_COMPACTLAUNCHER", "WEAPON_MINISMG", "WEAPON_PIPEBOMB",  
	"WEAPON_POOLCUE", "WEAPON_SWEEPER", "WEAPON_WRENCH", "WEAPON_PISTOL_MK2", "WEAPON_SNSPISTOL_MK2", 
	"WEAPON_REVOLVER_MK2", "WEAPON_SMG_MK2", "WEAPON_PUMPSHOTGUN_MK2", "WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE_MK2", "WEAPON_SPECIALCARBINE_MK2", "WEAPON_BULLPUPRIFLE_MK2", "WEAPON_COMBATMG_MK2",
	"WEAPON_HEAVYSNIPER_MK2", "WEAPON_MARKSMANRIFLE_MK2"
}

local holster = false
local holsterWeapon = nil
Citizen.CreateThread(function()
	while true do
		local timeDistance = 200
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			if GetEntityHealth(ped) > 101 and GetVehiclePedIsTryingToEnter(ped) == 0 and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) and not IsPedInParachuteFreeFall(ped) then
				local checkWeapon,lastWeapon = CheckWeapon(ped)

				if lastWeapon ~= nil then
					holsterWeapon = lastWeapon
				end

				if checkWeapon then
					if not holster then
						timeDistance = 4

						if not IsEntityPlayingAnim(ped,"rcmjosh4","josh_leadout_cop2",3) then
							SetPedCurrentWeaponVisible(ped,0,0,1,1)
							loadAnimDict("rcmjosh4")
							TaskPlayAnim(ped,"rcmjosh4","josh_leadout_cop2",3.0,2.0,-1,48,10,0,0,0)
							Citizen.Wait(200)
							SetPedCurrentWeaponVisible(ped, 1, 0, 1, 1)
							Citizen.Wait(300)
							ClearPedTasks(ped)
						end
						holster = true
					end
				elseif not checkWeapon then
					if holster then
						timeDistance = 4

						if not IsEntityPlayingAnim(ped,"weapons@pistol@","aim_2_holster",3) then
							loadAnimDict("weapons@pistol@")
							SetCurrentPedWeapon(ped,GetHashKey(holsterWeapon),true)
							TaskPlayAnim(ped,"weapons@pistol@","aim_2_holster",3.0,2.0,-1,48,10,0,0,0)
							Citizen.Wait(450)
							SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
							ClearPedTasks(ped)
						end
						holster = false
					end
				end
			end
		end

		if GetEntityHealth(ped) <= 101 and holster then
			holster = false
			SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
		end

		Citizen.Wait(timeDistance)
	end
end)

function CheckWeapon(ped)
	for i = 1,#weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true,weapons[i]
		end
	end
	return false,nil
end


function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end