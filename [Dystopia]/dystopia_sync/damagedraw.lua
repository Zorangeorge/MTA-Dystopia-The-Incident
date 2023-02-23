--[[
idstable = { --vehicle ids table -- do not change order, it is co-dependent with namestbl below 
		 "482",
		 "440",
		 "558",
		 "541",
		 "426",
		 "602",
		 "600",
		 "401",
		 "518",
		 "496",
		 "479",
		 "527",
		 "580",
		 "575",
		 "542",
		 "445",
		 "489",
		 "400",
		 "422",
		 "589",
		 "466",
		 "504",
		 "478",
		 "514",
		 "408",
		 "467",
		 "536",
		 "500",
		 "475",
		 "402",
		 "434",
		 "552",
		 "528",
		 "508",
		 "459",
		 "470",
		 "484",
		 "454",
		 "554",
		 "523",
		 "525",
		 "515",
		 "463",
		 "468",
		 "586",
		 "581",
		 "471",
		 "481",
		 "510",
		 "413",
		 "543",
		 "530",
		 "596",
		 "598",
		 "597",
		 "407",
		 "599",
		 "473",
		 "453",
		 "472",
		 "553",
		 "512",
		 "563",
		 "487",
		 "460",
		 "548",
		 "469",
		 "443",
		 "549",
		 "403",
		 "568",
		 "537",
		 "538",
		 "521",
		 "522", -- NRG-500 entry, keep name empty, used for grapple hook
		 "464",  --RC Baron, used for mounted minigun
		 "447",
		 "442",
		"474",
		"455",
		"490",
		"416",
		"534",
		"576",
		"412",
		"476",
		"520",
		"417",
		"609",
		"498",
		"593",
		"583",
		"404",
		"458",
		"410",
		"421",
		"545",
		"414",
		"433",
		"539",
		"592",
		"456",
		"573",
		"405"
		 }
namestbl = { --vehicle custom names table
"Burrito" ,
"Reinforced Burrito" ,
"Uranus" ,
"Uranus Ram" ,
"Premier" ,
"Reinforced Premier" ,
"Picador" ,
"Reinforced Picador" ,
"Buccaneer" ,
"Reinforced Buccaneer" ,
"Regina",
"Reinforced Regina" ,
"Stafford" ,
"Reinforced Stafford" ,
"Clover" ,
"Reinforced Clover" ,
"Rancher" ,
"Reinforced Rancher" ,
"Bobcat" ,
"Reinforced Bobcat" ,
"Glendale" ,
"Reinforced Glendale" ,
"Rusty Walton" ,
"Tanker" ,
"Trashmaster" ,
"Rusty Oceanic" ,
"Rusty Blade" ,
"Mesa Rockcrawler" ,
"Sabre Supercharged" ,
"Buffalo Bonemaster" ,
"Interceptor" ,
"Flat Van" ,
"Rescue01 Van" ,
"Journey" ,
"Surveillance Van" ,
"Patriot" ,
"Yacht" ,
"Cruiser" ,
"Yosemite" ,
"HPV 1000" ,
"Towtruck" ,
"Roadtrain" ,
"Freeway" ,
"Sanchez" ,
"Wayfarer" ,
"BF 400" ,
"Quadbike" ,
"Bike" ,
"Mountain Bike" ,
"Pony" ,
"Sadler" ,
"Forklift" ,
"Police Cruiser" ,
"Police Cruiser" ,
"Police Cruiser" ,
"Firetruck" ,
"Police Ranger" ,
"Dinghy" ,
"Fishing Boat" ,
"Coastguard" ,
"Nevada" ,
"Cropduster" ,
"Raindance" ,
"Maverick" ,
"Skimmer" ,
"Cargobob" ,
"Sparrow" ,
"Siege Truck" ,
"Tampa" ,
"Linerunner" ,
"Bandito" ,
"Freight Engine" ,
"Brown Streak",
"FCR-900",
"",  -- NRG-500 entry, keep it empty, used for grapple hook
"Minigun",   -- RC Baron, used for mounted minigun
"Gunship" ,  
"Romero",
"Hermes",
"Flatbed",
"Rancher XL",
"Ambulance",
"Remington",
"Tornado",
"Voodoo",
"Rustler",
"Hydra",  
"Leviathan",
"Boxville",  
"Boxville",  
"Dodo",
"Tug",
"Perennial",
"Solair",  
"Manana",
"Washington",  
"Hustler" ,
"Mule",
"Barracks",
"Vortex" ,
"Andromada",
"Yankee",
"Dune",
"Sentinel"
}


function retrieveCustomCarName (vehicle)
		local name
		local carmodel = getElementModel(vehicle)

		for i,v in ipairs(idstable) do
			
				if tonumber(v) == carmodel then
					name = namestbl[i]
					if name then return name else outputDebugString("car name error") end
					break
				end
		end
end

]]

-- Message config
local MINIMUM_SIZE = 0.1
local MESSAGE_TIME = 1000 -- milliseconds
local VEHICLE_SCALE_MULTIPLIER = 0.7 -- 30%
--local SPACE_BETWEEN_LINES = 0.3
local DISTANCE_TO_RENDER_DAMAGE = 300 -- GTA units
local HEIGHT_OFFSET = 1--1.20
local SHADING_PER_RENDER = 7.5
local SCALE = 0.2

