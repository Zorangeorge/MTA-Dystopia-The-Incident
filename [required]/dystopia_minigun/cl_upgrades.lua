update_timer = nil
w, h = guiGetScreenSize ()
minigunAmmo = "mountedminigun_vehweapon_ammo" -- Name of data for mounted machine gun  ammunition 
ammoInClip = 500 -- the number of rounds in gun clip
soundDist = 500 -- the maximum range of the sound gun

addEvent("cl_bulletSpawn", true)
addEventHandler("cl_bulletSpawn",getRootElement(),function(veh, weapon,player)
	local x,y,z = getElementPosition ( weapon )
 	local weaponReal = createWeapon("ak-47", x+1,y,z)
	attachElements ( weaponReal, weapon, 0, 0, 0.8 )
	setWeaponProperty(weaponReal, "damage", 25)
	setElementCollisionsEnabled(weaponReal, false)
	setElementAlpha(weaponReal,0)
	setElementAlpha(weaponReal,0)
	local sound = playSound3D ( "19.wav", x, y, z )
	setSoundMaxDistance ( sound, soundDist )
	setElementData ( weaponReal, "owner", player,true )
	local aim = getElementData ( player, "attachedToWeapon_aim" )
	
	setWeaponTarget(weaponReal, aim[1],aim[2],aim[3])
	setWeaponProperty ( weaponReal, "weapon_range", 1500 )
	setWeaponProperty ( weaponReal, "target_range", 1500 )
	setWeaponState(weaponReal, "firing")
	setTimer ( fireCustomWeapInTime, 200, 1, weaponReal, player )
end)

function getPositionInfrontOfElement(x,y,rotation, meters)
    posX = x - math.sin(math.rad(rotation)) * meters
    posY = y + math.cos(math.rad(rotation)) * meters
    return posX, posY, posZ
end

function causeCustomWeaponDamage(hitElement)
	if hitElement then
		local owner = getElementData(source,"owner")
		if isElement (owner) and getElementData (owner, "attachedToWeapon_fire") then
			if hitElement == localPlayer then 
				
				setElementHealth(localPlayer, getElementHealth(localPlayer)-25)
				
				if getElementHealth(localPlayer) <= 0 then
					killPlayer(localPlayer,owner,38)
				end
				
			elseif owner == localPlayer then
				
				if getElementType (hitElement) == "ped" then
				
				
				triggerServerEvent("CheckPedSyncer",hitElement,owner)
				
					setElementHealth(hitElement, getElementHealth(hitElement)-25)
					triggerEvent("onClientPedDamage",hitElement,localPlayer,38,25)
					triggerServerEvent("S_SHOOT",getLocalPlayer(),38,1000,500,hitElement,getTickCount()/1000*45);
					if getElementHealth(hitElement) <= 0 then
						--killPed(hitElement,localPlayer,38)
						local h = getElementHealth(hitElement)
						if(h>25)then
						setElementHealth(hitElement,h-25)
						triggerEvent("sync.message", root, hitElement, 255, 0, 0, "HIT!")
						else
						triggerServerEvent("killPedSpecial",hitElement,localPlayer)
						triggerEvent("sync.message", root, hitElement, 255, 0, 0, "KILL!")
						end
					end
				elseif getElementType ( hitElement ) == "vehicle" then
					triggerServerEvent ( "causeVehicleDamageFromMG", localPlayer, hitElement ) 
				elseif getElementType ( hitElement ) == "object" then
					triggerServerEvent ( "objSBreak",localPlayer, hitElement ) 
				end
			end
		end
	end
end
addEventHandler("onClientWeaponFire", getRootElement(), causeCustomWeaponDamage)

function fireCustomWeapInTime (weapon, player)
	if isElement ( player ) and getElementData ( player, "attachedToWeapon_fire" ) then
		local aim = getElementData ( player, "attachedToWeapon_aim" )
		setWeaponTarget(weapon, aim[1],aim[2],aim[3])
		setWeaponState(weapon, "firing")
		local x,y,z = getElementPosition ( player )
		playSound3D ( "19.wav", x, y, z )
		setTimer ( function () local sound = playSound3D ( "19.wav", x, y, z ) setSoundMaxDistance ( sound, soundDist ) end, 100, 1 )
		setTimer ( fireCustomWeapInTime, 200, 1, weapon, player )
	else
		destroyElement ( weapon )
	end
end

function fireCustomVehWeapon ()
	if getElementData (localPlayer, "attachedToWeapon") then
		local veh = getElementData (localPlayer, "attachedToWeapon_v")
		if isElement ( veh ) then
			local weapon = getElementData ( veh, "mountedminigun_vehweapon_miniBaseObj" )
			if isElement ( weapon ) and getElementData ( weapon, minigunAmmo )>0 and Remove_Mountminigun_Weapon_Ammo ( weapon)  then
				local x, y, z = getWorldFromScreenPosition ( w/2, h/2, 50 )
				setElementData ( localPlayer, "attachedToWeapon_aim", {x, y, z} )
				setTimer ( updateWeaponTargetOnFire, 200, 1 )
				setElementData ( localPlayer, "attachedToWeapon_fire", true)
				triggerServerEvent("sv_bulletSpawn", localPlayer, veh, weapon, localPlayer)
			else
				outputDebugString("no minigun ammo")
			end
		end
	end
end
bindKey ("mouse1", "down", fireCustomVehWeapon)

