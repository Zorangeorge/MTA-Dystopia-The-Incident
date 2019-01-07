checking = 0
carchecking = 0
wright = false
wleft = false
wback = false
function FPSStart (startedresource)
	if startedresource == getThisResource() then
		local skin = engineLoadTXD ( "160.txd" ) -- arm skin
		engineImportTXD ( skin, 160 )
		local x,y,z = getElementPosition( getLocalPlayer() )
		Body = createObject (991, x, y, z )
		setElementParent(Body, getLocalPlayer())
		attachElements ( Body, getLocalPlayer(), 0, -0.3, 0.45, 0, 90, 0)
		setElementAlpha( Body, 0)
		setElementAlpha( localPlayer, 0)
		setElementData ( getLocalPlayer(), "blocker", Body )
		
--[[	setElementCollisionsEnabled(Body,false)
		local camera = getCamera ()
		setElementCollidableWith ( Body, camera, true )
		setElementCollidableWith ( camera, Body, true )]]
		
		realskin = getElementModel(getLocalPlayer())
		if realskin == 160 then
			realskin = 200
		end
		realvoice1, realvoice2 = getPedVoice (getLocalPlayer())
		setElementModel ( getLocalPlayer(), 160 )
		setPedVoice (getLocalPlayer(),realvoice1,realvoice2)
		local allcars = getElementsByType ( "vehicle", getRootElement(), false)
		for theKey,theVehicle in ipairs(allcars) do
			setElementCollidableWith ( Body, theVehicle, false )
		end
--[[		local allpeds = getElementsByType ( "ped", getRootElement(), false)
		for theKey,theVehicle in ipairs(allpeds) do
			setElementCollidableWith ( Body, theVehicle, false )
		end]]
		bindKey ( "left", "both", sidewalking )
		bindKey ( "right", "both", sidewalking )
		bindKey ( "backwards", "both", sidewalking )
		bindKey ( "fire", "down", autoAimMode )
		bindKey ( "aim_weapon", "up", autoAimMode )
		
		local attachments = getAttachedElements(localPlayer)
		if attachments then
			for _,elem in ipairs(attachments) do
			setElementAlpha(elem,0)
			end
		end
		
	end
end
addEventHandler ( "onClientResourceStart", getRootElement(), FPSStart)

function reset_FP ()
FPSStop (getThisResource())
FPSStart(getThisResource())
end
addCommandHandler("fpreset",reset_FP)

function clearcars()
	if getElementType(source) == "vehicle" then
		setElementCollidableWith ( Body, source, false )
	end
end
addEventHandler( "onClientElementStreamIn", getRootElement(),clearcars)

function invisOnSpawn()
	realskin = getElementModel(getLocalPlayer())
	if realskin == 160 then
		realskin = 200
	end
	realvoice1, realvoice2 = getPedVoice (getLocalPlayer())
	setElementModel ( getLocalPlayer(), 160 )
	setPedVoice (getLocalPlayer(),realvoice1,realvoice2)
end
addEventHandler ( "onClientPlayerSpawn", getLocalPlayer(), invisOnSpawn )

function climbcheck()
	if isPlayerDead(getLocalPlayer())== false and getControlState("aim_weapon") == false then
		setElementCollisionsEnabled(Body, false)
		if checking == 0 then
			checking = 1
			stopclimbcheck = setTimer ( stopCcheck, 1200, 1 )
			addEventHandler ("onClientPreRender", getRootElement(), areyouclimbing)
		elseif checking == 1 then
			if isTimer(stopclimbcheck) then
				killTimer(stopclimbcheck)
			end
			stopclimbcheck = setTimer ( stopCcheck, 1200, 1 )
		end
	end
end
bindKey ("jump", "down", climbcheck )

function stopCcheck()
	local currentmode = getElementModel ( getLocalPlayer())
	if currentmode == 160 then
		setElementCollisionsEnabled(Body, true)
	end
	removeEventHandler("onClientPreRender", getRootElement(), areyouclimbing)
	setCameraTarget (getLocalPlayer())
	checking = 0
end

