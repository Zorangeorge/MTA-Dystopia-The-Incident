--Gate_WetCourts = createObject(975,-1863.5,1043.900390625,46.799999237061,0,0,90) 
--setElementDoubleSided(Gate_WetCourts,true)
--setObjectScale(Gate_WetCourts,1.24)

--code from Kieran/cat
MainGate = createObject(975,-1863.5,1043.900390625,46.799999237061,0,0,90)
MainCol = createColSphere ( -1863.5,1043.900390625,46.799999237061,7 )

function MainCol_open ( thePlayer, matchingDimension )
    if (getElementType(thePlayer) == "player") then 
		
		--local playerName = getPlayerName(thePlayer)
		--	if playerName == "Zorgman" then 
				moveObject(MainGate, 3000, -1863.5,1051.8000488281,46.799999237061)
				isPlayer = false
		--	else
		--		outputChatBox("Access denied.",thePlayer)
		--	end
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