--boxingmarker = createMarker ( 1954.6611328125, 2315.501953125, 15.553371429443, "cylinder", 1.5, 255, 255, 0, 50 )
--setElementInterior ( boxingmarker, 7 )
--gymentrance = createMarker ( 1968.7493896484, 2294.7719726563, 15.455863952637, "cylinder", 1.5, 255, 255, 0, 170 )
--gymexit = createMarker ( 774.061584, -78.840705871582, 999.6627807617, "cylinder", 1.5, 255, 255, 0, 170 )
--setElementInterior (gymexit, 7 )
--invisiceiling = createObject ( 10765, 766.87561035156, -68.73966217041, 1002.569152832, 0, 0, 0 )
--setElementInterior ( invisiceiling, 7 )
--setElementAlpha(invisiceiling, 0)
addEvent("PutPlayerInLVRing",true)

boxingplayers = 0
gameon = 0
redbetters = {}
bluebetters = {}
--fightTextDisplay = textCreateDisplay ()
--fightTextItem = textCreateTextItem ( "FIGHT!", 0.5, 0.5, "low", 0, 255, 0, 255, 4, "center", "center" )
--textDisplayAddText ( fightTextDisplay, fightTextItem )
--redwinTextDisplay = textCreateDisplay ()
--redwinTextItem = textCreateTextItem ( "RED WINS!", 0.5, 0.5, "low", 255, 0, 0, 255, 4, "center", "center" )
--textDisplayAddText ( redwinTextDisplay, redwinTextItem )
--bluewinTextDisplay = textCreateDisplay ()
--bluewinTextItem = textCreateTextItem ( "BLUE WINS!", 0.5, 0.5, "low", 0, 0, 255, 255, 4, "center", "center" )
--textDisplayAddText ( bluewinTextDisplay, bluewinTextItem )
--nowinTextDisplay = textCreateDisplay ()
--nowinTextItem = textCreateTextItem ( "DRAW!", 0.5, 0.5, "low", 0, 255, 0, 255, 4, "center", "center" )
--textDisplayAddText ( nowinTextDisplay, nowinTextItem )
--matchcancelled = textCreateDisplay ()
--matchcancelledtext = textCreateTextItem ( "MATCH CANCELLED!", 0.5, 0.5, "low", 0, 255, 0, 255, 4, "center", "center" )
--textDisplayAddText ( matchcancelled, matchcancelledtext )
--redbetmarker = createMarker( 1965.8212890625, 2306.0595703125, 15.456624984741, "cylinder", 1.0, 255, 0, 0, 50 )
--bluebetmarker = createMarker( 1965.8798828125, 2307.857421875, 15.463848114014, "cylinder", 1.0, 0, 0, 255, 50 )
LV_Gymcol =  createColCuboid(1951.11646, 2295.08496, 9.82031, 22.410888671875, 27.5390625, 10.80625)

--door to go in and out of gym
--[[function entergym3(hitPlayer)
	if getElementType(hitPlayer) == "player" then
		if (getPlayerWeaponSlot(hitPlayer) ~= 8 ) and (isPedOnGround(hitPlayer)) and (getPedOccupiedVehicle(hitPlayer) == false) then
			setElementInterior ( hitPlayer, 7 )
			setElementPosition ( hitPlayer,  775.03442382813, -76.017471313477, 1000.6526489258 )
		end
	end
end
addEventHandler ( "onMarkerHit", gymentrance, entergym3 )

function exitgym3(hitPlayer)
	if getElementType(hitPlayer) == "player" then
		setElementInterior ( hitPlayer, 0 )
		setElementPosition ( hitPlayer, 1966.1120605469, 2294.6625976563, 16.455863952637 )
	end
end
addEventHandler ( "onMarkerHit", gymexit, exitgym3 )]]

