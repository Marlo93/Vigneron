Keys.Register('F6', 'F6', 'Ouvrir le menu vigneron', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
        openMenu()
    end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', ExampleText, '', '', '', MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function openBilling()
	local amount = KeyboardInput('Que voulez-vous faire ?', nil, 5)
	local player, distance = ESX.Game.GetClosestPlayer()
	if player ~= -1 and distance <= 3.0 then
		if amount == nil then
			ESX.ShowNotification('~r~Montant invalide !~s~')
		else
            local playerPed = PlayerPedId()
		    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
		    Citizen.Wait(5000)
			TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_vigne', ('vigne'), amount)
			ESX.ShowNotification('~g~La facture a bien été envoyée.~s~')
		end
	else
		ESX.ShowNotification('Il n\'y a aucun joueur à proximité.')
	end
end

function refreshMoney()
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
        UpdateSocietyvigneMoney(money)
    end, 'vigne')
end

function UpdateSocietyvigneMoney(money)
    vigne_fond = ESX.Math.GroupDigits(money)
end

function getInventory()
    ESX.TriggerServerCallback('vigne:playerinventory', function(inventory)
        all_items = inventory
    end)
end

function getStock()
    ESX.TriggerServerCallback('vigne:getStockItems', function(inventory)
        all_items = inventory
    end)
end

function resetPlayerOutfit()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

function applySkinOutfit(apply)
    TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject
		if skin.sex == 0 then
			uniformObject = apply.clothes['male']
		else
			uniformObject = apply.clothes['female']
		end
		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		end
	end)
end

function UpdateCam(model, coords, heading)
    if model == tempModel then
        return
    else
        if tempVeh ~= nil then
            DeleteEntity(tempVeh)
            tempVeh = nil
        end

        RequestModel(GetHashKey(model))
        while not HasModelLoaded(GetHashKey(model)) do
            Wait(1)
        end
        tempModel = model
        tempVeh = CreateVehicle(GetHashKey(model), coords, heading, 0, 0)
        FreezeEntityPosition(tempVeh, true)
        SetVehicleDoorsLocked(tempVeh, 4)
        SetEntityAlpha(tempVeh, 180, 180)
        local camCoords = GetOffsetFromEntityInWorldCoords(tempVeh, 3.0, 2.0, 2.0)
    end
end

function stopCamera()
    RenderScriptCams(0, 0, 500, 0, 0)
    TriggerEvent("InitCamModulePause", false)
    DeleteEntity(tempVeh)
    tempVeh = nil
    tempModel = nil
    DestroyAllCams(true)
end

function cameraGarageVehicule() 
    for k,v in pairs(Config.Garage.Camera) do
        local cameraVehicle = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cameraVehicle, true)
        SetCamParams(cameraVehicle, v.positionCamera.x, v.positionCamera.y, v.positionCamera.z, 0.0, 0.0, v.positionCamera.w, 42.2442, 0, 1, 1, 2)
        SetCamFov(cameraVehicle, 60.0) --[[ distance (Field Of View) ]]
        RenderScriptCams(true, true --[[ activer l'animation ]], 2000 --[[ temps de l'animation ]], true, true)
    end
end