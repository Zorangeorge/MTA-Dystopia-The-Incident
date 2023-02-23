addEvent("ShowQuestWindow",true)
local currentped

function checkNPCForQuest(ped)
	if ped then
		local x,y,z = getElementPosition(localPlayer)
		local team = getPlayerTeam(localPlayer)
		local teamname = getTeamName(team)
		local px,py,pz = getElementPosition(ped)
		if getDistanceBetweenPoints3D(x,y,z,px,py,pz)< NPC_INTERACTION_DISTANCE then
			local name = getElementData(ped,"name")
			if name == "CDF Recruiter" then
				CDF_Recruiter_mainQ()
			elseif name == "Milton" then
				Milton_Winthrop_mainQ()	
			elseif name == "Derrik" then
				Derrik_mainQ()
			elseif name == "Cousin Saltmeat" then
				RaiderArena_mainQ()
			elseif name == "Bookie" then
				local team = getElementData(ped,"BotTeam")
				if getTeamName(team) == "Bandits" then
					LVBookie_mainQ()
				elseif getTeamName(team) == "Raiders" then
					RaiderArenaBookie_mainQ()
				end
			elseif name == "Lou Harper" then
				LouHarper_mainQ()
			elseif name == "Mac" then
				Mac_mainQ()
				
			elseif name == "Old Scavenger" then
				startingQuest_mainQ()		
				
			elseif name == "Ellis" then
				meetEllisQuest_mainQ()
				
			elseif name == "Meat" then
				meatRelease_Q(ped)
			
			elseif name == "Slave" then
				slaveRelease_Q(ped)			
			
			elseif name == "Captive" then
				captiveRelease_Q(ped)
			
			elseif name == "Morris" then
				montgomeryBanditRaid_Q(ped)
				
			elseif name == "Bounty Hunter" then
				scavBountyHunter_Q(ped)
			
			elseif name == "Weasel" then
				Weasel_Q(ped) --explore the drain for Weasel
				
			elseif name == "Litterman" then
				Litterman_Q(ped) --bring meat and fish cans to Litterman in graveyard camp
				
			elseif name == "Cullen" then
				Cullen_Q(ped) --tow vehicles to the car shop
				
			elseif name == "Wilson" then
				Wilson_Q(ped) --LS train station
			elseif name == "Connaugh" then
				Connaugh_Q(ped) --LS scav hideout near pershing
			elseif name == "Al Milligore" then
				Al_Milligore_Q(ped) --CJ mansion
			elseif name == "Bo Freemantle" then
				Bo_Freemantle_Q(ped) --LS hills CDF
			elseif name == "Martin" then
				Martin_Q(ped) --LS hills CDF
			elseif name == "Jesus" then
				Jesus_Q(ped) --LS hills CDF
			elseif name == "Bugs" then
				Bugs_Q(ped) --LS hills CDF
			elseif name == "Trader" then
				startTrade(ped) --generic traders
			elseif name == "Quartermaster" then
				startTrade(ped) --military and CDF outfitters
			elseif name == "Outfitter" then
				startTrade(ped) --scav, raider, bandit outfitters
			elseif name == "Mechanic" then
				startTrade(ped) -- mechanic items traders
			elseif name == "Medic" then
				startTrade(ped) -- medic items traders
			elseif name == "Bartender" then
				startTrade(ped) -- bartender items traders
			elseif name == "Weapons Dealer" then
				startTrade(ped) -- weapon items traders
			elseif name == "Trotter" then
				go_Ref_Q(name) --anon LS 
			elseif name == "Hopkins" then
				go_Ref_Q(name) --anon LS 
			elseif name == "Coleman" then
				go_Ref_Q(name) --anon LS 
			elseif name == "Sgt. Crisp" then
				sgtCrispFuel_Q(ped) --cleaner sgt ref camp 
			elseif name == "Nimsky" then
				nimskyscrap_Q(ped) --nimsky dumpcamp 
			elseif name == "Sheriff Gruber" then
				sheriffGruber_Q(ped) --CDF  
			elseif name == "Supervisor" then
				CampSupervisor_Q(ped) 
			elseif name == "McCready" then
				McCready_Q(ped)
			elseif name == "The Professor" then
				theProfessor_dialogue1(ped) --observatory LS
			elseif name == "Registry Medtech" then
				Registry_Medtech_dialogue(ped) --Registry_Medtech ref camp
			elseif name == "Registry Bureaucrat" then
				Registry_Bureaucrat_dialogue(ped) --Registry_Medtech ref camp
			elseif name == "Agent Shepherd" then
				Agent_Shepherd_dialogue(ped) --refugee camp heli extraction missions			
			elseif name == "Mallory Freemantle" then
				Mallory_Freemantle_Q(ped) --palomino CDF
			elseif name == "Aunt Mae" then
				Aunt_Mae_Q(ped) --refugee camp quests
			end
		end
	end
end
addEventHandler("ShowQuestWindow",root,checkNPCForQuest)


local curr_mission_col
local curr_mission_blip
local curr_mission_blip2
local curr_mission_marker
local current_mission_item
local curr_mission_item_obj
local curr_mission_vehicle
local curr_mission_ped

function clearMissionData ()

removeEventHandler("onClientPedWasted",root,BountyTargetCheckKill)
removeEventHandler("onClientPedWasted",root,WantedTargetCheckKill)
removeEventHandler("onClientPedWasted",root,Al_Milligore_MissionCheckKill)
removeEventHandler("onClientPedWasted",root,ConnaughMissionCheckKill)
removeEventHandler("onClientPedWasted",root,HarlanMissionCheckKill)
removeEventHandler("onClientPedWasted",root,LouHarperMissionCheckKill)
removeEventHandler("onClientPedWasted",root,MacMissionCheckKill)
removeEventHandler("onClientPedWasted",root,Martin_MissionCheckKill)
removeEventHandler("onClientPedWasted",root,Bo_Freemantle_MissionCheckKill)
if isElement(MiltonGoToDumpTargetZone) then
	removeEventHandler("onClientColShapeHit",MiltonGoToDumpTargetZone,MiltonGoToDumpCheck)
end
if isElement(EllisTargetZone) then
	removeEventHandler("onClientColShapeHit",EllisTargetZone,EllisTargetZoneCheck)
end
if isElement(JesusTargetZone) then
	removeEventHandler("onClientColShapeHit",JesusTargetZone,JesusTargetZoneCheck)
end
if isElement(curr_mission_col) then
	removeEventHandler("onClientColShapeHit", curr_mission_col, ReturnHomeMcCreadyMissionCheck)
	removeEventHandler("onClientColShapeHit", curr_mission_col, RichmanMcCreadyMissionCheck)
	removeEventHandler("onClientColShapeHit", curr_mission_col, MansionMcCreadyMissionCheck)
	removeEventHandler("onClientColShapeHit", curr_mission_col, GroveMcCreadyMissionCheck)
end
if isElement(curr_mission_vehicle) then
	removeEventHandler("onClientVehicleExplode",curr_mission_vehicle,lootVanExplodes)
end
if isElement(curr_mission_col) then destroyElement(curr_mission_col); curr_mission_col = nil end
if isElement(curr_mission_blip) then destroyElement(curr_mission_blip); curr_mission_blip = nil end
if isElement(curr_mission_blip2) then destroyElement(curr_mission_blip2); curr_mission_blip2 = nil end
if isElement(curr_mission_marker) then destroyElement(curr_mission_marker); curr_mission_marker = nil end
if isElement(curr_mission_item_obj) then destroyElement(curr_mission_item_obj); curr_mission_item_obj = nil end
--if isElement(curr_mission_ped) then destroyElement(curr_mission_ped); curr_mission_ped = nil end
if isElement(curr_mission_ped) then triggerServerEvent("Dystopia_destroy_mission_ped_for_player",localPlayer) end
if isElement(curr_mission_vehicle) then triggerServerEvent("Dystopia_destroy_mission_vehicle_for_player",localPlayer) end
--if isElement(curr_mission_ped) then triggerServerEvent("Dystopia_destroy_mission_ped_for_player",localPlayer) end
current_mission_item = nil
currentMission = "None"
raidersKilled = 0
lootersKilled = 0
scavsKilled = 0
CDFKilled = 0
estabKilled = 0
banditsKilled = 0
zombiesKilled = 0
Weasel_found_them = 0
BountyKilled = 0
BountyTarget_name = nil
BountyTarget_x = nil
BountyTarget_y = nil
BountyTarget_z = nil
BountyTarget_zonename = nil
BootyMission_1 = 0
--BootyMission_2 = 0
WantedKilled = 0
WantedTarget_name = nil
WantedTarget_x = nil
WantedTarget_y = nil
WantedTarget_z = nil
WantedTarget_zonename = nil
successful_medical_examination = false

end

addEventHandler("onClientPlayerWasted",root,function()
if source == localPlayer then clearMissionData () end
end)

addEventHandler("onClientPedWasted",root,function()
if source == curr_mission_ped then clearMissionData () end
end)

--------------------MISSIONS SPECIFICS START HERE

--Mallory_Freemantle, camp boss in Palomino CDF 

local Mallory_Freemantle_mission_status = 0

function Mallory_Freemantle_Q(ped)
	if Mallory_Freemantle_mission_status == 0 then
		showQuestWindow ( "Mallory Freemantle", "Our radio tower went silent. Must be the damn bandits cutting the wires again! I need somebody who can handle both tools and guns to go take care of the problem. Travel there, remove any threat, fix the antenna, come back. Simple job, and we're paying 400$ for this!\n\n[ REQUIRED: Wire & Toolbox ]", 
				"Hm, I can do it!", "Start_Mallory_Freemantle_Q('Fix the radio antenna on the peak south of Palomino')", 
				"Nah, don't think so", " ",
				"0", " ", 		
				"0", " " )
	elseif Mallory_Freemantle_mission_status == 1 then
		showQuestWindow ( "Mallory Freemantle", "Have you done what I asked for? Our communication lines are vital, without them there's no coordination with The Farm. Get on that mountain and fix the antenna!", 
				"Yes, it's done!", "Mallory_Freemantle_win_Q()", 
				"Still working on it..", " ",
				"0", " ", 		
				"0", " " )
		elseif Mallory_Freemantle_mission_status == 2 then
		showQuestWindow ( "Mallory Freemantle", "We have reports of suspicious bandit activity around Hanky Panky point. One of our rangers spotted bandits there last week, and then again yesterday. This can't be good! Find that camp and bring some intel. They must be up to something! (+500$)", 
				"Sure, I'm on it!", "Start_Mallory_Freemantle_Q('Investigate suspicious bandit activity around Hanky Panky Point.')", 
				"Oh, not fighting again..", " ",
				"0", " ", 		
				"0", " " )
		elseif Mallory_Freemantle_mission_status == 3 then
		showQuestWindow ( "Mallory Freemantle", "Have you done what I asked for? We need to find out what they're plotting. Go there and leave no stone unturned!", 
				"I found this!", "Mallory_Freemantle_win_Q()", 
				"Not yet", " ",
				"0", " ", 		
				"0", " " )
	end
end

function Mallory_Freemantle_win_Q()

	if Mallory_Freemantle_mission_status == 1 then
		Mallory_Freemantle_mission_status = 2
		currentMission = "None"
		triggerEvent("DrawQuestTitle",localPlayer,"+400$","mission completed!","Speak with Mallory to continue")
		triggerServerEvent("GiveReputation",localPlayer,400)
		addPlayerExp(localPlayer,15)
		outputStatusInfo("+15 XP",240,240,240 )
		local karma = getElementData(localPlayer,"karma") or 0
		setElementData(localPlayer,"karma",karma+3,true)
		outputStatusInfo("+2 karma",240,240,240 )
	elseif Mallory_Freemantle_mission_status == 3 then
		Mallory_Freemantle_mission_status = 0
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

