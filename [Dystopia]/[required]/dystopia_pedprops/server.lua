maskTable = {}
vestTable = {}

vestTable["khakivest"] = {1922, 3, 90}
vestTable["estabvest"] = {1923, 3, 90}
vestTable["blackvest"] = {1924, 3, 90}

maskTable["vendetta"] = {1455, 1, 90}
maskTable["gasmask"] = {1487, 1, 90}
maskTable["cowboy"] = {1543, 1, 90}
maskTable["bloodhokey"] = {1951, 1, 90}
maskTable["bag"] = {1551, 1, 90}
maskTable["biomask"] = {1669, 1, 90}
maskTable["respirator"] = {1854, 1, 90}

local obj = {}
local vest = {}

--[[function mask_remove()
	if obj[source] then
		exports.bone_attach:detachElementFromBone(obj[source])
		destroyElement(obj[source])
		obj[source] = nil
	end
end
addEvent("removemask", true)
addEventHandler("removemask", root, mask_remove)

function vest_remove()
	if vest[source] then
		exports.bone_attach:detachElementFromBone(vest[source])
		destroyElement(vest[source])
		vest[source] = nil
	end
end
addEvent("removevest", true)
addEventHandler("removevest", root, vest_remove)]]--

function mask_add(element, name)
	if (name == "none") then return end
	
	if obj[element] then
		destroyElement(obj[element])
	end
	
	local t = maskTable[name]	
	local objeid = t[1]
	local bodyattach = t[2]
	local zROT = t[3]
	obj[element] = createObject(objeid, 0, 0, 0, 0, 0, 0)
	exports.bone_attach:attachElementToBone(obj[element], element, bodyattach, 0, 0, -0.61, 0, 0, zROT)
end

function vest_add(element, name)
	if (name == "none") then return end
	
	if vest[element] then
		destroyElement(vest[element])
	end
	
	local t = vestTable[name]	
	local objeid = t[1]
	--local bodyattach = t[2]
	--local zROT = t[3]
	vest[element] = createObject(objeid, 0, 0, 0, 0, 0, 0)
	exports.bone_attach:attachElementToBone(vest[element], element, 3, -0.03, 0, -0.55, -0.5, 2, 90)
	
	--if getElementType(element) == "ped" then setPedArmor(element, 50) end
end

function clearPedAccessories()
	if getElementType(source) == "ped" then
		if obj[source] then
			exports.bone_attach:detachElementFromBone(obj[source])
			destroyElement(obj[source])
			obj[source] = nil
		end
		if vest[source] then
			exports.bone_attach:detachElementFromBone(vest[source])
			destroyElement(vest[source])
			vest[source] = nil
		end
	end
end
addEventHandler("onElementDestroy", root, clearPedAccessories)
--addEventHandler("onPedWasted", root, clearPedAccessories)

function quitPlayer()
	if obj[source] then
		destroyElement(obj[source])
		obj[source] = nil
	end
	if vest[source] then
		destroyElement(vest[source])
		vest[source] = nil
	end
end
addEventHandler("onPlayerQuit", root, quitPlayer)

function setPlayerProp(player, command, proptype, name)
	if (proptype) and (name) then
		if (proptype == "vest") then
			if vestTable[name] then
				vest_add(player, name)
			end
		elseif (proptype == "mask") then
			if maskTable[name] then
				mask_add(player, name)
			end
		end
	end
end
addCommandHandler("giveprop", setPlayerProp)

