-----------------
--- (c) 2010 ----
--- by Zipper ---
-----------------

--[[
Don't change anything if you don't know
what you're doing!!!
______________________________
Please don't remove the copyright,
but feel free to edit this resource
and please report if you find a bug!
______________________________
Maybe it would have been better to
use tables instead of "_G", but i simply
like the "_G" much more.
______________________________
Don't like the optic of the cards?
Think that "_G" is crap?
Think that my english is too bad?

Then go to hell.
]]

pokerPlayerPositions = {}
	pokerPlayerPositions[1] = {}
		pokerPlayerPositions[1]["x"] = 1117.9412841797
		pokerPlayerPositions[1]["y"] = 11.394277572632
		pokerPlayerPositions[1]["z"] = 1002
		pokerPlayerPositions[1]["rot"] = 0
	pokerPlayerPositions[2] = {}
		pokerPlayerPositions[2]["x"] = 1118.427734375
		pokerPlayerPositions[2]["y"] = 12.34
		pokerPlayerPositions[2]["z"] = 1001.8
		pokerPlayerPositions[2]["rot"] = -45
	pokerPlayerPositions[3] = {}
		pokerPlayerPositions[3]["x"] = 1119.2440185547
		pokerPlayerPositions[3]["y"] = 12.797629356384
		pokerPlayerPositions[3]["z"] = 1002
		pokerPlayerPositions[3]["rot"] = -90
	pokerPlayerPositions[4] = {}
		pokerPlayerPositions[4]["x"] = 1120.1339111328
		pokerPlayerPositions[4]["y"] = 12.356394767761
		pokerPlayerPositions[4]["z"] = 1002
		pokerPlayerPositions[4]["rot"] = -135
	pokerPlayerPositions[5] = {}
		pokerPlayerPositions[5]["x"] = 1120.3681640625
		pokerPlayerPositions[5]["y"] = 11.336325645447
		pokerPlayerPositions[5]["z"] = 1002
		pokerPlayerPositions[5]["rot"] = 180
	pokerPlayerPositions[6] = {}
		pokerPlayerPositions[6]["x"] = 1118.6916503906
		pokerPlayerPositions[6]["y"] = 10.396108627319
		pokerPlayerPositions[6]["z"] = 1001.5
		pokerPlayerPositions[6]["rot"] = 206
		
-- The door & the dice-blip at the marker-position
	--Dystopia's blips
local door = createObject ( 3109, -2502.216796875, 2361.5061035156, 5.2554173469543 )

EstabPokerBlip = createBlip ( -2502.216796875, 2361.5061035156, 5.2554173469543, 25 , 2, 255, 255, 255, 255, -1, 100)
BanditPokerBlip = createBlip ( 1259.6357421875, -785.3720703125, 92.03125, 25, 2, 255, 255, 255, 255, -1, 100 )
RaiderPokerBlip = createBlip ( 459.36172485352, 939.74005126953, -7.2374229431152, 25, 2, 255, 255, 255, 255, -1, 100 )
ScavPokerBlip = createBlip ( -2172.4443359375, 679.93359375, 55.161338806152, 25, 2, 255, 255, 255, 255, -1, 100 )
CDFPokerBlip = createBlip ( 685.806640625, -454.7001953125, 16.532913208008, 25, 2, 255, 255, 255, 255, -1, 100 )

exports.dystopia_core:brHideBlip(EstabPokerBlip)
exports.dystopia_core:brHideBlip(BanditPokerBlip)
exports.dystopia_core:brHideBlip(RaiderPokerBlip)
exports.dystopia_core:brHideBlip(ScavPokerBlip)
exports.dystopia_core:brHideBlip(CDFPokerBlip)

-- Need an explanation?
pokerPlayer1 = false
pokerPlayer2 = false
pokerPlayer3 = false
pokerPlayer4 = false
pokerPlayer5 = false
pokerPlayer6 = false
pokerCurPlayers = 0

pokerFirstLoop = false

pokerPlayer1In = false
pokerPlayer2In = false
pokerPlayer3In = false
pokerPlayer4In = false
pokerPlayer5In = false
pokerPlayer6In = false

pokerPlayer1Money = 0
pokerPlayer2Money = 0
pokerPlayer3Money = 0
pokerPlayer4Money = 0
pokerPlayer5Money = 0
pokerPlayer6Money = 0

pokerPlayer1Bet = 0
pokerPlayer2Bet = 0
pokerPlayer3Bet = 0
pokerPlayer4Bet = 0
pokerPlayer5Bet = 0
pokerPlayer6Bet = 0

