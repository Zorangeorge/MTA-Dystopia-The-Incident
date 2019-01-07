--[[

Forest Generator v1.0.0
autor: Essle Jaxcate | essle.55@yandex.ru

[serverside]

]]

--

local generatedObjects = {}

--

local objectsList = { --first number is the object id, the second is the z adjustment 3593, 3594, 12957
	
	
	
	 
	
	
--[[--overgrowth
{856,0.3}, --ferns, grass and stumps
	{871,0.0}, 
	{801,0.6}, 
	{808,0.2}, 
	{809,0.2}, 
	{802,0.1}, 
	{822,1.1}, 
	{820,1.1}, 
	{833,0.1}, 
	{835,0.5}, 
	{839,0.3}, 
	{840,0.3},
	{841,0.1},	
	{842,0.1}, 
	{844,0.3}, 
	{671,0.1},
	{874,0.5}, --proc grass added 10 times for more density
	{874,0.5},
	{874,0.5},
	{874,0.5},
	{874,0.5},
	{874,0.5},
	{874,0.5},
	{874,0.5},
	{874,0.5},
	{874,0.5},
	{874,0.5},
	{872,0.3},
	
	{703,0.2}, --trees
	{691,0.3}, 
	
	{882,0.2}, -- _PO trees
	{883,0.2}, 
	{884,0.2}, 
	{885,0.2}, 
	{892,0.2}, 
	{895,0.2}, 
	
	{647,0.5}, --bushes
	{825,0.5},
	{800,0.8},
	{803,0.8},
	{805,0.8}]]
	
	{823,0.2}, --all marsh plants
	{671,0.1},
	{827,0.2},
	{808,0.2},
	{806,0.2},
	{855,0.2}, --reeds
	{855,0.2}, --reeds
	{855,0.2}, --reeds
	{872,0.2},--reeds
	{872,0.2},--reeds
	{872,0.2}--reeds
	
	

--[[	{ 2670, -0.1 }, -- trash
	{ 2671, -0.1 },
	{ 2674, -0.1 },
	{ 2675, -0.1 },
	{ 2676, -0.1 },
	{ 18099, -0.1 },
	{ 18100, -0.1 },
	{ 18101, -0.1 },
	{ 849, -0.1 },
	{ 850, -0.1 },
	{ 851, -0.1 },
	{ 852, 0.15 },
	{ 853, -0.1 },
	{ 854, -0.1 }]]
	
		
	--[[{ 3593, -0.5 }, -- wreck vehicles
	{ 3594, -0.5 },
	{ 12957, -0.5 }]]
	
	--[[{ 727, 0.2 }, -- original trees
	{ 729, 0.2 },
	{ 730, 0.2 },
	{ 732, 0.2 },
	{ 763, 0.2 },
	{ 764, 0.2 },
	{ 765, 0.2 },
	{ 766, 0.2 },
	{ 767, 0.2 },
	{ 768, 0.2 },
	{ 769, 0.2 },
	{ 770, 0.2 },
	{ 770, 0.2 },
	{ 771, 0.2 },
	{ 772, 0.2 },
	{ 773, 0.2 },
	{ 774, 0.2 },
	{ 775, 0.2 },
	{ 776, 0.2 },
	{ 777, 0.2 },
	{ 778, 0.2 },
	{ 779, 0.2 },
	{ 780, 0.2 },
	{ 781, 0.2 },
	{ 782, 0.2 }, ]]
}

--

addEvent("call.generateObjects", true)
addEventHandler("call.generateObjects", root, function(list)

	for _, theObject in ipairs(generatedObjects) do
		theObject:destroy()
	end

	generatedObjects = {}

	for _, thePosition in ipairs(list) do
		local tree = objectsList[math.random(1, #objectsList)]
		table.insert(generatedObjects, Object(tree[1], thePosition[1], thePosition[2], thePosition[3] - tree[2], 0.0, 0.0, math.random(0, 359)))
	end

	outputChatBox("Generated "..#generatedObjects.." objects", source)
	outputDebugString("Generated "..#generatedObjects.." objects")

	-- export

	local map = xmlCreateFile("mapoutput.map", "map")

	for theId, theSubject in ipairs(generatedObjects) do

		local node = xmlCreateChild(map, "object")
		local rX, rY, rZ = getElementRotation(theSubject, "ZXY") 

		xmlNodeSetAttribute(node, "id", "objGen-"..theId)
		xmlNodeSetAttribute(node, "model", theSubject.model)
		xmlNodeSetAttribute(node, "posX", math.rang(theSubject.position.x))
		xmlNodeSetAttribute(node, "posY", math.rang(theSubject.position.y))
		xmlNodeSetAttribute(node, "posZ", math.rang(theSubject.position.z))
		xmlNodeSetAttribute(node, "rotX", math.rang(rX))
		xmlNodeSetAttribute(node, "rotY", math.rang(rY))
		xmlNodeSetAttribute(node, "rotZ", math.rang(rZ))
		xmlNodeSetAttribute(node, "breakable", "false")
		xmlNodeSetAttribute(node, "doublesided", "false")
		xmlNodeSetAttribute(node, "interior", 0)
		xmlNodeSetAttribute(node, "dimension", 0)
		xmlNodeSetAttribute(node, "scale", 1)
		xmlNodeSetAttribute(node, "alpha", 255)

	end

	xmlSaveFile(map)
	xmlUnloadFile(map)

end)

--

function math.rang(a)

	return string.format("%.6f", a)

end