ESX = nil

Citizen.CreateThread(function(blips)
    while ESX == nil do
        TriggerEvent(Config.getESX, function(object) ESX = object end)
        Wait(10)
    end

    if Config.enableBlip then
        for k,v in pairs (Config.infoBlip.pos) do
            local blip = AddBlipForCoord(v)
            SetBlipSprite(blip, Config.infoBlip.Sprite)
            SetBlipDisplay(blip, Config.infoBlip.Display)
            SetBlipScale(blip, Config.infoBlip.Scale)
            SetBlipColour(blip, Config.infoBlip.Color)
            SetBlipAsShortRange(blip, Config.infoBlip.Range)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.infoBlip.Name)
            EndTextCommandSetBlipName(blip)
        end
    end

    if Config.enableHarvestBlip then
        for k,v in pairs (Config.infoBlip.Harvest.pos) do
            local blip = AddBlipForCoord(v)
            SetBlipSprite(blip, Config.infoBlip.Harvest.Sprite)
            SetBlipDisplay(blip, Config.infoBlip.Harvest.Display)
            SetBlipScale(blip, Config.infoBlip.Harvest.Scale)
            SetBlipColour(blip, Config.infoBlip.Harvest.Color)
            SetBlipAsShortRange(blip, Config.infoBlip.Harvest.Range)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.infoBlip.Harvest.Name)
            EndTextCommandSetBlipName(blip)
        end
    end

    if Config.enableTreatmentBlip then
        for k,v in pairs (Config.infoBlip.Treatment.pos) do
            local blip = AddBlipForCoord(v)
            SetBlipSprite(blip, Config.infoBlip.Treatment.Sprite)
            SetBlipDisplay(blip, Config.infoBlip.Treatment.Display)
            SetBlipScale(blip, Config.infoBlip.Treatment.Scale)
            SetBlipColour(blip, Config.infoBlip.Treatment.Color)
            SetBlipAsShortRange(blip, Config.infoBlip.Treatment.Range)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.infoBlip.Treatment.Name)
            EndTextCommandSetBlipName(blip)
        end
    end

    if Config.enableSellBlip then
        for k,v in pairs (Config.infoBlip.Sell.pos) do
            local blip = AddBlipForCoord(v)
            SetBlipSprite(blip, Config.infoBlip.Sell.Sprite)
            SetBlipDisplay(blip, Config.infoBlip.Sell.Display)
            SetBlipScale(blip, Config.infoBlip.Sell.Scale)
            SetBlipColour(blip, Config.infoBlip.Sell.Color)
            SetBlipAsShortRange(blip, Config.infoBlip.Sell.Range)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.infoBlip.Sell.Name)
            EndTextCommandSetBlipName(blip)
        end
    end

    if Config.enablePed then
        for k,v in pairs (Config.Zones.Farming.Sell) do
            while (not HasModelLoaded(v.pedModel)) do
                RequestModel(v.pedModel)
                Citizen.Wait(1.0)
            end
            local createPed = CreatePed(2, GetHashKey(v.pedModel), v.pedPos, v.pedHeading, 0, 0)
            FreezeEntityPosition(createPed, 1)
            if Config.scenarioPed then
                TaskStartScenarioInPlace(nwPed, Config.scenarioName, 0, false)
            end
            SetEntityInvincible(createPed, true)
            SetBlockingOfNonTemporaryEvents(createPed, 1)
            npc = createPed
        end
    end
end)