function enterboxingring(hitPlayer)
	--if source == boxingmarker and getElementType(hitPlayer) == "player" then
		if boxingplayers == 0 then
			setElementPosition ( hitPlayer, 1961.6240234375, 2304.4150390625, 17.357542037964 )
			setPedWeaponSlot ( hitPlayer, 0 )
			boxingplayers = boxingplayers+1
			redboxer = hitPlayer
			--redskin = getPlayerSkin(redboxer)
			redstyle = getPedFightingStyle(redboxer)
			redhealth = getElementHealth(redboxer)
			redarmor = getPedArmor(redboxer)
			--setPlayerSkin ( hitPlayer, 80 )
			--setPlayerFightingStyle ( hitPlayer, 5 )
			setElementHealth(hitPlayer, 100 )
			setPedArmor(hitPlayer, 0 )
			nochallengers = setTimer ( npcmatchtoday, 12000, 1 )
		elseif boxingplayers == 1 and hitPlayer ~= redboxer then
			setElementPosition ( hitPlayer, 1962.0810546875, 2309.2275390625, 17.357542037964 )
			setPedWeaponSlot ( hitPlayer, 0 )
			boxingplayers = boxingplayers+1
			blueboxer = hitPlayer
			--blueskin = getPlayerSkin(blueboxer)
			bluestyle = getPedFightingStyle(blueboxer)
			bluehealth = getElementHealth(blueboxer)
			bluearmor = getPedArmor(blueboxer)
			--setPlayerSkin ( hitPlayer, 81 )
			--setPlayerFightingStyle ( hitPlayer, 5 )
			setElementHealth(hitPlayer, 100 )
			setPedArmor(hitPlayer, 0 )
			killTimer ( nochallengers )
			nochallengers = nil
			setTimer ( triggerboxingroundstart, 2000, 1 )
			--textDisplayAddObserver ( fightTextDisplay, blueboxer )
			--textDisplayAddObserver ( fightTextDisplay, redboxer )
			triggerClientEvent(blueboxer,"DrawQuestTitle",blueboxer," ","Fight!"," ","no")
			triggerClientEvent(redboxer,"DrawQuestTitle",redboxer," ","Fight!"," ","no")
			--setElementInterior ( boxingmarker, 1 )
			--setElementInterior (bluebetmarker, 0 )
			--setElementInterior (redbetmarker, 0 )
		end
	--end
end
--addEventHandler ( "onMarkerHit", boxingmarker, enterboxingring )


addEventHandler("PutPlayerInLVRing",root, function()
	
	enterboxingring(client)
	
end)

function triggerboxingroundstart()
	ringthebell = setTimer ( boxingroundtimeover, 120000, 1 )
	toggleControl ( redboxer, "fire", true )
	toggleControl ( blueboxer, "fire", true )
	toggleControl ( redboxer, "aim_weapon", true )
	toggleControl ( blueboxer, "aim_weapon", true )
	--textDisplayRemoveObserver ( fightTextDisplay, blueboxer )
	--textDisplayRemoveObserver ( fightTextDisplay, redboxer )
	gameon = 1
end

function towelcheck()
	if gameon == 1 then
		if source == redboxer or source == blueboxer then
			local playerhealth = getElementHealth(source)
			if playerhealth < 20 and playerhealth ~= 0 then
				toggleControl ( redboxer, "fire", false )
				toggleControl ( redboxer, "aim_weapon", false )
				toggleControl ( blueboxer, "fire", false )
				toggleControl ( blueboxer, "aim_weapon", false )
				if source == redboxer then
					gameon = 0
					blueguywins()
				elseif source == blueboxer then
					gameon = 0
					redguywins()
				end
			end
		end
	end
end
addEventHandler ( "onPlayerDamage", root, towelcheck )

addEventHandler ( "onPedWasted", root, 
	function () 
		if source == blueboxer then 
		gameon = 0; 
		redguywins()
		setTimer(setElementAlpha,3000,1,blueboxer,100)
		setTimer(destroyElement,6000,1,blueboxer)
		setTimer(function() destroyElement(source); blueboxer = nil end ,7000,1)
		
		end 
	end)

