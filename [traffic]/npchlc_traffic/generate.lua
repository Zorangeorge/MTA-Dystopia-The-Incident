function initTrafficGenerator()
	traffic_density = {peds = 0.01,cars = 0.001--[[0.00001]],boats = 0.000001,planes = 0.000001}

	population = {peds = {},cars = {},boats = {},planes = {}}
	element_timers = {}

	players = {}
	for plnum,player in ipairs(getElementsByType("player")) do
		players[player] = true
	end
	addEventHandler("onPlayerJoin",root,addPlayerOnJoin)
	addEventHandler("onPlayerQuit",root,removePlayerOnQuit)

	square_subtable_count = {}

	setTimer(updateTraffic,1000,0)
end

function addPlayerOnJoin()
	players[source] = true
end

function removePlayerOnQuit()
	players[source] = nil
end

function updateTraffic()
	server_coldata = getResourceFromName("server_coldata")
	npc_hlc = getResourceFromName("npc_hlc")

	colcheck = get("npchlc_traffic.check_collisions")
	colcheck = colcheck == "all" and root or colcheck == "local" and resourceRoot or nil

	updateSquarePopulations()
	generateTraffic()
	removeEmptySquares()
end

function updateSquarePopulations()
	if square_population then
		for dim,square_dim in pairs(square_population) do
			for y,square_row in pairs(square_dim) do
				for x,square in pairs(square_row) do
					square.count = {peds =  0,cars =  0,boats =  0,planes =  0}
					square.list  = {peds = {},cars = {},boats = {},planes = {}}
					square.gen_mode  = "despawn"
				end
			end
		end
	end

	countPopulationInSquares("peds")
	countPopulationInSquares("cars")
	countPopulationInSquares("boats")
	countPopulationInSquares("planes")

	for player,exists in pairs(players) do
		local x,y = getElementPosition(player)
		local dim = getElementDimension(player)
		x,y = math.floor(x/SQUARE_SIZE),math.floor(y/SQUARE_SIZE)

		for sy = y-4,y+4 do for sx = x-4,x+4 do
			local square = getPopulationSquare(sx,sy,dim)
			if not square then
				square = createPopulationSquare(sx,sy,dim,"spawn")
			else
				if x-3 <= sx and sx <= x+3 and y-3 <= sy and sy <= y+3 then
					square.gen_mode = "nospawn"
				else
					square.gen_mode = "spawn"
				end
			end
		end end
	end

	if colcheck then call(server_coldata,"generateColData",colcheck) end
end

function removeEmptySquares()
	if square_population then
		for dim,square_dim in pairs(square_population) do
			for y,square_row in pairs(square_dim) do
				for x,square in pairs(square_row) do
					if
						square.gen_mode == "despawn" and
						square.count.peds == 0 and
						square.count.cars == 0 and
						square.count.boats == 0 and
						square.count.planes == 0
					then
						destroyPopulationSquare(x,y,dim)
					end
				end
			end
		end
	end
end

function countPopulationInSquares(trtype)
	for element,exists in pairs(population[trtype]) do
		if getElementType(element) ~= "ped" or not isPedInVehicle(element) then
			local x,y = getElementPosition(element)
			local dim = getElementDimension(element)
			x,y = math.floor(x/SQUARE_SIZE),math.floor(y/SQUARE_SIZE)

			for sy = y-2,y+2 do for sx = x-2,x+2 do
				local square = getPopulationSquare(sx,sy,dim)
				if sx == x and sy == y then
					if not square then square = createPopulationSquare(sx,sy,dim,"despawn") end
					square.list[trtype][element] = true
				end
				if square then square.count[trtype] = square.count[trtype]+1 end
			end end
		end
	end
end

function createPopulationSquare(x,y,dim,genmode)
	if not square_population then
		square_population = {}
		square_subtable_count[square_population] = 0
	end
	local square_dim = square_population[dim]
	if not square_dim then
		square_dim = {}
		square_subtable_count[square_dim] = 0
		square_population[dim] = square_dim
		square_subtable_count[square_population] = square_subtable_count[square_population]+1
	end
	local square_row = square_dim[y]
	if not square_row then
		square_row = {}
		square_subtable_count[square_row] = 0
		square_dim[y] = square_row
		square_subtable_count[square_dim] = square_subtable_count[square_dim]+1
	end
	local square = square_row[x]
	if not square then
		square = {}
		square_subtable_count[square] = 0
		square_row[x] = square
		square_subtable_count[square_row] = square_subtable_count[square_row]+1
	end
	square.count = {peds =  0,cars =  0,boats =  0,planes =  0}
	square.list  = {peds = {},cars = {},boats = {},planes = {}}
	square.gen_mode = genmode
	return square
