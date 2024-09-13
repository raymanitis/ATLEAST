Config = Config or {}

Config.cosmetics = { -- Only remove options and change options values, don't add any and don't change the value!
    { label = 'Paints', value = 'paints', item = 'cosmetics' }, -- I advice to place this at first for a better organization
    { label = 'Wheels', value = 23, modsId = 'modFrontWheels', item = 'cosmetics' }, -- I advice to place this at first for a better organization
    { label = 'Rear Wheels', value = 24, modsId = 'modBackWheels', item = 'cosmetics' },
    { label = 'Spoiler', value = 0, modsId = 'modSpoilers', item = 'cosmetics' },
    { label = 'Front Bumper', value = 1, modsId = 'modFrontBumper', item = 'cosmetics' },
    { label = 'Rear Bumper', value = 2, modsId = 'modRearBumper', item = 'cosmetics' },
    { label = 'Skirt', value = 3, modsId = 'modSideSkirt', item = 'cosmetics' },
    { label = 'Exhaust', value = 4, modsId = 'modExhaust', item = 'cosmetics' },
    { label = 'Frame', value = 5, modsId = 'modFrame', item = 'cosmetics' },
    { label = 'Grill', value = 6, modsId = 'modGrille', item = 'cosmetics' },
    { label = 'Bonnet', value = 7, modsId = 'modHood', item = 'cosmetics' },
    { label = 'Left Wing', value = 8, modsId = 'modFender', item = 'cosmetics' },
    { label = 'Right Wing', value = 9, modsId = 'modRightFender', item = 'cosmetics' },
    { label = 'Roof', value = 10, modsId = 'modRoof', item = 'cosmetics' },
    { label = 'Horn', value = 14, modsId = 'modSideSkirt', item = 'cosmetics' },
    { label = 'Subwoofer', value = 19, modsId = 'modSubwoofer', item = 'cosmetics' },
    { label = 'Plate Holder', value = 25, modsId = 'modPlateHolder', item = 'cosmetics' },
    { label = 'Vanity Plate', value = 26, modsId = 'modVanityPlate', item = 'cosmetics' },
    { label = 'Trim A', value = 27, modsId = 'modTrimA', item = 'cosmetics' },
    { label = 'Ornaments', value = 28, modsId = 'modOrnaments', item = 'cosmetics' },
    { label = 'Dashboard', value = 29, modsId = 'modDashboard', item = 'cosmetics' },
    { label = 'Dial', value = 30, modsId = 'modDial', item = 'cosmetics' },
    { label = 'Door speakers', value = 31, modsId = 'modDoorSpeaker', item = 'cosmetics' },
    { label = 'Seats', value = 32, modsId = 'modSeats', item = 'cosmetics' },
    { label = 'Steering wheel', value = 33, modsId = 'modSteeringWheel', item = 'cosmetics' },
    { label = 'Shifter leavers', value = 34, modsId = 'modShifterLeavers', item = 'cosmetics' },
    { label = 'A Plate', value = 35, modsId = 'modAPlate', item = 'cosmetics' },
    { label = 'Speakers', value = 36, modsId = 'modSpeakers', item = 'cosmetics' },
    { label = 'Trunk', value = 37, modsId = 'modTrunk', item = 'cosmetics' },
    { label = 'Hydrolic', value = 38, modsId = 'modHydrolic', item = 'cosmetics' },
    { label = 'Engine block', value = 39, modsId = 'modEngineBlock', item = 'cosmetics' },
    { label = 'Air filter', value = 40, modsId = 'modAirFilter', item = 'cosmetics' },
    { label = 'Struts', value = 41, modsId = 'modStruts', item = 'cosmetics' },
    { label = 'Arch cover', value = 42, modsId = 'modArchCover', item = 'cosmetics' },
    { label = 'Aerials', value = 43, modsId = 'modAerials', item = 'cosmetics' },
    { label = 'Trim B', value = 44, modsId = 'modTrimB', item = 'cosmetics' },
    { label = 'Tank', value = 45, modsId = 'modTank', item = 'cosmetics' },
    { label = 'Windows', value = 46, modsId = 'modWindows', item = 'cosmetics' },
    { label = 'Door R', value = 47, modsId = 'modDoorR', item = 'cosmetics' },
    { label = 'Livery', value = 48, modsId = 'modLivery', item = 'cosmetics' },
    { label = 'Lightbar', value = 49, modsId = 'modLightbar', item = 'cosmetics' },
    { label = 'Window Tint', value = 'windowTint', modsId = 'windowTint', item = 'cosmetics' },
    { label = 'Plates', value = 'plates', modsId = 'plateIndex', item = 'cosmetics' },
}