function redguywins()
	if isTimer(ringthebell) then killTimer ( ringthebell ) end
	boxingwinner = redboxer
	setTimer ( boxingroundstops, 2000, 1 )
	if getElementType(blueboxer) == "player" then
	--textDisplayAddObserver ( redwinTextDisplay, blueboxer )
	triggerClientEvent(blueboxer,"DrawQuestTitle",blueboxer," ","Red won!"," ","no")
	end
	--textDisplayAddObserver ( redwinTextDisplay, redboxer )
	triggerClientEvent(redboxer,"DrawQuestTitle",redboxer," ","Red won!"," ","no")
	for theKey, theBetter in ipairs(redbetters) do
		givePlayerMoney ( theBetter, 50 )
		--textDisplayAddObserver ( redwinTextDisplay, theBetter )
		--setTimer ( textDisplayRemoveObserver, 2000, 1, redwinTextDisplay, theBetter )
		triggerClientEvent(theBetter,"DrawQuestTitle",theBetter," ","Red won!"," ","no")
	end
end

function blueguywins()
	killTimer ( ringthebell )
	boxingwinner= blueboxer
	setTimer ( boxingroundstops, 2000, 1 )
	if getElementType(blueboxer) == "player" then
	--textDisplayAddObserver ( bluewinTextDisplay, blueboxer )
	triggerClientEvent(blueboxer,"DrawQuestTitle",blueboxer," ","Blue won!"," ","no")
	end
	--textDisplayAddObserver ( bluewinTextDisplay, redboxer )
	triggerClientEvent(redboxer,"DrawQuestTitle",redboxer," ","Blue won!"," ","no")
	for theKey, theBetter in ipairs(bluebetters) do
		givePlayerMoney ( theBetter, 50 )
		--textDisplayAddObserver ( bluewinTextDisplay, theBetter )
		--setTimer ( textDisplayRemoveObserver, 2000, 1, bluewinTextDisplay, theBetter )
		triggerClientEvent(theBetter,"DrawQuestTitle",theBetter," ","Blue won!"," ","no")
	end
end

