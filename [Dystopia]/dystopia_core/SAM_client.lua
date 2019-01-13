allSAMTimers = { }

addEvent ( "destroyTrespasser", true )
function launchZeMissileeeiz (player,SAMcolshape)
	
	local x,y,z = getElementPosition(SAMcolshape)
	local isInResArea = getElementData ( localPlayer, "inRestrictedArea" )
	local rotZ = getPedRotation ( localPlayer )
	local SAMObj = getElementData(SAMcolshape,"SAMObject")
		
	if isInResArea and getPedOccupiedVehicle ( localPlayer ) and not getElementData(SAMObj,"destroyed") then
		allSAMTimers[SAMcolshape] = setTimer ( createProjectile, 10000, 0, localPlayer, 20, x,y,z+6, 1.0, localPlayer, 0, 0, rotZ, 0.1, 0.1, 0.1 )
		--setElementData(SAMcolshape,"active",true)
		--allSAMTimers[SAMcolshape] = SAMtimer
		--table.insert(allSAMTimers,SAMtimer)
	end
	
end
addEventHandler ( "destroyTrespasser", root, launchZeMissileeeiz)

addEvent ( "destroyTimer", true )

addEventHandler ( "destroyTimer", root,
	function (SAMcol)
		
		local isInResArea = getElementData ( localPlayer, "inRestrictedArea" )

			if isTimer(allSAMTimers[SAMcol]) then 
				killTimer(allSAMTimers[SAMcol])
				--allSAMTimers[SAMcol] = nil
				outputDebugString("timer destryed")
			end
	end
)

function clearSAMsActive()
	
	if source == localPlayer then 
	--outputDebugString("func triggered player was killd") 
		
		if getElementData ( source, "inRestrictedArea") == true then
			setElementData ( source, "inRestrictedArea", false ,true)
		end
		
		outputDebugString("samtimers: "..#allSAMTimers)
		
		for i,timer in ipairs(allSAMTimers) do
				
				if isTimer(timer) then 
					killTimer(timer) 
					--outputDebugString("timer killed on death") 
				else 
					--iprint(timer)
				end
				
		end
		
	end
	
end
--addEventHandler ( "onClientPlayerWasted", localPlayer, clearSAMsActive)
addEventHandler ( "onClientPlayerWasted", root, clearSAMsActive)