end

function destroyPopulationSquare(x,y,dim)
	if not square_population then return end
	local square_dim = square_population[dim]
	if not square_dim then return end
	local square_row = square_dim[y]
	if not square_row then return end
	local square = square_row[x]
	if not square then return end
	
	square_subtable_count[square] = nil
	square_row[x] = nil
	square_subtable_count[square_row] = square_subtable_count[square_row]-1
	if square_subtable_count[square_row] ~= 0 then return end
	square_subtable_count[square_row] = nil
	square_dim[y] = nil
	square_subtable_count[square_dim] = square_subtable_count[square_dim]-1
	if square_subtable_count[square_dim] ~= 0 then return end
	square_subtable_count[square_dim] = nil
	square_population[dim] = nil
	square_subtable_count[square_population] = square_subtable_count[square_population]-1
	if square_subtable_count[square_population] ~= 0 then return end
	square_subtable_count[square_population] = nil
	square_population = nil
end

function getPopulationSquare(x,y,dim)
	if not square_population then return end
	local square_dim = square_population[dim]
	if not square_dim then return end
	local square_row = square_dim[y]
	if not square_row then return end
	return square_row[x]
end

function generateTraffic()
	if not square_population then return end
	
	for dim,square_dim in pairs(square_population) do
		for y,square_row in pairs(square_dim) do
			for x,square in pairs(square_row) do
				local genmode = square.gen_mode
				if genmode == "spawn" then
				--if #population.peds > 3 and genmode == "spawn" then outputDebugString("POPULATION REACHED!") return end
					spawnTrafficInSquare(x,y,dim,"peds")
					spawnTrafficInSquare(x,y,dim,"cars")
					spawnTrafficInSquare(x,y,dim,"boats")
					spawnTrafficInSquare(x,y,dim,"planes")
				elseif genmode == "despawn" then
					despawnTrafficInSquare(x,y,dim,"peds")
					despawnTrafficInSquare(x,y,dim,"cars")
					despawnTrafficInSquare(x,y,dim,"boats")
					despawnTrafficInSquare(x,y,dim,"planes")
				end
			end
		end
	end
end

vehicles = {589, --reinforced bobcat
478, --Rusty walton
552, -- Flat Van
528 --Rescue 01
}
skins = {108,109, 181, 247, 248, 242, 293 }

skincount,vehiclecount = #skins,#vehicles

