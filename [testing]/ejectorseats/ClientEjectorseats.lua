-------------------
-- Ejector Seats -- -- Makes it so you can eject from vehicles to reach rooftops or escape during crashes etc
-------- By -------
------ KWKSND ----- -- Makes Multi Theft Auto more fun!! :D
-------------------

function RemoveCol(fogger)
	setElementCollisionsEnabled(fogger, false)
end
addEvent("ClientRemoveCol",true)
addEventHandler("ClientRemoveCol", getRootElement(), RemoveCol)
