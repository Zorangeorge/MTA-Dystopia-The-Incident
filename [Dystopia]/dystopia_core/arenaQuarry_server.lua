--boxingmarker = createMarker ( 1954.6611328125, 2315.501953125, 15.553371429443, "cylinder", 1.5, 255, 255, 0, 50 )
--setElementInterior ( boxingmarker, 7 )
--gymentrance = createMarker ( 1968.7493896484, 2294.7719726563, 15.455863952637, "cylinder", 1.5, 255, 255, 0, 170 )
--quarrygymexit = createMarker ( 774.061584, -78.840705871582, 999.6627807617, "cylinder", 1.5, 255, 255, 0, 170 )
--setElementInterior (quarrygymexit, 7 )
--invisiceiling = createObject ( 10765, 766.87561035156, -68.73966217041, 1002.569152832, 0, 0, 0 )
--setElementInterior ( invisiceiling, 7 )
--setElementAlpha(invisiceiling, 0)
addEvent("PutPlayerInQuarryRing",true)

quarryboxingplayers = 0
quarrygameon = 0
quarryredbetters = {}
quarrybluebetters = {}
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
quarry_Gymcol =   createColCuboid(611.84589, 829.39142, -44.02839, 17.979614257813, 38.330871582031, 4.5501846313477)

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
addEventHandler ( "onMarkerHit", quarrygymexit, exitgym3 )]]

function enterquarryring(hitPlayer)
	--if source == boxingmarker and getElementType(hitPlayer) == "player" then
		if quarryboxingplayers == 0 then
			setElementPosition ( hitPlayer, 619.076171875, 863.171875, -42.9609375 )
			setElementRotation ( hitPlayer, 0,0,185.26254272461 )
			setPedWeaponSlot ( hitPlayer, 0 )
			quarryboxingplayers = quarryboxingplayers+1
			quarryredboxer = hitPlayer
			--redskin = getPlayerSkin(quarryredboxer)
			quarryredstyle = getPedFightingStyle(quarryredboxer)
			quarryredhealth = getElementHealth(quarryredboxer)
			quarryredarmor = getPedArmor(quarryredboxer)
			--setPlayerSkin ( hitPlayer, 80 )
			--setPlayerFightingStyle ( hitPlayer, 5 )
			setElementHealth(hitPlayer, 100 )
			setPedArmor(hitPlayer, 0 )
			quarrynochallengers = setTimer ( quarrynpcmatchtoday, 12000, 1 )
		elseif quarryboxingplayers == 1 and hitPlayer ~= quarryredboxer then
			setElementPosition ( hitPlayer, 622.458984375, 833.8515625, -42.9609375 )
			setElementRotation ( hitPlayer, 0,0,0.54107666015625 )
			setPedWeaponSlot ( hitPlayer, 0 )
			quarryboxingplayers = quarryboxingplayers+1
			quarryblueboxer = hitPlayer
			--blueskin = getPlayerSkin(quarryblueboxer)
			quarrybluestyle = getPedFightingStyle(quarryblueboxer)
			quarrybluehealth = getElementHealth(quarryblueboxer)
			quarrybluearmor = getPedArmor(quarryblueboxer)
			--setPlayerSkin ( hitPlayer, 81 )
			--setPlayerFightingStyle ( hitPlayer, 5 )
			setElementHealth(hitPlayer, 100 )
			setPedArmor(hitPlayer, 0 )
			killTimer ( quarrynochallengers )
			quarrynochallengers = nil
			setTimer ( triggerquarryboxingroundstart, 2000, 1 )
			--textDisplayAddObserver ( fightTextDisplay, quarryblueboxer )
			--textDisplayAddObserver ( fightTextDisplay, quarryredboxer )
			triggerClientEvent(quarryblueboxer,"DrawQuestTitle",quarryblueboxer," ","Fight!"," ","no")
			triggerClientEvent(quarryredboxer,"DrawQuestTitle",quarryredboxer," ","Fight!"," ","no")
			--setElementInterior ( boxingmarker, 1 )
			--setElementInterior (bluebetmarker, 0 )
			--setElementInterior (redbetmarker, 0 )
		end
	--end
