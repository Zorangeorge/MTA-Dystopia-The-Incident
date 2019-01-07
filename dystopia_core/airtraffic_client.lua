addEvent("openCargoDoor",true)
function openCargoDoorForPlane ()
	if isElement(source) then
	setVehicleAdjustableProperty ( source, 5000 )
	CreatePlaneLoot(source)
	end
	
end
addEventHandler("openCargoDoor",root,openCargoDoorForPlane)

function CreatePlaneLoot (plane) --this really should be done server side, otherwise it will get multiplied with players online (fixed with an elementdata

--if planeAlreadyExploded then return end
if plane and getElementData(plane,"planeLootTriggered") then return end

local px,py,pz = getElementPosition(plane)
local smokeeffect = setTimer(createEffect,10000,12,"riot_smoke",px,py,pz)
--setTimer(destroyElement,120000,1,smokeeffect)

local itemsTable = {{table.random(policeweapons),table.random(militaryloot)},{table.random(policeweapons),table.random(militaryloot)},{table.random(policeweapons),table.random(militaryloot)},{table.random(policeweapons),table.random(militaryloot)},{table.random(policeweapons),table.random(militaryloot)},{table.random(policeweapons),table.random(militaryloot)},{table.random(policeweapons),table.random(militaryloot)},{table.random(policeweapons),table.random(militaryloot)},{table.random(policeweapons),table.random(militaryloot)}}

	local radius = 5
	local numberDropped = 10
	for i, t in ipairs(itemsTable) do
		local pX, pY, pZ = getElementPosition ( plane )
		local x = pX + radius * math.cos((i-1) * 2 * math.pi / numberDropped)
		local y = pY + radius * math.sin((i-1) * 2 * math.pi / numberDropped)
		local z = getGroundPosition(x, y,1000)
		triggerServerEvent("createAircrashLootItem",root, t[1], x, y, z, 97.3,120,0 ) 
			if type(t[2]) == "string" then
			triggerServerEvent("createAircrashLootItem",root,t[2], x+0.3, y+0.3, z, 97.3,120,math.random(0,359) )
			end
			if math.random(1,10) >8 then 
				local fire = createEffect("molotov_fire",x+0.3, y+0.3, z)
			--setTimer(destroyElement,120000,1,fire)
			end			
			if math.random(1,10) >7 then 
				local box = createObject(2977,x+0.3, y+0.3, z-0.2, 0,0,math.random(0,359))
				setTimer(destroyElement,120000,1,box)
			end
	end

	local itemsTable2 = {{table.random(ammunitionweapons),table.random(policeweapons)},{table.random(ammunitionweapons),table.random(policeweapons)},{table.random(ammunitionweapons),table.random(policeweapons)},{table.random(ammunitionweapons),table.random(policeweapons)},{table.random(ammunitionweapons),table.random(policeweapons)},{table.random(ammunitionweapons),table.random(policeweapons)},{table.random(ammunitionweapons),table.random(policeweapons)},{table.random(ammunitionweapons),table.random(policeweapons)},{table.random(ammunitionweapons),table.random(policeweapons)}}
	
	local radius = 6
	local numberDropped = 10
	for i, t in ipairs(itemsTable2) do
		local pX, pY, pZ = getElementPosition ( plane )
		local x = pX + radius * math.cos((i-1) * 2 * math.pi / numberDropped)
		local y = pY + radius * math.sin((i-1) * 2 * math.pi / numberDropped)
		local z = getGroundPosition(x, y,1000)
		triggerServerEvent("createAircrashLootItem",root, t[1], x, y, z, 97.3,120,0 ) 
			if type(t[2]) == "string" then
			triggerServerEvent("createAircrashLootItem",root,t[2], x+0.3, y+0.3, z, 97.3,120,math.random(0,359) )
			end
			if math.random(1,10) >8 then 
				local fire = createEffect("molotov_fire",x+0.3, y+0.3, z)
				--setTimer(destroyElement,120000,1,fire)
			end						
			if math.random(1,10) >7 then 
				local box = createObject(2977,x+0.3, y+0.3, z-0.2, 0,0,math.random(0,359))
				setTimer(destroyElement,120000,1,box)
			end
	end
	
	local itemsTable3 = {{table.random(militaryloot),table.random(ammunitionweapons)},{table.random(militaryloot),table.random(ammunitionweapons)},{table.random(militaryloot),table.random(ammunitionweapons)},{table.random(militaryloot),table.random(ammunitionweapons)},{table.random(militaryloot),table.random(ammunitionweapons)},{table.random(militaryloot),table.random(ammunitionweapons)},{table.random(militaryloot),table.random(ammunitionweapons)},{table.random(militaryloot),table.random(ammunitionweapons)},{table.random(militaryloot),table.random(ammunitionweapons)}}
	
	local radius = 7
	local numberDropped = 10
	for i, t in ipairs(itemsTable3) do
		local pX, pY, pZ = getElementPosition ( plane )
		local x = pX + radius * math.cos((i-1) * 2 * math.pi / numberDropped)
		local y = pY + radius * math.sin((i-1) * 2 * math.pi / numberDropped)
		local z = getGroundPosition(x, y,1000)
		triggerServerEvent("createAircrashLootItem",root, t[1], x, y, z, 97.3,120,0 ) 
			if type(t[2]) == "string" then
			triggerServerEvent("createAircrashLootItem",root,t[2], x+0.3, y+0.3, z, 97.3,120,math.random(0,359) )
			end
			if math.random(1,10) >8 then 
				local fire = createEffect("molotov_fire",x+0.3, y+0.3, z)
				
				--setTimer(destroyElement,120000,1,fire)
			end					
			if math.random(1,10) >7 then 
				local box = createObject(2977,x+0.3, y+0.3, z-0.2, 0,0,math.random(0,359))
				
				setTimer(destroyElement,120000,1,box)
			end
	end
		setElementData(plane,"planeLootTriggered",true,true)
		objtodelete = nil

end

--[[createEffect("riot_smoke",x,y,z)
createEffect("fire",x,y,z)
createEffect("fire_med",x,y,z)
createEffect("fire_large",x,y,z)]]