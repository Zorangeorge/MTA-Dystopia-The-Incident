function pedDamaged(attacker, weapon, bodypart , loss)
ped = source
triggerServerEvent("pedWasDamaged", ped, attacker, weapon, bodypart , loss) 
end
addEventHandler("onClientPedDamage",getRootElement(),pedDamaged) 

local meatpieces = {}

function butcherbody(button, press)

local weapon = getPedWeapon(localPlayer)

if getElementData(localPlayer,"insidebutchercol") ~= nil and bladedWeapons[weapon] and weapon ~= 15 and button == "r" then 
														  
	local butchercol = getElementData(localPlayer,"insidebutchercol")
	if not isElement(butchercol) then return end
	local deadbody = getElementData(butchercol,"owner")
	local name = getElementData(deadbody,"name")
	local x,y,z = getElementPosition(deadbody)
	local rand = math.random(0,4)
	local  randombloodamount = math.random (6,10)
		
	if isElement(getElementAttachedTo(butchercol)) == false then return else
	if isElement(deadbody) and getElementData(butchercol,"harvested")~=true and getElementData(deadbody,"zombie")~= true then --
		setTimer(function()local randomspread = math.random (0.1,0.5); fxAddBlood (x+randomspread, y+randomspread, z-0.90+randomspread, 0, 0, 0, 200, 0.8)end,1000,7)

		local x,y,z = getElementPosition( deadbody )
		local px, py, pz = getElementPosition( localPlayer )
		local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360 --MAGIC SPELL TO MAKE PEDS LOOK AT STUFF

		triggerServerEvent("ButcherAnim",localPlayer)
		
		local xp = getPlayerExp(localPlayer)
		setPlayerExp(localPlayer,xp+2)
		outputStatusInfo("+2 xp", 240,240,240 )
		
		setTimer(function() setElementAlpha(deadbody, 0); setElementCollisionsEnabled(deadbody,false); meatpieces = {};  end, 6000, 1)
		if #meatpieces <= 2 then
		
		triggerServerEvent("BodyButchered", deadbody,butchercol)

		table.insert(meatpieces, "meat")
		setElementData(butchercol,"harvested",true)
		setElementData(deadbody,"name","")
		
		end
	end	
	end

end
end
addEventHandler("onClientKey",root,butcherbody)

--ped DAMAGED

function pedDamaged ( attacker, weapon, bodypart )

if not attacker then return end
if weapon == 51 then weapon = 16 end

    if getElementType ( source ) == "ped" and getElementType ( attacker ) == "player" then
        if (getElementData (source, "type") == "civilian") then
			local weapslot = getSlotFromWeapon(weapon)
            local melee = false
			local fireweapon = false
			
				if (getPedWeapon(source) < 16) then
					melee = true
				else
					fireweapon = true				
				end
				
				if bodypart == 9 then
						local rand = math.random(0,2)
						if rand == 0 then
							setPedAnimation(source,"ped","gas_cwr",2000,false,true,false,false)
							setTimer(setElementData,1000,1,source,"panic", true,true)
							triggerEvent("sync.message", root, source, 255, 204, 0, "PANIC")
						else
							setPedAnimation(source,"ped","KO_shot_face",5000,false,true,false,false)
							setTimer(setElementData,3000,1,source,"panic", true,true)
							triggerEvent("sync.message", root, source, 255, 204, 0, "PANIC")
						end
				end
				
				if bodypart == 3  --[[and weapslot ~= 0 and weapslot ~= 1 and weapslot ~= 10]] then
				local rand = math.random(1,4)
					if rand == 1 then
						setPedAnimation(source,"ped","handscower",2000,false,true,false,false)
						setTimer(setElementData,1000,1,source,"panic", true,true)
						triggerEvent("sync.message", root, source, 255, 204, 0, "PANIC")
					elseif rand == 2 then
						setPedAnimation(source,"ped","EV_step",2000,false,true,false,false)
						setTimer(setElementData,1000,1,source,"panic", true,true)
						triggerEvent("sync.message", root, source, 255, 204, 0, "PANIC")
					elseif rand == 3 then
						setPedAnimation(source,"ped","getup",3000,false,true,false,false)
						setTimer(setElementData,1500,1,source,"panic", true,true)
						triggerEvent("sync.message", root, source, 255, 204, 0, "PANIC")
					elseif rand == 4 then
						setPedAnimation(source,"ped","KO_shot_stom",5000,false,true,false,false)
						setTimer(setElementData,3000,1,source,"panic", true,true)
						triggerEvent("sync.message", root, source, 255, 204, 0, "PANIC")
					end
				elseif --[[weapslot ~= 0 and weapslot ~= 1 and weapslot ~= 10 and]] (bodypart == 7 or bodypart == 8) then
					setPedAnimation(source,"ped","getup",3000,false,true,false,false)
					setTimer(setElementData,1500,1,source,"panic", true,true)
					triggerEvent("sync.message", root, source, 255, 204, 0, "PANIC")
				end
        end
    end
end
addEventHandler ( "onClientPedDamage", getRootElement(), pedDamaged )