function Remove_Mountminigun_Weapon_Ammo ( mountminigun_weapon )
	if isElement ( mountminigun_weapon ) then
		
		local ammo = getElementData ( mountminigun_weapon, minigunAmmo ) or 0
		
		if ammo and ammo > 0 then
			setElementData(mountminigun_weapon,minigunAmmo,ammo-1)
			outputDebugString("minigun ammo: "..ammo-1)
			return true
		else
			outputDebugString("no minigun ammo")
			return false
		end
--[[		local cur_temp_ammo = getElementData ( mountminigun_weapon, "temp_ammo" ) or 0
		local main_ammo = getElementData ( mountminigun_weapon, minigunAmmo ) or 0
		if cur_temp_ammo > 0 then
			setElementData ( mountminigun_weapon, "temp_ammo", cur_temp_ammo - 1 )
			outputDebugString("currtempammo: "..getElementData ( mountminigun_weapon, cur_temp_ammo ))
			return true
		elseif main_ammo > 0 then
			setElementData ( mountminigun_weapon, "temp_ammo", ammoInClip )
			setElementData ( mountminigun_weapon, minigunAmmo, main_ammo - 1 )
			outputDebugString("minigunAmmo: "..getElementData ( mountminigun_weapon, minigunAmmo ))
			return true
		else
			outputDebugString("no minigun ammo")
			return false
		end]]
	end
end

function updateWeaponTargetOnFire ()
	if getKeyState ("mouse1") and getElementData (localPlayer,"attachedToWeapon") then
		local veh = getElementData ( localPlayer, "attachedToWeapon_v" ) 
		local weapon = getElementData ( veh, "mountedminigun_vehweapon_miniBaseObj" )
		if isElement (veh) and getElementHealth (veh) > 0 then
			if not Remove_Mountminigun_Weapon_Ammo ( weapon ) then setElementData ( localPlayer, "attachedToWeapon_fire", false) return true end
			local x, y, z = getWorldFromScreenPosition ( w/2, h/2, 75 )
			setElementData ( localPlayer, "attachedToWeapon_aim", {x, y, z} )
			setTimer ( updateWeaponTargetOnFire, 50, 1 )
		else
			setElementData ( localPlayer, "attachedToWeapon_fire", false)
		end
	else
		setElementData ( localPlayer, "attachedToWeapon_fire", false)
	end
end


function getIntoMacineGun ()
	local veh_col = getElementData ( localPlayer, "veh_col_col" )
	if getElementData ( localPlayer, "attachedToWeapon" ) then
	    local veh = getElementData(localPlayer,"attachedToWeapon_v")
		triggerServerEvent ( "detachPlayerFromMinigun", localPlayer, veh)
		removeEventHandler('onClientRender', root, renderVehCross )
		if isTimer (update_timer) then
			killTimer ( update_timer )
		end
		return true
	end
	if isElement ( veh_col ) then
		local veh = getElementData ( localPlayer, "veh_col_veh" )
		if isElement ( veh ) then
			if isElement ( getElementData ( veh, "mountedminigun_vehweapon_miniBaseObj" ) ) and not isElement(getElementData ( veh, "playerOnWeapon" )) and not isPedInVehicle(localPlayer) then
				triggerServerEvent ( "attachPlayerToMinigun", localPlayer, veh)
				setElementData (localPlayer,"attachedToWeapon",true)
				setPedWeaponSlot(localPlayer,0)
				addEventHandler('onClientRender', root, renderVehCross )
				setTimer ( function () update_timer = setTimer ( updatePlayerWeapon, 50, 0 ) end, 500, 1 )
			end
		end
	end
end
bindKey ( "e", "down", getIntoMacineGun)

function updatePlayerWeapon ()
	if getElementData (localPlayer, "attachedToWeapon") then
		local veh = getElementData (localPlayer, "attachedToWeapon_v")
		if isElement ( veh ) and getElementHealth ( veh ) > 0 then
			local x, y, z, lx, ly, lz = getCameraMatrix ()
			local rot = findRotation ( x,y,lx,ly )
			local rot2_x, rot_y, rot2_z = getCameraRotation()
			setElementRotation ( localPlayer, 0, 0, rot, "default", true )
			triggerServerEvent ("rotatePlayerWeapon",localPlayer,rot,rot2_x)
		end
	else
		killTimer ( update_timer )
	end
end


function renderVehCross ()
	if getElementData (localPlayer,"attachedToWeapon") then
		dxDrawImage (w/2-16, h/2-16,32,32,"shotgun.png",0,0,0)
	else
		removeEventHandler('onClientRender', root, renderVehCross )
	end
end

function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
end

function getCameraRotation ()
    local px, py, pz, lx, ly, lz = getCameraMatrix()
    local rotz = 6.2831853071796 - math.atan2 ( ( lx - px ), ( ly - py ) ) % 6.2831853071796
    local rotx = math.atan2 ( lz - pz, getDistanceBetweenPoints2D ( lx, ly, px, py ) )
    rotx = math.deg(rotx)
    rotz = -math.deg(rotz)	
    return rotx, 180, rotz
end

addEventHandler("onPlayerMoveItemInInventory",getRootElement(),function(item, loot) 
	triggerServerEvent("sv_destroyWeapon", getRootElement(), item, loot, getLocalPlayer())
end)

addEventHandler("onPlayerMoveItemOutOFInventory",getRootElement(),function(item, loot)
	triggerServerEvent("sv_createWeapon", getRootElement(), item, loot, getLocalPlayer())
end)
