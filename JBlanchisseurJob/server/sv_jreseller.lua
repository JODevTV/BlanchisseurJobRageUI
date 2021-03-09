ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_society:registerSociety', 'reseller', 'reseller', 'society_reseller', 'society_reseller', 'society_reseller', {type = 'public'})

RegisterServerEvent('PaBLO:getStockItem')
AddEventHandler('PaBLO:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_reseller', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
			--	if Config.EnableJobLogs == true then
			--		TriggerEvent('esx_joblogs:AddInLog', 'reseller', 'getSharedInventory', xPlayer.name, count, inventoryItem.label)
			--	end
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end
	end)
end)


ESX.RegisterServerCallback('PaBLO:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_reseller', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('PaBLO:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)
RegisterServerEvent('PaBLO:putStockItems')
AddEventHandler('PaBLO:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_reseller', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		--	if Config.EnableJobLogs == true then
		--		TriggerEvent('esx_joblogs:AddInLog', 'reseller', 'putStockItems', xPlayer.name, count, inventoryItem.label)
		--	end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

RegisterServerEvent('jojo:blanchiement')
AddEventHandler('jojo:blanchiement', function(argent)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local taxe = 0.65    -- Le blanchisseur prend 35% (1-0.65 = 0.35)

	argent = ESX.Math.Round(tonumber(argent))
	pourcentage = argent * taxe
	Total = ESX.Math.Round(tonumber(pourcentage))

	if argent > 0 and xPlayer.getAccount('black_money').money >= argent then
		xPlayer.removeAccountMoney('black_money', argent)
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Information', 'Blanchiement', 'Attend ~r~10 secondes', 'CHAR_MP_FM_CONTACT', 8)
		Citizen.Wait(10000)
		
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Information', 'Blanchiement', 'Tu as reçu : ' .. ESX.Math.GroupDigits(Total) .. ' ~g~$', 'CHAR_MP_FM_CONTACT', 8)
		xPlayer.addMoney(Total)
	else
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Information', 'Blanchiement', '~r~Montant invalide', 'CHAR_MP_FM_CONTACT', 8)
	end	
end)

