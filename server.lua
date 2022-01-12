ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('armor', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx:armor', source)
	xPlayer.removeInventoryItem('armor', 1)
end)