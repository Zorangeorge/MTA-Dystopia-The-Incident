-----------------
--- (c) 2010 ----
--- by Zipper ---
-----------------

--[[
I think there is no explanation needet here.
]]

pokerCurBets = 0
pokerCurOwnChips = 1
block = false

pokerMoneyPositions = {}
	pokerMoneyPositions[1] = {}
		pokerMoneyPositions[1]["x"] = 1118.4542236328
		pokerMoneyPositions[1]["y"] = 11.419797897339
		pokerMoneyPositions[1]["z"] = 1002.0599365234
	pokerMoneyPositions[2] = {}
		pokerMoneyPositions[2]["x"] = 1118.8343505859
		pokerMoneyPositions[2]["y"] = 10.888602256775
		pokerMoneyPositions[2]["z"] = 1002.0599365234
	pokerMoneyPositions[3] = {}
		pokerMoneyPositions[3]["x"] = 1118.779296875
		pokerMoneyPositions[3]["y"] = 12.075232505798
		pokerMoneyPositions[3]["z"] = 1002.0599365234
	pokerMoneyPositions[4] = {}
		pokerMoneyPositions[4]["x"] = 1119.171020507
		pokerMoneyPositions[4]["y"] = 12.28514957428
		pokerMoneyPositions[4]["z"] = 1002.0599365234
	pokerMoneyPositions[5] = {}
		pokerMoneyPositions[5]["x"] = 1119.7019042969
		pokerMoneyPositions[5]["y"] = 12.054441452026
		pokerMoneyPositions[5]["z"] = 1002.0599365234
	pokerMoneyPositions[6] = {}
		pokerMoneyPositions[6]["x"] = 1119.9338378906
		pokerMoneyPositions[6]["y"] = 11.458479881287
		pokerMoneyPositions[6]["z"] = 1002.0599365234
		
gWindow = {}
gImage = {}
gButton = {}
gEdit = {}
gLabel = {}
screenwidth, screenheight = guiGetScreenSize()
lp = getLocalPlayer()

function showPokerHand_func ( card1, card2 )

	showPokerDisplay ()
	if gWindow["pokerOwnCards"] then
		guiSetVisible ( gWindow["pokerOwnCards"], true )
		for i = 1, 5 do
			if isElement ( gImage["cardDeko"..i] ) then
				destroyElement ( gImage["cardDeko"..i] )
			end
			if isElement ( gImage["cardDeko"..i] ) then
				destroyElement ( gImage["cardDeko"..i] )
			end
		end
	else
		gWindow["pokerOwnCards"] = guiCreateWindow(screenwidth-303,screenheight-20,303,265,"Own Hand",false)
		guiSetAlpha(gWindow["pokerOwnCards"],1)
		guiWindowSetSizable( gWindow["pokerOwnCards"], false )
		guiWindowSetMovable ( gWindow["pokerOwnCards"], false )
		addEventHandler ( "onClientMouseEnter", gWindow["pokerOwnCards"], showUpPokerHand )
		pokerGuiState = false
	end
	if card1 and card2 then	
		ownHandCard1 = card1
		ownHandCard2 = card2
		createPokerCard ( card1, 0.0297, 0.0906, 0.4422, 0.8642, gWindow["pokerOwnCards"], 1 )
		createPokerCard ( card2, 0.4818, 0.0943, 0.4521, 0.8566, gWindow["pokerOwnCards"], 2 )
	end
end
addEvent ( "showPokerHand", true )
addEventHandler ( "showPokerHand", getRootElement(), showPokerHand_func )

function showUpPokerHand ()

	guiSetPosition ( gWindow["pokerOwnCards"], screenwidth-303, screenheight-265, false )
	removeEventHandler ( "onClientMouseEnter", gWindow["pokerOwnCards"], showUpPokerHand )
	addEventHandler ( "onClientMouseLeave", gWindow["pokerOwnCards"], hideDownPokerHand )
end
function hideDownPokerHand ()

	guiSetPosition ( gWindow["pokerOwnCards"], screenwidth-303, screenheight-20, false )
	removeEventHandler ( "onClientMouseLeave", gWindow["pokerOwnCards"], hideDownPokerHand )
	addEventHandler ( "onClientMouseEnter", gWindow["pokerOwnCards"], showUpPokerHand )
end
	
