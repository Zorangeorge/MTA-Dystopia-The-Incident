weapOff = {}
weapOff[422] = {-0.1, -1.9, -0.2, 0, 0, 50} -- bobcat
weapOff[470] = {-0.1, 0.1, 0.8, 0, 0, 50} -- 
weapOff[401] = {-0.1, 0.1, 0.8, 0, 0, 50} --  --bravura
weapOff[554] = {-0.1, 0.1, 0.8, 0, 0, 50} --  
weapOff[605] = {-0.1, 0.1, 0.8, 0, 0, 50} --  
weapOff[478] = {-0.1, 0.1, 0.8, 0, 0, 50} --  
weapOff[600] = {-0.1, 0.1, 0.8, 0, 0, 50} --  
weapOff[589] = {-0.1, -1.9, -0.2, 0, 0, 50} --  --club/reinf bobcat
weapOff[552] = {-0.1, 0.4, 1, 0, 0, 50} -- utility van/flat van 
weapOff[528] = {0, -0.7, 0.6, 0, 0, 50} --  --fbi van
weapOff[490] = {-0.1, 0.1, 0.8, 0, 0, 50} -- 
weapOff[400] = {-0.1, -1.4, 0.8, 0, 0, 50} --  --landstalker/reinforced rancher
weapOff[568] = {0, -0.7, 0.4, 0, 0, 50} --  -- bandito
weapOff[500] = {-0.1, -1, 0.4, 0, 0, 50} --  -- mesa
weapOff[445] = {0, -1.1, 0.6, 0, 0, 50} --  --admiral/reinf clover
--helis
weapOff[563] = {-1.7, 0.2, -1.2, 0, 0, 50} --  --raindance
weapOff[548] = {-0.1, 0.1, 0.8, 0, 0, 50} --  --cargobob
weapOff[417] = {-2.6, 1.5, 0.2, 0, 0, 50} --  --leviathan


 
veh_damage = 50 -- Damage Car
minigun_name = "Minigun" -- The name of the object, which puts the machine gun

addEvent("attachPlayerToMinigun", true)
addEventHandler("attachPlayerToMinigun",getRootElement(),function(veh)
	local mid = getElementModel ( veh )
	if weapOff[mid] then
		local weap = getElementData ( veh, "mountedminigun_vehweapon_miniBaseObj" )
		setPedAnimation ( source, "SILENCED", "SilenceCrouchfire", 1, false, false, false, true )
		attachElements ( source, weap, -0.2, -0.5, 1, 0, 0, 0)
		setElementCollisionsEnabled ( source, false )
		setElementData ( source, "attachedToWeapon_v", veh )
		setElementData ( source, "currentCol", nil )
		setElementData ( source, "attachedToWeapon_w", weap )
		setElementData ( veh, "playerOnWeapon", source )
		toggleControl (source,"fire", false)
		--toggleControl (source,"next_weapon", false)
		--toggleControl (source,"previous_weapon", false)
		toggleControl (source,"enter_exit", false)
	end
end)

addEvent("rotatePlayerWeapon", true)
addEventHandler("rotatePlayerWeapon",getRootElement(),function(rot,rot2_x)
	if getElementData ( source, "attachedToWeapon" ) then
		local veh = getElementData ( source, "attachedToWeapon_v" )
		if isElement ( veh ) and getElementHealth ( veh ) > 0 then
			local weap = getElementData ( veh, "mountedminigun_vehweapon_miniBaseObj" )
			local weap2 = getElementData ( veh, "mountedminigun_vehweapon_miniobj" )
			local mid = getElementModel ( veh )
			if isElement ( weap ) then
				local _, _, veh_rot = getElementRotation (veh)
				setElementAttachedOffsets ( weap, weapOff[mid][1], weapOff[mid][2], weapOff[mid][3], 0, 0, rot-veh_rot+45)
				--outputChatBox ( rot )
				local _,_,_,_,lr,_ = getElementAttachedOffsets ( weap2 )
				if -rot2_x < 5 then
					setElementAttachedOffsets ( weap2, 0, -0.3, 0.9, weapOff[mid][4], -rot2_x+30, weapOff[mid][6])
			--[[
			elseif -rot2_x > 5 then
					setElementAttachedOffsets ( weap2, 0, -0.3, 0.9, weapOff[mid][4], -rot2_x-30, weapOff[mid][6])
					
			]]		
				else
					setElementAttachedOffsets ( weap2, 0, -0.3, 0.9, weapOff[mid][4], lr, weapOff[mid][6])
				end
			end
		else
			setElementData ( source, "attachedToWeapon", false )
		end
	end
end)