function table.random ( theTable ) 
    return theTable[math.random ( #theTable )]
end

local raiderteam = getTeamFromName("Raiders")
local banditteam = getTeamFromName("Bandits")
local estabteam = getTeamFromName("Establishment")
local scavteam = getTeamFromName("Scavengers")
local cdfteam = getTeamFromName("CDF")
local neutteam = getTeamFromName("Raiders")

local raiderr,raiderg,raiderb = getTeamColor(raiderteam)
local banditr,banditg,banditb = getTeamColor(banditteam)
local estabr,estabg,estabb = getTeamColor(estabteam)
local scavr,scavg,scavb = getTeamColor(scavteam)
local cdfr, cdfg, cfgb = getTeamColor(cdfteam)
local neutr, neutg,neutb = getTeamColor(raiderteam)

local raiderMeleeWeapons = {2,4,8,5,10,11,12}--{ 33,25,24,30,27,31}
local raiderGunnerWeapons = {25,30,33,24}--{ 33,25,24,30,27,31}
local banditGunnerWeapons = {25,30,33,27,29}--{ 33,25,24,30,27,31}
local scavGunnerWeapons = {29,30,25}--{ 33,25,24,30,27,31}
local cdfGunnerWeapons = {30,31,29}--{ 33,25,24,30,27,31}
local estabGunnerWeapons = {27,31}--{ 33,25,24,30,27,31}

raiderSkin = {108,109, 181, 247, 248, 242, 293 }
banditSkin = {28, 30,47,104,144,301,241,177,184,102,18,223}
cdfSkin = {73,16,176,179,2,21,278}
specSkin = {285}
armySkin = {287}

function isPedDrivingVehicle(ped)
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ isPedDrivingVehicle [ped/player expected, got " .. tostring(ped) .. "]")
    local isDriving = isPedInVehicle(ped) and getVehicleOccupant(getPedOccupiedVehicle(ped)) == ped
    return isDriving, isDriving and getPedOccupiedVehicle(ped) or nil
end

function deployR01 (vehicle)

--iprint(vehicle)

	if vehicle and not getElementData(vehicle,"deployedalready") then
		outputDebugString("creating specs!")
		local x,y,z = getElementPosition(vehicle)
		local r = getElementRotation(vehicle)
		local R01 = exports["dystopia_slothbot"]:spawnBot (x+math.random(-0.5,0.5),y+math.random(-0.5,0.5),z+1.3,r+180, 285, int, int, estabteam, table.random(estabGunnerWeapons),"hunting", nil)
		--attachElements ( R01, vehicle, 0,y-3,0)
		--detachElements(R01,vehicle)
		setPedAnimation(R01,"ped",table.random({"crouch_roll_l","crouch_roll_r"}),1000,true,true,false,false )
		--setPedAnimation(R01,"dodge",table.random({"cover_dive_01","cover_dive_01"}),-1,false,true,false,false  )
		--setPedAnimation(R01,"dam_jump","sf_jumpwall",1000,true,true,false,false  )
		setElementData(R01, "name", "R01 Spec")
		setElementData(R01, "spec", true)
		--setElementData(R01, "BotTeam", estabteam)
		--setElementDimension(R01,dim)
		element_timers[R01] = {}
		addEventHandler("onElementDestroy",R01,removePedFromListOnDestroy,false)
		addEventHandler("onPedWasted",R01,removeDeadPed,false)
		population.peds[R01] = true
	end
	
	if getElementData(vehicle,"deployedalready") then outputDebugString("deployed already!") end

end

function deployArmy (vehicle)

--iprint(vehicle)

	if vehicle and not getElementData(vehicle,"deployedalready") then
		outputDebugString("creating grunts!")
		local x,y,z = getElementPosition(vehicle)
		local r = getElementRotation(vehicle)
		local grunt = exports["dystopia_slothbot"]:spawnBot (x+math.random(-2,2),y+math.random(-4,-1),z+1.3,r+180, 287, int, int, estabteam, 31,"hunting", nil)
		--attachElements ( R01, vehicle, 0,y-3,0)
		--detachElements(R01,vehicle)
		setPedAnimation(grunt,"ped",table.random({"crouch_roll_l","crouch_roll_r"}),1000,true,true,false,false )
		--setPedAnimation(R01,"dodge",table.random({"cover_dive_01","cover_dive_01"}),1000,true,true,false,false  )
		--setPedAnimation(R01,"dam_jump","sf_jumpwall",1000,true,true,false,false  )
		setElementData(grunt, "name", "Grunt")
		setElementData(grunt, "grunt", true)
		setElementData(R01, "BotTeam", estabteam)
		--setElementDimension(R01,dim)
		element_timers[grunt] = {}
		addEventHandler("onElementDestroy",grunt,removePedFromListOnDestroy,false)
		addEventHandler("onPedWasted",grunt,removeDeadPed,false)
		population.peds[grunt] = true
	end
	
	if getElementData(vehicle,"deployedalready") then outputDebugString("deployed already!") end

end

PANIC_DIST = 100
PANIC_TIME = 60
PANIC_SPEED = 100
STOP_VEH = 0
--deployment_spacer = false

deployedalready_vehicles = {}

addEventHandler ( "onPlayerWeaponFire", root, function()
	local px, py, pz = getElementPosition ( source )
	--create col
	local colshape = createColSphere(px, py, pz,PANIC_DIST)
	--grab elems in colshape
	local pedtab = getElementsWithinColShape(colshape,"ped")
	--destroy col
	destroyElement(colshape)

	if #pedtab == 0 then return end

	for i, ped in ipairs ( pedtab ) do

			--local x, y, z = getElementPosition ( ped )
			--if ( getDistanceBetweenPoints3D ( x, y, z, px, py, pz ) <= PANIC_DIST ) then

		if isPedDrivingVehicle(ped) then
			
			local vehicle = getPedOccupiedVehicle(ped)

					if vehicle then
					
					

						local setup = getElementData(vehicle,"setup")
						
						--outputDebugString("SETUP: "..setup)
						iprint("VEHICLE SPAWNED")
						if setup == "R01 Van" then
						local vehicle = getPedOccupiedVehicle(ped)
							
							call(npc_hlc,"setNPCDriveSpeed",ped,STOP_VEH) -- stop vehicle
														
							if not deployedalready_vehicles[vehicle] then
								outputDebugString("TRAFFIC: deploying R01!")
								setTimer ( function () deployR01(vehicle) end, 1000, 1)
								setTimer ( function () deployR01(vehicle) end, 2000, 1)
								deployedalready_vehicles[vehicle] = true
							end
							setTimer ( function () setElementData(vehicle,"deployedalready",true) end, 3000, 1)
							setTimer ( function() call(npc_hlc,"setNPCDriveSpeed",ped,50) end, PANIC_TIME, 1) --restart vehicle
						
						elseif setup == "Raider Scout" or setup == "Bandit Scout" then
							call(npc_hlc,"setNPCDriveSpeed",ped,0)
							outputDebugString("TRAFFIC: Scout deployed!")
							
							local shooterB = (getAttachedElements(vehicle))[1]--getElementData(vehicle,"shooterB")

							if shooterB then
								local timer = getElementData(shooterB, "stucktimer")
								if timer then killTimer(timer) end
								detachElements(shooterB,vehicle)
								setPedAnimation(shooterB,"ped",table.random({"crouch_roll_l","crouch_roll_r"}),1000,true,true,false,false )
								setElementData(shooterB, "status", "hunting",true)
								setElementData(shooterB, "target", nil,true)
							end

							setTimer ( function() call(npc_hlc,"setNPCDriveSpeed",ped,50) end, PANIC_TIME, 1)
							
						elseif setup == "Army Barraks" then
						local vehicle = getPedOccupiedVehicle(ped)
							
							call(npc_hlc,"setNPCDriveSpeed",ped,STOP_VEH) -- stop vehicle
														
							if not deployedalready_vehicles[vehicle] then
								outputDebugString("TRAFFIC: deploying R01!")
								setTimer ( function () deployArmy(vehicle) end, 1000, 1)
								setTimer ( function () deployArmy(vehicle) end, 1000, 1)
								setTimer ( function () deployArmy(vehicle) end, 2000, 1)
								setTimer ( function () deployArmy(vehicle) end, 2000, 1)
								deployedalready_vehicles[vehicle] = true
							end
							setTimer ( function () setElementData(vehicle,"deployedalready",true) end, 3000, 1)
							setTimer ( function() call(npc_hlc,"setNPCDriveSpeed",ped,50) end, PANIC_TIME, 1) --restart vehicle

						else
							call(npc_hlc,"setNPCDriveSpeed",ped,PANIC_SPEED)
							outputDebugString("TRAFFIC: Driver reacts to gunshots!")
							setTimer ( function() call(npc_hlc,"setNPCDriveSpeed",ped,50) end, PANIC_TIME, 1)
						end

					end
		end
	end
end )

Bone_County_vehicle_setups = {"Raider Pickup",
															"Bandit Pickup",
															"Raider Scout",
															"R01 Van",
															"Army Barraks",
															"CDF Pickup",
															"Bandit Scout",
															"Raider Lurker"
}
Los_Santos_vehicle_setups = {"Raider Pickup",
														 "Bandit Pickup",
														 "Raider Scout",
														 "R01 Van",
														 "Army Barraks",
														 "CDF Pickup",
														 "Bandit Scout",
														 "Raider Lurker"
}
Tierra_Robada_vehicle_setups = {"Raider Pickup",
																"Bandit Pickup",
																"Raider Scout",
																"R01 Van",
																"Army Barraks",
																"CDF Pickup",
																"Bandit Scout",
																"Raider Lurker"
}
--[[{
"Raider Pickup",
"Bandit Pickup",
"R01 Van",
"Looter Pickup",
"Raider Scout",
"Wastelander Pickup",
"Army Patriot",
"Army Barraks",
"Army Rancher",
"Bandit Dune",
"Bandit Scout",
"Raider Lurker",
"CDF Pickup",
"Scav Camper",
"Bandit Mesa",
"Raider Burrito"
}]]

--cities list
-- [[{"Tierra Robada","Bone County","Las Venturas","San Fierro","Red County","Whetstone","Flint County","Los Santos"}]]



function setupCar(car,lane,n1,n2,nb,speed)

--local model = getElementModel(car)
local dim = getElementDimension(car)
local x,y,z = getElementPosition(car)
local r = getElementRotation(car)
local zone = getElementZoneName(car,true)
local pedteam
local pedskin
local pedWeapons
local setup
	if zone == "Tierra Robada" then setup = table.random(Tierra_Robada_vehicle_setups) 
	elseif zone == "Bone County" then setup = table.random(Bone_County_vehicle_setups) 
	elseif zone == "Los Santos" then setup = table.random(Los_Santos_vehicle_setups) 
	else setup = "Raider Pickup"
	end
local shooter1x,shooter1y,shooter1z
local shooter2x,shooter2y,shooter2z
local shooterBx,shooterBy,shooterBz
local maxpass = getVehicleMaxPassengers(car)

	if setup == "Raider Pickup" then 
		setElementModel(car,478) --walton
		setVehicleColor(car,230,230,230,raiderr,raiderg,raiderb)
		shooter1x,shooter1y,shooter1z = 0.5, -1, 1.3
		shooter2x,shooter2y,shooter2z = -0.5, -1, 1.3
		pedteam = raiderteam
		pedskin = raiderSkin
		pedWeapons = raiderGunnerWeapons
	elseif setup == "Raider Scout" then 
		setElementModel(car,463) --freeway
		setVehicleColor(car,raiderr,raiderg,raiderb,raiderr,raiderg,raiderb)
		shooterBx, shooterBy, shooterBz = 0, -0.7, 0.3
		pedteam = raiderteam
		pedskin = raiderSkin
		pedWeapons = raiderMeleeWeapons
	elseif setup == "Bandit Scout" then
		setElementModel(car,471) --quad
		setVehicleColor(car,banditr,banditg,banditb,banditr,banditg,banditb)
		shooterBx, shooterBy, shooterBz = 0, -0.7, 0.3
		pedteam = banditteam
		pedskin = banditSkin
		pedWeapons = {25}
	elseif setup == "Raider Lurker" then
		setElementModel(car,545) --hustler
		setVehicleDoorState(car,0,4)
		setVehicleDoorState(car,1,4)
		setVehicleDoorState(car,2,4)
		setVehicleDoorState(car,3,4)
		setVehicleColor(car,raiderr,raiderg,raiderb,raiderr,raiderg,raiderb)
		shooter1x, shooter1y, shooter1z = 0, -1.8, 0.7
		pedteam = raiderteam
		pedskin = raiderSkin
		pedWeapons = raiderGunnerWeapons
	elseif setup == "R01 Van" then 
		setElementModel(car,528) --FBI truck
		setVehicleColor(car,0, 0, 0,0, 0, 0)
		shooter1x,shooter1y,shooter1z = 0, -1, 1.3
		pedteam = estabteam
		pedskin = specSkin
		pedWeapons = estabGunnerWeapons
	elseif setup == "Army Barraks" then --barraks
		setElementModel(car,433)
		setVehicleVariant(car,0,0)
		shooter1x,shooter1y,shooter1z = 1, 0, 2.3
		shooter2x,shooter2y,shooter2z = -1, 0, 2.3
		pedteam = estabteam
		pedskin = armySkin
		pedWeapons = {31}
	elseif setup == "Bandit Pickup" then
		setElementModel(car,589) --reinforced bobcat
		setVehicleColor(car,banditr,banditg,banditb,banditr,banditg,banditb)
		shooter1x,shooter1y,shooter1z = 0, -1, 1
		pedteam = banditteam
		pedskin = banditSkin
		pedWeapons = banditGunnerWeapons
	elseif setup == "CDF Pickup" then --reinforced bobcat
		setElementModel(car,589)
		setVehicleColor(car,230,230,230,cdfr, cdfg, cfgb)
		shooter1x,shooter1y,shooter1z = 0, -1, 1
		pedteam = cdfteam
		pedskin = cdfSkin
		pedWeapons = cdfGunnerWeapons
	else
		setElementModel(car,554)
		setVehicleColor(car,246, 198, 18,246, 198, 18)
		shooter1x,shooter1y,shooter1z = 0, -1.7, 1
		pedteam = scavteam
		pedskin = scavSkin or 0
		pedWeapons = scavGunnerWeapons
	end
	
	setElementData(car,"setup",setup)

		local driver = createPed(table.random(pedskin),x,y,z+1)
			warpPedIntoVehicle(driver,car)
			setElementDimension(driver,dim)
			setElementData(driver, "name", "Driver")
			setElementData(driver, "BotTeam", pedteam)
			element_timers[driver] = {}
			addEventHandler("onElementDestroy",driver,removePedFromListOnDestroy,false)
			addEventHandler("onPedWasted",driver,removeDeadPed,false)
			population.peds[driver] = true
			
			call(npc_hlc,"enableHLCForNPC",driver,"walk",0.99,speed)
			ped_lane[driver] = lane
			initPedRouteData(driver)
			addNodeToPedRoute(driver,n1)
			addNodeToPedRoute(driver,n2,nb)
			for nodenum = 1,4 do addRandomNodeToPedRoute(driver) end
	
	if 	shooter1x then		
					local shooter1 = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(pedskin), int, int, pedteam, table.random(pedWeapons), "guarding", nil)
					attachElements ( shooter1, car, shooter1x,shooter1y,shooter1z)
					setElementData(shooter1, "name", "Gunner")
					--setElementData(shooter1, "raider", true)
					setElementData(shooter1, "BotTeam", pedteam)
					setElementDimension(shooter1,dim)
					element_timers[shooter1] = {}
					addEventHandler("onElementDestroy",shooter1,removePedFromListOnDestroy,false)
					addEventHandler("onPedWasted",shooter1,removeDeadPed,false)
					population.peds[shooter1] = true
					setElementData(car,"shooter1",shooter1)
					
					shooter1x = false
					
					--local allPlayers = getElementsByType("player")

					--for k,v in ipairs(allPlayers) do
					--	triggerClientEvent(v,"pedCrouch",root,shooter1,true) ------zzz
					--end
	end

	if 	shooter2x then
		local shooter2 = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(pedskin), int, int, pedteam, table.random(pedWeapons), "guarding", nil)
		attachElements ( shooter2, car, shooter2x,shooter2y,shooter2z)
		setElementData(shooter2, "name", "Gunner")
		--setElementData(shooter2, "raider", true)
		setElementData(shooter2, "BotTeam", pedteam)
		setElementDimension(shooter2,dim)
		element_timers[shooter2] = {}
		addEventHandler("onElementDestroy",shooter2,removePedFromListOnDestroy,false)
		addEventHandler("onPedWasted",shooter2,removeDeadPed,false)
		population.peds[shooter2] = true
		setElementData(car,"shooter2",shooter2)
		
		shooter2x = false
		--local allPlayers = getElementsByType("player")

		--for k,v in ipairs(allPlayers) do
		--	triggerClientEvent(root,"pedCrouch",root,shooter1,true) ------zzz
		--end
	end

	if 	shooterBx then
		local shooterB = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(pedskin), int, int, pedteam, table.random(pedWeapons), "following", driver)
		--outputDebugString("shooterB created")
		attachElements ( shooterB, car, shooterBx,shooterBy,shooterBz)
		setElementData(shooterB,"name","Hunter")
		--warpPedIntoVehicle(shooterB,car,1)
		local bottimer = setTimer(function ()
			local veh = car
			local rx,ry,rz = getElementRotation(veh,"default")
			setElementRotation(shooterB,0,0,rz,"default",true)
			setPedAnimation(shooterB,"bikev","bikev_passenger",-1,true,true,false,true)
		end,100,0)
		setElementData(shooterB, "BotTeam",pedteam)
		setElementData(shooterB, "stucktimer",bottimer)
		--setElementData(shooterB, "status","paused",true)
		--setElementData(shooterB, "slothbot",false,true)
		setElementDimension(shooterB,dim)
		element_timers[shooterB] = {}
		addEventHandler("onElementDestroy",shooterB,removePedFromListOnDestroy,false)
		addEventHandler("onPedWasted",shooterB,removeDeadPed,false)
		population.peds[shooterB] = true
		setElementData(car,"shooterB",shooterB)
		
		shooterBx = false
		--local allPlayers = getElementsByType("player")

		--for k,v in ipairs(allPlayers) do
		--	triggerClientEvent(root,"pedCrouch",root,shooter1,true) ------zzz
		--end
	end


