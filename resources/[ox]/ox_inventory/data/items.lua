return {
	-- ['testburger'] = {
	-- 	label = 'Test Burger',
	-- 	weight = 220,
	-- 	degrade = 60,
	-- 	client = {
	-- 		image = 'burger_chicken.png',
	-- 		status = { hunger = 200000 },
	-- 		anim = 'eating',
	-- 		prop = 'burger',
	-- 		usetime = 2500,
	-- 		export = 'ox_inventory_examples.testburger'
	-- 	},
	-- 	server = {
	-- 		export = 'ox_inventory_examples.testburger',
	-- 		test = 'what an amazingly delicious burger, amirite?'
	-- 	},
	-- 	buttons = {
	-- 		{
	-- 			label = 'Lick it',
	-- 			action = function(slot)
	-- 				print('You licked the burger')
	-- 			end
	-- 		},
	-- 		{
	-- 			label = 'Squeeze it',
	-- 			action = function(slot)
	-- 				print('You squeezed the burger :(')
	-- 			end
	-- 		},
	-- 		{
	-- 			label = 'What do you call a vegan burger?',
	-- 			group = 'Hamburger Puns',
	-- 			action = function(slot)
	-- 				print('A misteak.')
	-- 			end
	-- 		},
	-- 		{
	-- 			label = 'What do frogs like to eat with their hamburgers?',
	-- 			group = 'Hamburger Puns',
	-- 			action = function(slot)
	-- 				print('French flies.')
	-- 			end
	-- 		},
	-- 		{
	-- 			label = 'Why were the burger and fries running?',
	-- 			group = 'Hamburger Puns',
	-- 			action = function(slot)
	-- 				print('Because they\'re fast food.')
	-- 			end
	-- 		}
	-- 	},
	-- 	consume = 0.3
	-- },

	['bandage'] = {
		label = 'Pārsējs',
		weight = 115,
		consume = 0,
		description = "Pārsējs dziedināšanai.",
		server = {
			export = 'randol_medical.bandage',
		},
	},
	-- Add these items below if you wish to use them.
	["firstaid"] = {
		label = "First Aid",
		weight = 2000,
		stack = true,
		close = true,
		description = "",
		consume = 0,
		client = { image = "firstaid.png", },
		server = {
			export = 'randol_medical.firstaid',
		},
	},
	["medicalbag"] = {
		label = "Medical Bag",
		weight = 500,
		stack = true,
		close = true,
		consume = 0,
		description = "A medical bag.",
		client = { image = "medicalbag.png", },
		server = { export = 'randol_medical.medicalbag', },
	},

	

	["handcuffs"] = {
		label = "Rokudzelži",
		weight = 100,
		stack = true,
		close = true,
		description = "Noder, ja cilvēki slikti uzvedas. Varbūt to var izmantot kaut kam citam?",
		client = {
			image = "handcuffs.png",
		}
	},

	['black_money'] = {
		label = 'Netīrās naudas rullis',
	},

	['contract'] = {
		label = 'Līgums',
		weight = 100,
		stack = true
	},

	['burger'] = {
		label = 'Siera burgers',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'ēst',
			prop = 'burgers',
			usetime = 2500,
			notification = 'Tu apēdi gardu burgeru'
		}
	},

	['sprunk'] = {
		label = 'Sprunks',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'Tu veldzēji savu slāpes ar sprunku'
		}
	},

	['parachute'] = {
		label = 'Izpletnis',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Atkritumi',
	},

	['paperbag'] = {
		label = 'Papīra Maisiņš',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['id_card'] = {
		label = 'ID karte',
		weight = 0,
		stack = false,
		close = false,
		client = {
			image = 'id_card.png'
		}
	}, 

	['panties'] = {
		label = 'Biksītes',
		weight = 10,
		consume = 0,
		description = "Kādas sievietes biksītes",
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Mūķīzeris',
		weight = 160,
		client = {
			event = 'lockpick:use'
		}
	},

	['vehiclekey'] = {
		label = 'Transportlīdzekļa atslēga'
	},
	
	["phone"] = {
		label = "Telefons",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},


	['money'] = {
		label = 'Nauda',
	},

	['mustard'] = {
		label = 'Sinepes',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'Tu izdzēri sinepes'
		}
	},

	['radio'] = {
		label = 'Rācija',
		weight = 1000,
		stack = false,
		allowArmed = true
	},

	['lightarmor'] = {
        label = 'Viegla bruņuveste',
        weight = 2000,
        stack = true,
        close = true,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500,
			image = "bodyarmor_1.png",
        }    
    },
    ['heavyarmor'] = {
        label = 'Smagā bruņuveste',
        weight = 5000,
        stack = false,
        close = true,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500,
			image = "bodyarmor_2.png",
        }
    },
    ['armor'] = {
        label = 'Bruņuveste',
        weight = 3000,
        stack = false,
        close = true,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
        }    
    },

	['clothing'] = {
		label = 'Apģērbs',
		consume = 0,
	},

	['audums'] = {
		label = 'Audums',
		weight = 50,
		description = "Auduma gabals",
	},

	['vadi'] = {
		label = 'Vadi',
		weight = 50,
		description = "Vadi no kādas elektro iekārtas.",
	},

	['woodplank'] = {
		label = 'Koka dēlis',
		weight = 50,
	},

	['display'] = {
		label = 'Mazs displejs',
		weight = 50,
	},
	['diegs'] = {
		label = 'Diega kamols',
		weight = 50,
	},
	

	-- ["armor"] = {
	-- 	label = "Bruņas",
	-- 	weight = 5000,
	-- 	stack = true,
	-- 	close = true,
	-- 	description = "Nedaudz aizsardzības nekaitēs... vai ne?",
	-- 	client = {
	-- 		image = "armor.png",
	-- 	}
	-- },

	["driver_license"] = {
		label = "Vadītāja apliecība",
		weight = 0,
		stack = false,
		close = false,
		description = "Atļauja, kas pierāda, ka vari vadīt transportlīdzekli",
		client = {
			image = "driver_license.png",
		}
	},

	["grapejuice"] = {
		label = "Vīnogu Sula",
		weight = 200,
		stack = true,
		close = false,
		description = "Vīnogu sula ir teikts, ka tā ir veselīga",
		client = {
			image = "grapejuice.png",
		}
	},

	["radioscanner"] = {
		label = "Radio Skeneris",
		weight = 1000,
		stack = true,
		close = true,
		description = "Ar šo tu vari saņemt dažus policijas ziņojumus. Nav 100% efektīvs",
		client = {
			image = "radioscanner.png",
		}
	},
	------------------------------

	
	["diving_gear"] = {
		label = "Niršanas aprīkojums",
		weight = 30000,
		stack = false,
		close = true,
		description = "Pilns aprīkojums lai dodos nirt!",
		client = {
			image = "diving_gear.png",
		}
	},

	
	["drill"] = {
		label = "Urbis",
		weight = 20000,
		stack = true,
		close = false,
		description = "Izurbsi ar šito caurumu jebkur...",
		client = {
			image = "drill.png",
		}
	},
	
	["vodka"] = {
		label = "Degvīns",
		weight = 500,
		stack = true,
		close = true,
		description = "Visiem izslāpušajiem garšos!",
		client = {
			image = "vodka.png",
		}
	},
	
	-- ["casinochips"] = {
	-- 	label = "Kazino žetoni",
	-- 	weight = 0,
	-- 	stack = true,
	-- 	close = false,
	-- 	description = "Žetoni kazino spēlēšanai",
	-- 	client = {
	-- 		image = "casinochips.png",
	-- 	}
	-- },
	
	["printerdocument"] = {
		label = "Dokuments",
		weight = 500,
		stack = false,
		close = true,
		description = "Printera dokuments.",
		client = {
			image = "printerdocument.png",
		}
	},
	
	-- ["weed_purple-haze"] = {
	-- 	label = "Purple Haze 2g",
	-- 	weight = 200,
	-- 	stack = true,
	-- 	close = false,
	-- 	description = "Marihuānas paciņa ar 2g Purple Haze.",
	-- 	client = {
	-- 		image = "weed_baggy.png",
	-- 	}
	-- },
	
	["laptop"] = {
		label = "Klēpjdators",
		weight = 4000,
		stack = true,
		close = true,
		description = "Dārgs klēpjdators",
		client = {
			image = "laptop.png",
		}
	},
	
	["racing_gps"] = {
		label = "Sacīkšu GPS",
		weight = 1000,
		stack = true,
		close = true,
		description = "Sacīkšu GPS",
		client = {
			image = "racing_gps.png",
		}
	},
	
	["painkillers"] = {
		label = "Pretsāpju līdzekļi",
		weight = 0,
		stack = true,
		close = true,
		description = "Ja sāpes ir neciešamas, lietojiet šo tableti, lai justos lieliski",
		client = {
			image = "painkillers.png",
		}
	},
	
	["weed_nutrition"] = {
		label = "Augu mēslojums",
		weight = 2000,
		stack = true,
		close = true,
		description = "Augu uzturvielas",
		client = {
			image = "weed_nutrition.png",
		}
	},
	
	["ifaks"] = {
		label = "Ifaks",
		weight = 200,
		stack = true,
		close = true,
		description = "Ifaks dziedināšanai un stresa noņemšanai",
		client = {
			image = "ifaks.png",
		}
	},
	
	["empty_weed_bag"] = {
		label = "Tukša marihuānas paciņa",
		weight = 0,
		stack = true,
		close = true,
		description = "Mazā tukša paciņa",
		client = {
			image = "weed_baggy_empty.png",
		}
	},
	
	["advancedlockpick"] = {
		label = "Uzlabots slēdzenes lauzējs",
		weight = 500,
		stack = true,
		close = true,
		description = "Ja bieži zaudējat atslēgas, tas ir ļoti noderīgi... Arī noderīgs alus atvēršanai",
		client = {
			event = 'lockpick:use'
		}
	},
	
	-- ["labkey"] = {
	-- 	label = "Atslēga",
	-- 	weight = 500,
	-- 	stack = false,
	-- 	close = true,
	-- 	description = "Atslēga no slēdzenes...?",
	-- 	client = {
	-- 		image = "labkey.png",
	-- 	}
	-- },
	
	["snikkel_candy"] = {
		label = "Snikkel",
		weight = 100,
		stack = true,
		close = true,
		description = "Garšīga konfekte :O nam nam",
		client = {
			image = "snikkel_candy.png",
		}
	},
	
	["ironoxide"] = {
		label = "Dzelzs pulveris",
		weight = 100,
		stack = true,
		close = false,
		description = "Pulveris sajaukšanai",
		client = {
			image = "ironoxide.png",
		}
	},
	
	["firstaid"] = {
		label = "Pirmās palīdzības komplekts",
		weight = 2500,
		stack = true,
		close = true,
		description = "Pirmās palīdzības komplekts.",
		client = {
			image = "firstaid.png",
		}
	},
	
	["diamond_ring"] = {
		label = "Dimanta gredzens",
		weight = 1500,
		stack = true,
		close = true,
		description = "Dimanta gredzens tavai beibei!",
		client = {
			image = "diamond_ring.png",
		}
	},

	["goldchain"] = {
		label = "Zelta ķēde",
		weight = 1500,
		stack = true,
		close = true,
		description = "Ar šo būsi riktīgs gangsteris!",
		client = {
			image = "goldchain.png",
		}
	},
	
	["tirekit"] = {
        label = "Tire Kit",
        weight = 250,
        stack = true,
        close = true,
        description = "A nice toolbox with stuff to repair your tire",
        client = {
            image = "tirekit.png",
        },
        server = {
            export = 'vehiclehandler.tirekit'
        }
    },

    ["repairkit"] = {
        label = "Remonta komplekts",
        weight = 2500,
        stack = true,
        close = true,
        description = "Remonta komplekts ar daudz un dažādiem darbarīkiem",
        client = {
            image = "repairkit.png",
        },
    },

    ["advancedrepairkit"] = {
        label = "Advencēts remonta komplekts",
        weight = 5000,
        stack = true,
        close = true,
        description = "Remonta komplekts ar daudz un dažādiem darbarīkiem",
        client = {
            image = "advancedrepairkit.png",
        },
    },
	
	["screwdriverset"] = {
		label = "Instrumentu komplekts",
		weight = 1000,
		stack = true,
		close = false,
		description = "Ļoti noderīgs skrūvju ieskrūvēšanai...",
		client = {
			image = "screwdriverset.png",
		}
	},
	
	["firework4"] = {
		label = "Raudas Vītols",
		weight = 1000,
		stack = true,
		close = true,
		description = "Pirotehnika",
		client = {
			image = "firework4.png",
		}
	},
	
	["tosti"] = {
		label = "Grilēta siera sviestmaize",
		weight = 200,
		stack = true,
		close = true,
		description = "Gardā siera maizīte.",
		client = {
			image = "tosti.png",
		}
	},
	
	["xtcbaggy"] = {
		label = "XTC paciņa",
		weight = 0,
		stack = true,
		close = true,
		description = "Foršas ripas.",
		client = {
			image = "xtc_baggy.png",
		}
	},
	
	["samsungphone"] = {
		label = "Samsung S10",
		weight = 1000,
		stack = true,
		close = true,
		description = "Tu man zvani uz man samsung.",
		client = {
			image = "samsungphone.png",
		}
	},
	
	["oxy"] = {
		label = "Receptē izrakstīts Oxy",
		weight = 0,
		stack = true,
		close = true,
		description = "Etiķete ir norauta",
		client = {
			image = "oxy.png",
		}
	},
	
	["beer"] = {
		label = "Alus",
		weight = 500,
		stack = true,
		close = true,
		description = "Nekas nav tik labs kā auksts alus!",
		client = {
			image = "beer.png",
		}
	},
	
	["iron"] = {
		label = "Dzelzs",
		weight = 1000,
		stack = true,
		close = true,
		description = "Svarīgs materiāls dažādiem izstrādājumiem.",
		client = {
			image = "iron.png",
		}
	},


	----- PICAS
	----- PICAS
	----- PICAS
	----- PICAS

	['pizza_pep'] = { -- A simple sandwich for a simple day
        label = 'Peperoni Pica',
        weight = 350,
        stack = true,
        close = true,
        description = "Kurš uzlika sieru uz manas picas?",
        client = {
            status = { hunger = 200000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'knjgh_pizzaslice5', 
            pos = vec3(0.0500, -0.0300, -0.0700), 
            rot = vec3(300.0, -10.0, 160.0),
            bone = 60309 },
            usetime = 7500,
        },
    },

    ['pizza_chs'] = { -- A simple sandwich for a simple day
        label = 'Siera Pica',
        weight = 350,
        stack = true,
        close = true,
        description = "Vai pietiek ar sieru? Nē...",
        client = {
            status = { hunger = 200000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'knjgh_pizzaslice4', 
            pos = vec3(0.0500, -0.0300, -0.0700), 
            rot = vec3(300.0, -10.0, 160.0),
            bone = 60309 },
            usetime = 7500,
        },
    },

    ['pizza_msh'] = { -- A simple sandwich for a simple day
        label = 'Sēņu Pica',
        weight = 350,
        stack = true,
        close = true,
        description = "Sēnes uz manas picas? Kurš par to domāja?",
        client = {
            status = { hunger = 200000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'knjgh_pizzaslice3', 
            pos = vec3(0.0500, -0.0300, -0.0700), 
            rot = vec3(300.0, -10.0, 160.0),
            bone = 60309 },
            usetime = 7500,
        },
    },

    ['pizza_mgt'] = { -- A simple sandwich for a simple day
        label = 'Margeritas Pica',
        weight = 350,
        stack = true,
        close = true,
        description = "Es domāju ka šajā picā ir alkohols...",
        client = {
            status = { hunger = 200000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'knjgh_pizzaslice2', 
            pos = vec3(0.0500, -0.0300, -0.0700), 
            rot = vec3(300.0, -10.0, 160.0),
            bone = 60309 },
            usetime = 7500,
        },
    },

    ['pizza_dmt'] = { -- A simple sandwich for a simple day
        label = 'Dubultās Gaļas Pica',
        weight = 350,
        stack = true,
        close = true,
        description = "Kad ar vienu gaļu nepietiek un ar 3 ir dīvaini...",
        client = {
            status = { hunger = 200000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'knjgh_pizzaslice1', 
            pos = vec3(0.0500, -0.0300, -0.0700), 
            rot = vec3(300.0, -10.0, 160.0),
            bone = 60309 },
            usetime = 7500,
        },
    },

	----- BURGERI
	----- BURGERI
	----- BURGERI
	----- BURGERI

	['burger'] = { -- A test hamburger that you can eat
        label = 'Hamburgers',
        weight = 350,
        stack = true,
        close = true,
        description = "Nebija naudas? :D",
        client = {
            status = { hunger = 230000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'prop_cs_burger_01', 
            pos = vec3(0.05, -0.02, -0.03), rot = vec3(150.0, 340.0, 170.0) },
            usetime = 7500,
        },
    },

    ['burger_chs'] = { -- A test hamburger that you can eat
        label = 'Siera Burgers',
        weight = 350,
        stack = true,
        close = true,
        description = "Mazais burgeris.",
        client = {
            status = { hunger = 230000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'prop_cs_burger_01', 
            pos = vec3(0.05, -0.02, -0.03), rot = vec3(150.0, 340.0, 170.0) },
            usetime = 7500,
        },
    },

    ['burger_chsbcn'] = { -- A test hamburger that you can eat
        label = 'BekonSiera burgers',
        weight = 350,
        stack = true,
        close = true,
        description = "Ar sieru un bekonu.",
        client = {
            status = { hunger = 230000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'prop_cs_burger_01', 
            pos = vec3(0.05, -0.02, -0.03), rot = vec3(150.0, 340.0, 170.0) },
            usetime = 7500,
        },
    },


	--- CITI FAST BOOD
	--- CITI FAST BOOD
	--- CITI FAST BOOD
	--- CITI FAST BOOD

	['hotdog'] = { -- A test hamburger that you can eat
        label = 'Hotdogs',
        weight = 350,
        stack = true,
        close = true,
        description = "Nav gatavots ar īstiem suņiem vai gaļu...",
        client = {
            status = { hunger = 230000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'prop_cs_hotdog_01', 
            pos = vec3(0.06, -0.01, -0.03), rot = vec3(60.0, -90.0, 0.0) },
            usetime = 7500,
        },
    },

    ['noodles'] = { -- Fuck those baked shits are good af
        label = 'Taizemes nūdeles',
        weight = 350,
        stack = true,
        close = true,
        description = "Taizemes nūdeles, sarullē un ēd..",
        client = {
            status = { hunger = 160000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'v_ret_fh_noodle', 
            pos = vec3(-0.03, 0.01, 0.05), 
            rot = vec3(0.0, 0.0, -40.0) },
            usetime = 7500,
        },
    },

    ['fr_fries'] = { -- A test hamburger that you can eat
        label = 'Frī Kartupeļi',
        weight = 350,
        stack = true,
        close = true,
        description = "Frī Kartupeļi",
        client = {
            status = { hunger = 120000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'prop_food_chips', 
            pos = vec3(-0.01, 0.0, -0.02), rot = vec3(0.0, 0.0, -45.0) },
            usetime = 5000,
        },
    },


	--- SNACKS
	--- SNACKS
	--- SNACKS

	['phatc_rib'] = { -- A skeletons favorite snack
        label = 'Ribiņas',
        weight = 350,
        stack = true,
        close = true,
        description = "Ribiņas",
        client = {
            status = { hunger = 120000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'ng_proc_food_chips01b', 
            pos = vec3(0.0, 0.08, 0.05), rot = vec3(90.0, 0.0, -45.0) },
            usetime = 5000,
        },
    },

    ['phatc_bch'] = { -- Biggie Cheese
        label = 'Čipsi ar sieru',
        weight = 350,
        stack = true,
        close = true,
        description = "Siera garšas čipsi, gatavoti ar īstām žurkām.",
        client = {
            status = { hunger = 120000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'ng_proc_food_chips01a', 
            pos = vec3(0.0, 0.08, 0.05), rot = vec3(90.0, 0.0, -45.0) },
            usetime = 5000,
        },
    },

    ['ps_qs'] = { -- is that candy
        label = 'Mēles Diskotēka',
        weight = 350,
        stack = true,
        close = true,
        description = "Konfektes liek mēlei iet brrrr..",
        client = {
            status = { hunger = 650000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'prop_candy_pqs', 
            pos = vec3(0.0, 0.02, 0.05), rot = vec3(90.0, 0.0, -45.0) },
            usetime = 5000,
        },
    },

	-- deserti
	-- DESERTI
	--DESERTI

	-- FOOD: Deserts

    ['donut_chc'] = { -- Fuck those baked shits are good af
        label = 'Šokolādes virtulis',
        weight = 350,
        stack = true,
        close = true,
        description = "Mmmmm , šokolāde",
        client = {
            status = { hunger = 150000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_foodpack_donut002', 
            bone = 18905,
            pos = vec3(0.13, 0.050, 0.020), 
            rot = vec3(-50.0, 100.0, 270.0) },
            usetime = 7500,
        },
    },

    ['donut_sby'] = { -- Fuck those baked shits are good af
        label = 'Zemeņu virtulis',
        weight = 350,
        stack = true,
        close = true,
        description = "Mmmmm , zemenes",
        client = {
            status = { hunger = 150000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_foodpack_donut001', 
            bone = 18905,
            pos = vec3(0.13, 0.050, 0.020), 
            rot = vec3(-50.0, 100.0, 270.0) },
            usetime = 7500,
        },
    },

    ['smore'] = { -- Fuck those baked shits are good af
        label = 'Smore',
        weight = 350,
        stack = true,
        close = true,
        description = "Mmmmm..",
        client = {
            status = { hunger = 90000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_food_dessert_a', 
            bone = 18905,
            pos = vec3(0.15, 0.03, 0.03), 
            rot = vec3(-42.0, -36.0, 0.0) },
            usetime = 7500,
        },
    },

    ['icecream_chr'] = { -- brain cold go brrrrr
        label = 'Ķiršu saldējums',
        weight = 350,
        stack = true,
        close = true,
        description = "Nesasals smadzenes?",
        client = {
            status = { hunger = 50000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_icecream_cherry', 
            bone = 18905,
            pos = vec3(0.14, 0.03, 0.01), 
            rot = vec3(85.0, 70.0, -203.0) },
            usetime = 7500,
        },
    },

    ['icecream_chc'] = { -- brain cold go brrrrr
        label = 'Šokolādes saldējums',
        weight = 350,
        stack = true,
        close = true,
        description = "Nesasals smadzenes?",
        client = {
            status = { hunger = 50000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_icecream_chocolate', 
            bone = 18905,
            pos = vec3(0.14, 0.03, 0.01), 
            rot = vec3(85.0, 70.0, -203.0) },
            usetime = 7500,
        },
    },

    ['icecream_lmn'] = { -- brain cold go brrrrr
        label = 'Citrona saldējums',
        weight = 350,
        stack = true,
        close = true,
        description = "Nesasals smadzenes?",
        client = {
            status = { hunger = 50000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_icecream_lemon', 
            bone = 18905,
            pos = vec3(0.14, 0.03, 0.01), 
            rot = vec3(85.0, 70.0, -203.0) },
            usetime = 7500,
        },
    },

    ['icecream_pso'] = { -- brain cold go brrrrr
        label = 'Pistāciju saldējums',
        weight = 350,
        stack = true,
        close = true,
        description = "Nesasals smadzenes?",
        client = {
            status = { hunger = 50000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_icecream_pistachio', 
            bone = 18905,
            pos = vec3(0.14, 0.03, 0.01), 
            rot = vec3(85.0, 70.0, -203.0) },
            usetime = 7500,
        },
    },

    ['icecream_rpy'] = { -- brain cold go brrrrr
        label = 'Aveņu saldējums',
        weight = 350,
        stack = true,
        close = true,
        description = "Nesasals smadzenes?",
        client = {
            status = { hunger = 50000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_icecream_raspberry', 
            bone = 18905,
            pos = vec3(0.14, 0.03, 0.01), 
            rot = vec3(85.0, 70.0, -203.0) },
            usetime = 7500,
        },
    },

    ['icecream_ckd'] = { -- brain cold go brrrrr
        label = 'Cepumu saldējums',
        weight = 350,
        stack = true,
        close = true,
        description = "Nesasals smadzenes?",
        client = {
            status = { hunger = 50000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_icecream_stracciatella', 
            bone = 18905,
            pos = vec3(0.14, 0.03, 0.01), 
            rot = vec3(85.0, 70.0, -203.0) },
            usetime = 7500,
        },
    },

    ['icecream_sby'] = { -- brain cold go brrrrr
        label = 'Zemeņu saldējums',
        weight = 350,
        stack = true,
        close = true,
        description = "Nesasals smadzenes?",
        client = {
            status = { hunger = 50000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_icecream_strawberry', 
            bone = 18905,
            pos = vec3(0.14, 0.03, 0.01), 
            rot = vec3(85.0, 70.0, -203.0) },
            usetime = 7500,
        },
    },

    ['icecream_vna'] = { -- brain cold go brrrrr
        label = 'Vaniļas saldējums',
        weight = 350,
        stack = true,
        close = true,
        description = "Nesasals smadzenes?",
        client = {
            status = { hunger = 50000 },
            anim = { dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger_fp' },
            prop = { model = 'bzzz_icecream_walnut', 
            bone = 18905,
            pos = vec3(0.14, 0.03, 0.01), 
            rot = vec3(85.0, 70.0, -203.0) },
            usetime = 7500,
        },
    },

	-- DRINKS
	--DRINKS
	-- DRINKS

	-- DRINKS: General

    ['water'] = { -- Carbonized syrup is good for the soul
        label = 'Ūdens Pudele',
        weight = 350,
        stack = true,
        close = true,
        description = "Ja tev vajag ūdeni tad dzer..",
        client = {
            status = { thirst = 300000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'vw_prop_casino_water_bottle_01a', 
            pos = vec3(0.008, 0.0, -0.05), rot = vec3(0.0, 0.0, -40.0) },
            usetime = 7500,
        },
    },

    ['milk'] = { -- milky milky milky
        label = 'Piens',
        weight = 350,
        stack = true,
        close = true,
        description = "Ja gribi stiprus kaulus dzer..",
        client = {
            status = { thirst = 300000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'v_res_tt_milk', 
            bone = 18905,
            pos = vec3(0.10, 0.008, 0.070), 
            rot = vec3(240.0, -60.0, 0.0) },
            usetime = 7500,
        },
    },


    -- COFFEES


    ['coffee_black'] = { -- Carbonized syrup is good for the soul
        label = 'Melnā kafija',
        weight = 350,
        stack = true,
        close = true,
        description = "Tik melns..",
        client = {
            status = { thirst = 220000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'ng_proc_coffee_01a', 
            pos = vec3(0.008, 0.0, -0.05), rot = vec3(0.0, 0.0, -40.0) },
            usetime = 7500,
        },
    },

    ['coffee_mocha'] = { -- Carbonized syrup is good for the soul
        label = 'Moča',
        weight = 350,
        stack = true,
        close = true,
        description = "Kas vispār ir moča?",
        client = {
            status = { thirst = 220000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'ng_proc_coffee_01a', 
            pos = vec3(0.008, 0.0, -0.05), rot = vec3(0.0, 0.0, -40.0) },
            usetime = 7500,
        },
    },

    ['coffee_cpcno'] = { -- Carbonized syrup is good for the soul
        label = 'Kapučīno',
        weight = 350,
        stack = true,
        close = true,
        description = "Tas jūs varētu nedaudz pamodināt",
        client = {
            status = { thirst = 220000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'ng_proc_coffee_01a', 
            pos = vec3(0.008, 0.0, -0.05), rot = vec3(0.0, 0.0, -40.0) },
            usetime = 7500,
        },
    },

    ['coffee_amrcno'] = { -- Carbonized syrup is good for the soul
        label = 'Amerikāno kafija',
        weight = 350,
        stack = true,
        close = true,
        description = "Amerikāņu kafija ar o",
        client = {
            status = { thirst = 220000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'ng_proc_coffee_01a', 
            pos = vec3(0.008, 0.0, -0.05), rot = vec3(0.0, 0.0, -40.0) },
            usetime = 7500,
        },
    },


    -- SODAS


    ['ecola'] = { -- Carbonized syrup is good for the soul
        label = 'eCola',
        weight = 350,
        stack = true,
        close = true,
        description = "Koliņa..",
        client = {
            status = { thirst = 160000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'prop_ecola_can', 
            pos = vec3(0.0, 0.0, 0.0), rot = vec3(0.0, 0.0, 130.0) },
            usetime = 5000,
        },
    },

    ['sprunk'] = { -- Carbonized syrup is good for the soul
        label = 'Sprunks',
        weight = 350,
        stack = true,
        close = true,
        description = "Tas garšo tā, it kā ūdens būtu iesitis jums kaklā",
        client = {
            status = { thirst = 160000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'ng_proc_sodacan_01b', 
            pos = vec3(0.005, -0.001, 0.08), rot = vec3(0.0, 0.0, 160.0) },
            usetime = 5000,
        },
    },

    ['orangotang'] = { -- Carbonized syrup is good for the soul
        label = 'Orange',
        weight = 350,
        stack = true,
        close = true,
        description = "Es pat nezināju, ka cilvēki to vēlas",
        client = {
            status = { thirst = 160000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'prop_orang_can_01', 
            pos = vec3(0.0, 0.0, 0.0), rot = vec3(0.0, 0.0, 130.0) },
            usetime = 5000,
        },
    },

    ['ejunk'] = { -- Drinking too much of this wont kill you. I think.
        label = 'Enerģijas dzēriens',
        weight = 350,
        stack = true,
        close = true,
        description = "Nedzer daudz būs slikti",
        client = {
            status = { thirst = 160000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = 'sf_prop_sf_can_01a', 
            pos = vec3(0.025, 0.010, 0.05), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 5000,
        },
    },
	
	
	-- ["key"] = {
	-- 	label = "Atslēga?",
	-- 	weight = 1000,
	-- 	stack = false,
	-- 	close = true,
	-- 	description = "Atslēga A..?",
	-- 	client = {
	-- 		image = "keya.png",
	-- 	}
	-- },

	-- ["recyclablematerial"] = {
	-- 	label = "Pārstrādes kaste",
	-- 	weight = 100,
	-- 	stack = true,
	-- 	close = false,
	-- 	description = "Kaste ar pārstrādājamiem materiāliem",
	-- 	client = {
	-- 		image = "recyclablematerial.png",
	-- 	}
	-- },

	-- ["bottle"] = {
	-- 	label = "Tukša pudele",
	-- 	weight = 100,
	-- 	stack = true,
	-- 	close = false,
	-- 	description = "Tukša pudele",
	-- 	client = {
	-- 		image = "bottle.png",
	-- 	}
	-- },

	-- ["can"] = {
	-- 	label = "Tukša bundža",
	-- 	weight = 100,
	-- 	stack = true,
	-- 	close = false,
	-- 	description = "Tukša bundža , noder pārstrādei.",
	-- 	client = {
	-- 		image = "can.png",
	-- 	}
	-- },

	['atm-robbery'] = {
		label = 'Hakošanas iekārta',
		description = "Iekārta kuru var pieslēgt pie bankomāta",
		client = {
			image = 'atm-robbery.png'
		}
	},

	-- ['darbinieka-karte'] = {
	-- 	label = 'Fleeca darbinieka karte',
	-- 	description = "Kāda Fleeca bankas darbinieka kartiņa",
	-- 	client = {
	-- 		image = 'darbinieka-karte.png'
	-- 	}
	-- },

	['shop-robbery'] = {
		label = 'Signalizācijas atslēdzējs',
		description = "Ar šo iekārtu vari atslēgt signalizāciju...",
		client = {
			image = 'shop-robbery.png'
		}
	},

	['bank-robbery'] = {
		label = '[A] Kartiņa',
		description = "Kartiņa ar Fleeca bankas logo",
		client = {
			image = 'bank-robbery.png'
		}
	},

	['palleto-robbery'] = {
		label = '[B] Kartiņa',
		description = "Kartiņa ar Paleto bankas logo",
		client = {
			image = 'bank-robbery.png'
		}
	},

	['juvilieris-robbery'] = {
		label = '[C] Kartiņa',
		description = "Kartiņa ar Juviliera bankas logo",
		client = {
			image = 'bank-robbery.png'
		}
	},

	['lbanka-robbery'] = {
		label = '[D] Kartiņa',
		description = "Kartiņa ar bankas logo",
		client = {
			image = 'bank-robbery.png'
		}
	},

	['rentalpapers'] = {
		label = "Īres dokumenti",
		weight = 0,
		stack = false,
		close = false,
		description = "Īres dokumenti",
		client = {
			image = "rentalpapers.png",
		},
	},

	['police_stormram'] = {
		label = "[PD] Stormram",
		weight = 0,
		stack = false,
		close = false,
		description = "Policijas stormram ar ko izsist durvis.",
		client = {
			image = "police_stormram.png",
		},
	},

	['nightvision'] = {
		label = "Nakts redzamības brilles",
		weight = 0,
		stack = false,
		close = false,
		description = "Brilles lai labāk redzētu naktī.",
		client = {
			image = "nightvision.png",
		},
	},


	--BIZNESU ITEMI EDAMAIS UTT

	["restaurant_food"] = {
		label = "Restorāna ēdiens",
		weight = 0,
		stack = true,
		close = true,
		client = {
			export = 'mt-restaurants.useFoodItem'
		}
	},
	["restaurant_box"] = {
		label = "Restorāna kaste",
		weight = 0,
		stack = true,
		close = true,
		client = {
			export = 'mt-restaurants.useBoxItem'
		}
	},
	["restaurant_menu"] = {
		label = "Restorāna ēdienkarte",
		weight = 0,
		stack = true,
		close = true,
		client = {
			export = 'mt-restaurants.openMenu'
		}
	},
	
	["meat"] = {
		label = "Gaļa",
		weight = 100,
		stack = true,
		close = true,
		description = "Gaļa",
		client = {
			image = "meat.png",
		}
	},
	
	["fish"] = {
		label = "Zivs",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaiga zivs",
		client = {
			image = "fish.png",
		}
	},
	
	["onion"] = {
		label = "Sīpols",
		weight = 100,
		stack = true,
		close = true,
		description = "Sīpols",
		client = {
			image = "onion.png",
		}
	},
	
	["carrot"] = {
		label = "Burkāns",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigs burkāns",
		client = {
			image = "carrot.png",
		}
	},
	
	["lettuce"] = {
		label = "Salāti",
		weight = 100,
		stack = true,
		close = true,
		description = "Salāti",
		client = {
			image = "lettuce.png",
		}
	},
	
	["cucumber"] = {
		label = "Gurķis",
		weight = 100,
		stack = true,
		close = true,
		description = "Gurķis",
		client = {
			image = "cucumber.png",
		}
	},
	
	["potato"] = {
		label = "Kartupelis",
		weight = 100,
		stack = true,
		close = true,
		description = "Kartupelis",
		client = {
			image = "potato.png",
		}
	},
	
	["tomato"] = {
		label = "Tomāts",
		weight = 100,
		stack = true,
		close = true,
		description = "Tomāts",
		client = {
			image = "tomato.png",
		}
	},
	
	["wheat"] = {
		label = "Kvieši",
		weight = 100,
		stack = true,
		close = true,
		description = "Kvieši",
		client = {
			image = "wheat.png",
		}
	},
	
	["strawberry"] = {
		label = "Zemenes",
		weight = 100,
		stack = true,
		close = true,
		description = "Zemenes",
		client = {
			image = "strawberry.png",
		}
	},
	
	["watermelon"] = {
		label = "Arbūzs",
		weight = 100,
		stack = true,
		close = true,
		description = "Arbūzs",
		client = {
			image = "watermelon.png",
		}
	},
	
	["soya"] = {
		label = "Soja",
		weight = 100,
		stack = true,
		close = true,
		description = "Soja",
		client = {
			image = "soya.png",
		}
	},
	
	["pineapple"] = {
		label = "Ananāss",
		weight = 100,
		stack = true,
		close = true,
		description = "Ananāss",
		client = {
			image = "pineapple.png",
		}
	},
	
	["apple"] = {
		label = "Ābols",
		weight = 100,
		stack = true,
		close = true,
		description = "Ābols",
		client = {
			image = "apple.png",
		}
	},
	
	["pear"] = {
		label = "Bumbieris",
		weight = 100,
		stack = true,
		close = true,
		description = "Bumbieris",
		client = {
			image = "pear.png",
		}
	},
	
	["lemon"] = {
		label = "Citrons",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigs citrons",
		client = {
			image = "lemon.png",
		}
	},
	
	["banana"] = {
		label = "Banāns",
		weight = 100,
		stack = true,
		close = true,
		description = "Banāns",
		client = {
			image = "banana.png",
		}
	},
	
	["orange"] = {
		label = "Apelsīns",
		weight = 100,
		stack = true,
		close = true,
		description = "Apelsīns",
		client = {
			image = "orange.png",
		}
	},
	
	["peach"] = {
		label = "Persiks",
		weight = 100,
		stack = true,
		close = true,
		description = "Persiks",
		client = {
			image = "peach.png",
		}
	},
	
	["mango"] = {
		label = "Mango",
		weight = 100,
		stack = true,
		close = true,
		description = "Mango.",
		client = {
			image = "mango.png",
		}
	},
	
	["corn"] = {
		label = "Kukurūza",
		weight = 100,
		stack = true,
		close = true,
		description = "Kukurūza.",
		client = {
			image = "corn.png",
		}
	},
	
	["coffee_beans"] = {
		label = "Kafijas pupiņas",
		weight = 100,
		stack = true,
		close = true,
		description = "Kafijas pupiņas",
		client = {
			image = "coffee_beans.png",
		}
	},

	["cutted_onion"] = {
		label = "Sagriezts Sīpols",
		weight = 100,
		stack = true,
		close = true,
		description = "Sagriezts Sīpols",
		client = {
			image = "cutted_onion.png",
		}
	},
	["cutted_carrot"] = {
		label = "Sagriezts Brukāns",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts burkāns.",
		client = {
			image = "cutted_carrot.png",
		}
	},
	["cutted_lettuce"] = {
		label = "Sagriezti Salāti",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezti salāti.",
		client = {
			image = "cutted_lettuce.png",
		}
	},
	["cutted_cucumber"] = {
		label = "Sagriezts Gurķis",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts gurķis.",
		client = {
			image = "cutted_cucumber.png",
		}
	},
	["cutted_potato"] = {
		label = "Sagriezts Kartupelis",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts kartupelis.",
		client = {
			image = "cutted_potato.png",
		}
	},
	["cutted_tomato"] = {
		label = "Sagriezts Tomāts",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts tomāts.",
		client = {
			image = "cutted_tomato.png",
		}
	},
	["cutted_wheat"] = {
		label = "Sagriezti Kvieši",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezti kvieši.",
		client = {
			image = "cutted_wheat.png",
		}
	},
	["cutted_strawberry"] = {
		label = "Sagrieztas Zemenes",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagrieztas zemenes..",
		client = {
			image = "cutted_strawberry.png",
		}
	},
	["cutted_watermelon"] = {
		label = "Sagriezts Arbūzs",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts arbūzs.",
		client = {
			image = "cutted_watermelon.png",
		}
	},
	["cutted_soya"] = {
		label = "Sagriezta Soja",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezta Soja..",
		client = {
			image = "cutted_soya.png",
		}
	},
	["cutted_pineapple"] = {
		label = "Sagriezts Ananāss",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts ananāss.",
		client = {
			image = "cutted_pineapple.png",
		}
	},
	["cutted_apple"] = {
		label = "Sagriezts Ābols",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts ābols.",
		client = {
			image = "cutted_apple.png",
		}
	},
	["cutted_pear"] = {
		label = "Sagriezts Bumbieris",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts bumbiers.",
		client = {
			image = "cutted_pear.png",
		}
	},
	["cutted_lemon"] = {
		label = "Sagriezts Citrons",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts citrons.",
		client = {
			image = "cutted_lemon.png",
		}
	},
	["cutted_banana"] = {
		label = "Sagriezts Banāns",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts banāns.",
		client = {
			image = "cutted_banana.png",
		}
	},
	["cutted_orange"] = {
		label = "Sagriezts Apelsīns",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts apelsīns.",
		client = {
			image = "cutted_orange.png",
		}
	},
	["cutted_peach"] = {
		label = "Sagriezts Persiks",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts persiks.",
		client = {
			image = "cutted_peach.png",
		}
	},
	["cutted_mango"] = {
		label = "Sagriezts Mango",
		weight = 100,
		stack = true,
		close = true,
		description = "Svaigi sagriezts mango.",
		client = {
			image = "cutted_mango.png",
		}
	},
	["cutted_meat"] = {
		label = "Sagriezta gaļa",
		weight = 500,
		stack = true,
		close = true,
		description = "Svaigi sagriezta gaļa.",
		client = {
			image = "cutted_meat.png",
		}
	},
	["cutted_fish"] = {
		label = "Sagriezta Zivs",
		weight = 500,
		stack = true,
		close = true,
		description = "Svaigi sagriezta zivs.",
		client = {
			image = "cutted_fish.png",
		}
	},
	

	------------------------------------


	['racingtablet'] = {
		label = 'Sacīkšu Planšete',
		weight = 500,
		description = 'Šķiet, ka kaut kas saistīts ar automašīnām.',
		stack = false,
		client = {
			export = 'rahe-racing.racingtablet',
		}
	},
	
	['boostingtablet'] = {
		label = 'Boosting Planšete',
		weight = 0,
		description = "Šķiet, ka šeit kaut kas ir instalēts.",
		client = {
		export = 'rahe-boosting.boostingtablet',
		}
	},
	['hackingdevice'] = {
		label = 'Hackeru ierīce',
		weight = 0,
		description = 'Ļaus apiet transportlīdzekļu drošības sistēmas.',
		client = {
		export = 'rahe-boosting.hackingdevice',
		}
	},
	['gpshackingdevice'] = {
		label = 'GPS izsekošanas ierīce',
		weight = 0,
		description = 'Ja vēlaties atspējot transportlīdzekļa GPS sistēmas.',
		client = {
		export = 'rahe-boosting.gpshackingdevice',
		}
	},

	-------------------- NARKAŠ

	["watering_can"] = {
		label = "Lejkanna",
		weight = 500,
		stack = false,
		close = false,
		description = "Vienkārša laistīšanas kanna",
		client = {
			image = "watering_can.png",
		}
	},
	
	["fertilizer"] = {
		label = "Mēslojums",
		weight = 500,
		stack = false,
		close = false,
		description = "Mēslojums",
		client = {
			image = "fertilizer.png",
		}
	},
	
	["advanced_fertilizer"] = {
		label = "Uzlabots Mēslojums",
		weight = 500,
		stack = false,
		close = false,
		description = "Mēslojums ar nelielu piedevu",
		client = {
			image = "advanced_fertilizer.png",
		}
	},
	
	["liquid_fertilizer"] = {
		label = "Šķidrais mēslojums",
		weight = 200,
		stack = false,
		close = false,
		description = "Būtībā Ūdens ar barības vielām",
		client = {
			image = "liquid_fertilizer.png",
		}
	},
	
	["weed_lemonhaze_seed"] = {
		label = "Weed Lemonhaze Sēkla",
		weight = 20,
		stack = true,
		close = true,
		description = "Weed Lemonhaze Sēkla",
		client = {
			image = "weed_lemonhaze_seed.png",
		}
	},
	
	["weed_lemonhaze"] = {
		label = "Weed Lemonhaze",
		weight = 20,
		stack = true,
		close = false,
		description = "Weed Lemonhaze",
		client = {
			image = "weed_lemonhaze.png",
		}
	},
	
	["coca_seed"] = {
		label = "Coca Sēkla",
		weight = 20,
		stack = true,
		close = true,
		description = "Coca Sēkla",
		client = {
			image = "coca_seed.png",
		}
	},
	
	["coca"] = {
		label = "Coca",
		weight = 20,
		stack = true,
		close = false,
		description = "Coca",
		client = {
			image = "coca.png",
		}
	},
	
	["paper"] = {
		label = "Papīrs",
		weight = 50,
		stack = true,
		close = false,
		description = "Papīrs",
		client = {
			image = "paper.png",
		}
	},
	["papers"] = {
		label = "Tinamie papīri",
		weight = 50,
		stack = true,
		close = false,
		description = "Tinamie papīriši",
		client = {
			image = "papers.png",
		}
	},
	
	["nitrous"] = {
		label = "Nitro",
		weight = 500,
		stack = false,
		close = false,
		description = "Nitro",
		client = {
			image = "nitrous.png",
		}
	},
	
	["cocaine"] = {
		label = "Kokaīns",
		weight = 20,
		stack = true,
		close = true,
		description = "Mazs kokaīna maisiņš",
		client = {
			image = "cocaine.png",
		}
	},
	
	["joint"] = {
		label = "Joints",
		weight = 10,
		stack = true,
		close = true,
		description = "Joints",
		client = {
			image = "joint.png",
		}
	},
	
	["weed_processing_table"] = {
		label = "Zāles Apstrādes Galds",
		weight = 1000,
		stack = false,
		close = true,
		description = "Sagatavot Zāli",
		client = {
			image = "weed_processing_table.png",
		}
	},
	
	["cocaine_processing_table"] = {
		label = "Kokaīna Apstrādes Galds",
		weight = 1000,
		stack = false,
		close = true,
		description = "Sagatavot Kokaīnu",
		client = {
			image = "cocaine_processing_table.png",
		}
	},

	-------------------------------------------

	-- MAAJAS LAUPISANAM RANDOM ITEMI

	["microwave"] = {
		label = "Mikroviļņu krāsns",
		weight = 100,
		stack = true,
		close = false,
		description = "Laba iekārta lai uzsildītu ēdienu.",
		client = {
			image = "microwave.png",
		}
	},

	["toaster"] = {
		label = "Tosteris",
		weight = 100,
		stack = true,
		close = false,
		description = "Laba iekārta lai uzsildītu ēdienu.",
		client = {
			image = "toaster.png",
		}
	},

	["camera"] = {
		label = "Kamera",
		weight = 100,
		stack = true,
		close = false,
		description = "Dārga aukstas kvalitātes video kamera.",
		client = {
			image = "camera.png",
		}
	},

	["xbox"] = {
		label = "XBOX X",
		weight = 100,
		stack = true,
		close = false,
		description = "XBOX spēļu konsole.",
		client = {
			image = "xbox.png",
		}
	},

	["aincientcoin"] = {
		label = "Vēsturiska monēta",
		weight = 100,
		stack = true,
		close = false,
		description = "Ļoti sena monēta ar augstu vērtību.",
		client = {
			image = "aincientcoin.png",
		}
	},

	["cwnotepad"] = {
		label = "Piezīmj Bloks",
		weight = 300,
		stack = true,
		close = true,
		allowArmed = true,
		description = "Piezīmj Bloks",
	},
	["cwnote"] = {
		label = "Lapiņa",
		weight = 350,
		stack = true,
		close = true,
		allowArmed = true,
		description = "Lapiņa",
	},
	
	['card_2070'] = {
		label = 'LSX 2070',
		weight = 750,
		stack = true,
	},
	
	['card_2080'] = {
		label = 'LSX 2080',
		weight = 750,
		stack = true,
	},

	['card_3080'] = {
		label = 'LSX 3080',
		weight = 1000,
		stack = true,
		
	},

	['card_3090'] = {
		label = 'LSX 3090',
		weight = 1000,
		stack = true,
	},

	['card_4080'] = {
		label = 'LSX 4080',
		weight = 1500,
		stack = true,
	},

	['card_4090'] = {
		label = 'LSX 4090',
		weight = 1500,
		stack = true,
	},

['warehouse_locator'] = {
    label = 'Noliktavas lokators',
    weight = 200,
    stack = true
},

['usb_drive'] = {
    label = 'USB fleš',
    weight = 100,
    stack = true
},

['handcuffs'] = {
    label = 'Rokudzelži',
    weight = 100,
    stack = true
},

['zipties'] = {
    label = 'Zipties',
    weight = 10,
    stack = true
},

['bolt_cutters'] = {
    label = 'Skrūvju griezējs',
    weight = 500,
    stack = false
},
	
	

	["weed_white-widow"] = {
		label = "White Widow 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "Narkotiku maisiņš ar 2g White Widow",
		client = {
			image = "weed_baggy.png",
		}
	},

	["gatecrack"] = {
		label = "Gatecrack",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to tear down some fences",
		client = {
			image = "usb_device.png",
		}
	},

	["firework2"] = {
		label = "Popelers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Salūts",
		client = {
			image = "firework2.png",
		}
	},

	["coffee"] = {
		label = "Kafija",
		weight = 200,
		stack = true,
		close = true,
		description = "Kafija",
		client = {
			image = "coffee.png",
		}
	},

	["iphone"] = {
		label = "iPhone",
		weight = 1000,
		stack = true,
		close = true,
		description = "Ļoti kruts telefons",
		client = {
			image = "iphone.png",
		}
	},

	["harness"] = {
		label = "Sacīkšu Josta",
		weight = 1000,
		stack = false,
		close = true,
		description = "Ar šito paliksi mašīnā.",
		client = {
			image = "harness.png",
		}
	},

	["stickynote"] = {
		label = "Līmlapiņa",
		weight = 0,
		stack = false,
		close = false,
		description = "Kādreiz , lai atcerētos.. :)",
		client = {
			image = "stickynote.png",
		}
	},

	["mastercard"] = {
		label = "Master Karte",
		weight = 0,
		stack = false,
		close = false,
		description = "Izmantot ATM",
		client = {
			image = "mastercard.png",
		}
	},

	["twerks_candy"] = {
		label = "Twerks",
		weight = 100,
		stack = true,
		close = true,
		description = "Garšīga šokolāde :O",
		client = {
			image = "twerks_candy.png",
		}
	},

	["10kgoldchain"] = {
		label = "10k Zelta ķēde",
		weight = 2000,
		stack = true,
		close = true,
		description = "10 karātu zelta ķēde",
		client = {
			image = "10kgoldchain.png",
		}
	},

	["cryptostick"] = {
		label = "Kripto fleš",
		weight = 200,
		stack = false,
		close = true,
		description = "Kāpēc kāds kādreiz pirktu naudu, kuras nav.. Cik daudz tajā būtu..?",
		client = {
			image = "cryptostick.png",
		}
	},

	["cokebaggy"] = {
		label = "Kokaīna maisiņš",
		weight = 0,
		stack = true,
		close = true,
		description = "Paliec priecīgs",
		client = {
			image = "cocaine_baggy.png",
		}
	},

	["visa"] = {
		label = "Visa Karte",
		weight = 0,
		stack = false,
		close = false,
		description = "Visa izmanto ATM",
		client = {
			image = "visacard.png",
		}
	},

	["aluminumoxide"] = {
		label = "Alumīnija pulveris",
		weight = 100,
		stack = true,
		close = false,
		description = "Nedaudz pulvera, ar ko sajaukt",
		client = {
			image = "aluminumoxide.png",
		}
	},

	["empty_evidence_bag"] = {
		label = "Tukšs pierādījumu maisiņš",
		weight = 0,
		stack = true,
		close = false,
		description = "Daudz izmantots, lai pasargātu DNS no asinīm, ložu čaulām un daudz ko citu",
		client = {
			image = "evidence.png",
		}
	},

	["firework1"] = {
		label = "2Brāļi",
		weight = 1000,
		stack = true,
		close = true,
		description = "Salīts",
		client = {
			image = "firework1.png",
		}
	},

	["glass"] = {
		label = "Stikls",
		weight = 100,
		stack = true,
		close = false,
		description = "Nesagriezies",
		client = {
			image = "glass.png",
		}
	},

	["aluminum"] = {
		label = "Alumīnījs",
		weight = 100,
		stack = true,
		close = false,
		description = "Jauks metāla gabals, ko droši var kaut kam izmantot",
		client = {
			image = "aluminum.png",
		}
	},

	["rubber"] = {
		label = "Gumija",
		weight = 100,
		stack = true,
		close = false,
		description = "Gumija, es uzskatu, ka ar to jūs varat izveidot savu gumijas pīli :D",
		client = {
			image = "rubber.png",
		}
	},

	["coke_small_brick"] = {
		label = "Kokaīna iepakojums",
		weight = 350,
		stack = false,
		close = true,
		description = "Neliels kokaīna iepakojums, ko izmanto galvenokārt darījumos un aizņem daudz vietas",
		client = {
			image = "coke_small_brick.png",
		}
	},

	["rolling_paper"] = {
		label = "Tinamais Papīrs",
		weight = 0,
		stack = true,
		close = true,
		description = "Kādu jointu?",
		client = {
			image = "rolling_paper.png",
		}
	},

	["crack_baggy"] = {
		label = "Kreka Maisiņš",
		weight = 0,
		stack = true,
		close = true,
		description = "Paliec smaidīgs..",
		client = {
			image = "crack_baggy.png",
		}
	},

	["pinger"] = {
		label = "Pingers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Izmantojot signālu un tālruni, varat nosūtīt savu atrašanās vietu",
		client = {
			image = "pinger.png",
		}
	},

	["whiskey"] = {
		label = "Viskijs",
		weight = 500,
		stack = true,
		close = true,
		description = "Visiem izslāpušajiem",
		client = {
			image = "whiskey.png",
		}
	},

	["security_card_01"] = {
		label = "Drošības karte A",
		weight = 0,
		stack = true,
		close = true,
		description = "Drošības karte... Interesanti, kur tā noder...",
		client = {
			image = "security_card_01.png",
		}
	},

	["grape"] = {
		label = "Vīnoga",
		weight = 100,
		stack = true,
		close = false,
		description = "Mmmmh yummie, Vīnogas",
		client = {
			image = "grape.png",
		}
	},

	["sandwich"] = {
		label = "Sviestmaize",
		weight = 200,
		stack = true,
		close = true,
		description = "Sviestmaize",
		client = {
			image = "sandwich.png",
		}
	},

	["goldbar"] = {
		label = "Zelta Stienis",
		weight = 7000,
		stack = true,
		close = true,
		description = "Man izskatās diezgan dārgi",
		client = {
			image = "goldbar.png",
		}
	},

	["certificate"] = {
		label = "Sertifikāts",
		weight = 0,
		stack = true,
		close = true,
		description = "Sertifikāts, kas apliecina, ka jums pieder noteiktas lietas",
		client = {
			image = "certificate.png",
		}
	},

	["moneybag"] = {
		label = "Naudas Soma",
		weight = 0,
		stack = false,
		close = true,
		description = "Soma ar naudu",
		client = {
			image = "moneybag.png",
		}
	},
	
	['backpack'] = {
		label = 'Mugursoma',
		weight = 220,
		stack = false,
		description = "Neliela mugursoma kur glabāt mantas",
		consume = 0,
		client = {
			export = 'wasabi_backpack.openBackpack'
		}
	},

	["antipatharia_coral"] = {
		label = "Antipatārija",
		weight = 1000,
		stack = true,
		close = true,
		description = "Antipatārija",
		client = {
			image = "antipatharia_coral.png",
		}
	},

	["kurkakola"] = {
		label = "Kola",
		weight = 500,
		stack = true,
		close = true,
		description = "Dzer kolu paliec resns",
		client = {
			image = "cola.png",
		}
	},

	["dendrogyra_coral"] = {
		label = "Dendrogyra",
		weight = 1000,
		stack = true,
		close = true,
		description = "Koralis",
		client = {
			image = "dendrogyra_coral.png",
		}
	},

	["meth"] = {
		label = "Metamfetamīns",
		weight = 100,
		stack = true,
		close = true,
		description = "Metamfetamīns",
		client = {
			image = "meth_baggy.png",
		}
	},

	["cleaningkit"] = {
		label = "Tīrīšanas Komplekts",
		weight = 250,
		stack = true,
		close = true,
		description = "Tīrīšanas Komplekts",
		client = {
			image = "cleaningkit.png",
		}
	},

	["weed_brick"] = {
		label = "Zāles Briks",
		weight = 1000,
		stack = true,
		close = true,
		description = "1KG Zāles Briks",
		client = {
			image = "weed_brick.png",
		}
	},

	["small_tv"] = {
		label = "Mazais TV",
		weight = 30000,
		stack = false,
		close = true,
		description = "TV",
		client = {
			image = "placeholder.png",
		}
	},

	["coke_brick"] = {
		label = "Kokaīna Ķieģelis",
		weight = 1000,
		stack = false,
		close = true,
		description = "Smags kokaīna iepakojums, ko galvenokārt izmanto darījumos un aizņem daudz vietas",
		client = {
			image = "coke_brick.png",
		}
	},

	["casinochips"] = {
		label = "Kazino Čipi",
		weight = 0,
		stack = true,
		close = false,
		description = "Kazino azartspēļu žetoni",
		client = {
			image = "casinochips.png",
		}
	},

	["lawyerpass"] = {
		label = "Advokāta Karte",
		weight = 0,
		stack = false,
		close = false,
		description = "Advokāta Karte",
		client = {
			image = "lawyerpass.png",
		}
	},

	["security_card_02"] = {
		label = "Drošības karte B",
		weight = 0,
		stack = true,
		close = true,
		description = "Kur var izmantot?",
		client = {
			image = "security_card_02.png",
		}
	},

	["filled_evidence_bag"] = {
		label = "Pierādījumu maisiņš",
		weight = 200,
		stack = false,
		close = false,
		description = "Pierādījumu maisiņš",
		client = {
			image = "evidence.png",
		}
	},

	["binoculars"] = {
		label = "Binoklis",
		weight = 600,
		stack = true,
		close = true,
		description = "Sneaky esi?",
		client = {
			image = "binoculars.png",
		}
	},

	["steel"] = {
		label = "Tērauds",
		weight = 100,
		stack = true,
		close = false,
		description = "Tērauds",
		client = {
			image = "steel.png",
		}
	},

	["weed_skunk"] = {
		label = "Skunk 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "Maisiņš 2g Skunk",
		client = {
			image = "weed_baggy.png",
		}
	},

	["firework3"] = {
		label = "Vipeouts",
		weight = 1000,
		stack = true,
		close = true,
		description = "Salūts",
		client = {
			image = "firework3.png",
		}
	},

	["weed_purple-haze"] = {
		label = "Purple Haze 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "Maisiņša ar 2g Purple Haze",
		client = {
			image = "weed_baggy.png",
		}
	},

	["trojan_usb"] = {
		label = "Trojāna USB",
		weight = 0,
		stack = true,
		close = true,
		description = "Ērta programmatūra dažu sistēmu izslēgšanai",
		client = {
			image = "usb_device.png",
		}
	},

	["weed_ak47"] = {
		label = "AK47 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "Maisiņš ar 2g AK47",
		client = {
			image = "weed_baggy.png",
		}
	},

	["markedbills"] = {
		label = "Markēta Nauda",
		weight = 1000,
		stack = false,
		close = true,
		description = "Money?",
		client = {
			image = "markedbills.png",
		}
	},

	["rolex"] = {
		label = "Zelta Pulkstenis",
		weight = 1500,
		stack = true,
		close = true,
		description = "Zelta pulkstenis man šķiet džekpots!",
		client = {
			image = "rolex.png",
		}
	},

	["weed_amnesia"] = {
		label = "Amnesia 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "Maisiņš ar 2g Amnesia",
		client = {
			image = "weed_baggy.png",
		}
	},

	["water_bottle"] = {
		label = "Ūdens Pudele",
		weight = 500,
		stack = true,
		close = true,
		description = "Dzer, dzer, dzer",
		client = {
			image = "water_bottle.png",
		}
	},

	["weaponlicense"] = {
		label = "Ieroču Licence",
		weight = 0,
		stack = false,
		close = true,
		description = "Ko darīsi ko?",
		client = {
			image = "weapon_license.png",
		}
	},

	["labkey"] = {
		label = "Atslēga",
		weight = 500,
		stack = false,
		close = true,
		description = "Slēdzenes atslēga...?",
		client = {
			image = "labkey.png",
		}
	},

	["lighter"] = {
		label = "Šķiltavas",
		weight = 0,
		stack = true,
		close = true,
		description = "Aizdedzini salūtu",
		client = {
			image = "lighter.png",
		}
	},

	["tablet"] = {
		label = "Planšete",
		weight = 2000,
		stack = true,
		close = true,
		description = "Dārga planšete",
		client = {
			image = "tablet.png",
		}
	},

	["plastic"] = {
		label = "Plastmasa",
		weight = 100,
		stack = true,
		close = false,
		description = "Uztaisi kaut ko...",
		client = {
			image = "plastic.png",
		}
	},

	["electronickit"] = {
		label = "Elektroniskais Komplekts",
		weight = 100,
		stack = true,
		close = true,
		description = "Ja vienmēr esat vēlējies izveidot robotu, varat sākt šeit. Varbūt tu būsi jaunais Elons Masks?",
		client = {
			image = "electronickit.png",
		}
	},

	["metalscrap"] = {
		label = "Metāla Lūžņi",
		weight = 100,
		stack = true,
		close = false,
		description = "Droši vien jūs varat no tā izveidot kaut ko jauku",
		client = {
			image = "metalscrap.png",
		}
	},

	["diving_fill"] = {
		label = "Niršanas Truba",
		weight = 3000,
		stack = false,
		close = true,
		description = "Palīdzēs elpot zem ūdens...",
		client = {
			image = "diving_tube.png",
		}
	},

	["walkstick"] = {
		label = "Spieķis",
		weight = 1000,
		stack = true,
		close = true,
		description = "Vecs esi? HAHA",
		client = {
			image = "walkstick.png",
		}
	},
	
	["thermite"] = {
		label = "Termīta Bumba",
		weight = 1000,
		stack = true,
		close = true,
		description = "Dažreiz jūs vēlētos, lai viss sadeg",
		client = {
			image = "thermite.png",
		}
	},
	
	["specialbadge"] = {
		label = "Policijas žetons",
		weight = 1000,
		stack = true,
		close = true,
		description = "Speciāls žetons priekš policijas",
		client = {
			image = "thermite.png",
		}
	},

	["houselaptop"] = {
        label = "House laptop",
        weight = 1200,
        stack = false,
        close = false,
        description = "Can Probably Hack Something With This",
        client = {
            image = "houselaptop.png",
        }
    },
	["mansionlaptop"] = {
        label = "Mansion laptop",
        weight = 1200,
        stack = false,
        close = false,
        description = "Can Probably Hack Something With This",
        client = {
            image = "mansionlaptop.png",
        }
    },
	["art1"] = {
        label = "Kitty Sleeping Art",
        weight = 2500,
        stack = false,
        close = false,
        description = "This Is Too Cute",
        client = {
            image = "art1.png",
        }
    },
	["art2"] = {
        label = "Wide Eye Kitty Art",
        weight = 2500,
        stack = false,
        close = false,
        description = "This Is Too Cute",
        client = {
            image = "art2.png",
        }
    },
	["art3"] = {
        label = "Fancy Kitty Art",
        weight = 2500,
        stack = false,
        close = false,
        description = "This Is Too Cute",
        client = {
            image = "art3.png",
        }
    },
	["art4"] = {
        label = "Presidential Kitty Art",
        weight = 2500,
        stack = false,
        close = false,
        description = "Id Vote For This",
        client = {
            image = "art4.png",
        }
    },
	["art5"] = {
        label = "Obi Jesus Painting",
        weight = 2500,
        stack = false,
        close = false,
        description = "I Swore My Allegiance To The Force, To Heaven!",
        client = {
            image = "art5.png",
        }
    },
	["art6"] = {
        label = "Merp Kitty Art",
        weight = 2500,
        stack = false,
        close = false,
        description = "Merp",
        client = {
            image = "art6.png",
        }
    },
	["art7"] = {
        label = "Family Portait",
        weight = 2500,
        stack = false,
        close = false,
        description = "Smile",
        client = {
            image = "art7.png",
        }
    },
	["boombox"] = {
        label = "Boom Box",
        weight = 2500,
        stack = false,
        close = false,
        description = "How Did People Carry This",
        client = {
            image = "boombox.png",
        }
    },
	["boombox"] = {
        label = "Boom Box",
        weight = 2500,
        stack = false,
        close = false,
        description = "How Did People Carry This",
        client = {
            image = "boombox.png",
        }
    },
	["checkbook"] = {
        label = "Check Book",
        weight = 2500,
        stack = false,
        close = false,
        description = "Do People Use These?",
        client = {
            image = "checkbook.png",
        }
    },
	["mdlaptop"] = {
        label = "Slow Laptop",
        weight = 2500,
        stack = false,
        close = false,
        description = "Can I Download More Ram?",
        client = {
            image = "laptop.png",
        }
    },
	["mddesktop"] = {
        label = "Desktop",
        weight = 2500,
        stack = false,
        close = false,
        description = "I hope there isnt a virus",
        client = {
            image = "mddesktop.png",
        }
    },
	["mdmonitor"] = {
        label = "Monitor",
        weight = 2500,
        stack = false,
        close = false,
        description = "720HD bb",
        client = {
            image = "mdmonitor.png",
        }
    },
	["mdtablet"] = {
        label = "Tablet",
        weight = 2500,
        stack = false,
        close = false,
        description = "Never Will Give This Up",
        client = {
            image = "mdtablet.png",
        }
    },
	["mdspeakers"] = {
        label = "Speakers",
        weight = 2500,
        stack = false,
        close = false,
        description = "Is This Even Loud?",
        client = {
            image = "speaker.png",
        }
    },
	["engine_s"] = {
		label = "Engine S",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["engine_a"] = {
		label = "Engine A",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["engine_b"] = {
		label = "Engine B",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["engine_c"] = {
		label = "Engine C",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["engine_d"] = {
		label = "Engine D",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["transmission_s"] = {
		label = "Transmission S",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["transmission_a"] = {
		label = "Transmission A",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["transmission_b"] = {
		label = "Transmission B",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["transmission_c"] = {
		label = "Transmission C",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["transmission_d"] = {
		label = "Transmission D",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["suspension_s"] = {
		label = "Suspension S",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["suspension_a"] = {
		label = "Suspension A",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["suspension_b"] = {
		label = "Suspension B",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["suspension_c"] = {
		label = "Suspension C",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["suspension_d"] = {
		label = "Suspension D",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["brake_s"] = {
		label = "Brake S",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["brake_a"] = {
		label = "Brake A",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["brake_b"] = {
		label = "Brake B",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["brake_c"] = {
		label = "Brake C",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["brake_d"] = {
		label = "Brake D",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["turbo_s"] = {
		label = "Turbo S",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["turbo_a"] = {
		label = "Turbo A",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["turbo_b"] = {
		label = "Turbo B",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["turbo_c"] = {
		label = "Turbo C",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["turbo_d"] = {
		label = "Turbo D",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["armour_s"] = {
		label = "Armour S",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["armour_a"] = {
		label = "Armour A",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["armour_b"] = {
		label = "Armour B",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["armour_c"] = {
		label = "Armour C",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["armour_d"] = {
		label = "Armour D",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["engine_repair_kit"] = {
		label = "Engine repair kit",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["body_repair_kit"] = {
		label = "Body repair kit",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["cosmetics"] = {
		label = "Cosmetics",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
	},
	["mechanic_toolbox"] = {
		label = "Mechanics toolbox",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			export = 'mt_workshops.openToolboxMenu'
		}
	},
	["neons_controller"] = {
		label = "Neons controller",
		weight = 1000,
		stack = true,
		close = true,
		description = "",
		client = {
			export = 'mt_workshops.openLightsController'
		}
	},
	["mods_list"] = {
		label = "Vehicle mods list",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			export = 'mt_workshops.openCosmeticsMenu'
		}
	},
	["extras_controller"] = {
		label = "Vehicle extras",
		weight = 0,
		stack = true,
		close = true,
		description = "",
		client = {
			export = 'mt_workshops.openExtrasMenu'
		}
	},
	["weedbag"] = {
		label = "Sapakots zāles maisiņš",
		weight = 10,
		stack = true,
		close = true,
		description = "Sapakots zāles maisiņš",
		client = {
			image = "weedbag.png",
		}
	},


    ["repairkit"] = {
        label = "Repairkit",
        weight = 2500,
        stack = true,
        close = true,
        description = "A nice toolbox with stuff to repair your vehicle",
        client = {
            image = "repairkit.png",
        }
    },

    ["advancedrepairkit"] = {
        label = "Advanced Repairkit",
        weight = 4000,
        stack = true,
        close = true,
        description = "A nice toolbox with stuff to repair your vehicle",
        client = {
            image = "advancedkit.png",
        }
    },

	--- BLUEPRINTI

	["blueprint_browning"] = {
        label = "Browning rasējums",
        weight = 4000,
        stack = true,
        close = true,
        description = "Rasējums browning pistolei",
        client = {
            image = "blueprint_browning.png",
        }
    },

	["blueprint_dp9"] = {
        label = "DP9 rasējums",
        weight = 4000,
        stack = true,
        close = true,
        description = "Rasējums DP9 pistolei",
        client = {
            image = "blueprint_dp9.png",
        }
    },

	["blueprint_de"] = {
        label = "Desert eagle rasējums",
        weight = 4000,
        stack = true,
        close = true,
        description = "Rasējums desert eagle pistolei",
        client = {
            image = "blueprint_de.png",
        }
    },

	-- LUNAR HACK

	['blue_keycard'] = {
		label = 'Zila kartiņa',
		weight = 100,
		stack = false
	},
	
	['purple_keycard'] = {
		label = 'Violēta kartiņa',
		weight = 100,
		stack = false
	},
	
	['hack_usb'] = {
		label = 'Fantom USB',
		weight = 100,
		stack = false
	},
	
	['hack_card'] = {
		label = 'Spoofing Karte',
		weight = 100,
		stack = false
	},
	
	['coins'] = {
		label = 'Monētas',
		weight = 10,
	},
	
	['painting'] = {
		label = 'Glezna',
		weight = 100,
	},
	
	['bomb_c4'] = {
		label = 'C4 Sprāgstviela',
		weight = 3000,
	},
	
	['angle_grinder'] = {
		label = 'Leņķa Slīpmašīna',
		weight = 1500,
	},
	
	['contracts_tablet'] = {
		label = 'Planšetdators',
		weight = 200,
	},
	
	['classified_docs'] = {
		label = 'Slepeni Dokumenti',
		weight = 100,
	},
	
	['diamond_necklace'] = {
		label = 'Dimanta Kaklarota',
		weight = 100,
	},
	
	['diamonds_box'] = {
		label = 'Dimantu Kaste',
		weight = 200,
	},
	
	['luxurious_watch'] = {
		label = 'Grezns Pulkstenis',
		weight = 200,
	},
	
	['rare_coins'] = {
		label = 'Retas Monētas',
		weight = 500,
	},
	
	['diamond_ring'] = {
		label = 'Dimanta Gredzens',
		weight = 50,
	},
	
	['gold_bar'] = {
		label = 'Zelta Stienis',
		weight = 500,
	},
	
	["large_drill"] = {
		label = "Liela Urbjmašīna",
		weight = 12500,
		stack = true,
		close = true,
	},

	['basic_rod'] = { label = 'Makšķere', stack = false, weight = 1000 },

	['graphite_rod'] = { label = 'Grafīta Makšķere', stack = false, weight = 1500 },
	
	['titanium_rod'] = { label = 'Titāna Makšķere', stack = false, weight = 2000 },
	
	['worms'] = { label = 'Tārpi', weight = 10 },
	
	['artificial_bait'] = { label = 'Mākslīgā ēsma', weight = 30 },
	
	['anchovy'] = { label = 'Anšovi', weight = 20 },
	
	['grouper'] = { label = 'Grupētājs', weight = 3500 },
	
	['haddock'] = { label = 'Pikša', weight = 500 },
	
	['mahi_mahi'] = { label = 'Mahi Mahi', weight = 3500 },
	
	['piranha'] = { label = 'Piranja', weight = 1500 },
	
	['red_snapper'] = { label = 'Sarkanais Snappers', weight = 2500 },
	
	['salmon'] = { label = 'Lasis', weight = 1000 },
	
	['shark'] = { label = 'Haizivs', weight = 7500 },
	
	['trout'] = { label = 'Forele', weight = 750 },
	
	['tuna'] = { label = 'Tuna', weight = 10000 },

	["stolen_package"] = {
		label = "Nozagta paciņa",
		weight = 100,
		stack = false,
		close = false,
		description = "Varētu būt vērtīga?",
		client = {
			usetime = 3000,
		},
		server = {
			export = 'xt-porchpirate.stolen_package'
		}
	},
	

    ["weed_skunk_seed"] = {
        label = "Skunk Seed",
        weight = 0,
        stack = true,
        close = true,
        description = "A weed seed of Skunk",
        client = {
            image = "weed_seed.png",
        }
    },

    ["weed_ak47_seed"] = {
        label = "AK47 Seed",
        weight = 0,
        stack = true,
        close = true,
        description = "A weed seed of AK47",
        client = {
            image = "weed_seed.png",
        }
    },

    ["wine"] = {
        label = "Wine",
        weight = 300,
        stack = true,
        close = false,
        description = "Some good wine to drink on a fine evening",
        client = {
            image = "wine.png",
        }
    },

    ["weed_purple-haze_seed"] = {
        label = "Purple Haze Seed",
        weight = 0,
        stack = true,
        close = true,
        description = "A weed seed of Purple Haze",
        client = {
            image = "weed_seed.png",
        }
    },

    ["weed_og-kush_seed"] = {
        label = "OGKush Seed",
        weight = 0,
        stack = true,
        close = true,
        description = "A weed seed of OG Kush",
        client = {
            image = "weed_seed.png",
        }
    },

    ["weed_amnesia_seed"] = {
        label = "Amnesia Seed",
        weight = 0,
        stack = true,
        close = true,
        description = "A weed seed of Amnesia",
        client = {
            image = "weed_seed.png",
        }
    },

    ["weed_white-widow_seed"] = {
        label = "White Widow Seed",
        weight = 0,
        stack = true,
        close = false,
        description = "A weed seed of White Widow",
        client = {
            image = "weed_seed.png",
        }
    },

    ["weed_og-kush"] = {
        label = "OGKush 2g",
        weight = 200,
        stack = true,
        close = false,
        description = "A weed bag with 2g OG Kush",
        client = {
            image = "weed_baggy.png",
        }
    },

    ["jerry_can"] = {
        label = "Jerrycan 20L",
        weight = 20000,
        stack = true,
        close = true,
        description = "A can full of Fuel",
        client = {
            image = "jerry_can.png",
        }
    },

	['pickaxe'] = {
		label = 'Cērtnis',
		weight = 325,
		stack = true,
		degrade = 30, -- Tas ir laiks minūtēs, kurā cērte sabojājas līdz 0
		decay = true -- Šī ir funkcija, kas dzēš priekšmetu, kad izturība sasniedz 0 (ox_inventory v2.31.0 vai vēlāk)
	},
	
	['scrap_metal'] = {
		label = 'Metāla lūžņi',
		weight = 280,
		stack = true,
	},
	
	['stone'] = {
		label = 'Akmens',
		weight = 265,
		stack = true,
	},
	
	['raw_copper'] = {
		label = 'Neapstrādāts varš',
		weight = 245,
		stack = true,
	},
	
	['raw_iron'] = {
		label = 'Neapstrādāts dzelzs',
		weight = 225,
		stack = true,
	},
	
	['raw_steel'] = {
		label = 'Neapstrādāts tērauds',
		weight = 210,
		stack = true,
	},
	
	['raw_silver'] = {
		label = 'Neapstrādāts sudrabs',
		weight = 190,
		stack = true,
	},
	
	['raw_gold'] = {
		label = 'Neapstrādāts zelts',
		weight = 190,
		stack = true,
	},
	
	['raw_diamond'] = {
		label = 'Neapstrādāts dimants',
		weight = 165,
		stack = true,
	},
	
	['raw_emerald'] = {
		label = 'Neapstrādāts smaragds',
		weight = 140,
		stack = true,
	},
	
	['copper'] = {
		label = 'Varš',
		weight = 225,
		stack = true,
	},
	
	['iron'] = {
		label = 'Dzelzs',
		weight = 200,
		stack = true,
	},
	
	['steel'] = {
		label = 'Tērauds',
		weight = 190,
		stack = true,
	},
	
	['silver'] = {
		label = 'Sudrabs',
		weight = 175,
		stack = true,
	},
	
	['gold'] = {
		label = 'Zelts',
		weight = 155,
		stack = true,
	},
	
	['diamond'] = {
		label = 'Dimants',
		weight = 140,
		stack = true,
	},
	
	['emerald'] = {
		label = 'Smaragds',
		weight = 125,
		stack = true,
	},

	['wood'] = {
		label = 'Koks',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	
	['metal'] = {
		label = 'Metāls',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	
	['rope'] = {
		label = 'Virve',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	
	['shovel'] = {
		label = 'Lāpsta',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	
}