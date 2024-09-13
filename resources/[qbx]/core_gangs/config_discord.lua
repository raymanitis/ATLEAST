ConfigDiscord = {
    DiscordLogEnable = false, -- to enable the discord logs.

    DiscordMsgColor = 16494651, -- Color of the message 
    DiscordUsername = 'Core Gangs', -- Name of the sender
    DiscordAvatar   = '', -- Avatar link of the sender

    DiscordLogs = {
        -- Log when a n organization is created
        ['OrganizationCreated'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**New organization created**',
            Text = 'Organization {{orgName}} has just been **created**.\nOrganisation informations:\nName: {{orgName}}\nColor: {{orgColor}}\nImage: {{orgImage}}\n\nOwner of the organization information:\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}'    
        },

        -- Log when a player join an organisation
        ['OrganizationJoined'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**Player joined an organization**',
            Text = 'Organization **{{orgName}}** has just been **joined** by the player **{{criminalName}}**:\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}'    
        },

        -- Log when a player leave an organisation
        ['OrganizationLeaved'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**Player leaved an organization**',
            Text = 'Organization **{{orgName}}** has just been **leaved** by the player **{{criminalName}}**:\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}'    
        },

        -- Log when a player start a war start
        ['WarStart'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**War start**',
            Text = 'A war for the zone **{{zoneId}}** has just been started by the criminal **{{criminalName}}** who is in the organization **{{orgName}}**.\n\n__Player infos:__\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}'    
        },

        -- Log when a war is end and which organizaiton win
        ['WarWin'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**War win**',
            Text = 'The war for the zone **{{zoneId}}** has just been **won** by the **{{orgName}}** organization with **{{warPoint}}** points'
        },

        -- Log when a criminal profil is created
        ['CriminalsCreated'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**Criminal profil created**',
            Text = 'A player has just **created** a profil with the name **{{criminalName}}**.\nPlayer infos:\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}'    
        },

        -- Log for bounty create
        ['BountyCreated'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**Bounty Created**',
            Text = 'A bounty as just been **created** by the criminals **{{criminalName}}** against the criminals **{{targetCriminalName}}** for **{{bountyAmount}}** bitcoin.\nCreator Infos:\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}\n\nOther player Infos:\n__Player source:__ {{targetSource}}\n__Player citizenid:__ {{targetCitizenid}}\n__Player Name:__ {{targetCriminalName}}'
        },

        -- Log for bounty create
        ['BountyAutoCreated'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**Auto Bounty Created**',
            Text = 'An auto bounty as just been **created** against the criminals {{criminalName}} for killing someone in continental zone.\n\nPlayer Infos:\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}\n\nOther player Infos:\n__Player source:__ {{targetSource}}\n__Player citizenid:__ {{targetCitizenid}}\n__Player Name:__ {{targetCriminalName}}'
        },

        -- Log for bounty create
        ['BountyEnded'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**Bounty ended**',
            Text = 'A bounty as just been **ended** by the criminals {{criminalName}} and won {{bountyAmount}}. It was against the criminals {{targetCriminalName}}.\nWinner Infos:\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}\n\nOther player Infos:\n__Player source:__ {{targetSource}}\n__Player citizenid:__ {{targetCitizenid}}\n__Player Name:__ {{targetName}}'    
        },

        -- Log for bounty death
        ['BountyWipePlayerLog'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**PLAYER WIPE due to death with bounty**',
            Text = 'This player was **removed** from the database because he died with a bounty on his head.\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}'    
        },

        -- Log for bounty death inventory wipe
        ['BountyInventoryWipePlayerLog'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**PLAYER inventory WIPE due to death with bounty**',
            Text = 'This player inventory was **wipe** because he died with a bounty on his head.\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}'
        },

        -- Log when organization is remove automatically when last member leave it (see config to enable this feature)
        ['OrganizationRemoveAutomatically'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**Organization {{orgName}} has been remove**',
            Text = 'The organization {{orgName}} has been **removed** from the database because every player of the organization leave it.\nThe last player to leave it was:\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}'    
        },

        -- Log when organization is transfert to another player with command setorgowner
        ['OrganizationOwnerSwitchByCommand'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**Organization {{orgName}} owner has been updated to {{citizenid}}**',
            Text = 'The organization {{orgName}} owner has been **updated** to a new one via command.\n\nNew owner:\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}\n\nLast owner:\n__Player citizenid:__ {{targetCitizenid}}\n__Player Name:__ {{targetName}}'    
        },

        -- Log when organization is transfert to another player when the owner leave it (see config to enable this feature)
        ['OrganizationOwnerSwitchAutomatically'] = {
            Enable = false,
            ChannelWebHook = 'PUT YOUR LINK HERE',
            Title = '**Organization {{orgName}} owner has been updated to {{newOwnerIdentifier}}**',
            Text = 'The organization {{orgName}} owner has been **updated** to a new one since last owner quit the organziation.\n\nLast owner:\n__Player source:__ {{source}}\n__Player citizenid:__ {{citizenid}}\n__Player Name:__ {{name}}\n\nNew owner:\n__Player citizenid:__ {{targetCitizenid}}\n__Player Name:__ {{targetName}}'    
        }
    }
}