end
--addEventHandler ( "onMarkerHit", boxingmarker, enterquarryring )


addEventHandler("PutPlayerInQuarryRing",root, function()
	
	enterquarryring(client)
	
end)

function triggerquarryboxingroundstart()
	ringthequarrybell = setTimer ( quarryboxingroundtimeover, 120000, 1 )
	toggleControl ( quarryredboxer, "fire", true )
	toggleControl ( quarryblueboxer, "fire", true )
	toggleControl ( quarryredboxer, "aim_weapon", true )
	toggleControl ( quarryblueboxer, "aim_weapon", true )
	--textDisplayRemoveObserver ( fightTextDisplay, quarryblueboxer )
	--textDisplayRemoveObserver ( fightTextDisplay, quarryredboxer )
	quarrygameon = 1
end

function quarrytowelcheck()
	if quarrygameon == 1 then
		if source == quarryredboxer or source == quarryblueboxer then
			local playerhealth = getElementHealth(source)
			if playerhealth < 20 and playerhealth ~= 0 then
				toggleControl ( quarryredboxer, "fire", false )
				toggleControl ( quarryredboxer, "aim_weapon", false )
				toggleControl ( quarryblueboxer, "fire", false )
				toggleControl ( quarryblueboxer, "aim_weapon", false )
				if source == quarryredboxer then
					quarrygameon = 0
					quarryblueguywins()
				elseif source == quarryblueboxer then
					quarrygameon = 0
					quarryredguywins()
				end
			end
		end
	end
end
addEventHandler ( "onPlayerDamage", root, quarrytowelcheck )

addEventHandler ( "onPedWasted", root, 
	function () 
		if source == quarryblueboxer then 
		quarrygameon = 0; 
		quarryredguywins()
		setTimer(setElementAlpha,3000,1,quarryblueboxer,100)
		setTimer(destroyElement,6000,1,quarryblueboxer)
		setTimer(function() if isElement(source) then destroyElement(source) end  quarryblueboxer = nil end  ,7000,1)
		
		end 
	end)

function quarryredguywins()
	if isTimer(ringthequarrybell) then killTimer ( ringthequarrybell ) end
	quarryboxingwinner = quarryredboxer
	setTimer ( quarryboxingroundstops, 2000, 1 )
	if getElementType(quarryblueboxer) == "player" then
	--textDisplayAddObserver ( redwinTextDisplay, quarryblueboxer )
	triggerClientEvent(quarryblueboxer,"DrawQuestTitle",quarryblueboxer," ","You lost!"," ","no")
	end
	--textDisplayAddObserver ( redwinTextDisplay, quarryredboxer )
	triggerClientEvent(quarryredboxer,"DrawQuestTitle",quarryredboxer," ","You won!","+50$","no")
	for theKey, theBetter in ipairs(quarryredbetters) do
		givePlayerMoney ( theBetter, 50 )
		--textDisplayAddObserver ( redwinTextDisplay, theBetter )
		--setTimer ( textDisplayRemoveObserver, 2000, 1, redwinTextDisplay, theBetter )
		triggerClientEvent(theBetter,"DrawQuestTitle",theBetter," ","Red won!"," ","no")
	end
end

function quarryblueguywins()
	killTimer ( ringthequarrybell )
	quarryboxingwinner= quarryblueboxer
	setTimer ( quarryboxingroundstops, 2000, 1 )
	if getElementType(quarryblueboxer) == "player" then
	--textDisplayAddObserver ( bluewinTextDisplay, quarryblueboxer )
	triggerClientEvent(quarryblueboxer,"DrawQuestTitle",quarryblueboxer," ","You won!","+50 $","no")
	end
	--textDisplayAddObserver ( bluewinTextDisplay, quarryredboxer )
	triggerClientEvent(quarryredboxer,"DrawQuestTitle",quarryredboxer," ","You lost!"," ","no")
	for theKey, theBetter in ipairs(quarrybluebetters) do
		givePlayerMoney ( theBetter, 50 )
		--textDisplayAddObserver ( bluewinTextDisplay, theBetter )
		--setTimer ( textDisplayRemoveObserver, 2000, 1, bluewinTextDisplay, theBetter )
		triggerClientEvent(theBetter,"DrawQuestTitle",theBetter," ","Blue won!"," ","no")
	end
