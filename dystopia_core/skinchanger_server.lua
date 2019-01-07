function setupClothesNodes()

local allObjects = getElementsByType("object")
outputDebugString("loading clothes nodes...")	
	for _,obj in ipairs(allObjects) do 

		if getElementModel(obj) == 2846 or getElementModel(obj) == 2844 or getElementModel(obj) == 2843 or getElementModel(obj) == 2819 or getElementModel(obj) == 2845 then
			createClothesNode(obj)
		end
		
		--[[if getElementModel(obj) == 2846  then
			createClothesNode(obj)
		elseif getElementModel(obj) == 2844 then
			createClothesNode(obj)
		elseif getElementModel(obj) == 2843 then 
			createClothesNode(obj)
		elseif getElementModel(obj) == 2819 then 
			createClothesNode(obj)
		elseif getElementModel(obj) == 2845 then 
			createClothesNode(obj)
		end]]
	end
end	

function createClothesNode (obj)

		local x,y,z = getElementPosition(obj)
		local clothescolshape =  createColSphere(x,y,z,1.3)
		attachElements(clothescolshape,obj,0,0,0.5)
		setElementData(clothescolshape, "clothesnode", true)
		detachElements(clothescolshape,obj)
end

function clothes_interact(hitElement)
	
local elemType = getElementType(hitElement)

	if elemType == "player" and isPedInVehicle(hitElement) then -- don't trigger for players inside vehicles
		return
	end
	
	if elemType == "player" and isElement(source) and getElementData(source,"clothesnode") == true then  -- if a player hits a clothes colshape
		
		setElementData(hitElement,"insideClothesCol", true)
		
		outputInteractInfo("Change character\n[E]", hitElement, 240,240,240)
		bindKey(hitElement,"e","down",changeClothes)
		triggerClientEvent(hitElement,"showHelpMessageEvent",hitElement,clothes_help_messsage)
	else 
		
	return
	
	end	

end
addEventHandler("onColShapeHit", resourceRoot, clothes_interact) 

function clear_clothes_interact(leaveElement)

local elemType = getElementType(leaveElement)
	
	if elemType == "player" and isPedInVehicle(leaveElement) then -- don't trigger for players inside vehicles
		return
	end
	
	if elemType == "player" and getElementData(source,"clothesnode") == true then  -- if a player hits a clothes colshape
		
		setElementData(leaveElement,"insideClothesCol", false)
		unbindKey(leaveElement,"e","down",changeClothes)
	else 
		
	return
	
	end	
end
addEventHandler("onColShapeLeave", resourceRoot, clear_clothes_interact)


busychanging = false

function changeClothes (player)

if busychanging == true then return end

	local skincheck = getElementModel(player)
	if skincheck == 278 then 
		outputInteractInfo("Unequip Camouflage Suit first!",player,255,240,0) 
		return 
	elseif skincheck == 288 then 
		outputInteractInfo("Unequip Hazmat Suit first!",player,255,240,0) 
		return 
	end
	
	busychanging = true
	
local team = getPlayerTeam(player)
local currskin = getElementModel(player)
local skinpool

	if team == Raiders then skinpool = raiderPlayerSkin
	elseif team == Establishment then skinpool = {287,277,266,284,281,282,285}
	elseif team == Scavengers then skinpool = {143,160, 180, 183, 24, 220,272, 25,135, --ScavengerGuardSkins
												183,29, --ScavengerFreelancerSkins
												13,100, --WastelanderFreelancerSkins
												34, 133, 134, 198, 201, 202, 261, --wastelandersSkin
												239,106,161,291 --playerSkin
												}
	elseif team == CDF then skinpool = CDFskins
	elseif team == Bandits then skinpool = banditSkin
	end

setPedAnimation(player,"BOMBER","BOM_Plant")
outputStatusInfo("[ changing clothes ]", player, 255, 255, 255)

setTimer(function()
			setPedAnimation(player); 
			setElementModel(player,table.random(skinpool) )
			local currskin = getElementModel(player)
			local acc = getPlayerAccount(player)
			setAccountData(acc,"currentSkin",currskin)
			busychanging = false
			--setAccountData(acc,"currentSkin",currskin)
			end,1500,1)
		triggerClientEvent(player, "sleep:drawDXProgress", player, 1500,1500)
		setTimer(triggerClientEvent,1500,1,player, "sleep:stopDXProgress", player)	
		
end
	
addEventHandler( "onResourceStart", resourceRoot,setupClothesNodes )
--addCommandHandler("clothesobj",setupClothesNodes)