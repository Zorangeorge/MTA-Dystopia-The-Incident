players = {}
canHit = false
once = true
handler = false
bind = false

function bbat_hit()
	
	local x1, y1, z1 = getElementPosition (localPlayer)
	
	if getPedOccupiedVehicle (localPlayer)~= false then 
		if getVehicleType(getPedOccupiedVehicle(localPlayer))== "Bike" or getVehicleType(getPedOccupiedVehicle(localPlayer))== "Quad" then
			if getPedWeapon(localPlayer)==5 or getPedWeapon(localPlayer)==6 or getPedWeapon(localPlayer)==3 or getPedWeapon(localPlayer)==2 or getPedWeapon(localPlayer)==7 or getPedWeapon(localPlayer)==8 or getPedWeapon(localPlayer)==10 or getPedWeapon(localPlayer)==15 then
				if bind == false then
					bindKey ( "mouse1", "down", bbat_anim )
					bind = true
				end
			else
				unbindKey ("mouse1", "down", bbat_anim )
				bind = false
			end
		else
			unbindKey ("mouse1", "down", bbat_anim )
			bind = false
		end
	else
		unbindKey ("mouse1", "down", bbat_anim )
		bind = false
	end
	
end

addEventHandler("onVehicleExit",root,function(player,seat)
	if player == localPlayer then
		removeEventHandler("onClientRender", root, bbat_hit)  
	end
end)

addEventHandler("onVehicleEnter",root,function(player,seat)
	if player == localPlayer then
		addEventHandler("onClientRender", root, bbat_hit)  
	end
end)

--[[
function set_slot()
if getPedOccupiedVehicle (localPlayer)~= false then 
if getVehicleType(getPedOccupiedVehicle(localPlayer))== "Bike" or getVehicleType(getPedOccupiedVehicle(localPlayer))== "Quad" then
if handler == false then
addEventHandler("onClientKey", root, changeWeap1)
handler = true
end
end
else
removeEventHandler("onClientKey", root, changeWeap1)
handler = false
end
end
addEventHandler("onClientRender", root, set_slot)  
]]
bike_melee_weaps = { [2]=true,[3]=true,[5]=true,[6]=true,[7]=true,[8]=true,[10]=true,[15]=true }

function changeWeapOnBike(button,press)
	if press then
		if button == "mouse_wheel_down" then
			if getPedOccupiedVehicle (localPlayer)~= false then 
				if getVehicleType(getPedOccupiedVehicle(localPlayer))== "Bike" or getVehicleType(getPedOccupiedVehicle(localPlayer))== "Quad" then
			
					if getPedWeaponSlot( localPlayer)== 0 then
						if getPedWeapon(localPlayer,1) ~= 0 and bike_melee_weaps[getPedWeapon(localPlayer,1)] then
						setPedWeaponSlot( localPlayer, 1 )
						elseif getPedWeapon(localPlayer,10) ~= 0 and bike_melee_weaps[getPedWeapon(localPlayer,10)] then
						setPedWeaponSlot( localPlayer, 10 )
						end
					elseif getPedWeaponSlot( localPlayer)== 1 then
						if getPedWeapon(localPlayer,10) ~= 0 and bike_melee_weaps[getPedWeapon(localPlayer,10)] then
						setPedWeaponSlot( localPlayer, 10 )
						else
						setPedWeaponSlot( localPlayer, 0 )
						end
					elseif getPedWeaponSlot( localPlayer)== 10 then
						setPedWeaponSlot( localPlayer, 0 )
					else 
						setPedWeaponSlot( localPlayer, 0 )
					end
				end	
			end
		else
			if (button) == "mouse_wheel_down" then
			setPedWeaponSlot( localPlayer, 0)
			end
		end

	end
end
addEventHandler("onClientKey", root, changeWeapOnBike)

function bbat_anim()
block, animation = getPedAnimation(localPlayer)
if not block and not animation and canHit == false then
triggerServerEvent("bbatAnim", resourceRoot, localPlayer)
canHit = true
setTimer ( canHitfalse, 100, 1)
--createLine()
triggerCreateHitColsOnBike()-- 
end
end

function canHitfalse() 
canHit = false
end

--[[function createLine() 

players = nil
players = getElementsByType( "ped" )
for i,thePlayer in ipairs(players) do
x2, y2, z2 = getElementPosition (thePlayer)
playerRotX,playerRotY,playerRotZ = getElementRotation(localPlayer)

dxDrawLine3D(x1,y1,z1,x2,y2,z2)
if getPedOccupiedVehicle (thePlayer)== false then 
if getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) < 2 then
if canHit == true then
if x1>x2 and y1>y2 then
triggerServerEvent("bbatHitting", resourceRoot, thePlayer,localPlayer,315)
end
if x1<x2 and y1>y2 then
triggerServerEvent("bbatHitting", resourceRoot, thePlayer,localPlayer,45)
end
if x1<x2 and y1<y2 then
triggerServerEvent("bbatHitting", resourceRoot, thePlayer,localPlayer,135)
end
if x1>x2 and y1<y2 then
triggerServerEvent("bbatHitting", resourceRoot, thePlayer,localPlayer,225)
end
end
end
end
end
end]]


function triggerCreateHitColsOnBike (weapon)

	if canHit == true then
		local weapon = getPedWeapon(localPlayer)
		triggerServerEvent("CreateHitColsOnBike",root,weapon)
	end
end