function Start_Mallory_Freemantle_Q(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start Mallory_Freemantle")
	end
	
	if newmission == "Fix the radio antenna on the peak south of Palomino" then 
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","mr. fixer","Fix the radio antenna on the peak south of Palomino")
		Mallory_FreemantleAntennaCol = createColSphere(2084.228515625, -428.259765625, 114.14374542236,1)
		curr_mission_col = Mallory_FreemantleAntennaCol
		Mallory_FreemantleAntennaMarker = createMarker(2084.228515625, -428.259765625, 113.14374542236,"cylinder",1.5,100,100,100,150)
		addEventHandler("onClientColShapeHit", Mallory_FreemantleAntennaCol, Mallory_FreemantleAntennaMissionCheck)
		Mallory_FreemantleAntennaBlip = createBlip ( 2084.228515625, -428.259765625, 113.14374542236, 53, 2, 255, 255, 255, 255, 1, 500)
		curr_mission_item_obj = createObject(1624,2084.0810546875, -427.421875, 113.18435668945)
		--setObjectScale(curr_mission_item_obj,1.5)
		setElementRotation(curr_mission_item_obj,0,0,90)
		setElementDoubleSided(curr_mission_item_obj,true)
		setElementCollisionsEnabled(curr_mission_item_obj,false)
		curr_mission_blip = Mallory_FreemantleAntennaBlip
		curr_mission_marker = Mallory_FreemantleAntennaMarker
		setElementData(Mallory_FreemantleAntennaBlip, "blip.visibleOnScreen", true)
		
	elseif newmission == "Investigate suspicious bandit activity around Hanky Panky Point." then
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","hanky panky","\nInvestigate the suspicious bandit activity\naround Hanky Panky Point")
		Mallory_FreemantleJournalCol = createColSphere(2663.7978515625, 220.2392578125, 57.161201477051,1)
		curr_mission_col = Mallory_FreemantleJournalCol
		Mallory_FreemantleJournalMarker = createMarker(2663.7978515625, 220.2392578125, 56.161201477051,"cylinder",1,100,100,100,150)
		addEventHandler("onClientColShapeHit", Mallory_FreemantleJournalCol, Mallory_FreemantleJournalMissionCheck)
		Mallory_FreemantleJournalBlip = createBlip ( 2663.7978515625, 220.2392578125, 57.161201477051, 53, 2, 255, 255, 255, 255, 1, 500)
		curr_mission_item_obj = createObject(2894,2663.7978515625, 220.2392578125, 56.161201477051)
		--setObjectScale(curr_mission_item_obj,1)
		setElementRotation(curr_mission_item_obj,0,0,337)
		setElementDoubleSided(curr_mission_item_obj,true)
		setElementCollisionsEnabled(curr_mission_item_obj,false)
		curr_mission_blip = Mallory_FreemantleJournalBlip
		curr_mission_marker = Mallory_FreemantleJournalMarker
		setElementData(Mallory_FreemantleJournalBlip, "blip.visibleOnScreen", true)
		
	end
	
end

function Mallory_FreemantleJournalMissionCheck(hitElem)

	if hitElem == localPlayer and currentMission == "Investigate suspicious bandit activity around Hanky Panky Point." then
	outputStatusInfo("[ Investigating... ]",240,240,240 )
	removeEventHandler("onClientColShapeHit", Mallory_FreemantleJournalCol, Mallory_FreemantleJournalMissionCheck)
	triggerEvent("sleep:drawDXProgress", localPlayer, 1000,1000)
	setTimer(triggerEvent,1000,1,"sleep:stopDXProgress",localPlayer)
	setTimer(destroyElement,1000,1,curr_mission_item_obj)
	setPedAnimation( localPlayer, "BOMBER", "BOM_Plant",1000,true,false,false,false)
	
	setTimer(function() 
		currentMission = "Take the journal back to Mallory in Palomino."
		triggerEvent("DrawQuestTitle",localPlayer,"\n\nYou found Moe's Journal!\nBring it back to Mallory Freemantle\nin Palomino Creek"," "," ","no")
		destroyElement(Mallory_FreemantleJournalBlip)
		destroyElement(Mallory_FreemantleJournalCol)
		destroyElement(Mallory_FreemantleJournalMarker)
		--destroyElement(curr_mission_item_obj)
		Mallory_Freemantle_mission_status = 3 
		outputInteractInfo("+ [Moe's Journal]",255, 92, 38)
	end,1500,1)
	
	else
	
	outputInteractInfo("[ Wire & Toolbox required ]",255,150,0 )
	
	end
	
end

function Mallory_FreemantleAntennaMissionCheck(hitElem)

	if hitElem == localPlayer and hasPlayerItem_c ("Wire", localPlayer) and hasPlayerItem_c ("Wire", localPlayer) then
	--triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\n[ repairing the antenna ]"," "," ","no")
	outputStatusInfo("[ repairing... ]",240,240,240 )
	removeEventHandler("onClientColShapeHit", Mallory_FreemantleAntennaCol, Mallory_FreemantleAntennaMissionCheck)
	triggerEvent("sleep:drawDXProgress", localPlayer, 5000,5000)
	setTimer(triggerEvent,5000,1,"sleep:stopDXProgress",localPlayer)
	setPedAnimation( localPlayer, "BOMBER", "BOM_Plant",5000,true,false,false,false)
	
	setTimer(function() 
		currentMission = "Go back to Mallory Freemantle and claim your reward."
		triggerEvent("DrawQuestTitle",localPlayer,"\n\nWell done!\nReport back to Mallory Freemantle\nin Palomino Creek"," "," ","no")
		destroyElement(Mallory_FreemantleAntennaBlip)
		destroyElement(Mallory_FreemantleAntennaCol)
		destroyElement(Mallory_FreemantleAntennaMarker)
		Mallory_Freemantle_mission_status = 1 
		local count, slot = hasPlayerItem_c ("Wire", localPlayer)
		triggerServerEvent("RemoveItemInSync",localPlayer,slot)
		outputInteractInfo("- Wire",255, 92, 38)
	end,5000,1)
	
	else
	
	outputInteractInfo("[ Wire & Toolbox required ]",255,150,0 )
	
	end
	
end



-- Estab agent extraction missions


extractedPedLines = {"Go,go,go!","Good to see you!","It was about time!"}

RefCampExtractionMissions = {

--LV scav comm =
{
{1661.5302734375, 2406.9140625, 10.92001914978},--landing=1
{1650.24609375, 2395.529296875, 10.874519348145},--ped=2
"Our agent went to gather intel on a new scavenger com station in Las Venturas. He's real close to the camp, but you can slip in unnoticed from the north side. Hurry up and extract him!",--dialogue = 3
0,--pedmodel = 4
"Fly to Las Venturas com station and land in the marked spot" --missiontext = 5
},
--LV abandoned parking near crater = 
{
{2333.7109375, 1507.6279296875, 30.836273193359 },--landing=
{2346.6318359375, 1516.2255859375, 31.124568939209 },--ped=
"Our man is in Las Venturas, inside the Hot Zone. You will find him on the roof of an ruined parking building. Move fast, the radiation hits hard over there. Now go and extract him!",--dialogue = 
0,--pedmodel = 
"Fly to the Las Venturas parking and land in the marked spot" --missiontext = 
},
--SF little island = 
{
{ -1502.9619140625, 1373.8759765625, 3.6388397216797},--landing=
{ -1510.353515625, 1371.9970703125, 3.2309036254883},--ped=
"Your extraction target was investigating Boat Town, north of San Fierro. He's waiting for evac on a small island near shore. No issues are expected with this one, but keep your eyes open!",--dialogue = 
0,--pedmodel = 
"Fly to the island near Boat Town and land in the marked spot" --missiontext = 
},
--SF china town = 
{
{-2282.3388671875, 645.390625, 73.866119384766 },--landing=
{ -2292.5634765625, 655.06640625, 73.859375},--ped=
"Your target awaits extraction on a roof near China Town, in San Fierro. Watch your closing vector, the roofs are crawling with the damn scavs. Move swiftly and bring our agent back here for debriefing!",--dialogue = 
0,--pedmodel = 
"Fly near China Town and land in the marked spot" --missiontext = 
},
--angel pine shipwreck = 
{
{ -2766.6640625, -2283.2470703125, 4.383472442627},--landing=
{-2748.2646484375, -2274.6220703125, 7.6885986328125 },--ped=
"Our agent went to gather intel about the Berevinsky, a large cargo ship shipwrecked on a beach near Angel Pine. Fly there and extract him, we'll be waiting here for you.",--dialogue = 
0,--pedmodel = 
"Fly to the Berevinsky near Angel Pine and land in the marked spot" --missiontext = 
},
--palomino = 
{
{ 2224.8291015625, -111.3369140625, 26.484375},--landing=
{2210.783203125, -110.8759765625, 25.806245803833 },--ped=
"Our agent went to gather intel on the CDF camp in Palomino Creek. The area might be occupied by militias and LZ might be hot. Hurry up and extract him!",--dialogue = 
0,--pedmodel = 
"Fly to Palomino Creek and land in the marked spot" --missiontext = 
},
--dillimore = 
{
{ 536.4052734375, -467.09375, 41.587127685547},--landing=
{546.90234375, -475.6796875, 39.731979370117 },--ped=
"Our agent went to gather intel on the CDF camp in Dillimore. The area is occupied by militias and LZ might be hot. Hurry up and extract him!",--dialogue = 
0,--pedmodel = 
"Fly to Dillimore and land in the marked spot" --missiontext = 
},
--hunters quarry = 
{
{ 708.6513671875, 915.958984375, -18.648086547852},--landing=
{715.33984375, 908.7490234375, -19.139516830444 },--ped=
"This one is special: your extraction target is an anthropologist from mainland. He went on to study the raider clans of Hunters Quarry - a crazy assignemnt if you ask me. Time to bring him home with the data he gathered.",--dialogue = 
0,--pedmodel = 
"Fly to Hunters Quarry and land in the marked spot" --missiontext = 
},
--whetstone traincrash = 
{
{ -1304.84375, -1528.45703125, 23.84246635437},--landing=
{-1309.7109375, -1523.7734375, 23.800832748413 },--ped=
"You don't need to know too much about this assignment. Fly to Whetstone and bring our man back here, he'll be waiting by the railroad. And keep your mouth shut when you are back, understood?",--dialogue = 
0,--pedmodel = 
"Fly to Whetstone and land in the marked spot" --missiontext = 
}

}

function ReturnWithExtractionMissionCheck(hitElem)

	if hitElem == localPlayer and getPedOccupiedVehicle(localPlayer) == curr_mission_vehicle then 

		triggerEvent("DrawQuestTitle",localPlayer,"Well done!","mission completed!","+600$")
		triggerServerEvent("GiveReputation",localPlayer,600)
		addPlayerExp(localPlayer,15)
		outputStatusInfo("+15 XP",240,240,240 )
		removeEventHandler("onClientColShapeHit", curr_mission_col, ReturnWithExtractionMissionCheck)
		clearMissionData ()
	end

end

function RefCampHeliExtractionMissionCheck(hitElem)

	if hitElem == localPlayer and getPedOccupiedVehicle(localPlayer) == curr_mission_vehicle then 

		triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\nTarget extracted!\nReturn to A69 on a double!"," "," ","no")
		removeEventHandler("onClientColShapeHit", curr_mission_col, RefCampHeliExtractionMissionCheck)
		destroyElement(curr_mission_blip)
		destroyElement(curr_mission_col)
		destroyElement(curr_mission_marker)
		currentMission = "Fly back to A69 with your passenger"
		
		local x,y,z = getElementPosition( localPlayer )
		local px, py, pz = getElementPosition( curr_mission_ped )
		local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360
		setElementRotation(curr_mission_ped,0,0,pedangle)
		addBubble(table.random(extractedPedLines), curr_mission_ped, getTickCount())
		setPedAnimation(curr_mission_ped,"ped", "sprint_civi",2000,false,true,true,false)
		setTimer(function()triggerServerEvent("Dystopia_warpAPedInVehicle",localPlayer,curr_mission_ped,curr_mission_vehicle)end,2000,1)
		local returnlocationblip = createBlip ( 148.0205078125, 1819.5869140625, 17.640625, 3, 2, 255, 255, 255, 255, 1, 500)
		setElementData(returnlocationblip, "blip.visibleOnScreen", true)
		curr_mission_blip = returnlocationblip
		
		local targetCol = createColSphere(148.0205078125, 1819.5869140625, 17.640625,2)
		curr_mission_col = targetCol
		addEventHandler("onClientColShapeHit", curr_mission_col, ReturnWithExtractionMissionCheck)
		
		curr_mission_marker = createObject(354,148.0205078125, 1819.5869140625, 16.640625)
	end
end

function AgentShepherd_start(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start extraction mission")
	end
	
	if newmission == "Get in the chopper and fly to the marked location" then 
		
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","extraction","Get in the heli and fly to your target")
		local localhandler = RefCampExtractionMissions[themission]
		triggerServerEvent("Dystopia_create_mission_vehicle_for_player",localPlayer,563,148.0205078125, 1819.5869140625, 17.640625, 268.91918945313,"4G3NTX",0,0,0,0,0,0)
		
		--setTimer(setVehicleColor,10000,1,curr_mission_vehicle, 0,0,0,0,0,0,0,0,0)
		
		local targetblip = createBlip ( localhandler[1][1], localhandler[1][2], localhandler[1][3], 14, 2, 255, 255, 255, 255, 1, 500)
		setElementData(targetblip, "blip.visibleOnScreen", true)
		curr_mission_blip = targetblip
		curr_mission_marker = createObject(354,localhandler[1][1], localhandler[1][2], localhandler[1][3])		--flaremodel = 354
		
		
--[[		local targetped = createPed(table.random(ScavengerFreelancerSkins),localhandler[2][1], localhandler[2][2], localhandler[2][3])
		curr_mission_ped = targetped]]
		
		triggerServerEvent("Dystopia_create_mission_ped_for_player",localPlayer,table.random(EstabSuitSkins),localhandler[2][1], localhandler[2][2], localhandler[2][3],"Agent","Establishment","ped","ON_LOOKERS","shout_in")
		
		currentMission = localhandler[5]
		
		local targetCol = createColSphere(localhandler[1][1], localhandler[1][2], localhandler[1][3],2)
		curr_mission_col = targetCol
		addEventHandler("onClientColShapeHit", targetCol, RefCampHeliExtractionMissionCheck)
	
	end

end

function AgentShepherd_bargain()
showQuestWindow ( "Agent Shepherd", "This is what you people are paid for! But hey, rest assured, there will be a fat bonus if you pull this through! 600$ are waiting for you here when you complete this assignment.", 
		"I'm on it, sir!", "AgentShepherd_start('Get in the chopper and fly to the marked location')", 
		"Nah, flying makes me sick..", " ", 	
		"0", " ",
		"0", " " )
end

function AgentShepherd_brief()

--get random mission
themission = math.random(1,9)
--get dialogue
currentdialogue = RefCampExtractionMissions[themission][3]

showQuestWindow ( "Agent Shepherd", currentdialogue, 
		"On my way!", "AgentShepherd_start('Get in the chopper and fly to the marked location')", 
		"Sounds high-risk...", "AgentShepherd_bargain()", 	
		"Nah, flying makes me sick..", " ",
		"0", " " )
end

function AgentShepherd_info()
showQuestWindow ( "Agent Shepherd", "Establishment agents work covertly to keep the enemy at bay. This sometimes requires dangerous assignments, deep into enemy territory. One of them is ready to return home with the intel; you need to extract and bring him here for debrief.", 
		"Tell me more", "AgentShepherd_brief()", 
		"Actually, flying makes me sick..", " ", 	
		"0", " ",
		"0", " " )
end


function Agent_Shepherd_dialogue (ped)
showQuestWindow ( "Agent Shepherd", "You there! Are you qualified for flying a chopper? A military one? Well regardless, there's no time for this. I need you right now for a dangerous mission, are you in?", 
		"I'm listening", "AgentShepherd_brief()", 
		"Nah, not now!", " ",
		"Flying makes me sick..", " ", 		
		"What?!", "AgentShepherd_info()" )
end


--registry bureaucrat

local successful_medical_examination = false

function Registry_Bureaucrat_takeGear()
triggerServerEvent("takeAllPlayerGear",root)
triggerServerEvent("MakePlayerRefugee",root)

showQuestWindow ( "Registry Bureaucrat", "Now listen up, camp rules: You're not allowed to leave the Camp. You must obey Peacekeepers instructions at all times. The camp administration provides you with one free soup per day, get it from the soup dispensers. Camp is governed by martial law and transgressions are severly punished. Now move inside, refugee!",
		"Okay", "clearMissionData()", 
		"0", " ",
		"0", " ", 		
		"0", " " )
setTimer(function()if not isCursorShowing() then showCursor(true) end end,3000,1)
end

--[[function test_dialogue_window()
		showQuestWindow ( "Test window", "KEEP YOUR DISTANCE!\nYou might be infected!\nFirst go and speak\nto the Medtech over there.\nIf you pass the medical\nexam come back\nto me and I'll\nsee about your\nadmission.",
				"butt 1", " ", 
				"butt 2", " ",
				"butt 3", " ", 		
				"butt 4", " " )
end]]

function Registry_Bureaucrat_dialogue(ped)
	if not successful_medical_examination then
		showQuestWindow ( "Registry Bureaucrat", "KEEP YOUR DISTANCE! You might be infected! First go and speak to the Medtech over there. If you pass the medical exam come back to me and I'll see about your admission.",
				"Aha...", " ", 
				"0", " ",
				"0", " ", 		
				"0", " " )
	else
		
		showQuestWindow ( "Registry Bureaucrat", "It appears you're not infected. So you want to become a refugee? You want to enjoy the safety and warmth of the camp? Good, then give all your gear to me. The Establishment provides everything you need inside the camp.",
				"Yes, sir!", "Registry_Bureaucrat_takeGear()", 
				"Huh? I changed my mind!", " ",
				"0", " ", 		
				"0", " " )
	end
end

--registry medtech ref camp

addEvent("PlayerWasChipped",true)
function after_was_chipped_Obj ()
	clearMissionData ()
	triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\nGo and speak with the Registry Bureaucrat\nto complete your registration"," "," ","no")
	currentMission = "Speak with the Registry Bureaucrat"
	successful_medical_examination = true
	local targetblip = createBlip ( 354, 1795.2998, 18.2, 3, 2, 255, 255, 255, 255, 1, 500)
	setElementData(targetblip, "blip.visibleOnScreen", true)
	curr_mission_blip = targetblip
end
addEventHandler("PlayerWasChipped",root,after_was_chipped_Obj)

function Registry_Medtech_enterAmbo (newmission)

	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start enter ambulance")
	end
	
	if newmission == "Enter the ambulance for your med exam" then 
		local chipAmbulance = getElementByID("Chip_Ambulance")
		local x,y,z = getElementPosition(chipAmbulance)
		triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\nEnter in the back of the ambulance\nfor your medical examination"," "," ","no")
		local targetblip = createBlip ( x, y, z, 3, 2, 255, 255, 255, 255, 1, 500)
		setElementData(targetblip, "blip.visibleOnScreen", true)
		curr_mission_blip = targetblip
		addEventHandler("onClientVehicleEnter",chipAmbulance,clearMissionData)
	end
	
end

function Registry_Medtech_nonsmartass (ped)
showQuestWindow ( "Registry Medtech", "This is what all you people say, but we have to see about it. Enter the ambulance overthere for your medical examination. If you are clear, you can speak with the Bureaucrat for admission.",
		"Okay", "Registry_Medtech_enterAmbo('Enter the ambulance for your med exam')", 
		"Nevermind", " ",
		"0", " ", 		
		"0", " " )
end

function Registry_Medtech_smartass (ped)
showQuestWindow ( "Registry Medtech", "Oh, so you're a smartass? This won't make you popular with the Peacekeepers once you are inside, so I suggest you curb your sparkling personality a bit. Now get in the ambulance for your medical exam!",
		"Okay", "Registry_Medtech_enterAmbo('Enter the ambulance for your med exam')", 
		"Fuck off", " ",
		"0", " ", 		
		"0", " " )
end

function Registry_Medtech_truth (ped)
showQuestWindow ( "Registry Medtech", "Okay, gimme just a second... Good, I put that down. Have you ever been bitten, Mr. "..getPlayerName(localPlayer).."?",
		"Nope", "Registry_Medtech_nonsmartass()", 
		"Only during foreplay", "Registry_Medtech_smartass()",
		"Nevermind", " ", 		
		"0", " " )
end

function Registry_Medtech_lie (ped)
showQuestWindow ( "Registry Medtech", "Okay, gimme just a second... How is this spelled? Mc-D-U-F-U-S? Good, I wrote it down. Have you ever been bitten, Mr. McDufus?",
		"Nope", "Registry_Medtech_nonsmartass()", 
		"Only during foreplay", "Registry_Medtech_smartass()",
		"Nevermind", " ", 		
		"0", " " )
end

function Registry_Medtech_dialogue (ped)
showQuestWindow ( "Registry Medtech", "You want admission in the camp? You'd better not be infected, then! I'll put you down in the registry here. What is your name?",
		getPlayerName(localPlayer), "Registry_Medtech_truth()", 
		"[LIE] Bob McDufus", "Registry_Medtech_lie()",
		"Nevermind", " ", 		
		"0", " " )
end
--The Professor -- scav rescue missions with heli in LS

savedPedLines = {"Thank you!","I'm saved!","Just in time!","Thank goodness!","I thought I'm done for!","Oh, I'm so happy to see you!","Hooray!"}

function missionPedKilled ()
	if curr_mission_ped and isPedDead(curr_mission_ped) then
	triggerEvent("DrawQuestTitle",localPlayer,"Bad luck...","mission failed","The scavenger was killed!","no")
	clearMissionData()
	end
end

addEvent("SetCurrentMissionPed",true)
function set_Curr_Mission_Ped (ped)
		curr_mission_ped = ped
		addEventHandler("onClientPedWasted",curr_mission_ped,missionPedKilled)
end
addEventHandler("SetCurrentMissionPed",root,set_Curr_Mission_Ped)


LSrescueMissions = {

--LSHospitalRescue =
{
{1160.3095703125, -1357.0087890625, 25.658447265625},--landing=1
{1158.443359375, -1345.544921875, 26.686153411865},--ped=2
"Our friend went to check All Saints General Hospital, hoping for any medical supplies left. Some looters started snooping in the area and now he's trapped on the roof! He's well hidden, but he can't make any moves without giving away his position. Hurry up and rescue him!",--dialogue = 3
0,--pedmodel = 4
"Fly to All Saints Hospital in Los Santos and land in the marked spot" --missiontext = 5
},
--LSHighwayRescue = 
{
{1639.8046875, -1512.11328125, 21.595613479614 },--landing=
{1637.34375, -1498.6337890625, 22.589454650879 },--ped=
"We received a distress call from a friendly scavenger! He's in a tight situation, hiding on the roof of some building right below the freeway node, in Downtown Los Santos. Take the heli and hurry up to his position!",--dialogue = 
0,--pedmodel = 
"Fly to the Downtown LS freeway node and land in the marked spot" --missiontext = 
},
--LSCarniceriaRescue = 
{
{ 2199.55859375, -1025.921875, 69.3046875},--landing=
{ 2193.0439453125, -1032.5224609375, 70.3046875},--ped=
"One of our friends got in serious trouble! He's stuck in Las Colinas, with raiders nearby! Be careful, the landing zone is most likely hot! You need to hurry, he's minutes away from being discovered, and you know what raiders do to people, right?",--dialogue = 
0,--pedmodel = 
"Fly to Las Colinas and land in the marked spot" --missiontext = 
},
--LSMotelRescue = 
{
{2178.49609375, -1837.451171875, 15.140625 },--landing=
{ 2175.3779296875, -1828.8115234375, 16.140625},--ped=
"One of our scavs got spotted in the Ganton area by the bad guys! He's on top of some motel there, and there's raiders around that are looking for him. Take the heli and hurry to his position before it's too late!",--dialogue = 
0,--pedmodel = 
"Fly to Ganton and land in the marked spot" --missiontext = 
},
--LSDockHighwayRescue = 
{
{ 2659.4453125, -2138.087890625, 22.969848632813},--landing=
{2666.806640625, -2135.875, 23.969848632813 },--ped=
"A friend of ours went on a scavenge run that did not ended well. He was ambushed by some robbers and he took refuge on top of some containers in the Ocean Docks area. Take the heli and hurry up to his position!",--dialogue = 
0,--pedmodel = 
"Fly to Ocean Docks and land in the marked spot" --missiontext = 
}

}

function ReturnWithRescuedMissionCheck(hitElem)

	if hitElem == localPlayer and getPedOccupiedVehicle(localPlayer) == curr_mission_vehicle then 

		triggerEvent("DrawQuestTitle",localPlayer,"You did it!","good job!","+10 karma")
		local karma = getElementData(localPlayer,"karma") or 0
		setElementData(localPlayer,"karma",karma+10,true)
		outputStatusInfo("+10 karma",240,240,240 )
		removeEventHandler("onClientColShapeHit", curr_mission_col, ReturnWithRescuedMissionCheck)
		clearMissionData ()
	end

end

function LSHeliRescueMissionCheck(hitElem)

	if hitElem == localPlayer and getPedOccupiedVehicle(localPlayer) == curr_mission_vehicle then 

		triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\nTarget rescued!\nNow take the Sparrow back to the Observatory"," "," ","no")
		removeEventHandler("onClientColShapeHit", curr_mission_col, LSHeliRescueMissionCheck)
		destroyElement(curr_mission_blip)
		destroyElement(curr_mission_col)
		destroyElement(curr_mission_marker)
		currentMission = "Fly back to the Observatory with your passenger"
		
		local x,y,z = getElementPosition( localPlayer )
		local px, py, pz = getElementPosition( curr_mission_ped )
		local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - px ), ( y - py ) ) ) ) % 360
		setElementRotation(curr_mission_ped,0,0,pedangle)
		addBubble(table.random(savedPedLines), curr_mission_ped, getTickCount())
		setPedAnimation(curr_mission_ped,"ped", "sprint_civi",2000,false,true,true,false)
		setTimer(function()triggerServerEvent("Dystopia_warpAPedInVehicle",localPlayer,curr_mission_ped,curr_mission_vehicle)end,2000,1)
		local returnlocationblip = createBlip ( 1153.5, -2056.1669921875, 69.0078125, 3, 2, 255, 255, 255, 255, 1, 500)
		setElementData(returnlocationblip, "blip.visibleOnScreen", true)
		curr_mission_blip = returnlocationblip
		
		local targetCol = createColSphere(1153.5, -2056.1669921875, 69.0078125,2)
		curr_mission_col = targetCol
		addEventHandler("onClientColShapeHit", curr_mission_col, ReturnWithRescuedMissionCheck)
		
		curr_mission_marker = createObject(354,1153.5, -2056.1669921875, 68.0078125)
	end