pokerPlayer1HandValue = 0
pokerPlayer2HandValue = 0
pokerPlayer3HandValue = 0
pokerPlayer4HandValue = 0
pokerPlayer5HandValue = 0
pokerPlayer6HandValue = 0

communityCard1 = false
communityCard2 = false
communityCard3 = false
communityCard4 = false
communityCard5 = false

pokerPlayer1TotalBet = 0
pokerPlayer2TotalBet = 0
pokerPlayer3TotalBet = 0
pokerPlayer4TotalBet = 0
pokerPlayer5TotalBet = 0
pokerPlayer6TotalBet = 0

curPokerRound = 0

curPokerPlayer = false

curPokerPot = 0

curPokerBlindPlayer = false

bigBlind = 20
smallBlind = bigBlind / 2

-- The Marker for entering the poker
	--and Dystopia's markers
pokerEntranceMarkers = createElement("pokerBlipsGroup","pokerBlpGropup")

EstabPokerEntranceMarker = createMarker ( -2503.169, 2362.234, 3.959, "cylinder", 1.5, 125, 125, 125, 125 )
ScavPokerEntranceMarker = createMarker ( -2172.4443359375, 679.93359375, 54.161338806152, "cylinder", 1.5, 125, 125, 125, 125 )
RaiderPokerEntranceMarker = createMarker ( 459.36172485352, 939.74005126953, -8.2374229431152, "cylinder", 1.5, 125, 125, 125, 125 )
BanditPokerEntranceMarker = createMarker ( 1259.6357421875, -785.3720703125, 91.03125, "cylinder", 1.5, 125, 125, 125, 125 )
CDFPokerEntranceMarker = createMarker ( 682.841796875, -479.4775390625, 15.3359375, "cylinder", 1.5, 125, 125, 125, 125 )

setElementParent(EstabPokerEntranceMarker, pokerEntranceMarkers)
setElementParent(ScavPokerEntranceMarker, pokerEntranceMarkers)
setElementParent(RaiderPokerEntranceMarker, pokerEntranceMarkers)
setElementParent(BanditPokerEntranceMarker, pokerEntranceMarkers)
setElementParent(CDFPokerEntranceMarker, pokerEntranceMarkers)

-- The poker table
pokerTable = createObject ( 2189, 1119.17, 11.49, 1001.88 )
setElementInterior ( pokerTable, 12 )
pokerChair1 = createObject ( 1720, 1119.8155517578, 10.448568344116, 1001.078, 0, 0, 206 )
pokerChair2 = createObject ( 1720, 1118.6916503906, 10.396108627319, 1001.078, 0, 0, 146 )
setElementInterior ( pokerChair1, 12 )
setElementInterior ( pokerChair2, 12 )

function pokerMarkerHit ( hit, dim )

	if dim then
		if getElementType ( hit ) == "player" then
			suc = true
			for i = 1, 6 do
				if _G["pokerPlayer"..i] == hit then
					suc = false
					break
				end
			end
			-- Only proceed if the player isn't already playing and is not in a vehicle!
			if not getPedOccupiedVehicle ( hit ) and suc then
				-- If there is one more seat
				if pokerCurPlayers <= 5 then
					pokerCurPlayers = pokerCurPlayers + 1
					for i = 1, 6 do
						if not _G["pokerPlayer"..i] then
							_G["pokerPlayer"..i] = hit
							_G["pokerPlayer"..i.."Money"] = 200
							_G["pokerPlayer"..i.."In"] = false
							setElementFrozen ( hit, true )
							setElementPosition ( hit, pokerPlayerPositions[i]["x"], pokerPlayerPositions[i]["y"], pokerPlayerPositions[i]["z"] )
							setElementInterior ( hit, 12 )
							setPedRotation ( hit, pokerPlayerPositions[i]["rot"] - 90 )
							setCameraMatrix ( hit, 1119.8720703125, 11.228228569031, 1005.1077270508, 1119.1854248047, 11.514589309692, 1002.0599365234 )
							toggleAllControls ( hit, false, true, false )
							-- Sometimes the animations stops, don't ask me why
							for i = 1, 6 do
								if _G["pokerPlayer"..i] then
									setPedAnimation ( _G["pokerPlayer"..i], "FOOD", "FF_Sit_Loop", -1, true, false, false )
									setPedRotation ( _G["pokerPlayer"..i], pokerPlayerPositions[i]["rot"] - 90 )
								end
							end
							showCursor ( hit, true )
							setElementData ( hit, "ElementClicked", true )
							triggerClientEvent ( hit, "showPokerHand", hit, 0, 0 )
							triggerClientEvent ( hit, "setVarbs", getRootElement(), "pokerCurOwnChips", 200 )
							-- Refresh the Values for the new player
							for k = 1, 6 do
								if _G["pokerPlayer"..k] then
									_G["p"..k] = "(".._G["pokerPlayer"..k.."Money"]..") "..getPlayerName ( _G["pokerPlayer"..k] )
									if _G["pokerPlayer"..k.."In"] then
										_G["p"..k.."s"] = true
									else
										_G["p"..k.."s"] = false
									end
								else
									_G["p"..k] = ""
									_G["p"..k.."s"] = false
								end
							end
							sendMessageToAllPokerPlayers ( getPlayerName(hit).." joined the game!", 200, 200, 0 )
							triggerClientEvent ( _G["pokerPlayer"..i], "refreshPokerVarbs", getRootElement(), _G["pokerPlayer"..i.."Bet"], curPokerPot, getHighestCall(), _G["pokerPlayer"..i.."Money"], p1, p1s, p2, p2s, p3, p3s, p4, p4s, p5, p5s, p6, p6s )
							if not pokerRoundStarted then
								_G["pokerPlayer"..i.."In"] = true
							else
								_G["pokerPlayer"..i.."In"] = false
							end
							break
						end
					end
					setElementData(hit,"pokerCurrentEntrance",source)
				else
					outputChatBox ( "Please wait, all seats are currently in use!", hit, 125, 0, 0 )
				end
			end
		end
	end
