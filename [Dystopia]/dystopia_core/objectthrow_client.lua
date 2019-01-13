addEvent("ArmZeBall",true)
function armBall(player)
	addEventHandler("onClientKey", root, throwTheObject)
end
addEventHandler("ArmZeBall",root,armBall)

addEvent("DisarmZeBall",true)
function disarmBall ()
	removeEventHandler("onClientKey",getRootElement(),throwTheObject)
end
addEventHandler("DisarmZeBall",root,disarmBall)

function throwTheObject(button, state)
	if button == "mouse1" and state == true then
		local theObjectInHand = getElementData(localPlayer, "carriedObject")
		triggerServerEvent("throwObject", resourceRoot, theObjectInHand)
		--triggerServerEvent("carry.syncThrowing", resourceRoot, theObjectInHand, 1)
	end
end

addEvent("throwObject.getGround", true)
addEventHandler("throwObject.getGround", root,
	function (object, ox, oy, oz)
		disarmBall()
		_, _, _, _, _, maxz = getElementBoundingBox(object)
		triggerServerEvent("throwObject.gotGround", root, object, getGroundPosition(ox, oy, oz)+maxz)
	end
)

addEvent("throwObject.fall", true)
addEventHandler("throwObject.fall", root,
	function (object)
		setElementVelocity(object, 0, 0, 0)
	end
)

-- local thePlayer, object, Ballpedx, Ballpedy, BallRadius, newGroundDiff, Ballnewx, Ballnewy, Ballnewz, rotz, xInHand, yInHand, zInHand

-- function throwedBall()
-- 	if object then
-- 		oldx, oldy, oldz = getElementPosition(object)
-- 		oldz = Ballnewz
-- 		Ballnewx = math.cos(math.rad(rotz+90))*BallRadius + Ballpedx
-- 		Ballnewy = math.sin(math.rad(rotz+90))*BallRadius + Ballpedy
-- 		Ballnewz = -1/100*(BallRadius-30)^2 + zInHand + 9
-- 		newGroundDiff = oldz-getGroundPosition(oldx,oldy,oldz+1)
-- 		outputChatBox(newGroundDiff)
-- 		if newGroundDiff>0.5 and newGroundDiff<2.5 then
-- 			BallRadius = BallRadius + 1 - 0.3
-- 			setElementPosition(object,Ballnewx,Ballnewy,Ballnewz)
-- 		else
-- 			setElementVelocity(object,math.cos(math.rad(rotz+90))*BallRadius/4,math.sin(math.rad(rotz+90))*BallRadius/4,-1)
-- 			setTimer(function() setElementVelocity(object,0,0,0) setElementFrozen(object,true); setElementData(thePlayer,"carriedObject", false); setElementHealth(object,1) end, 3000, 1 ) --froze it again so you can't move it 
-- 			--setTimer(function() local x,y,z = getElementPosition(object) triggerServerEvent("carry.fixPosition_pong", root, object,x,y,z) end, 4000, 1)

-- 			if localPlayer == thePlayer then
-- 				triggerServerEvent("carry.syncThrowing", resourceRoot, object, 2)
-- 				removeEventHandler("onClientKey", root, throwTheObject)
-- 			end
-- 			removeEventHandler("onClientRender", root, throwedBall)
-- 		end
-- 	end
-- end


-- addEvent("carry.syncThrowing", true)
-- addEventHandler("carry.syncThrowing", root,
-- 	function (player, _object)
-- 		setTimer(function()
-- 			thePlayer = player
-- 			object = _object
-- 			Ballpedx, Ballpedy, Ballpedz = getElementPosition(player)
-- 			rotx, roty, rotz = getElementRotation(player)
-- 			BallRadius = 0.1
-- 			newGroundDiff = 1
-- 			xInHand, yInHand, zInHand = getElementPosition(_object)
-- 			Ballnewx, Ballnewy, Ballnewz = getElementPosition(_object)
-- 			addEventHandler("onClientRender", getRootElement(), throwedBall)
-- 		end, 300, 1)
-- 	end
-- )


-- addEvent("ArmZeBall",true)
-- function armBall()
-- 	setPedWeaponSlot(getLocalPlayer(),0)
-- 	theObjectInHand = getElementData(getLocalPlayer(),"carriedObject")--createObject(1370,0,0,0)
-- 	setElementCollisionsEnabled(theObjectInHand,false)
-- 	setElementHealth(theObjectInHand,1)

-- 	addEventHandler("onClientKey",getRootElement(),throwTheObject)
-- 	--addEventHandler("onClientPlayerWeaponSwitch", getRootElement(),ballWeaponSwitch)
-- end
-- addEventHandler("ArmZeBall",root,armBall)

-- addEvent("DisarmZeBall",true)
-- function disarmBall ()
-- removeEventHandler("onClientKey",getRootElement(),throwTheObject)
-- end
-- addEventHandler("DisarmZeBall",root,disarmBall)

