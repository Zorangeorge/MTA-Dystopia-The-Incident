
addEvent("pedCrouch",true)

function setPedDucked(ped, state)
if state==true and (not isPedDucked(ped)) then
setPedControlState(ped, "crouch", true)
setTimer(setPedControlState, 100, 0, ped, "crouch", false)
return true
elseif state==false and isPedDucked(ped) then
setPedControlState(ped, "crouch", true)
setTimer(setPedControlState, 100, 0, ped, "crouch", false)
return true
end
return false
end



addEventHandler("pedCrouch",root,setPedDucked)


--[[
function shootgrenade()
  local stompergrenades=getElementData(localPlayer,"stomperammo") or 0
  if not isPedAiming(localPlayer) then
    return
  elseif getElementData(localPlayer,"stomperequipped") ~= true then
    return
  elseif stompergrenades == 0 then
    outputStatusInfo("No ammo", 255,255,255)
    return
  else
    local weapon = getPedWeapon(localPlayer)
    if (weapon == 31) or (weapon == 30) then
      local x,y,z = getElementPosition( localPlayer )
      local mx,my,mz = getPedTargetCollision (localPlayer)
      local gx, gy, gz = getPedWeaponMuzzlePosition(localPlayer)
      local sound = playSound3D( 'sounds/m79.wav', x, y, z, false )
      local distance
      if mx then distance = getDistanceBetweenPoints3D(x,y,z,mx,my,mz) end
      if not distance then distance = 100 end
      local projectilespeed = 0.1*distance/2.5
      if projectilespeed >=1.2 then projectilespeed = 1.2 end
      setSoundMaxDistance( sound, 30 )
      setSoundVolume(sound, 0.2)
      triggerServerEvent("recargar", localPlayer, localPlayer)
      local grenade = createProjectile ( localPlayer, 16, gx, gy, gz, projectilespeed)
      setElementData(localPlayer,"stomperammo",stompergrenades-1)
      grensmoke = createEffect ( "gunsmoke", gx, gy, gz)
      setTimer ( destroyElement, 1000, 1, grensmoke )
    end
  end
end
bindKey("mouse3", "down", shootgrenade)
bindKey("E", "down", shootgrenade)
]]