Config.rimsCategory = { -- Only remove options and change options values and don't change the value!
    { label = 'Sport', value = 0 }, -- The price must be the same as the wheels price at Config.Cosmetics
    { label = 'Muscle', value = 1 },
    { label = 'Lowrvalueer', value = 2 },
    { label = 'SUV', value = 3 },
    { label = 'OffRoad', value = 4 },
    { label = 'Tuner', value = 5 },
    { label = 'Bike', value = 6 },
    { label = 'High End', value = 7 },
    { label = "Benny's Orignal", value = 8 },
    { label = "Benny's Bespoke", value = 9 },
    { label = "Open Wheel", value = 10 },
    { label = 'Street', value = 11 },
    { label = 'Track', value = 12 },
}

Config.horns = {
    { label = 'Stock', value = -1 },
    { label = 'Truck Horn', value = 0 },
    { label = 'Cop Horn', value = 1 },
    { label = 'Clown Horn', value = 2 },
    { label = 'Musical Horn 1', value = 3 },
    { label = 'Musical Horn 2', value = 4 },
    { label = 'Musical Horn 3', value = 5 },
    { label = 'Musical Horn 4', value = 6 },
    { label = 'Musical Horn 5', value = 7 },
    { label = 'Sad Trombone', value = 8 },
    { label = 'Classical Horn 1', value = 9 },
    { label = 'Classical Horn 2', value = 10 },
    { label = 'Classical Horn 3', value = 11 },
    { label = 'Classical Horn 4', value = 12 },
    { label = 'Classical Horn 5', value = 13 },
    { label = 'Classical Horn 6', value = 14 },
    { label = 'Classical Horn 7', value = 15 },
    { label = 'Scale - Do', value = 16 },
    { label = 'Scale - Re', value = 17 },
    { label = 'Scale - Mi', value = 18 },
    { label = 'Scale - Fa', value = 19 },
    { label = 'Scale - Sol', value = 20 },
    { label = 'Scale - La', value = 21 },
    { label = 'Scale - Ti', value = 22 },
    { label = 'Scale - Do', value = 23 },
    { label = 'Jazz Horn 1', value = 24 },
    { label = 'Jazz Horn 2', value = 25 },
    { label = 'Jazz Horn 3', value = 26 },
    { label = 'Jazz Horn Loop', value = 27 },
    { label = 'Star Spangled Banner 1', value = 28 },
    { label = 'Star Spangled Banner 2', value = 29 },
    { label = 'Star Spangled Banner 3', value = 30 },
    { label = 'Star Spangled Banner 4', value = 31 },
    { label = 'Classical Horn 8 Loop', value = 32 },
    { label = 'Classical Horn 9 Loop', value = 33 },
    { label = 'Classical Horn 10 Loop', value = 34 },
    { label = 'Classical Horn 8', value = 35 },
    { label = 'Classical Horn 9', value = 36 },
    { label = 'Classical Horn 10', value = 37 },
    { label = 'Funeral Loop', value = 38 },
    { label = 'Funeral', value = 39 },
    { label = 'Spooky Loop', value = 40 },
    { label = 'Spooky', value = 41 },
    { label = 'San Andreas Loop', value = 42 },
    { label = 'San Andreas', value = 43 },
    { label = 'Liberty City Loop', value = 44 },
    { label = 'Liberty City', value = 45 },
    { label = 'Festive 1 Loop', value = 46 },
    { label = 'Festive 1', value = 47 },
    { label = 'Festive 2 Loop', value = 48 },
    { label = 'Festive 2', value = 49 },
    { label = 'Festive 3 Loop', value = 50 },
    { label = 'Festive 3', value = 51 },
}

Config.paintsCategory = { -- Only remove options and change options values, don't add any and don't change the value!
    { label = 'Primary Color', value = 'primary', modsId = 'color1' },
    { label = 'Secondary Color', value = 'secoundary', modsId = 'color2' },
    { label = 'Pearl Color', value = 'pearl', modsId = 'pearlescentColor' },
    { label = 'Wheels Color', value = 'wheels', modsId = 'wheelColor' },
    { label = 'Interior Color', value = 'interior', modsId = 'interiorColor' },
    { label = 'Dashboard Color', value = 'dashboard', modsId = 'dashboardColor' }
}

Config.paintsTypes = {
    { label = 'Metalic', value = 'metalic' },
    { label = 'Matte', value = 'matte' },
    { label = 'Metals', value = 'metals' },
    { label = 'Chameleon', value = 'chameleon' },
}

