addEvent("openCargoPlaneDoor",true)
function openCargoDoorForCargoPlane ()
	if isElement(source) then
	setVehicleAdjustableProperty ( source, 2500 )
	end
	
end
addEventHandler("openCargoPlaneDoor",root,openCargoDoorForCargoPlane)

addEvent("closeCargoPlaneDoor",true)
function closeCargoDoorForCargoPlane ()
	if isElement(source) then
	setVehicleAdjustableProperty ( source, 0 )
	end
	
end
addEventHandler("closeCargoPlaneDoor",root,closeCargoDoorForCargoPlane)

