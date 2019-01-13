function mountminigun ( pla )
	--outputDebugString("minigun clicked") 
	bindKey (pla,"a", "down", mmmgright) 
	bindKey (pla,"arrow_r", "down", mmmgright) 
	bindKey (pla,"d", "down", mmmgleft) 
	bindKey (pla,"arrow_l", "down", mmmgleft)

	if getPedContactElement(pla) then 
		local standingOnObject = getPedContactElement(pla)
		if getElementType(standingOnObject) == "vehicle" then
			createVehicleMinigun(standingOnObject)
			addVehicleMinigunToDatabase(standingOnObject)
		end
	else
		local minigun, x, y, z, xx, yy, zz = createStandMinigun(pla)
		local minigun_id = addStandMinigunToDatabase(x, y, z, xx, yy, zz)
		setElementData(minigun, "minigun_id", minigun_id)
	end
end 

function createVehicleMinigun(standingOnObject)
	local a,b,c,d,e,f
	local proceed = 0

	if getVehicleName(standingOnObject) == "Utility Van" then 
		a,b,c,d,e,f = 0.6,2,1.3,0, 0, 0
		proceed = 1
	elseif getVehicleName(standingOnObject) == "Yosemite" or getVehicleName(standingOnObject) == "Walton" then
		a,b,c,d,e,f = 0.6,1.4,1,0, 0, 0
		proceed = 1
	elseif getVehicleName(standingOnObject) == "Picador" 
		or getVehicleName(standingOnObject) == "Patriot" 
		or getVehicleName(standingOnObject) == "Bobcat" 
		or getVehicleName(standingOnObject) == "Bravura" 
		or getVehicleName(standingOnObject) == "Club" then
		a,b,c,d,e,f =  0,-0.5,1.5,0, 0, 0
		proceed = 1
	end
	if proceed == 1 then
		local x,y,z = 0, 0, 0
		local xx,yy,zz = 0, 0, 0

		local mountgun = createObject(2985, x,y, z-1.1,0,0,0) 
		local miniggun1 = createVehicle(464, 0, 0, 0)
		toggleVehicleRespawn(miniggun1,false)

		setElementRotation(mountgun,xx,yy,zz+90) 
		setElementData(miniggun1,"mountedgun",mountgun) 

		setVehicleVariant ( miniggun1, 601 , 601  ) 

		setElementCollisionsEnabled(mountgun, false) 
		setVehicleEngineState ( miniggun1, false ) 
		attachElements( mountgun,miniggun1, 0, 0.5, -1, 0, 0, 90 ) 
		setElementAlpha(miniggun1, 0)
		attachElements(miniggun1,standingOnObject,a,b,c,d,e,f)
		setElementData(standingOnObject, "has_minigun", true)

		--attachElements(miniggun1,standingOnObject,0,-0.5,1.5,0, 0, 0) --top mount for: picador, bravura, bobcat, club,patriot
		--attachElements(miniggun1,standingOnObject,0.6,2,1.3,0, 0, 0) --hood mount for utility van
		--attachElements(miniggun1,standingOnObject,0.6,1.4,1,0, 0, 0) --hood mount for yosemite
		return mountgun
	end
end

function createStandMinigun(x,y,z,xx,yy,zz)
	if (isElement(x)) then
		local pla = x
		x,y,z = getElementPosition(pla)
		xx,yy,zz = getElementRotation(pla)
	end
	local mountgun = createObject(2985, x,y, z-1.1,0,0,0) 
	local miniggun1 = createVehicle(464, 0, 0, 0) 
	toggleVehicleRespawn(miniggun1,false)
	--local serial = getPlayerSerial(pla) 
	--setVehicleEngineState(miniggun1,false)
	setElementRotation(mountgun,xx,yy,zz+90) 
	setElementData(miniggun1,"mountedgun",mountgun) 
	--setElementData(pla,"mountedgun2",miniggun1) 
	--setElementData(mountgun,"doel","mountedgun") 

	setVehicleVariant ( miniggun1, 601 , 601  ) 
	--setVehicleDamageProof ( miniggun1, true ) 
	setElementCollisionsEnabled(mountgun, false) 
	setVehicleEngineState ( miniggun1, false ) 
	attachElements( miniggun1,mountgun, -0.2, 0, 1.1, 0, 0, -90 ) 
	setElementAlpha(miniggun1, 0)
	return mountgun, x, y, z, xx, yy, zz