function areyouclimbing()
	hx,hy,hz = getPedBonePosition ( getLocalPlayer(), 8 )
	local rot = getPedRotation (getLocalPlayer())
	radRot = math.rad ( rot )
	local radius = .5
	local tx = hx + radius * math.sin(radRot)
	local ty = hy + -(radius) * math.cos(radRot)
	local tz = hz	
	setCameraMatrix(tx,ty,tz,hx,hy,hz)
	if ( isPedDoingTask ( getLocalPlayer(), "TASK_SIMPLE_CLIMB" ) ) then
		if isTimer(stopclimbcheck) then
			killTimer(stopclimbcheck)
			doneclimbyet = setTimer ( finishCcheck, 400, 1 )
		end
	end
end

function finishCcheck()
	if ( isPedDoingTask ( getLocalPlayer(), "TASK_SIMPLE_CLIMB" ) ) then
		doneclimbyet = setTimer ( finishCcheck, 400, 1 )
	else
		finishedclimbing()
	end
end

function finishedclimbing()
	checking = 0
	removeEventHandler("onClientPreRender", getRootElement(), areyouclimbing)
	local currentmode = getElementModel ( getLocalPlayer())
	if currentmode == 160 then
		setElementCollisionsEnabled(Body, true)
	end
	setCameraTarget (getLocalPlayer())
end

function FPSStop (startedresource)
	if startedresource == getThisResource() then
		setElementModel ( getLocalPlayer(), realskin )
		setPedVoice (getLocalPlayer(),realvoice1,realvoice2)
		setCameraTarget (getLocalPlayer())		
	end
	
	local attachments = getAttachedElements(localPlayer)
		if attachments then
			for _,elem in ipairs(attachments) do
			setElementAlpha(elem,255)
			end
		end
	
end
addEventHandler ( "onClientResourceStop", getRootElement(), FPSStop)

function shakeCamera(weapon)
	x,y,z = getPedBonePosition ( getLocalPlayer(), 26 )
	if weapon == 24  then 
		createExplosion ( x,y,z + 10,12,false,0.4,false)
	elseif weapon == 25  then 
		createExplosion ( x,y,z + 10,12,false,0.5,false)
	elseif weapon == 26  then
		createExplosion ( x,y,z + 10,12,false,0.7,false)
	elseif weapon == 27  then 
		createExplosion ( x,y,z + 10,12,false,0.5,false)
	elseif weapon == 29  then 
		createExplosion ( x,y,z + 10,12,false,0.2,false)
	elseif weapon == 30  then 
		createExplosion ( x,y,z+10,12,false,0.2,false)
    elseif weapon == 31  then 
		createExplosion ( x,y,z + 10,12,false,0.3,false)
	elseif weapon == 33  then 
		createExplosion ( x,y,z + 10,12,false,0.3,false)
	elseif weapon == 34  then 
		createExplosion ( x,y,z + 10,12,false,0.3,false)
	end
end
--addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), shakeCamera )

function carcheck(player)
	if player == getLocalPlayer() then
		if carchecking ~= 1 then
			carchecking = 1
			local currentmode = getElementModel ( getLocalPlayer())
			if currentmode == 160 then
				abortCarEnterCheck = setTimer ( checkCarTask, 100, 1 )
				setElementCollisionsEnabled(Body, false)
				addEventHandler ("onClientPreRender", getRootElement(), areyougettingin)
			end
		end
	end
end
addEventHandler ( "onClientVehicleStartEnter", getRootElement(), carcheck )
addEventHandler ( "onClientVehicleEnter", getRootElement(), carcheck )

function carfollowupcheck()
	if (isPedInVehicle(getLocalPlayer()) == true) then -- if player is in car
		setElementModel ( getLocalPlayer(), realskin )
		setElementCollisionsEnabled(Body, false)
		setPedVoice (getLocalPlayer(),realvoice1,realvoice2)
		setCameraTarget (getLocalPlayer())
--		setCameraView(0)
	else
		setElementCollisionsEnabled(Body, true)
		setPedVoice (getLocalPlayer(),realvoice1,realvoice2)
		setElementModel ( getLocalPlayer(), 160 )
		setCameraTarget (getLocalPlayer())
	end
end

function areyougettingin()
	hx,hy,hz = getPedBonePosition ( getLocalPlayer(), 8 )
	local rot = getPedRotation (getLocalPlayer())
	radRot = math.rad ( rot )
	local radius = .5
	local tx = hx + radius * math.sin(radRot)
	local ty = hy + -(radius) * math.cos(radRot)
	local tz = hz	
	setCameraMatrix(tx,ty,tz,hx,hy,hz)
end

