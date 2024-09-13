Config = {
    FrameworkLoadinEvent = 'QBCore:Client:OnPlayerLoaded',
    peds = {
         ['1'] = {
            label = 'Runāt ar svešinieku',
            icon = 'fa-solid fa-comment',
            model = "a_m_m_beach_01",
            coords = vector3(-469.3886, -230.6185, 36.2363),
            heading = 115.9684,
            data = {
                firstname = 'Juris',
                lastname = 'Kalns',
                text = 'Yoo čari, ko gribi ?',
                buttons = {
                    { 
                        text = 'Sveiks bračiņ, nezini kur nopelnīt ?',
                        data = {
                            text = 'Ak pelnīt gribi, nuu nezinu, es tev ieteikt paprovēt zvejot.',
                            buttons = {
                                {
                                    text = 'Aaa okej, paldies par padomu.',
                                    close = true
                                },
                            }
                        } 
                    },
                    { 
                        text = 'Labs ir, atvaino es došos.', 
                        close = true 
                    },
                }
            }
        },

        ['2'] = {
            label = 'Runāt ar svešinieku',
            icon = 'fa-solid fa-comment',
            model = "ig_djgeneric_01",
            coords = vector3(393.7173, -1929.1169, 24.7096),
            heading = 82.5698,
            data = {
                firstname = 'Džeims',
                lastname = 'Rūtiņš',
                text = 'Kas i ko puišel ? Ko lupī ?',
                buttons = {
                    { 
                        text = 'Viss labi, es tikai vēlejos uzjautāt nezini kur piestrādāt te ?',
                        data = {
                            text = 'Te kaut kur netālu fujaks piedāvā narkotikas vedāt, bet neatceros īsti kur.',
                            buttons = {
                                {
                                    text = 'Paldies pa info, pameklēšu.',
                                    close = true
                                },
                            }
                        } 
                    },
                    { 
                        text = 'Sori sori, labi atvaino.', 
                        close = true 
                    },
                }
            }
        },
    }
}