function table.random ( theTable ) 
    return theTable[math.random ( #theTable )]
end

function createNPCFighter()
Fighters = createTeam("Fighters")
local skins = { 	28, --bmydrug
					30, --hmydrug
					47, --hmycr
					104, --ballas3
					144, --bmycg -masked black
					301, --ryder3
					241, --smyst - fat homeless masked
					177, --masked biker
					184, --green hoody balaclava
					102 --hooligan
					}
local weapons = {0,4,10,11,12,14}
blueboxer = exports["dystopia_slothbot"]:spawnBot (1962.0810546875, 2309.2275390625, 17.357542037964,197.72120666504, table.random(skins), int, int, Fighters, table.random(weapons), "chasing", redboxer)
setElementData(blueboxer, "name", "Fighter")

triggerClientEvent(redboxer,"DrawQuestTitle",redboxer," ","Fight!"," ","no")

	--local randomnumber = math.random(1,2)
	--if randomnumber == 2 then
		--local ped2 = exports["dystopia_slothbot"]:spawnBot (1962.5010546875, 2309.2275390625, 17.357542037964,197.72120666504, table.random(skins), int, int, Fighters, 0, "chasing", redboxer)
		--setElementData(ped2, "name", "Fighter")
	--end

	return blueboxer
end

--no 2nd player to box
function npcmatchtoday()
	
	blueboxer = createNPCFighter()	
	setElementHealth (blueboxer, 500 )
	toggleControl ( redboxer, "fire", true )
	toggleControl ( redboxer, "aim_weapon", true )
	
	--setElementPosition ( redboxer, 1961.0361328125, 2302.4326171875, 16.456624984741 )
	----setPlayerFightingStyle ( redboxer, redstyle )
	--setElementHealth (redboxer, redhealth )
	--setPedArmor(redboxer, redarmor )
	
	----textDisplayAddObserver ( matchcancelled, redboxer )
	----setTimer ( textDisplayRemoveObserver, 2000, 1, matchcancelled, redboxer )
	--gameon = 0
	--startover()
end

--someone won
function boxingroundstops()
	if boxingwinner == redboxer then
		givePlayerMoney ( redboxer, 50 )
		if getElementType(blueboxer) == "player" then
		--textDisplayRemoveObserver ( redwinTextDisplay, blueboxer )
		end
		--textDisplayRemoveObserver ( redwinTextDisplay, redboxer )
	elseif boxingwinner == blueboxer then
		if getElementType(blueboxer) == "player" then
		givePlayerMoney ( blueboxer, 50 )
		--textDisplayRemoveObserver ( bluewinTextDisplay, blueboxer )
		end
		--textDisplayRemoveObserver ( bluewinTextDisplay, redboxer )
	elseif boxingwinner == draw then
		if getElementType(blueboxer) == "player" then
		--textDisplayRemoveObserver ( nowinTextDisplay, blueboxer )
		end
		--textDisplayRemoveObserver ( nowinTextDisplay, redboxer )
	end
	--setPlayerFightingStyle ( redboxer, redstyle )
	setElementHealth (redboxer, redhealth )
	setPedArmor(redboxer, redarmor )
	--setPlayerSkin(redboxer, redskin)
	setElementPosition ( redboxer, 1961.0361328125, 2302.4326171875, 16.456624984741 )
	toggleControl ( redboxer, "fire", false )
	toggleControl ( redboxer, "aim_weapon", false )
	
	if getElementType(blueboxer) == "player" then
	--setPlayerFightingStyle ( blueboxer, bluestyle )
	setElementHealth (blueboxer, bluehealth )
	setPedArmor(blueboxer, bluearmor )
	--setPlayerSkin(blueboxer, blueskin)
	setElementPosition ( blueboxer, 1962.056640625, 2310.9677734375, 16.463848114014 )
	toggleControl ( blueboxer, "fire", false )
	toggleControl ( blueboxer, "aim_weapon", false )
	end
	gameon = 0
	startover()
end

--someone left the server
function boxerquit()
	if source == blueboxer then
		setElementPosition ( redboxer, 1961.0361328125, 2302.4326171875, 16.456624984741 )
		givePlayerMoney ( redboxer, 20 )
		--setPlayerFightingStyle ( redboxer, redstyle )
		setElementHealth (redboxer, redhealth )
		setPedArmor(redboxer, redarmor )
		--setPlayerSkin(redboxer, redskin)
		toggleControl ( redboxer, "fire", false )
		toggleControl ( redboxer, "aim_weapon", false )
		--textDisplayAddObserver ( matchcancelled, redboxer )
		triggerClientEvent(redboxer,"DrawQuestTitle",redboxer," ","cancelled"," ","no")
		--setTimer ( --textDisplayRemoveObserver, 2000, 1, matchcancelled, redboxer )
		gameon = 0
		startover()
	elseif source == redboxer then
	if getElementType(blueboxer) == "player" then
		setElementPosition ( blueboxer, 1962.056640625, 2310.9677734375, 16.463848114014 )
		givePlayerMoney ( blueboxer, 20 )
		setElementHealth (blueboxer, bluehealth )
		setPedArmor(blueboxer, bluearmor )
		--setPlayerFightingStyle ( blueboxer, bluestyle )
		--setPlayerSkin(blueboxer, blueskin)
		toggleControl ( blueboxer, "fire", false )
		toggleControl ( blueboxer, "aim_weapon", false )
		--textDisplayAddObserver ( matchcancelled, blueboxer )
		--setTimer ( textDisplayRemoveObserver, 2000, 1, matchcancelled, blueboxer )
		triggerClientEvent(blueboxer,"DrawQuestTitle",blueboxer," ","cancelled"," ","no")
	end
		gameon = 0
		startover()
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), boxerquit )

--match takes too long
function boxingroundtimeover()
	redhealth = getElementHealth ( redboxer )
	bluehealth = getElementHealth ( blueboxer )
	if redhealth > bluehealth then
		boxingwinner= redboxer
		setTimer ( boxingroundstops, 2000, 1 )
		--textDisplayAddObserver ( redwinTextDisplay, blueboxer )
		--textDisplayAddObserver ( redwinTextDisplay, redboxer )
		triggerClientEvent(redboxer,"DrawQuestTitle",redboxer," ","Red won!"," ","no")
		triggerClientEvent(blueboxer,"DrawQuestTitle",blueboxer," ","Red won!"," ","no")
	elseif redhealth < bluehealth then
		boxingwinner= blueboxer
		setTimer ( boxingroundstops, 2000, 1 )
		--textDisplayAddObserver ( bluewinTextDisplay, blueboxer )
		--textDisplayAddObserver ( bluewinTextDisplay, redboxer )
		triggerClientEvent(redboxer,"DrawQuestTitle",redboxer," ","Blue won!"," ","no")
		triggerClientEvent(blueboxer,"DrawQuestTitle",blueboxer," ","Blue won!"," ","no")

	else
		boxingwinner= draw
		setTimer ( boxingroundstops, 2000, 1 )
		--textDisplayAddObserver ( nowinTextDisplay, blueboxer )
		triggerClientEvent(redboxer,"DrawQuestTitle",redboxer," ","draw"," ","no")
		triggerClientEvent(blueboxer,"DrawQuestTitle",blueboxer," ","draw"," ","no")
		--textDisplayAddObserver ( nowinTextDisplay, redboxer )
	end
	if isTimer(ringthebell) then
		killTimer (ringthebell)
		destroyElement(ringthebell)
	end
	gameon = 0
	startover()
