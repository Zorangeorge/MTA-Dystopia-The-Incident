--by Slothman

--SETTINGS
grapplegun = 23 --WHICH GUN WILL BE USED AS A GRAPPLE?
gunrange = 20 --HOW FAR WILL THE GRAPPLE RANGE BE?

--DO NOT ALTER ANYTHING BELOW HERE

if gunrange > 150 then
    gunrange = 150
end
local processingPlayers = {}
local root = getRootElement()
local keys = getBoundKeys ( "Jump" )

function jumped ()
    local theVehicle = getPedOccupiedVehicle ( getLocalPlayer() )
    if ( theVehicle ) then
        local carpurpose = (getElementData ( theVehicle,  "purpose" ))
        if (carpurpose ==  "grapple") then
            triggerServerEvent ( "ongrapplejump", getLocalPlayer(), getLocalPlayer() )  
        end
    end
end

if keys then
    for i,keyName in ipairs(keys) do
        bindKey ( keyName, "down", jumped )
    end
end

function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )

    if weapon == grapplegun and getElementData(localPlayer,"zipline") == true then 
        if source == getLocalPlayer() then
            toggleControl ( "fire", false )
			setElementData(localPlayer,"zipline",false,true)
            setTimer ( toggleControl, 1200, 1, "fire", true )
            toggleControl ( "vehicle_fire", false )
            setTimer ( toggleControl, 1200, 1, "vehicle_fire", true )
            if (hitElement) then
                if getElementType(hitElement) == "vehicle" then
                    px = hitX
                    py = hitY
                    pz = hitZ
                    local vx, vy, vz = getElementPosition(hitElement)
                    local sx = px - vx
                    local sy = py - vy
                    local sz = pz - vz
                    
                    local x, y, z, lx, ly, lz = getCameraMatrix()
                    local camangle = ( 360 - math.deg ( math.atan2 ( ( x - lx ), ( y - ly ) ) ) ) % 360
            
                    local rotpX = 30
                    local rotpY = 0
                    local rotpZ = camangle-180
                    
                    local rotvX,rotvY,rotvZ = getElementRotation(hitElement)
                    
                    local t = math.rad(rotvX)
                    local p = math.rad(rotvY)
                    local f = math.rad(rotvZ)
                    
                    local ct = math.cos(t)
                    local st = math.sin(t)
                    local cp = math.cos(p)
                    local sp = math.sin(p)
                    local cf = math.cos(f)
                    local sf = math.sin(f)
                    
                    local z = ct*cp*sz + (sf*st*cp + cf*sp)*sx + (-cf*st*cp + sf*sp)*sy
                    local x = -ct*sp*sz + (-sf*st*sp + cf*cp)*sx + (cf*st*sp + sf*cp)*sy
                    local y = st*sz - sf*ct*sx + cf*ct*sy
                    
                    local rotX = rotpX - rotvX
                    local rotY = rotpY - rotvY
                    local rotZ = rotpZ - rotvZ

                    setTimer ( triggerServerEvent, 1200, 1,"gluezPlayer", source, hitElement, x, y, z, rotX, rotY, rotZ )
                end
            end
            
            setRadioChannel (0)

            local x, y, z = getPedTargetStart(getLocalPlayer())
            local lx, ly, lz = getPedTargetEnd(getLocalPlayer())
            local camlen = getDistanceBetweenPoints3D(x, y, z, lx, ly, lz)
            local fromX, fromY, fromZ = getPedBonePosition(getLocalPlayer(), 26)
            local toX = fromX + (lx - x)/camlen*gunrange
            local toY = fromY + (ly - y)/camlen*gunrange
            local toZ = fromZ + (lz - z)/camlen*gunrange
            local hit, hitX, hitY, hitZ = processLineOfSight(fromX, fromY, fromZ, toX, toY, toZ, true, true, false, true, false, true, true)
            
            groundshot = 0
            
            if hit then 
                if fromZ > hitZ then
                    local len = getDistanceBetweenPoints3D(fromX, fromY, fromZ, hitX, hitY, hitZ)
                    local hitX = fromX + (hitX - fromX)/len*(len - .5)
                    local hitY = fromY + (hitY - fromY)/len*(len - .5)
                    local ground = getGroundPosition ( hitX, hitY, hitZ + 1 )
                    local distance = (getDistanceBetweenPoints3D (hitX, hitY, hitZ, hitX, hitY, ground))
                    if distance < .3 then
                        hitZ = hitZ + 1
                        groundshot = 1
                    end
                elseif fromZ < hitZ then
                    local len = getDistanceBetweenPoints3D(fromX, fromY, fromZ, hitX, hitY, hitZ)
                    local hitX = fromX + (hitX - fromX)/len*(len - .5)
                    local hitY = fromY + (hitY - fromY)/len*(len - .5)
                    local rooffree = isLineOfSightClear ( hitX, hitY, hitZ, hitX, hitY, hitZ + .4, true, true, false, true, false, true, true )
                    if not rooffree then
                        groundshot = 2
                        hitZ = hitZ - .5
                    end
                end
                local len = getDistanceBetweenPoints3D(fromX, fromY, fromZ, hitX, hitY, hitZ)
                hitX = fromX + (hitX - fromX)/len*(len - .5)
                hitY = fromY + (hitY - fromY)/len*(len - .5)
                hitZ = fromZ + (hitZ - fromZ)/len*(len - .5)
                local angle = math.deg(math.atan2(hitY - fromY, hitX - fromX)) - 90
                triggerServerEvent ( "ongrapple", getLocalPlayer(), wallstick, hitX, hitY, hitZ, angle, groundshot )    
                aplayer = source
                local thisname = getPlayerName(aplayer)
                local thisguyschip = createObject ( 1935, hitX, hitY, hitZ, 0, 0, pedrot )
                setElementData ( aplayer, "targethook", thisguyschip )
                setElementAlpha( thisguyschip, 0)
                processingPlayers[aplayer] = true
                setTimer ( stopline, 1000, 1, aplayer )
            end
        else
            aplayer = source
            local thisname = getPlayerName(aplayer)
            local thisguyschip = createObject ( 1935, hitX, hitY, hitZ, 0, 0, pedrot )
            setElementData ( aplayer, "targethook", thisguyschip )
            setElementAlpha( thisguyschip, 0)
            processingPlayers[aplayer] = true
            setTimer ( stopline, 1000, 1, aplayer )
        end
    else
        local theVehicle = getPedOccupiedVehicle ( getLocalPlayer() )
        if (source == getLocalPlayer()) and ( theVehicle ) then
            local carpurpose = (getElementData ( theVehicle,  "purpose" ))
            if (carpurpose ==  "grapple") then
                if (getPedWeaponSlot( getLocalPlayer() ) == 3) or (getPedWeaponSlot( getLocalPlayer() ) == 2) or (getPedWeaponSlot( getLocalPlayer() ) == 6) then
                    toggleControl ( "fire", false )
                    setTimer ( toggleControl, 1200, 1, "fire", true )
                    toggleControl ( "vehicle_fire", false )
                    setTimer ( toggleControl, 1200, 1, "vehicle_fire", true )
                end
            end
        end
    end
