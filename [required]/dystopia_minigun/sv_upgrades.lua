local cardamage = 10 -- Damage car with a single shot

addEvent("sv_bulletSpawn", true)
addEventHandler("sv_bulletSpawn",getRootElement(),function(veh, weapon,player)
	triggerClientEvent("cl_bulletSpawn", getRootElement(), veh, weapon,player)
end)
--addEvent("onPlayerWasted", true)
addEventHandler("onPlayerWasted",getRootElement(),function()
	setElementData (source, "attachedToWeapon", false)
end)
addEventHandler ( "onVehicleExplode", getRootElement(), function()
	local wep = getElementData(source, "mountedminigun_vehweapon_miniBaseObj")
	local wep2 = getElementData(source, "mountedminigun_vehweapon_miniobj")
	local owner = getElementData(source, "playerOnWeapon")
	if wep or wep2 then
		destroyElement(wep)
		destroyElement(wep2)
		setElementData(source, "mountedminigun_vehweapon_miniBaseObj", false)
    	setElementData(source, "mountedminigun_vehweapon_miniobj", false)
	end
	if owner then 
	    setElementHealth(owner,getElementHealth(owner)-math.random(25,50))
	end
end)

addEvent("detachPlayerFromMinigun", true)
addEventHandler("detachPlayerFromMinigun",getRootElement(),function(veh)
		local weap = getElementData ( veh, "mountedminigun_vehweapon_miniBaseObj" )
        local attachedto = getElementData(source,"attachedToWeapon_w")
		local x,y,z = getElementPosition(veh)
		setPedAnimation ( source, "ped","SEAT_UP", false )
		setTimer(setPedAnimation, 1300,1,source,false)
		detachElements(source,attachedto)
		setElementCollisionsEnabled ( source, true )
		setElementData ( source, "attachedToWeapon_v", nil )
		setElementData ( source, "currentCol", nil )
		setElementData ( source, "attachedToWeapon_w", nil )
		setElementData ( source,"attachedToWeapon",false)
		setElementData ( veh, "playerOnWeapon", nil )
		toggleControl (source,"fire", true)
		--toggleControl (source,"next_weapon", true)
		--toggleControl (source,"previous_weapon", true)
		toggleControl (source,"enter_exit", true)
end)

addEvent("causeVehicleDamageFromMG", true)
addEventHandler("causeVehicleDamageFromMG", getRootElement(), function(veh)
    local currenthealth = getElementHealth(veh)
	setElementHealth(veh,currenthealth-cardamage)
end)


addEvent("sv_createWeapon", true)
addEventHandler("sv_createWeapon", getRootElement(), function(item, veh, player)
    if veh then
	--local veh = loot--getElementData(loot,"parent")
	local x,y,z = getElementPosition(veh)
	local mid = getElementModel(veh)
	if weapOff[mid] and item == minigun_name and not getElementData(veh, "mountedminigun_vehweapon_miniobj") then
		local weapon = createObject ( 362, x+weapOff[mid][1],y+weapOff[mid][2],z+weapOff[mid][3])
		setObjectScale(weapon,2.2)
		local weapon_base = createObject ( 2351, x+weapOff[mid][1],y+weapOff[mid][2],z-0.7)
		
		setElementCollisionsEnabled(weapon,false)
		setElementCollisionsEnabled(weapon_base,false)
		--setElementAlpha(weapon_base,0)
		setObjectScale(weapon_base,1)
		attachElements ( weapon_base, veh, weapOff[mid][1], weapOff[mid][2], weapOff[mid][3]+0.1, 0,0,0)
		attachElements ( weapon, weapon_base, -0.3, -0.5, 0.3, weapOff[mid][4], weapOff[mid][5], weapOff[mid][6])
		setElementData(veh, "mountedminigun_vehweapon_miniBaseObj", weapon_base)
		setElementData(veh, "mountedminigun_vehweapon_miniobj", weapon)
		setElementData(weapon_base, "mountedminigun_vehweapon_ammo", 0,true)
	end
	end
	--triggerClientEvent("cl_waitForKey", getRootElement(), veh, weapon, player)
end)
addEvent("sv_destroyWeapon", true)
addEventHandler("sv_destroyWeapon", getRootElement(), function(item, loot, player)
	local veh = getElementData(loot,"parent")
	if isElement(veh) and not getElementData(veh,"vehicle") then return end
	if (getElementData(loot, minigun_name)or 0) <= 0 then
	    if getElementData(veh,"vehicle") then
		destroyElement(getElementData(veh, "mountedminigun_vehweapon_miniobj"))
		destroyElement(getElementData(veh, "mountedminigun_vehweapon_miniBaseObj"))
		setElementData(veh, "mountedminigun_vehweapon_miniBaseObj", false)
    	setElementData(veh, "mountedminigun_vehweapon_miniobj", false)
		end
	end
end)


addEvent("CheckPedSyncer",true)

function check_PedSyncer(player)

	if not getElementSyncer(source) or getElementSyncer(source) ~= player then
		setElementSyncer(source,player)
	end
	
end

addEventHandler("CheckPedSyncer",root,check_PedSyncer)