function checkCarTask()
	local stask = getPedSimplestTask(getLocalPlayer()) 
	if (isPedInVehicle(getLocalPlayer()) == true) then -- if player is in car
		removeEventHandler("onClientPreRender", getRootElement(), areyougettingin)
		carchecking = 0
		CarFollowUp = setTimer ( carfollowupcheck, 100, 1 )
		setElementModel ( getLocalPlayer(), realskin )
		setPedVoice (getLocalPlayer(),realvoice1,realvoice2)
		setCameraTarget (getLocalPlayer())
--		setCameraView(0)
	elseif (stask == "TASK_SIMPLE_CAR_GET_IN") or (stask == "TASK_SIMPLE_GO_TO_POINT") or (stask == "TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE") or (stask == "TASK_SIMPLE_CAR_ALIGN") or (stask == "TASK_SIMPLE_CAR_CLOSE_DOOR_FROM_INSIDE") or (stask == "TASK_SIMPLE_CAR_SHUFFLE") or (stask == "TASK_SIMPLE_CAR_DRIVE") or (stask == "TASK_SIMPLE_ACHIEVE_HEADING") then -- if player is still getting in
		abortCarEnterCheck = setTimer ( checkCarTask, 100, 1 )
	elseif (isPedInVehicle(getLocalPlayer()) == false) then
--enter vehicle was aborted
		setElementCollisionsEnabled(Body, true)
		removeEventHandler("onClientPreRender", getRootElement(), areyougettingin)
		carchecking = 0
		setCameraTarget (getLocalPlayer())
		CarFollowUp = setTimer ( carfollowupcheck, 100, 1 )
	end
end

function carexit(player)
	if player == getLocalPlayer() then
		setElementCollisionsEnabled(Body, true)
		setTimer ( setElementModel, 500, 1, getLocalPlayer(), 160 )
		setTimer ( setPedVoice, 500, 1, getLocalPlayer(), realvoice1,realvoice2 )
	end
end
addEventHandler ( "onClientVehicleStartExit", getRootElement(), carexit )
addEventHandler ( "onClientVehicleExit", getRootElement(), carexit )

function changestatus (dataName)
	if source == getLocalPlayer() and dataName == "usemode" then
		if (isPedInVehicle(source) == false) and (isPlayerDead(getLocalPlayer())== false) then
			if (getElementData ( source, "usemode" ) == true ) then
				setElementCollisionsEnabled(Body, false)
				setElementModel ( getLocalPlayer(), realskin )
				setPedVoice (getLocalPlayer(),realvoice1,realvoice2)
				setCameraTarget(getLocalPlayer())
			elseif (getElementData ( source, "usemode" ) == false ) then
				setElementCollisionsEnabled(Body, true)
				setElementModel ( getLocalPlayer(), 160 )
				setPedVoice (getLocalPlayer(),realvoice1,realvoice2)				
			end
		end
	end
end
addEventHandler( "onClientElementDataChange", getRootElement(), changestatus )

function zwasted ( killer, weapon, bodypart )
	local x,y,z = getElementPosition( getLocalPlayer())
	setCameraMatrix(x, y, z-.8, x, y, z+1)
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), zwasted )

function updateCamera()
	if checking == 0 and carchecking == 0 and wright == false and wleft == false or wback == true then
		x,y,z,tx,ty,tz =  getCameraMatrix()
		newangle = (( 360 - math.deg ( math.atan2 ( ( x - tx ), ( y - ty ) ) ) ) % 360)-180
		setPedRotation( getLocalPlayer(), newangle )
	end
end
addEventHandler ( "onClientPreRender", getRootElement(), updateCamera )

function sidewalking(key, keystate)
	if ( keystate == "down" ) then
		if key == "left" then
			wleft = true
		elseif key == "right" then
			wright = true
		elseif key == "backwards" then
			wback = true
		end
	elseif ( keystate == "up" ) then
		if key == "left" then
			wleft = false
		elseif key == "right" then
			wright = false
		elseif key == "backwards" then
			wback = false
		end
	end
end

function autoAimMode( key, keystate)
setElementAlpha( localPlayer, 0)
	if keystate == "down" then
		setControlState("aim_weapon", true)
	else
		setControlState("aim_weapon", false)
	end
end


function reAim ()
	--if getControlState(localPlayer,"aim_weapon") then
	setControlState("aim_weapon", true)
	--end
end

addEventHandler("onClientPlayerWeaponFire",localPlayer,reAim)