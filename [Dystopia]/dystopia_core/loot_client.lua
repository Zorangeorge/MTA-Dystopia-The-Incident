  function respawnIt (source)
		 triggerServerEvent("RespawnLootObjectInSync",localPlayer,source)
		setElementData(source,"itemsspawned",false,true) 
  end

objectsRespawnTime =   600000 ---- RESPAWN TIME OF THE LOOT BOXES -- 600000 is 10 minutes	
 
respawnTimers = {}
 function spawnitems()
--[[	--explosive barrels (they should not give fuel when exploded)
	if getElementModel(source) == 1225 then 	
	--SAM sites (they should not work if destroyed)
	if getElementModel(source) == 3267 or getElementModel(source) == 3884 ]]
	if not source then return end
	setElementData(source,"destroyed",true,true); 
	setTimer(function() if not source then return end setElementData(source,"destroyed",false,true) end,objectsRespawnTime,1)
 
	if getElementData(source,"itemsspawned") == true then 
		return 
	else
	
    local lx,ly,lz = getElementPosition(source)
	local groundz = getGroundPosition(lx,ly,lz+1)
    destroyElement (source)
    triggerServerEvent ("SPAWNLOOT", source, source, lx, ly, groundz)
    setTimer( respawnIt, objectsRespawnTime, 1, source)
    --#BUG: if player disconnects after breaking a loot node, object never respawns, since timer is client-sided; solutions: 1. create the timer server-side (potentially stressful on the server if many players break many loot nodes) or 2. leave it client-side BUT transfer it to server if client disconnects; solved by Ares as #2 
	setElementData(source,"itemsspawned",true,true)
	triggerServerEvent("loot.respawnTimer", resourceRoot, objectsRespawnTime, source)

	--outputChatBox("broke")
    end
end
addEventHandler ("onClientObjectBreak", root, spawnitems)


-- #BUGFIX:
-- addEventHandler("onClientResourceStop", resourceRoot,
-- 	function ()
-- 		for k, data in ipairs(respawnTimers) do
-- 			outputChatBox("respawntimers")
-- 			if isTimer(data[1]) then
-- 				outputChatBox("timer is there")
-- 				timeleft = getTimerDetails(data[1])
-- 				triggerServerEvent("loot.respawnTimer", root, timeleft, data[2])
-- 			end
-- 		end
-- 	end
-- )



--[[local playerslootmarker = nil
local playerslootobject = nil
local playersloottext = nil
local handleradded = false
local objtype
local r,g,b,a 
local loottextcheck

function drawPlayersLootText (text)
if playerslootmarker then
playersloottext = dxDrawTextOnElement(playerslootmarker,objtype,0.12,30,255,255,255,200,1,"pricedown")
end
end

function addWorldMarkerIfLootNode (obj) --creates a marker for two seconds above loot objects when they are targeted

		if not obj then 
				
				if handleradded then
				removeEventHandler("onClientRender",root,drawPlayersLootText)
				playerslootobject = nil 
				handleradded = false
				end
				
				if playerslootmarker then 
				setTimer(destroyElement,3000,1,playerslootmarker)
				playerslootmarker = nil
				end
				
				if playersloottext then
				destroyElement(playersloottext)
				playersloottext = nil
				end
				
				return
				
				
		else
					if getElementType(obj)~= "object" then
					return
					
					else
					local objmodel = getElementModel(obj)
									
					if 	   objmodel == 2977 
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
						or objmodel == 1224
						or objmodel == 1558
						or objmodel == 1220
						or objmodel == 1221
						then 
							objtype = "looT"; r,g,b,a = 255,255,255,255; loottextcheck = true 
							--outputDebugString("Object health is: "..getElementHealth(obj).."")
					
					elseif 	objmodel == 1217 
						or objmodel == 3633 
						or objmodel == 935 
						or objmodel == 3632 
						then 
							objtype = "fuel"; r,g,b,a = 255,130,1,255; loottextcheck = true 
					
					elseif 	objmodel == 964 
						then 
							objtype = "strongbox"; r,g,b,a = 33,64,95,255; loottextcheck = true 
					
					elseif 	objmodel == 1264 
						--or  objmodel == 1265
						then 
							objtype = "stockpile"; r,g,b,a = 33,64,95,255; loottextcheck = true 
					
					elseif 	objmodel == 1411 
						then 
							objtype = "wire fence"; r,g,b,a = 33,64,95,255; loottextcheck = true

					elseif 	objmodel == 1449 
						then 
							objtype = "barricade"; r,g,b,a = 33,64,95,255; loottextcheck = true
							
					elseif 	objmodel == 12957 
						or  objmodel == 3593
						or  objmodel == 3594
						then 
							objtype = "wreck"; r,g,b,a = 80,57,49,255; loottextcheck = true 
					
					elseif 	objmodel == 11631 
						
						then 
							objtype = "radio station"; r,g,b,a = 141,236,120,255; loottextcheck = true 
					end
					
					if loottextcheck == true then
						local x,y,z = getElementPosition(obj)
						local px,py,pz = getElementPosition(localPlayer)
						playerslootobject = obj
						
							if playerslootmarker then 
							destroyElement(playerslootmarker)
							end							
							playerslootmarker = createMarker ( x, y, pz+0.95, "arrow", 0.2, r,g,b,a, localPlayer)
							drawPlayersLootText()
																			
							if not handleradded then 
								addEventHandler("onClientRender",root,drawPlayersLootText)	
								handleradded = true
	 						end
						loottextcheck = false
					end
					
			end
		end
	
end
addEventHandler ("onClientPlayerTarget",root,addWorldMarkerIfLootNode)]]