end
addEventHandler ( "onMarkerHit", pokerEntranceMarkers, pokerMarkerHit )

function takePlayerChips ( player, amount )

	_G["pokerPlayer"..player.."Money"] = _G["pokerPlayer"..player.."Money"] - amount
	curPokerPot = curPokerPot + amount
	if _G["pokerPlayer"..player.."Money"] < 0 then
		_G["pokerPlayer"..player.."Money"] = 0
		sendMessageToAllPokerPlayers ( getPlayerName(_G["pokerPlayer"..player]).." is all in!", 0, 0, 170 )
	end
end

function roundCheck()
	
	-- Check if enough players are there -
	-- if there are enough, proceed
	pokerCurPlayers = 0
	for i = 1, 6 do
		if _G["pokerPlayer"..i] ~= false then
			pokerCurPlayers = pokerCurPlayers + 1
			if _G["pokerPlayer"..i.."Money"] <= 0 then
				setPlayerLeavingPoker_func ( _G["pokerPlayer"..i] )
			end
		end
	end
	if pokerCurPlayers > 1 then
		curPokerPot = 0
		sendMessageToAllPokerPlayers ( "Dealer: New round!", 200, 200, 0 )
		pokerRoundStarted = true
		curPokerRound = 0
		if not curPokerBlindPlayer then curPokerBlindPlayer = 0 end
		pokerFirstLoop = false
		for i = 1, 6 do
			_G["pokerPlayer"..i.."Bet"] = 0
		end
		i = getNextPlayerAtPoker ( curPokerBlindPlayer )
		i = getPrevPlayerAtPoker ( i )
		curPokerBlindPlayer = i
		_G["pokerPlayer"..i.."Bet"] = bigBlind
		takePlayerChips ( i, bigBlind )
		_G["pokerPlayer"..i.."Bet"] = _G["pokerPlayer"..i.."Bet"]
		smallBlindPlayer = getNextPlayerAtPoker (curPokerBlindPlayer)
		_G["pokerPlayer"..smallBlindPlayer.."Bet"] = smallBlind
		takePlayerChips ( smallBlindPlayer, smallBlind )
		sendMessageToAllPokerPlayers ( "Dealer: Bigblind: "..getPlayerName(_G["pokerPlayer"..curPokerBlindPlayer])..", Smallblind: "..getPlayerName(_G["pokerPlayer"..smallBlindPlayer]).."!", 200, 200, 0 )
		cardsInUse = nil
		cardsInUse = {}
		pokerFirstLoop = false
		-- Give out the hand cards for the players & some other things
		for i = 1, 6 do
			_G["pokerPlayer"..i.."HandValue"] = 0
			if _G["pokerPlayer"..i] then
				card1 = getNewCard()
				card2 = getNewCard()
				_G["pokerPlayer"..i.."In"] = true
				_G["pokerPlayer"..i.."card1"] = card1
				_G["pokerPlayer"..i.."card2"] = card2
				triggerClientEvent ( _G["pokerPlayer"..i], "showPokerHand", getRootElement(), card1, card2 )
				triggerClientEvent ( _G["pokerPlayer"..i], "setVarbs", _G["pokerPlayer"..i], "pokerCurBets", bigBlind )
			end
		end
		setTimer ( nextRoundPlayer, 1000, 1 )
	else
		if isTimer ( roundCheckTimer ) then
			killTimer ( roundCheckTimer )
		end
		roundCheckTimer = setTimer ( roundCheck, 5000, 1 )
	end
