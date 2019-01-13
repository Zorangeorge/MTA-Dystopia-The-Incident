weap_attachment_valid = {}
weap_attachment_valid[434] = true
weap_attachment_valid[603] = true			
weap_attachment_valid[475] = true				
weap_attachment_valid[402] = true
weap_attachment_valid[542] = true
weap_attachment_valid[549] = true
weap_attachment_valid[576] = true
weap_attachment_valid[412] = true
weap_attachment_valid[558] = true
weap_attachment_valid[541] = true
weap_attachment_valid[445] = true
weap_attachment_valid[527] = true
weap_attachment_valid[602] = true
weap_attachment_valid[424] = true
weap_attachment_valid[568] = true
weap_attachment_valid[536] = true
weap_attachment_valid[496] = true
weap_attachment_valid[518] = true
weap_attachment_valid[504] = true
weap_attachment_valid[401] = true
weap_attachment_valid[575] = true
weap_attachment_valid[400] = true
weap_attachment_valid[534] = true
weap_attachment_valid[559] = true
weap_attachment_valid[600] = true
weap_attachment_valid[466] = true

weap_attachment_offsets = {}
weap_attachment_offsets[434] = {-1.2,-0.6,0.2}--interceptor (hotknife) 
weap_attachment_offsets[603] = {-1.3,-0.6,0.4}--phoenix					
weap_attachment_offsets[475] = {-1.2,-0.6,0.4}--SABRE					
weap_attachment_offsets[402] = {-1.4,-0.7,0.2}--bonemaster (buffalo)
weap_attachment_offsets[542] = {-1.2,-0.5,0.5}--clover
weap_attachment_offsets[549] = {-1.2,-0.5,0.5}--TAMPA
weap_attachment_offsets[576] = {-1.2,-0.5,0.5}--tornado
weap_attachment_offsets[412] = {-1.2,-0.5,0.5}--voodoo
weap_attachment_offsets[558] = {-1.2,-0.5,0.5}--URANUS
weap_attachment_offsets[541] = {-1.3,-0.5,0.5}--URANUS RAM
weap_attachment_offsets[445] = {-1.2,-0.5,0.5} --reinf clover (admiral)
weap_attachment_offsets[527] = {-1.3,-0.5,0.5} --reinf regina(cadrona)
weap_attachment_offsets[602] = {-1.2,-0.5,0.5} --alpha
weap_attachment_offsets[424] = {-1.2,-0.5,0.5} --bf inj
weap_attachment_offsets[568] = {-0.8,-0.5,0.4} --bandito
weap_attachment_offsets[536] = {-1.2,-0.7,0.2} --blade
weap_attachment_offsets[496] = {-1.2,-0.7,0.5} --reinf bucaneer/blista
weap_attachment_offsets[518] = {-1.2,-0.7,0.5} --bucaneer
weap_attachment_offsets[466] = {-1.2,-0.7,0.5} --glendale
weap_attachment_offsets[504] = {-1.2,-0.7,0.5} --banger
weap_attachment_offsets[401] = {-1.2,-0.7,0.5} --reinf picador/bravura
weap_attachment_offsets[600] = {-1.2,-0.7,0.5} -- picador
weap_attachment_offsets[575] = {-1.3,-0.7,0.8} --reinf stafford/broadway
weap_attachment_offsets[400] = {-1.5,-0.5,0.4} --reinf rancher/landstalker
weap_attachment_offsets[534] = {-1.4,-0.7,0.4} --remington

function attachMinigun(playSrc,cmd,vehicle)
	if not vehicle then vehicle = getPedOccupiedVehicle(playSrc) end
	local vehiclemodel = getElementModel(vehicle)
		--iprint("veh model: "..vehiclemodel)
	if weap_attachment_valid[vehiclemodel]== true then
	local gun = createObject(362,0,0,0)
	attachElements(gun, vehicle, weap_attachment_offsets[vehiclemodel][1],weap_attachment_offsets[vehiclemodel][2],weap_attachment_offsets[vehiclemodel][3],-90,-55,0)
	setObjectScale(gun,1.8)
	setElementCollisionsEnabled(gun, false)
	setElementData(vehicle,"driverminigun_vehweapon",gun,true)
	setElementData(vehicle,"driverminigun_vehweapon_ammo",1000,true)
	--iprint("driver minigun: yes")
	addVehicleUpgrade(vehicle,1087) --hydraulics
	addVehicleUpgrade(vehicle,1025) --offroad wheels
	setVehicleColor(vehicle,10,10,10,204, 51, 0,204, 51, 0)
	else
	--iprint("driver minigun: no")
	end
end
addCommandHandler("createweaponveh",attachMinigun)

