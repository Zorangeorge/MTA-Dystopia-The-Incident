-----------------
--- (c) 2010 ----
--- by Zipper ---
-----------------

--[[
I think there is no explanation needet here,
but be VERY carefull if you're changing something
here!!!

Btw., there are some german words like "karo" in here,
but they aren't shown in the game - just for the images...

It can be that some algorithms for the hands aren't correct -
please tell me about it, they are all selfmade!
]]

pokerColors = {}
pokerColorsShort = {}
pokerColorNames = {}
pokerColorOutNames = {}

pokerCardsNames = {}

cardIDTypeName = {}

handValueNames = {}

pokerColors = {
 [1]="red",
 [2]="red",
 [3]="black",
 [4]="black"
}
pokerColorsShort = {
 [1]="r",
 [2]="r",
 [3]="b",
 [4]="b"
}

pokerColorNames = {
 [1]="karo",
 [2]="herz",
 [3]="pik",
 [4]="kreuz"
}

pokerColorOutNames = {
 [1]="Diamonds",
 [2]="Hearts",
 [3]="Spades",
 [4]="Clubs"
}

cardIDTypeOutName = {
 [1]="2",
 [2]="3",
 [3]="4",
 [4]="5",
 [5]="6",
 [6]="7",
 [7]="8",
 [8]="9",
 [9]="10",
 [10]="Jack",
 [11]="Queen",
 [12]="King",
 [13]="Ace"
}

cardIDTypeName = {
 [1]="2",
 [2]="3",
 [3]="4",
 [4]="5",
 [5]="6",
 [6]="7",
 [7]="8",
 [8]="9",
 [9]="10",
 [10]="j",
 [11]="q",
 [12]="k",
 [13]="a"
}

handValueNames = {
 [1]="Royal Flush",
 [2]="Straigt Flush",
 [3]="Four of a Kind",
 [4]="Full House",
 [5]="Flush",
 [6]="Straight",
 [7]="Three of a Kind",
 [8]="Double Pair",
 [9]="Pair",
 [10]="Highcard",
 [11]="Side out"
}

function createPokerTables ()

	for i = 1, 52 do
		local cardColor = pokerColorOutNames [ getCardColor ( i ) ]
		local cardName = getCardName ( i )
		table.insert ( pokerCardsNames, i )
		pokerCardsNames[i] = cardColor.." "..cardName
	end
end

function getCardColor ( cardID )

	if cardID <= 13 then
		return 1
	elseif cardID <= 26 then 
		return 2
	elseif cardID <= 39 then
		return 3
	else
		return 4
	end
end

function getCardName ( id )

	if id then
		if id > 13 and id <= 26 then 
			id = id - 13 * 1
		elseif id > 26 and id <= 39 then
			id = id - 13 * 2
		elseif id > 39 then
			id = id - 13 * 3
		end
		return cardIDTypeOutName[id]
	end
end

function getCardType ( id )

	if id then
		if id > 13 and id <= 26 then 
			id = id - 13 * 1
		elseif id > 26 and id <= 39 then
			id = id - 13 * 2
		elseif id > 39 then
			id = id - 13 * 3
		end
		return id
	end
end

function getCardSpezType ( id )

	if id then
		if id > 13 and id <= 26 then 
			id = id - 13 * 1
		elseif id > 26 and id <= 39 then
			id = id - 13 * 2
		elseif id > 39 then
			id = id - 13 * 3
		end
		if id == 10 or id == 11 or id == 12 then
			return 2
		else
			return 1
		end
	end
end

function getFittingPicture ( id )

	if getCardType ( id ) == 10 then
		return "j"
	elseif getCardType ( id ) == 11 then
		return "q"
	elseif getCardType ( id ) == 12 then
		return "k"
	end
end

function getFittingSymbol ( card )

	return pokerColorNames[getCardColor ( card )]
end

createPokerTables ()

function getPlayerBestHand_func ( card1, card2, card3, card4, card5, card6, card7 )

	communityCard1 = card1
	communityCard2 = card2
	communityCard3 = card3
	communityCard4 = card4
	communityCard5 = card5
	communityCard6 = card6
	communityCard7 = card7
	sv = nil
	if hasPlayerRoyalFlush ( card1, card2 ) then
		v = 1
	elseif hasPlayerStraightFlush ( card1, card2 ) then
		v = 2
	elseif hasPlayerFourOfAKind ( card1, card2 ) then
		v = 3
		bool, sv = hasPlayerFourOfAKind ( card1, card2 )
	elseif hasPlayerFullHouse ( card1, card2 ) then
		v = 4
	elseif hasPlayerFlush () then
		v = 5
	elseif hasPlayerStraight ( card1, card2 ) then
		v = 6
		bool, sv = hasPlayerStraight ( card1, card2 )
	elseif hasPlayerThreeOfAKind ( card1, card2 ) then
		v = 7
	elseif hasPlayerDoublePair ( card1, card2 ) then
		v = 8
	elseif hasPlayerPair ( card1, card2 ) then
		v = 9
		bool, sv = hasPlayerPair ( card1, card2 )
	else
		v = 10
	end
	if tonumber ( sv ) then
		triggerServerEvent ( "handRecieveFromClient", lp, v, sv )
	else
		triggerServerEvent ( "handRecieveFromClient", lp, v )
	end
