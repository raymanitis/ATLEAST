--========================================================================================================================================================================-
--========================================================================================================================================================================-
--=========================================                                                                                      =========================================-                         
--=========================================                                                                                      =========================================-
--=========================================                                                                                      =========================================-
--========================================================================================================================================================================-
--========================================================================================================================================================================-



globalConfig = {

  language = 'en', --change with 'en' for english, 'fr' for french, 'cz' for czech, 'de' for german




      --Set up new line to add a table, xyz are the coordinate, model is the props used as table. The 3 tables for armwrestling are 

                                                    -- 'prop_arm_wrestle_01' --
                                              -- 'bkr_prop_clubhouse_arm_wrestle_01a' --
                                              -- 'bkr_prop_clubhouse_arm_wrestle_02a' --

  props = { 
  

    {x = 977.7809, y = -142.7185, z = 74.2314, model = 'prop_arm_wrestle_01'},
    {x = 0, y =0, z = 0, model = 'bkr_prop_clubhouse_arm_wrestle_01a'},
    {x = 0, y = 0, z = 0, model = 'bkr_prop_clubhouse_arm_wrestle_02a'},


  },

  showBlipOnMap = false, -- Set to true to show blip for each table

  blip = { --Blip info

    title="Arm wrestle",  
    colour=0, -- 
    id=1 

  }

}

text = { 
  ['en'] = {
    ['win'] = "You win !",
    ['lose'] = "You lost",
    ['full'] = "A wrestling match is already in progress",
    ['tuto'] = "To win, quickly press ",
    ['wait'] = "Waiting for an opponent",
  },
  ['fr'] = {
    ['win'] = "Vous avez gagné !",
    ['lose'] = "Vous avez perdu",
    ['full'] = "Un bras de fer est déjà en cours",
    ['tuto'] = "Pour gagner, appuyez rapidement sur ",
    ['wait'] = "En attente d'un adversaire",
  },
  ['cz'] = {
    ['win'] = "Vyhrál jsi !",
    ['lose'] = "Prohrál jsi",
    ['full'] = "Zápasový zápas již probíhá",
    ['tuto'] = "Chcete-li vyhrát, rychle stiskněte ",
    ['wait'] = "Čekání na protivníka",
  },
  ['de'] = {
    ['win'] = "Du hast gewinnen !",
    ['lose'] = "Du hast verloren",
    ['full'] = "Ein Wrestling Match ist bereits im Gange",
    ['tuto'] = "Um zu gewinnen, drücken Sie schnell ",
    ['wait'] = "Warten auf einen Gegner",
  },

}