end

function setMyVehiclesVariant(theUser, command, var1, var2)
    local var1, var2 = tonumber(var1), tonumber(var2) -- If anything was passed make sure its number or nil
    local myVeh = getPedOccupiedVehicle(theUser) -- Get the vehicle that they're in
    if (myVeh and getVehicleController(myVeh) == theUser) then -- Make sure they're in control
        local wasSet = setVehicleVariant(myVeh, var1, var2) -- Set what they wanted
        if (wasSet) then
            outputChatBox("Vehicle variant successfully set!", theUser, 0, 255, 0)
        else
            outputChatBox("Vehicle variant unsuccessfully set.", theUser, 255, 255, 0)
        end
    end
end
addCommandHandler("setvehvar", setMyVehiclesVariant) -- Add the command

count_needed = 0

function spawnTrafficInSquare(x,y,dim,trtype)
	local square_tm_id = square_id[y] and square_id[y][x]
	if not square_tm_id then return end
	local square = square_population and square_population[dim] and square_population[dim][y] and square_population[dim][y][x]
	if not square then return end
	if count_needed > 1 then return end

	local conns = square_conns[square_tm_id][trtype]
	local cpos1 = square_cpos1[square_tm_id][trtype]
	local cpos2 = square_cpos2[square_tm_id][trtype]
	local cdens = square_cdens[square_tm_id][trtype]
	local ttden = square_ttden[square_tm_id][trtype]
	count_needed = count_needed+math.max(ttden*traffic_density[trtype]-square.count[trtype]/25,0)

	while count_needed >= 1 do
		local sqpos = ttden*math.random()
		local connpos
		local connnum = 1
		while true do
			connpos = cdens[connnum]
			if sqpos > connpos then
				sqpos = sqpos-connpos
			else
				connpos = sqpos/connpos
				break
			end
			connnum = connnum+1
		end

		local connid = conns[connnum]
		connpos = cpos1[connnum]*(1-connpos)+cpos2[connnum]*connpos
		local n1,n2,nb = conn_n1[connid],conn_n2[connid],conn_nb[connid]
		local ll,rl = conn_lanes.left[connid],conn_lanes.right[connid]
		local lanecount = ll+rl
		if lanecount == 0 and math.random(2) > 1 or lanecount ~= 0 and math.random(lanecount) > rl then
			n1,n2,ll,rl = n2,n1,rl,ll
			connpos = (nb and math.pi*0.5 or 1)-connpos
		end
		lane = rl == 0 and 0 or math.random(rl)
		local x,y,z
		local x1,y1,z1 = getNodeConnLanePos(n1,connid,lane,false)
		local x2,y2,z2 = getNodeConnLanePos(n2,connid,lane,true)
		local dx,dy,dz = x2-x1,y2-y1,z2-z1
		local rx = math.deg(math.atan2(dz,math.sqrt(dx*dx+dy*dy)))
		local rz
		if nb then
			local bx,by,bz = node_x[nb],node_y[nb],(z1+z2)*0.5
			local x1,y1,z1 = x1-bx,y1-by,z1-bz
			local x2,y2,z2 = x2-bx,y2-by,z2-bz
			local possin,poscos = math.sin(connpos),math.cos(connpos)
			x = bx+possin*x1+poscos*x2
			y = by+possin*y1+poscos*y2
			z = bz+possin*z1+poscos*z2
			local tx = -poscos
			local ty = possin
			tx,ty = x1*tx+x2*ty,y1*tx+y2*ty
			rz = -math.deg(math.atan2(tx,ty))
		else
			x = x1*(1-connpos)+x2*connpos
			y = y1*(1-connpos)+y2*connpos
			z = z1*(1-connpos)+z2*connpos
			rz = -math.deg(math.atan2(dx,dy))
		end

		local speed = conn_maxspeed[connid]/180
		local vmult = speed/math.sqrt(dx*dx+dy*dy+dz*dz)
		local vx,vy,vz = dx*vmult,dy*vmult,dz*vmult

		local model = trtype == "peds" and skins[math.random(skincount)] or vehicles[math.random(vehiclecount)]
		local colx,coly,colz = x,y,z+z_offset[model]

		local create = true
		if colcheck then
			local box = call(server_coldata,"createModelIntersectionBox",model,colx,coly,colz,rz)
			create = not call(server_coldata,"doesModelBoxIntersect",box,dim)
		end

		if create and trtype == "peds" then
			local ped = createPed(x,y,z+1,rz)

			setElementDimension(ped,dim)
			element_timers[ped] = {}
			addEventHandler("onElementDestroy",ped,removePedFromListOnDestroy,false)
			addEventHandler("onPedWasted",ped,removeDeadPed,false)
			population.peds[ped] = true

			if colcheck then call(server_coldata,"updateElementColData",ped) end

			call(npc_hlc,"enableHLCForNPC",ped,"walk",0.99,40/180)
			ped_lane[ped] = lane
			initPedRouteData(ped)
			addNodeToPedRoute(ped,n1)
			addNodeToPedRoute(ped,n2,nb)
			for nodenum = 1,4 do addRandomNodeToPedRoute(ped) end

		elseif create and trtype == "cars" then
			local zoff = z_offset[model]/math.cos(math.rad(rx))
			local car = createVehicle(model,x,y,z+zoff,rx,0,rz)
			setElementDimension(car,dim)
			setupCar(car,lane,n1,n2,nb,speed)
			element_timers[car] = {}
			addEventHandler("onElementDestroy",car,removeCarFromListOnDestroy,false)
			addEventHandler("onVehicleExplode",car,removeDestroyedCar,false)
			population.cars[car] = true
			
