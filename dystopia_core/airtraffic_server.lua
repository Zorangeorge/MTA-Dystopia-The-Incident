-- airtraffic by LANMan 2017

SUPPLY_PLANE_CRASHES_ENABLED = false
plane = nil
DELETETIMER = 60*60*1000
PLANESPWNTIMER = 61*60*1000

setTimer(function()
if SUPPLY_PLANE_CRASHES_ENABLED then
if getPlayerCount() > 0 then -- checa se tem alguém jogando
	-- vê quantos pilots tem no server 
--[[	local cont = 0
	for i, v in ipairs(getElementsByType("ped")) do
		local data = getAllElementData(v) -- get all the element data of the ped 
    	for k, vv in pairs (data) do
			if vv == "Pilot" then
				if isPedDead(v) then
					cont = 0
				else
					cont = cont + 1
					outputChatBox("Airtraffic check!\nPilots count: "..cont)
				end			
			end
		end
	end]]
	--if not plane then
		local randomPlayer1 = getRandomPlayer() -- pegando um usuário aleatório para ser a referência da posição do avião
		local x, y, z = getElementPosition(randomPlayer1)
		local int = getElementInterior(randomPlayer1)
		local dim = getElementDimension(randomPlayer1) -- pegando a dimensão onde está o player aleatório

		-- aleatory start location
		local rand_loc = math.random(8)
		if rand_loc == 1 then
			x = x - 90
			y = y + 10
		elseif rand_loc == 2 then
			x = x + 90
			y = y - 10
		elseif rand_loc == 3 then
			x = x + 16
			y = y - 90
		elseif rand_loc == 4 then
			x = x - 00
			y = y + 90
		elseif rand_loc == 5 then
			x = x - 90
			y = y - 90
		elseif rand_loc == 6 then
			x = x - 90
			y = y + 90
		elseif rand_loc == 7 then
			x = x + 90
			y = y - 90
		elseif rand_loc == 8 then
			x = x + 90
			y = y + 90
		end

		-- aleatory start altitude
		local RNDalt =1--= math.random(6)
		if RNDalt == 1 then
			z = 100
		end
		--[[elseif RNDalt == 2 then
			z = 200
		elseif RNDalt == 3 then
			z = 300     			-- only for see in high places
		elseif RNDalt == 4 then
			z = 400     			-- only for see in airplanes or heli
		elseif RNDalt == 5 then
			z = 500
		elseif RNDalt == 6 then
			z = 600 
		else
			z = 600 -- only for see in airplanes or heli
		end]]

		-- aleatory plane
		--local RNDplane = math.random(1,3)
		if RNDalt == 1 then
			model = 592 -- Andromada
	--[[	elseif RNDalt == 2 then
			model = 577
		elseif RNDalt == 3 then
			model = 520 -- Hydra
		end]]
		
	--[[if RNDalt == 1 then
			model = 592 -- Andromada
		elseif RNDalt == 2 then
			model = 577 -- AT-400
		elseif RNDalt == 6 then
			model = 520 -- Hydra

		-- mais comuns
		elseif RNDalt == 13 then
			model = 592 -- Andromada
		elseif RNDalt == 15 then
			model = 577 -- AT-400
		elseif RNDalt == 16 then
			model = 592 -- Andromada
		end]]
		end
		

		local pilot 
		if not pilot then pilot = createPed(287, x, y, z) end
		setElementData(pilot, "BotTeam", getTeamFromName("Establishment"))
		setElementInterior(pilot, int)
		setElementDimension(pilot, dim)
		setElementData(pilot, "name", "Pilot",true)

		-- aleatory direction
		local RNDdir = math.random(4)
		if RNDdir == 1 then -- Y +
			plane = createVehicle (model, x, y, z)
			setElementDimension(plane, dim)
			setElementRotation(plane,0,0,0)
			warpPedIntoVehicle(pilot,plane)
			setVehicleEngineState (plane, true)
			setElementVelocity(plane,0,0.3,-1)
		elseif RNDdir == 2 then -- Y -
			plane = createVehicle (model, x, y, z)
			setElementDimension(plane, dim)
			setElementRotation(plane,0,0,180)
			warpPedIntoVehicle(pilot,plane)
			setVehicleEngineState (plane, true)
			setElementVelocity(plane,0,-0.3,-1)
		elseif RNDdir == 3 then -- X +
			plane = createVehicle (model, x, y, z)
			setElementDimension(plane, dim)
			setElementRotation(plane,0,0,90)
			warpPedIntoVehicle(pilot,plane)
			setVehicleEngineState (plane, true)
			setElementVelocity(plane,-0.3,0,-1)
		elseif RNDdir == 4 then -- X -
			plane = createVehicle (model, x, y, z)
			setElementDimension(plane, dim)
			setElementRotation(plane,0,0,270)
			warpPedIntoVehicle(pilot,plane)
			setVehicleEngineState (plane, true)
			setElementVelocity(plane,0.3,0,-1)
					
		end
		
		if plane then
			outputDebugString("PLANE SPAWNED: alt. "..RNDalt.."00 m")
			--local planeregion = getElementZone(plane)
			outputTopBar( "Supply plane spotted!", root, 255, 255, 255 )
			--setElementHealth(plane,20)
			local planeblip = createBlipAttachedTo ( plane, 5, 2, 0, 255, 255, 255, 0, 999 )
			brHideBlip(planeblip)
			setVehicleLandingGearDown(plane, false)
			toggleVehicleRespawn(plane,false)
			setVehicleColor(plane, 153, 153, 102, 153, 153, 102, 153, 153, 102, 153, 153, 102 )
			setVehicleFuelTankExplodable(plane, true)
			setVehiclePanelState ( plane, 0, 3 )
			setVehiclePanelState ( plane, 1, 3 )
			setVehiclePanelState ( plane, 2, 3 )
			setVehiclePanelState ( plane, 3, 3 )
			setVehiclePanelState ( plane, 4, 3 )
			setVehiclePanelState ( plane, 5, 3 )
			setVehiclePanelState ( plane, 6, 3 )
			local planetodelete = plane
			local pilottodelete = pilot
			local bliptodelete = planeblip
			setTimer(function()
				if isElement(planetodelete) then destroyElement(planetodelete)
				end
				if isElement(pilottodelete) then destroyElement(pilottodelete)
				end
				if isElement(bliptodelete) then destroyElement(bliptodelete)
				end
				plane = nil
				end, DELETETIMER,1)

		end
	--end
	
	
--end
end
end
end, PLANESPWNTIMER, 0)

