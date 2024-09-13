return {
    vehicles = { -- Higher ranks can see the vehicles from ranks below them so you don't need to input the same vehicle into each grade.
        [0] = { -- 0 is the job grade.
            ambulance = 'Ambulance', --@ spawncode | label
        },
        [1] = { },
        [2] = { },
        [3] = { },
        [4] = { }
    },
    heli = {
        [0] = { polmav = 'AIR-1', },
        [1] = { },
        [2] = { },
        [3] = { },
        [4] = { }
    },
    boat = {
        [0] = { dinghy = 'BOAT-1', },
        [1] = { },
        [2] = { },
        [3] = { },
        [4] = { }
    },
    VehicleMods = { -- Sets default cosmetics for job vehicles. Uses lib.setVehicleProperties: https://github.com/overextended/ox_lib/blob/master/resource/vehicleProperties/client.lua#L288
        polmav = {
            extras = { ['1'] = false, ['2'] = true }, -- Examples
            modLivery = 1,
        },
        ambulance = {
            extras = {},
            modLivery = 1,
        }
    },
}