function turnBegin_func ()

	guiSetVisible ( gImage["cardBG1"], true )
	guiSetVisible ( gImage["cardBG2"], true )
	if pokerCurOwnChips > 0 then
		guiSetAlpha(gButton["pokerCheck"],1)
		guiSetAlpha(gButton["pokerCall"],1)
		guiSetAlpha(gButton["pokerFold"],1)
		guiSetAlpha(gButton["pokerRaise"],1)
		guiSetAlpha(gButton["pokerLeave"],1)
		guiSetAlpha(gEdit["pokerRaiseAmount"],1)
		block = true
	else
		triggerServerEvent ( "playerTurnCall", lp, lp )
	end
end
addEvent ( "turnBegin", true )
addEventHandler ( "turnBegin", getRootElement(), turnBegin_func )

function createPokerCard ( card, x, y, w, h, parentElement, cardNR )

	if card then
		if card > 0 then
			if not ( getCardType ( card ) == 10 or getCardType ( card ) == 11 or getCardType ( card ) == 12 ) then
				gImage["cardBG"..cardNR] = guiCreateStaticImage(x,y,w,h,"images/cards/images/bg.png",true,parentElement)
				guiSetAlpha(gImage["cardBG"..cardNR],1)
				local pfad = "images/cards/"..pokerColors[getCardColor(card)].."/"..cardIDTypeName[getCardType(card)].."_"..pokerColorsShort[getCardColor(card)]..".png"
				gImage["cardDeko1"..cardNR] = guiCreateStaticImage(0.0373,0.0306,0.1716,0.1179,pfad,true,gImage["cardBG"..cardNR])
				guiSetAlpha(gImage["cardDeko1"..cardNR],1)
				gImage["cardDeko2"..cardNR] = guiCreateStaticImage(0.7985,0.8646,0.1866,0.1266,pfad,true,gImage["cardBG"..cardNR])
				guiSetAlpha(gImage["cardDeko2"..cardNR],1)
				gImage["cardDeko3"..cardNR] = guiCreateStaticImage(0.291,0.3231,0.4403,0.3231,"images/cards/symbols/"..getFittingSymbol(card)..".png",true,gImage["cardBG"..cardNR])
				guiSetAlpha(gImage["cardDeko3"..cardNR],1)
				gImage["cardDeko4"..cardNR] = guiCreateStaticImage(0.0448,0.8515,0.2015,0.1354,"images/cards/symbols/"..getFittingSymbol(card)..".png",true,gImage["cardBG"..cardNR])
				guiSetAlpha(gImage["cardDeko4"..cardNR],1)
				gImage["cardDeko5"..cardNR] = guiCreateStaticImage(0.7687,0.0218,0.2015,0.1354,"images/cards/symbols/"..getFittingSymbol(card)..".png",true,gImage["cardBG"..cardNR])
				guiSetAlpha(gImage["cardDeko5"..cardNR],1)
			else
				gImage["cardBG"..cardNR] = guiCreateStaticImage(x,y,w,h,"images/cards/images/bg.png",true,parentElement)
				guiSetAlpha(gImage["cardBG"..cardNR],1)
				local pfad = "images/cards/"..pokerColors[getCardColor(card)].."/"..cardIDTypeName[getCardType(card)].."_"..pokerColorsShort[getCardColor(card)]..".png"
				gImage["cardDeko1"..cardNR] = guiCreateStaticImage(0.0694,0.1398,0.8681,0.75,"images/cards/images/"..getFittingPicture(card)..".png",true,gImage["cardBG"..cardNR])
				gImage["cardDeko2"..cardNR] = guiCreateStaticImage(0.792,0.8475,0.168,0.1243,"images/cards/symbols/"..getFittingSymbol(card)..".png",true,gImage["cardDeko1"..cardNR])
				gImage["cardDeko3"..cardNR] = guiCreateStaticImage(0.0347,0.0339,0.125,0.0975,pfad,true,gImage["cardBG"..cardNR])
				gImage["cardDeko4"..cardNR] = guiCreateStaticImage(0.8542,0.9025,0.125,0.0975,pfad,true,gImage["cardBG"..cardNR])
				gImage["cardDeko5"..cardNR] = guiCreateStaticImage(0.0903,0.1568,0.1458,0.0847,"images/cards/symbols/"..getFittingSymbol(card)..".png",true,gImage["cardBG"..cardNR])
			end
		end
	end
end

function setVarbs_func ( varb, value )

	_G[varb] = value
end
addEvent ( "setVarbs", true )
addEventHandler ( "setVarbs", getRootElement(), setVarbs_func )

