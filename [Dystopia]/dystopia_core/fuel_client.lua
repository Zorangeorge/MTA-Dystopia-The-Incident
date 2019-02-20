local carFuel = {};

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
    function()
        local xml = xmlLoadFile("config/vehicleFuelData.xml");
        local xmlNodes = xmlNodeGetChildren(xml);
        for i,node in ipairs(xmlNodes) do
           carFuel[tonumber(xmlNodeGetAttribute(node,'id'))] = tonumber(xmlNodeGetAttribute(node,'fuel'));
        end
        xmlUnloadFile(xml);
    end
)

addEvent("onPedSyphonFuel",true);
function startSyphon()
	if not isPedInVehicle(localPlayer) then
		if isPedOnGround(localPlayer) then
			local px, py, pz = getElementPosition(localPlayer);
			local rot = getPedRotation(localPlayer);
			 
			local a = math.rad(90 - rot);
		 
			local dx = math.cos(a) * 1.5;
			local dy = math.sin(a) * 1.5;
			local ppx = math.cos(a) * 0.2;
			local ppy = math.sin(a) * 0.2;
		 
			local ex = px-dx;
			local ey = py+dy;
			px = px-ppx;
			py = py+ppy;
			hit, x, y, z, elementHit = processLineOfSight(px, py, pz+1, ex, ey, pz);
			if elementHit then
				if getElementType(elementHit) == 'vehicle' then
					triggerServerEvent('pedSyphonVehicle',localPlayer,elementHit);
				end
			end
		end
	end
end
addEventHandler("onPedSyphonFuel",getRootElement(),startSyphon);
--addCommandHandler('syphon',startSyphon)

addEvent("onPedReFuel",true);
function fillHerUp()
	local vehicle = getPedOccupiedVehicle(localPlayer);
	if not isPedInVehicle(localPlayer) then
		if isPedOnGround(localPlayer) then
			local px, py, pz = getElementPosition(localPlayer);
			local rot = getPedRotation(localPlayer);
			 
			local a = math.rad(90 - rot);
		 
			local dx = math.cos(a) * 1.5;
			local dy = math.sin(a) * 1.5;
			local ppx = math.cos(a) * 0.2;
			local ppy = math.sin(a) * 0.2;
		 
			local ex = px-dx;
			local ey = py+dy;
			px = px-ppx;
			py = py+ppy;
			hit, x, y, z, elementHit = processLineOfSight(px, py, pz+1, ex, ey, pz);
			if elementHit then
				if getElementType(elementHit) == 'vehicle' then
					triggerServerEvent('pedRefuelVehicle',localPlayer,elementHit);
				end
			end
		end
	end
end

addEventHandler("onPedReFuel",getRootElement(),fillHerUp);

--addCommandHandler('refuel',fillHerUp)

function drawGUI()
	local vehicle = getPedOccupiedVehicle(localPlayer);
	if vehicle and getVehicleType(vehicle) ~= "BMX" then
		local x,y = guiGetScreenSize();
		--if getVehicleType(vehicle) ~= 'Automobile' and getVehicleType(vehicle) ~= 'Bike' and getVehicleType(vehicle) ~= 'Monster Truck' and getVehicleType(vehicle) ~= 'Quad' then return end
		local driver = getVehicleController(vehicle);
		if driver ~= localPlayer then return end 
		if getVehicleEngineState(vehicle) == false then return end 
		local maxFuel = carFuel[0];
		local curFuel = getElementData(vehicle,'fuel');
		local carHealth = getElementHealth(vehicle)/10;
		if curFuel == false then return end
		if carFuel[getElementModel(vehicle)] then maxFuel = carFuel[getElementModel(vehicle)]; end
		local fuel = (curFuel/maxFuel)*100;
		local colour = nil;
		if fuel > 90 then
			colour = 0xF5763100;
			dxDrawRectangle(x-30,(y/2)-71,16,21,colour);
		end
		if fuel > 75 then
			if colour == nil then
				colour = 0xF5763100;
			end
			dxDrawRectangle(x-30,(y/2)-48,16,21,colour);
		end
		if fuel > 60 then
			if colour == nil then
				colour = 0xF5763100;
			end
			dxDrawRectangle(x-30,(y/2)-25,16,21,colour);
		end
		if fuel > 45 then
			if colour == nil then
				colour = 0xF5763100;
			end
			dxDrawRectangle(x-30,(y/2)-2,16,21,colour);
		end
		if fuel > 30 then
			if colour == nil then
				colour = 0xF5763100;
			end
			dxDrawRectangle(x-30,(y/2)+21,16,21,colour);
		end
		if colour == nil then
			if fuel > 15 then
				colour = 0xF5763100;
			else
				colour = 0xF5763100;
			end
		end
			dxDrawRectangle(x-30,(y/2)+44,16,21,colour);
	end
end
addEventHandler("onClientRender",getRootElement(),drawGUI);


addEventHandler("onClientElementStreamIn",getRootElement(),function ()
	if getElementType(source) ~= 'vehicle' then return end
	--if getVehicleType(source) ~= 'Automobile' and getVehicleType(source) ~= 'Bike' and getVehicleType(source) ~= 'Monster Truck' and getVehicleType(source) ~= 'Quad' then return end
	triggerServerEvent('giveVehicleFuelOnSpawn',source);
end);