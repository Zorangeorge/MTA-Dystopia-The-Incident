local detachOnExit = false

addEvent ("attachElements",true)

addEventHandler ("attachElements",root,function(attachTo,offsX,offsY,offsZ,rotX,rotY,rotZ,slot)
	if isElement (attachTo) and (not isVehicleBlown(attachTo)) then
		local attX,attY,attZ = getElementRotation (attachTo)
		attachElements (source,attachTo,offsX,offsY,offsZ,rotX,rotY,rotZ)
		if slot then
			setPedWeaponSlot (source,slot)
		end
	end
end)

addEvent ("detachElements",true)
addEventHandler ("detachElements",root,function()
		local x,y,z = getElementPosition(source)
		local rx,ry,rz = getElementRotation(source)
		detachElements (source)
		setElementPosition(source,x,y,z,false)
		setElementRotation(source,rx,ry,rz)
end)


if detachOnExit then
	addEventHandler ("onVehicleExit",root,function(thePlayer,seat)
		if isElementAttached (source) and seat == 0 then
			detachElements (source)
		end
	end)
end