function refreshPokerVarbs_func ( ownBet, curpot, curbet, curchips, p1, p2, p3, p4, p5, p6, p1s, p2s, p3s, p4s, p5s, p6s )

	guiSetText ( gLabel["pokerPotAmount"], curpot.." $" )
	pokerCurBets = curbet
	pokerCurOwnChips = curchips
	curOwnBet = ownBet
	
	guiBringToFront ( gImage["cardBG1"] )
	guiBringToFront ( gImage["cardBG2"] )

	guiSetText ( gLabel["pokerPlayer1"], p1 )
	if p1s then
		guiLabelSetColor(gLabel["pokerPlayer1"],000,125,000)
	else
		guiLabelSetColor(gLabel["pokerPlayer1"],125,000,000)
	end
	guiSetText ( gLabel["pokerPlayer2"], p2 )
	if p2s then
		guiLabelSetColor(gLabel["pokerPlayer2"],000,125,000)
	else
		guiLabelSetColor(gLabel["pokerPlayer2"],125,000,000)
	end
	guiSetText ( gLabel["pokerPlayer3"], p3 )
	if p3s then
		guiLabelSetColor(gLabel["pokerPlayer3"],000,125,000)
	else
		guiLabelSetColor(gLabel["pokerPlayer3"],125,000,000)
	end
	guiSetText ( gLabel["pokerPlayer4"], p4 )
	if p4s then
		guiLabelSetColor(gLabel["pokerPlayer4"],000,125,000)
	else
		guiLabelSetColor(gLabel["pokerPlayer4"],125,000,000)
	end
	guiSetText ( gLabel["pokerPlayer5"], p5 )
	if p5s then
		guiLabelSetColor(gLabel["pokerPlayer5"],000,125,000)
	else
		guiLabelSetColor(gLabel["pokerPlayer5"],125,000,000)
	end
	guiSetText ( gLabel["pokerPlayer6"], p6 )
	if p6s then
		guiLabelSetColor(gLabel["pokerPlayer6"],000,125,000)
	else
		guiLabelSetColor(gLabel["pokerPlayer6"],125,000,000)
	end
end
addEvent ( "refreshPokerVarbs", true )
addEventHandler ( "refreshPokerVarbs", getRootElement(), refreshPokerVarbs_func )

function hideBtns ()

	guiSetAlpha(gButton["pokerCheck"],0)
	guiSetAlpha(gButton["pokerCall"],0)
	guiSetAlpha(gButton["pokerFold"],0)
	guiSetAlpha(gButton["pokerRaise"],0)
	guiSetAlpha(gEdit["pokerRaiseAmount"],0)
	guiBringToFront ( gImage["cardBG1"] )
	guiBringToFront ( gImage["cardBG2"] )
end
addEvent ( "hidePokerPlayerBtns", true )
addEventHandler ( "hidePokerPlayerBtns", getRootElement(), hideBtns )

function hidePokerDisplay_func ()

	hideBtns()
	guiSetVisible ( gWindow["pokerCommunity"], false )
	guiSetVisible ( gWindow["pokerOwnCards"], false )
	block = false
end
addEvent ( "hidePokerDisplay", true )
addEventHandler ( "hidePokerDisplay", getRootElement(), hidePokerDisplay_func )