--[[			local topshooter = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(skins), int, int, pedteam, table.random(raiderWeapons), "guarding", nil)
    			attachElements ( topshooter, car, 0, 0.3, 0)
				setElementData(topshooter, "name", "Raider")
				setElementData(topshooter, "type", "civilian")
				setElementData(topshooter, "sex", "male")
				setElementData(topshooter, "raider", true)
				setElementDimension(topshooter,dim)
				element_timers[topshooter] = {}
				addEventHandler("onElementDestroy",topshooter,removePedFromListOnDestroy,false)
				addEventHandler("onPedWasted",topshooter,removeDeadPed,false)
				population.peds[topshooter] = true]]

			if colcheck then call(server_coldata,"updateElementColData",car) end

--[[			local ped1 = createPed(skins[math.random(skincount)],x,y,z+1)
			warpPedIntoVehicle(ped1,car)
			setElementDimension(ped1,dim)
			setElementData(ped1, "name", "")
			--setElementData(ped1, "BotTeam", pedteam)
			element_timers[ped1] = {}
			addEventHandler("onElementDestroy",ped1,removePedFromListOnDestroy,false)
			addEventHandler("onPedWasted",ped1,removeDeadPed,false)
			population.peds[ped1] = true]]

--[[			local maxpass = getVehicleMaxPassengers(model)

			if maxpass >= 1 and math.random() < 0.5 then
			local ped2 = createPed(skins[math.random(skincount)],x,y,z+1)--exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(skins), int, int, pedteam, table.random(raiderWeapons), "guarding", nil)
			--if not ped2 then outputChatBox("no ped2") end
    			attachElements ( ped2, car, 0, -1.5, 0.7)
				setElementData(ped2, "name", "")
				setPedSlothbot(ped2,car)
				setElementAlpha(ped2,0)
				--setElementData(ped2,"slothbot",true)
				--setElementData(ped2,"status","guarding")
				--setElementData(ped2, "type", "civilian")
				--setElementData(ped2, "sex", "male")
				setElementData(ped2, "raider", true)
				setElementData(ped2, "BotTeam", pedteam)
				setElementDimension(ped2,dim)
				element_timers[ped2] = {}
				addEventHandler("onElementDestroy",ped2,removePedFromListOnDestroy,false)
				addEventHandler("onPedWasted",ped2,removeDeadPed,false)
				population.peds[ped2] = true

			end]]

		--[[	if maxpass >= 2 and math.random() < 0.25 then
				local ped3 = createPed(skins[math.random(skincount)],x,y,z+1)
				warpPedIntoVehicle(ped3,car,2)
				setElementDimension(ped3,dim)
				setElementData(ped3, "BotTeam", pedteam)
				element_timers[ped3] = {}
				addEventHandler("onElementDestroy",ped3,removePedFromListOnDestroy,false)
				addEventHandler("onPedWasted",ped3,removeDeadPed,false)
				population.peds[ped3] = true
			end

			if maxpass >= 3 and math.random() < 0.25 then
				local ped4 = createPed(skins[math.random(skincount)],x,y,z+1)
				warpPedIntoVehicle(ped4,car,3)
				setElementDimension(ped4,dim)
				setElementData(ped4, "BotTeam", pedteam)
				element_timers[ped4] = {}
				addEventHandler("onElementDestroy",ped4,removePedFromListOnDestroy,false)
				addEventHandler("onPedWasted",ped4,removeDeadPed,false)
				population.peds[ped4] = true
			end]]

			setElementVelocity(car,vx,vy,vz)

