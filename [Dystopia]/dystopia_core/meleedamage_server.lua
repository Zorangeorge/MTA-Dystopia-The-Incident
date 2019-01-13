addEvent("ShatterBrokenBottle",true)  
addEvent ( "killThePed", true)
    
    function playerDamage ( attacker, weapon, bodypart, loss )
       
        local health = getElementHealth(source)
        local Dloss = meleeWeaponsDamage[weapon]
   
        if weaponsTrue[weapon] then
            
            if health-Dloss > 0 then
                setElementHealth ( source,  health-Dloss)
                else
				if getElementType(attacker) == "player" then
					killPed(source,attacker)
					else
					killPed(source)
				end
            end
        end
        
         if KOWeapons[weapon] then
       
            if health < 35 then 
            				
            setPedAnimation ( source, "SWEET", "Sweet_injuredloop", 10000, true,false,true, true )
            outputStatusInfo("Incapacitated", source, 250, 0, 0)
			setElementData(source,"incapacitated",true,true)
			local hkjfhplayer = source
			setTimer(resetIncapacitated, 10000, 1,hkjfhplayer)
       
            end
        end
        
    end
    addEventHandler ( "onPlayerDamage", getRootElement (), playerDamage )
    
    function forceKillPed (ped,attacker)
		if attacker == client then
		killPed (ped,client)
		else
		killPed (ped,attacker)
		end
    end
    addEventHandler ("killThePed", root, forceKillPed)
 
 function resetIncapacitated(player)
 setElementData(player,"incapacitated",false,true)
 hkjfhplayer = nil
end
 
function removeBrokenBottle ()
if isElement(client) and getPedWeapon(client,10) == 14 then
takeWeapon(client,14)
playSound3DToElement(client,client,"sounds/bottlebreak.mp3",10,0.5)
end 
end
 
addEventHandler("ShatterBrokenBottle", resourceRoot, removeBrokenBottle)