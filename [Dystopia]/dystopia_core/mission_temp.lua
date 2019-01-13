--Aunt_Mae, camp boss in Palomino CDF 

local Aunt_Mae_mission_status = 0

function Aunt_Mae_Q(ped)
	if Aunt_Mae_mission_status == 0 then
		showQuestWindow ( "Aunt Mae", "I need your help! Cross the Sherman Dam and go near Las Barrancas to search for wild pigs. Kill and butcher them, bring me all the Raw Meat you gather. Today I plan to make a stew for the sick refugees.\n\n[ REQUIRED: Bladed Weapon ]", 
				"Hm, I can do it!", "Start_Aunt_Mae_Q('Go near Las Barrancas and hunt wild pigs to gather raw meat')", 
				"You don't look like you'll pay", " ",
				"0", " ", 		
				"0", " " )
	elseif Aunt_Mae_mission_status == 1 then
		showQuestWindow ( "Aunt Mae", "Have you done what I asked for? The poor people could use a good stew to get back on their feet!", 
				"Here is the meat!", "Aunt_Mae_win_Q()", 
				"Still working on it..", " ",
				"0", " ", 		
				"0", " " )
		elseif Aunt_Mae_mission_status == 2 then
		showQuestWindow ( "Aunt Mae", "I need you to do one more good deed. The Establishment is giving us water, but barely enough for drinking. We don't have enough to wash ourselves, or clothes... Can you drive our water truck to Sherman Reservoir and fill it up?", 
				"Sure, I'm on it!", "Start_Aunt_Mae_Q('Drive the water truck to the Sherman Reservoir and fill it up')", 
				"Nope", " ",
				"0", " ", 		
				"0", " " )
		elseif Aunt_Mae_mission_status == 3 then
		showQuestWindow ( "Aunt Mae", "Have you done what I asked for? We urgently need that water! The hygiene level in the camp dropped drastically.", 
				"Yes, brought it", "Aunt_Mae_win_Q()", 
				"Not yet", " ",
				"0", " ", 		
				"0", " " )
	end
end

function Aunt_Mae_win_Q()

	if Aunt_Mae_mission_status == 1 then
		Aunt_Mae_mission_status = 2
		currentMission = "None"
		triggerEvent("DrawQuestTitle",localPlayer,"+400$","mission completed!","Speak with Mallory to continue")
		triggerServerEvent("GiveReputation",localPlayer,400)
		addPlayerExp(localPlayer,15)
		outputStatusInfo("+15 XP",240,240,240 )
		local karma = getElementData(localPlayer,"karma") or 0
		setElementData(localPlayer,"karma",karma+3,true)
		outputStatusInfo("+2 karma",240,240,240 )
	elseif Aunt_Mae_mission_status == 3 then
		Aunt_Mae_mission_status = 0
		currentMission = "None"
		triggerEvent("DrawQuestTitle",localPlayer,"+500$","mission completed!","To be continued...")
		triggerServerEvent("GiveReputation",localPlayer,500)
		addPlayerExp(localPlayer,15)
		outputStatusInfo("+15 XP",240,240,240 )
		local karma = getElementData(localPlayer,"karma") or 0
		setElementData(localPlayer,"karma",karma+5,true)
		outputStatusInfo("+5 karma",240,240,240 )
	end
	
end

