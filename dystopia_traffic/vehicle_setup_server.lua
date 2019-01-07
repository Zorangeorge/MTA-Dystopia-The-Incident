 function position_and_attach_objects(vehicle,setup)

   setElementFrozen(vehicle,true)
   local x,y,z = getElementPosition(vehicle)
   local rx,ry,rz = getElementRotation(vehicle)
   local vehmodel = getElementModel(vehicle)
   local no_doors

      -- get the objects
      local subObjects

   if vehmodel == 443 then --siegetruck
     setElementPosition(vehicle,0,0,5,true)
     setElementRotation(vehicle,0,0,0)
     subObjects = create_siegetruck_attachments ()
   elseif vehmodel == 545 then 
   
	    if getElementData(vehicle,"setup") == "Kamikaboom" then --kamikaboom
		 setElementPosition(vehicle,2492.6006, -1679.2998, 13.3,true)
		 setElementRotation(vehicle,0,0,0)
		 subObjects = create_kamikaboom_attachments ()
		 no_doors = true
		elseif getElementData(vehicle,"setup") == "Raider Lurker" then --lurker
		 setElementPosition(vehicle,2492.6006, -1679.2998, 13.3,true)
		 setElementRotation(vehicle,0,0,0)
		 subObjects = create_lurker_attachments ()
		 no_doors = true
		end
		
   elseif vehmodel == 591 then --meatwagon
     setElementPosition(vehicle,2474.2, -1673.2, 14,true)
     setElementRotation(vehicle,0,0,0)
     subObjects = create_meatwagon_attachments ()
   elseif vehmodel == 552 then --peacekeepervan
     setElementPosition(vehicle,2486.5,-1675.6,13.1,true)
     setElementRotation(vehicle,0,0,0)
     subObjects = create_peacekeepervan_attachments ()
   elseif vehmodel == 549 then --roadwarrior
     setElementPosition(vehicle,2524.8999,-1463.3,23.8,true)
     setElementRotation(vehicle,0,0,270)
     subObjects = create_roadwarrior_attachments ()
     no_doors = true
   elseif vehmodel == 515 then --warrig
     setElementPosition(vehicle,2481.2,-1669.8,14.5,true)
     setElementRotation(vehicle,0,0,0)
     subObjects = create_warrig_attachments ()
   end
      --iprint(vehicle)
      --iprint(subObjects)

      --vehicle parts and stats--
          --local vehPanelNo = {0,1,2,3,4,5,6} -- panel number
          --local vehPanelSt = {0,1,2,3} -- panel state
          --local vehWheelSt = {0,1,2} -- 0 intact, 2 missing
          --local vehDoorNo = {0,1,2,3,4,5}
          --local vehDoorSt = {0,1,2,3,4}
      if  no_doors then
            setVehicleDoorState ( vehicle, 0, 4 )
            setVehicleDoorState ( vehicle, 1, 4 )
            setVehicleDoorState ( vehicle, 2, 4 )
            setVehicleDoorState ( vehicle, 3, 4 )
      end
      -- Attach so they look like what they do in the map editor
		if subObjects and #subObjects > 0 then     
			 for _,part in ipairs (subObjects) do
				attachRotationAdjusted ( part, vehicle )
				setElementParent(part,vehicle)
			  end
		end

   setElementPosition(vehicle, x, y, z,true)
   setElementRotation(vehicle, rx, ry, rz)
   setElementFrozen(vehicle,false)

   return vehicle

end

function attachRotationAdjusted ( from, to )
  -- Note: Objects being attached to ('to') should have at least two of their rotations set to zero
  --       Objects being attached ('from') should have at least one of their rotations set to zero
  -- Otherwise it will look all funny

  local frPosX, frPosY, frPosZ = getElementPosition( from )
  local frRotX, frRotY, frRotZ = getElementRotation( from )
  local toPosX, toPosY, toPosZ = getElementPosition( to )
  local toRotX, toRotY, toRotZ = getElementRotation( to )
  local offsetPosX = frPosX - toPosX
  local offsetPosY = frPosY - toPosY
  local offsetPosZ = frPosZ - toPosZ
  local offsetRotX = frRotX - toRotX
  local offsetRotY = frRotY - toRotY
  local offsetRotZ = frRotZ - toRotZ

  offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation ( offsetPosX, offsetPosY, offsetPosZ, toRotX, toRotY, toRotZ )

  attachElements( from, to, offsetPosX, offsetPosY, offsetPosZ, offsetRotX, offsetRotY, offsetRotZ )
end

function applyInverseRotation ( x,y,z, rx,ry,rz )
  -- Degress to radians
  local DEG2RAD = (math.pi * 2) / 360
  rx = rx * DEG2RAD
  ry = ry * DEG2RAD
  rz = rz * DEG2RAD

  -- unrotate each axis
  local tempY = y
  y =  math.cos ( rx ) * tempY + math.sin ( rx ) * z
  z = -math.sin ( rx ) * tempY + math.cos ( rx ) * z

  local tempX = x
  x =  math.cos ( ry ) * tempX - math.sin ( ry ) * z
  z =  math.sin ( ry ) * tempX + math.cos ( ry ) * z

  tempX = x
  x =  math.cos ( rz ) * tempX + math.sin ( rz ) * y
  y = -math.sin ( rz ) * tempX + math.cos ( rz ) * y

  return x, y, z
end