end
addEvent ( "getPlayerBestHand", true )
addEventHandler ( "getPlayerBestHand", getRootElement(), getPlayerBestHand_func )

function hasPlayerPair ( card1, card2 )

	for i = 1, 7 do
		for k = 1, 7 do
			if ( getCardType(_G["communityCard"..k]) == getCardType(_G["communityCard"..i]) ) and k ~= i then
				return true, getCardType(_G["communityCard"..k])
			end
		end
	end
	return false
end

function hasPlayerDoublePair ( card1, card2 )

	double = 0
	for i = 1, 7 do
		for k = 1, 7 do
			if ( getCardType(_G["communityCard"..k] ) == getCardType(_G["communityCard"..i]) ) and k ~= i then
				double = double + 1
			end
		end
	end
	if double >= 3 then
		return true
	end
	return false
end

function hasPlayerThreeOfAKind ( card1, card2 )

	for i = 1, 7 do
		for k = 1, 7 do
			for h = 1, 7 do
				if i ~= k and i ~= h and k ~= h then
					if getCardType(_G["communityCard"..i]) == getCardType(_G["communityCard"..k]) and getCardType(_G["communityCard"..k]) == getCardType(_G["communityCard"..h]) then
						return true, getCardType(_G["communityCard"..i])
					end
				end
			end
		end
	end
	return false
end

function hasPlayerStraight ( card1, card2 )

	for i = 1, 13 do
		_G["sc"..i] = false
	end
	for i = 1, 7 do
		local cType = getCardType(_G["communityCard"..i])
		if not _G["sc"..cType] then
			_G["sc"..cType] = true
		end
	end
	for i = 1, 9 do
		if _G["sc"..(i+0)] and _G["sc"..(i+1)] and _G["sc"..(i+2)] and _G["sc"..(i+3)] and _G["sc"..(i+4)] then
			return true, _G["sc"..(i+4)]
		end
	end
	return false
end

function hasPlayerFlush ()

	color1Counter = 0
	color2Counter = 0
	color3Counter = 0
	color4Counter = 0
	for i = 1, 7 do
		color = getCardColor ( _G["communityCard"..i] )
		_G["color"..color.."Counter"] = _G["color"..color.."Counter"] + 1
	end
	if color1Counter >= 5 or color2Counter >= 5 or color3Counter >= 5 or color4Counter >= 5 then
		return true
	end
	return false
end

function hasPlayerFullHouse ( card1, card2 )

	bool, cType = hasPlayerThreeOfAKind ( card1, card2 )
	if bool then
		bool = false
		for i = 1, 7 do
			for k = 1, 7 do
				if ( getCardType(_G["communityCard"..k]) == getCardType(_G["communityCard"..i]) ) and k ~= i then
					if getCardType(_G["communityCard"..k]) ~= cType then
						bool = true
					end
				end
			end
		end
		if bool then
			return true
		end
	end
	return false
end

function hasPlayerFourOfAKind ( card1, card2 )

	for i = 1, 13 do
		_G["cardType"..i.."Counter"] = 0
	end
	for i = 1, 7 do
		local cType = getCardType ( _G["communityCard"..i] )
		_G["cardType"..cType.."Counter"] = _G["cardType"..cType.."Counter"] + 1
	end
	local quad = false
	for i = 1, 7 do
		if _G["cardType"..getCardType ( _G["communityCard"..i] ).."Counter"] == 4 then
			quad = true
			quadNR = getCardType ( _G["communityCard"..i] )
		end
	end
	if quad then
		return true, quadNR
	end
	return false
end

function hasPlayerStraightFlush ( card1, card2 )

	if hasPlayerFlush ( card1, card2 ) and hasPlayerStraight ( card1, card2 ) then
		return true
	else
		return false
	end
end

function hasPlayerRoyalFlush ( card1, card2 )

	local straigtCards = nil
	local straigtCards = {}
	for i = 1, 7 do
		table.insert ( straigtCards, getCardType(i) )
		straigtCards[getCardType(i)] = true
	end
	for i = 1, 8 do
		if i+4 == 13 then
			if straigtCards[i] == true and straigtCards[i+1] == true and straigtCards[i+2] == true and straigtCards[i+3] == true and straigtCards[i+4] == true then
				if getCardColor ( _G["communityCard"..i] ) == getCardColor ( _G["communityCard"..i+1] ) == getCardColor ( _G["communityCard"..i+2] ) == getCardColor ( _G["communityCard"..i+3] ) == getCardColor ( _G["communityCard"..i+4] ) then
					return true
				end
			end
		end
	end
	return false
end