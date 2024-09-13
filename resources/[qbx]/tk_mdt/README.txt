Hey! Thanks for purchasing my script. Remember:
   	- You are not allowed to resell or release my scripts

Requirements:
   	- es_extended / qb-core
   	- MySQL / oxmysql

Installing the script:
   	1. Download the file and extract "tk_mdt" into your resources folder
   	2. Add "start tk_mdt" into your server.cfg file
   	3. Import the SQL file(s) into your server's database
   	4. Edit config.lua to your liking
    	4.5. In-game images:
			Sing up at Fivemanage, create a team, login to your account, go to the tokens page, create a new token and paste the token to tk_mdt/config_sv.lua -> ConfigSV.FivemanageToken
			https://docs.fivemanage.com/getting-started
   	5. Restart your server

More questions?
   	- Join our Discord and open a ticket: https://discord.gg/YndnF9tkqu

Documentation:
    - https://tk-scripts.gitbook.io/docs/tk_mdt

Items (ox_inventory):
	["pol_mdt"] = {
		label = "Police MDT",
		weight = 200,
		stack = true,
		close = true,
	},

	["ems_mdt"] = {
		label = "EMS MDT",
		weight = 200,
		stack = true,
		close = true,
	},

	["citizen_mdt"] = {
		label = "Citizen MDT",
		weight = 200,
		stack = true,
		close = true,
	},
   