end
roundCheckTimer = setTimer ( roundCheck, 5000, 1 )

function playerTurnCheck_func ( player )

	-- if the player decides to check
	local id = getPlayerPokerID ( player )
	sendMessageToAllPokerPlayers ( getPlayerName(player).." checks!", 200, 0, 0 )
	killTimer ( timeoutTimer )
	nextRoundPlayer ()
end
addEvent ( "playerTurnCheck", true )
addEventHandler ( "playerTurnCheck", getRootElement(), playerTurnCheck_func )

function playerTurnCall_func ( player )

	-- if the player decides to call
	local id = getPlayerPokerID ( player )
	sendMessageToAllPokerPlayers ( getPlayerName(player).." calls ( To "..getHighestCall().." )!", 200, 0, 0 )
	local curAmount = getHighestCall ()
	local amount = curAmount - _G["pokerPlayer"..id.."Bet"]
	-- Check if its an all in
	if amount >= _G["pokerPlayer"..id.."Money"] then
		_G["pokerPlayer"..id.."TotalBet"] = _G["pokerPlayer"..id.."TotalBet"] + amount
		sendMessageToAllPokerPlayers ( getPlayerName(_G["pokerPlayer"..id]).." is all in!", 0, 0, 170 )
	else
		_G["pokerPlayer"..id.."TotalBet"] = _G["pokerPlayer"..id.."TotalBet"] + _G["pokerPlayer"..id.."Money"]
	end
	curPokerPot = curPokerPot + amount
	_G["pokerPlayer"..id.."Bet"] = getHighestCall ()
	killTimer ( timeoutTimer )
	nextRoundPlayer ()
end
addEvent ( "playerTurnCall", true )
addEventHandler ( "playerTurnCall", getRootElement(), playerTurnCall_func )

function playerTurnRaise_func ( amount )

	-- if the player decides to raise
	local player = source
	sendMessageToAllPokerPlayers ( getPlayerName(player).." raises ( To: "..amount.." )!", 200, 0, 0 )
	local id = getPlayerPokerID ( player )
	takePlayerChips ( id, amount )
	_G["pokerPlayer"..id.."Bet"] = _G["pokerPlayer"..id.."Bet"] + amount
	_G["pokerPlayer"..id.."TotalBet"] = _G["pokerPlayer"..id.."TotalBet"] + amount
	if isTimer ( timeoutTimer ) then
		killTimer ( timeoutTimer )
	end
	nextRoundPlayer ()
end
addEvent ( "playerTurnRaise", true )
addEventHandler ( "playerTurnRaise", getRootElement(), playerTurnRaise_func )

function playerTurnFold_func ()

	-- if the player decides to fold
	local player = source
	local id = getPlayerPokerID ( player )
	sendMessageToAllPokerPlayers ( getPlayerName(player).." folds!", 200, 0, 0 )
	_G["pokerPlayer"..id.."Bet"] = 0
	_G["pokerPlayer"..id.."In"] = false
	if isTimer ( timeoutTimer ) then
		killTimer ( timeoutTimer )
	end
	nextRoundPlayer ()
end
addEvent ( "playerTurnFold", true )
addEventHandler ( "playerTurnFold", getRootElement(), playerTurnFold_func )

function getPlayerPokerID ( player )

	-- get the poker-ID of the player, responsible for his money / seat / ect.
	for i = 1, 6 do
		if _G["pokerPlayer"..i] == player then
			return i
		end
	end
end

function getHighestCall ()

	-- get the highest call
	local highest = 0
	for i = 1, 6 do
		if _G["pokerPlayer"..i.."Bet"] > highest then
			highest = _G["pokerPlayer"..i.."Bet"]
		end
	end
	return highest
end

