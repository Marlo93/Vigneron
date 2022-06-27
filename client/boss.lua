RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

vigne_fond = nil

Boss = {}
Boss.Toggle = false
function Boss:Create()
    Boss.Toggle = true
    mainMenu = RageUI.CreateMenu('Vigne', 'Que voulez-vous faire ?', 50, 200)
    mainMenu:SetRectangleBanner(Config.ColorBanner.r, Config.ColorBanner.g, Config.ColorBanner.b, Config.ColorBanner.a)
    mainMenu.Closed = function()
        Boss.Toggle = false
    end
end

function openBoss()
    Boss:Create()
    RageUI.Visible(mainMenu, true)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(2.0)
            if Boss.Toggle then

                RageUI.IsVisible(mainMenu, function()

                    FreezeEntityPosition(PlayerPedId(), true)

                    if vigne_fond then
                        RageUI.Button('Argent de l\'entreprise :', nil, {RightLabel = vigne_fond..'~g~ $~s~'}, true, {
                            onSelected = function()
                            end
                        })

                    end

                    RageUI.Button('Déposer de l\'argent', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local deposit = KeyboardInput('Que voulez-vous faire ?', nil, 50)
                            deposit = tonumber(deposit)
                            if deposit == nil then
                                ESX.ShowNotification('~r~Montant invalide !~s~')
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'vigne', deposit)
                                TriggerServerEvent('vigne:deposit', deposit)
                                refreshMoney()
                            end
                        end
                    })

                    RageUI.Button('Retirer de l\'argent', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local withdraw = KeyboardInput('Que voulez-vous faire ?', nil, 50)
                            withdraw = tonumber(withdraw)
                            if withdraw == nil then
                                ESX.ShowNotification('~r~Montant invalide !~s~')
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'vigne', withdraw)
                                TriggerServerEvent('vigne:withdraw', withdraw)
                                refreshMoney()
                            end
                        end
                    })

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