-- Plugin made by LagParty, do whatever you want with it.

-- tagName is a string with the tag used on your vehicle_names.xml file
local tagName = "whatever"
local rootElement = getRootElement()

--[[
-- This function loads the xml info into two tables.
function loadXml()
	local i = 0

	-- We are looking for a specific tag inside the file
	local xmlRoot = xmlLoadFile("vehicle_names.xml")
	local xmlTag = xmlFindChild(xmlRoot, "group", i)
	local xmlName = xmlNodeGetAttribute(xmlTag, "name")
	
	while xmlName ~= tagName do
		xmlTag = xmlFindChild( xmlRoot, "group", i)
		xmlName = xmlNodeGetAttribute(xmlTag, "name")
		i = i+1;
	end
	
	-- We found it, lets load them into the tables.
	i = 0
	
	-- These are global values, one stores the car id's on integers (for faster comparison)
	-- and the other stores the car names on strings.
	idstable = {}
	namestbl = {}
	
	-- Copy the info one by one.
	local xmlCars = xmlFindChild(xmlTag, "vehicle", i)
	
	while xmlCars do 
		table.insert( idstable, tonumber(xmlNodeGetAttribute(xmlCars, "id")))
		table.insert( namestbl, xmlNodeGetAttribute(xmlCars, "name"))
		i = i+1
		xmlCars = xmlFindChild(xmlTag, "vehicle", i)
	end
	
	-- Close the file.
	xmlUnloadFile(xmlRoot)
	
end
addEventHandler("onResourceStart", rootElement, loadXml)
]]

-- This function checks if it's necessary to call the client event to show the custom text.
function carEnterHandle(theVehicle)

	setPlayerHudComponentVisible (source, "vehicle_name", false)
	
	for i,v in ipairs(idstable) do
	
		if tonumber(v)==getElementModel(theVehicle) then
					
			triggerClientEvent(source, "ShowCustomCarName", rootElement, namestbl[i])
			break
		end
	end
end
addEventHandler ("onPlayerVehicleEnter", rootElement, carEnterHandle)


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