-- Draw function config
local DRAW_CHECK_BUILDINGS = true
local DRAW_CHECK_VEHICLES = false
local DRAW_CHECK_PEDS = false
local DRAW_CHECK_OBJECTS = false
local DRAW_CHECK_DUMMIES = false
local DRAW_SEE_THROUGH_STUFF = false
local DRAW_IGNORE_CAMERA_OBJECTS = true

local messages = { }
--local bodypart_to_bone = {[3] = 4, [4] = 24, [5] = 35, [6] = 25, [7] = 42, [8] = 52, [9] = 8}

local ChunkfiveFont = dxCreateFont ( "Chunkfive.otf", 100 )

--[[function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end]]

addEvent("sync.message", true)
addEventHandler("sync.message", root,
	function (player, r, g, b, message)
	
	if not isElement(player) then return end
		
		if player == localPlayer then 
		--triggerEvent("syncDamageValueLocalPlayer",localPlayer, localPlayer,_, _, _, message) 
		return 
		end
		
		if isElement(player) then
			if not messages[player] then
				messages[player] = {}
			end
		end

		--if type(messages[player][1]) == "table" then
			
		--end
		--if tonumber(message) and tonumber(message)~= 0 then
		messages[player][1] = { tostring(message), true, getTickCount()+MESSAGE_TIME, 255, r, g, b}
		--table.insert ( messages, { message, true, getTickCount() + 1500, 150, r, g, b, localPlayer } )
		--else
		--messages[player][1] = { tostring(message), true, getTickCount()+MESSAGE_TIME, 255, r, g, b}
		--end
		--if messages[player][2][2] and messages[player][2][2] == messages[player][1][2] then 
		--	messages[player][2][2] = nil 
		--	return 
		--else
		--messages[player][2] = messages[player][1]
		--end
	end
)

addEventHandler ( "onClientRender", root, function ( ) --STATUSINFO RENDER  
    for player in pairs ( messages ) do
    	for sindex, sdata in ipairs(messages[player]) do
	        local v1 = sdata[1] -- message
	        local v2 = sdata[2] -- bool (?)
	        local v3 = sdata[3] -- expire time
	        local v4 = sdata[4] -- alpha
	        local v5 = sdata[5] -- r
	        local v6 = sdata[6] -- g
	        local v7 = sdata[7] -- b
	        local v8 = player -- player
			
			if not isElement(v8) then
				messages[player] = nil
				return
			end
--[[	        if sindex == 1 then
	        	--y = 2
	        	SCALE = .25
	        else
	        	--y= 2.6
	        	SCALE = .10
	        end]]

	        if isElement(v8) and getElementType(v8) == "vehicle" then
	        	SCALE = SCALE * VEHICLE_SCALE_MULTIPLIER
	        end
			local x,y,z = getElementPosition(v8)
			local px,py,pz = getElementPosition(localPlayer)
			if isElement(v8) and getDistanceBetweenPoints3D(x,y,z,px,py,pz)<1 then HEIGHT_OFFSET = 0.5 end
			
--if messages[player][2] and messages[player][2] ~= v1 then
			--dxDrawTextOnElement(v8, v1, (sindex*SPACE_BETWEEN_LINES)+HEIGHT_OFFSET, DISTANCE_TO_RENDER_DAMAGE, 0, 0, 0, v4, scale, ChunkfiveFont)
			--end
			
	        dxDrawTextOnElement(v8, v1, HEIGHT_OFFSET, DISTANCE_TO_RENDER_DAMAGE, v5, v6, v7, v4, SCALE, ChunkfiveFont)
	        
	        
	        if (#messages[player] == 2 and sindex == 2) or (#messages[player] == 1) then
		        if ( getTickCount() >= v3 ) then
		            messages[player][sindex][4] = v4-SHADING_PER_RENDER
		            if ( messages[player][sindex][4] <= 0 ) then
		            	messages[player] = nil
		            end
		        end
		    end
		end
    end
end )


function dxDrawTextOnElement(element, text, height, distance, R, G, B, alpha, size, font)
	local x, y, z = getElementPosition(element)
	local x2, y2, z2 = getElementPosition(localPlayer)
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z, x2, y2, z2, DRAW_CHECK_BUILDINGS, DRAW_CHECK_VEHICLES, DRAW_CHECK_PEDS, DRAW_CHECK_OBJECTS, DRAW_CHECK_DUMMIES, DRAW_SEE_THROUGH_STUFF, DRAW_IGNORE_CAMERA_OBJECTS,ignoredElement)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if (sx and sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				scale = (size or 1)-(distanceBetweenPoints / distance)
				if scale < MINIMUM_SIZE then
					scale = MINIMUM_SIZE
				end
				height = HEIGHT_OFFSET - (distanceBetweenPoints / distance )
				dxDrawText(text, sx-2, sy-2, sx, sy, tocolor(1, 1, 1, alpha or 255), scale, font or "arial", "center", "center", false, false, false,true)
				dxDrawText(text, sx, sy, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), scale, font or "arial", "center", "center", false, false, false,true)
			end
		end
	end
end
--[[

]]
