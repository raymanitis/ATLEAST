Config = {}

-- Set the cost of the DMV test
Config.DMVTestPrice = 500

-- Set the maximum number of mistakes allowed to pass the test
Config.MaxMistakes = 3

-- DMV test questions
Config.Questions = {
    {
        question = "Kāds ir ātruma ierobežojums apdzīvotās vietās ?",
        answers = {
            "50 km/h", 
            "60 km/h", 
            "70 km/h"
        },
        correctAnswer = 1
    },
    {
        question = "Ko darīt, ja gaismas signāls ir zaļš, bet priekšā esošais transports neizkustas?",
        answers = {
            "Jāgaida, līdz transporta līdzeklis izkustas", 
            "Jābūt pacietīgam un jāgaida", 
            "Jāapgriežas un jāmeklē cita ceļa izvēle"
        },
        correctAnswer = 2
    },
    {
        question = "Cik metru attālumā no gājēju pārejas ir jānovieto automobilis, lai ievērotu drošību?",
        answers = {
            "5 metri", 
            "10 metri", 
            "15 metri"
        },
        correctAnswer = 2
    },
    {
        question = "Kas jāņem vērā, ja pie krustojuma nav ceļa zīmju?",
        answers = {
            "Jāievēro priekšrocība, kas norādīta uz ceļa", 
            "Jāievēro vispārīgās ceļu satiksmes noteikumi", 
            "Jāapstājas un jāizvērtē situācija"
        },
        correctAnswer = 2
    },
    {
        question = "Kā jāuzvedas, kad redzat ceļa zīmi ar uzrakstu 'Dodiet ceļu'?",
        answers = {
            "Jāapstājas un jāļauj citiem transportlīdzekļiem pārvietoties", 
            "Jābrauc ātrāk, lai nepalaistu garām", 
            "Jāpalēnina ātrumu un jāvērtē situācija"
        },
        correctAnswer = 1
    },
    {
        question = "Ko nozīmē ceļa zīme 'Stāvvieta tikai iedzīvotājiem'?",
        answers = {
            "Stāvvieta ir pieejama tikai ar īpašu atļauju", 
            "Stāvvieta ir bezmaksas visiem", 
            "Stāvvieta ir tikai atsevišķos laikos"
        },
        correctAnswer = 1
    },
    {
        question = "Kad ir atļauts izmantot mobilo telefonu, braucot ar automobili?",
        answers = {
            "Ja tiek izmantots hands-free iekārta", 
            "Ja tiek lietots tikai īsziņas", 
            "Ja neviens cits nav tuvumā"
        },
        correctAnswer = 1
    },
    {
        question = "Ko darīt, ja braucot ar automobili sākat izjust dzinēja problēmas?",
        answers = {
            "Jācenšas novērst problēmu pašam",
            "Jābrauc tālāk, līdz sasniegsit tuvāko servisu", 
            "Jāapstājas un jāizsauc palīdzība", 
        },
        correctAnswer = 3
    },
    {
        question = "Kāds ir minimālais augstums, lai būtu obligāti jālieto drošības josta priekšējā sēdeklī?",
        answers = {
            "1,35 metri", 
            "1,50 metri", 
            "1,70 metri"
        },
        correctAnswer = 1
    },
    {
        question = "Kā jāizvēlas drošības jostas bērniem automobiļa aizmugurējās sēdekļos?",
        answers = {
            "Atkarībā no bērna vecuma un svara", 
            "Atkarībā no automobiļa markas", 
            "Atkarībā no bērna auguma"
        },
        correctAnswer = 1
    },
    {
        question = "Ko darīt, ja krustojumā ir šķērsošanas ceļa zīme 'Apgriezšanās aizliegta'?",
        answers = {
            "Jābrauc tālāk, pat ja nav iespējas apgriezties",
            "Jāapgriežas, ja ceļa apstākļi to atļauj", 
            "Jāievēro aizliegums un jāmeklē alternatīvs ceļš",
        },
        correctAnswer = 3
    }
    -- Add more questions here
}

-- Ped location and properties
Config.DMVPed = {
    model = 's_m_y_cop_01', -- Ped model (change to desired ped model)
    location = { x = -552.07, y = -191.79, z = 37.22, heading = 190.23 }, -- Ped location and heading
    animation = {
        dict = 'amb@world_human_cop_idles@male@idle_b', -- Animation dictionary
        name = 'idle_e', -- Animation name
        flag = 49 -- Animation flag (optional)
    }
}