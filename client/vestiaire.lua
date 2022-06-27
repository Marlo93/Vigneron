RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local civil = false
local service = true

Vestiaire = {}
Vestiaire.Toggle = false
function Vestiaire:Create()
    Vestiaire.Toggle = true
    mainMenu = RageUI.CreateMenu('Vigne', 'Que voulez-vous faire ?', 50, 200)
    mainMenu:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
    mainMenu.Closed = function()
        Vestiaire.Toggle = false
    end
end

function openVestiaire()
    Vestiaire:Create()
    RageUI.Visible(mainMenu, true)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2.0)
            if Vestiaire.Toggle then

                RageUI.IsVisible(mainMenu, function()

                    FreezeEntityPosition(PlayerPedId(), true)

                    RageUI.Button('Reprendre sa tenue de civile', nil, {RightLabel = '→'}, civil, {
                        onSelected = function()
                            civil = false
                            service = true
                            resetPlayerOutfit()
                            TriggerServerEvent('vigne:resetOutfit')
                        end
                    })

                    for k,v in pairs (Config.setOutfit) do
                        RageUI.Button('Prendre sa tenue de vigneron', nil, {RightLabel = '→'}, service, {
                            onSelected = function()
                                civil = true
                                service = false
                                applySkinOutfit(v)
                                TriggerServerEvent('vigne:setOutfit') 
                            end
                        })
                        
                    end
                end)

            else
                RageUI.Visible(mainMenu, false)
                if not RageUI.Visible(mainMenu) then
                    mainMenu = RMenu:DeleteType('mainMenu', FreezeEntityPosition(PlayerPedId(), false), true)
                end
                return false
            end
        end
    end)
end