function nextRoundPlayer ()

	-- After a player decides to call / raise / whatever
	if isTimer ( timeoutTimer ) then
		killTimer ( timeoutTimer )
	end
	sucess = true
	p1, p2, p3, p4, p5, p6, p1s, p2s, p3s, p4s, p5s, p6s = getPokerPlayerStats()
	for i = 1, 6 do
		if _G["pokerPlayer"..i] then
			triggerClientEvent ( _G["pokerPlayer"..i], "refreshPokerVarbs", getRootElement(), _G["pokerPlayer"..i.."Bet"], curPokerPot, getHighestCall(), _G["pokerPlayer"..i.."Money"], p1, p2, p3, p4, p5, p6, p1s, p2s, p3s, p4s, p5s, p6s )
		end
	end
	counter = 0
	for i = 1, 6 do
		if _G["pokerPlayer"..i.."In"] then
			counter = counter + 1
			pokerCPlayerFolder = i
			if _G["pokerPlayer"..i.."Bet"] ~= getHighestCall () and _G["pokerPlayer"..i.."Money"] ~= 0 then
				sucess = false
			end
		end
	end
	if counter == 0 then
		sendMessageToAllPokerPlayers ( "Round ended!", 0, 125, 0 )
		resetPokerValues()
	elseif counter == 1 then
		sendMessageToAllPokerPlayers ( "Round ended - won by Fold: "..getPlayerName(_G["pokerPlayer"..pokerCPlayerFolder]).."!", 0, 125, 0 )
		_G["pokerPlayer"..pokerCPlayerFolder.."Money"] = _G["pokerPlayer"..pokerCPlayerFolder.."Money"] + curPokerPot
		for i = 1, 6 do
			if _G["pokerPlayer"..i] then
				triggerClientEvent ( _G["pokerPlayer"..i], "hidePokerPlayerBtns", getRootElement() )
			end
		end
		resetPokerValues()
	else
		if curPokerPlayer == curPokerBlindPlayer then
			pokerFirstLoop = true
		elseif not _G["pokerPlayer"..curPokerBlindPlayer.."In"] then
			if curPokerPlayer == getPrevPlayerAtPoker ( curPokerBlindPlayer )  then
				pokerFirstLoop = true
			end
		end
		if not sucess or not pokerFirstLoop then
			nextPlayer()
			pokerFirstLoop = false
		elseif curPokerRound == 0 then
			showFlop()
			pokerFirstLoop = false
		elseif curPokerRound == 1 then
			showTurn()
			pokerFirstLoop = false
		elseif curPokerRound == 2 then
			showRiver()
			pokerFirstLoop = false
		elseif curPokerRound == 3 then
			getWinner()
			pokerFirstLoop = false
		end
	end
end

function setPlayerLeavingPoker_func ( player, id )

	-- If someone leaves the game, for e.g. by disconnect
	-- or "timeout"
	triggerEvent ( "playerTurnFold", player )
	if not id then
		id = getPlayerPokerID ( player )
	end
	if isElement ( player ) then
		setElementFrozen ( player, false )
		local x,y,z = getElementPosition(getElementData(player,"pokerCurrentEntrance"))
		setElementPosition ( player, x,y,z+1)-- -2504.489, 2362.214, 4.634 )
		setElementInterior ( player, 0 )
		setCameraTarget ( player, player )
		toggleAllControls ( player, true, true, true )
		setPedAnimation ( player )
		showCursor ( player, false )
		setElementData ( player, "ElementClicked", false )
		sendMessageToAllPokerPlayers ( getPlayerName(player).." left the game!", 200, 200, 0 )
		triggerClientEvent ( player, "hidePokerDisplay", getRootElement() )
	end
	_G["pokerPlayer"..id] = false
	_G["pokerPlayer"..id.."HandValue"] = 11
	_G["pokerPlayer"..id.."Bet"] = 0
	_G["pokerPlayer"..id.."Money"] = 0
	_G["pokerPlayer"..id.."In"] = false
	pokerCurPlayers = pokerCurPlayers - 1
	if curPokerPlayer == id then
		nextPlayer ()
	end
end
addEvent ( "setPlayerLeavingPoker", true )
addEventHandler ( "setPlayerLeavingPoker", getRootElement(), setPlayerLeavingPoker_func )

-- If a player quits whos playing at the moment
function pokerPlayerQuit ()
	for i = 1, 6 do
		if _G["pokerPlayer"..i] == source then
			setPlayerLeavingPoker_func ( source )
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), pokerPlayerQuit )