function showPokerDisplay ()

	if gWindow["pokerCommunity"] then
		guiSetVisible ( gWindow["pokerCommunity"], true )
	else
		gWindow["pokerCommunity"] = guiCreateWindow(screenwidth/2-450/2,screenheight/2-256/2,450,259,"Community Cards",false)
		guiSetAlpha(gWindow["pokerCommunity"],1)
		
		guiWindowSetSizable( gWindow["pokerCommunity"], false )
		guiWindowSetMovable ( gWindow["pokerCommunity"], false )
		
		gButton["pokerCheck"] = guiCreateButton(0.2443+0.17*-1+0.0251*-1,0.695,0.17,0.1351,"Check",true,gWindow["pokerCommunity"])
		guiSetAlpha(gButton["pokerCheck"],0)
		addEventHandler("onClientGUIClick", gButton["pokerCheck"],
			function ()
				if guiGetAlpha ( source ) == 1 and source == gButton["pokerCheck"] and block then
					if pokerCurBets == 0 or pokerCurBets == curOwnBet then
						triggerServerEvent ( "playerTurnCheck", lp, lp )
						block = false
						hideBtns()
					else
						outputChatBox ( "You can't check!", 125, 0, 0 )
					end
				end
			end
		)
		
		gButton["pokerCall"] = guiCreateButton(0.2443,0.695,0.17,0.1351,"Call",true,gWindow["pokerCommunity"])
		guiSetAlpha(gButton["pokerCall"],0)
		addEventHandler("onClientGUIClick", gButton["pokerCall"],
			function ()
				if guiGetAlpha ( source ) == 1 and source == gButton["pokerCall"] and block then
					if pokerCurBets == 0 or pokerCurBets == curOwnBet then
						triggerServerEvent ( "playerTurnCheck", lp, lp )
						block = false
						hideBtns()
					else
						triggerServerEvent ( "playerTurnCall", lp, lp )
						block = false
						hideBtns()
					end
				end
			end
		)
		
		gButton["pokerFold"] = guiCreateButton(0.2443+0.17+0.0251,0.695,0.17,0.1351,"Fold",true,gWindow["pokerCommunity"])
		guiSetAlpha(gButton["pokerFold"],0)
		addEventHandler("onClientGUIClick", gButton["pokerFold"],
			function ()
				if guiGetAlpha ( source ) == 1 and source == gButton["pokerFold"] and block then
					triggerServerEvent ( "playerTurnFold", lp )
					hideBtns()
					block = false
				end
			end
		)
		
		gButton["pokerRaise"] = guiCreateButton(0.2443+0.17*2+0.0251*2,0.695,0.1005,0.139,"Raise",true,gWindow["pokerCommunity"])
		guiSetAlpha(gButton["pokerRaise"],0)
		addEventHandler("onClientGUIClick", gButton["pokerRaise"],
			function ()
				if guiGetAlpha ( source ) == 1 and source == gButton["pokerRaise"] and block then
					local raiseAmount = math.floor(math.abs(tonumber(guiGetText(gEdit["pokerRaiseAmount"]))))
					if raiseAmount >= 10 then
						local raiseAmount = raiseAmount + ( pokerCurBets - curOwnBet )
						if pokerCurOwnChips >= raiseAmount then
							triggerServerEvent ( "playerTurnRaise", lp, raiseAmount )
							hideBtns()
							block = false
						else
							outputChatBox ( "Not enough chips left!", 125, 0, 0 )
						end
					else
						outputChatBox ( "At least 10!", 125, 0, 0 )
					end
				end
			end
		)
		
		gButton["pokerLeave"] = guiCreateButton(0.7717,0.8417,0.18491,0.1236,"Leave",true,gWindow["pokerCommunity"])
		guiSetAlpha(gButton["pokerLeave"],1)
		addEventHandler("onClientGUIClick", gButton["pokerLeave"],
			function ()
				if guiGetAlpha ( source ) == 1 and source == gButton["pokerLeave"] then
					triggerServerEvent ( "setPlayerLeavingPoker", lp, lp )
					hideBtns()
					guiSetVisible ( gWindow["pokerCommunity"], false )
					guiSetVisible ( gWindow["pokerOwnCards"], false )
				end
			end
		)
		
		gEdit["pokerRaiseAmount"] = guiCreateEdit(0.7717,0.7027,0.1849,0.1158,"",true,gWindow["pokerCommunity"])
		guiSetAlpha(gEdit["pokerRaiseAmount"],0)
		
		gLabel["pokerInfo1"] = guiCreateLabel(0.0205,0.8533,0.0571,0.0579,"Pot:",true,gWindow["pokerCommunity"])
		guiSetAlpha(gLabel["pokerInfo1"],1)
		guiLabelSetColor(gLabel["pokerInfo1"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["pokerInfo1"],"top")
		guiLabelSetHorizontalAlign(gLabel["pokerInfo1"],"left",false)
		guiSetFont(gLabel["pokerInfo1"],"default-bold-small")
		gLabel["pokerPotAmount"] = guiCreateLabel(0.0365,0.9189,0.1142,0.0811,"- $",true,gWindow["pokerCommunity"])
		guiSetAlpha(gLabel["pokerPotAmount"],1)
		guiLabelSetColor(gLabel["pokerPotAmount"],000,125,000)
		guiLabelSetVerticalAlign(gLabel["pokerPotAmount"],"top")
		guiLabelSetHorizontalAlign(gLabel["pokerPotAmount"],"left",false)
		guiSetFont(gLabel["pokerPotAmount"],"default-bold-small")
		gLabel["pokerInfo2"] = guiCreateLabel(0.1712,0.8456,0.121,0.0656,"Players:",true,gWindow["pokerCommunity"])
		guiSetAlpha(gLabel["pokerInfo2"],1)
		guiLabelSetColor(gLabel["pokerInfo2"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["pokerInfo2"],"top")
		guiLabelSetHorizontalAlign(gLabel["pokerInfo2"],"left",false)
		guiSetFont(gLabel["pokerInfo2"],"default-bold-small")
		
		gLabel["pokerPlayer1"] = guiCreateLabel(0.3,0.83,0.2,0.0656,"",true,gWindow["pokerCommunity"])
		guiSetAlpha(gLabel["pokerPlayer1"],1)
		guiLabelSetColor(gLabel["pokerPlayer1"],125,000,000)
		guiLabelSetVerticalAlign(gLabel["pokerPlayer1"],"top")
		guiLabelSetHorizontalAlign(gLabel["pokerPlayer1"],"left",false)
		guiSetFont(gLabel["pokerPlayer1"],"default-small")
		gLabel["pokerPlayer2"] = guiCreateLabel(0.3,0.88,0.2,0.063,"",true,gWindow["pokerCommunity"])
		guiSetAlpha(gLabel["pokerPlayer2"],1)
		guiLabelSetColor(gLabel["pokerPlayer2"],125,0,0)
		guiLabelSetVerticalAlign(gLabel["pokerPlayer2"],"top")
		guiLabelSetHorizontalAlign(gLabel["pokerPlayer2"],"left",false)
		guiSetFont(gLabel["pokerPlayer2"],"default-small")
		gLabel["pokerPlayer3"] = guiCreateLabel(0.3,0.93,0.2,0.063,"",true,gWindow["pokerCommunity"])
		guiSetAlpha(gLabel["pokerPlayer3"],1)
		guiLabelSetColor(gLabel["pokerPlayer3"],125,0,0)
		guiLabelSetVerticalAlign(gLabel["pokerPlayer3"],"top")
		guiLabelSetHorizontalAlign(gLabel["pokerPlayer3"],"left",false)
		guiSetFont(gLabel["pokerPlayer3"],"default-small")
		gLabel["pokerPlayer4"] = guiCreateLabel(0.55,0.83,0.2,0.063,"",true,gWindow["pokerCommunity"])
		guiSetAlpha(gLabel["pokerPlayer4"],1)
		guiLabelSetColor(gLabel["pokerPlayer4"],125,0,0)
		guiLabelSetVerticalAlign(gLabel["pokerPlayer4"],"top")
		guiLabelSetHorizontalAlign(gLabel["pokerPlayer4"],"left",false)
		guiSetFont(gLabel["pokerPlayer4"],"default-small")
		gLabel["pokerPlayer5"] = guiCreateLabel(0.55,0.88,0.2,0.063,"",true,gWindow["pokerCommunity"])
		guiSetAlpha(gLabel["pokerPlayer5"],1)
		guiLabelSetColor(gLabel["pokerPlayer5"],125,0,0)
		guiLabelSetVerticalAlign(gLabel["pokerPlayer5"],"top")
		guiLabelSetHorizontalAlign(gLabel["pokerPlayer5"],"left",false)
		guiSetFont(gLabel["pokerPlayer5"],"default-small")
		gLabel["pokerPlayer6"] = guiCreateLabel(0.55,0.93,0.2,0.063,"",true,gWindow["pokerCommunity"])
		guiSetAlpha(gLabel["pokerPlayer6"],1)
		guiLabelSetColor(gLabel["pokerPlayer6"],125,0,0)
		guiLabelSetVerticalAlign(gLabel["pokerPlayer6"],"top")
		guiLabelSetHorizontalAlign(gLabel["pokerPlayer6"],"left",false)
		guiSetFont(gLabel["pokerPlayer6"],"default-small")
	end
end

function refreshPokerCommunityCards_func ( card1, card2, card3, card4, card5 )

	for i = 1, 7 do
		if isElement ( gImage["cardBG"..i] ) then
			destroyElement ( gImage["cardBG"..i] )
		end
	end
	createPokerCard ( ownHandCard1, 0.0297, 0.0906, 0.4422, 0.8642, gWindow["pokerOwnCards"], 1 )
	createPokerCard ( ownHandCard2, 0.4818, 0.0943, 0.4521, 0.8566, gWindow["pokerOwnCards"], 2 )
	createPokerCard ( card1, 0.0228, 0.0927, 0.18, 0.5714, gWindow["pokerCommunity"], 3 )
	createPokerCard ( card2, 0.0228+0.18*1+0.01*1, 0.0927, 0.18, 0.5714, gWindow["pokerCommunity"], 4 )
	createPokerCard ( card3, 0.0228+0.18*2+0.01*2, 0.0927, 0.18, 0.5714, gWindow["pokerCommunity"], 5 )
	createPokerCard ( card4, 0.0228+0.18*3+0.01*3, 0.0927, 0.18, 0.5714, gWindow["pokerCommunity"], 6 )
	createPokerCard ( card5, 0.0228+0.18*4+0.01*4, 0.0927, 0.18, 0.5714, gWindow["pokerCommunity"], 7 )
end
addEvent ( "refreshPokerCommunityCards", true )
addEventHandler ( "refreshPokerCommunityCards", getRootElement(), refreshPokerCommunityCards_func )