end

function table.random ( theTable ) 
    return theTable[math.random ( #theTable )]
end

function quarrycreateNPCFighter()
Fighters = createTeam("Fighters")
local skins = { 	108,109, --vagos
				181, --punk
				247, 248, --bikers
				242, --dread brother
				293 --ogloc
					}
local weapons = {2, 4, 5,6,7, 8,10,11,12,15}
quarryblueboxer = exports["dystopia_slothbot"]:spawnBot (622.458984375, 833.8515625, -42.9609375, 0.54107666015625, table.random(skins), int, int, Fighters, table.random(weapons), "chasing", quarryredboxer)
setElementData(quarryblueboxer, "name", "Fighter")

triggerClientEvent(quarryredboxer,"DrawQuestTitle",quarryredboxer," ","Fight!"," ","no")

	--local randomnumber = math.random(1,2)
	--if randomnumber == 2 then
		--local ped2 = exports["dystopia_slothbot"]:spawnBot (1962.5010546875, 2309.2275390625, 17.357542037964,197.72120666504, table.random(skins), int, int, Fighters, 0, "chasing", quarryredboxer)
		--setElementData(ped2, "name", "Fighter")
	--end

	return quarryblueboxer
end

--no 2nd player to box
function quarrynpcmatchtoday()
	
	quarryblueboxer = quarrycreateNPCFighter()	
	setElementHealth (quarryblueboxer, 500 )
	toggleControl ( quarryredboxer, "fire", true )
	toggleControl ( quarryredboxer, "aim_weapon", true )
	
	--setElementPosition ( quarryredboxer, 1961.0361328125, 2302.4326171875, 16.456624984741 )
	----setPlayerFightingStyle ( quarryredboxer, quarryredstyle )
	--setElementHealth (quarryredboxer, quarryredhealth )
	--setPedArmor(quarryredboxer, quarryredarmor )
	
	----textDisplayAddObserver ( matchcancelled, quarryredboxer )
	----setTimer ( textDisplayRemoveObserver, 2000, 1, matchcancelled, quarryredboxer )
	--quarrygameon = 0
	--quarrystartover()
end

--someone won
function quarryboxingroundstops()
	if quarryboxingwinner == quarryredboxer then
		givePlayerMoney ( quarryredboxer, 50 )
		if getElementType(quarryblueboxer) == "player" then
		--textDisplayRemoveObserver ( redwinTextDisplay, quarryblueboxer )
		end
		--textDisplayRemoveObserver ( redwinTextDisplay, quarryredboxer )
	elseif quarryboxingwinner == quarryblueboxer then
		if getElementType(quarryblueboxer) == "player" then
		givePlayerMoney ( quarryblueboxer, 50 )
		--textDisplayRemoveObserver ( bluewinTextDisplay, quarryblueboxer )
		end
		--textDisplayRemoveObserver ( bluewinTextDisplay, quarryredboxer )
	elseif quarryboxingwinner == draw then
		if getElementType(quarryblueboxer) == "player" then
		--textDisplayRemoveObserver ( nowinTextDisplay, quarryblueboxer )
		end
		--textDisplayRemoveObserver ( nowinTextDisplay, quarryredboxer )
	end
	--setPlayerFightingStyle ( quarryredboxer, quarryredstyle )
	setElementHealth (quarryredboxer, quarryredhealth )
	setPedArmor(quarryredboxer, quarryredarmor )
	--setPlayerSkin(quarryredboxer, redskin)
	setElementPosition ( quarryredboxer, 609.5224609375, 866.8984375, -40.639701843262 )
	--toggleControl ( quarryredboxer, "fire", false )
	--toggleControl ( quarryredboxer, "aim_weapon", false )
	
	if getElementType(quarryblueboxer) == "player" then
	--setPlayerFightingStyle ( quarryblueboxer, quarrybluestyle )
	setElementHealth (quarryblueboxer, quarrybluehealth )
	setPedArmor(quarryblueboxer, quarrybluearmor )
	--setPlayerSkin(quarryblueboxer, blueskin)
	setElementPosition ( quarryblueboxer, 611.259765625, 867.412109375, -41.822582244873 )
	--toggleControl ( quarryblueboxer, "fire", false )
	--toggleControl ( quarryblueboxer, "aim_weapon", false )
	end
	quarrygameon = 0
	quarrystartover()
end

--someone left the server
function quarryboxerquit()
	if source == quarryblueboxer then
		setElementPosition ( quarryredboxer, 609.5224609375, 866.8984375, -40.639701843262 )
		givePlayerMoney ( quarryredboxer, 20 )
		--setPlayerFightingStyle ( quarryredboxer, quarryredstyle )
		setElementHealth (quarryredboxer, quarryredhealth )
		setPedArmor(quarryredboxer, quarryredarmor )
		--setPlayerSkin(quarryredboxer, redskin)
		toggleControl ( quarryredboxer, "fire", false )
		toggleControl ( quarryredboxer, "aim_weapon", false )
		--textDisplayAddObserver ( matchcancelled, quarryredboxer )
		triggerClientEvent(quarryredboxer,"DrawQuestTitle",quarryredboxer," ","cancelled"," ","no")
		--setTimer ( --textDisplayRemoveObserver, 2000, 1, matchcancelled, quarryredboxer )
		quarrygameon = 0
		quarrystartover()
	elseif source == quarryredboxer then
	if getElementType(quarryblueboxer) == "player" then
		setElementPosition ( quarryblueboxer, 611.259765625, 867.412109375, -41.822582244873 )
		givePlayerMoney ( quarryblueboxer, 20 )
		setElementHealth (quarryblueboxer, quarrybluehealth )
		setPedArmor(quarryblueboxer, quarrybluearmor )
		--setPlayerFightingStyle ( quarryblueboxer, quarrybluestyle )
		--setPlayerSkin(quarryblueboxer, blueskin)
		toggleControl ( quarryblueboxer, "fire", false )
		toggleControl ( quarryblueboxer, "aim_weapon", false )
		--textDisplayAddObserver ( matchcancelled, quarryblueboxer )
		--setTimer ( textDisplayRemoveObserver, 2000, 1, matchcancelled, quarryblueboxer )
		triggerClientEvent(quarryblueboxer,"DrawQuestTitle",quarryblueboxer," ","cancelled"," ","no")
	end
		quarrygameon = 0
		quarrystartover()
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quarryboxerquit )

--match takes too long
function quarryboxingroundtimeover()
	quarryredhealth = getElementHealth ( quarryredboxer )
	quarrybluehealth = getElementHealth ( quarryblueboxer )
	if quarryredhealth > quarrybluehealth then
		quarryboxingwinner= quarryredboxer
		setTimer ( quarryboxingroundstops, 2000, 1 )
		--textDisplayAddObserver ( redwinTextDisplay, quarryblueboxer )
		--textDisplayAddObserver ( redwinTextDisplay, quarryredboxer )
		triggerClientEvent(quarryredboxer,"DrawQuestTitle",quarryredboxer," ","Red won!"," ","no")
		triggerClientEvent(quarryblueboxer,"DrawQuestTitle",quarryblueboxer," ","Red won!"," ","no")
	elseif quarryredhealth < quarrybluehealth then
		quarryboxingwinner= quarryblueboxer
		setTimer ( quarryboxingroundstops, 2000, 1 )
		--textDisplayAddObserver ( bluewinTextDisplay, quarryblueboxer )
		--textDisplayAddObserver ( bluewinTextDisplay, quarryredboxer )
		triggerClientEvent(quarryredboxer,"DrawQuestTitle",quarryredboxer," ","Blue won!"," ","no")
		triggerClientEvent(quarryblueboxer,"DrawQuestTitle",quarryblueboxer," ","Blue won!"," ","no")

	else
		quarryboxingwinner= draw
		setTimer ( quarryboxingroundstops, 2000, 1 )
		--textDisplayAddObserver ( nowinTextDisplay, quarryblueboxer )
		triggerClientEvent(quarryredboxer,"DrawQuestTitle",quarryredboxer," ","draw"," ","no")
		triggerClientEvent(quarryblueboxer,"DrawQuestTitle",quarryblueboxer," ","draw"," ","no")
		--textDisplayAddObserver ( nowinTextDisplay, quarryredboxer )
	end
	if isTimer(ringthequarrybell) then
		killTimer (ringthequarrybell)
		destroyElement(ringthequarrybell)
	end
	quarrygameon = 0
	quarrystartover()
end

--boxer dies somehow (shouldnt ever happen)
function quarryboxerdied()
	if source == quarryblueboxer then
		setElementPosition ( quarryredboxer, 609.5224609375, 866.8984375, -40.639701843262 )
		givePlayerMoney ( quarryredboxer, 20 )
		--setPlayerFightingStyle ( quarryredboxer, quarryredstyle )
		setElementHealth (quarryredboxer, quarryredhealth )
		--setPlayerSkin(quarryredboxer, redskin)
		setPedArmor(quarryredboxer, quarryredarmor )
		--toggleControl ( quarryredboxer, "fire", false )
		--toggleControl ( quarryredboxer, "aim_weapon", false )
		--textDisplayAddObserver ( matchcancelled, quarryredboxer )
		triggerClientEvent(quarryredboxer,"DrawQuestTitle",quarryredboxer," ","cancelled"," ","no")
		--setTimer ( textDisplayRemoveObserver, 2000, 1, matchcancelled, quarryredboxer )
		toggleControl ( quarryblueboxer, "fire", true )
		toggleControl ( quarryblueboxer, "aim_weapon", true )
		toggleControl ( quarryblueboxer, "next_weapon", true )
		toggleControl ( quarryblueboxer, "previous_weapon", true )
		quarrygameon = 0
		quarrystartover()
	elseif source == quarryredboxer then
		if getElementType(quarryblueboxer) == "player" then
			setElementPosition ( quarryblueboxer, 611.259765625, 867.412109375, -41.822582244873 )
			givePlayerMoney ( quarryblueboxer, 20 )
			setElementHealth (quarryblueboxer, quarrybluehealth )
			setPedArmor(quarryblueboxer, quarrybluearmor )
			--setPlayerFightingStyle ( quarryblueboxer, quarrybluestyle )
			--setPlayerSkin(quarryblueboxer, blueskin)
			--toggleControl ( quarryblueboxer, "fire", false )
			--toggleControl ( quarryblueboxer, "aim_weapon", false )
			--textDisplayAddObserver ( matchcancelled, quarryblueboxer )
			triggerClientEvent(quarryblueboxer,"DrawQuestTitle",quarryblueboxer," ","cancelled"," ","no")
			--setTimer ( textDisplayRemoveObserver, 2000, 1, matchcancelled, quarryblueboxer )
		end
		toggleControl ( quarryredboxer, "fire", true )
		toggleControl ( quarryredboxer, "aim_weapon", true )
		toggleControl ( quarryredboxer, "next_weapon", true )
		toggleControl ( quarryredboxer, "previous_weapon", true )

		quarrygameon = 0
		quarrystartover()
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), quarryboxerdied )

