local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_banco")


local giveCashAnywhere = false 
local withdraWAnywhere = false 
local depositAnywhere = false 
local displayBankBlips = true 
local enableBankingGui = true 

local banks = {
  {name="Banco", id=108, x=150.266, y=-1040.203, z=29.374},
  {name="Banco", id=108, x=-1212.980, y=-330.841, z=37.787},
  {name="Banco", id=108, x=-2962.582, y=482.627, z=15.703},
  {name="Banco", id=108, x=-112.202, y=6469.295, z=31.626},
  {name="Banco", id=108, x=314.187, y=-278.621, z=54.170},
  {name="Banco", id=108, x=-351.534, y=-49.529, z=49.042},
  {name="Banco", id=108, x=237.31, y=217.78, z=106.29}, -- CENTRAL
  {name="Banco", id=108, x=1175.54, y=2706.63, z=38.09},

  --ATMS
  {name="Banco", id=108, x=380.76400756836, y=323.38748168945, z=103.56636810303},
  {name="Banco", id=108, x=33.200717926025, y=-1348.2208251953, z=29.497043609619},
  {name="Banco", id=108, x=2558.4545898438, y=389.54257202148, z=108.62294006348},
  {name="Banco", id=108, x=1153.6931152344, y=-326.8268737793, z=69.205139160156},
  {name="Banco", id=108, x=-717.61431884766, y=-915.8046875, z=19.215589523315},
  {name="Banco", id=108, x=-56.934768676758, y=-1752.1641845703, z=29.421012878418},
  {name="Banco", id=108, x=-3240.58984375, y=1008.6592407227, z=12.830708503723},
  {name="Banco", id=108, x=1735.2423095703, y=6410.53515625, z=35.037223815918},
  {name="Banco", id=108, x=540.23602294922, y=2671.095703125, z=42.156490325928},
  {name="Banco", id=108, x=1968.0998535156, y=3743.5573730469, z=32.34375},
  {name="Banco", id=108, x=2683.0681152344, y=3286.5756835938, z=55.24112701416},
  {name="Banco", id=108, x=1702.9084472656, y=4933.5522460938, z=42.063674926758},
  {name="Banco", id=108, x=-1827.1905517578, y=784.90563964844, z=138.30258178711}
}

Citizen.CreateThread(function()
  if displayBankBlips then
    for k,v in ipairs(banks)do
      local blip = AddBlipForCoord(v.x, v.y, v.z)
      SetBlipSprite(blip, v.id)
      SetBlipScale(blip, 0.4)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING");
      AddTextComponentString(tostring(v.name))
      EndTextCommandSetBlipName(blip)
    end
  end
end)

local atBank = false
local bankOpen = false

RegisterNetEvent('send:banco')
AddEventHandler('send:banco', function(banco)
  TransitionToBlurred(1000)
	SetNuiFocus(true, true)
	SendNUIMessage({
    openBank = true,
		banco = banco
	})
end)


function closeGui()
  TransitionFromBlurred(1000)
  SetNuiFocus(false)
  SendNUIMessage({openBank = false})
  bankOpen = false
  atmOpen = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		local pos = GetEntityCoords(PlayerPedId(), true)
		for k, j in pairs(banks) do
			if(Vdist(pos.x, pos.y, pos.z, j.x, j.y, j.z) < 150.0) then
				if(Vdist(pos.x, pos.y, pos.z, j.x, j.y, j.z) < 5.0) then
					draw3DText(j.x, j.y, j.z, "Pressione ~g~E~w~ para acessar o banco")
				end
			end
		end
	end
end)

if enableBankingGui then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if(IsNearBank()) then
        atBank = true
        if IsControlJustPressed(1, 51) and not vRP.isHandcuffed()  then 
            if bankOpen then
              closeGui()
              bankOpen = false
            else
              TriggerServerEvent("bank:update9")
              TriggerServerEvent("get:banco")
              bankOpen = true
          end
      	end
      else
        if(bankOpen) then
          closeGui()
        end
        atBank = false
        bankOpen = false
      end
    end
  end)
end

