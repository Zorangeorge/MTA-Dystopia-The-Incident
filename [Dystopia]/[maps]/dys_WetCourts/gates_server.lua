--[[function StartResource()
outputChatBox("http://Rick - Load new gate.")
end
StartResource()]]--<--original credits

--Gate_WetCourts = createObject(975,-1863.5,1043.900390625,46.799999237061,0,0,90) 

--setElementDoubleSided(Gate_WetCourts,true)
--setObjectScale(Gate_WetCourts,1.24)

--kieran
MainGate = createObject(975,-1863.5,1043.900390625,46.799999237061,0,0,90)
MainCol = createColSphere ( -1863.5,1043.900390625,46.799999237061,7 )

function MainCol_open ( thePlayer, matchingDimension )
    if (getElementType(thePlayer) == "player") then 
		
		local playerName = getPlayerName(thePlayer)
			if playerName == "Myrfin" or playerName == "Cat" or playerName == "Raven" or playerName == "Herrjors" or playerName == "Karim" or playerName == "Zorgman" then 
				moveObject(MainGate, 3000, -1863.5,1051.8000488281,46.799999237061)
				isPlayer = false
			else
				outputChatBox("Access denied.",thePlayer)
			end
    end
	
end
addEventHandler ( "onColShapeHit", MainCol, MainCol_open )

function MainCol_close ( thePlayer, matchingDimension )
	
	local players = getElementsWithinColShape ( source )
	if players then for _,player in ipairs(players) do if getElementType(player)== "player" then isPlayer = true end  end end -- :P
	if isPlayer then
		return
	end 
	
	if (getElementType(thePlayer) == "player") then 
        moveObject(MainGate, 3000, -1863.5,1043.900390625,46.799999237061)
    end
	
end
addEventHandler ( "onColShapeLeave", MainCol, MainCol_close )

--
--[[
Gate_WetCourts_ColShape = createColSphere ( -1863.5,1043.900390625,46.799999237061,7 )
local Gate_WetCourts_Animation = false

local x,y,z = -1863.5,1051.8000488281,46.799999237061
local x1,y1,z1 = -1863.5,1043.900390625,46.799999237061

function Toggle_Gate_WetCourts(toggle,anim_time)

outputDebugString("toggle success:")

	if toggle == true and Gate_WetCourts_Animation == false then
		outputDebugString("1")
		Gate_WetCourts_Animation = true
		moveObject(Gate_WetCourts,anim_time,x1,y1,z1)
		setTimer ( function () Gate_WetCourts_Animation = false outputDebugString("anim false") end, anim_time, 1)
		setTimer ( Toggle_Gate_WetCourts, anim_time, 1,false,anim_time )
		
		
	elseif toggle == false and Gate_WetCourts_Animation == false then
		outputDebugString("2")
		Gate_WetCourts_Animation = true
		moveObject(Gate_WetCourts,anim_time,x,y,z)
		setTimer ( function () Gate_WetCourts_Animation = false outputDebugString("anim false 2")  end, anim_time, 1)
		
	end
	
end	

function Gate_WetCourts_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
 outputDebugString("col hit")
	Toggle_Gate_WetCourts(true,5000) --movement duration time
    end
end
addEventHandler("onColShapeHit",Gate_WetCourts_ColShape,Gate_WetCourts_ColShapeEnter)

function Gate_WetCourts_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
  outputDebugString("col leave")
	Toggle_Gate_WetCourts(false,5000) --movement duration time
    end
end
addEventHandler("onColShapeLeave",Gate_WetCourts_ColShape,Gate_WetCourts_ColShape_Leave)
]]