--[[			call(npc_hlc,"enableHLCForNPC",ped1,"walk",0.99,speed)
			ped_lane[ped1] = lane
			initPedRouteData(ped1)
			addNodeToPedRoute(ped1,n1)
			addNodeToPedRoute(ped1,n2,nb)
			for nodenum = 1,4 do addRandomNodeToPedRoute(ped1) end]]
		end

		square.count[trtype] = square.count[trtype]+1

		count_needed = count_needed-1
	end
end

function removePedFromListOnDestroy()
	for timer,exists in pairs(element_timers[source]) do
		killTimer(timer)
	end
	element_timers[source] = nil
	population.peds[source] = nil
end

function removeDeadPed()
	element_timers[source][setTimer(destroyElement,60000,1,source)] = true
	
	removePedFromVehicle(source)
	
end

function removeCarFromListOnDestroy()
	for timer,exists in pairs(element_timers[source]) do
		killTimer(timer)
	end
	element_timers[source] = nil
	population.cars[source] = nil
	deployedalready_vehicles[source] = nil
end

function removeDestroyedCar()
	element_timers[source][setTimer(destroyElement,60000,1,source)] = true
end

function despawnTrafficInSquare(x,y,dim,trtype)
	local square = square_population and square_population[dim] and square_population[dim][y] and square_population[dim][y][x]
	if not square then return end

	if trtype == "peds" then
		for element,exists in pairs(square.list[trtype]) do
			destroyElement(element)
		end
	else
		for element,exists in pairs(square.list[trtype]) do
			local occupants = getVehicleOccupants(element)
			local destroy = true
			for seat,ped in pairs(occupants) do
				if not population.peds[ped] then destroy = false end
			end
			if destroy then
				destroyElement(element)
				for seat,ped in pairs(occupants) do
					destroyElement(ped)
				end
			end
		end
	end
end