-- start the turn of the next player
function nextPlayer ()

	if not curPokerPlayer then
		curPokerPlayer = getNextPlayerAtPoker ( getNextPlayerAtPoker ( getNextPlayerAtPoker ( 0 ) ) )
	end
	curPokerPlayer = getNextPlayerAtPoker ( curPokerPlayer )
	sendMessageToAllPokerPlayers ( getPlayerName(_G["pokerPlayer"..curPokerPlayer]).."'s turn!", 0, 0, 170 )
	outputChatBox ( "Current call: "..getHighestCall()..", your call: ".._G["pokerPlayer"..curPokerPlayer.."Bet"], _G["pokerPlayer"..curPokerPlayer], 150, 150, 25 )
	if isTimer ( timeoutTimer ) then
		killTimer ( timeoutTimer )
	end
	local player = _G["pokerPlayer"..curPokerPlayer]
	timeoutTimer = setTimer ( setPlayerLeavingPoker_func, 30000, 1, player, curPokerPlayer )
	triggerClientEvent ( _G["pokerPlayer"..curPokerPlayer], "turnBegin", getRootElement() )
end

-- show the flop to the players
function showFlop()

	communityCard1 = getNewCard()
	communityCard2 = getNewCard()
	communityCard3 = getNewCard()
	for i = 1, 6 do
		_G["pokerPlayer"..i.."Bet"] = 0
	end
	for i = 1, 6 do
		if _G["pokerPlayer"..i] then
			triggerClientEvent ( _G["pokerPlayer"..i], "refreshPokerCommunityCards", getRootElement(), communityCard1, communityCard2, communityCard3 )
		end
	end
	curPokerRound = curPokerRound + 1
	nextPlayer ()
end

-- show the turn to the players
function showTurn()

	communityCard4 = getNewCard()
	for i = 1, 6 do
		_G["pokerPlayer"..i.."Bet"] = 0
	end
	for i = 1, 6 do
		if _G["pokerPlayer"..i] then
			triggerClientEvent ( _G["pokerPlayer"..i], "refreshPokerCommunityCards", getRootElement(), communityCard1, communityCard2, communityCard3, communityCard4 )
		end
	end
	curPokerRound = curPokerRound + 1
	nextPlayer ()
end

-- show the river to the players
function showRiver()

	communityCard5 = getNewCard()
	for i = 1, 6 do
		_G["pokerPlayer"..i.."Bet"] = 0
	end
	for i = 1, 6 do
		if _G["pokerPlayer"..i] then
			triggerClientEvent ( _G["pokerPlayer"..i], "refreshPokerCommunityCards", getRootElement(), communityCard1, communityCard2, communityCard3, communityCard4, communityCard5 )
		end
	end
	curPokerRound = curPokerRound + 1
	nextPlayer ()
end

-- force the clients to "tell" their hand-values
function getWinner()

	for i = 1, 6 do
		if _G["pokerPlayer"..i] and  _G["pokerPlayer"..i.."In"] then
			triggerClientEvent ( _G["pokerPlayer"..i], "getPlayerBestHand", getRootElement(), communityCard1, communityCard2, communityCard3, communityCard4, communityCard5, _G["pokerPlayer"..i.."card1"], _G["pokerPlayer"..i.."card2"] )
		else
			_G["pokerPlayer"..i.."HandValue"] = 11
		end
	end
	setTimer ( finalCheck, 2000, 1 )
end

