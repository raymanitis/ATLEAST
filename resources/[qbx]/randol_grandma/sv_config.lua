return {
    checkDead = true,
    locations = { -- Multi location support.
        {coords = vec4(-1361.4050, -758.2765, 22.4829, 309.5480), model = 'ig_mrs_thornhill', name = 'Grandma', busy = false},
    },
    cost = 300,
    moneyType = 'cash', -- cash/bank ('cash' will convert to 'money' for ESX, so keep it as 'cash' if you wanna use cash and let the bridge handle it)
    duration = 10000,
}