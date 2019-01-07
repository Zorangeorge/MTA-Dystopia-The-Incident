-------------------
-- Ejector Seats -- -- Makes it so you can eject from vehicles to reach rooftops or escape during crashes etc
-------- By -------
------ KWKSND ----- -- Makes Multi Theft Auto more fun!! :D
-------------------

burners = {}

function ejectsetkey (player,seat,jacked)
if getElementModel(source) == 520 or getElementData(source,"ejectorseats")== true then
	if getPedOccupiedVehicleSeat(player) == 0 then
		bindKey ( player, "X", "down", eject )
		--outputChatBox ( "Press X to Eject each passenger and then yourself.", player, 255,255,0 )
		outputInteractInfo("Eject: [X]",player,255,200,0)
	end
end
end

addEventHandler ( "onVehicleEnter", getRootElement(), ejectsetkey )

function clearkeyset (exitingPlayer, seat, playerjacked)
if getElementModel(source) == 520 or getElementData(source,"ejectorseats")== true then
	if seat == 0 then
		unbindKey ( exitingPlayer, "X", eject )
	end
end
end

addEventHandler ( "onVehicleStartExit", getRootElement(), clearkeyset )

function eject (source)
	if getPedOccupiedVehicleSeat(source) == 0 then
		car = getPedOccupiedVehicle(source)
		eX, eY, eZ = getElementPosition( car )
	
		passenger1 = getVehicleOccupant ( car, 1)
		passenger2 = getVehicleOccupant ( car, 2)
		passenger3 = getVehicleOccupant ( car, 3)
		passenger4 = getVehicleOccupant ( car, 4)
		driver = getVehicleOccupant ( car, 0)
		cleanbrn = setTimer (function()
			for brnrkey, brn in ipairs(burners) do
				destroyElement(brn)
				burners = nil
				burners = { }
			end
		end,7000, 1)
		if passenger1 then
			speedx, speedy, speedz = getElementVelocity ( car ) -- get the velocity of the player
		
			removePedFromVehicle ( passenger1 )
			setElementPosition (passenger1, eX, eY, eZ+5 )
			burner = createMarker ( eX, eY, eZ+5 ,"corona", 3, 255, 150, 0, 200 )
			table.insert( burners, burner )
			attachElements ( burner, passenger1, 0, 0, -0.5 )
			smoke = createObject(2780,eX, eY, eZ+5)
			table.insert( burners, smoke )
			attachElements ( smoke, passenger1, 0, 0, -0.5 )
			setElementAlpha(smoke,0)
			triggerClientEvent ( "ClientRemoveCol",  getRootElement(), smoke )
			setTimer (setElementVelocity , 50, 100, passenger1, speedx*0.5, speedy*0.5, 400 )
			giveWeapon ( passenger1, 46, 1, true )
			return
		end
		if passenger2 then
			speedx, speedy, speedz = getElementVelocity ( car ) -- get the velocity of the player
			
			removePedFromVehicle ( passenger2 )
			setElementPosition (passenger2, eX, eY, eZ+5 )
			burner = createMarker ( eX, eY, eZ+5 ,"corona", 3, 255, 150, 0, 200 )
			table.insert( burners, burner )
			attachElements ( burner, passenger2, 0, 0, -0.5 )
			smoke = createObject(2780,eX, eY, eZ+5)
			table.insert( burners, smoke )
			attachElements ( smoke, passenger2, 0, 0, -0.5 )
			setElementAlpha(smoke,0)
			triggerClientEvent ( "ClientRemoveCol",  getRootElement(), smoke )
			setTimer (setElementVelocity , 50, 100, passenger2, speedx*0.5, speedy*0.5, 400 )
			giveWeapon ( passenger2, 46, 1, true )
			return
		end
		if passenger3 then
			speedx, speedy, speedz = getElementVelocity ( car ) -- get the velocity of the player
				
			removePedFromVehicle ( passenger3 )
			setElementPosition (passenger3, eX, eY, eZ+5 )
			burner = createMarker ( eX, eY, eZ+5 ,"corona", 3, 255, 150, 0, 200 )
			table.insert( burners, burner )
			attachElements ( burner, passenger3, 0, 0, -0.5 )
			smoke = createObject(2780,eX, eY, eZ+5)
			table.insert( burners, smoke )
			attachElements ( smoke, passenger3, 0, 0, -0.5 )
			setElementAlpha(smoke,0)
			triggerClientEvent ( "ClientRemoveCol",  getRootElement(), smoke )
			setTimer (setElementVelocity , 50, 100, passenger3, speedx*0.5, speedy*0.5, 400 )
			giveWeapon ( passenger3, 46, 1, true )
			return
		end
		if passenger4 then
			speedx, speedy, speedz = getElementVelocity ( car ) -- get the velocity of the player
					
			removePedFromVehicle ( passenger4 )
			setElementPosition (passenger4, eX, eY, eZ+5 )
			burner = createMarker ( eX, eY, eZ+5 ,"corona", 3, 255, 150, 0, 200 )
			table.insert( burners, burner )
			attachElements ( burner, passenger4, 0, 0, -0.5 )
			smoke = createObject(2780,eX, eY, eZ+5)
			table.insert( burners, smoke )
			attachElements ( smoke, passenger4, 0, 0, -0.5 )
			setElementAlpha(smoke,0)
			triggerClientEvent ( "ClientRemoveCol",  getRootElement(), smoke )
			setTimer (setElementVelocity , 50, 100, passenger4, speedx*0.5, speedy*0.5, 400 )
			giveWeapon ( passenger4, 46, 1, true )
			return
		end
		if driver then
			speedx, speedy, speedz = getElementVelocity ( car ) -- get the velocity of the player
							
			removePedFromVehicle ( driver )
			setElementPosition (driver, eX, eY, eZ+5 )
			burner = createMarker ( eX, eY, eZ+5 ,"corona", 3, 255, 150, 0, 200 )
			table.insert(burners,burner)
			attachElements ( burner, driver, 0, 0, -0.5 )
			smoke = createObject(2780,eX, eY, eZ+5,0,0,0)
			table.insert( burners, smoke )
			attachElements ( smoke, driver, 0, 0, 0,0,0,0 )
			setElementAlpha(smoke,0)
			triggerClientEvent ( "ClientRemoveCol",  getRootElement(), smoke )
			setTimer (setElementVelocity, 50, 100, driver, speedx*0.5, speedy*0.5, 400 )
			giveWeapon ( driver, 46, 1, true )
			unbindKey ( source, "X", eject )
			return
		end
	end
end
			