function checkForAircrash()
if getElementModel(source)== 592 then 
	setElementVelocity(source,0,0,0)
	--if isVehicleOnGround(source) then 
	local x,y,z = getElementPosition(source)
	local rx,ry,rz = getElementRotation(source)
	local pilot = getVehicleOccupant(source)
	--destroyElement(getVehicleOccupant(source))
	destroyElement(source)
		
	local propplane = createVehicle(592,x,y,z,rx,ry,rz)
	--local planeregion = getElementZone(propplane)
	outputTopBar( "Supply plane crashed!", 255, 255, 255 )
	local aircrashblip = createBlipAttachedTo ( propplane, 19, 2, 0, 255, 255, 255, 0, 999 )
	setTimer(destroyElement,DELETETIMER,1,aircrashblip)
	warpPedIntoVehicle(pilot,propplane)
	setVehicleColor(propplane, 153, 153, 102, 153, 153, 102, 153, 153, 102, 153, 153, 102 )
	setVehicleDamageProof(propplane, true)
      setVehicleEngineState(propplane, false)
	  setElementHealth(propplane, 300)
	  setElementData(propplane, "vehicle_disabled",true,true)
	  setElementData(propplane, "repaired", false,true)
	    setVehiclePanelState ( propplane, 0, 3 )
	    setVehiclePanelState ( propplane, 1, 3 )
		setVehiclePanelState ( propplane, 2, 3 )
	    setVehiclePanelState ( propplane, 3, 3 )
	    setVehiclePanelState ( propplane, 4, 3 )
	    setVehiclePanelState ( propplane, 5, 3 )
	    setVehiclePanelState ( propplane, 6, 3 )

	setTimer(setElementFrozen,4000,1,propplane,true)
	setTimer(destroyElement,DELETETIMER,1,propplane);
	setTimer(destroyElement,DELETETIMER,1,pilot);
	setTimer(outputDebugString,DELETETIMER,1,"AIRCRASH DELETED")
	triggerClientEvent("openCargoDoor",propplane)
	outputDebugString("AIRCRASH LOOT SPAWNED")
end
end
addEventHandler("onVehicleExplode",root,checkForAircrash)

function cyclicPlaneCheck (plane)
	if isElement(plane) then 
		if isVehicleOnGround(plane) then
		checkForAircrash(plane)
		end
	end 
end
setTimer(cyclicPlaneCheck,5000,0,plane)

addEvent("createAircrashLootItem",true)

function createAircrashLootObjectItem(a, b, c, d, e,f,g )
createObjectItem( a, b, c, d, e,f,g )
end

addEventHandler("createAircrashLootItem",root,createAircrashLootObjectItem)

--checa se não tem ninguém perto do piloto, se não tem, apaga ele e o avião
--[[setTimer(function()
	for i, peds in ipairs(getElementsByType("ped")) do
			local data = getAllElementData(peds) -- get all the element data of the ped 
    		for k, vv in pairs (data) do
				if vv == "Pilot" then
					local contajogadores = 0
					local deucerto = 0
					for i, players in ipairs(getElementsByType("player")) do
						contajogadores = contajogadores + 1
						x, y, z = getElementPosition(players)
						xp, yp, zp = getElementPosition(peds)
						if getDistanceBetweenPoints3D(x, y, z, xp, yp, zp) > 600 then
							deucerto = deucerto + 1
						end
					end
					if deucerto >= contajogadores then
						local plane = getPedOccupiedVehicle(peds)
						destroyElement(peds)
						destroyElement(plane)
						outputDebugString("PLANE DELETED")
						
					end
				end
			end
	end
end, 5000, 0)]]

-- airtraffic by LANMan 2017
