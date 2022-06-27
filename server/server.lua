ESX = nil
TriggerEvent(Config.getESX, function(obj) ESX = obj end)
TriggerEvent('esx_society:registerSociety', 'vigne', 'vigne', 'society_vigne', 'society_vigne', 'society_vigne', {type = 'public'})

AC = AC or {};
AC.distanceProtect = 10;

RegisterServerEvent('vigne:open')
AddEventHandler('vigne:open', function()
	if not Shared.ESX_LEGACY then
    	local getPlayers = ESX.GetPlayers()
    	for i=1, #getPlayers, 1 do
    	    --local xPlayer = ESX.GetPlayerFromId(getPlayers[i])
    	    TriggerClientEvent('esx:showAdvancedNotification', getPlayers[i], 'Vigne', '~h~~p~Informations~s~', 	ServerConfig.Notifications.announceOpen, 'CHAR_MP_FM_CONTACT', 3)
    	end
	else
		local players = ESX.GetExtendedPlayers()
		for i = 1, #players do
			TriggerClientEvent('esx:showAdvancedNotification', players[i].playerId, 'Vigne', '~h~~p~Informations~s~', 	ServerConfig.Notifications.announceOpen, 'CHAR_MP_FM_CONTACT', 3)
		end
	end
end)

RegisterServerEvent('vigne:close')
AddEventHandler('vigne:close', function()
	if not Shared.ESX_LEGACY then
    	local getPlayers = ESX.GetPlayers()
    	for i=1, #getPlayers, 1 do
    	    --local xPlayer = ESX.GetPlayerFromId(getPlayers[i])
    	    TriggerClientEvent('esx:showAdvancedNotification', getPlayers[i], 'Vigne', 	'~h~~p~Informations~s~', ServerConfig.Notifications.announceClose, 	'CHAR_MP_FM_CONTACT', 3)
    	end
	else
		local players = ESX.GetExtendedPlayers()
		for i = 1, #players do
			TriggerClientEvent('esx:showAdvancedNotification', players[i].playerId, 'Vigne', 	'~h~~p~Informations~s~', ServerConfig.Notifications.announceClose, 	'CHAR_MP_FM_CONTACT', 3)
		end
	end
end)

RegisterServerEvent('vigne:recruitment')
AddEventHandler('vigne:recruitment', function()
	if not Shared.ESX_LEGACY then
   		local getPlayers = ESX.GetPlayers()
   		for i=1, #getPlayers, 1 do
   		    --local xPlayer = ESX.GetPlayerFromId(getPlayers[i]) -- ? a quoi cela sert si tu revoie getPlayers[i] ?
   		    TriggerClientEvent('esx:showAdvancedNotification', getPlayers[i], 'Vigne', '~h~~p~Informations~s~', ServerConfig.Notifications.announceRecruitment, 'CHAR_MP_FM_CONTACT', 3)
   		end
	else
		local players = ESX.GetExtendedPlayers()
		for i = 1, #players do
			TriggerClientEvent('esx:showAdvancedNotification', players[i].playerId, 'Vigne', '~h~~p~Informations~s~', ServerConfig.Notifications.announceRecruitment, 'CHAR_MP_FM_CONTACT', 3)
		end
	end
end)

RegisterServerEvent('vigne:custom')
AddEventHandler('vigne:custom', function(message) -- Le message custom est envoyé à la source?
	if not Shared.ESX_LEGACY then
    	local getPlayers = ESX.GetPlayers()
    	for i=1, #getPlayers, 1 do
    	    --local xPlayer = ESX.GetPlayerFromId(getPlayers[i])
    	    TriggerClientEvent('esx:showAdvancedNotification', getPlayers[i], 'Vigne', 	'~h~~p~Informations~s~', '~h~~b~'..message..'~s~', 'CHAR_MP_FM_CONTACT', 3)
    	end
	else
		local players = ESX.GetExtendedPlayers()
		for i=1, #players do
			TriggerClientEvent('esx:showAdvancedNotification', players[i].playerId, 'Vigne', 	'~h~~p~Informations~s~', '~h~~b~'..message..'~s~', 'CHAR_MP_FM_CONTACT', 3)
		end
	end
end)

ESX.RegisterServerCallback('vigne:playerinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local all_items = {}
	for k,v in pairs(items) do
		if v.count > 0 then
			all_items[#all_items+1] = {label = v.label, item = v.name,nb = v.count}
		end
	end
	cb(all_items)
end)

ESX.RegisterServerCallback('vigne:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				all_items[#all_items+1] = {label = v.label, item = v.name,nb = v.count}
			end
		end
	end)
	cb(all_items)
end)

