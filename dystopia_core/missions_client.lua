mainMission = nil
currentMission = "None"

raidersKilled = 0
lootersKilled = 0
scavsKilled = 0
CDFKilled = 0
estabKilled = 0
banditsKilled = 0
zombiesKilled = 0
HarlanKilled = 0

miltonStory = 0
mingStory = 0
macStory = 0

missionBlip = nil
playerTargetCol = nil
playerTargetPedName = nil

function startMontgomeryBanditRaid(newMission)
if newMission == currentMission then return else clearMissionData(); currentMission = newMission end
	if newMission == "Kill bandit leader Harlan in Montgomery." then 
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","bandit town","Locate and kill Harlan in Montgomery (+400$)")
	HarlanTargetZone = createColSphere(1298.087890625, 371.7802734375, 29.829942703247,400)
	addEventHandler("onClientPedWasted",root,HarlanMissionCheckKill)
	HarlanTargetBlip = createBlip ( 1298.087890625, 371.7802734375, 29.829942703247, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(HarlanTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = HarlanTargetZone
	curr_mission_blip = HarlanTargetBlip
	end
end

function HarlanMissionCheckKill (killer,weapon)

	local name = getElementData(source,"name")
	local x,y,z = getElementPosition(source)

	if name == "Harlan" and isElementWithinColShape(source,HarlanTargetZone) then 
	HarlanKilled = HarlanKilled+1 
	outputDebugString("Harlan was killed")
	end

	if HarlanKilled >= 1 then 
	HarlanKillMissionWin() 
	end
end

function HarlanKillMissionWin ()
HarlanKilled = 0
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+400$")
triggerServerEvent("GiveReputation",localPlayer,400)
removeEventHandler("onClientPedWasted",root,HarlanMissionCheckKill)
currentMission = "None"
destroyElement(HarlanTargetZone)
destroyElement(HarlanTargetBlip)
HarlanTargetBlip = nil
HarlanTargetZone = nil
end

function LouHarperMissionWin ()
raidersKilled = 0
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+400$")
triggerServerEvent("GiveReputation",localPlayer,400)
local karma = getElementData(localPlayer,"karma") or 0
setElementData(localPlayer,"karma",karma+5)
outputStatusInfo("+5 karma",240,240,240 )
addPlayerExp(localPlayer,10)
outputStatusInfo("+10 XP",240,240,240 )
removeEventHandler("onClientPedWasted",root,LouHarperMissionCheckKill)
currentMission = "None"
destroyElement(louHarperTargetZone)
destroyElement(louHarperTargetBlip)
louHarperTargetBlip = nil
louHarperTargetZone = nil
end

function LouHarperMissionCheckKill (killer,weapon)

	local israider = getElementData(source,"raider")
	--local x,y,z = getElementPosition(source)

	if israider and isElementWithinColShape(source,louHarperTargetZone) then 
	raidersKilled = raidersKilled+1 
	outputDebugString("A raider was killed")
	end

	if raidersKilled >= 4 then 
	LouHarperMissionWin() 
	end
end

function start_LouHarper_currentMission(newMission)
if newMission == currentMission then return else clearMissionData(); currentMission = newMission end
	if newMission == "Go to the Snake Farm and kill the 4 Raiders there." then 
	louHarperTargetZone = createColSphere(-23.3349609375, 2338.5263671875, 24.140625,200)
	addEventHandler("onClientPedWasted",root,LouHarperMissionCheckKill)
	louHarperTargetBlip = createBlip ( -23.3349609375, 2338.5263671875, 24.140625, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(louHarperTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = louHarperTargetZone
	curr_mission_blip = louHarperTargetBlip
	end
end


function MacMissionWin ()
zombiesKilled = 0
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+400$")
triggerServerEvent("GiveReputation",localPlayer,400)
local karma = getElementData(localPlayer,"karma") or 0
setElementData(localPlayer,"karma",karma+10)
outputStatusInfo("+10 karma",240,240,240 )
addPlayerExp(localPlayer,10)
outputStatusInfo("+10 XP",240,240,240 )
removeEventHandler("onClientPedWasted",root,MacMissionCheckKill)
currentMission = "None"
destroyElement(MacTargetZone)
destroyElement(MacTargetBlip)
MacTargetBlip = nil
MacTargetZone = nil
clearMissionData()
end

function MacMissionCheckKill (killer,weapon)

	local zed = getElementData(source,"zombie")
	local x,y,z = getElementPosition(source)

	if zed == true and isElementWithinColShape(source, MacTargetZone) then 
	zombiesKilled = zombiesKilled+1 
	outputDebugString("A zed was killed")
	end

	if zombiesKilled >= 10 then 
	MacMissionWin() 
	end
end

function start_Mac_currentMission(newMission)
if newMission == currentMission then return else clearMissionData(); currentMission = newMission end
	if newMission == "Kill 10 Zombies in Aldea Malvada camp area." then 
	MacTargetZone = createColSphere(-1300.6943359375, 2511.251953125, 87.02254486084,200)
	addEventHandler("onClientPedWasted",root,MacMissionCheckKill)
	MacTargetBlip = createBlip ( -1300.6943359375, 2511.251953125, 87.02254486084, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(MacTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = MacTargetZone
	curr_mission_blip = MacTargetBlip
	end
end


function MiltonGoToDumpCheck (hitElem)
	if source == MiltonGoToDumpTargetZone and hitElem == localPlayer and currentMission == "MiltonGoToDump" then
		--output shit for player
		triggerEvent("DrawQuestTitle",localPlayer,"You found Goldgrin!","mission completed!","+100$")
		triggerServerEvent("GiveReputation",localPlayer,100)		
		--destroy elements
		removeEventHandler("onClientColShapeHit",MiltonGoToDumpTargetZone,MiltonGoToDumpCheck)
		miltonStory = 2
		destroyElement(MiltonGoToDumpTargetBlip)
		destroyElement(MiltonGoToDumpTargetZone)
		currentMission = "None"
	end
end
 
function Milton_GoToDump_currentMission(newMission)
if newMission == currentMission then return else clearMissionData(); currentMission = newMission end
	if newMission == "MiltonGoToDump" then 
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","the hood","Go to the Dump Camp and meet Goldgrin")
	MiltonGoToDumpTargetZone = createColSphere(2589.6006,-1138.5996,68,3)
	addEventHandler("onClientColShapeHit",resourceRoot,MiltonGoToDumpCheck)
	MiltonGoToDumpTargetBlip = createBlip ( 2589.6006,-1138.5996,68, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(MiltonGoToDumpTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = MiltonGoToDumpTargetZone
	curr_mission_blip = MiltonGoToDumpTargetBlip 
	end
end

function Milton_Winthrop_boozeCheck_Q()
if hasPlayerItem_c ("Alcohol Bottle", localPlayer) then
local count, slot = hasPlayerItem_c ("Alcohol Bottle", localPlayer)
triggerServerEvent("RemoveItemInSync",localPlayer,slot)
outputTopBar("You give Alcohol Bottle to Milton",240,240,240)
triggerEvent("DrawQuestTitle",localPlayer,"Good job!","mission completed!","+100$")
triggerServerEvent("GiveReputation",localPlayer,100)
destroyElement(MiltonTargetBlip)
miltonStory = 1
else
showQuestWindow ( "Milton", "I don't *hic* have time for this nonsense! Come back when you did what I asked!", 
		"Oh..", " ", 
		"0", " ",
		"0", " ", 		
		"0", " " )
end
end

function start_Milton1_currentMission(newMission)
--if newMission == currentMission then return else newMission = currentMission end
if newMission == currentMission then return else clearMissionData(); currentMission = newMission end
if miltonStory == 0 then miltonStory = 0.5 end
	if newMission == "Bring a bottle of alcohol to Milton at Jefferson Motel." then 
	--MacTargetZone = createColSphere(-1300.6943359375, 2511.251953125, 87.02254486084,200)
	--addEventHandler("onClientPedWasted",root,MacMissionCheckKill)
	MiltonTargetBlip = createBlip ( 2228.7,-1174.7,25.7, 41, 2, 255, 255, 255, 255, 1, 500)
	setElementData(MiltonTargetBlip, "blip.visibleOnScreen", true)

	curr_mission_blip = MiltonTargetBlip 
	--miltonStory = 0.5
	end
end


function EllisTargetZoneCheck (hitElem)
	if source == EllisTargetZone and hitElem == localPlayer and currentMission == "Go and meet the scavengers that the old scavenger seen in Temple." then
		--output shit for player
		triggerEvent("DrawQuestTitle",localPlayer,"You found the scavs!","mission completed!","Speak with Ellis to continue")
		triggerServerEvent("GiveReputation",localPlayer,50)		
		--destroy elements
		removeEventHandler("onClientColShapeHit",EllisTargetZone,EllisTargetZoneCheck)
		--miltonStory = 2
		destroyElement(EllisTargetZoneTargetBlip)
		destroyElement(EllisTargetZone)
		currentMission = "None"
	end
end


function meetEllis_mission(newMission)
if newMission == currentMission then return else clearMissionData(); currentMission = newMission end
	if newMission == "Go and meet the scavengers that the old scavenger seen in Temple." then 
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","scavs","Follow the marker to meet the scavs")
	EllisTargetZone = createColSphere(2796.6728515625,-1946.2314453125,17.3203125,3) --posX="2796.6728515625" posY="-1946.2314453125" posZ="17.3203125" rotX="0" rotY="0" rotZ="35.7802734375"
	addEventHandler("onClientColShapeHit",resourceRoot, EllisTargetZoneCheck)
	EllisTargetZoneTargetBlip = createBlip ( 2796.6728515625,-1946.2314453125,17.3203125, 58, 2, 255, 255, 255, 255, 1, 500)
	setElementData(EllisTargetZoneTargetBlip, "blip.visibleOnScreen", true)
	end
end


function JesusTargetZoneCheck (hitElem)
	if source == JesusTargetZone and hitElem == localPlayer and currentMission == "Find Rinkeville" then
		--output shit for player
		triggerEvent("DrawQuestTitle",localPlayer,"You found Rinkeville","mission completed!","Talk with Jesus or explore the camp")
		--triggerServerEvent("GiveReputation",localPlayer,50)		
		--destroy elements
		removeEventHandler("onClientColShapeHit",JesusTargetZone,JesusTargetZoneCheck)
		--miltonStory = 2
		destroyElement(JesusTargetZoneTargetBlip)
		destroyElement(JesusTargetZone)
		currentMission = "None"
	end
end

function findRinkeville_mission(newMission)
if newMission == currentMission then return else clearMissionData(); currentMission = newMission end
	if newMission == "Find Rinkeville" then 
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","safe haven","Go to Rinkeville and find Jesus")
	JesusTargetZone = createColSphere(2246.7475585938, -1445.9299316406, 24.302925109863,3) --posX="2796.6728515625" posY="-1946.2314453125" posZ="17.3203125" rotX="0" rotY="0" rotZ="35.7802734375"
	addEventHandler("onClientColShapeHit",resourceRoot, JesusTargetZoneCheck)
	JesusTargetZoneTargetBlip = createBlip ( 2246.7475585938, -1445.9299316406, 24.302925109863, 58, 2, 255, 255, 255, 255, 1, 500)
	setElementData(JesusTargetZoneTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = JesusTargetZone
	curr_mission_blip = JesusTargetZoneTargetBlip 
	end
end


function MikeFreemantleZoneCheck (hitElem)
	if source == MikeFreemantleTargetZone and hitElem == localPlayer and currentMission == "Report to Mike Freemantle" then
		--output shit for player
		triggerEvent("DrawQuestTitle",localPlayer,"Well done","mission completed!","You found Mike Freemantle")
		triggerServerEvent("GiveReputation",localPlayer,50)		
		--destroy elements
		removeEventHandler("onClientColShapeHit",MikeFreemantleTargetZone,MikeFreemantleTargetZoneCheck)
		--miltonStory = 2
		destroyElement(MikeFreemantleZoneTargetBlip)
		destroyElement(MikeFreemantleTargetZone)
		currentMission = "None"
	end
end

function CDF_find_MikeFreemantle_Q(newMission)
if newMission == currentMission then return else clearMissionData(); currentMission = newMission end
	if newMission == "Report to Mike Freemantle" then 
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","the family","Go to Dillimore and report to Mike Freemantle")
	MikeFreemantleTargetZone = createColSphere(612.7002, -609.2002, 17.2,3) --posX="2796.6728515625" posY="-1946.2314453125" posZ="17.3203125" rotX="0" rotY="0" rotZ="35.7802734375"
	addEventHandler("onClientColShapeHit",resourceRoot, MikeFreemantleZoneCheck)
	MikeFreemantleZoneTargetBlip = createBlip ( 612.7002, -609.2002, 17.2, 61, 2, 255, 255, 255, 255, 1, 500)
	setElementData(MikeFreemantleZoneTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = MikeFreemantleTargetZone
	curr_mission_blip = MikeFreemantleZoneTargetBlip 
	end
end

function BoFreemantleZoneCheck (hitElem)
	if source == BoFreemantleTargetZone and hitElem == localPlayer and currentMission == "Find Bo Freemantle in Mulholland, LS" then

		triggerEvent("DrawQuestTitle",localPlayer,"Well done","mission completed!","You found Bo Freemantle")
		triggerServerEvent("GiveReputation",localPlayer,50)		

		removeEventHandler("onClientColShapeHit",BoFreemantleTargetZone,BoFreemantleZoneCheck)

		destroyElement(BoFreemantleZoneTargetBlip)
		destroyElement(BoFreemantleTargetZone)
		currentMission = "None"
	end
end

function CDF_join_find_Bo_Freemantle_Q(newMission)
if newMission == currentMission then return else clearMissionData(); currentMission = newMission end
	if newMission == "Find Bo Freemantle in Mulholland, LS" then 
	triggerEvent("DrawQuestTitle",localPlayer,"New mission:","front lines","Find Bo Freemantle in Mulholland, LS")
	--changeTeam
	triggerServerEvent("changePlayerTeam",localPlayer,"CDF")
	BoFreemantleTargetZone = createColSphere(932.09998,-858.29999,93.5,3) --posX="2796.6728515625" posY="-1946.2314453125" posZ="17.3203125" rotX="0" rotY="0" rotZ="35.7802734375"
	addEventHandler("onClientColShapeHit",resourceRoot, BoFreemantleZoneCheck)
	BoFreemantleZoneTargetBlip = createBlip ( 932.09998,-858.29999,98.5, 61, 2, 255, 255, 255, 255, 1, 500)
	setElementData(BoFreemantleZoneTargetBlip, "blip.visibleOnScreen", true)
	curr_mission_col = BoFreemantleTargetZone
	curr_mission_blip = BoFreemantleZoneTargetBlip 
	end
end