addEvent("WeaponizeVehicle",true)

function weaponizeVehicle(vehicle)
	if not vehicle then vehicle = getPedOccupiedVehicle(source) end
	local vehiclemodel = getElementModel(vehicle)
		--iprint("veh model: "..vehiclemodel)
	if weap_attachment_valid[vehiclemodel]== true then
		local gun = createObject(362,0,0,0)
		attachElements(gun, vehicle, weap_attachment_offsets[vehiclemodel][1],weap_attachment_offsets[vehiclemodel][2],weap_attachment_offsets[vehiclemodel][3],-90,-55,0)
		setObjectScale(gun,1.8)
		setElementCollisionsEnabled(gun, false)
		setElementData(vehicle,"driverminigun_vehweapon",gun,true)
		setElementData(vehicle,"driverminigun_vehweapon_ammo",1000,true)
		setElementData(vehicle,"smokeinstalled",true,true)
		--iprint("driver minigun: yes")
		--addVehicleUpgrade(vehicle,1087) --hydraulics
		--addVehicleUpgrade(vehicle,1025) --offroad wheels
		setVehicleColor(vehicle,10,10,10,204, 51, 0,204, 51, 0)
		triggerEvent("ManageVehWeapOnVehSpawn",vehicle,source,0)
		outputInteractInfo("[ vehicle upgraded ]",source,240,240,240)
	else
	outputInteractInfo("[ this vehicle can't be weaponized ]",source,255,50,0)
	end
end
addEventHandler("WeaponizeVehicle",root,weaponizeVehicle)

--notfirsttime = false
function manageVehWeaponsExit (player,seat,jacker)
	
	if getElementData(source,"driverminigun_vehweapon") and seat == 0 then
		triggerClientEvent(player,"cancelVehicleWeaponCamera",root)
		local vehWeapAmmoLeft = getPedTotalAmmo(player,4)
	--if not notfirsttime then
	setElementData(source,"driverminigun_vehweapon_ammo",vehWeapAmmoLeft,true)
	--notfirsttime = true
	--end
	local currentSlot4Weap = getElementData(player,"slot4_weap_saved")
	local currentSlot4Ammo = getElementData(player,"slot4_ammo_saved")
	setElementData(player,"slot4_weap_saved",nil)
	setElementData(player,"slot4_ammo_saved",nil)
	if getPedWeapon(player,4) == 32 then
		takeWeapon(player,32,vehWeapAmmoLeft) 
		takeweapon = takeWeapon(player,32) 
	end
	
	giveWeapon(player,currentSlot4Weap,currentSlot4Ammo)
	
	--iprint("minigun removed, weap returned")
	end
end


function manageVehWeaponsEnter (player,seat,jacker)
		
		--iprint(source)
		
		local weap = getElementData(source,"driverminigun_vehweapon")
		--iprint("weapon is: "..tostring(weap))
	if weap and seat == 0 then
	
		local vehWeapAmmo = getElementData(source,"driverminigun_vehweapon_ammo")
		--iprint("vehicle ammo is : "..tostring(weap))
		if vehWeapAmmo < 1 then vehWeapAmmo = 1 end
		local currentSlot4Weap = getPedWeapon(player,4)
		--iprint("current ped weapon: "..tostring(currentSlot4Weap)..", saved")
		if currentSlot4Weap~=0 and (currentSlot4Weap == 28 or currentSlot4Weap ==29 ) then
		setElementData(player,"slot4_weap_saved",currentSlot4Weap,true)
		--iprint("weapon saved to player elemdata")
			local currentSlot4Ammo = getPedTotalAmmo(player,4)
			--iprint("current ped ammo: "..tostring(currentSlot4Ammo))
			if currentSlot4Ammo < 1 then currentSlot4Ammo = 1; iprint("ammo adjusted: 1") end
			setElementData(player,"slot4_ammo_saved",currentSlot4Ammo,true)
			--iprint("ammo saved to player elemdata")
			takeWeapon(player,currentSlot4Weap,currentSlot4Ammo)
			--iprint("ped ammo removed")
			takeWeapon(player,currentSlot4Weap)
			--iprint("ped ammo removed")
		end
		giveWeapon(player,32,vehWeapAmmo)
		--iprint("vehicle weapon: "..tostring(32).." and ammo: "..tostring(vehWeapAmmo).." added")
	end 

end

addEventHandler("onVehicleEnter",root,manageVehWeaponsEnter)
addEventHandler("onVehicleExit",root,manageVehWeaponsExit)
addEvent("ManageVehWeapOnVehSpawn",true)
addEventHandler("ManageVehWeapOnVehSpawn",root,manageVehWeaponsEnter)