function quarrystartover()
	--setElementInterior ( boxingmarker, 0 )
	quarryboxingplayers = 0
	quarryredboxer = nil
	quarryblueboxer = nil
	if isTimer(quarrynochallengers) then
		killTimer ( quarrynochallengers )
		quarrynochallengers = nil
	end
	if isTimer(ringthequarrybell) then
		killTimer (ringthequarrybell)
		ringthequarrybell = nil
	end
	quarryredbetters = nil
	quarrybluebetters = nil
	quarryredbetters = {}
	quarrybluebetters = {}
	--setElementInterior (bluebetmarker, 1 )
	--setElementInterior (redbetmarker, 1 )
end

--betting stuff
--[[function quarrybetonblue(hitPlayer)
	if getElementType(hitPlayer) == "player" then
		local money = getPlayerMoney(hitPlayer)
		if (money > 24) then
			 triggerClientEvent ( hitPlayer, "onBlueHit", hitPlayer )
		end
	end
end
addEventHandler ( "onMarkerHit", bluebetmarker, quarrybetonblue )
			
function quarrybetonred(hitPlayer)
	if getElementType(hitPlayer) == "player" then
		local money = getPlayerMoney(hitPlayer)
		if (money > 24) then
			triggerClientEvent ( hitPlayer, "onRedHit", hitPlayer )
		end
	end
end
addEventHandler ( "onMarkerHit", redbetmarker, quarrybetonblue )			

function betexit(hitelmnt)
	if getElementType(hitelmnt) == "player" then
		triggerClientEvent ( hitelmnt, "onBetLeave", hitelmnt )
	end
end
addEventHandler ( "onMarkerLeave", bluebetmarker, betexit )
addEventHandler ( "onMarkerLeave", redbetmarker, betexit )]]

