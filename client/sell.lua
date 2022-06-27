RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

quantity = {wine = ''}

Sell = {}
Sell.Toggle = false
function Sell:Create()
    Sell.Toggle = true
    mainMenu = RageUI.CreateMenu('Vigne', 'Que voulez-vous faire ?', 50, 200)
    mainMenu:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
    mainMenu.Closed = function()
        Sell.Toggle = false
    end
end

function openSell(wine)
    Sell:Create()
    RageUI.Visible(mainMenu, true)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2.0)
            if Sell.Toggle then

                RageUI.IsVisible(mainMenu, function()

                    FreezeEntityPosition(PlayerPedId(), true)

                    RageUI.Button('Vendre votre récolte', nil, {RightLabel = quantity.wine}, true, {
                        onSelected = function()
                            local qty = KeyboardInput('Que voulez-vous faire ?', nil, 2)
                            if qty ~= '' and tonumber(qty) ~= nil then
                                quantity.wine = qty
                                indicator = true
                            else
                                ESX.ShowNotification(Config.Zones.Farming.errorInput)
                            end
                        end
                    })

                    if indicator then
                        local price = (quantity.wine * Config.sellingPrice)
                        RageUI.Button('Prix de revente', nil, {RightLabel = price..'~g~$~s~'}, true, {})

                        RageUI.Button('Confirmer la revente', ('Si tu confirmes la revente, je te passerai %s ~g~$~s~ en cash direct !'):format(price, Config.sellingPrice), {RightBadge = RageUI.BadgeStyle.Tick, Color = { HightLightColor = {39, 227, 45, 160}, BackgroundColor = {39, 227, 45, 160} }}, true, {
                            onSelected = function()
                                TriggerServerEvent('vigne:sellWine', quantity.wine, price)
                            end
                        })
                    end
                end)

            else
                RageUI.Visible(mainMenu, false)
                if not RageUI.Visible(mainMenu) then
                    mainMenu = RMenu:DeleteType('mainMenu', FreezeEntityPosition(PlayerPedId(), false), true)
                    quantity.wine = ''
                    indicator = false
                end
                return false
            end
        end
    end)
end