end

addEventHandler("onVehicleRespawn", root,
	function ()
		if getElementData(source, "has_minigun") then
			createVehicleMinigun(source)			
		end
	end
)

function mmmgleft(pla) 
--outputDebugString("left pressed")
	if isPedInVehicle(pla) and getVehicleName(getPedOccupiedVehicle(pla))== "RC Baron" then 
		local mountedgun = getElementData(pla,"mountedgun")
		if mountedgun then		
			local xx,yy,zz=getElementRotation(mountedgun) 
			setElementRotation(mountedgun,xx,yy,zz-20) 
		end
	end 
end 
  
function mmmgright(pla)
--outputDebugString("right pressed")
	if isPedInVehicle(pla) and getVehicleName(getPedOccupiedVehicle(pla))== "RC Baron" then 
		local mountedgun = getElementData(pla,"mountedgun")
		if mountedgun and mountedgun ~= getPedOccupiedVehicle(pla) then mountedgun = getPedOccupiedVehicle(pla) end
		if mountedgun then
		setElementFrozen(getPedOccupiedVehicle(pla),false)
			local xx,yy,zz=getElementRotation(mountedgun) 
			--detachElements( mountedgun, getElementData(mountedgun,"mountedgun"))
			setElementRotation(mountedgun,xx,yy,zz+20) 
			--attachElements( mountedgun, getElementData(mountedgun,"mountedgun"), -0.8, 0, 1.1, 0, 0, -90 )
		setElementFrozen(getPedOccupiedVehicle(pla),true)
		end
	end 
end 
  
addEventHandler( "onResourceStop", getResourceRootElement( getThisResource() ), 
function () 
	for i,v in ipairs (getElementsByType ("player")) do 
		if (getElementData (v, "mountedgun")) then 
			removeElementData (v, "ismounted") 
			removeElementData (v, "mountedgun") 
		end 
	end 
end 
)
 
addEventHandler( "onResourceStart", getResourceRootElement( getThisResource() ), 
	function () 
		for i,v in ipairs (getElementsByType ("player")) do 
			if (getElementData (v, "mountedgun")) then 
			removeElementData (v, "ismounted") 
			removeElementData (v, "mountedgun") 
			end 
		end 
	end 
) 
  
--[[addEventHandler("onPlayerSpawn", root, --keys for mounted minigun, you'll need to edit them probably, to fit your layout
	function(_, account) 
		--bindKey (source,"=", "up", mountminigun) 
		bindKey (source,"a", "down", mmmgright) 
		bindKey (source,"arrow_r", "down", mmmgright) 
		bindKey (source,"d", "down", mmmgleft) 
		bindKey (source,"arrow_l", "down", mmmgleft) 
		--bindKey (source,"d", "down", mmmgright2) 
		--bindKey (source,"a", "down", mmmgleft2) 
	end 
) ]]

--[[function mmmgleft2(pla) 
	if isPedInVehicle(pla)then 
	--local mountedgun=getElementData(pla,"mountedgun") 
		if mountedgun then 
			local ismounted=getElementData(pla,"ismounted") 
			if ismounted then 
			local xx,yy,zz=getElementRotation(mountedgun) 
			attachElements( mountedgun, ismounted, 0, 0, 0.5, 0, 0,zz+10) 
			  
			end 
		end 
	end 
end

function mmmgright2(pla) 
	if isPedInVehicle(pla)then 
		local mountedgun=getElementData(pla,"mountedgun") 
		if mountedgun then 
			local ismounted=getElementData(pla,"ismounted") 
			if ismounted then 
				local xx,yy,zz=getElementRotation(mountedgun) 
				local xxx,yyy,zzz=getElementRotation(ismounted) 
				local test=(zz-zzz) 
				attachElements( mountedgun, ismounted, 0, 0, 0.5, 0, 0,zz -10) 
			end 
		end 
	end 
end ]]
  
--[[addEventHandler ("onPlayerQuit", getRootElement(),  
function(quitType, reason, responsibleElement) 
  if (getElementData (source, "mountedgun")) then 
local mountedgun=getElementData(source,"mountedgun") 
local mountedgun2=getElementData(source,"mountedgun2") 
destroyElement (mountedgun)     
destroyElement (mountedgun2)     
removeElementData (source, "mountedgun") 
removeElementData (source, "mountedgun2") 
removeElementData (source, "ismounted") 
  end 
end) ]]