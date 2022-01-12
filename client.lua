ESX = nil
local armorModel = 'prop_bodyarmour_03'

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:armor')
AddEventHandler('esx:armor', function()
	while not HasModelLoaded(armorModel) do
		Wait(0)
		RequestModel(armorModel)
	end
		
	local playerPed  = PlayerPedId()
	local armor = GetHashKey(armorModel)
	local crate = CreateObject(armor, GetEntityCoords(playerPed), true, false, false)

	ESX.Streaming.RequestAnimDict('oddjobs@basejump@ig_15', function()
		TaskPlayAnim(playerPed, 'oddjobs@basejump@ig_15', 'puton_parachute', 49.0, -8, -1, 49, 0, 0, 0, 0)
		AttachEntityToEntity(crate, playerPed, GetPedBoneIndex(playerPed, 57005), 0.09, 0.03, -0.02, -28.0, 3.0, 28.0, false, true, true, true, 0, true)

		exports["progressBars"]:startUI(5000, "Putting on armor...")

		Wait(5000)
		TriggerEvent('skinchanger:getSkin', function(skin) 
			if skin.sex == 0 then
				local clothesSkin = {
					['bproof_1'] = 16,  ['bproof_2'] = 2 --Change these values for which vest you want to use
						}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
			end)
		ClearPedSecondaryTask(playerPed)
		DetachEntity(crate, true, true)
		DeleteObject(crate)
	end)
	SetPedArmour(playerPed, 100)
end)
