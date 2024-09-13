---@type table<string, Job>
return {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Freelancer',
                payment = 200
            },
        },
	},
	['police'] = {
        label = 'LSPD',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = {
                name = 'Kadets',
                payment = 800
            },
            [1] = {
                name = 'Virsnieks',
                payment = 1000
            },
            [2] = {
                name = 'Vecākais Virsnieks',
                payment = 1200
            },
            [3] = {
                name = 'Korporālis',
                payment = 1400
            },
            [4] = {
                name = 'Seržants',
                payment = 1600
            },
            [5] = {
                name = 'Leitnants',
                payment = 1800
            },
            [6] = {
                name = 'Kapteinis',
                payment = 2000
            },
            [7] = {
                name = 'Komandieris',
                bankAuth = true,
                payment = 2200
            },
            [8] = {
                name = 'Priekšnieka Vietnieks',
                bankAuth = true,
                payment = 2400
            },
            [9] = {
                name = 'Priekšnieks',
                isboss = true,
                bankAuth = true,
                payment = 2600
            },
        },
    }, 
	['ambulance'] = {
		label = 'EMS',
        type = 'ems',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'Paramedic',
                payment = 75
            },
			[2] = {
                name = 'Doctor',
                payment = 100
            },
			[3] = {
                name = 'Surgeon',
                payment = 125
            },
			[4] = {
                name = 'Chief',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
        type = 'realestate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'House Sales',
                payment = 75
            },
			[2] = {
                name = 'Business Sales',
                payment = 100
            },
			[3] = {
                name = 'Broker',
                payment = 125
            },
			[4] = {
                name = 'Manager',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'Driver',
                payment = 75
            },
			[2] = {
                name = 'Event Driver',
                payment = 100
            },
			[3] = {
                name = 'Sales',
                payment = 125
            },
			[4] = {
                name = 'Manager',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
	},
    ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Driver',
                payment = 50
            },
		},
	},
	['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'Showroom Sales',
                payment = 75
            },
			[2] = {
                name = 'Business Sales',
                payment = 100
            },
			[3] = {
                name = 'Finance',
                payment = 125
            },
			[4] = {
                name = 'Manager',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
        type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Recruit',
                payment = 50
            },
			[1] = {
                name = 'Novice',
                payment = 75
            },
			[2] = {
                name = 'Experienced',
                payment = 100
            },
			[3] = {
                name = 'Advanced',
                payment = 125
            },
			[4] = {
                name = 'Manager',
                isboss = true,
                bankAuth = true,
                payment = 150
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Judge',
                payment = 300
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Associate',
                payment = 300
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Journalist',
                payment = 300
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Driver',
                payment = 300
            },
        },
	},
	['tow'] = {
		label = 'Towing',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Driver',
                payment = 300
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Collector',
                payment = 300
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Picker',
                payment = 300
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Sales',
                payment = 300
            },
        },
	},
    ['uwu'] = {
		label = 'Uwu Cafe',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Darbinieks',
                payment = 300
            },
        },
	},

    ['vpburgershot'] = {
		label = 'Burgerhsot',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            [0] = {
                name = 'Darbinieks',
                payment = 300
            },
            [1] = {
                name = 'Priekšnieks',
                isboss = true,
                bankAuth = true,
                payment = 300
            },
        },
	},

    ['hayes'] = {
        label = 'TsyTunes',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [1] = {
                name = 'Māceklis',
                payment = 50
            },
            [2] = {
                name = 'Mehāniķa palīgs',
                payment = 100
            },
            [3] = {
                name = 'Kvalificēts mehāniķis',
                payment = 150
            },
            [4] = {
                name = 'Pieredzējis mehāniķis',
                payment = 200
            },
            [5] = {
                name = 'Mehāniķu uzraugs',
                payment = 250
            },
            [6] = {
                name = 'Priekšnieks',
                isboss = true,
                bankAuth = true,
                payment = 300
            },
        },
	},


}
