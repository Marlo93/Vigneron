RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Garage = {}
Garage.Toggle = false
function Garage:Create()
    Garage.Toggle = true
    mainMenu = RageUI.CreateMenu('Vigne', 'Que voulez-vous faire ?', 50, 200)
    mainMenu:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
    mainMenu.Closed = function()
        Garage.Toggle = false
    end
end

function openGarage()
    Garage:Create()
    RageUI.Visible(mainMenu, true)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2.0)
            if Garage.Toggle then

                RageUI.IsVisible(mainMenu, function()

                    cameraGarageVehicule()
                    FreezeEntityPosition(PlayerPedId(), true)

                    for k,v in pairs (Config.Garage.Vehicles) do
                        RageUI.Button(v.label, nil, {RightBadge = RageUI.BadgeStyle.Car}, true, {
                            onActive = function()
                                UpdateCam(v.name , v.spawnPoint)
                            end,
                            onSelected = function()
                                local model = GetHashKey(v.name)
                                RequestModel(model)
                                while not HasModelLoaded(model) do Citizen.Wait(10) end
                                DoScreenFadeOut(1000)
                                Wait(1000)
                                local vehicle = CreateVehicle(model, v.spawnPoint, true, false)
                                SetVehicleNumberPlateText(vehicle..math.random(50, 999))
                                SetVehRadioStation(vehicle, false)
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                DoScreenFadeIn(1000)
                                RageUI.CloseAll()
                            end
                        })
                    end
                end)

                else
                    RageUI.Visible(mainMenu, false)
                    if not RageUI.Visible(mainMenu) then
                        mainMenu = RMenu:DeleteType('mainMenu', stopCamera(), FreezeEntityPosition(PlayerPedId(), false), true)
                    end
                    return false
                end
            end
        end)
    end