addEvent( "quarryOnRedBetPlaced", true )
function quarrybetonred()
	table.insert(quarryredbetters,source)
	takePlayerMoney ( source, 25 )
	playSoundFrontEnd ( source, 40 )
end
addEventHandler( "quarryOnRedBetPlaced", getRootElement(), quarrybetonred )

addEvent( "quarryOnBlueBetPlaced", true )
function quarrybetonblue()
	table.insert(quarrybluebetters,source)
	takePlayerMoney ( source, 25 )
	playSoundFrontEnd ( source, 40 )
end
addEventHandler( "quarryOnBlueBetPlaced", getRootElement(), quarrybetonblue )

--enables weapons when gym col is left
function quarrygymexit(hitelmnt)
	if getElementType(hitelmnt) == "player" then
		toggleControl ( hitelmnt, "fire", true )
		toggleControl ( hitelmnt, "aim_weapon", true )
		toggleControl ( hitelmnt, "next_weapon", true )
		toggleControl ( hitelmnt, "previous_weapon", true )
	end
end
addEventHandler ( "onColShapeLeave", quarry_Gymcol, quarrygymexit )

--disables weapons when gym col is hit
function quarrygymenter(hitelmnt)
	if getElementType(hitelmnt) == "player" then
		setPedWeaponSlot(hitelmnt,0)
		toggleControl ( hitelmnt, "fire", false )
		toggleControl ( hitelmnt, "aim_weapon", false )
		toggleControl ( hitelmnt, "next_weapon", false )
		toggleControl ( hitelmnt, "previous_weapon", false )
	end