Citizen.CreateThread(function()
  while true do
    if bankOpen then
      local ply = PlayerPedId()
      local active = true
      DisableControlAction(0, 1, active) 
      DisableControlAction(0, 2, active) 
      DisableControlAction(0, 24, active) 
      DisablePlayerFiring(ply, true) 
      DisableControlAction(0, 142, active)
      DisableControlAction(0, 106, active) 
    end
    Citizen.Wait(0)
  end
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('balance', function(data, cb)
  SendNUIMessage({openSection = "balance"})
  cb('ok')
end)

RegisterNUICallback('multasbalance', function(data, cb)
  SendNUIMessage({openSection = "multasbalance"})
  cb('ok')
end)
RegisterNUICallback('walletbalance', function(data, cb)
  SendNUIMessage({openSection = "walletbalance"})
  cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
  SendNUIMessage({openSection = "withdraw"})
  cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
  SendNUIMessage({openSection = "deposit"})
  cb('ok')
end)

RegisterNUICallback('transfer', function(data, cb)
  SendNUIMessage({openSection = "transfer"})
  cb('ok')
end)

RegisterNUICallback('quickCash', function(data, cb)
  TriggerServerEvent('bank:quickCash9')
  cb('ok')
end)

RegisterNUICallback('erroMulta', function()
  TriggerEvent('Notify','negado',"Você não tem nenhuma multa para pagar")
end)
RegisterNUICallback('erroMulta2', function()
  TriggerEvent('Notify','negado',"Valor desejado inexistente")
end)

RegisterNUICallback('withdrawSubmit', function(data, cb)
  TriggerEvent('bank:withdraw9', data.amount)
  cb('ok')
end)

RegisterNUICallback('depositSubmit', function(data, cb)
  TriggerEvent('bank:deposit9', data.amount)
  cb('ok')
end)

RegisterNUICallback('pagarMulta', function(data,cb)
  TriggerEvent('bank:pagarmulta9', tonumber(data.amount))
  cb('ok')
end)

RegisterNUICallback('transferSubmit', function(data, cb)
  local toPlayer = data.toPlayer
  local amount = data.amount
  TriggerServerEvent("bank:transfer9", toPlayer, tonumber(amount))
end)

function IsNearBank()
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(banks) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if (distance <= 3) then
      return true
    end
  end
end

function IsNearPlayer(player)
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
  local ply2Coords = GetEntityCoords(ply2, 0)
  local distance = GetDistanceBetweenCoords(ply2Coords["x"], ply2Coords["y"], ply2Coords["z"],  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
  if (distance <= 5) then
    return true
  end
end

RegisterNetEvent('bank:pagarmulta9')
AddEventHandler('bank:pagarmulta9', function(amount)
  if(IsNearBank() == true or depositAnywhere == true ) then
    TriggerServerEvent("bank:pagarmulta9", tonumber(amount))
  else
    vRP.notifyError("Você só pode pagar multa em um banco!")
  end
end)

RegisterNetEvent('bank:deposit9')
AddEventHandler('bank:deposit9', function(amount)
  if(IsNearBank() == true or depositAnywhere == true ) then
    TriggerServerEvent("bank:deposit9", tonumber(amount))
  else
    vRP.notifyError("Você só pode depositar em um banco!")
  end
end)

RegisterNetEvent('bank:withdraw9')
AddEventHandler('bank:withdraw9', function(amount)
  if (IsNearBank() == true or withdraWAnywhere == true) then
    TriggerServerEvent("bank:withdraw9", tonumber(amount))
  else
    vRP.notifyError("Você só pode sacar em um banco!")
  end
end)

RegisterNetEvent('bank:givecash9')
AddEventHandler('bank:givecash9', function(toPlayer, amount)
  if(IsNearPlayer(toPlayer) == true or giveCashAnywhere == true) then
    local player2 = GetPlayerFromServerId(toPlayer)
    local playing = IsPlayerPlaying(player2)
    if (playing ~= false) then
      TriggerServerEvent("bank:givecash9", toPlayer, tonumber(amount))
      vRP.notify("Você transferiu " .. tonumber(amount) .. " para " .. toPlayer)
    else
      vRP.notifyWarning("Cidadão fora da cidade!")
    end
  else
    vRP.notifyWarning("Cidadão não mora nessa cidade!")
  end
end)

RegisterNetEvent('banking:updateBalance9')
AddEventHandler('banking:updateBalance9', function(balance, walletbalance, multasbalance,   identidade)
	SendNUIMessage({
		updateBalance = true,
    balance = balance,
    walletbalance = walletbalance,
    multasbalance = multasbalance,   
    identidade = identidade
    
	})
end)

RegisterNetEvent("banking:addBalance9")
AddEventHandler("banking:addBalance9", function(amount)
	SendNUIMessage({
		addBalance = true,
		amount = amount
	})
end)

RegisterNetEvent("banking:removeBalance9")
AddEventHandler("banking:removeBalance9", function(amount)
	SendNUIMessage({
		removeBalance = true,
		amount = amount
	})
end)


function draw3DText(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end