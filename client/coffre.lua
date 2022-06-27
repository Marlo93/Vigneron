RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Coffre = {}
Coffre.Toggle = false
function Coffre:Create()
    Coffre.Toggle = true
    mainMenu = RageUI.CreateMenu('Vigne', 'Que voulez-vous faire ?', 50, 200)
    putMenu = RageUI.CreateSubMenu(mainMenu, 'Vigne', 'Que voulez-vous faire ?')
    getMenu = RageUI.CreateSubMenu(mainMenu, 'Vigne', 'Que voulez-vous faire ?')
    mainMenu:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
    putMenu:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
    getMenu:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
    mainMenu.Closed = function()
        Coffre.Toggle = false
    end
end

all_items = {}

function openCoffre()
    Coffre:Create()
    RageUI.Visible(mainMenu, true)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2.0)
            if Coffre.Toggle then

                RageUI.IsVisible(mainMenu, function()

                    FreezeEntityPosition(PlayerPedId(), true)

                    RageUI.Button('Déposer un objet', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            getInventory()
                        end
                    }, putMenu)

                    RageUI.Button('Retirer un objet', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            getStock()
                        end
                    }, getMenu)
                
                end)

                RageUI.IsVisible(putMenu, function()

                    for k,v in pairs (all_items) do
                        RageUI.Button(v.label, nil, {RightLabel = '('..v.nb..')'}, true, {
                            onSelected = function()
                                local deposit = KeyboardInput('Que voulez-vous faire ?', nil, 4)
                                deposit = tonumber(deposit)
                                TriggerServerEvent('vigne:putStockItems', v.item, deposit)
                                getInventory()
                            end
                        })

                    end
                end)

                RageUI.IsVisible(getMenu, function()

                    for k,v in pairs (all_items) do
                        RageUI.Button(v.label, nil, {RightLabel = '('..v.nb..')'}, true, {
                            onSelected = function()
                                local withdraw = KeyboardInput('Que voulez-vous faire ?', nil, 4)
                                withdraw = tonumber(withdraw)
                                if withdraw <= v.nb then
                                    TriggerServerEvent('vigne:takeStockItems', v.item, withdraw)
                                else
                                    ESX.ShowNotification('~r~Vous n\'avez pas assez d\'objets !~s~')
                                end
                                getStock()
                            end
                        })

                    end
                end)

            else
                RageUI.Visible(mainMenu, false)
                RageUI.Visible(putMenu, false)
                RageUI.Visible(getMenu, false)
                if not RageUI.Visible(mainMenu) and not RageUI.Visible(putMenu) and not RageUI.Visible(getMenu) then
                    mainMenu = RMenu:DeleteType('mainMenu', FreezeEntityPosition(PlayerPedId(), false), true)
                end
                return false
            end
        end
    end)
end