end
addEventHandler ( "onColShapeHit", quarry_Gymcol, quarrygymenter )

--cleans everything up if resource is stopped
function quarrycleanup(stoppedresource)
	if stoppedresource == getThisResource() then
		local quarrylvgymstuff = getElementsWithinColShape ( quarry_Gymcol, "player" )  -- get all the players inside the sphere
		for theKey,theElement in ipairs(quarrylvgymstuff) do 
			toggleControl ( theElement, "fire", true )
			toggleControl ( theElement, "aim_weapon", true )
			toggleControl ( theElement, "next_weapon", true )
			toggleControl ( theElement, "previous_weapon", true )
		end
		if isElement(quarryredboxer) then
			--setPlayerFightingStyle ( quarryredboxer, quarryredstyle )
			setElementHealth (quarryredboxer, quarryredhealth )
			setPedArmor(quarryredboxer, quarryredarmor )
			--setPlayerSkin(quarryredboxer, redskin)
		end
		if isElement(quarryblueboxer) and getElementType(quarryblueboxer)== "player" then	
			--setPlayerFightingStyle ( quarryblueboxer, quarrybluestyle )
			setElementHealth (quarryblueboxer, quarrybluehealth )
			setPedArmor(quarryblueboxer, quarrybluearmor )
			--setPlayerSkin(quarryblueboxer, blueskin)
		end
	end
end
addEventHandler ( "onResourceStop", getRootElement(), quarrycleanup )

--startup
function startupquarryboxing(startedresource)
	if startedresource == getThisResource() then
		local quarrylvgymstuff = getElementsWithinColShape ( quarry_Gymcol, "player" )  -- get all the players inside the sphere
		for theKey,theElement in ipairs(quarrylvgymstuff) do 
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
addEventHandler ( "onResourceStart", getRootElement(), startupquarryboxing )