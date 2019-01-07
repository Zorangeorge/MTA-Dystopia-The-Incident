--made by Wojak aka Wojak[PL] aka [2RT]Wojak[PL]
--if you want to copy some parts of this code and use it, make sure to mention me in the credits
----------------------------------------------------------------------------
--settings:
--local command = "rearview" -- put your new command in the quotation marks
--local control_or_key = "aim_weapon" --consult the wiki for valid names of keys and controls
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--note: even one typo will cause the script not to work, if you don't know what you are doing, don't do it!
local disallowed_veh = {
592, 553, 577, 488, 511, 497, 548, 563, 512, 476, 593, 447, 425, 519, 520, 460,417, 469, 487, 513
}

local is_disallowed = {}
for i,id in pairs(disallowed_veh) do
	is_disallowed[id] = true
end

local v,h = guiGetScreenSize()
--outputDebugString(v.."     "..h)
local localpla = getLocalPlayer()
local i = true
local state = false
local model

local shooting_veh_minigun = false

--[[function shooting_veh_minigungle()

	local veh = getPedOccupiedVehicle(localpla)
	local isveh = isElement(veh)
	
	if isveh then
		model = getElementModel(veh)
	end
	
	if not shooting_veh_minigun and isElement(veh) and not is_disallowed[model] then
		
		addEventHandler( "onClientRender", root, showcrosshair)
		setCameraMatrixOnMyVeh(veh)
		local camera = getCamera()
		attachElements(camera,localPlayer,0,-4,2)
		shooting_veh_minigun = true
		
	elseif shooting_veh_minigun then
		removeEventHandler( "onClientRender", root, showcrosshair)
		shooting_veh_minigun = false
		setCameraTarget(localpla)
		
	elseif not shooting_veh_minigun and isElement(veh) and not is_disallowed[model] then
		outputChatBox("Vehicle weap error")
		
	end
	
 end]]
 
function enableVehMinigunViewpoint ()
	
	local veh = getPedOccupiedVehicle(localpla)
	local isveh = isElement(veh)
	
	if isveh then
		model = getElementModel(veh)
	end
	
	if not shooting_veh_minigun and isElement(veh) and not is_disallowed[model] then
		
		addEventHandler( "onClientRender", root, showcrosshair)
		setCameraMatrixOnMyVeh(veh)
		local camera = getCamera()
		attachElements(camera,localPlayer,0,-4,2)
		shooting_veh_minigun = true
	end
	
end

function disableableVehMinigunViewpoint ()
	
	local veh = getPedOccupiedVehicle(localpla)
	local isveh = isElement(veh)
	
	if isveh then
		model = getElementModel(veh)
	end
	
	if	shooting_veh_minigun then
		removeEventHandler( "onClientRender", root, showcrosshair)
		shooting_veh_minigun = false
		setCameraTarget(localpla)
	end
	
end
 
 
 --addCommandHandler(command,shooting_veh_minigungle)
 --bindKey(control_or_key,"down",shooting_veh_minigungle)
 --bindKey ( "mouse2", "down", shooting_veh_minigungle )
 
function showcrosshair ()
	local x,y = guiGetScreenSize()
	local img = dxDrawImage( x/2-16-16,y/2+16+10,37,37*3,"images/vehicle_crosshair.png" ) --CAR
	--local img = dxDrawImage( x/2-10,y/2+32,37,37*3,"latest.png" ) --BIKE
end
 
function setCameraMatrixOnMyVeh (veh)
	local matrix = getElementMatrix(veh)
	local offX1 = 0 * matrix[1][1] + 0 * matrix[2][1] + 2 * matrix[3][1] + 1 * matrix[4][1]
	local offY1 = 0 * matrix[1][2] + 0 * matrix[2][2] + 2 * matrix[3][2] + 1 * matrix[4][2]
	local offZ1 = 0 * matrix[1][3] + 0 * matrix[2][3] + 2 * matrix[3][3] + 1 * matrix[4][3]
	local offX = 0 * matrix[1][1] - 3 * matrix[2][1] + 2 * matrix[3][1] + 1 * matrix[4][1]
	local offY = 0 * matrix[1][2] - 3 * matrix[2][2] + 2 * matrix[3][2] + 1 * matrix[4][2]
	local offZ = 0 * matrix[1][3] - 3 * matrix[2][3] + 2 * matrix[3][3] + 1 * matrix[4][3]
	setCameraMatrix(offX,offY,offZ,offX1,offY1,offZ1,0,100)
end

addEvent("cancelVehicleWeaponCamera",true)



function cancelVehWeaponCamera()
	
	if shooting_veh_minigun then
	disableableVehMinigunViewpoint()
	end
end
addEventHandler("cancelVehicleWeaponCamera",root,cancelVehWeaponCamera)