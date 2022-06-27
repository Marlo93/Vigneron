RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local list = {'Ouverture', 'Fermeture', 'Recrutement', 'Personnalisée'}
local listIndex = 1

Menu = {}
Menu.Toggle = false
function Menu:Create()
    Menu.Toggle = true
    mainMenu = RageUI.CreateMenu('Vigne', 'Que voulez-vous faire ?', 50, 200)
    positions = RageUI.CreateSubMenu(mainMenu, 'Vigne', 'Que voulez-vous faire ?')
    mainMenu:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
    mainMenu.Closed = function()
        Menu.Toggle = false
    end
end

function openMenu()
    Menu:Create()
    RageUI.Visible(mainMenu, true)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2.0)
            if Menu.Toggle then

                RageUI.IsVisible(mainMenu, function()

                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    if service then
                        RageUI.Separator('← ~g~Vous êtes en service.~s~ →')
                    else
                        RageUI.Separator('← ~r~Vous n\'êtes pas en service.~s~ →')
                    end

                    RageUI.Checkbox('Prendre son service', nil, service, {}, {
                        onChecked = function()
                            service = true
                        end,
                        onUnChecked = function()
                            service = false
                        end
                    })
                    
                    if service then

                        RageUI.Line()

                        RageUI.List('Annonce', list, listIndex, nil, {}, true, {
                            onSelected = function()
                                if listIndex == 1 then
                                    TriggerServerEvent('vigne:open')
                                elseif listIndex == 2 then
                                    TriggerServerEvent('vigne:close')
                                elseif listIndex == 3 then
                                    TriggerServerEvent('vigne:recruitment')
                                elseif listIndex == 4 then
                                    local announce = KeyboardInput('Que voulez-vous faire ?', nil, 100)
                                    if announce == nil then
                                        ESX.ShowNotification('~r~Vous n\'avez rentré aucun caractère !~s~')
                                    elseif string.len(announce) <= 5 then
                                        ESX.ShowNotification('~r~Vous n\'avez rentré que 5 caractères !~s~')
                                    end
                                    TriggerServerEvent('vigne:custom', announce)
                                end
                            end,
                            onListChange = function(Index)
                                listIndex = Index
                            end
                        })

                        RageUI.Button('Facturer un citoyen', 'Vous devez être proche d\'un joueur.', {RightLabel = '→'}, closestPlayer ~= -1 and closestDistance <= 3.0, {
                            onSelected = function()
                                openBilling()
                            end
                        })

                    end
                end)

            else
                RageUI.Visible(mainMenu, false)
                if not RageUI.Visible(mainMenu) then
                    mainMenu = RMenu:DeleteType('mainMenu', true)
                end
                return false
            end
        end
    end)
end