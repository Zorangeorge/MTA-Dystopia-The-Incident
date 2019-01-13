carFuelData = {};
local gasStations = {};
local gasStationsBlip = {};
local gasStationsMarkers = {};

allFuelPointMarkers = createElement("fuelPointGroup","fuelPointGroup-ID")


addEventHandler("onResourceStart", getResourceRootElement(getThisResource()),
    function()--populate car fuel capacity table from the xml
        local xml = xmlLoadFile("config/vehicleFuelData.xml");
        local xmlNodes = xmlNodeGetChildren(xml);
        for i,node in ipairs(xmlNodes) do
           carFuelData[tonumber(xmlNodeGetAttribute(node,'id'))] = tonumber(xmlNodeGetAttribute(node,'fuel'));
        end
        xmlUnloadFile(xml);
		
		local fuelPoints = getElementsByType("Fuel_Source") --create fuel points from the map custom elements
		for i,fuelpoint in ipairs(fuelPoints) do
			local x,y,z = getElementPosition(fuelpoint)
			gasStationsMarkers[i] = createMarker(x,y,z-1,'cylinder', 8, 255, 210, 77, 85);
			setElementData(gasStationsMarkers[i],'gasStation',true);
			setElementParent(gasStationsMarkers[i], allFuelPointMarkers)
		end
		
    end
)

function fuelUse(p)
if not p or not isElement(p) or not (getElementType(p) == "ped" or getElementType(p) == "player") or not getPedOccupiedVehicle(p) then return end
--if p and isElement(p) and (getElementType(p) == "ped" or getElementType(p) == "player") and not getPedOccupiedVehicle(p) then return end
	local vehicle = getPedOccupiedVehicle(p);
	if vehicle then
		setTimer(fuelUse,1000,1,p);
		--if getVehicleType(vehicle) ~= 'Automobile' and getVehicleType(vehicle) ~= 'Bike' and getVehicleType(vehicle) ~= 'Monster Truck' and getVehicleType(vehicle) ~= 'Quad' then return end
		if getVehicleController(vehicle) ~= p then return end --###
		if getVehicleEngineState(vehicle) == false then return end --###
		
		local fuel = getCarFuel(vehicle)
		if fuel == 0 then setVehicleEngineState(vehicle,false); return end --###
		
		--[[local speedX, speedY, speedZ = getElementVelocity(vehicle);
		vel = (speedX^2 + speedY^2 + speedZ^2)^(0.5)+(math.random(100,1000)/25000);]]
		local newX,newY,newZ = getElementPosition(vehicle);
		local oldX = getElementData(vehicle,'oldX') or newX;
		local oldY = getElementData(vehicle,'oldY') or newY;
		local oldZ = getElementData(vehicle,'oldZ') or newZ;
		local vel = (getDistanceBetweenPoints2D(oldX,oldY,newX,newY)/70)+(math.random(100,1000)/50000);
		
		local oldX = setElementData(vehicle,'oldX',newX);
		local oldY = setElementData(vehicle,'oldY',newY);
		local oldZ = setElementData(vehicle,'oldZ',newZ)
		
		--if vel < 0.01 then return end --###
		
		local remainingFuel = takeCarFuel(vehicle,vel);
		if remainingFuel < 0.001 then
			remainingFuel = 0;
			--outputChatBox('Your car has ran out of fuel.',v); -- p?
			outputInteractInfo("[ fuel depleted ]", p, 255,0,0)
			setVehicleEngineState(vehicle,false);
		end
	end
end

function startFuelUse(p,seat,jacked)
	--if getVehicleType(source) ~= 'Automobile' and getVehicleType(source) ~= 'Bike' and getVehicleType(source) ~= 'Monster Truck' and getVehicleType(source) ~= 'Quad' then return end
    if seat ~= 0 then return end
	if getCarFuel(source) and getCarFuel(source) <= 0 then setVehicleEngineState(source,false); end
	setTimer(fuelUse,1000,1,p);
end
addEventHandler("onVehicleEnter",getRootElement(),startFuelUse)

