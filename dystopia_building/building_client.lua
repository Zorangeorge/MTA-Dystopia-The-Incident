
addEvent("PlayerIsPlacingObject",true)
addEvent("PlayerFinishedPlacingObject",true)

local current_placing_obj = nil
local build_placement_light = nil

function startDrawingLine()
current_placing_obj = source
addEventHandler("onClientRender",root,renderDXLine)
end

function stopRenderingDXLine()
current_placing_obj = nil
removeEventHandler("onClientRender",root,renderDXLine)
if isElement(build_placement_light) then destroyElement(build_placement_light) end
build_placement_light = nil

end

function renderDXLine()
local x,y,z = getElementPosition(localPlayer)
local tx,ty,tz = getElementPosition(current_placing_obj)
local r,g,b
local building_object_blocked = false
local building_object_toofar = false
local building_object_toohigh = false
local player_closing_distance_limit = false

--bool isLineOfSightClear ( float startX, float startY, float startZ, float endX, float endY, float endZ, [ bool checkBuildings = true, bool checkVehicles = true, bool checkPeds = true, bool checkObjects = true, bool checkDummies = true, bool seeThroughStuff = false, bool ignoreSomeObjectsForCamera = false, element ignoredElement = nil ] )

if not isLineOfSightClear(x,y,z,tx,ty,tz,true,true,true,true,false,true,false,current_placing_obj) then building_object_blocked = true end
if getDistanceBetweenPoints3D(x,y,z,tx,ty,tz) > getElementRadius(current_placing_obj) then building_object_toofar = true end
if tz-z > getElementRadius(current_placing_obj) then building_object_toohigh = true end
if getDistanceBetweenPoints3D(x,y,z,tx,ty,tz)-getElementRadius(current_placing_obj) > 4 then player_closing_distance_limit = true end
	if getDistanceBetweenPoints3D(x,y,z,tx,ty,tz)-getElementRadius(current_placing_obj) > 8 then --player got too far, cancel building
		triggerServerEvent("ClientCancelledPlacement",current_placing_obj)
		stopRenderingDXLine()
		if isElement(build_placement_light) then destroyElement(build_placement_light); build_placement_light = nil end
		return
	end
	
	if building_object_toofar or building_object_blocked or building_object_toohigh then 
		r,g,b =  248, 30, 0
		if getElementData(current_placing_obj,"canBeBuilt") then setElementData(current_placing_obj,"canBeBuilt",nil,true) end
	else
		r,g,b = 0,255,0
		if not getElementData(current_placing_obj,"canBeBuilt") then setElementData(current_placing_obj,"canBeBuilt",true,true) end
	end
	
	if player_closing_distance_limit then 
		r,g,b = 255,0,0 
		if getElementData(current_placing_obj,"canBeBuilt") then setElementData(current_placing_obj,"canBeBuilt",nil,true) end
	end
	
dxDrawLine3D(x,y,z,tx,ty,tz,tocolor(r,g,b))
if isElement(build_placement_light) then destroyElement(build_placement_light) end
build_placement_light = createLight(0, x,y,z+2, 20, r,g,b, 0, 0, 0, true) 

end




addEventHandler("PlayerIsPlacingObject",root,startDrawingLine)
--addEventHandler("PlayerFinishedPlacingObject",root,destroyLights)
addEventHandler("PlayerFinishedPlacingObject",root,stopRenderingDXLine)

--build_placement_light = createLight(0, x, y, z, 6, 255, 0, 0, 0, 0, 0, true)
--build_placement_light = createLight(0, x, y, z, 6, 255, 0, 0, 0, 0, 0, true)
--if isElement(light) then destroyElement(light) end