-- --[[function ballWeaponSwitch(prev,cur)
-- 	if prev == 0 then
-- 		toggleControl("fire",true)
-- 		removeEventHandler("onClientKey",getRootElement(),throwTheObject)
-- 		setElementAlpha(theObjectInHand,0)
-- 	elseif cur == 0 then
-- 		toggleControl("fire",false)
-- 		addEventHandler("onClientKey",getRootElement(),throwTheObject)
-- 		setElementAlpha(theObjectInHand,255)
-- 	end
-- end]]

-- setFPSLimit = 50

-- function throwTheObject(button, state)
-- 	if button == "mouse1" and state == true then
-- 		--detachElements(theObjectInHand,localPlayer)
-- 		setElementFrozen(theObjectInHand,false)
-- 		setPedAnimation(getLocalPlayer(),"RYDER", "Van_Throw",-1,false)
-- 		setTimer(function()
-- 			xInHand,yInHand,zInHand = getElementPosition(theObjectInHand)
-- 			toggleControl("fire",true)
-- 			Ballpedx, Ballpedy, Ballpedz = getElementPosition(getLocalPlayer())
-- 			rotx,roty,rotz = getElementRotation(getLocalPlayer())
-- 			BallRadius = 0.1
-- 			newGroundDiff = 1
-- 			Ballnewx,Ballnewy,Ballnewz = getElementPosition(theObjectInHand)
-- 			triggerServerEvent("sync.throwDetach", root, theObjectInHand)
			
-- 		end,300/getGameSpeed(),1)


		
-- 		--removeEventHandler("onClientPlayerWeaponSwitch", getRootElement(),ballWeaponSwitch)
-- 		removeEventHandler("onClientKey",getRootElement(),throwTheObject)
-- 		setPedWalkingStyle(getLocalPlayer(), 0)
-- 		setElementData(getLocalPlayer(),"carriedObject",nil,true)
-- 		toggleControl("walk",true)
-- 		toggleControl("sprint",true)
-- 		toggleControl("fire",true)
-- 		toggleControl("enter_exit",true)
-- 		toggleControl("crouch",true)
-- 		toggleControl("aim_weapon",true)
-- 		toggleControl("next_weapon",true)
-- 		toggleControl("previous_weapon",true)
-- 			setTimer(function() 
-- 				setElementData(localPlayer, "carriedObject", false) 
-- 				end
-- 			, 1000,1)
-- 	end
-- end

-- addEvent("sync.detached", true)
-- addEventHandler("sync.detached", root,
-- 	function (theObjectInHand)
-- 		addEventHandler("onClientRender",getRootElement(),throwedBall)
-- 		setElementHealth(theObjectInHand,1)
-- 		setTimer(function()
-- 			setPedAnimation(getLocalPlayer())
-- 		end,900/getGameSpeed(),1)
-- 		setTimer(function()
-- 			setElementCollisionsEnabled(theObjectInHand,true)
-- 		end,400,1)
-- 	end
-- )

-- function throwedBall()
-- setElementHealth(theObjectInHand,1)
-- 	oldx, oldy, oldz = getElementPosition(theObjectInHand)
-- 	oldz = Ballnewz
-- 	Ballnewx = math.cos(math.rad(rotz+90))*BallRadius + Ballpedx
-- 	Ballnewy = math.sin(math.rad(rotz+90))*BallRadius + Ballpedy
-- 	Ballnewz = -1/100*(BallRadius-30)^2 + zInHand + 9
-- 	newGroundDiff = oldz-getGroundPosition(oldx,oldy,oldz+1)
-- 	if newGroundDiff>0.5 and newGroundDiff<3 then
-- 		BallRadius = BallRadius + getGameSpeed() - 0.3
-- 		--setElementPosition(theObjectInHand,Ballnewx,Ballnewy,Ballnewz)
-- 		triggerServerEvent("carry.fixPosition_pong", root, theObjectInHand,Ballnewx,Ballnewy,Ballnewz)
-- 	else
-- 		removeEventHandler("onClientRender",getRootElement(),throwedBall)
-- 		--setElementVelocity(theObjectInHand,math.cos(math.rad(rotz+90))*BallRadius/4,math.sin(math.rad(rotz+90))*BallRadius/4,-1)
-- 		triggerServerEvent("carry.fixVelocity", root, theObjectInHand, math.cos(math.rad(rotz+90))*BallRadius/4,math.sin(math.rad(rotz+90))*BallRadius/4,-1)
-- 		--setTimer(function() setElementVelocity(theObjectInHand,0,0,0) setElementFrozen(theObjectInHand,true); setElementData(localPlayer,"carriedObject", false); setElementHealth(theObjectInHand,1) end, 3000, 1 ) --froze it again so you can't move it 
-- 		setTimer(function() triggerServerEvent("carry.fixVelocity", root, theObjectInHand, 0, 0, 0) end, 3000, 1 ) --froze it again so you can't move it 
-- 		setTimer(function() local x,y,z = getElementPosition(theObjectInHand) triggerServerEvent("carry.fixPosition_pong", root, theObjectInHand,x,y,z) end, 4000, 1)
		
-- 	end
-- end