function switchEngine(playerSource)
    local theVehicle = getPedOccupiedVehicle(playerSource);
    if theVehicle and getVehicleController(theVehicle) == playerSource then
        local state = getVehicleEngineState(theVehicle)
		if state then
			setVehicleEngineState(theVehicle, false);
			outputInteractInfo('[ engine stopped ]',playerSource, 240,240,240);
		else
			if getCarFuel(theVehicle) <= 0 then outputInteractInfo('[ no fuel ]',playerSource, 240,240,240); return end
			setVehicleEngineState(theVehicle, true);
			outputInteractInfo('[ engine started ]',playerSource, 240,240,240);
		end
    end
end

function commandSwitchEngine(plSource,commandName)
	if isPlayerInACL(plSource, "Admin") or isPlayerInACL(plSource, "Moderator") then
	switchEngine(plSource)
	end
end
addCommandHandler("engine",commandSwitchEngine);

addEvent('pedSyphonVehicle',true);
function pedSyphon(v)
	if getCarFuel(source) >= carFuelData[-1] then outputInteractInfo("[max capacity]",source, 240,240,240); return end
	local n = math.random(100,200)/1000;
	local left = takeCarFuel(v,n);
	local total = addCarFuel(source,n);
	if left <= 0 then outputInteractInfo("[fuel tank empty]",source, 240,240,240); return end
	triggerClientEvent("onPedSyphonFuel",source);
end
addEventHandler('pedSyphonVehicle',getRootElement(),pedSyphon);

addEvent('pedRefuelVehicle',true);
function pedRefuel(v)
	if getCarFuel(source) <= 0 then outputInteractInfo("[ no fuel left ]",source, 240,240,240); return end
	local maxFuel = carFuelData[0];
	if carFuelData[getElementModel(v)] then
		maxFuel = getFuel[getElementModel(v)];
	end
	if getCarFuel(v) >= maxFuel then
		outputInteractInfo("[ fuel tank full ]", source, 240,240,240) return
	end
	local n = math.random(100,200)/1000;
	local left = takeCarFuel(source,n);
	local total = addCarFuel(v,n);
	triggerClientEvent("onPedReFuel",source);
end
addEventHandler('pedRefuelVehicle',getRootElement(),pedRefuel);

addEvent('onVehicleRefuel',true);

function vehicleRefuel(v,m)
	if not isElement(m) or not getElementData(m,'gasStation') then return end
	if getElementType(v) ~= 'vehicle' then return end
	--if getVehicleType(v) ~= 'Automobile' and getVehicleType(v) ~= 'Bike' and getVehicleType(v) ~= 'Monster Truck' and getVehicleType(v) ~= 'Quad' then return end
	local driver = getVehicleOccupant(v);
	if not driver then return end
	
	if not isElementWithinMarker(v,m) then return end --###
	local maxFuel = carFuelData[0];
	--if getPlayerMoney(driver[0]) < 25 then outputChatBox("You can't afford any more fuel.",p); return end
	if carFuelData[getElementModel(v)] then
		maxFuel = carFuelData[getElementModel(v)];
	end
	if getCarFuel(v) >= maxFuel then return end
	addCarFuel(v,10);
	--takePlayerMoney(driver[0],25);
	if getCarFuel(v) >= maxFuel then outputInteractInfo("[fuel tank full]", driver[0], 240,240,240); takeCarFuel(v,getCarFuel(v)-maxFuel); return end
	setTimer(vehicleRefuel,1000,1,v,m);
end

addEventHandler('onVehicleRefuel',getRootElement(),vehicleRefuel);

function hitTheMarker(e)
	setTimer(vehicleRefuel,1500,1,e,source);
end

addEventHandler('onMarkerHit',allFuelPointMarkers,hitTheMarker);
--addEventHandler('onMarkerHit',getRootElement(),hitTheMarker);

