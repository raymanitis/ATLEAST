return {

	---------------------------------------------------- PD

	{
        coords = vec3(475.8371, -996.5598, 25.2542),  -- Stash coordinates
        target = {
            loc = vec3(475.8371, -996.5598, 25.2542),  -- Target coordinates for interaction
            length = 1.2,
            width = 1,
            heading = 0,
            minZ = 24.0,
            maxZ = 26.0,
            label = '[1] Ieroči'
        },
        name = 'police_shared_stash1',  -- Unique identifier for the stash
        label = '[1] Ieroči',  -- Display name
        owner = false,  -- Shared stash
        slots = 200,  -- Number of slots
        weight = 1000000,  -- Maximum weight in grams
        groups = {['police'] = 1}  -- Accessible by police job
    },

	{
        coords = vec3(475.9567, -993.7631, 25.2542),  -- Stash coordinates
        target = {
            loc = vec3(475.9567, -993.7631, 25.2542),  -- Target coordinates for interaction
            length = 1.2,
            width = 1,
            heading = 0,
            minZ = 24.0,
            maxZ = 26.0,
            label = '[2] Narkotikas'
        },
        name = 'police_shared_stash2',  -- Unique identifier for the stash
        label = '[2] Narkotikas',  -- Display name
        owner = false,  -- Shared stash
        slots = 200,  -- Number of slots
        weight = 1000000,  -- Maximum weight in grams
        groups = {['police'] = 1}  -- Accessible by police job
    },

	{
        coords = vec3(471.9107, -993.8668, 25.2542),  -- Stash coordinates
        target = {
            loc = vec3(471.9107, -993.8668,25.2542),  -- Target coordinates for interaction
            length = 1.2,
            width = 1,
            heading = 0,
            minZ = 24.0,
            maxZ = 26.0,
            label = '[3] Laupijums'
        },
        name = 'police_shared_stash3',  -- Unique identifier for the stash
        label = '[3] Laupijums',  -- Display name
        owner = false,  -- Shared stash
        slots = 200,  -- Number of slots
        weight = 1000000,  -- Maximum weight in grams
        groups = {['police'] = 1}  -- Accessible by police job
    },

	{
        coords = vec3(471.8283, -996.6674, 25.2542),  -- Stash coordinates
        target = {
            loc = vec3(471.8283, -996.6674, 25.2542),  -- Target coordinates for interaction
            length = 1.2,
            width = 1,
            heading = 0,
            minZ = 24.0,
            maxZ = 26.0,
            label = '[4] Zādzību rīki'
        },
        name = 'police_shared_stash4',  -- Unique identifier for the stash
        label = '[4] Zādzību rīki',  -- Display name
        owner = false,  -- Shared stash
        slots = 200,  -- Number of slots
        weight = 1000000,  -- Maximum weight in grams
        groups = {['police'] = 1}  -- Accessible by police job
    },

    {
        coords = vec3(474.0197, -994.0684, 25.2542),  -- Stash coordinates
        target = {
            loc = vec3(474.0197, -994.0684, 25.2542),  -- Target coordinates for interaction
            length = 1.2,
            width = 1,
            heading = 0,
            minZ = 24.0,
            maxZ = 26.0,
            label = '[5] Miskaste'
        },
        name = 'police_shared_stash5',  -- Unique identifier for the stash
        label = '[5] Miskaste',  -- Display name
        owner = false,  -- Shared stash
        slots = 200,  -- Number of slots
        weight = 1000000,  -- Maximum weight in grams
        groups = {['police'] = 1}  -- Accessible by police job
    },

    {
        coords = vec3(474.0388, -996.7119,25),  -- Stash coordinates
        target = {
            loc = vec3(474.0388, -996.7119, 25),  -- Target coordinates for interaction
            length = 1.2,
            width = 1,
            heading = 0,
            minZ = 24.0,
            maxZ = 26000.0,
            label = '[6] Bosa skapis'
        },
        name = 'police_shared_stash6',  -- Unique identifier for the stash
        label = '[6] Bosa skapis',  -- Display name
        owner = false,  -- Shared stash
        slots = 200,  -- Number of slots
        weight = 1000000,  -- Maximum weight in grams
        groups = {['police'] = 8}  -- Accessible by police job
    },

    {
        coords = vec3(461.4114, -986.3000, 29.6242),  -- Stash coordinates
        target = {
            loc = vec3(461.4114, -986.3000, 29.6242),  -- Target coordinates for interaction
            length = 1.2,
            width = 1,
            heading = 0,
            minZ = 24.0,
            maxZ = 26.0,
            label = '[7] Bosa skapis'
        },
        name = 'police_shared_stash7',  -- Unique identifier for the stash
        label = '[7] Bosa skapis',  -- Display name
        owner = false,  -- Shared stash
        slots = 200,  -- Number of slots
        weight = 1000000,  -- Maximum weight in grams
        groups = {['police'] = 8}  -- Accessible by police job
    },

	-- {
	-- 	coords = vec3(452.3, -991.4, 30.7),
	-- 	target = {
	-- 		loc = vec3(451.25, -994.28, 30.69),
	-- 		length = 1.2,
	-- 		width = 5.6,
	-- 		heading = 0,
	-- 		minZ = 29.49,
	-- 		maxZ = 32.09,
	-- 		label = 'Open personal locker'
	-- 	},
	-- 	name = 'policelocker',
	-- 	label = 'Personal locker',
	-- 	owner = true,
	-- 	slots = 70,
	-- 	weight = 70000,
	-- 	groups = shared.police
	-- },

	

	--------------------------------------------------------------
	-- {
	-- 	coords = vec3(301.3, -600.23, 43.28),
	-- 	target = {
	-- 		loc = vec3(301.82, -600.99, 43.29),
	-- 		length = 0.6,
	-- 		width = 1.8,
	-- 		heading = 340,
	-- 		minZ = 43.34,
	-- 		maxZ = 44.74,
	-- 		label = 'Open personal locker'
	-- 	},
	-- 	name = 'emslocker',
	-- 	label = 'Personal Locker',
	-- 	owner = true,
	-- 	slots = 70,
	-- 	weight = 70000,
	-- 	groups = {['ambulance'] = 0}
	-- },
}