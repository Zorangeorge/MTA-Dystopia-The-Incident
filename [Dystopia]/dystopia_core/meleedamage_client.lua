function pedDamage ( attacker, weapon, bodypart, loss )
     
       local health = getElementHealth(source)
       local Dloss = meleeWeaponsDamage[weapon]
       
      if weaponsTrue[weapon] then
           if health-Dloss > 0 then 
              setElementHealth ( source,  health - Dloss) 
           elseif health-Dloss <= 0 then 
              triggerServerEvent ( "killThePed", source,source,attacker)  
           end
        end

        if KOWeapons[weapon] then
			if health < 40 then 
			   setPedAnimation ( source, "SWEET", "Sweet_injuredloop", 10000, true,false,true, false )
                   if getElementData( source, "KO") ~= true then
                      setElementData (source, "KO", true, true)
					  triggerEvent("sync.message", root, source, 125, 125, 125, "INCAPACITATED")
                      --outputDebugString ("KO set")
						if getElementData (source, "zombie") == true then
						setPedAnimation ( source, "ped", "WALK_drunk", 4000, true, true, false, false )
						setTimer( clearKO, 10000, 1, source)
						end
                   end
            
            end
        end
		
		if bleedWeapons[weapon] then
        
            local randnum = math.random (0,3)
            local randnumblood = math.random (0,359)
            local ix, iy, iz = getElementPosition (source)
			
			if weapon == 23 then
				if getElementData( source, "bleeding") ~= true then
				   setElementData (source, "bleeding", true, true) 
				   triggerEvent("sync.message", root, source, 255, 230, 230, "BLEEDING")
				end
				setPedFootBloodEnabled (source, true)
				tickTimer = setTimer( bleedingPed, 1000, 60, source) 
                clearTimer = setTimer( clearBleeding, math.random (5000, 15000), 1, source)
            
            else
				if randnum == 3 then
					if getElementData( source, "bleeding") ~= true then
					   setElementData (source, "bleeding", true, true)
					   triggerEvent("sync.message", root, source, 255, 230, 230, "BLEEDING")
					end
					setPedFootBloodEnabled (source, true)
					tickTimer = setTimer( bleedingPed, 1000, 60, source) 
					clearTimer = setTimer( clearBleeding, math.random (5000, 15000), 1, source)
				end
			end
        end
		
end

local tickTimer
local clearTimer

function clearBleeding(ped)
        
        if isElement(ped) and (getElementData(ped, "bleeding") == true) then
   
            setElementData (ped, "bleeding", false, true)
            setPedFootBloodEnabled (ped, false)
        
           --outputDebugString ("Bleeding cleared")
           
           if isTimer (tickTimer) then killTimer ( tickTimer ) end
           if isTimer (clearTimer) then killTimer ( clearTimer ) end
   
        end
    end

function setBleeding()
	local randnumblood = math.random (0,359)
	local ix, iy, iz = getElementPosition (localPlayer)
	fxAddBlood ( ix, iy, iz, randnumblood, randnumblood, randnumblood, 6, 1 )
	setPedFootBloodEnabled (localPlayer, true)
	
	if getElementData( localPlayer, "bleeding") ~= true then
		setElementData (localPlayer, "bleeding", true, true)
		--outputDebugString ("Bleeding set")
		tickTimer = setTimer( bleedingPed, 1000, 60, localPlayer)
		clearTimer = setTimer( clearBleeding, math.random (5000, 15000), 1, localPlayer)
	end
	
end
addCommandHandler("bleeding", setBleeding)
addEvent("setPlayerBleeding",true)
--addEvent("onClientPlayerDamage",true)
addEventHandler ( "setPlayerBleeding", getRootElement (), function () triggerEvent("onClientPlayerDamage",localPlayer,localPlayer,23,9,10) end)
addEventHandler ( "onClientPedDamage", getRootElement (), pedDamage )
addEventHandler ( "onClientPlayerDamage", getRootElement (), pedDamage )

   function clearKO(ped)
    if isElement(ped) and (getElementData(ped, "KO") == true) then
        setElementData (ped, "KO", false, true)
        --outputDebugString ("KO cleared")
    end
   end


	
addEvent("StopBleedingBandage",true)  	
function clearBleedingBandage()
        
        if isElement(source) and (getElementData(source, "bleeding") == true) then
   
            setElementData (source, "bleeding", false, true)
            setPedFootBloodEnabled (source, false)
			outputStatusInfo("Bleeding stopped", 250,250,250)
			local xp = getPlayerExp(source)
			setPlayerExp(source,xp+1)
			outputStatusInfo("+1 xp",240,240,240 )
           
           if isTimer (tickTimer) then killTimer ( tickTimer ) end
           if isTimer (clearTimer) then killTimer ( clearTimer ) end
        
		end
end	

addEventHandler("StopBleedingBandage", root, clearBleedingBandage)  

function bleedingPed(ped)
    
    if isElement (ped) then      
        
          if (isPedDead (ped) == nil) then return end
         
          if (isPedDead (ped) == true) then 
			  clearBleeding(ped) 
			  if getElementData(ped,"zombie") == true then setElementData(ped,"status","dead") end
			  return 
		  end
                                                         
        if (isPedDead (ped) == false) then 
            local  pedhealth = getElementHealth (ped)
            local  sx, sy, sz = getElementPosition (ped)
            local  randombloodamount = math.random (6,10)
            local  bleedloss = 1 --math.random (1,3) 
            
				if isElement(ped) and (getElementData(ped, "bleeding") == true) then
								 
					setElementHealth (ped, pedhealth-bleedloss)
										
					if ped == localPlayer then 
						outputStatusInfo("Bleeding!", 250,0,0)
						--outputStatusInfo("-"..bleedloss.." hp", 250,0,0)
					end
					
					fxAddBlood (sx, sy, sz, 0, 0, 0, 200, 0.8) 
					
				end
		end
	end
end
  
function manageBrokenBottle(attacker, weapon)
if attacker ~= localPlayer or weapon ~= 14 then 
	return
else
	local randchance = math.random(0,5)
	if randchance == 3 then 
	triggerServerEvent("ShatterBrokenBottle",resourceRoot)--takeWeapon(localPlayer,14)
	outputStatusInfo ("Bottle shattered!", 250,180,0)
	local victimhealth = getElementHealth(source)
	setElementHealth(source,victimhealth-20)
	end
end
end
addEventHandler("onClientPedDamage", getRootElement(),manageBrokenBottle)

function barbedWireMeleeDamage(loss,attacker) 
if isElement(loss) then attacker = loss end
	if getElementModel(source) ~= 1411 or (getElementType(attacker)~= "player" and getElementType(attacker)~= "ped") or getPedOccupiedVehicle(attacker) then 
		return 
	else
	local weapon = getPedWeapon(attacker)
	if weapon ~= 0 then return else
		if getElementType(attacker)== "player" then
			triggerEvent("onClientPlayerDamage",attacker,attacker,23,9,10) 
			triggerEvent("sync.message", root, attacker, 255, 230, 230, "STRIKE")
		elseif getElementType(attacker)== "ped" then 
			triggerEvent("onClientPedDamage",attacker,attacker,23,9,10)
			triggerEvent("sync.message", root, attacker, 255, 230, 230, "STRIKE")
		end
	end
	end
end

addEventHandler("onClientObjectDamage", getRootElement(), barbedWireMeleeDamage)--barbed wire fence melee damage
addEventHandler("onClientObjectBreak", getRootElement(), barbedWireMeleeDamage)--barbed wire fence melee damage