function getCarFuel(v)
	if getElementType(v) == 'vehicle' then
		--if getVehicleType(v) == 'Automobile' or getVehicleType(v) == 'Bike' or getVehicleType(v) == 'Monster Truck' or getVehicleType(v) == 'Quad' then
			local fuel = getElementData(v,'fuel');
			local model = getElementModel(v);
			if not carFuelData[model] then model = 0; end
			if not fuel then
				if carFuelData[model] then
					fuel = carFuelData[model];
					setElementData(v,'fuel',carFuelData[model]);
				else
					fuel = carFuelData[0];
					setElementData(v,'fuel',carFuelData[0]);
				end
			end
			return fuel;
		--end
	elseif getElementType(v) == 'player' then
		local fuel = getElementData(v,'fuel');
		if not fuel then
			setElementData(v,'fuel',0);
			return 0;
		end
		return fuel;
	end
end

function addCarFuel(v,a)
	if getElementType(v) == 'vehicle' then
		--if getVehicleType(v) == 'Automobile' or getVehicleType(v) == 'Bike' or getVehicleType(v) == 'Monster Truck' or getVehicleType(v) == 'Quad' then
			local fuel = getElementData(v,'fuel');
			local model = getElementModel(v);
			if not carFuelData[model] then model = 0; end
			if not fuel then
				if carFuelData[model] then
					fuel = carFuelData[model];
					setElementData(v,'fuel',carFuelData[model]);
				else
					fuel = carFuelData[0];
					setElementData(v,'fuel',carFuelData[0]);
				end
			end
			fuel = fuel + a;
			if fuel > carFuelData[model] then fuel = carFuelData[model]; end
			setElementData(v,'fuel',fuel);
			return fuel;
		--end
	elseif getElementType(v) == 'player' then
		local fuel = getElementData(v,'fuel');
		if not fuel then
			fuel = 0;
		end
		fuel = fuel + a;
		if fuel > carFuelData[-1] then fuel = carFuelData[-1]; end
		setElementData(v,'fuel',fuel);
		return fuel;
	end
end

function takeCarFuel(v,a)
	if getElementType(v) == 'vehicle' then
		--if getVehicleType(v) == 'Automobile' or getVehicleType(v) == 'Bike' or getVehicleType(v) == 'Monster Truck' or getVehicleType(v) == 'Quad' then
			local fuel = getElementData(v,'fuel');
			local model = getElementModel(v);
			if not carFuelData[model] then model = 0; end
				if not fuel then
				if carFuelData[model] then
					fuel = carFuelData[model];
					setElementData(v,'fuel',carFuelData[model]);
				else
					fuel = carFuelData[0];
					setElementData(v,'fuel',carFuelData[0]);
				end
			end
			fuel = fuel - a;
			if fuel < 0 then fuel = 0; end
			setElementData(v,'fuel',fuel);
			return fuel;
		--end
	elseif getElementType(v) == 'player' then
		local fuel = getElementData(v,'fuel');
		if not fuel then
			fuel = 0;
		end
		fuel = fuel - a;
		if fuel < 0 then fuel = 0; end
		setElementData(v,'fuel',fuel);
		return fuel;
	end
end

addEvent('giveVehicleFuelOnSpawn',true);
addEventHandler('giveVehicleFuelOnSpawn',getRootElement(),function()
	getCarFuel(source);
end);

function onVehicleRespawn(exploded)
if getElementType(source) ~= 'vehicle' then return end
	local model = getElementModel(source);
	if not carFuelData[model] then model = 0; end
		if not fuel then
		
		if carFuelData[model] then
		
		local randfuel = math.random(0, carFuelData[model])
		
			setElementData(source,'fuel',randfuel);
		else
			setElementData(source,'fuel',math.random(0,carFuelData[0]));
		end
	end
	return;
end
addEventHandler("onVehicleRespawn",getRootElement(),onVehicleRespawn)


addEvent("RemoveAllCarFuel",true)

function takeAllFuelOnExploded(vehicle)

local fuel = getCarFuel(vehicle)
takeCarFuel(vehicle,fuel)

end
addEventHandler("RemoveAllCarFuel",resourceRoot,takeAllFuelOnExploded)