function finalCheck ()

	curWinnerValue = 11
	pokerPlayer0HandSecValue = 0
	curWinner = 0
	curWinners = 0
	curWinnersList = nil
	curWinnersList = {}
	for i = 1, 6 do
		if _G["pokerPlayer"..i.."In"] then
			val = _G["pokerPlayer"..i.."HandValue"]
			-- If a player has a better hand than the current "winner"
			-- "<" instead ">", because smaller values are better hands
			if _G["pokerPlayer"..i.."HandValue"] < curWinnerValue then
				curWinnerValue = _G["pokerPlayer"..i.."HandValue"]
				curWinner = i
				curWinners = 1
				curWinnersList = nil
				curWinnersList = {}
				table.insert ( curWinnersList, curWinner )
			-- if the current "winner" has the same hand as a player
			elseif _G["pokerPlayer"..i.."HandValue"] == curWinnerValue then
				if val == 3 or val == 6 or val == 7 or val == 9 then
					if _G["pokerPlayer"..i.."HandSecValue"] and _G["pokerPlayer"..curWinner.."HandSecValue"] then
						if _G["pokerPlayer"..i.."HandSecValue"] > _G["pokerPlayer"..curWinner.."HandSecValue"] then
							curWinner = i
							curWinners = 1
							curWinnersList = nil
							curWinnersList = {}
							table.insert ( curWinnersList, i )
						-- if they've got the same "hand value"
						elseif _G["pokerPlayer"..i.."HandSecValue"] ==_G["pokerPlayer"..curWinner.."HandSecValue"] then
							curWinners = curWinners + 1
							table.insert ( curWinnersList, i )
						end
					end
				else
					-- choose the highcard
					if getPlayerHighCard ( i ) > getPlayerHighCard ( curWinner ) then
						curWinner = i
						curWinners = 1
						curWinnersList = nil
						curWinnersList = {}
						table.insert ( curWinnersList, i )
					-- if they've got the same highcard
					elseif getPlayerHighCard ( i ) == getPlayerHighCard ( curWinner ) then
						curWinners = curWinners + 1
						table.insert ( curWinnersList, i )
					end
				end
			end
		end
	end
	if curWinners == 1 then
		local winnername = getPlayerName(_G["pokerPlayer"..curWinner])
		local value = handValueNames[_G["pokerPlayer"..curWinner.."HandValue"]]
		local h1 = pokerColorOutNames[getCardColor(_G["pokerPlayer"..curWinner.."card1"])].." "..cardIDTypeOutName[getCardType(_G["pokerPlayer"..curWinner.."card1"])]
		local h2 = pokerColorOutNames[getCardColor(_G["pokerPlayer"..curWinner.."card2"])].." "..cardIDTypeOutName[getCardType(_G["pokerPlayer"..curWinner.."card2"])]
		-- if the winner was "all in"
		-- if the winner was "all in"
		if _G["pokerPlayer"..curWinner.."Money"] <= 0 then
			_G["pokerPlayer"..curWinner.."Money"] = curPokerPot - _G["pokerPlayer"..curWinner.."TotalBet"] * 2
			curPokerPot = curPokerPot - _G["pokerPlayer"..curWinner.."TotalBet"] * 2
			sendMessageToAllPokerPlayers ( winnername.." winns with "..value..". ( Hand: "..h1..", "..h2.." ), "..(_G["pokerPlayer"..curWinner.."TotalBet"] * 2).." chips", 0, 125, 0 )
			if curPokerPot > 0 then
				counter = 0
				for i = 1, 6 do
					if _G["pokerPlayer"..i.."In"] then
						if i == curWinner then
						else
							counter = counter + 1
						end
					end
				end
				local amount = math.floor ( curPokerPot / counter )
				sendMessageToAllPokerPlayers ( "The remaining "..curPokerPot.." chips will be split!", 0, 125, 0 )
				for i = 1, 6 do
					if _G["pokerPlayer"..i.."In"] then
						if i == curWinner then
						else
							_G["pokerPlayer"..i.."Money"] = _G["pokerPlayer"..i.."Money"] + amount
						end
					end
				end
				resetPokerValues()
			end
		else
			sendMessageToAllPokerPlayers ( winnername.." winns with a "..value..". ( Hand: "..h1..", "..h2.." ), "..curPokerPot.." chips", 0, 125, 0 )
			_G["pokerPlayer"..curWinner.."Money"] = _G["pokerPlayer"..curWinner.."Money"] + curPokerPot
			resetPokerValues()
		end
	else
		winnernames = nil
		counter = 0
		for i, key in ipairs ( curWinnersList ) do
			counter = counter + 1
			if winnernames then
				local h1 = pokerColorOutNames[getCardColor(_G["pokerPlayer"..i.."card1"])].." "..cardIDTypeOutName[getCardType(_G["pokerPlayer"..i.."card1"])]
				local h2 = pokerColorOutNames[getCardColor(_G["pokerPlayer"..i.."card2"])].." "..cardIDTypeOutName[getCardType(_G["pokerPlayer"..i.."card2"])]
				winnernames = winnernames..", "..getPlayerName(_G["pokerPlayer"..i]).." ("..h1..", "..h2..")"
			else
				local h1 = pokerColorOutNames[getCardColor(_G["pokerPlayer"..i.."card1"])].." "..cardIDTypeOutName[getCardType(_G["pokerPlayer"..i.."card1"])]
				local h2 = pokerColorOutNames[getCardColor(_G["pokerPlayer"..i.."card2"])].." "..cardIDTypeOutName[getCardType(_G["pokerPlayer"..i.."card2"])]
				winnernames = getPlayerName(_G["pokerPlayer"..i]).." ("..h1..","..h2..")"
			end
		end
		local splot = math.floor ( curPokerPot / counter )
		sendMessageToAllPokerPlayers ( "Split pot between: "..winnernames..", "..splot.." chips ( each )!", 0, 125, 0 )
		for i, key in ipairs ( curWinnersList ) do
			_G["pokerPlayer"..i.."Money"] = _G["pokerPlayer"..i.."Money"] + splot
		end
		resetPokerValues()
	end
end

