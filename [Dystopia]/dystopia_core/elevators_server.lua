--Made by Eren ;)

elevator1 = createObject(3115,-1456.6999511719,501.29998779297,9.8900003433228)
elevator2 = createObject(3114,-1414.5,516.39001464844,9.628999710083)
elevator3_LSCDF = createObject(3114,1459,-1398.900390625,12.39999961853,0,0,89.747314453125)

local elevator1RefCount = 0
local elevator2RefCount = 0
local elevator3_LSCDFRefCount = 0

CDFElevatorControlPoints = createElement("ControlPointsGroup","CDFElevatorControlPoints")

elevator3_LSCDF_Col1 = createColSphere(0, 0, 0, 1.5)
elevator3_LSCDF_Col2 = createColSphere(1465.6552734375, -1409.2939453125, 13.7421875, 1.5)
elevator3_LSCDF_Col3 = createColSphere(1464.2841796875, -1408.1005859375, 47.1484375, 1.5)
attachElements(elevator3_LSCDF_Col1,elevator3_LSCDF,-10,-1,1)

setElementParent(elevator3_LSCDF_Col1, CDFElevatorControlPoints)
setElementParent(elevator3_LSCDF_Col2, CDFElevatorControlPoints)
setElementParent(elevator3_LSCDF_Col3, CDFElevatorControlPoints)

function moveElevator1()
	if elevatorRefCount == 0 then
		moveObject(elevator1,10000,-1456.6999511719,501.29998779297,16.920003890991)
		elevatorRefCount = 1
	else
		moveObject(elevator1,10000,-1456.6999511719,501.29998779297,9.8900003433228)
		elevatorRefCount = 0
	end
end

function moveElevator2()
	if elevator2RefCount == 0 then
		moveObject(elevator2,3000,-1414.5,516.39001464844,16.679000854492)
		elevator2RefCount = 1
	else
		moveObject(elevator2,3000,-1414.5,516.39001464844,9.628999710083)
		elevator2RefCount = 0
	end
end

function moveElevator3_LSCDF()
	if elevator3_LSCDFRefCount == 0 then
		moveObject(elevator3_LSCDF,10000,1459,-1398.900390625,45.5) 
		elevator3_LSCDFRefCount = 1
	else
		moveObject(elevator3_LSCDF,10000,1459,-1398.900390625,12.39999961853)
		elevator3_LSCDFRefCount = 0
	end
end

function timer1()
	setTimer(moveElevator1,2000,1)
end

function timer2()
	setTimer(moveElevator2,2000,1)
end

function timer3()
	setTimer(moveElevator3_LSCDF,2000,1)
end

addCommandHandler("mainlift",timer1)
addCommandHandler("sidelift",timer2)
addCommandHandler("cdflift",timer3)

function hitElevatorCol(hitElem)
	if getElementType(hitElem)=="player" then
	bindKey(hitElem,"e","down","cdflift")
	outputInteractInfo("Use elevator\n[E]",hitElem,240,240,240)
	end
end

function leaveElevatorCol(hitElem)
	if getElementType(hitElem)=="player" then
	unbindKey(hitElem,"e","down","cdflift")
	end
end

addEventHandler("onColShapeHit",CDFElevatorControlPoints,hitElevatorCol,true)
addEventHandler("onColShapeLeave",CDFElevatorControlPoints,leaveElevatorCol,true)

