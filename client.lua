ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:armor')
AddEventHandler('esx:armor', function()
	local playerPed = PlayerPedId()
	local armor = loadModel(`prop_bodyarmour_03`)
	local crate = CreateObject(armor, 0,0,0, true, false, false)

	ESX.Streaming.RequestAnimDict('oddjobs@basejump@ig_15', function()
		TaskPlayAnim(playerPed, 'oddjobs@basejump@ig_15', 'puton_parachute', 49.0, -8, -1, 49, 0, 0, 0, 0)
		AttachEntityToEntity(crate, playerPed, GetPedBoneIndex(playerPed, 57005), 0.09, 0.03, -0.02, -28.0, 3.0, 28.0, false, true, true, true, 0, true)

		exports["progressBars"]:startUI(5000, "Putting Armor...")


		Citizen.Wait(5000)
		TriggerEvent('skinchanger:getSkin', function(skin) 
			if skin.sex == 0 then
			local clothesSkin = {
			['bproof_1'] = 16,  ['bproof_2'] = 2---Change these values for which ThermalVision helmet want to use.
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
		end)
		ClearPedSecondaryTask(playerPed)
		DeleteObject(crate)
	end)

	SetPedArmour(playerPed, 100)
end)


loadModel = function(object)
    while not HasModelLoaded(object) do Wait(0) RequestModel(object) end
    return object
end