function table.random(theTable)
	return theTable[math.random(#theTable)]
end

local gasmasks_tbl = {"none", "gasmask", "respirator", "biomask"}
--local trooperhead_tbl = {"respirator"}
local civvests_tbl = {"none", "khakivest", "blackvest"}
local raiderhead_tbl = {"none", "gasmask", "respirator", "biomask", "bloodhokey"}
local militiahead_tbl = {"none", "respirator", "biomask", "cowboy", "gasmask"}
local nomadhead_tbl = {"none", "gasmask", "respirator", "biomask", "bag"}
local bandithead_tbl = {"none", "gasmask", "respirator", "biomask", "cowboy"}
local heavytrooperhead_tbl = {"none", "cowboy", "respirator", "biomask"}

addEvent("PropPed")
addEventHandler("PropPed", root,
	function()
		local ped = source
		local rand1 = math.random(0, 1)
		local rand2 = math.random(0, 1)
		local name = getElementData(ped, "name")
		if name == "Trooper" then
			if rand1 > 0 then
				vest_add(ped, "khakivest")
			end
		elseif name == "Peacekeeper" then
			if rand1 > 0 then
				mask_add(ped, table.random(gasmasks_tbl))
			end
			vest_add(ped, "estabvest")
		elseif name == "Heavy Trooper" then
			vest_add(ped, "khakivest")
			if rand1 > 0 then
				local mask = table.random(heavytrooperhead_tbl)
				mask_add(ped, mask)
			end
		elseif name == "R/01 Spec" then
			vest_add(ped, "estabvest")
			if rand1 > 0 then
				mask_add(ped, "biomask")
			end
		elseif name == "R/01 Agent" then
			if rand1 > 0 then
				vest_add(ped, "estabvest")
			end
			if rand2 > 0 then
				mask_add(ped, "biomask")
			end
		elseif name == "R/01 Operator" then
			vest_add(ped, "estabvest")
			if rand1 > 0 then
				mask_add(ped, "biomask")	
			end
		elseif name == "R/01 Grunt" then
			if rand1 > 0 then
				vest_add(ped, "estabvest")
			end
			if rand2 > 0 then
				mask_add(ped, "biomask")
			end
		elseif name == "Raider Barker" or name == "Raider Mongrel" then
			if rand1 > 0 then
				local mask = table.random(raiderhead_tbl)
				if mask ~= "none" then 
					mask_add(ped, mask)
					setElementData(ped, "name", "Raider Hound", true)
					setElementHealth(ped, 130)
				end
			end
			if rand2 > 0 then
				local vest = table.random(civvests_tbl)
				if vest ~= "none" then 
					vest_add(ped, vest)
					setElementData(ped, "name", "Raider Pitdog", true)
					setElementHealth(ped, 160)
				end
			end
		elseif name == "Nomad" or name == "Thug" or name == "Robber" then
			if rand1 > 0 then
				mask_add(ped, table.random(nomadhead_tbl))
			end
			if rand2 > 0 then
				vest_add(ped, table.random(civvests_tbl))
			end
		elseif name == "Bandit" then
			if rand1 > 0 then
				local mask = table.random(raiderhead_tbl)
				if mask ~= "none" then 
					mask_add(ped, mask)
					--setElementData(ped, "name", "Bandit Heavy", true)
					setElementHealth(ped, 130)
				end
			end
			if rand2 > 0 then
				local vest = table.random(civvests_tbl)
				if vest ~= "none" then 
					vest_add(ped, vest)
					setElementData(ped, "name", "Bandit Veteran", true)
					setElementHealth(ped, 160)
				end
			end
		elseif name == "Militia" then
			if rand1 > 0 then
				mask_add(ped, table.random(militiahead_tbl))
			end
			if rand2 > 0 then
				local vest = table.random(civvests_tbl)
				if vest ~= "none" then
					vest_add(ped, vest)
					setElementData(ped, "name", "Militia Ranger", true)
					setElementHealth(ped, 180)
				end
			end
		elseif name == "Guard" or name == "Scavenger" then
			if rand1 > 0 then
				vest_add(ped, table.random(civvests_tbl))
			end
		elseif name == "Wastelander" then
			if rand1 > 0 then
				mask_add(ped, "cowboy")
				vest_add(ped, table.random(civvests_tbl))
			end
		end
	end
)