end

--boxer dies somehow (shouldnt ever happen)
function boxerdied()
	if source == blueboxer then
		setElementPosition ( redboxer, 1961.0361328125, 2302.4326171875, 16.456624984741 )
		givePlayerMoney ( redboxer, 20 )
		--setPlayerFightingStyle ( redboxer, redstyle )
		setElementHealth (redboxer, redhealth )
		--setPlayerSkin(redboxer, redskin)
		setPedArmor(redboxer, redarmor )
		toggleControl ( redboxer, "fire", false )
		toggleControl ( redboxer, "aim_weapon", false )
		--textDisplayAddObserver ( matchcancelled, redboxer )
		triggerClientEvent(redboxer,"DrawQuestTitle",redboxer," ","cancelled"," ","no")
		--setTimer ( textDisplayRemoveObserver, 2000, 1, matchcancelled, redboxer )
		toggleControl ( blueboxer, "fire", true )
		toggleControl ( blueboxer, "aim_weapon", true )
		toggleControl ( blueboxer, "next_weapon", true )
		toggleControl ( blueboxer, "previous_weapon", true )
		gameon = 0
		startover()
	elseif source == redboxer then
		if getElementType(blueboxer) == "player" then
			setElementPosition ( blueboxer, 1962.056640625, 2310.9677734375, 16.463848114014 )
			givePlayerMoney ( blueboxer, 20 )
			setElementHealth (blueboxer, bluehealth )
			setPedArmor(blueboxer, bluearmor )
			--setPlayerFightingStyle ( blueboxer, bluestyle )
			--setPlayerSkin(blueboxer, blueskin)
			toggleControl ( blueboxer, "fire", false )
			toggleControl ( blueboxer, "aim_weapon", false )
			--textDisplayAddObserver ( matchcancelled, blueboxer )
			triggerClientEvent(blueboxer,"DrawQuestTitle",blueboxer," ","cancelled"," ","no")
			--setTimer ( textDisplayRemoveObserver, 2000, 1, matchcancelled, blueboxer )
		end
		toggleControl ( redboxer, "fire", true )
		toggleControl ( redboxer, "aim_weapon", true )
		toggleControl ( redboxer, "next_weapon", true )
		toggleControl ( redboxer, "previous_weapon", true )
		gameon = 0
		startover()
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), boxerdied )

function startover()
	--setElementInterior ( boxingmarker, 0 )
	boxingplayers = 0
	redboxer = nil
	blueboxer = nil
	if isTimer(nochallengers) then
		killTimer ( nochallengers )
		nochallengers = nil
	end
	if isTimer(ringthebell) then
		killTimer (ringthebell)
		ringthebell = nil
	end
	redbetters = nil
	bluebetters = nil
	redbetters = {}
	bluebetters = {}
	--setElementInterior (bluebetmarker, 1 )
	--setElementInterior (redbetmarker, 1 )
end

--betting stuff
--[[function betonblue(hitPlayer)
	if getElementType(hitPlayer) == "player" then
		local money = getPlayerMoney(hitPlayer)
		if (money > 24) then
			 triggerClientEvent ( hitPlayer, "onBlueHit", hitPlayer )
		end
	end
end
addEventHandler ( "onMarkerHit", bluebetmarker, betonblue )
			
function betonred(hitPlayer)
	if getElementType(hitPlayer) == "player" then
		local money = getPlayerMoney(hitPlayer)
		if (money > 24) then
			triggerClientEvent ( hitPlayer, "onRedHit", hitPlayer )
		end
	end
end
addEventHandler ( "onMarkerHit", redbetmarker, betonblue )			

function betexit(hitelmnt)
	if getElementType(hitelmnt) == "player" then
		triggerClientEvent ( hitelmnt, "onBetLeave", hitelmnt )
	end
end
addEventHandler ( "onMarkerLeave", bluebetmarker, betexit )
addEventHandler ( "onMarkerLeave", redbetmarker, betexit )]]

