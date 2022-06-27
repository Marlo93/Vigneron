Config = {
    getESX = 'esx:getSharedObject',
    ColorBanner = {r = 77, g = 18, b = 72, a = 170},
    enableBlip = true, -- Enable/Disable Blip / true/false
    enableHarvestBlip = true, -- Enable/Disable Blip / true/false
    enableTreatmentBlip = true, -- Enable/Disable Blip / true/false
    enableSellBlip = true, -- Enable/Disable Blip / true/false
    enablePed = true, -- Enable/Disable Ped / true/false
    scenarioPed = true, -- Enable/Disable Scenario / True/false
    scenarioName = 'WORLD_HUMAN_CLIPBOARD', -- https://wiki.rage.mp/index.php?title=Scenarios
    antiMoonwalk = false, -- (Le moonwalk permet de récolter plus vite.)
    maxNumber = 50, -- Maximum de raisin et de vin rouge que l'on peut récolter et avoir sur soi.
    sellingPrice = 200, -- Montant du vin rouge unité. (Prix de revente.)

    infoBlip = { -- --> https://docs.fivem.net/docs/game-references/blips/
        Name = '[Entreprise] - Vigneron',
        Sprite = 85,
        Display = 4,
        Scale = 0.8,
        Color = 50,
        Range = true,
        pos = {vector3(-1891.187, 2045.96, 140.96)},

        Harvest = {
            Name = '[Vigneron] - Récolte [1/3]',
            Sprite = 615,
            Display = 4,
            Scale = 0.8,
            Color = 27,
            Range = true,
            pos = {vector3(-1878.61, 2119.04, 131.74)},
        },

        Treatment = {
            Name = '[Vigneron] - Traitement [2/3]',
            Sprite = 615,
            Display = 4,
            Scale = 0.8,
            Color = 27,
            Range = true,
            pos = {vector3(-1454.02, -386.43, 37.20)},
        },
        
        Sell = {
            Name = '[Vigneron] - Revente [3/3]',
            Sprite = 615,
            Display = 4,
            Scale = 0.8,
            Color = 27,
            Range = true,
            pos = {vector3(342.84, -1298.97, 31.51)},
        }
    },

    infoMarker = {
        Type = 21,
        Size = {0.6, 0.6, 0.6},
        Color = {77, 18, 72},
        Rotation = true,
    },

    interactionText = {
        Boss = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder à la gestion de votre entreprise.',
        Coffre = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au stock.',
        Garage = 'Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule.',
        Harvest = 'Appuyez sur ~INPUT_CONTEXT~ pour récolter du raisin.',
        Treatment = 'Appuyez sur ~INPUT_CONTEXT~ pour traiter du raisin.',
        Sell = 'Appuyez sur ~INPUT_CONTEXT~ pour vendre votre vin.',
        Vestiaire = 'Appuyez sur ~INPUT_CONTEXT~ pour changer votre tenue.',
    },

    Garage = {
        spawnPointNotClear = '~r~Il y a déjà un véhicule ici !~s~',
        Vehicles = {
            {label = 'Bison', name = 'bison3', spawnPoint = vector4(-1920.85, 2048.92, 139.73, 258.06)},
            {label = 'Limousine', name = 'stretch', spawnPoint = vector4(-1920.85, 2048.92, 139.73, 258.06)},
        },
        Camera = {
            {positionCamera = vector4(-1914.66, 2051.18, 141.73, 120.76)},
        },
    },

    Zones = {
        Boss = {vector3(-1875.674, 2060.781, 145.5737)},
        Coffre = {vector3(-1868.463, 2066.209, 140.9768)},
        Garage = {vector3(-1928.72, 2060.15, 139.83+1)},
        Vestiaire = {vector3(-1881.376, 2061.168, 140.984)},

        Farming = {
            errorInput = '~r~Il semblerait que vous n\'ayez rentré aucune valeur.',
            playerDistance = {
                Harvest = '~r~Vous êtes trop loin de la zone de récolte !~s~',
                Treatment = '~r~Vous êtes trop loin de la zone de traitement !~s~',
            },
            Harvest = vector3(-1878.61, 2119.04, 131.74+1),
            Treatment = vector3(-1454.02, -386.43, 37.20+1),
            Sell = {
                {pos = vector3(342.84, -1298.97, 31.51), pedPos = vector3(343.1142, -1298.196, 32.51031-1), pedHeading = 158.6653, pedModel = 'csb_bryony'} -- https://docs.fivem.net/docs/game-references/ped-models/
            },
        },
    },

    setOutfit = {
        [0] = {
            clothes = {
                ['male'] = {
                    bags_1 = 0, bags_2 = 0,
                    tshirt_1 = 15, tshirt_2 = 0,
                    torso_1 = 13, torso_2 = 5,
                    arms = 11,
                    pants_1 = 35, pants_2 = 0,
                    shoes_1 = 7, shoes_2 = 2,
                    mask_1 = 0, mask_2 = 0,
                    bproof_1 = 0, bproof_2 = 0,
                    helmet_1 = -1, helmet_2 = 0,
                    chain_1 = 0, chain_2 = 0,
                    decals_1 = 0, decals_2 = 0,
                },
                ['female'] = {
                    bags_1 = 0, bags_2 = 0,
                    tshirt_1 = 38, tshirt_2 = 2,
                    torso_1 = 25, torso_2 = 7,
                    arms = 3,
                    pants_1 = 34, pants_2 = 0,
                    shoes_1 = 6, shoes_2 = 0,
                    mask_1 = 0, mask_2 = 0,
                    bproof_1 = 0, bproof_2 = 0,
                    helmet_1 = -1, helmet_2 = 0,
                    chain_1 = 0, chain_2 = 2,
                    decals_1 = 0, decals_2 = 0
                },
            },
        },
    },
}
