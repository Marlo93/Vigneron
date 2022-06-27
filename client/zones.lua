playerFarming = false
local GUI = {}
local vigneron <const> = 'vigne'

Citizen.CreateThread(function() -- boss
    while true do
        Citizen.Wait(1.0)
        local interval = true
        local pedCoords = GetEntityCoords(PlayerPedId())
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
            for i = 1, #Config.Zones.Boss do
                local distance = #(pedCoords - Config.Zones.Boss[i]) 
                if distance < 10.0 then interval = false
                    if not Boss.Toggle then
                        DrawMarker(Config.infoMarker.Type, Config.Zones.Boss[i], 0, 0, 0, Config.infoMarker.Rotation, nil, nil, Config.infoMarker.Size[1], Config.infoMarker.Size[2], Config.infoMarker.Size[3], Config.infoMarker.Color[1], Config.infoMarker.Color[2], Config.infoMarker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    end
                    if distance <= 3.0 then
                        if not Boss.Toggle then
                            ESX.ShowHelpNotification(Config.interactionText.Boss)
                            if IsControlJustPressed(1, 51) then
                                openBoss()
                            end
                        end
                    end
                else
                    Boss.Toggle = false
                end
            end
        end
        if interval then
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function() -- coffre
    while true do
        Citizen.Wait(1.0)
        local interval = true
        local pedCoords = GetEntityCoords(PlayerPedId())
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
            for i = 1, #Config.Zones.Coffre do
                local distance = #(pedCoords - Config.Zones.Coffre[i]) 
                if distance < 10.0 then interval = false
                    if not Coffre.Toggle then
                        DrawMarker(Config.infoMarker.Type, Config.Zones.Coffre[i], 0, 0, 0, Config.infoMarker.Rotation, nil, nil, Config.infoMarker.Size[1], Config.infoMarker.Size[2], Config.infoMarker.Size[3], Config.infoMarker.Color[1], Config.infoMarker.Color[2], Config.infoMarker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    end
                    if distance <= 3.0 then
                        if not Coffre.Toggle then
                            ESX.ShowHelpNotification(Config.interactionText.Coffre)
                            if IsControlJustPressed(1, 51) then
                                openCoffre()
                            end
                        end
                    end
                else
                    Coffre.Toggle = false
                end
            end
        end
        if interval then
            Citizen.Wait(500)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        local interval = true
        if ESX.PlayerData.job and ESX.PlayerData.job.name == vigneron then
            local pedCoords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(Config.Zones.Farming) do
                if k == 'Harvest' or k == 'Treatment' then
                    local distance = #(pedCoords - v)
                    if distance <= 9.0 then interval = false
                        DrawMarker(Config.infoMarker.Type, interactionPos, 0, 0, 0, Config.infoMarker.Rotation, nil, nil, Config.infoMarker.Size[1], Config.infoMarker.Size[2], Config.infoMarker.Size[3], Config.infoMarker.Color[1], Config.infoMarker.Color[2], Config.infoMarker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if distance <= 1.2 then
                            if not playerFarming then
                                ESX.ShowHelpNotification(Config.interactionText[k])
                            end
                            if not playerFarming and IsControlJustPressed(1, 51) and IsPedOnFoot(PlayerPedId()) then
                                playerFarming = true
                                GUI.Time = GetGameTimer()
                            end
                            if playerFarming then
                                if (GetGameTimer() - GUI.Time > Shared.farmingTime) then
                                    TriggerServerEvent('vigne:server:reward', k, (GetGameTimer() - GUI.Time))
                                    GUI.Time = GetGameTimer()
                                end
                            end
                        else
                            playerFarming = false
                            GUI.Time = 0
                        end
                    end
                end
            end
        end
        if interval then
            Wait(500)
        end
    end
end) 


Citizen.CreateThread(function() -- garage
    while true do
        Citizen.Wait(1.0)
        local interval = true
        local pedCoords = GetEntityCoords(PlayerPedId())
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
            for i = 1, #Config.Zones.Garage do
                local distance = #(pedCoords - Config.Zones.Garage[i]) 
                if distance < 10.0 then interval = false
                    if not Garage.Toggle then
                        DrawMarker(Config.infoMarker.Type, Config.Zones.Garage[i], 0, 0, 0, Config.infoMarker.Rotation, nil, nil, Config.infoMarker.Size[1], Config.infoMarker.Size[2], Config.infoMarker.Size[3], Config.infoMarker.Color[1], Config.infoMarker.Color[2], Config.infoMarker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    end
                    if distance <= 3.0 then
                        if not Garage.Toggle then
                            ESX.ShowHelpNotification(Config.interactionText.Garage)
                            if IsControlJustPressed(1, 51) then
                                openGarage()
                            end
                        end
                    end
                else
                    Garage.Toggle = false
                end
            end
        end
        if interval then
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function() -- Farming vente
    while true do
        local interval = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
            for k,v in pairs (Config.Zones.Farming.Sell) do
                local pedCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
                if #(pedCoords-interactionPos) < 2.0 then
                    interval = 0
                    ESX.ShowHelpNotification(Config.interactionText.Sell)
                    if IsControlJustPressed(1, 51) and IsPedOnFoot(PlayerPedId()) then
                        PlayAmbientSpeech1(npc, "GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                        openSell(wine)
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

Citizen.CreateThread(function() -- Cloakroom
    while true do
        Citizen.Wait(1.0)
        local interval = true
        local pedCoords = GetEntityCoords(PlayerPedId())
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigne' then
            for i = 1, #Config.Zones.Vestiaire do
                local distance = #(pedCoords - Config.Zones.Vestiaire[i]) 
                if distance < 10.0 then interval = false
                    if not Vestiaire.Toggle then
                        DrawMarker(Config.infoMarker.Type, Config.Zones.Vestiaire[i], 0, 0, 0, Config.infoMarker.Rotation, nil, nil, Config.infoMarker.Size[1], Config.infoMarker.Size[2], Config.infoMarker.Size[3], Config.infoMarker.Color[1], Config.infoMarker.Color[2], Config.infoMarker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    end
                    if distance <= 3.0 then
                        if not Vestiaire.Toggle then
                            ESX.ShowHelpNotification(Config.interactionText.Vestiaire)
                            if IsControlJustPressed(1, 51) then
                                openVestiaire()
                            end
                        end
                    end
                else
                    Vestiaire.Toggle = false
                end
            end
        end
        if interval then
            Citizen.Wait(500)
        end
    end
end)