Config.paints = {
    metalic = {
        { label = 'Black', value = 0 },
        { label = 'Carbon Black', value = 147 },
        { label = 'Graphite', value = 1 },
        { label = 'Anhracite Black', value = 11 },
        { label = 'Black Steel', value = 2 },
        { label = 'Dark Steel', value = 3 },
        { label = 'Silver', value = 4 },
        { label = 'Bluish Silver', value = 5 },
        { label = 'Rolled Steel', value = 6 },
        { label = 'Shadow Silver', value = 7 },
        { label = 'Stone Silver', value = 8 },
        { label = 'Mvaluenight Silver', value = 9 },
        { label = 'Cast Iron Silver', value = 10 },
        { label = 'Red', value = 27 },
        { label = 'Torino Red', value = 28 },
        { label = 'Formula Red', value = 29 },
        { label = 'Lava Red', value = 150 },
        { label = 'Blaze Red', value = 30 },
        { label = 'Grace Red', value = 31 },
        { label = 'Garnet Red', value = 32 },
        { label = 'Sunset Red', value = 33 },
        { label = 'Cabernet Red', value = 34 },
        { label = 'Wine Red', value = 143 },
        { label = 'Candy Red', value = 35 },
        { label = 'Hot Pink', value = 135 },
        { label = 'Pfsiter Pink', value = 137 },
        { label = 'Salmon Pink', value = 136 },
        { label = 'Sunrise Orange', value = 36 },
        { label = 'Orange', value = 38 },
        { label = 'Bright Orange', value = 138 },
        { label = 'Gold', value = 99 },
        { label = 'Bronze', value = 90 },
        { label = 'Yellow', value = 88 },
        { label = 'Race Yellow', value = 89 },
        { label = 'Dew Yellow', value = 91 },
        { label = 'Dark Green', value = 49 },
        { label = 'Racing Green', value = 50 },
        { label = 'Sea Green', value = 51 },
        { label = 'Olive Green', value = 52 },
        { label = 'Bright Green', value = 53 },
        { label = 'Gasoline Green', value = 54 },
        { label = 'Lime Green', value = 92 },
        { label = 'Mvaluenight Blue', value = 141 },
        { label = 'Galaxy Blue', value = 61 },
        { label = 'Dark Blue', value = 62 },
        { label = 'Saxon Blue', value = 63 },
        { label = 'Blue', value = 64 },
        { label = 'Mariner Blue', value = 65 },
        { label = 'Harbor Blue', value = 66 },
        { label = 'Diamond Blue', value = 67 },
        { label = 'Surf Blue', value = 68 },
        { label = 'Nautical Blue', value = 69 },
        { label = 'Racing Blue', value = 73 },
        { label = 'Ultra Blue', value = 70 },
        { label = 'Light Blue', value = 74 },
        { label = 'Chocolate Brown', value = 96 },
        { label = 'Bison Brown', value = 101 },
        { label = 'Creeen Brown', value = 95 },
        { label = 'Feltzer Brown', value = 94 },
        { label = 'Maple Brown', value = 97 },
        { label = 'Beechwood Brown', value = 103 },
        { label = 'Sienna Brown', value = 104 },
        { label = 'Saddle Brown', value = 98 },
        { label = 'Moss Brown', value = 100 },
        { label = 'Woodbeech Brown', value = 102 },
        { label = 'Straw Brown', value = 99 },
        { label = 'Sandy Brown', value = 105 },
        { label = 'Bleached Brown', value = 106 },
        { label = 'Schafter Purple', value = 71 },
        { label = 'Spinnaker Purple', value = 72 },
        { label = 'Mvaluenight Purple', value = 142 },
        { label = 'Bright Purple', value = 145 },
        { label = 'Cream', value = 107 },
        { label = 'Ice White', value = 111 },
        { label = 'Frost White', value = 112 },
    },
    matte = {
        { label = 'Black', value = 12 },  
        { label = 'Gray', value = 13 },  
        { label = 'Light Gray', value = 14 }, 
        { label = 'Ice White', value = 131 },
        { label = 'Blue', value = 83 }, 
        { label = 'Dark Blue', value = 82 },
        { label = 'Mvaluenight Blue', value = 84 },
        { label = 'Mvaluenight Purple', value = 149 },
        { label = 'Schafter Purple', value = 148 },
        { label = 'Red', value = 39 },
        { label = 'Dark Red', value = 40 },
        { label = 'Orange', value = 41 },
        { label = 'Yellow', value = 42 },
        { label = 'Lime Green', value = 55 },
        { label = 'Green', value = 128 },
        { label = 'Forest Green', value = 151 },
        { label = 'Foliage Green', value = 155 },
        { label = 'Olive Darb', value = 152 },
        { label = 'Dark Earth', value = 153 },
        { label = 'Desert Tan', value = 154 },
    },
    metals = {
        { label = 'Brushed Steel', value = 117 },
        { label = 'Brushed Black Steel', value = 118 },
        { label = 'Brushed Aluminum', value = 119 },
        { label = 'Pure Gold', value = 158 },
        { label = 'Brushed Gold', value = 159 },
    },
    chameleon = { -- (Colors Credits to https://www.gta5-mods.com/misc/Camaliao-paint-add-on)
        { label = 'Anod Red', value = 161 },
        { label = 'Anod Wine', value = 162 },
        { label = 'Anod Purple', value = 163 },
        { label = 'Anod Blue', value = 164 },
        { label = 'Anod Green', value = 165 },
        { label = 'Anod Lime', value = 166 },
        { label = 'Anod Copper', value = 167 },
        { label = 'Anod Bronze', value = 168 },
        { label = 'Anod Champagne', value = 169 },
        { label = 'Anod Gold', value = 170 },
        { label = 'Green Blue Flip', value = 171 },
        { label = 'Green Red Flip', value = 172 },
        { label = 'Green Brow Flip', value = 173 },
        { label = 'Green Turq Flip', value = 174 },
        { label = 'Green Purp Flip', value = 175 },
        { label = 'Teal Red Flip', value = 176 },
        { label = 'Turq Red Flip', value = 177 },
        { label = 'Turq Purp Flip', value = 178 },
        { label = 'Cyan Puro Flip', value = 179 },
        { label = 'Blue Pink Flip', value = 180 },
        { label = 'Blue Green Flip', value = 181 },
        { label = 'Purp Red Flip', value = 182 },
        { label = 'Purp Green Flip', value = 183 },
        { label = 'Magen Gree Flip', value = 184 },
        { label = 'Magen Yell Flip', value = 185 },
        { label = 'Burg Green Flip', value = 186 },
        { label = 'Magen Cyan Flip', value = 187 },
        { label = 'Coppe Purp Flip', value = 188 },
        { label = 'Magen Orange Flip', value = 189 },
        { label = 'Red Orange Flip', value = 190 },
        { label = 'Orange Purp Flip', value = 191 },
        { label = 'Orange Blue Flip', value = 192 },
        { label = 'White Purp Flip', value = 193 },
        { label = 'Red Rainbow Flip', value = 194 },
        { label = 'Blue Rainbow Flip', value = 195 },
        { label = 'Dark Green Pearl', value = 196 },
        { label = 'Dark Teal Pearl', value = 197 },
        { label = 'Dark Blue Pearl', value = 198 },
        { label = 'Dar Purple Pearl', value = 199 },
        { label = 'Oil Slick Pearl', value = 200 },
        { label = 'Lit Green Pearl', value = 201 },
        { label = 'Lit Blue Pearl', value = 202 },
        { label = 'Lit Purp Pearl', value = 203 },
        { label = 'Lit Pink Pearl', value = 204 },
        { label = 'Offwhite Prisma', value = 205 },
        { label = 'Pink Pearl', value = 206 },
        { label = 'Yellow Pearl', value = 207 },
        { label = 'Green Pearl', value = 208 },
        { label = 'Blue Pearl', value = 209 },
        { label = 'Cream Pearl', value = 210 },
        { label = 'White Prisma', value = 211 },
        { label = 'Graphite Prisma', value = 212 },
        { label = 'Dark Blue Prisma', value = 213 },
        { label = 'Dark Purple Prisma', value = 214 },
        { label = 'Hot Pink Prisma', value = 215 },
        { label = 'Red Prisma', value = 216 },
        { label = 'Green Prisma', value = 217 },
        { label = 'Black Prisma', value = 218 },
        { label = 'Oil Slic Prisma', value = 219 },
        { label = 'Rainbow Prisma', value = 220 },
        { label = 'Black Holo', value = 221 },
        { label = 'White Holo', value = 222 },
    }
}

Config.plates = {
    { label = 'Blue on White', value = 0 },
    { label = 'Yellow on Black', value = 1 },
    { label = 'Yellow on Blue', value = 2 },
    { label = 'Blue on White 2', value = 3 },
    { label = 'Blue on White 3', value = 4 },
    { label = 'Yankton', value = 5 },
}

Config.windowTint = {
    { label = 'Stock', value = 0 },
    { label = 'Pure black', value = 1 },
    { label = 'Dark Smoke', value = 2 },
    { label = 'Light Smoke', value = 3 },
    { label = 'Limo', value = 4 },
    { label = 'Green', value = 5 },
}

Config.neonsColors = {
    "rgb(2, 21, 255)",
    "rgb(15, 3, 255)",
    "rgb(35, 1, 255)",
    "rgb(3, 83, 255)",
    "rgb(0, 222, 140)",
    "rgb(94, 255, 1)",
    "rgb(255, 0, 0)",
    "rgb(255, 5, 190)",
    "rgb(255, 50, 100)",
    "rgb(255, 62, 0)",
    "rgb(255, 62, 0)",
    "rgb(255, 221, 0)",
    "rgb(255, 255, 255)"
}