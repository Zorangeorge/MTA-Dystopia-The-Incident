    addEvent("SPAWNLOOT", true)
	
	local padding = 1
	local paddingdivider = math.random(2,4)
	
function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end
--[[-- Get the position of a point 3 units to the right of the element:
x,y,z = getPositionFromElementOffset(element,3,0,0)

-- Get the position of a point 2 units in front of the element:
x,y,z = getPositionFromElementOffset(element,0,2,0)

-- Get the position of a point 1 unit above the element:
x,y,z = getPositionFromElementOffset(element,0,0,1)]]
    
    function spawnitemsserver (source, lx, ly, lz)
    
       --[[ --EXAMPLE for zone specific loot
	   --check loot spawn zone 
	   if getZoneName (lx, ly, lz) == "Uber OP ZOn3" then
        
          if getElementModel(source) == 2977 then --kmilitary_crate -> blue metal crate, military loot
        
            loot = createObjectItem( table.random(uberOPw3ap0ns), lx, ly, lz+0.2, 97.3,120, math.random(0,359), 0, 0)
            
            elseif getElementModel(source) == 2971 then --k_smashboxes -> large cardboard boxes
            
            loot = createObjectItem( table.random(uberOPg3ar), lx, ly, lz+0.2, 97.3,120, math.random(0,359), 0, 0)
            
			--- and so on
             
          end ]]
		  
       --else 
	   
                if  getElementModel(source) == 2977 then --kmilitary_crate -> blue metal crate, military loot
                
                    loot = createObjectItem( table.random(militaryloot), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
						local randnum = math.random(0,2)
						if randnum < 2 then loot2 = createObjectItem( table.random(militaryloot), lx+(padding/paddingdivider), ly+(padding/paddingdivider), lz, 97.3,120, math.random(0,359), 0, 0) end
                    
                    elseif getElementModel(source) == 2971 then --k_smashboxes -> large cardboard boxes
                    
                    loot = createObjectItem( table.random(heavyduty), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
						local randnum = math.random(0,2)
						if randnum < 2 then loot2 = createObjectItem( table.random(heavyduty), lx+(padding/paddingdivider), ly+(padding/paddingdivider), lz, 97.3,120, math.random(0,359), 0, 0) end
                    
                    elseif getElementModel(source) == 1431 then --DYN_BOX_PILE -> five wooden crates piled up
                    
                    loot = createObjectItem( table.random(residentialgarage), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
						local randnum = math.random(0,2)
						if randnum < 2 then loot2 = createObjectItem( table.random(residentialgarage), lx+(padding/paddingdivider), ly+(padding/paddingdivider), lz-0.55, 97.3,120, math.random(0,359), 0, 0) end
                
                    elseif getElementModel(source) == 1440 then --DYN_BOX_PILE_3 -> garbage bags cardboard crates pile, hardest to break with no weapons
                    
                    loot = createObjectItem( table.random(residentialhousehold), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
						local randnum = math.random(0,2)
						if randnum < 2 then loot2 = createObjectItem( table.random(residentialhousehold), lx+(padding/paddingdivider), ly+(padding/paddingdivider), lz, 97.3,120, math.random(0,359), 0, 0) end
                    
                    elseif getElementModel(source) == 1438 then --DYN_BOX_PILE_2 -> (only) cardboard crates pile
                    
                    loot = createObjectItem( table.random(officedistrict), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
						local randnum = math.random(0,2)
						if randnum < 2 then loot2 = createObjectItem( table.random(officedistrict), lx+(padding/paddingdivider), ly+(padding/paddingdivider), lz, 97.3,120, math.random(0,359), 0, 0) end

                    elseif getElementModel(source) == 1441 then --DYN_BOX_PILE_4 -> wood plank cardboard crates pile
                    
                    loot = createObjectItem( table.random(residentialgarage), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
						local randnum = math.random(0,2)
						if randnum < 2 then loot2 = createObjectItem( table.random(residentialgarage), lx+(padding/paddingdivider), ly+(padding/paddingdivider), lz-0.65, 97.3,120, math.random(0,359), 0, 0) end
					
					elseif getElementModel(source) == 1429 then --DYN_TV -> broken TV -> good for electric parts drop; any other objects like it?
                    
                    loot = createObjectItem( "Scrap Metal", lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
                    
                    elseif getElementModel(source) == 1421 then --DYN_BOXES -> two wooden and one cardboard box; breaks in smaller pieces/boxes, might be good for ammo drops and smaller items
                    
                    loot = createObjectItem( table.random(residentialweapons), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
						local randnum = math.random(0,2)
                    	if randnum < 2 then loot2 = createObjectItem( table.random(residentialweapons), lx+(padding/paddingdivider), ly+(padding/paddingdivider), lz-0.76, 97.3,120, math.random(0,359), 0, 0) end

                    elseif getElementModel(source) == 2968 then --cm_box -> smallest cardboard box; breaks very easy, good for low level/food loot and smaller items; movable
                    
                    loot = createObjectItem( table.random(foodandwater), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
                    
                    elseif getElementModel(source) == 2900 then --temp_cardbox -> one large cardboard box; breaks very easy, good for low level loot; movable
                    
                    loot = createObjectItem( table.random(officedistrict), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
                    
                    elseif getElementModel(source) == 1230 then --cardboardbox -> small cardboard box; breaks very easy, good for low level loot; movable
                    
                    loot = createObjectItem( table.random(foodandwater), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
                    
                    elseif getElementModel(source) == 1265 then --BlackBag2 -> garbage bag; breaks hard(??), good for low level loot; movable
                    
                    loot = createObjectItem( table.random(garbage), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
                    
                    elseif getElementModel(source) == 1264 then --BlackBag1 -> garbage bag; breaks hard(??), good for low level loot; movable
                    
                    loot = createObjectItem( table.random(garbage), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
                    
                    elseif getElementModel(source) == 1224 then --woodenbox -> one wooden box; movable
                    
                    loot = createObjectItem( table.random(heavyduty), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
                    
                    elseif getElementModel(source) == 1558 then --CJ_CARDBRD_PICKUP -> medium cardboard box on a pallet
                    
                    loot = createObjectItem( table.random(medicalloot), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
                    	local randnum = math.random(0,2)
					if randnum < 2 then loot2 = createObjectItem( table.random(medicalloot), lx+(padding/paddingdivider), ly+(padding/paddingdivider), lz, 97.3,120, math.random(0,359), 0, 0) end
                    
                    elseif getElementModel(source) == 1220 then --cardboardbox2 -> small cardboard box
                    
                    loot = createObjectItem( table.random(foodandwater), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
                    
                    elseif getElementModel(source) == 1221 then --cardboardbox4 -> medium cardboard box
                    
                    loot = createObjectItem( table.random(foodandwater), lx, ly, lz, 97.3,120, math.random(0,359), 0, 0)
					
					elseif checkagainsttable(getElementModel(source),woodobjects) == true then
						loot = createObjectItem( "Wood", lx,ly,lz, 97.3,120, math.random(0,359), 0, 0)
					elseif checkagainsttable(getElementModel(source),scrapmetalobjects) == true then
						loot = createObjectItem( "Scrap Metal", lx,ly,lz, 97.3,120, math.random(0,359), 0, 0)
					elseif checkagainsttable(getElementModel(source),complexmetalobjects) == true then
						loot = createObjectItem( "Scrap Metal", lx,ly,lz, 97.3,120, math.random(0,359), 0, 0)
						local randnum = math.random(0,2)
                    	if randnum < 2 then loot2 = createObjectItem( "Wire", lx+(padding/paddingdivider), ly+(padding/paddingdivider), lz, 97.3,120, math.random(0,359), 0, 0) end
					elseif checkagainsttable(getElementModel(source),woodmetalobjects) == true then
						loot = createObjectItem( "Wood", lx,ly,lz, 97.3,120, math.random(0,359), 0, 0)
						local randnum = math.random(0,2)
                    	if randnum < 2 then loot2 = createObjectItem( "Scrap Metal", lx+(padding/paddingdivider), ly+(padding/paddingdivider), lz, 97.3,120, math.random(0,359), 0, 0) end
					elseif checkagainsttable(getElementModel(source),dispenserobjects) then
					outputDebugString("vending machine breaks")
						--local randnum = math.random(0,2)
                    	--if randnum < 2 then
						local fx,fy,fz = getPositionFromElementOffset(source,0,-1,0)
						outputDebugString("vending machine item spawns")
						loot = createObjectItem( table.random(dispenseritems), fx,fy, lz, 97.3,120, math.random(0,359), 0, 0)-- end
						
                end
             end 
    addEventHandler("SPAWNLOOT", root, spawnitemsserver)    
    


	
    function destroyLoot (loot)
        if (isElement(loot) == true) and (getElementData(loot,"item_inventory")) then
            destroyElement(loot)
            else outputDebugString("loot wasn't properly destroyed") return
        
        end
    end

function setupStrongboxNodes()

local allObjects = getElementsByType("object")
outputDebugString("loading strongbox nodes...")	
	
	for _,obj in ipairs(allObjects) do 

		if getElementModel(obj) == 964  then
			createStrongboxNode(obj)
		end
	
	end
	
end	

function createStrongboxNode (obj)

		local x,y,z = getElementPosition(obj)
		local strongboxcolshape =  createColSphere(x,y,z,1.9)
		attachElements(strongboxcolshape,obj,0,0,0.5)
		setElementData(strongboxcolshape, "strongboxnode", true,true)
		detachElements(strongboxcolshape,obj)

end

addEventHandler( "onResourceStart", resourceRoot, setupStrongboxNodes )

addEvent("RespawnLootObjectInSync",true)

function respawnLootObjectForAll(obj)

respawnObject ( obj )

local objmodel = getElementModel(obj)
			if objmodel == 2977 
			or objmodel == 2971 
			or objmodel == 1431
			or objmodel == 1440
			or objmodel == 1438
			or objmodel == 1441
			or objmodel == 1429
			or objmodel == 1421
			or objmodel == 2968
			or objmodel == 2900
			or objmodel == 1230
			or objmodel == 1265
			or objmodel == 1264
			or objmodel == 1224
			or objmodel == 1558
			or objmodel == 1220
			or objmodel == 1221 
			then
			setTimer(setElementHealth,3000,1,obj,1)
			end

end

addEventHandler("RespawnLootObjectInSync",root,respawnLootObjectForAll)


-- #bugfix

respawnTimers = {}
addEvent("loot.respawnTimer", true)
addEventHandler("loot.respawnTimer", root,
	function (timeleft, object)
		--outputChatBox("got to server")
		if not respawnTimers[client] then
			respawnTimers[client] = {}
		end
		table.insert(respawnTimers[client], {getRealTime().timestamp+timeleft, object})
	end
)

addEventHandler("onPlayerQuit", root,
	function ()
		--print (#respawnTimers[source])
		if not respawnTimers[source] then return end
		for k, d in ipairs(respawnTimers[source]) do
			if getRealTime().timestamp < d[1] then
				local timeleft = d[1] - getRealTime().timestamp
				setTimer(respawnLootObjectForAll, timeleft, 1, d[2])
				--outputServerLog("timer will be fired in "..tostring(timeleft).." seconds.")
			end
			table.remove(respawnTimers, k)
		end
	end
)