addEvent( "onRedBetPlaced", true )
function betonred()
	table.insert(redbetters,source)
	takePlayerMoney ( source, 25 )
	playSoundFrontEnd ( source, 40 )
end
addEventHandler( "onRedBetPlaced", getRootElement(), betonred )

addEvent( "onBlueBetPlaced", true )
function betonblue()
	table.insert(bluebetters,source)
	takePlayerMoney ( source, 25 )
	playSoundFrontEnd ( source, 40 )
end
addEventHandler( "onBlueBetPlaced", getRootElement(), betonblue )

--enables weapons when gym col is left
function gymexit(hitelmnt)
	if getElementType(hitelmnt) == "player" then
		toggleControl ( hitelmnt, "fire", true )
		toggleControl ( hitelmnt, "aim_weapon", true )
		toggleControl ( hitelmnt, "next_weapon", true )
		toggleControl ( hitelmnt, "previous_weapon", true )
	end
end
addEventHandler ( "onColShapeLeave", LV_Gymcol, gymexit )

--disables weapons when gym col is hit
function gymenter(hitelmnt)
	if getElementType(hitelmnt) == "player" then
		setPedWeaponSlot(hitelmnt,0)
		toggleControl ( hitelmnt, "fire", false )
		toggleControl ( hitelmnt, "aim_weapon", false )
		toggleControl ( hitelmnt, "next_weapon", false )
		toggleControl ( hitelmnt, "previous_weapon", false )
	end
end
addEventHandler ( "onColShapeHit", LV_Gymcol, gymenter )

--cleans everything up if resource is stopped
function cleanup(stoppedresource)
	if stoppedresource == getThisResource() then
		local lvgymstuff = getElementsWithinColShape ( LV_Gymcol, "player" )  -- get all the players inside the sphere
		for theKey,theElement in ipairs(lvgymstuff) do 
			toggleControl ( theElement, "fire", true )
			toggleControl ( theElement, "aim_weapon", true )
			toggleControl ( theElement, "next_weapon", true )
			toggleControl ( theElement, "previous_weapon", true )
		end
		if isElement(redboxer) then
			--setPlayerFightingStyle ( redboxer, redstyle )
			setElementHealth (redboxer, redhealth )
			setPedArmor(redboxer, redarmor )
			--setPlayerSkin(redboxer, redskin)
		end
		if isElement(blueboxer) and getElementType(blueboxer)== "player" then	
			--setPlayerFightingStyle ( blueboxer, bluestyle )
			setElementHealth (blueboxer, bluehealth )
			setPedArmor(blueboxer, bluearmor )
			--setPlayerSkin(blueboxer, blueskin)
		end
	end
end
addEventHandler ( "onResourceStop", getRootElement(), cleanup )

--startup
function startuplvboxing(startedresource)
	if startedresource == getThisResource() then
		local lvgymstuff = getElementsWithinColShape ( LV_Gymcol, "player" )  -- get all the players inside the sphere
		for theKey,theElement in ipairs(lvgymstuff) do 
			toggleControl ( theElement, "fire", false )
			toggleControl ( theElement, "aim_weapon", false )
			toggleControl ( theElement, "next_weapon", false )
			toggleControl ( theElement, "previous_weapon", false )
			--textDisplayRemoveObserver ( fightTextDisplay, theElement )
			--textDisplayRemoveObserver ( redwinTextDisplay, theElement )
			--textDisplayRemoveObserver ( bluewinTextDisplay, theElement )
			--textDisplayRemoveObserver ( nowinTextDisplay, theElement )
			--textDisplayRemoveObserver ( matchcancelled, theElement )			
		end
	end
end
addEventHandler ( "onResourceStart", getRootElement(), startuplvboxing )