end

addEventHandler ( "onClientPlayerWeaponFire", getRootElement(), onClientPlayerWeaponFireFunc )

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
		--setRadioChannel (0)
		--if getElementModel(source) == 464 then setVehicleEngineState(source,false) end
        local carpurpose = (getElementData ( source,  "purpose" ))
        if (carpurpose ==  "grapple") then
            setElementCollisionsEnabled(source, false)
            setVehicleEngineState ( source, false )
            setVehicleOverrideLights ( source, 1 )
            setPlayerHudComponentVisible ( "vehicle_name", false )
            if isElementInWater(source) and (thePlayer == getLocalPlayer()) then
                triggerServerEvent ( "ongrapplejump", getLocalPlayer(), getLocalPlayer() )  
            end         
        end
    end
)

function stationstop(station)
    local theVehicle = getPedOccupiedVehicle ( getLocalPlayer() )
    if ( theVehicle ) then
        local carpurpose = (getElementData ( theVehicle,  "purpose" ))
        if (carpurpose ==  "grapple") then
            oldslot = getPedWeaponSlot( getLocalPlayer() )
            if oldslot == 2 then
                local ammo = getPedTotalAmmo ( getLocalPlayer(), 3 )
                if ammo > 0 then
                    setPedWeaponSlot ( getLocalPlayer(), 3 )
                else
                    local ammo = getPedTotalAmmo ( getLocalPlayer(), 4 )
                    if ammo > 0 then
                        setPedWeaponSlot ( getLocalPlayer(), 4 )
                    else
                        local ammo = getPedTotalAmmo ( getLocalPlayer(), 5 )
                        if ammo > 0 then
                            setPedWeaponSlot ( getLocalPlayer(), 5 )
                        else
                            local ammo = getPedTotalAmmo ( getLocalPlayer(), 6 )
                            if ammo > 0 then
                                setPedWeaponSlot ( getLocalPlayer(), 6 )
                            end
                        end
                    end
                end
            elseif oldslot == 3 then
                local ammo = getPedTotalAmmo ( getLocalPlayer(), 4 )
                if ammo > 0 then
                    setPedWeaponSlot ( getLocalPlayer(), 4 )
                else
                    local ammo = getPedTotalAmmo ( getLocalPlayer(), 5 )
                    if ammo > 0 then
                        setPedWeaponSlot ( getLocalPlayer(), 5 )
                    else
                        local ammo = getPedTotalAmmo ( getLocalPlayer(), 6 )
                        if ammo > 0 then
                            setPedWeaponSlot ( getLocalPlayer(), 6 )
                        else
                            local ammo = getPedTotalAmmo ( getLocalPlayer(), 2 )
                            if ammo > 0 then
                                setPedWeaponSlot ( getLocalPlayer(), 2 )
                            end
                        end
                    end
                end
            elseif oldslot == 4 then
                local ammo = getPedTotalAmmo ( getLocalPlayer(), 5 )
                if ammo > 0 then
                    setPedWeaponSlot ( getLocalPlayer(), 5 )
                else
                    local ammo = getPedTotalAmmo ( getLocalPlayer(), 6 )
                    if ammo > 0 then
                        setPedWeaponSlot ( getLocalPlayer(), 6 )
                    else
                        local ammo = getPedTotalAmmo ( getLocalPlayer(), 2 )
                        if ammo > 0 then
                            setPedWeaponSlot ( getLocalPlayer(), 2 )
                        else
                            local ammo = getPedTotalAmmo ( getLocalPlayer(), 3 )
                            if ammo > 0 then
                                setPedWeaponSlot ( getLocalPlayer(), 3 )
                            end
                        end
                    end
                end
            elseif oldslot == 5 then
                local ammo = getPedTotalAmmo ( getLocalPlayer(), 6 )
                if ammo > 0 then
                    setPedWeaponSlot ( getLocalPlayer(), 6 )
                else
                    local ammo = getPedTotalAmmo ( getLocalPlayer(), 2 )
                    if ammo > 0 then
                        setPedWeaponSlot ( getLocalPlayer(), 2 )
                    else
                        local ammo = getPedTotalAmmo ( getLocalPlayer(), 3 )
                        if ammo > 0 then
                            setPedWeaponSlot ( getLocalPlayer(), 3 )
                        else
                            local ammo = getPedTotalAmmo ( getLocalPlayer(), 4 )
                            if ammo > 0 then
                                setPedWeaponSlot ( getLocalPlayer(), 4 )
                            end
                        end
                    end
                end
            elseif oldslot == 6 then
                local ammo = getPedTotalAmmo ( getLocalPlayer(), 2 )
                if ammo > 0 then
                    setPedWeaponSlot ( getLocalPlayer(), 2 )
                else
                    local ammo = getPedTotalAmmo ( getLocalPlayer(), 3 )
                    if ammo > 0 then
                        setPedWeaponSlot ( getLocalPlayer(), 3 )
                    else
                        local ammo = getPedTotalAmmo ( getLocalPlayer(), 4 )
                        if ammo > 0 then
                            setPedWeaponSlot ( getLocalPlayer(), 4 )
                        else
                            local ammo = getPedTotalAmmo ( getLocalPlayer(), 5 )
                            if ammo > 0 then
                                setPedWeaponSlot ( getLocalPlayer(), 5 )
                            end
                        end
                    end
                end
            else
                local ammo = getPedTotalAmmo ( getLocalPlayer(), 2 )
                if ammo > 0 then
                    setPedWeaponSlot ( getLocalPlayer(), 2 )
                else
                    local ammo = getPedTotalAmmo ( getLocalPlayer(), 3 )
                    if ammo > 0 then
                        setPedWeaponSlot ( getLocalPlayer(), 3 )
                    else
                        local ammo = getPedTotalAmmo ( getLocalPlayer(), 4 )
                        if ammo > 0 then
                            setPedWeaponSlot ( getLocalPlayer(), 4 )
                        else
                            local ammo = getPedTotalAmmo ( getLocalPlayer(), 5 )
                            if ammo > 0 then
                                setPedWeaponSlot ( getLocalPlayer(), 5 )
                            else
                                local ammo = getPedTotalAmmo ( getLocalPlayer(), 6 )
                                if ammo > 0 then
                                    setPedWeaponSlot ( getLocalPlayer(), 6 )
                                end
                            end
                        end
                    end                     
                end
            end         
            cancelEvent (true)
        end
    end
end

addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(), stationstop)

function createLine ()
if #processingPlayers>0 then
    for aplayer in pairs(processingPlayers) do
        local Ptarget = (getElementData ( aplayer, "targethook" ))
        mx, my, mz = getElementPosition( Ptarget )
        local px, py, pz = getElementPosition ( aplayer )
        dxDrawLine3D (px, py, pz, mx, my, mz, tocolor(0,0,0,255), 3, false, 1 )
    end
end
end
addEventHandler("onClientRender",root, createLine )

function stopline (aplayer)
    processingPlayers[aplayer] = nil
    local Ptarget = (getElementData ( aplayer, "targethook" ))
    destroyElement(Ptarget)
end