RegisterServerEvent('vigne:putStockItems')
AddEventHandler('vigne:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
		if item_in_inventory >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous n\'avez pas assez d\'objets !~s~')
		end
	end)
end)

RegisterServerEvent('vigne:takeStockItems')
AddEventHandler('vigne:takeStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vigne', function(inventory)
		xPlayer.addInventoryItem(itemName, count)
		inventory.removeItem(itemName, count)
	end)
end)


RegisterServerEvent('vigne:server:reward')
AddEventHandler('vigne:server:reward', function(value, time)
	local _source = source
	local player = ESX.GetPlayerFromId(_source)
	local x,y,z = player.getCoords().x, player.getCoords().y, player.getCoords().z -- faut présciser car heading est retourner aussi et c'est sympa d'utiliser le playerObecjet pour une fois x)
	if Config.Zones.Farming[value] then
		local distance = #(vector3(x,y,z) - Config.Zones.Farming[value]) -- vector3(Config.Zones.Farming[value].x, Config.Zones.Farming[value].y, Config.Zones.Farming[value].z)
		if distance > AC.distanceProtect or time < Shared.farmingTime or not time then
			DropPlayer(_source, string.format("%s : tricher détecter", value))
		elseif distance <= 1.2 then
			if not Shared.ESX_LEGACY then
				if value == 'Harvest' then
					local inventoryItem = player.getInventoryItem('grape')
            		if inventoryItem.limit ~= -1 and inventoryItem.count >= Config.maxNumber then
            		    TriggerClientEvent('esx:showNotification', _source, ServerConfig.Notifications.		maxItemInInventory)
            		else
            		    player.addInventoryItem('grape', ServerConfig.countForHarvest)
            		end
				elseif value == 'Treatment' then
            		local inventoryItemHarvest = player.getInventoryItem('grape')
            		local inventoryItem = player.getInventoryItem('wine')
            		if inventoryItem.limit ~= -1 and inventoryItem.count >= Config.maxNumber then
            		    TriggerClientEvent('esx:showNotification', _source, ServerConfig.	Notifications.	maxItemInInventory)
            		elseif inventoryItemHarvest.count <= 5 then
            		    TriggerClientEvent('esx:showNotification', _source, ServerConfig.	Notifications.	playerNeedgrapeForTreatment)
            		else
            		    player.removeInventoryItem('grape', ServerConfig.countRemoveForTreatment)
            		    player.addInventoryItem('wine', ServerConfig.countToAddInventoryForTreatment)
            		end
				end
			else
				if value == 'Harvest' then
					if player.canCarryItem('grape', ServerConfig.countForHarvest) then
						player.addInventoryItem('grape', ServerConfig.countForHarvest)
					else
						player.showNotification('Votre inventaire est pleins!')
					end
				elseif value == 'Treatment' then
					if player.canSwapItem('grape', ServerConfig.countRemoveForTreatment, 'wine', ServerConfig.countToAddInventoryForTreatment) then
						player.removeInventoryItem('grape', ServerConfig.countRemoveForTreatment)
						player.addInventoryItem('wine', ServerConfig.countToAddInventoryForTreatment)
					else
						player.showNotification('Votre inventaire est pleins!')
					end
				end
			end
		end
	end
end)

RegisterServerEvent('vigne:sellWine')
AddEventHandler('vigne:sellWine', function(count, price)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local inventoryItem = xPlayer.getInventoryItem('wine').count
	count = tonumber(count)
	price = tonumber(price)

	for k,v in pairs (Config.Zones.Farming.Sell) do
		local pedCoords, sellPosition = GetEntityCoords(GetPlayerPed(_src)), v.pos
		if #(pedCoords - sellPosition) <= AC.distanceProtect then
			if count > inventoryItem then
				TriggerClientEvent('esx:showNotification', _src, ServerConfig.Notifications.errorPlayerNeedMoreWineForSell)
			else
				xPlayer.removeInventoryItem('wine', count)
				xPlayer.addMoney(price)
				TriggerClientEvent('esx:showNotification', _src, ('Vous avez vendu %s vin rouge'):format(count))
				TriggerClientEvent('esx:showNotification', _src, ('~g~+%s $~s~'):format(price))
			end
		else
			DropPlayer(_src, 'Vigneron : Triche de revente détectée.')
		end
	end
end)