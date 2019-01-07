addEvent( "bbatAnim", true )
addEvent("CreateHitColsOnBike",true)
addEvent( "bbatHitting", true )
function bbatAnimHandler (player)
setPedAnimation( player, "BASEBALL", "BAT_PART",-1,false,false,true,false)
end
addEventHandler( "bbatAnim", resourceRoot, bbatAnimHandler)	

bike_melee_weaps = { [2]=true,[3]=true,[5]=true,[6]=true,[7]=true,[8]=true,[10]=true,[15]=true }

function createHitLists(weapon)
if bike_melee_weaps[weapon] then
local x,y,z = getElementPosition(client)
		local col1 = createColSphere(x,y,z,1.5)
		local col2 = createColSphere(x,y,z,1.5)
		attachElements(col1,client,0.7,1,0.5)
		attachElements(col2,client,0,1.5,0.5)
	--iprint("cols created")
		local plCol1 = getElementsWithinColShape(col1,"ped")
		local plCol2 = getElementsWithinColShape(col2,"ped")
	--iprint(tostring(#plCol1))	
	--iprint(plCol1)	
	--iprint(plCol2)	
	--iprint(tostring(#plCol2))
	--iprint(getElementData(plCol1[1],"name"))
		for i,ped in ipairs(plCol1) do
		--if ped == client then iprint("localPlayer in col1") end
		if getPedOccupiedVehicle (ped)== false then
		triggerEvent("bbatHitting", client, ped,weapon)
		end
		end

		for i,ped in ipairs(plCol2) do
		--if ped == client then iprint("localPlayer in col1") end
		if getPedOccupiedVehicle (ped)== false then
		--triggerEvent("bbatHitting", client, ped,weapon)
		bbatHitHandler (ped,weapon,client)
		end
		end

		destroyElement(col1)
		destroyElement(col2)
		--iprint("cols destroyed")
end
end
addEventHandler( "CreateHitColsOnBike", resourceRoot, createHitLists)		

	
function bbatHitHandler (hitPed,weapon,player_source)

	local speedx, speedy, speedz = getElementVelocity ( getPedOccupiedVehicle(player_source) )
	local actualspeed = ((speedx^2 + speedy^2 + speedz^2)^(0.5) )*180
	--setElementRotation ( hitPed, 0 , 0, playerRotZ,"default",true)
	setPedAnimation( hitPed, "BASEBALL", "Bat_Hit_3",-1,false,true,true,false)
	
	if actualspeed < 30 then 
		hit = 25
	else
		hit = math.floor(actualspeed)
		if hit<25 then 
			hit = 25 
		end
	end
	
	if ( hit > getElementHealth ( hitPed ) ) then 
		setTimer ( killPed, 50, 1, hitPed )
		triggerClientEvent(root, "sync.message", hitPed, hitPed, 255, 0, 0, "KILL!")
	else 
		setElementHealth ( hitPed, getElementHealth ( hitPed ) - hit )
		triggerClientEvent(root, "sync.message", hitPed, hitPed, 255, 0, 0, "HIT!")
	end

	if not isPedDead(hitPed) then 
		triggerClientEvent(root, "onRemoteClientPedDamage", hitPed, player_source,weapon, 3)
	end

end
addEventHandler( "bbatHitting", resourceRoot, bbatHitHandler)