end

function theProfessor_start(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start rescue mission")
	end
	
	if newmission == "Take the heli and fly to the indicated location" then 
		
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","code brown","Get in the heli and fly to your target")
		local localhandler = LSrescueMissions[themission]
		triggerServerEvent("Dystopia_create_mission_vehicle_for_player",localPlayer,469,1148.767578125, -2013.1767578125, 69.0078125, 264.17852783203,"BRWN")
		
		local targetblip = createBlip ( localhandler[1][1], localhandler[1][2], localhandler[1][3], 62, 2, 255, 255, 255, 255, 1, 500)
		setElementData(targetblip, "blip.visibleOnScreen", true)
		curr_mission_blip = targetblip
		curr_mission_marker = createObject(354,localhandler[1][1], localhandler[1][2], localhandler[1][3])		--flaremodel = 354
		
		
--[[		local targetped = createPed(table.random(ScavengerFreelancerSkins),localhandler[2][1], localhandler[2][2], localhandler[2][3])
		curr_mission_ped = targetped]]
		
		triggerServerEvent("Dystopia_create_mission_ped_for_player",localPlayer,table.random(ScavengerFreelancerSkins),localhandler[2][1], localhandler[2][2], localhandler[2][3],"Scavenger","Scavengers","ped","ON_LOOKERS","shout_in")
		
		
		local targetCol = createColSphere(localhandler[1][1], localhandler[1][2], localhandler[1][3],2)
		curr_mission_col = targetCol
		addEventHandler("onClientColShapeHit", targetCol, LSHeliRescueMissionCheck)
	
	end

end

function theProfessor_bargain()
showQuestWindow ( "The Professor", "Our gratitude... Also, you'll know that you did the right thing during a time when many men didn't.", 
		"OK, I'll do it.", "theProfessor_start('Take the heli and fly to the indicated location')", 
		"Actually, flying makes me sick..", " ", 	
		"0", " ",
		"0", " " )
end

function theProfessor_brief()

--get random mission
themission = math.random(1,5)
--get dialogue
currentdialogue = LSrescueMissions[themission][3]

showQuestWindow ( "The Professor", currentdialogue, 
		"On my way!", "theProfessor_start('Take the heli and fly to the indicated location')", 
		"What's in it for me?", "theProfessor_bargain()", 	
		"Nah, flying makes me sick..", " ",
		"0", " " )
end

function theProfessor_info()
showQuestWindow ( "The Professor", "We have received an S.O.S. on ham radio minutes ago! Code Brown: friendly in trouble and in dire need for evac! We have a Sparrow fueled and ready nearby, and he will marked the landing spot with a flare when you approach. Can you fly and bring him back here to safety?", 
		"Tell me more", "theProfessor_brief()", 
		"Actually, flying makes me sick..", " ", 	
		"0", " ",
		"0", " " )
end


function theProfessor_dialogue1 (ped)
showQuestWindow ( "The Professor", "Quick! I need someone with a kind hearth who can fly a helicopter! Maybe you are the man I'm looking for?", 
		"Damn sure I am!", "theProfessor_brief()", 
		"Nah, not me!", " ",
		"Flying makes me sick..", " ", 		
		"What?!", "theProfessor_info()" )
end


-- McCready, bandit boss in Ocean Docks warehouse

function lootVanExplodes () 

triggerEvent("DrawQuestTitle",localPlayer,"Bad luck...","mission failed","Your mission vehicle was destroyed!","no") 
clearMissionData ()

end

function ReturnHomeMcCreadyMissionCheck(hitElem)

	if hitElem == localPlayer and getPedOccupiedVehicle(localPlayer) == curr_mission_vehicle then 

		triggerEvent("DrawQuestTitle",localPlayer,"Welcome back, brother!","well done!","+800$")
		triggerServerEvent("GiveReputation",localPlayer,800)
		addPlayerExp(localPlayer,15)
		outputStatusInfo("+15 XP",240,240,240 )
		removeEventHandler("onClientColShapeHit", curr_mission_col, ReturnHomeMcCreadyMissionCheck)
		clearMissionData ()

	end
	
end

function RichmanMcCreadyMissionCheck(hitElem)

	if hitElem == localPlayer and getPedOccupiedVehicle(localPlayer) == curr_mission_vehicle then 

		triggerEvent("DrawQuestTitle",localPlayer,'\n\n\n\nWell done, time to go back!\nReturn the van to McCready at Ocean Docks Warehouse.'," "," ","no")
		removeEventHandler("onClientColShapeHit", curr_mission_col, RichmanMcCreadyMissionCheck)
		destroyElement(curr_mission_blip)
		destroyElement(curr_mission_col)
		destroyElement(curr_mission_marker)
		currentMission = "Drive the van back to Ocean Docks Warehouse"
		
		local warehousepickup = createBlip ( 2154.66796875, -2290.4423828125, 13.392587661743, 3, 2, 255, 255, 255, 255, 1, 500)
		setElementData(warehousepickup, "blip.visibleOnScreen", true)
		curr_mission_blip = warehousepickup
		
		local warehouseCol = createColSphere(2154.66796875, -2290.4423828125, 13.392587661743,2)
		curr_mission_col = warehouseCol
		addEventHandler("onClientColShapeHit", curr_mission_col, ReturnHomeMcCreadyMissionCheck)
		
		curr_mission_marker = createMarker(2154.66796875, -2290.4423828125, 12.392587661743,"cylinder",2,197, 63, 0)
		
		BootyMission_1 = 3

	end
	
end

function MansionMcCreadyMissionCheck(hitElem)

	if hitElem == localPlayer and getPedOccupiedVehicle(localPlayer) == curr_mission_vehicle then 

		triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\nGreat, now head to Richman for the next load.\nBut watch out, across the bridge the CDF owns the streets!"," "," ","no")
		removeEventHandler("onClientColShapeHit", curr_mission_col, MansionMcCreadyMissionCheck)
		destroyElement(curr_mission_blip)
		destroyElement(curr_mission_col)
		destroyElement(curr_mission_marker)
		currentMission = "Drive the van to Richman for another pickup"
		
		local richmanpickup = createBlip ( 294.4853515625, -1177.9951171875, 80.9140625, 3, 2, 255, 255, 255, 255, 1, 500)
		setElementData(richmanpickup, "blip.visibleOnScreen", true)
		curr_mission_blip = richmanpickup
		
		local richmanCol = createColSphere(294.4853515625, -1177.9951171875, 80.9140625,2)
		curr_mission_col = richmanCol
		addEventHandler("onClientColShapeHit", curr_mission_col, RichmanMcCreadyMissionCheck)
		
		curr_mission_marker = createMarker(294.4853515625, -1177.9951171875, 79.9140625,"cylinder",2,197, 63, 0)
		
		BootyMission_1 = 2

	end
	
end

function GroveMcCreadyMissionCheck(hitElem)

	if hitElem == localPlayer and getPedOccupiedVehicle(localPlayer) == curr_mission_vehicle then 

		triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\nGood job! Load these up!\nNow drive to the Mansion for your next pickup."," "," ","no")
		removeEventHandler("onClientColShapeHit", curr_mission_col, GroveMcCreadyMissionCheck)
		destroyElement(curr_mission_blip)
		destroyElement(curr_mission_col)
		destroyElement(curr_mission_marker)
		currentMission = "Drive the van to the Mansion for another pickup"
		
		local mansionpickup = createBlip ( 1253.71875, -808.6796875, 84.140625, 3, 2, 255, 255, 255, 255, 1, 500)
		setElementData(mansionpickup, "blip.visibleOnScreen", true)
		curr_mission_blip = mansionpickup
		
		local mansionCol = createColSphere(1253.71875, -808.6796875, 84.140625,2)
		curr_mission_col = mansionCol
		addEventHandler("onClientColShapeHit", curr_mission_col, MansionMcCreadyMissionCheck)
		
		curr_mission_marker = createMarker(1253.71875, -808.6796875, 83.140625,"cylinder",2,197, 63, 0)

		
		BootyMission_1 = 1

	end
	
end

addEvent("SetCurrentMissionVehicle",true)
function set_Curr_Mission_Veh (veh)
		curr_mission_vehicle = veh
		local blip
		local vehtype = getVehicleType(veh)
		
		if vehtype == "Helicopter" then blip = 18
		elseif vehtype == "Plane" then blip = 5
		elseif vehtype == "Boat" then blip = 9
		else blip = 51
		end
		
		local curr_veh_blip = createBlip ( 2154.66796875, -2290.4423828125, 13.392587661743, blip, 2, 255, 255, 255, 255, 1, 500)
		attachElements(curr_veh_blip,curr_mission_vehicle)
		curr_mission_blip2 = curr_veh_blip
		setElementData(curr_veh_blip, "blip.visibleOnScreen", true)
		addEventHandler("onClientVehicleExplode",curr_mission_vehicle,lootVanExplodes)
end
addEventHandler("SetCurrentMissionVehicle",root,set_Curr_Mission_Veh)


function McCready_start_Q(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start McCready")
	end
	
	if newmission == "Get in the van and drive to Grove Street" then 
		
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","booty run","Get in the van and drive to the Grove Street pickup point")

		triggerServerEvent("Dystopia_create_mission_vehicle_for_player",localPlayer,609,2154.66796875, -2290.4423828125, 13.392587661743, 224.66011047363,"BOOTY")
		
		local grovestpickup = createBlip ( 2494.19921875, -1682.6904296875, 13.338341712952, 3, 2, 255, 255, 255, 255, 1, 500)
		setElementData(grovestpickup, "blip.visibleOnScreen", true)
		curr_mission_blip = grovestpickup
		curr_mission_marker = createMarker(2494.19921875, -1682.6904296875, 12.338341712952,"cylinder",2,197, 63, 0)
		

		local groveCol = createColSphere(2494.19921875, -1682.6904296875, 13.338341712952,2)
		curr_mission_col = groveCol
		addEventHandler("onClientColShapeHit", groveCol, GroveMcCreadyMissionCheck)
	
	end

end

function McCready_brief_Q()
showQuestWindow ( "McCready", "Good! There are only two rules: don't lose the van and don't touch the loot. I don't need to tell you what happens if you do... I'll pay 800$ when you're back. You'll get more instructions on the road. What do you say?", 
		"I'm in!", "McCready_start_Q('Get in the van and drive to Grove Street')", 
		"Sounds boring..", " ",
		"0", " ", 		
		"0", " " )
end

function McCready_Q()
showQuestWindow ( "McCready", "Listen up.. I need someone that's trustworthy and good behind the wheel! I have a van outside, set up to pick up the booty from all our Los Santos chapters. The brothers are waiting for it. I want you to drive the van and bring it back in one piece. You think you can do that?", 
		"Tell me more!", "McCready_brief_Q()", 
		"Not for me..", " ",
		"0", " ", 		
		"0", " " )
end

-- camp Supervisor, will sign you up for cleaners

function placeholder_refuse_Supervisor()
showQuestWindow ( "Supervisor", "Not right now. But check back later and maybe we will be... There's always trouble around here!", 
		"Oh, ok..", " ", 
		"0", " ",
		"0", " ", 		
		"0", " " )
end

function CampSupervisor_Q()
showQuestWindow ( "Supervisor", "Mind your bussiness and keep your mouth shut here in the camp and maybe you'll soon fly to Mainland. Make trouble, and the cages are waiting!", 
		"Yes sir!", " ", 
		"Are you hiring?", "placeholder_refuse_Supervisor()",
		"0", " ", 		
		"0", " " )
end

--sgtCrisp, ref camp

function Check_Fuel_sgtCrisp_Q()
	
	if hasPlayerItem_c ("Fuel Canister", localPlayer) then
		
		local Fuel_count, mslot = hasPlayerItem_c ("Fuel Canister", localPlayer) or 0,nil
		local reward = Fuel_count*60
		local mslots = hasPlayerItem_c_slots ("Fuel Canister", localPlayer)
		
		if mslots then
			for i=1,9 do
				if mslots[i] then
					triggerServerEvent("RemoveItemInSync",root,i)
				end
			end
		end
		
		outputTopBar("You give fuel canisters to Sgt. Crisp",240,240,240)
		triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+"..reward.."$")
		triggerServerEvent("GiveReputation",localPlayer,reward)
		destroyElement(sgtCrispBlip)
		currentMission = "None"
		addPlayerExp(localPlayer,Fuel_count*2)
		outputStatusInfo("+"..(Fuel_count*2).." XP",240,240,240 )

	else
		showQuestWindow ( "Sgt. Crisp", "What do you think you're doing, idiot? You think we're joking here? Do you want to end up in the body ditch too? Go get that fuel now!", 
				"Umm.. Sorry!", " ", 
				"0", " ",
				"0", " ", 		
				"0", " " )

	end
end

function Start_sgtCrisp_Q(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start sgtCrisp")
	end
	
	if newmission == "Bring fuel canisters to Sgt. Crisp for 60$ each" then 
		
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","slow burn","Bring fuel canisters to Sgt. Crisp for 60$ each")

		local sgtCrispBlip = createBlip ( 204.39999,2073.8999,22.6, 29, 2, 255, 255, 255, 255, 1, 500)
		setElementData(sgtCrispBlip, "blip.visibleOnScreen", true)
		curr_mission_blip = sgtCrispBlip

	end
	
end

function Info_sgtCrisp()
showQuestWindow ( "Sgt. Crisp", "We're the Cleaner Corps and I'm Sgt. Crisp! We do our part day and night with the cleaning and re-building effort. Working on burning bodies, shooting zeds and making San Andreas safe from infection is tough work, but someboy has to do it. 'Clean up the mess' is our credo and when we arrive, infection recedes.", 
		"Aha..", "sgtCrispFuel_Q()", 
		"Are you hiring?", "JoinCleaners_sgtCrisp()",
		"0", " ", 		
		"0", " " )
end


function JoinCleaners_sgtCrisp()
showQuestWindow ( "Sgt. Crisp", "Top ranks are always looking for new warm bodies. This job is dirty, but is paid.. and at least you know you do your part in the cleaning and re-building effort! If you think you have the guts, go see the Supervisor about it. Maybe there's an opening.", 
		"I will, sir", "sgtCrispFuel_Q()", 
		"Nevermind", " ",
		"0", " ", 		
		"0", " " )
end

function sgtCrispFuel_Q(ped)
	if currentMission == 'Bring fuel canisters to Sgt. Crisp for 60$ each' then
		showQuestWindow ( "Sgt. Crisp", "Did you bring fuel as I instructed you? These bodies will decay and dissapear until you complete a simple bloody assignment!", 
				"Here it is", "Check_Fuel_sgtCrisp_Q()", 
				"No, not yet", " ",
				"0", " ", 		
				"0", " " )
	else
		showQuestWindow ( "Sgt. Crisp", "You there! I need you right now for an urgent assignment! Drop all you're doing and bring me some fuel canisters double-quick. As many as you can find! These corpses started to rot already. I'll pay you 60$ each.", 
				"I smell it.. Ok.", "Start_sgtCrisp_Q('Bring fuel canisters to Sgt. Crisp for 60$ each')", 
				"Who are you?", "Info_sgtCrisp()",
				"I'm busy", " ", 		
				"0", " " )
	end
end

--Bugs, Rinkeville LS

function Check_Parts_Bugs_Q()
	
	if hasPlayerItem_c ("Vehicle Parts", localPlayer) then
		
		local parts_count, mslot = hasPlayerItem_c ("Vehicle Parts", localPlayer) or 0,nil
		local reward = parts_count*50
		local mslots = hasPlayerItem_c_slots ("Vehicle Parts", localPlayer)
		
		if mslots then
			for i=1,9 do
				if mslots[i] then
					triggerServerEvent("RemoveItemInSync",root,i)
				end
			end
		end
		
		outputTopBar("You give vehicle parts to Bugs",240,240,240)
		triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+"..reward.."$")
		triggerServerEvent("GiveReputation",localPlayer,reward)
		destroyElement(BugsBlip)
		currentMission = "None"
		addPlayerExp(localPlayer,parts_count*2)
		outputStatusInfo("+"..(parts_count*2).." XP",240,240,240 )
		local karma = getElementData(localPlayer,"karma") or 0
		setElementData(localPlayer,"karma",karma+parts_count,true)
		outputStatusInfo("+"..parts_count.." karma",240,240,240 )
	else
		showQuestWindow ( "Bugs", "What do you t-t-think you're doing, p-punk? I'll b-b-bust your face if you t-t-try t-to make fun of ol' Bugs again!", 
				"Umm.. Sorry!", " ", 
				"0", " ",
				"0", " ", 		
				"0", " " )
		local karma = getElementData(localPlayer,"karma") or 0
		setElementData(localPlayer,"karma",karma-1,true)
		outputStatusInfo("-1 karma",240,240,240 )
	end
end

function Start_Bugs_Q(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start Bugs")
	end
	
	if newmission == "Bring vehicle parts to Bugs for 50$ each" then 
		
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","disassembler","Bring vehicle parts to Bugs for 50$ each")

		BugsBlip = createBlip ( 2271.5,-1458.7,23.6, 48, 2, 255, 255, 255, 255, 1, 500)
		setElementData(BugsBlip, "blip.visibleOnScreen", true)
		curr_mission_blip = BugsBlip

	end
	
end

function Info_Bugs()
showQuestWindow ( "Bugs", "What do you m-m-mean? I'm B-b-bugs, the b-best train engine mechanic left in Los S-Santos! Well, at least my c-c-competitors are all d-d-dead, so there's n-nobody to say otherwise.", 
		"Aha..", "Bugs_Q()", 
		"0", " ",
		"0", " ", 		
		"0", " " )
end

function Brief_Bugs()
showQuestWindow ( "Bugs", "N-now you're asking the right q-q-questions! I'm going to fix the freight t-t-train engine over t-there! Chuu-chuuu! Yeeeehaw!", 
		"Aha..", "Bugs_Q()", 
		"What are you going to do with it?", "Train_Teaser_Bugs()",
		"0", " ", 		
		"0", " " )
end

function Train_Teaser_Bugs()
showQuestWindow ( "Bugs", "Heh-he.. The t-t-train is unstoppable for z-z-zeds. Jesus and me are going to use the t-train to open a safe trade route: Corona, Market Station and b-b-beyond!", 
		"Oh, I see..", "Bugs_Q()", 
		"0", " ",
		"0", " ", 		
		"0", " " )
end

function Bugs_Q(ped)
	if currentMission == 'Bring vehicle parts to Bugs for 50$ each' then
		showQuestWindow ( "Bugs", "Hey, d-d-... did you f-find any vehicle p-parts? This train engine is not g-g-going to fix itself, you k-know?", 
				"Yes, look here", "Check_Parts_Bugs_Q()", 
				"No, not yet", " ",
				"0", " ", 		
				"0", " " )
	else
		showQuestWindow ( "Bugs", "You look like you t-travel a lot.. There's something I really need, b-b-but I cannot interrupt my work to g-go g-g-get them me'self. Bring me all vehicle parts you can f-find and I'll pay you 50$ f-f-for each!", 
				"Count me in!", "Start_Bugs_Q('Bring vehicle parts to Bugs for 50$ each')", 
				"Who are you?", "Info_Bugs()",
				"What do you need the parts for?", "Brief_Bugs()", 		
				"Not interested..", " " )
	end
end


--Bo Freemantle, LS hills CDF

function Bo_Freemantle_Win()
banditsKilled = 0
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+500$")
triggerServerEvent("GiveReputation",localPlayer,500)
removeEventHandler("onClientPedWasted",root,Bo_Freemantle_MissionCheckKill)

addPlayerExp(localPlayer,25)
outputStatusInfo("+25 XP",240,240,240 )
local karma = getElementData(localPlayer,"karma") or 0
setElementData(localPlayer,"karma",karma+5,true)
outputStatusInfo("+5 karma",240,240,240 )

currentMission = "None"
destroyElement(Bo_Freemantle_TargetCol)
destroyElement(Bo_Freemantle_TargetBlip)
Bo_Freemantle_TargetBlip = nil
Bo_Freemantle_TargetCol = nil
end

function Bo_Freemantle_MissionCheckKill (killer,weapon)

	local istarget = getElementData(source,"bandit")
	
	if istarget and isElementWithinColShape(source,Bo_Freemantle_TargetCol) then 
	banditsKilled = banditsKilled+1 
	outputDebugString("A bandit was killed")
	end

	if banditsKilled >= 10 then 
	Bo_Freemantle_Win() 
	end
end

function Bo_Freemantle_start_Q(newmission)
	
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start Bo Freemantle")
	end
	
	if newmission == "Kill 10 bandits in Richman area - 500$" then 
	
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","push forth","Kill 10 bandits in Richman area - 500$")

	Bo_Freemantle_TargetCol = createColSphere(295.869140625, -1170.00390625, 80.909896850586,350)
	Bo_Freemantle_TargetBlip = createBlip ( 295.869140625, -1170.00390625, 80.909896850586, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(Bo_Freemantle_TargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = Bo_Freemantle_TargetCol
	curr_mission_blip = Bo_Freemantle_TargetBlip
	
	addEventHandler("onClientPedWasted",root,Bo_Freemantle_MissionCheckKill)

	end
	
end

function Bo_Freemantle_Q(ped)
showQuestWindow ( "Bo Freemantle", "It's time to take the battle to the bandits. Our scouts located one of their strongholds in Richman, controlling the road going down to Rodeo. We need to strike hard and deliver a message to be rememberd. 500$ are yours if you take them out.", 
		"On my way!", "Bo_Freemantle_start_Q('Kill 10 bandits in Richman area - 500$')", 
		"Too dangerous..", " ",
		"0", " ", 		
		"0", " " )
end

--nimsky, dump camp

function Check_scrap_nimsky_Q()
	
	if hasPlayerItem_c ("Scrap Metal", localPlayer) then
		
		local scrap_count, mslot = hasPlayerItem_c ("Scrap Metal", localPlayer) or 0,nil
		local reward = scrap_count*20
		local mslots = hasPlayerItem_c_slots ("Scrap Metal", localPlayer)
		
		if mslots then
			for i=1,9 do
				if mslots[i] then
					triggerServerEvent("RemoveItemInSync",root,i)
				end
			end
		end
		
		outputTopBar("You give scrap metal to Nimsky",240,240,240)
		triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+"..reward.."$")
		triggerServerEvent("GiveReputation",localPlayer,reward)
		destroyElement(nimskyBlip)
		currentMission = "None"
		addPlayerExp(localPlayer,scrap_count*2)
		outputStatusInfo("+"..(scrap_count*2).." XP",240,240,240 )

	else
		showQuestWindow ( "Nimsky", "What do you think you're doing, idiot? You think we're joking here? Do you want Goldgrin to hear you're delying the operations? Go get that scrap now!", 
				"Oh..", " ", 
				"Fuck you!", " ",
				"Fuck Goldgrin!", " ", 		
				"Fuck y'all!", " " )
	end
end

function Start_nimsky_Q(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start nimsky")
	end
	
	if newmission == 'Bring scrap metal to Nimsky in the Dump Camp' then 
		
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","tinkerer",'Bring scrap metal to Nimsky in the Dump Camp')

		nimskyBlip = createBlip ( 2572.7998,-1116.2998,65.9, 28, 2, 255, 255, 255, 255, 1, 500)
		setElementData(nimskyBlip, "blip.visibleOnScreen", true)
		curr_mission_blip = nimskyBlip

	end
	
end

function InfoGoldgrin_nimsky()
showQuestWindow ( "Nimsky", "You haven't met him yet? He's the topdog here so don't step out of the line, or his boys are gonna' hurt you! They say he grew up in this dump, a real OG.. The apocalypse just made it easier for him, haha..", 
		"I'll remember it", "nimskyscrap_Q()", 
		"I'm not scared", "campLore_nimsky()",
		"0", " ", 		
		"0", " " )
end

function campLore_nimsky()
showQuestWindow ( "Nimsky", "Oh you're not, you say? Go meet him in that improvised fortress he built. Just outside, up the stairs and by the door and he may even have a job for a fool like you.. or he will make you walk the board.", 
		"Maybe I will..", "nimskyscrap_Q()", 
		"Shut up!", " ",
		"0", " ", 		
		"0", " " )
end

function nimskyscrap_Q(ped)
	if currentMission == 'Bring scrap metal to Nimsky in the Dump Camp' then
		showQuestWindow ( "Nimsky", "Any  scrap for me, fellow? Simple mission, go get it!", 
				"Yes, look here", "Check_scrap_nimsky_Q()", 
				"No, not yet.", " ",
				"0", " ", 		
				"0", " " )
	else
		showQuestWindow ( "Nimsky", "Hey fellow! How about some cash? I'll pay 20$ each for all scrap metal you can bring me. Goldgrin ordered me to patch things up around here. This camp is a damn mess!", 
				"I'm in!", "Start_nimsky_Q('Bring scrap metal to Nimsky in the Dump Camp')", 
				"Goldgrin?", "InfoGoldgrin_nimsky()",
				"0", " ", 		
				"0", " " )
	end
end

--Martin, LS hills CDF

function Martin_Win()
banditsKilled = 0
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+500$")
triggerServerEvent("GiveReputation",localPlayer,500)
removeEventHandler("onClientPedWasted",root,Martin_MissionCheckKill)

addPlayerExp(localPlayer,25)
outputStatusInfo("+25 XP",240,240,240 )
local karma = getElementData(localPlayer,"karma") or 0
setElementData(localPlayer,"karma",karma+5,true)
outputStatusInfo("+5 karma",240,240,240 )

currentMission = "None"
destroyElement(Martin_TargetCol)
destroyElement(Martin_TargetBlip)
Martin_TargetBlip = nil
Martin_TargetCol = nil
end

function Martin_MissionCheckKill (killer,weapon)

	local istarget = getElementData(source,"bandit")
	
	if istarget and isElementWithinColShape(source,Martin_TargetCol) then 
	banditsKilled = banditsKilled+1 
	outputDebugString("A bandit was killed")
	end

	if banditsKilled >= 10 then 
	Martin_Win() 
	end
end

function Martin_start_Q(newmission)
	
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start martin")
	end
	
	if newmission == "Kill 10 bandits in the target area - 500$" then 
	
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","push back","Kill 10 bandits in the target area - 500$")

	Martin_TargetCol = createColSphere(1270.2724609375, -791.875, 92.03125,350)
	Martin_TargetBlip = createBlip ( 1270.2724609375, -791.875, 92.03125, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(Martin_TargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = Martin_TargetCol
	curr_mission_blip = Martin_TargetBlip
	
	addEventHandler("onClientPedWasted",root,Martin_MissionCheckKill)

	end
	
end

function Martin_Q(ped)
showQuestWindow ( "Martin", "Listen up, citizen! Bandits holed up in a Vinewood mansion and launch attacks on our stronghold here. Enough is enough! Go there, clean them all up and you'll earn 500$ and the gratitude of the Free County of Red!", 
		"I'm on it, sir!", "Martin_start_Q('Kill 10 bandits in the target area - 500$')", 
		"Too dangerous..", " ",
		"0", " ", 		
		"0", " " )
end

--Weasel, LS drain entrance near CDF tower
local Weasel_found_them = 0

function Weasel_Q(ped)
	if Weasel_found_them == 0 then
	showQuestWindow ( "Weasel", "Hey there fellow scav! I need you to do something for us. I want you to get into the drain tunnel over there and try to find a safe route to the small ruins hideout near Pershing. Raiders are closing in on our friends there and we need a route to bring them here. There's 300$ for you in this!", 
			"Okay, I'll do it", "Start_Weasel_Q('Find a drain tunnel route to Pershing ruins hideout')", 
			"Your problem, buddy!", " ",
			"0", " ", 		
			"0", " " )
	else 
	showQuestWindow ( "Weasel", "Have you explored those tunnels yet? You need to hurry, they won't last a minute if those damned Raider Hounds sniff them!", 
			"The way is open", "Weasel_win_Q()", 
			"I killed the Raiders", "Weasel_win_Q()",
			"Not yet", " ", 		
			"0", " " )
	end
end

function Weasel_win_Q()
Weasel_found_them = 0
currentMission = "None"
addPlayerExp(localPlayer,10)
outputStatusInfo("+10 XP",240,240,240 )
local karma = getElementData(localPlayer,"karma") or 0
setElementData(localPlayer,"karma",karma+5,true)
outputStatusInfo("+5 karma",240,240,240 )
--triggerServerEvent("GiveReputation",localPlayer,200)
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+300$")
triggerServerEvent("GiveReputation",localPlayer,300)
end

function Start_Weasel_Q(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start Weasel")
	end
	
	if newmission == "Find a drain tunnel route to Pershing ruins hideout" then 
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","shady way","Find a route through the drain tunnels to the ruins hideout near Pershing")
	WeaselFriendsCol = createColSphere(1403.0322265625, -1446.37109375, 8.6720142364502,2)
	curr_mission_col = WeaselFriendsCol
	addEventHandler("onClientColShapeHit", WeaselFriendsCol, WeaselFriendsMissionCheck)
	WeaselFriendsBlip = createBlip ( 1403.0322265625, -1446.37109375, 8.6720142364502, 3, 2, 255, 255, 255, 255, 1, 500)
	curr_mission_blip = WeaselFriendsBlip
	setElementData(WeaselFriendsBlip, "blip.visibleOnScreen", true)
	end
	
end

function WeaselFriendsMissionCheck(hitElem)

	if hitElem == localPlayer then 

		if Weasel_found_them == 0 then
		
		triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\nLooks like the way is open...\nNow find the hideout in the ruins"," "," ","no")
		removeEventHandler("onClientColShapeHit", WeaselFriendsCol, WeaselFriendsMissionCheck)
		destroyElement(WeaselFriendsBlip)
		destroyElement(WeaselFriendsCol)
		
		Weasel_found_them = 1
		
		WeaselFriendsCol2 = createColSphere(1326.4912109375, -1577.1123046875, 13.3515625,3.5)
		curr_mission_col = WeaselFriendsCol2
		addEventHandler("onClientColShapeHit", WeaselFriendsCol2, WeaselFriendsMissionCheck)
		WeaselFriendsBlip2 = createBlip ( 1326.4912109375, -1577.1123046875, 13.3515625, 3, 2, 255, 255, 255, 255, 1, 500)
		curr_mission_blip = WeaselFriendsBlip2
		setElementData(WeaselFriendsBlip2, "blip.visibleOnScreen", true)
		
		elseif Weasel_found_them == 1 then
		
		triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\nYou found the hideout...\nReturn to Weasel with the good news"," "," ","no")
		removeEventHandler("onClientColShapeHit", WeaselFriendsCol2, WeaselFriendsMissionCheck)
		destroyElement(WeaselFriendsBlip2)
		destroyElement(WeaselFriendsCol2)
		Weasel_found_them = 2
		end
		
	end
	
end


--Al Milligore, CJ mansion
function Al_Milligore_Win()
CDFKilled = 0
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+500$")
triggerServerEvent("GiveReputation",localPlayer,500)
removeEventHandler("onClientPedWasted",root,Al_Milligore_MissionCheckKill)

addPlayerExp(localPlayer,25)
outputStatusInfo("+25 XP",240,240,240 )
--[[local karma = getElementData(localPlayer,"karma") or 0
setElementData(localPlayer,"karma",karma-3,true)
outputStatusInfo("-3 karma",240,240,240 )]]

currentMission = "None"
destroyElement(Al_Milligore_TargetCol)
destroyElement(Al_Milligore_TargetBlip)
Al_Milligore_TargetBlip = nil
Al_Milligore_TargetCol = nil
end

function Al_Milligore_MissionCheckKill (killer,weapon)

	local istarget = getElementData(source,"cdf")
	
	if istarget and isElementWithinColShape(source,Al_Milligore_TargetCol) then 
	CDFKilled = CDFKilled+1 
	outputDebugString("A CDF was killed")
	end

	if CDFKilled >= 10 then 
	Al_Milligore_Win() 
	end
end

function Al_Milligore_start_Q(newmission)
	
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start al milligore")
	end
	
	if newmission == "Kill 10 CDF members in the target area - 500$" then 
	
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","bad neighbours","Kill 10 CDF members in the target area - 500$")

	Al_Milligore_TargetCol = createColSphere(953.435546875, -819.916015625, 96.103019714355,350)
	Al_Milligore_TargetBlip = createBlip ( 953.435546875, -819.916015625, 96.103019714355, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(Al_Milligore_TargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = Al_Milligore_TargetCol
	curr_mission_blip = Al_Milligore_TargetBlip
	
	addEventHandler("onClientPedWasted",root,Al_Milligore_MissionCheckKill)

	end
	
end

function Al_Milligore_Q(ped)
showQuestWindow ( "Al Milligore", "You wanna prove yourself? I have just the right job for you. The damned CDF are pushing south into our turf. They had the audacity to establish a base just across the bridge! Go there, give them a lesson and you'll make 500$!", 
		"My kind of job", "Al_Milligore_start_Q('Kill 10 CDF members in the target area - 500$')", 
		"Too dangerous..", " ",
		"0", " ", 		
		"0", " " )
end


--Connaugh, LS hideout near pershing
function ConnaughMissionWin()
lootersKilled = 0
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+200$")
triggerServerEvent("GiveReputation",localPlayer,200)
removeEventHandler("onClientPedWasted",root,ConnaughMissionCheckKill)

addPlayerExp(localPlayer,15)
outputStatusInfo("+15 XP",240,240,240 )
local karma = getElementData(localPlayer,"karma") or 0
setElementData(localPlayer,"karma",karma+5,true)
outputStatusInfo("+5 karma",240,240,240 )

currentMission = "None"
destroyElement(ConnaughTargetCol)
destroyElement(ConnaughTargetBlip)
ConnaughTargetBlip = nil
ConnaughTargetCol = nil
end

function ConnaughMissionCheckKill (killer,weapon)

	local islooter = getElementData(source,"neutralfreelancer")
	
	if islooter and isElementWithinColShape(source,ConnaughTargetCol) then 
	lootersKilled = lootersKilled+1 
	outputDebugString("A looter was killed")
	end

	if lootersKilled >= 3 then 
	ConnaughMissionWin() 
	end
end

function Connaugh_start_Q(newmission)
	
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start connaugh")
	end
	
	if newmission == "Clear the looter gang for Connaugh - 200$" then 
	
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","goin' shopping","Clear the looter gang for Connaugh")

	ConnaughTargetCol = createColSphere(1353.373046875, -1765.0546875, 13.549824714661,70)
	ConnaughTargetBlip = createBlip ( 1353.373046875, -1765.0546875, 13.549824714661, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(ConnaughTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = ConnaughTargetCol
	curr_mission_blip = ConnaughTargetBlip
	
	addEventHandler("onClientPedWasted",root,ConnaughMissionCheckKill)

	end
	
end

function Connaugh_Q(ped)
showQuestWindow ( "Connaugh", "Shhh! Keep quiet, there's a mean looking gang looting the store nearby! Speaking of which, how would you like to earn some cash? I need someone to send them away by any means necessary! There's 200$ waiting for you if you take care of this for us.", 
		"OK, I'll do it", "Connaugh_start_Q('Clear the looter gang for Connaugh - 200$')", 
		"Too dangerous..", " ",
		"0", " ", 		
		"0", " " )
end


--Wilson, LS train station
local wilson_found_them = 0

function Wilson_Q(ped)
if wilson_found_them == 0 then
showQuestWindow ( "Wilson", "Our friends Norm and Tina are gone since yesterday.. They went exploring around the train yard behind this fence and we never seen them again. We heard terrible screams last night.. we fear for our lives now! Can you please find out what happened to them?", 
		"Hm, I'll take a look!", "Start_Wilson_Q('Find the missing scavs for Wilson')", 
		"Your problem, buddy", " ",
		"0", " ", 		
		"0", " " )
else
showQuestWindow ( "Wilson", "Did you find any trace of our friends? Bill is unable to eat and I couldn't close an eye last night. Must have been the beans.. or the screams?! Oh, Norm! Where art you, brother?", 
		"Raiders got them", "Wilson_win_Q()", 
		"They got eaten", "Wilson_win_Q()",
		"Not yet", " ", 		
		"0", " " )
end
end

function Wilson_win_Q()
wilson_found_them = 0
currentMission = "None"
addPlayerExp(localPlayer,15)
outputStatusInfo("+15 XP",240,240,240 )
local karma = getElementData(localPlayer,"karma") or 0
setElementData(localPlayer,"karma",karma+5,true)
outputStatusInfo("+5 karma",240,240,240 )
--triggerServerEvent("GiveReputation",localPlayer,200)
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!"," ")

end

function Start_Wilson_Q(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start wilson")
	end
	
	if newmission == "Find the missing scavs for Wilson" then 
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","red trace","Find the missing scavs for Wilson")
	WilsonFriendsCol = createColSphere(1689.357421875, -1973.9697265625, 8.8203125,2)
	curr_mission_col = WilsonFriendsCol
	addEventHandler("onClientColShapeHit", WilsonFriendsCol, WilsonFriendsMissionCheck)
	WilsonFriendsBlip = createBlip ( 1689.357421875, -1973.9697265625, 8.8203125, 62, 2, 255, 255, 255, 255, 1, 500)
	curr_mission_blip = WilsonFriendsBlip
	setElementData(WilsonFriendsBlip, "blip.visibleOnScreen", true)
	end
	
end

function WilsonFriendsMissionCheck(hitElem)

	if hitElem == localPlayer then 

	triggerEvent("DrawQuestTitle",localPlayer,"\n\n\n\nThey're not here...\nTake the news back to Wilson"," "," ","no")
	removeEventHandler("onClientColShapeHit", WilsonFriendsCol, WilsonFriendsMissionCheck)
	destroyElement(WilsonFriendsBlip)
	destroyElement(WilsonFriendsCol)
	wilson_found_them = 1
	
	end
	
end

--Litterman, LS cemetery

function Check_Food_Litterman_Q()
	
	if hasPlayerItem_c ("Meat Can", localPlayer) or hasPlayerItem_c ("Fish Can", localPlayer) or hasPlayerItem_c ("Soup Can", localPlayer) then
		
		local mcount, mslot = hasPlayerItem_c ("Meat Can", localPlayer) or 0,nil
		local fcount, fslot = hasPlayerItem_c ("Fish Can", localPlayer) or 0,nil
		local scount, sslot = hasPlayerItem_c ("Soup Can", localPlayer) or 0,nil
		local total_can_count = mcount + fcount + scount
		local reward = total_can_count*50
		local mslots = hasPlayerItem_c_slots ("Meat Can", localPlayer)
		local fslots = hasPlayerItem_c_slots ("Fish Can", localPlayer)
		local sslots = hasPlayerItem_c_slots ("Soup Can", localPlayer)
		
		iprint("mcount: "..mcount)
		iprint("fcount: "..fcount)
		iprint("scount: "..scount)
		iprint(mslots)
		iprint(fslots)
		iprint(sslots)
		
		if mslots then
		iprint("m loop")
			for i=1,9 do
			iprint("m slot: "..i)
				if mslots[i] then
				iprint("m removal triggered")
					triggerServerEvent("RemoveItemInSync",root,i)
				end
			end
		end
		
		if fslots then
		iprint("f loop")
			for i=1,9 do
			iprint("f slot: "..i)
				if fslots[i] then
				iprint("f removal triggered")
					triggerServerEvent("RemoveItemInSync",root,i)
				end
			end
		end
		
		if sslots then
		iprint("s loop")
			for i=1,9 do
			iprint("s slot: "..i)
				if sslots[i] then
				iprint("s removal triggered")
					triggerServerEvent("RemoveItemInSync",root,i)
				end
			end
		end
		
		outputTopBar("You give food to Litterman",240,240,240)
		triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+"..reward.."$")
		triggerServerEvent("GiveReputation",localPlayer,reward)
		destroyElement(LittermanBlip)
		currentMission = "None"
		addPlayerExp(localPlayer,total_can_count*2)
		outputStatusInfo("+"..(total_can_count*2).." XP",240,240,240 )
		local karma = getElementData(localPlayer,"karma") or 0
		setElementData(localPlayer,"karma",karma+total_can_count,true)
		outputStatusInfo("+"..total_can_count.." karma",240,240,240 )
	else
		showQuestWindow ( "Litterman", "You are a cruel person to mock us like this! Please save us, we're starving here!", 
				"Oh..", " ", 
				"0", " ",
				"0", " ", 		
				"0", " " )
		local karma = getElementData(localPlayer,"karma") or 0
		setElementData(localPlayer,"karma",karma-1,true)
		outputStatusInfo("-1 karma",240,240,240 )
	end
end

function Start_Litterman_Q(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start litterman")
	end
	
	if newmission == "Bring food cans to Litterman for 50$ each" then 
		
		triggerEvent("DrawQuestTitle",localPlayer,"New mission:","food aid","Bring food cans to Litterman for 50$ each")
		--LittermCol = createColSphere(1689.357421875, -1973.9697265625, 8.8203125,2)
		--addEventHandler("onClientColShapeHit", WilsonFriendsCol, WilsonFriendsMissionCheck)
		LittermanBlip = createBlip ( 813.20001, -1100.6, 25.8, 10, 2, 255, 255, 255, 255, 1, 500)
		setElementData(LittermanBlip, "blip.visibleOnScreen", true)
		curr_mission_blip = LittermanBlip

	end
	
end

function Litterman_Q(ped)
	if currentMission == 'Bring food cans to Litterman for 50$ each' then
		showQuestWindow ( "Litterman", "Hey, did you find any food cans for us? I'm not sure for how long we'll be able to bare, we're starving!", 
				"Yes, here it is", "Check_Food_Litterman_Q()", 
				"No, not yet", " ",
				"0", " ", 		
				"0", " " )
	else
		showQuestWindow ( "Litterman", "You! You might be exactly the guy we need! Help us, stranger... We holed up here a while ago, but time passed and we're out of supplies. Zeds and robbers roam outside, so it's a dangerous job for my friends here, but you look like you can handle it. Bring us some food cans and I'll pay you 50$ for each.", 
				"Okay!", "Start_Litterman_Q('Bring food cans to Litterman for 50$ each')", 
				"I don't care", " ",
				"0", " ", 		
				"0", " " )
	end
end

--Cullen, LS car shop
function Cullen_Q(ped)

showQuestWindow ( "Cullen", "Hey there, fellow! Fancy some honest earnings? I need you to tow any wrecked vehicle you can get, so we can scrap it. Bring it to our drop point here and I'll make it worth your while. I offer 200$ for each wreck you can bring me!", 
		"Sounds good, I'm in!", "Start_Cullen_tow_Q('Tow any wrecked vehicle to the marked drop point for +200$')", 
		"What is this place?", "Cullen_Info_Q()",
		"Oh? Nevermind!", " ", 		
		"0", " " )

end

function Start_Cullen_tow_Q(newmission)
outputDebugString("start cullen tow")

if newmission == currentMission then 
	return 
else 
	clearMissionData ()
	currentMission = newmission 
	outputDebugString(currentMission)
end

	if newmission == "Tow any wrecked vehicle to the marked drop point for +200$" then 
	
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","tow job","Tow any wrecked vehicle to the marked drop point for +200$")
	ScrappingCarDropPoint = createColSphere(2116.552734375, -1935.0400390625, 13.703514099121,2.5)
	ScrappingCarMarker = createMarker(2116.552734375, -1935.0400390625, 10.703514099121,"cylinder",3.5,100,200,200)
	addEventHandler("onClientColShapeHit", ScrappingCarDropPoint, ScrappingCarMissionCheck)
	ScrappingCarBlip = createBlip ( 2116.552734375, -1935.0400390625, 13.703514099121, 55, 2, 255, 255, 255, 255, 1, 500)
	setElementData(ScrappingCarBlip, "blip.visibleOnScreen", true)
	curr_mission_blip = ScrappingCarBlip
	curr_mission_col = ScrappingCarDropPoint
	curr_mission_marker = ScrappingCarMarker
	end

end

function ScrappingCarMissionCheck(hitElem)

	if hitElem and getElementType(hitElem)=="vehicle" and getVehicleTowingVehicle(hitElem) then
			
			local veh = hitElem
			local player = getVehicleOccupant(getVehicleTowingVehicle(hitElem))
		if player == localPlayer and currentMission == "Tow any wrecked vehicle to the marked drop point for +200$" then
			if getElementData(veh,"vehicle-scenery") == true then
				currentMission = "None"
				triggerServerEvent("DystopiaTowRespawnVehicle",root,veh)
				addPlayerExp(player,10)
				outputStatusInfo("+10 XP",240,240,240 )
				triggerServerEvent("GiveReputation",localPlayer,200)
				triggerEvent("DrawQuestTitle",localPlayer,"Good job!","vehicle scrapped!","+200$")
				destroyElement(ScrappingCarDropPoint)
				destroyElement(ScrappingCarMarker)
				destroyElement(ScrappingCarBlip)
				removeEventHandler("onClientColShapeHit", ScrappingCarDropPoint, ScrappingCarMissionCheck)
			else
				outputInteractInfo("[ you can only scrap wrecked vehicles ]",255,150,0 )
			end
		end
			
	end

end


function Cullen_Info_Q()
showQuestWindow ( "Cullen", "Hoo! This is Cullen's Repairs And Previously Illegal Car Modifications Emporium! The only honest mechanic shop left in Los Santos. Put your vehicle on the ramp there and check out our services! Did I mentioned we can rig your car with weaponry?", 
		"I see..", "Cullen_Q()", 
		"Meh, nevermind..", " ",
		"0", " ", 		
		"0", " " )
end

-- slaves and meat release quests
function freePed()

local ped = currentped
local thankyous = {"Thank you!","Thank you so much!","I won't forget you!","You are a kind man!","I'm saved!","Oh, happy day!","I'm free!"}
	if ped then
	local karma = getElementData(localPlayer,"karma") or 0
	setElementData(localPlayer,"karma",karma+2,true)
	outputStatusInfo("+2 karma",240,240,240 )
		triggerEvent("onChatIncome",ped,table.random(thankyous))
		local team = getPlayerTeam(localPlayer)
		setElementData(ped,"BotTeam",team)
		detachElements(ped)
		setTimer(setPedAnimation,3000,1,ped,"ped","sprint_panic",20000,true,true,true,false)
		setTimer(setElementAlpha,10000,1,ped,250)
		setTimer(setElementAlpha,13000,1,ped,150)
		setTimer(setElementAlpha,16000,1,ped,0)
		setTimer(setElementDimension,18000,1,currentped,666) --and may he stay there
		setTimer(setElementPosition,18500,1,currentped,0,0,-666) --and may he never climb back
		setElementData(currentped,"freed",true)
		currentped = nil
	end


end

function meatRelease_Q(ped)
currentped = ped
local team = getPlayerTeam(localPlayer)
local teamname = getTeamName(team)

	if teamname ~= "Raiders" and getElementData(ped,"freed")~= true then
	showQuestWindow ( "Meat", "No, please... no... Don't do it, man! I can work, I can loot, I can do stuff for you... Don't eat me... Please?", 
			"You are free to go", "freePed()", 
			"Nevermind", " ",
			"0", " ", 		
			"0", " " )
	else
	showQuestWindow ( "Meat", "No, please... No... Don't do it, man! I can work, I can loot, I can do stuff for you... Don't eat me... Please?", 
			"Shut up, piggy", " ", 
			"0", " ",
			"0", " ", 		
			"0", " " )
	end

end

function slaveRelease_Q(ped)
currentped = ped
local team = getPlayerTeam(localPlayer)
local teamname = getTeamName(team)
	if teamname ~= "Raiders" and not getElementData(ped,"freed") then
	showQuestWindow ( "Slave", "Please... No... Don't hurt me! I'll work, I'll do anything you tell me to... Just don't kill me...", 
			"You are free to go", "freePed()", 
			"Nevermind", " ",
			"0", " ", 		
			"0", " " )
	else
	showQuestWindow ( "Slave", "Please... No... Don't hurt me! I'll work, I'll do anything you tell me to... Just don't kill me...", 
			"Nevermind", " ", 
			"0", " ",
			"0", " ", 		
			"0", " " )
	end
end

function captiveRelease_Q(ped)
currentped = ped
local team = getPlayerTeam(localPlayer)
local teamname = getTeamName(team)
	if teamname ~= "Establishment" and not getElementData(ped,"freed") then
	showQuestWindow ( "Captive", "Please, set me free! I was minding my own bussiness when they ambushed me, clubbed me, snatched me and dragged me here. They were going to intern me in the Refugee Camp!", 
			"You are free to go", "freePed()", 
			"Nevermind", " ",
			"0", " ", 		
			"0", " " )
	else
	showQuestWindow ( "Captive", "Please... No... Don't hurt me!", 
			"Nevermind", " ", 
			"0", " ",
			"0", " ", 		
			"0", " " )
	end
end


--scav bounty hunters
function scavBountyHunter_Q()
showQuestWindow ( "Bounty Hunter", "You look like a hardy fellow, how would you like to make some bucks doing what you do best? I need someone like you to deliver justice to some bad guys - be warned though, we are dealing with the worst kind here: raiders!", 
		"Huh? Tell me more!", "scavBountyHunterInfo()", 
		"What do you have for me?", "scavBountyHunter_brief()",
		"Nevermind", " ", 		
		"0", " " )
end

function scavBountyHunterInfo()
showQuestWindow ( "Bounty Hunter", "These damn raiders are getting stronger by the day! Their hordes run amok and threaten all decency left in San Andreas! We work to put an end to this but not too many takers, dangerous job... Here's the deal: I give you a mark, you bring him death. When takedown is confirmed, you get the bounty.", 
		"Okay, I'm in!", "scavBountyHunter_brief()", 
		"Sounds too dangerous", " ",
		"0", " ", 		
		"0", " " )
end

BountyTarget_name = nil
BountyTarget_x = nil
BountyTarget_y = nil
BountyTarget_z = nil
BountyTarget_zonename = nil
BountyKilled = 0

function setupScavBountyHunter()
	
	newMission = "Bounty: Eliminate "..BountyTarget_name.." located in "..BountyTarget_zonename.."."
	
	if newMission == currentMission then return else currentMission = newMission end
	
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","Bounty","Locate and kill "..BountyTarget_name.." in "..BountyTarget_zonename.." (+500$)")
	BountyTargetZone = createColSphere(BountyTarget_x, BountyTarget_y, BountyTarget_z,300)
	addEventHandler("onClientPedWasted",root,BountyTargetCheckKill)
	BountyTargetBlip = createBlip ( BountyTarget_x, BountyTarget_y, BountyTarget_z, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(BountyTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = BountyTargetZone
	curr_mission_blip = BountyTargetBlip
end

function BountyTargetCheckKill (killer,weapon)

	local name = getElementData(source,"name")

	if name == BountyTarget_name and isElementWithinColShape(localPlayer,BountyTargetZone) then 
	BountyKilled = BountyKilled+1 
	outputDebugString("Bounty target was killed")
	end

	if BountyKilled >= 1 then 
	BountyTargetMissionWin() 
	end
end

function BountyTargetMissionWin ()
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","Target eliminated!","+500$")
triggerServerEvent("GiveReputation",localPlayer,500)
removeEventHandler("onClientPedWasted",root,BountyTargetCheckKill)
currentMission = "None"
destroyElement(BountyTargetZone)
destroyElement(BountyTargetBlip)
BountyTargetBlip = nil
BountyTargetZone = nil
cleanupScavBountyHunter()
clearMissionData()
end

function cleanupScavBountyHunter()
BountyKilled = 0
BountyTarget_name = nil
BountyTarget_x = nil
BountyTarget_y = nil
BountyTarget_z = nil
BountyTarget_zonename = nil
end

function scavBountyHunter_brief()

	if BountyTarget_name then 
	showQuestWindow ( "Bounty Hunter", "What do you think you're doing? You already have a mark! Go and finish up "..BountyTarget_name.." first and then come back for more work, you greedy bastard!", 
		"Right", " ", 
		"0", " ",
		"0", " ", 		
		"0", " ")
	return 
	end

local allraiderspawns = getElementsByType("Raider_spawn")
local raiderChiefs = {}

	for _,spawn in ipairs(allraiderspawns) do
		if getElementData(spawn,"BotType") == "Quest" then
			if getElementData(spawn,"name") ~= "Bookie" and getElementData(spawn,"name") ~= "Raider Slaver" and getElementData(spawn,"name") ~= "Warchief" then
				table.insert(raiderChiefs,spawn)
			end
		end
	end

	local randomTarget = table.random(raiderChiefs)
	
	if randomTarget then
		BountyTarget_name = getElementData(randomTarget,"name")
		BountyTarget_x = getElementData(randomTarget,"posX")
		BountyTarget_y = getElementData(randomTarget,"posY")
		BountyTarget_z = getElementData(randomTarget,"posZ")
		BountyTarget_zonename = getZoneName(BountyTarget_x, BountyTarget_y, BountyTarget_z)
	end	
	
	showQuestWindow ( "Bounty Hunter", "Then listen carefully, here's the job: your target is "..BountyTarget_name..", notorious raider scum. He can be found in "..BountyTarget_zonename..". He's probably guarded by his goons and armed to the teeth, so scout the area and plan ahead! Make sure he doesn't harm anybody ever again!", 
		"On my way!", "setupScavBountyHunter()", 
		"I changed my mind...", "cleanupScavBountyHunter()",
		"0", " ", 		
		"0", " " )

end

--CDF sherrif missions


function sheriffGruberInfo()
showQuestWindow ( "Sheriff Gruber", "Our new nation is starting to get a foothold here in Red, but we're fighting on two fronts: while the Establishment is the more dangerous foe, bandits can not be ignored. Their gangs harass the new settlements and hinder our expansion into Whetstone and Los Santos. We need to bring them to justice!", 
		"Okay, I'm in!", "sheriffGruber_brief()", 
		"Uh, too dangerous", " ",
		"0", " ", 		
		"0", " " )
end

WantedTarget_name = nil
WantedTarget_x = nil
WantedTarget_y = nil
WantedTarget_z = nil
WantedTarget_zonename = nil
WantedKilled = 0

function setupsheriffGruber()
	
	newMission = "Wanted: Deliver justice to "..WantedTarget_name.." located in "..WantedTarget_zonename.."."
	
	if newMission == currentMission then return else currentMission = newMission end
	
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","Wanted","Deliver justice to "..WantedTarget_name.." in "..WantedTarget_zonename.." (+500$)")
	WantedTargetZone = createColSphere(WantedTarget_x, WantedTarget_y, WantedTarget_z,300)
	addEventHandler("onClientPedWasted",root,WantedTargetCheckKill)
	WantedTargetBlip = createBlip ( WantedTarget_x, WantedTarget_y, WantedTarget_z, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(WantedTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = WantedTargetZone
	curr_mission_blip = WantedTargetBlip
end

function WantedTargetCheckKill (killer,weapon)

	local name = getElementData(source,"name")

	if name == WantedTarget_name and isElementWithinColShape(localPlayer,WantedTargetZone) then 
	WantedKilled = WantedKilled+1 
	outputDebugString("Wanted target was killed")
	end

	if WantedKilled >= 1 then 
	WantedTargetMissionWin() 
	end
end

function WantedTargetMissionWin ()
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","justice served","+500$")
triggerServerEvent("GiveReputation",localPlayer,500)
removeEventHandler("onClientPedWasted",root,WantedTargetCheckKill)
currentMission = "None"
destroyElement(WantedTargetZone)
destroyElement(WantedTargetBlip)
WantedTargetBlip = nil
WantedTargetZone = nil
cleanupsheriffGruber()
clearMissionData()
end

function cleanupsheriffGruber()
WantedKilled = 0
WantedTarget_name = nil
WantedTarget_x = nil
WantedTarget_y = nil
WantedTarget_z = nil
WantedTarget_zonename = nil
end

function sheriffGruber_brief()

	if WantedTarget_name then 
	showQuestWindow ( "Sheriff Gruber", "What do you think you're doing? Bring justice to "..WantedTarget_name.." as I told you! By order of the Free County of Red!", 
		"Yes sir!", " ", 
		"0", " ",
		"0", " ", 		
		"0", " ")
	return 
	end

local allbanditspawns = getElementsByType("Bandit_spawn")
local banditChiefs = {}

	for _,spawn in ipairs(allbanditspawns) do
	
		local x,y,z = getElementPosition(spawn)
		if getElementData(spawn,"BotType") == "Quest" then
			if getElementData(spawn,"name") ~= "Bookie" and 
			getElementData(spawn,"name") ~= "Trainee" and 
			getElementData(spawn,"name") ~= "Skipjack Moe" and 
			getZoneName(x,y,z,true) ~= "Los Santos" and 
			getZoneName(x,y,z,true) ~= "San Fierro" and
			getZoneName(x,y,z,true) ~= "Las Venturas" 
			then
				table.insert(banditChiefs,spawn)
			end
		end
	end

	local randomTarget = table.random(banditChiefs)
	
	if randomTarget then
		WantedTarget_name = getElementData(randomTarget,"name")
		WantedTarget_x = getElementData(randomTarget,"posX")
		WantedTarget_y = getElementData(randomTarget,"posY")
		WantedTarget_z = getElementData(randomTarget,"posZ")
		WantedTarget_zonename = getZoneName(WantedTarget_x, WantedTarget_y, WantedTarget_z)
	end	
	
	showQuestWindow ( "Sheriff Gruber", "Here's your brief: the wanted fellon is "..WantedTarget_name..", a bandit gang leader located in "..WantedTarget_zonename..". He's armed and dangerous, and most likely not alone. Bring him to justice! Long live the Free County of Red!", 
		"I'm on it!", "setupsheriffGruber()", 
		"Can't do it..", "cleanupsheriffGruber()",
		"0", " ", 		
		"0", " " )

end

function sheriffGruber_Q()
showQuestWindow ( "Sheriff Gruber", "How would you like to deliver justice to some bandits? The Free County of Red pays bounties for some particularly dangerous bandit gang leaders. What do you say?", 
		"Tell me more!", "sheriffGruberInfo()", 
		"I'll take one!", "sheriffGruber_brief()",
		"Nevermind", " ", 		
		"0", " " )
end

--RR Jenkins, Panopticon

function montgomeryBanditRaid_Q()
showQuestWindow ( "Morris", "You arrived here just in time, brother! I'm looking for someone tough - or crazy - enough to go teach those bandits in Montgomery a lesson. Kill their leader Harlan and there's a reward for you.", 
		"Killing? That's what I'm good at.", "startMontgomeryBanditRaid('Kill bandit leader Harlan in Montgomery.')", 
		"This sounds dangerous...", "montgomeryBanditRaid_Info_Q()",
		"Oh? Nevermind!", " ", 		
		"0", " " )
end

function montgomeryBanditRaid_Info_Q()
showQuestWindow ( "Morris", "Oh, just make sure you're packin'! Montgomery splits our land in two like an ugly burn mark. Expect more than twenty bandits scattered around the place. Watch the rooftops and move slowly. Harlan should be in a stronghold somewhere north of town. Take him out!", 
		"Okay, I'm in", "startMontgomeryBanditRaid('Kill bandit leader Harlan in Montgomery.')", 
		"Nevermind", " ",
		"0", " ", 		
		"0", " " )
end

--Starting quest, LS beach sewer pipe

function startingQuest_mainQ()
showQuestWindow ( "Old Scavenger", "Oh, you sure look better now, sir! We took you for dead and were about to check your pockets, you gave us a good scare. Hope you are not angry - dunno' if you heard but life's hard around here... After all, we could have left you lying there for the zeds to munch on.", 
		"Wait, what? Who am I? Where...", "startQ_cheesy_Q()", 
		"Tell me something useful instead", "startQ_goodbye_Q()",
		"Nevermind", " ", 		
		"0", " " )
end

function startQ_cheesy_Q()
showQuestWindow ( "Old Scavenger", "Oh, shut up! Are you going to claim amnesia now? I feel like I've seen this before... How the hell would I know who you are? We just found you face down in the sand and dragged you here. Looks like you banged your head pretty good though... This place is fucked up so bad anyway, that sometimes I wish I had amnesia too.", 
		"This place? What do you mean?", "startQ_info_Q()", 
		"I'll be going now", "startQ_goodbye_Q()",
		"0", " ", 		
		"0", " " )
end

function startQ_info_Q()
showQuestWindow ( "Old Scavenger", "You kiddin' me? This place is San Andreas deep to it's knees in blood, son! The walkers will grab you by the throat the moment you get out of this damn pipe... matter of fact I can already hear them. Bandits and looters are gonna get your hard earned shit whenever you leave your guard down,...", 
		"But...", "startQ_info2_Q()", 
		"Nevermind", " ",
		"0", " ", 		
		"0", " " )
end

function startQ_info2_Q()
showQuestWindow ( "Old Scavenger", " ...hungry raiders will grab on your carcass more often than the zeddos and on top of that the Establishment bombs us every other day! How's that now for 'bad'? Did I mention starvation, slavers and the earthquakes? You'd wish we'd left you on that beach!", 
		"So umm... what should I do now?", "startQ_goodbye_Q()", 
		"I heard enough", " ",
		"0", " ", 		
		"0", " " )
end

function startQ_goodbye_Q()
showQuestWindow ( "Old Scavenger", "I can tell you one thing - you can't stay here. Gets crowded, and crowds attract unwanted attention. I've seen a scavenger group nearby, at the blue apartment complex across the basketball field. They are probably from one of the scav camps around Los Santos. Go and talk with them, maybe they'll agree to take you along.", 
		"Sounds like my best option", "startQ_okImGoin_Q()", 
		"I'd rather avoid them", " ",
		"0", " ", 		
		"0", " " )
end

function startQ_okImGoin_Q()
showQuestWindow ( "Old Scavenger", "You do that, but keep your wits with you - survivors can be dangerous men in some circumstances. Not all of us are good guys, and for sure none of us are noble. Some people would stab you in your sleep, hehe... Take good care!\n\n[ HINT: Press [O] to check your mission info in the character panel ]", 
		"OK, I'll remember that", "meetEllis_mission('Go and meet the scavengers that the old scavenger seen in Temple.')", 
		"Hm, forget it", " ",
		"0", " ", 		
		"0", " " )
end

--Ellis, scavenger scout from Rinkeville

function meetEllisQuest_mainQ()
showQuestWindow ( "Ellis", "This place is taken, move along... We don't need another pair of hands looting around here!", 
		"Just some questions...", "Ellis_questions_Q()", 
		"Oh, okay then", " ",
		"0", " ", 		
		"0", " " )
end

function Ellis_What_Q()
showQuestWindow ( "Ellis", "We're a scavenging party from Rinkeville. We're here looking for wire from the grid station nearby, but there's thugs gathering there so we lay low until they are gone. Don't wanna make a fuss if there's no need, if you know what I mean.", 
		"Can I ask...", "Ellis_questions_Q()", 
		"0", " ",
		"0", " ",
		"0", " ")
end

function Ellis_Where_Q()
showQuestWindow ( "Ellis", "What do you mean? Go break some boxes like everybody else, or try your luck hunting. Search in the obvious places. If you have good reputation with a faction, traders will sell some to you, and I heard that the Establishment gives a soup per day to all refugees. Thirst should concern you more.", 
		"One more question...", "Ellis_questions_Q()", 
		"0", " ",
		"0", " ",
		"0", " ")
end

function Ellis_Where2_Q()
showQuestWindow ( "Ellis", "Rinkeville is a good place, but there are many other camps around. I use my map to find them and you should do the same. You'll find many people around, but stay sharp! Plenty of murderous bastards...\n\n[ HINT: Press M to open your map (needs to be equipped) ]", 
		"Another question...", "Ellis_questions_Q()", 
		"How do I find Rinkeville?", "Ellis_findRinkeville_Q()",
		"0", " ",
		"0", " ")
end

function Ellis_findRinkeville_Q()
showQuestWindow ( "Ellis", "Good call! We may find a use for you there. You'll find the camp in Jefferson, near the train tracks. Hell, maybe you can even fix that damn train for Bugs so he stops talking about it! When you get there, tell Jesus that we're home by tommorow night.", 
		"Thanks, on my way!", "findRinkeville_mission('Find Rinkeville')", 
		"Nah, changed my mind...", " ",
		"0", " ",
		"0", " ")
end

function Ellis_questions_Q()
showQuestWindow ( "Ellis", "Information doesn't come free, but you seem lost so I'll make just another exception. What do you want to know? But don't ask too many questions! I'd rather spend my time staring at this blue wall than waste it on zed bait like you.", 
		"Where can I find food?", "Ellis_Where_Q()",
		"What are you doing here?", "Ellis_What_Q()",
		"Where can I find people?", "Ellis_Where2_Q()",
		"0", " ")
end

--Jesus, camp boss in Rinkeville

local Jesus_mission_status = 0

function Jesus_Q(ped)
	if Jesus_mission_status == 0 then
		showQuestWindow ( "Jesus", "I haven't seen your face before.. But maybe it's better this way. I need a determined individual to go to the County General Hospital and get me a crate of Detaxiline. I'm paying 400$ for it!", 
				"Hm, I'll take a look!", "Start_Jesus_Q('Retrieve the Detaxiline crate from County General Hospital for Jesus - 400$')", 
				"Nah, don't think so", " ",
				"0", " ", 		
				"0", " " )
	elseif Jesus_mission_status == 1 then
		showQuestWindow ( "Jesus", "Have you found what I asked for? I have people here waiting for that meds. Please tell me you found them!", 
				"Yes, here they are!", "Jesus_win_Q()", 
				"Still working on it..", " ",
				"0", " ", 		
				"0", " " )
	elseif Jesus_mission_status == 2 then
		showQuestWindow ( "Jesus", "Did you fix the generator as I asked? Life here relies on electricity, we have to use powertools - not to mention the gate! It's like this since last month!", 
				"Yes, it's fine now!", "Jesus_win2_Q()", 
				"No, not yet..", " ",
				"0", " ", 		
				"0", " " )
	end
end

function Jesus_win_Q()
Jesus_mission_status = 0
currentMission = "None"

triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+400$")
triggerServerEvent("GiveReputation",localPlayer,400)

addPlayerExp(localPlayer,10)
outputStatusInfo("+10 XP",240,240,240 )
local karma = getElementData(localPlayer,"karma") or 0
setElementData(localPlayer,"karma",karma+3,true)
outputStatusInfo("+3 karma",240,240,240 )

end

function Start_Jesus_Q(newmission)
	if newmission == currentMission then 
		return 
	else 
		clearMissionData ()
		currentMission = newmission 
		outputDebugString(currentMission)
		outputDebugString("start Jesus")
	end
	
	if newmission == "Retrieve the Detaxiline crate from County General Hospital for Jesus - 400$" then 
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","the hospital","Retrieve the Detaxiline crate from County General Hospital for Jesus - 400$")
	JesusMedsCol = createColSphere(2018.5537109375, -1401.791015625, 26.46875,0.5)
	curr_mission_col = JesusMedsCol
	JesusMedsMarker = createMarker(2018.5537109375, -1401.791015625, 25.46875,"cylinder",1.5,100,200,200)
	addEventHandler("onClientColShapeHit", JesusMedsCol, JesusMedsMissionCheck)
	JesusMedsBlip = createBlip ( 2018.5537109375, -1401.791015625, 26.46875, 53, 2, 255, 255, 255, 255, 1, 500)
	curr_mission_item_obj = createObject(2912,2018.5537109375, -1401.791015625, 25.46875)
	setElementCollisionsEnabled(curr_mission_item_obj,false)
	curr_mission_blip = JesusMedsBlip
	curr_mission_marker = JesusMedsMarker
	setElementData(JesusMedsBlip, "blip.visibleOnScreen", true)
	end
	
end

function JesusMedsMissionCheck(hitElem)

	if hitElem == localPlayer then 

	triggerEvent("DrawQuestTitle",localPlayer,"\n\n\nYou found the Detaxiline!\nTake it back to Jesus and claim your reward"," "," ","no")
	removeEventHandler("onClientColShapeHit", JesusMedsCol, JesusMedsMissionCheck)
	currentMission = "You found the Detaxiline! Take it back to Jesus and claim your reward."
	destroyElement(JesusMedsBlip)
	destroyElement(JesusMedsCol)
	destroyElement(JesusMedsMarker)
	destroyElement(curr_mission_item_obj)
	current_mission_item = "Detaxiline Crate"
	Jesus_mission_status = 1
	
	end
	
end

--Mac, leader of Aldea Malvada
function Mac_mainQ()
showQuestWindow ( "Mac", "So, you found our safe camp!  We have rules around here, so be careful what you put your fingers on.. If you're looking to trade then our trader is downstairs, otherwise I might have a job for you.", 
		"I might be staying for a while", "Mac_job_Q()", 
		"Who are you?", "Mac_info_Q()",
		"I don't care", " ", 		
		"Job? What job?", "Mac_job_Q()" )
end

function Mac_job_Q()
showQuestWindow ( "Mac", "Oh, you may not think much of this place, but we call it 'home'. Anybody willing to help is welcome here - and we just happen to need a hand. We have a little too much zeds around than we'd like. Would you give them a shove out of the area for 400$?", 
		"OK, I'll do it", "Mac_start_Q()", 
		"Sounds too dangerous", " ",
		"0", " ", 		
		"0", " " )
end

function Mac_start_Q()
local currentMission = "Kill 10 Zombies in Aldea Malvada camp area."
start_Mac_currentMission(currentMission)
triggerEvent("DrawQuestTitle",localPlayer,"New mission:","claiming the hill","Kill 10 Zombies in Aldea Malvada area")
end

function Mac_info_Q()
showQuestWindow ( "Mac", "As you can see, I'm Mac and I take care of this little community. We holed up here pretty good after the Incident and we gathered quite a handful of people to help. Follow the rules and you can stay here, break them and we'll send you rolling to the Raiders downhill!", 
		"I see...", "Mac_mainQ()", 
		"0", " ",
		"0", " ", 		
		"0", " " )
end

-- Lou Harper, Verdant Meadows abandoned airstrip
function LouHarper_mainQ()
showQuestWindow ( "Lou Harper", "What are you doing here, snooping around my airport? Looking for a job, perhaps? We could use the help of a man just like you!",
		"What do you got?", "LouHarper_job_Q()", 
		"Who are you? And what is this place?", "LouHarper_info_Q()",
		"No, good bye!", " ", 		
		"0", " " )
end

function LouHarper_job_Q()
showQuestWindow ( "Lou Harper", "There's a Raiders nest in Snake Farm, at the end of the landing strip. They started a slave operation there a couple of weeks ago. Didn't made a move towards us yet, but Raiders are like cockroaches - when you see one, more will come later. Go there and make sure they're dead and we'll be grateful! (400$)",
		"OK, I'll do it", "LouHarper_start_Q()", 
		"No, this sounds dangerous", " ",
		"0", " ", 		
		"0", " " )
end

function LouHarper_info_Q()
showQuestWindow ( "Lou Harper", "I'm Lou, and I run this place... You may think that it's not much of an airport but it sees more air traffic than LV International nowadays, that's for sure!", 
		"I see...", "LouHarper_mainQ()", 
		"0", " ",
		"0", " ", 		
		"0", " " )
end

function LouHarper_start_Q()
local currentMission = "Go to the Snake Farm and kill the 4 Raiders there."
start_LouHarper_currentMission(currentMission)
triggerEvent("DrawQuestTitle",localPlayer,"New mission:","bashing snakes","Kill 4 Raiders located at The Snake Farm")
end

--Milton, history teacher, camp leader for Jefferson Motel

function Milton_Winthrop_mainQ()
if miltonStory == 0 then 
	showQuestWindow ( "Milton", "Hello, friend! Welcome to our very own Jefferson Motel! A sad and *hic* dry place, if you ask me... still the safest place around!", 
		"Who are you?", "Milton_Winthrop_info_Q()", 
		"What do you mean 'dry'?", "Milton_Winthrop_booze_Q()",
		"0", " ", 		
		"0", " " )
elseif miltonStory == 0.5 then
	showQuestWindow ( "Milton", "Just the man I *hic* wanted to see! So, tell me, did you find any liquor?", 
		"Yes, here it is!", "Milton_Winthrop_boozeCheck_Q()", 
		"No, not yet", " ",
		"0", " ", 		
		"0", " " )
elseif miltonStory == 1 then
	showQuestWindow ( "Milton", "Good to see you again! It so happens *hic* that I need your help again! We keep seeing Raiders around and people here are getting concerned. We're afraid we'll get eaten, we barely have enough men to fend the zeds! Go to the Dump Camp and ask Goldgrin for help! Watch out, he is a nasty fellow...(+100$)", 
		"Yes, I'll go", "Milton_GoToDump_currentMission('MiltonGoToDump')", 
		"No, I'm busy", " ",
		"0", " ", 		
		"0", " " )
elseif miltonStory == 2 then
	showQuestWindow ( "Milton", "Hello friend! I don't have anything *hic* else for you to do now, but check later and maybe I'll have some more work. Until then, feel safe and welcome here *hic* at our motel. Maybe look for Donna, tell her i sent you, hehe!", 
		"Okay, bye!", " ", 
		"Dirty old man!", " ",
		"0", " ", 		
		"0", " " )
end
end

function Milton_Winthrop_info_Q()
		showQuestWindow ( "Milton", "My name is Milton. I used to be a history teacher in *hic* Vice City, before this... Incident occured. I came to attend a conference and got trapped like everybody else! We fortified this motel here and people trusted me to *hic* lead them since the bad days started.", 
		"I see...", "Milton_Winthrop_mainQ()", 
		"Are you drunk?", "Milton_Winthrop_drunk_Q()", 
		"0", " ", 
		"0", " " )
end

function Milton_Winthrop_drunk_Q()
		showQuestWindow ( "Milton", "Oh my! *hic* A straight forward man! Well, I had indeed a sip, maybe two, but far from enough. *hic* This is where you might come in handy...", 
		"What do you need my help for?", "Milton_Winthrop_booze_Q()", 
		"0", " ", 
		"0", " ", 
		"0", " " )
end

function Milton_Winthrop_booze_Q()
		showQuestWindow ( "Milton", "I do *hic* need a certain item, kind sir. You see, I need booze to cope with this flesh eating, gun totting, merciless reality. If you were to bring me one bottle of alcohol, my life would get so much *hic* better.", 
		"I understand...", "Milton_Winthrop_confirm_Q()", 
		"0", " ", 
		"0", " ", 
		"0", " " )
end

function Milton_Winthrop_confirm_Q()
		showQuestWindow ( "Milton", "So will you *hic* help me?", 
		"Yeah, I'll help you", "Milton_Winthrop_yes_Q()", 
		"No, I don't think so", " ", 
		"0", " ", 
		"0", " " )
end

function Milton_Winthrop_accepted_Q()
triggerEvent("DrawQuestTitle",localPlayer,"New mission:","booze delivery","Bring an Alcohol Bottle to Milton")
local currentMission = "Bring a bottle of alcohol to Milton at Jefferson Motel."
start_Milton1_currentMission(currentMission)
end

function Milton_Winthrop_yes_Q()
		showQuestWindow ( "Milton", "I knew you are a kind and *hic* considerate fellow! I'll wait here for your return.", 
		"See ya' later then", "Milton_Winthrop_accepted_Q()", 
		"0", " ", 
		"0", " ", 
		"0", " " )
end


--missions to join the establishment from Trotter, Hopkins and Coleman in LS

function EstabAddmissionTargetZoneCheck (hitElem)
	if source == EstabAddmissionTargetZone and hitElem == localPlayer and currentMission == "Make your way to the Refugee Camp in Bone County" then
		--output shit for player
		triggerEvent("DrawQuestTitle",localPlayer,"You arrived at the Refugee Camp","mission completed!","Talk with the Medtech to continue")
		--triggerServerEvent("GiveReputation",localPlayer,50)		
		--destroy elements
		removeEventHandler("onClientColShapeHit",EstabAddmissionTargetZone,EstabAddmissionTargetZoneCheck)
		--miltonStory = 2
		destroyElement(EstabAddmissionTargetBlip)
		destroyElement(EstabAddmissionTargetZone)
		currentMission = "Talk to the Medtech"
	end
end

function goRef_StartQ(newMission)
if newMission == currentMission then return else clearMissionData(); currentMission = newMission end
	if newMission == "Make your way to the Refugee Camp in Bone County" then 
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","the long road","Make your way to the Refugee Camp admission point in Bone County")
	EstabAddmissionTargetZone = createColSphere(351.1357421875, 1788.3681640625, 17.835138320923,3.5) --posX="2796.6728515625" posY="-1946.2314453125" posZ="17.3203125" rotX="0" rotY="0" rotZ="35.7802734375"
	addEventHandler("onClientColShapeHit",resourceRoot, EstabAddmissionTargetZoneCheck)
	EstabAddmissionTargetBlip = createBlip ( 351.1357421875, 1788.3681640625, 17.835138320923, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(EstabAddmissionTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = EstabAddmissionTargetZone
	curr_mission_blip = EstabAddmissionTargetBlip 
	end
end

function go_Ref_Q(name)
		if not name then name = " " end
		showQuestWindow ( name, "You're a new face! Good, maybe you're not as dumb as the others. Say, what are you looking for in this part of the shithole that San Andreas became? Because you'll sure not find it here. But I just might know where you *can* find it...", 
		"What do you mean?", "goRef_info_Q()",
		"None of your bussiness...", "refQ_negative_answer()",		
		"0", " ", 
		"0", " " )
end

function goRef_dangerous()
		showQuestWindow ( " ", "There's a long hard road to the camp. I need to plan ahead, find a vehicle and enough fuel, guns, ammo and food. There's lots of hostiles on the road, not to mention the infected! Driveways are blocked, bridges broken, tunnels collapsed - I could probably use a good Survivor Map. I'm simply not ready yet... But I'll get there eventually!", 
		"Aha..", "go_Ref_Q()", 
		"How do I get there?", "goRef_accept()", 
		"0", " ", 
		"0", " " )
end

function goRef_info_Q()
		showQuestWindow ( " ", "I mean the safe haven, pal! The place without monsters and cannibals that every remaining sane man dreams about! Well, I know just the place and I'm going there soon. The new Refugee Camp takes in all people! As long as you are not infected, the Establishment will take care of you, maybe even evac you to mainland.", 
		"I see..", "go_Ref_Q()", 
		"Why still here, then?", "goRef_dangerous()", 
		"0", " ", 
		"0", " " )
		
end

function refQ_negative_answer()
		showQuestWindow ( " ", "Oh, you're not the smartest of the lot either, are you? You'll come to regret it when the bandits will take your boots or raiders will split you open! Staying here is suicide, man! Why don't you people get it? Suit yourself, but I'm not that dumb!", 
		"Yeah, whatever...", " ", 
		"0", " ", 
		"0", " ", 
		"0", " " )
		
end

function goRef_accept()
		showQuestWindow ( " ", "Oh, you sound like you know what you're doing! Ignore all that laborious planning - an unexpected move. You are either brave or stupid... I'll mark the location for you - it's in Bone County on A69 grounds. But be warned: take this path unprepared and you will only meet your end!", 
		"On my way!", "goRef_StartQ('Make your way to the Refugee Camp in Bone County')", 
		"Changed my mind...", " ", 
		"0", " ", 
		"0", " " )
		
end
--CDF Recruiter

function CDF_Recruiter_mainQ()
		showQuestWindow ( "CDF Recruiter", "Listen up! The Civilian Defence Force is herenow recruiting all able men of good moral standing! You're ready to reclaim our land from Establishment's oppression? Then it's time to join the Free Folk and make a stand for what you believe in! Long live the Free County of Red!", 
		"Wait, who are you guys?", "CDF_join_info_Q()",
		"Hell yeah!", "CDF_join_yes_Q()",		
		"What's in it for me?", "CDF_join_pay_Q()", 
		"I don't think so...", "CDF_join_no_Q()" )
end

function CDF_join_yes_Q()
		showQuestWindow ( "CDF Recruiter", "Good! Welcome to our ranks, brother! We need immediate reinforcements on our Los Santos front: head to Mulholland and report to Bo Freemantle. There you'll get your next assignment.", 
		"I'm on my way!", "CDF_join_find_Bo_Freemantle_Q('Find Bo Freemantle in Mulholland, LS')", 
		"0", " ", 
		"0", " ", 
		"0", " " )
		
end

function CDF_join_info_Q()
		showQuestWindow ( "CDF Recruiter", "Never heard of the CDF, right? Are you kidding me?! We are the last free men in San Andreas, and we're here to stay! The Free County of Red is home to all of us and Aaron Freemantle will bring us victory!", 
		"I see..", "CDF_Recruiter_mainQ()", 
		"0", " ", 
		"0", " ", 
		"0", " " )
		
end

function CDF_join_pay_Q()
		showQuestWindow ( "CDF Recruiter", "We take good care of our people. We provide food, warmth and friends - you also get to shove it to the Establishment. What else? You a junkie? *looks suspiciously* We don't like that synthetic gunk around, so don't even ask! We're keepin' Red pure, brother!", 
		"I see...", "CDF_Recruiter_mainQ()", 
		"0", " ", 
		"0", " ", 
		"0", " " )
		
end

function CDF_join_no_Q()
		showQuestWindow ( "CDF Recruiter", "Oh, you're not the smartest of the lot, are you? Suit yourself, but you'll come to regret it when the Establishment gonna' snatch you and shove you in their shitholes or when the bandits will take your boots!", 
		"Yeah, whatever...", " ", 
		"0", " ", 
		"0", " ", 
		"0", " " )
		
end

--Derrik, bandit boxing handler in LV
function Derrik_mainQ()
showQuestWindow ( "Derrik", "Looking for a fight, son? You found the right place!", 
		"Huh?", "Derrik_info_Q()", 
		"Cool, I'm in", "Derrik_fight_Q()",
		"No, sir", " ", 		
		"Fuck off, old man!", "Derrik_fight_Q()" )
end

function Derrik_info_Q()
showQuestWindow ( "Derrik", "A fight, what don't you get? The primordial game, sweat and blood, melee fighting - a good skill to have these days, by the way. You can also earn some money for yourself in the ring! So, what do you say?", 
		"Huh?", "Derrik_mainQ()", 
		"Yes, I'm in", "Derrik_fight_Q()",
		"No, not for me", " ", 		
		"Oh, shut it already!", "Derrik_fight_Q()" )
end

function Derrik_fight_Q()
triggerEvent("DrawQuestTitle",localPlayer,"Match set!","Get ready","Wait 10 seconds for an opponent...")
triggerServerEvent("PutPlayerInLVRing",localPlayer)
end

-- LV boxing bookie
function LVBookie_mainQ()
showQuestWindow ( "Bookie", "You want to bet on the next fight? Winning bets is a quick way to earn money... or loose it!", 
		"What?", "LVBookie_infoQ()", 
		"I'll bet on Red!", "LVRedBet()",
		"I'll bet on Blue!", "LVBlueBet()", 		
		"No, not for me", " " )
end

function LVBookie_infoQ()
showQuestWindow ( "Bookie", "What don't you get? You put 25$ on either Red or Blue. If your fighter wins you earn double. So, what are you waiting for?", 
		"Aham, I got it", "LVBookie_mainQ()", 
		"0", " ",
		"0", " ", 		
		"0", " " )
end

function LVBetFail()
showQuestWindow ( "Bookie", "Hey, what the fuck are you doin' here, wasting my time?! Get lost and come back when you have some money to bet on!", 
		"OK", " ", 
		"0", " ",
		"0", " ", 		
		"0", " " )
end

function LVRedBet()
local money = getPlayerMoney(localPlayer)
if (money > 24) then
triggerServerEvent("onRedBetPlaced",localPlayer)
triggerEvent("DrawQuestTitle",localPlayer,"Your bet:","25$","on the Red fighter")
else
LVBetFail()
end
end

function LVBlueBet()
local money = getPlayerMoney(localPlayer)
if (money > 24) then
triggerServerEvent("onBlueBetPlaced",localPlayer)
triggerEvent("DrawQuestTitle",localPlayer,"Your bet:","25$","on the Blue fighter")
else
LVBetFail()
end
end

--Cousin Saltmeat, raider fight handler
function RaiderArena_mainQ()
showQuestWindow ( "Cousin Saltmeat", "Aaaargh, brother! The smell of blood finally brought you down here. Are you ready to prove yourself in the Cage?", 
		"Cage? What cage?", "RaiderArena_info_Q()", 
		"Yeah, open the gates of hell!", "RaiderArena_fight_Q()",
		"Not now", " ", 		
		"0", " " )
end

function RaiderArena_info_Q()
showQuestWindow ( "Cousin Saltmeat", "Are you blind or stupid? I thought the Cage is big enough not to miss. You go in and you fight against whatever I throw at you! Survive and show everyone you're worth your salt or die and we eat well tonight!", 
		"Huh?", "RaiderArena_mainQ()", 
		"My kind of thing...", "RaiderArena_fight_Q()",
		"Hm, not for me", " ", 		
		"0", " " )
end

function RaiderArena_fight_Q()
triggerEvent("DrawQuestTitle",localPlayer,"Fight set!","Get ready","Wait 10 seconds for an opponent...")
triggerServerEvent("PutPlayerInQuarryRing",localPlayer)
end

-- Raider bookie
function RaiderArenaBookie_mainQ()
showQuestWindow ( "Bookie", "Wanna bet on the next fight? Winning bets is a quick way to earn money... or loose it!", 
		"Tell me more", "RaiderArenaBookie_infoQ()", 
		"25$ on Red!", "RaiderArenaRedBet()",
		"25$ on Blue!", "RaiderArenaBlueBet()", 		
		"Not for me", " " )
end

function RaiderArenaBookie_infoQ()
showQuestWindow ( "Bookie", "It's not hard to understand, even for a gunkbrain like you: bet 25$ on either Red or Blue. If your fighter wins, you get 50$ in return. If he looses then fuck you, come again. So, got any money?", 
		"I got it", "RaiderArenaBookie_mainQ()", 
		"0", " ",
		"0", " ", 		
		"0", " " )
end

function RaiderArenaBetFail()
showQuestWindow ( "Bookie", "You have a death wish, gunkbrain?! Fuck off and come back only when you have some money to bet on!", 
		"Oh...", " ", 
		"0", " ",
		"0", " ", 		
		"0", " " )
end

function RaiderArenaRedBet()
local money = getPlayerMoney(localPlayer)
if (money > 24) then
triggerServerEvent("quarryOnRedBetPlaced",localPlayer)
triggerEvent("DrawQuestTitle",localPlayer,"Your bet:","25$","on the Red fighter")
else
RaiderArenaBetFail()
end
end

function RaiderArenaBlueBet()
local money = getPlayerMoney(localPlayer)
if (money > 24) then
triggerServerEvent("quarryOnBlueBetPlaced",localPlayer)
triggerEvent("DrawQuestTitle",localPlayer,"Your bet:","25$","on the Blue fighter")
else
RaiderArenaBetFail()
end
end

 function mechanicRepair()
	
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local base_repairs_cost = 100
	local part_cost = 10
	local repairs_cost 
	local money = getPlayerMoney(localPlayer)
	local vhealth = getElementHealth(vehicle)
	local repairtime = ((1000 - vhealth)*10)+4000
	local damagedparts = assessVehicleCondition_c(vehicle)
	
	repairs_cost = base_repairs_cost + damagedparts*part_cost
	
	 if money<repairs_cost then
		outputInteractInfo("[ you can't afford it! ]",255,50,0)
		 if isCursorShowing() then showCursor(false) end
		return 
	 end
	
	 setElementFrozen(vehicle,true)
	 dxProgressBar(repairtime, repairtime)
	 outputStatusInfo("[ repairing... ]",240,240,240)
	 setPlayerMoney(money - repairs_cost)
	 
	 setTimer( function() 
		 fixVehicle(vehicle)
		 setVehicleWheelStates(vehicle,0,0,0,0) 
		 outputInteractInfo("[ vehicle repaired ]",50,255,50)
		 setElementData(vehicle, "repaired", true,true)
		 setElementData(vehicle, "vehicle_disabled", false, true)
		 dxKillProgressBar()
		 setElementFrozen(vehicle,false)
	 end, repairtime, 1) 
	 
	 if isCursorShowing() then showCursor(false) end
	 
 end

 local body_cost = 400
 local wheels_hyd = 250
 local nitro_cost = 200
 local weaponize_cost = 450
 
 --upgrades
 --1009 - nitroX2
 --1025 - offroad wheels
 --1087 - hydraulics
 
 upgradable_vehicles_ids = {
 
 [489] = 400, --rancher to landstalker
 [482] = 440, --burrito to rumpo
 [558] = 541, --uranus to bullet
 [426] = 602, --premier to alpha
 [600] = 401, --picador
 [518] = 496, --bucaneer
 [479] = 527, --regina
 [580] = 575, --stafford
 [542] = 445, --clover
 [422] = 589, --bobcat
 [466] = 504, --glendale
 
 }
 upgradable_vehicles_setups = {
 
 [545] = "Raider Lurker", --hustler
 [549] = "Roadwarrior", --tampa
 
 }
 denied_wheels_vehicles = {[400] = true}
 
 
 function installNitro()

 local vehicle = getPedOccupiedVehicle(localPlayer)
 local money = getPlayerMoney(localPlayer)
 local upgrade_time = 2000	 
	 if money<nitro_cost then
		outputInteractInfo("[ you can't afford it! ]",255,50,0)
		if isCursorShowing() then showCursor(false) end
		return 
	 end
	 
	 setElementFrozen(vehicle,true)
	 dxProgressBar(upgrade_time, upgrade_time)
	 outputStatusInfo("[ upgrading... ]",240,240,240)
	 setPlayerMoney(money - nitro_cost)
	 
	 setTimer( function()
	 addVehicleUpgrade(vehicle, 1009) --nitroX2
	 dxKillProgressBar()
	 setElementFrozen(vehicle,false)
	 outputInteractInfo("[ upgrade installed ]",240,240,240)
	 end, upgrade_time, 1)
 
 end
 
 function installWheelsAndHydraulics()

 local vehicle = getPedOccupiedVehicle(localPlayer)
 local money = getPlayerMoney(localPlayer)
 local upgrade_time = 3000	 
 local upgrade_cost = wheels_hyd
 
	 if money<upgrade_cost then
		outputInteractInfo("[ you can't afford it! ]",255,50,0)
		if isCursorShowing() then showCursor(false) end
		return 
	 end
	 
	 local vehicle_model = getElementModel(vehicle)
	
	local wheels_compat = true
	
	if denied_wheels_vehicles[vehicle_model] then 
		outputInteractInfo("[ wheels not compatible! ]",255,50,0)
		upgrade_cost = 150
		wheels_compat = false
	 end
	 
	 setElementFrozen(vehicle,true)
	 dxProgressBar(upgrade_time, upgrade_time)
	 outputStatusInfo("[ upgrading... ]",240,240,240)
	 setPlayerMoney(money - wheels_hyd)
	 
	 setTimer( function()
	 if wheels_compat then
		addVehicleUpgrade(vehicle, 1025) --offr wheels
	 end
	 addVehicleUpgrade(vehicle, 1087) --hydr
	 dxKillProgressBar()
	 setElementFrozen(vehicle,false)
	 outputInteractInfo("[ upgrades installed ]",240,240,240)
	 end, upgrade_time, 1)
 
 end
 
 function upgradeCarBody()

 local vehicle = getPedOccupiedVehicle(localPlayer)
 local money = getPlayerMoney(localPlayer)
 local upgrade_time = 7000	 
	 
	 local vehicle_model = getElementModel(vehicle)
	 local upgrade_model
	 
	 if upgradable_vehicles_ids[vehicle_model] then
		upgrade_model = upgradable_vehicles_ids[vehicle_model]
	elseif	upgradable_vehicles_setups[vehicle_model] then
		upgrade_model = upgradable_vehicles_setups[vehicle_model]
	else
		upgrade_model = false
		outputInteractInfo("[ this vehicle can't be upgraded ]",255,50,0)
		return
	end
	
	if money<body_cost then
		outputInteractInfo("[ you can't afford it! ]",255,50,0)
		--if isCursorShowing() then showCursor(false) end
		return 
	 end
	 
	 setElementFrozen(vehicle,true)
	 dxProgressBar(upgrade_time, upgrade_time)
	 outputStatusInfo("[ upgrading... ]",240,240,240)
	 setPlayerMoney(money - body_cost)
	 
	 setTimer( function()
		 if type(upgrade_model) == "number" then --it's a model replacement
			setElementModel(vehicle,upgrade_model)
		 elseif type(upgrade_model) == "string" then --it's an attachments job
		 
		 end
		 dxKillProgressBar()
		 setElementFrozen(vehicle,false)
		 outputInteractInfo("[ vehicle upgraded ]",240,240,240)
	 end, upgrade_time, 1)
 
 end 
 
 function mechanicUpgradeDialogue()

	showQuestWindow ( "Mechanic", "Oh, so you're after performance? Well, not many upgrades I can offer, my suppliers never return my calls lately. Take your pick!", 
			"Upgrade the body ("..body_cost.."$)", "upgradeCarBody()", 
			"Wheels and hydraulics ("..wheels_hyd.."$)", "installWheelsAndHydraulics()",
			"Install nitro ("..nitro_cost.."$)", "installNitro()", 		
			"Nevermind", " " )
			---- LARGER FUEL TANK; COLOR; GRENADE DROPPER; SEARCHLIGHT; HOMING MISSILE (WITH LASER TARGETING); SELF-INFLATABLE TIRES; EJECTING SEATS; EM SCANNER; TOWLINE (ADD A COLLISIONLESS TOWING TRUCK ATTACHED??)
end
 
 function mechanicRepairDialogue()

		local vehicle = getPedOccupiedVehicle(localPlayer)
		local base_repairs_cost = 100
		local part_cost = 10
		local repairs_cost
		local damagedparts = assessVehicleCondition_c(vehicle)
		local vhealth = getElementHealth(vehicle)
		
		repairs_cost = base_repairs_cost + damagedparts*part_cost
	
		local parts_line
		
		if damagedparts == 0 then 
			damagedparts = "no other" 
		end
		
		if type(damagedparts)== "number" and damagedparts > 0 then 
			parts_line = " I can replace the parts at "..part_cost.."$ each, that's another "..tostring(part_cost*damagedparts).."$. Grand total: "..tostring(100+part_cost*damagedparts).."$. "
		else 
			parts_line = " "
		end
		
	showQuestWindow ( "Mechanic", "Let's see... Basic engine repair goes for 100$, and there's "..damagedparts.." damaged parts."..parts_line.."I go ahead and repair it?", 
			"Yes, do it", "mechanicRepair()", 
			"And the upgrades?", "mechanicUpgradeDialogue()",
			"No, wait", "mechanicDialogueScav()", 		
			"Bye!", " " )
	
	
end
 
 function mechanicWeaponize()
 
 		local vehicle = getPedOccupiedVehicle(localPlayer)
		local cost = weaponize_cost
		local money = getPlayerMoney(localPlayer)
		local upgrade_time = 5000	 
		
		if money<cost then
		outputInteractInfo("[ you can't afford this! ]",255,50,0)
		return 
		end
		
	 setElementFrozen(vehicle,true)
	 dxProgressBar(upgrade_time, upgrade_time)
	 outputStatusInfo("[ upgrading... ]",240,240,240)
	 setPlayerMoney(money - cost)
	 
	 setTimer( function()
		 dxKillProgressBar()
		 setElementFrozen(vehicle,false)
		 triggerServerEvent("WeaponizeVehicle",localPlayer,getPedOccupiedVehicle(localPlayer))
		 --setElementData(vehicle,"smokeinstalled",true,true)
	 end, upgrade_time, 1)
		
 
 end
 
function mechanicDialogueScav()
--[[local team = getPlayerTeam(localPlayer)
local mech_team = getElementData(LS_mechanic_col,"BotTeam")
	
	if team ~= mech_team then 
		outputInteractInfo("[ you can't use this service! ]",255,50,0)
		return
	else]]
	showQuestWindow ( "Mechanic", "Hello there! Here we offer full services for your vehicle. Maintenance, repairs and upgrades, weapons thrown into the mix! What are you looking for?", 
			"Just need repairs", "mechanicRepairDialogue()", 
			"Upgrade my vehicle", "mechanicUpgradeDialogue()",
			"Weaponize it!", "mechanicWeaponize()", 		
			"Nevermind", " " )
	--end
	
end
