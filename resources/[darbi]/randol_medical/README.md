Installation/Handlers/Configuration is now on my docs page for Medical:

https://randolio-development.gitbook.io/randolio/paid-scripts/medical

# Items

# QBCORE/QBOX
```lua
medicalbag = { name = 'medicalbag', label = 'Medical Bag', weight = 500, type = 'item', image = 'medicalbag.png', unique = false, useable = true, shouldClose = true, description = 'A medical bag.' },
```

# ESX/QBOX (ox inv)

```lua
    ['bandage'] = {
		label = 'Bandage',
		weight = 115,
		consume = 0,
		server = {
			export = 'randol_medical.bandage',
		},
	},
	["firstaid"] = {
		label = "First Aid",
		weight = 2000,
		consume = 0,
		stack = true,
		close = true,
		description = "",
		client = { image = "firstaid.png", },
		server = {
			export = 'randol_medical.firstaid',
		},
	},
    ["medicalbag"] = {
		label = "Medical Bag",
		weight = 500,
		consume = 0,
		stack = true,
		close = true,
		description = "A medical bag.",
		client = { image = "medicalbag.png", },
		server = { export = 'randol_medical.medicalbag', },
	},
```

/emsactions - This pulls up a lib menu for EMS to revive, heal, view injuries of the nearest player and manage checkins. Binded to F6 by default.