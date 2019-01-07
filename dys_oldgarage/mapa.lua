 addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
     function()
        createObject(11388, -2048.216796875, 166.73092651367, 34.468391418457, 0.000000, 0.000000, 0.000000) --
		createObject(11389, -2048.1174316406, 166.71966552734, 30.975694656372, 0.000000, 0.000000, 0.000000) --
		createObject(11390, -2048.1791992188, 166.76277160645, 32.235980987549, 0.000000, 0.000000, 0.000000) --
		createObject(11391, -2056.2062988281, 158.56985473633, 29.087089538574, 0.000000, 0.000000, 0.000000) --
		createObject(11392, -2047.8289794922, 167.54446411133, 27.835615158081, 0.000000, 0.000000, 0.000000) --
		createObject(11393, -2043.5166015625, 161.337890625, 29.320350646973, 0.000000, 0.000000, 0.000000) --
		createObject(2893, -2050.9521484375, 171.15930175781, 29.11247253418, 7.9400024414063, 0.000000, 89.450988769531) --
		createObject(2893, -2050.9458007813, 169.32849121094, 29.112930297852, 7.9376220703125, 0.000000, 89.45068359375) --


--[[		local tow = createVehicle(562, -2052.4907226563, 154.04287719727, 28.589487075806, 0, 0, 0, "Taller")
		addVehicleUpgrade ( tow, 1010 )
		setVehicleDamageProof( tow, true)
		setVehicleIdleRespawnDelay ( tow, 10000 ) 
		tallerSF = false]]
     end
)

setGarageOpen(22,true)
--[[
function puerta(toggle)
    if toggle == true then
        setGarageOpen(22,true)
		 SFgarage = true
	end
   
    if toggle == false then
		setGarageOpen(22,false)
		 SFgarage = false
    end
end

function garage(source)
		local jugador = getPlayerName(source)
	--	outputDebugString ( jugador.." ha usado el comando del taller" )
       if SFgarage == true then
			puerta(false)
        else
            puerta(true)
        end
 
end
addCommandHandler( "sfgarage", garage, source)]]