function Start_Aunt_Mae_Q(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start Aunt_Mae")
	end
	
	if newmission == 'Go near Las Barrancas and hunt wild pigs to gather raw meat' then 
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","stew",'Go near Las Barrancas and hunt wild pigs to gather raw meat')
		Aunt_MaeAntennaCol = createColSphere(2084.228515625, -428.259765625, 114.14374542236,1)
		curr_mission_col = Aunt_MaeAntennaCol
		Aunt_MaeAntennaMarker = createMarker(2084.228515625, -428.259765625, 113.14374542236,"cylinder",1.5,100,100,100,150)
		addEventHandler("onClientColShapeHit", Aunt_MaeAntennaCol, Aunt_MaeAntennaMissionCheck)
		Aunt_MaeAntennaBlip = createBlip ( 2084.228515625, -428.259765625, 113.14374542236, 53, 2, 255, 255, 255, 255, 1, 500)
		curr_mission_item_obj = createObject(1624,2084.0810546875, -427.421875, 113.18435668945)
		--setObjectScale(curr_mission_item_obj,1.5)
		setElementRotation(curr_mission_item_obj,0,0,90)
		setElementDoubleSided(curr_mission_item_obj,true)
		setElementCollisionsEnabled(curr_mission_item_obj,false)
		curr_mission_blip = Aunt_MaeAntennaBlip
		curr_mission_marker = Aunt_MaeAntennaMarker
		setElementData(Aunt_MaeAntennaBlip, "blip.visibleOnScreen", true)
		
	elseif newmission == 'Drive the water truck to the Sherman Reservoir and fill it up' then
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","water boy","\nGet in the water truck\nand drive to Sherman Reservoir")
		if newmission == currentMission then 
			return 
		else 
			clearMissionData ()
			currentMission = newmission 
			outputDebugString(currentMission)
			outputDebugString("start extraction mission")
		end
	
	if newmission == 'Drive the water truck to the Sherman Reservoir and fill it up' then 
		
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","extraction",'Drive the water truck to the Sherman Reservoir and fill it up')
		local localhandler = RefCampExtractionMissions[themission]
		triggerServerEvent("Dystopia_create_mission_vehicle_for_player",localPlayer,552,199.6103515625, 2031.75390625, 17.333600997925, 270.10989379883,"WATATRK",0,0,0,0,0,0)
		
		local targetblip = createBlip ( -467.671875, 2177.6416015625, 46.872253417969, 14, 2, 255, 255, 255, 255, 1, 500)
		setElementData(targetblip, "blip.visibleOnScreen", true)
		curr_mission_blip = targetblip
		curr_mission_marker = createMarker(-467.671875, 2177.6416015625, 45.872253417969,"cylinder",1.5,100,100,100,150)
		
		local targetCol = createColSphere(-467.671875, 2177.6416015625, 46.872253417969,2)
		curr_mission_col = targetCol
		addEventHandler("onClientColShapeHit", targetCol, Aunt_MaeWaterRefillMissionCheck)
	
	end
		
	end
	
end

function Aunt_MaeWaterRefillMissionCheck(hitElem)

	if hitElem == localPlayer and currentMission == "Investigate suspicious bandit activity around Hanky Panky Point." then
	outputStatusInfo("[ Investigating... ]",240,240,240 )
	removeEventHandler("onClientColShapeHit", Aunt_MaeJournalCol, Aunt_MaeWaterRefillMissionCheck)
	triggerEvent("sleep:drawDXProgress", localPlayer, 1000,1000)
	setTimer(triggerEvent,1000,1,"sleep:stopDXProgress",localPlayer)
	setTimer(destroyElement,1000,1,curr_mission_item_obj)
	setPedAnimation( localPlayer, "BOMBER", "BOM_Plant",1000,true,false,false,false)
	
	setTimer(function() 
		currentMission = "Drive the truck back to the Refugee Camp"
		triggerEvent("DrawQuestTitle",localPlayer,"\n\nYou refilled the truck!\nDrive it back to the Refugee Camp"," "," ","no")
		destroyElement(Aunt_MaeJournalBlip)
		destroyElement(Aunt_MaeJournalCol)
		destroyElement(Aunt_MaeJournalMarker)
		--destroyElement(curr_mission_item_obj)
		Aunt_Mae_mission_status = 3 
		outputInteractInfo("+ [Moe's Journal]",255, 92, 38)
	end,1500,1)
	
	else
	
	outputInteractInfo("[ Wire & Toolbox required ]",255,150,0 )
	
	end
	
end

function Aunt_MaeAntennaMissionCheck(hitElem)

	if hitElem == localPlayer and hasPlayerItem_c ("Wire", localPlayer) and hasPlayerItem_c ("Wire", localPlayer) then
	--triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\n[ repairing the antenna ]"," "," ","no")
	outputStatusInfo("[ repairing... ]",240,240,240 )
	removeEventHandler("onClientColShapeHit", Aunt_MaeAntennaCol, Aunt_MaeAntennaMissionCheck)
	triggerEvent("sleep:drawDXProgress", localPlayer, 5000,5000)
	setTimer(triggerEvent,5000,1,"sleep:stopDXProgress",localPlayer)
	setPedAnimation( localPlayer, "BOMBER", "BOM_Plant",5000,true,false,false,false)
	
	setTimer(function() 
		currentMission = "Go back to Aunt Mae and claim your reward."
		triggerEvent("DrawQuestTitle",localPlayer,"\n\nWell done!\nReport back to Aunt Mae\nin Palomino Creek"," "," ","no")
		destroyElement(Aunt_MaeAntennaBlip)
		destroyElement(Aunt_MaeAntennaCol)
		destroyElement(Aunt_MaeAntennaMarker)
		Aunt_Mae_mission_status = 1 
		local count, slot = hasPlayerItem_c ("Wire", localPlayer)
		triggerServerEvent("RemoveItemInSync",localPlayer,slot)
		outputInteractInfo("- Wire",255, 92, 38)
	end,5000,1)
	
	else
	
	outputInteractInfo("[ Wire & Toolbox required ]",255,150,0 )
	
	end
	
end