function resetPokerValues ()

	-- Reset the values when a round is finished
	pokerRoundStarted = false
	pokerFirstLoop = false
	curPokerRound = 0
	curPokerPlayer = false
	curPokerPot = 0
	curPokerBlindPlayer = getNextPlayerAtPoker ( curPokerBlindPlayer )
	for i = 1, 6 do
		if _G["pokerPlayer"..i] then
			_G["pokerPlayer"..i.."In"] = true
		else
			_G["pokerPlayer"..i.."In"] = false
		end
		_G["pokerPlayer"..i.."TotalBet"] = 0
		_G["pokerPlayer"..i.."Bet"] = 0
		_G["pokerPlayer"..i.."HandValue"] = 0
		_G["communityCard"..i] = 0
	end
	p1, p2, p3, p4, p5, p6, p1s, p2s, p3s, p4s, p5s, p6s = getPokerPlayerStats()
	for i = 1, 6 do
		if _G["pokerPlayer"..i] then
			setTimer ( triggerClientEvent, 3000, 1, _G["pokerPlayer"..i], "refreshPokerCommunityCards", getRootElement() )
			setTimer ( triggerClientEvent, 3000, 1, _G["pokerPlayer"..i], "refreshPokerVarbs", getRootElement(), _G["pokerPlayer"..i.."Bet"], curPokerPot, getHighestCall(), _G["pokerPlayer"..i.."Money"], p1, p2, p3, p4, p5, p6, p1s, p2s, p3s, p4s, p5s, p6s )
		end
	end
	if isTimer ( roundCheckTimer ) then
		killTimer ( roundCheckTimer )
	end
	roundCheckTimer = setTimer ( roundCheck, 7500, 1 )
end

function getNextPlayerAtPoker ( id )

	-- get the next player ( clockwise )
	if id then
		for i = id, 6 do
			if _G["pokerPlayer"..i] and _G["pokerPlayer"..i.."In"] and i ~= id then
				return i
			end
		end
		for i = 1, 6 do
			if _G["pokerPlayer"..i] and _G["pokerPlayer"..i.."In"] and i ~= id then
				return i
			end
		end
	end
	return false
end

function getPrevPlayerAtPoker ( id )

	-- get the next player ( counter-clockwise )
	if id then
		for i = id, 0, -1 do
			if _G["pokerPlayer"..i] and _G["pokerPlayer"..i.."In"] and i ~= id then
				return i
			end
		end
		for i = 6, 0, -1 do
			if _G["pokerPlayer"..i] and _G["pokerPlayer"..i.."In"] and i ~= id then
				return i
			end
		end
	end
	return false
end

function getPlayerHighCard ( id )

	if id > 0 then
		local card1 = getCardType ( _G["pokerPlayer"..id.."card1"] )
		local card2 = getCardType ( _G["pokerPlayer"..id.."card2"] )
		for i = 1, 5 do
			_G["card"..(i+2)] = _G["communityCard"..i]
		end
		curBest = card1
		for i = 2, 7 do
			if curBest < _G["card"..i] then
				curBest = _G["card"..i]
			end
		end
		return curBest
	end
	return -1
end

function handRecieveFromClient_func ( value, sec )

	-- retrieve the hand-value from the client
	local id = getPlayerPokerID ( source )
	_G["pokerPlayer"..id.."HandValue"] = value
	if sec then
		_G["pokerPlayer"..id.."HandSecValue"] = sec
	end
end
addEvent ( "handRecieveFromClient", true )
addEventHandler ( "handRecieveFromClient", getRootElement(), handRecieveFromClient_func )

function sendMessageToAllPokerPlayers ( text, r, g, b )

	-- send a message to all current players
	for i = 1, 6 do
		local player = _G["pokerPlayer"..i]
		if player then
			if isElement ( player ) then
				outputChatBox ( text, player, r, g, b )
			end
		end
	end
end

function getNewCard()

	-- get a new card from the "stack"
	while true do
		local card = math.random ( 1, 52 )
		if not cardsInUse[card] then
			table.insert ( cardsInUse, card )
			cardsInUse[card] = true
			return card
		end
	end
end

function getPokerPlayerStats ()

	-- get the stats for the client
	for i = 1, 6 do
		if _G["pokerPlayer"..i.."In"] then
			_G["p"..i.."s"] = true
		else
			_G["p"..i.."s"] = false
		end
		if _G["pokerPlayer"..i] then
			_G["p"..i] = "(".._G["pokerPlayer"..i.."Money"]..") "..getPlayerName ( _G["pokerPlayer"..i] )
		else
			_G["p"..i] = ""
		end
	end
	return p1, p2, p3, p4, p5, p6, p1s, p2s, p3s, p4s, p5s, p6s
end