ChunkfiveFont = guiCreateFont ( "fonts/Chunkfive.otf", 15 )
ChunkfiveFontSmall = guiCreateFont ( "fonts/Chunkfive.otf", 11 )

-- center window
function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) / 2,(screenH - windowH) / 2
    guiSetPosition(center_window, x, y, false)
end

function GUI ()
	-- window of choice to create / accept an invite
	giuGroup1 = guiCreateWindow ( 400, 400, 300, 200, " ", false )
	centerWindow ( giuGroup1 )
	guiSetAlpha ( giuGroup1, 1.0 )
	--guiSetProperty ( giuGroup1 )
	guiWindowSetSizable ( giuGroup1, false )
	guiSetVisible ( giuGroup1, false )
	
	-- buttons
	giuButtom1 = guiCreateButton ( 20, 35, 260, 35, "New group", false, giuGroup1 )
	giuButtom2 = guiCreateButton ( 20, 90, 260, 35, "Invites", false, giuGroup1 )
	giuButtom3 = guiCreateButton ( 20, 145, 260, 35, "Close", false, giuGroup1 )

	-- window of your group
	giuGroup2 = guiCreateWindow ( 400, 400, 300, 455, " ", false )
	centerWindow ( giuGroup2 )
	guiSetAlpha ( giuGroup2, 1.0 )
	--guiSetProperty ( giuGroup2 )
	guiWindowSetSizable ( giuGroup2, false )
	guiSetVisible ( giuGroup2, false )
	
	-- buttons
	giuButtom13 = guiCreateButton ( 20, 350, 260, 35, "Invite", false, giuGroup2 )
	giuButtom4 = guiCreateButton ( 20, 400, 260, 35, "Leave group", false, giuGroup2 )
	
	-- confirmation of withdrawal
	giuGroup5 = guiCreateWindow ( 400, 400, 200, 200, " ", false )
	centerWindow ( giuGroup5 )
	guiSetAlpha ( giuGroup5, 1.0 )
	--guiSetProperty ( giuGroup5 )
	guiWindowSetSizable ( giuGroup5, false )
	guiSetVisible ( giuGroup5, false )
	
	-- buttons
	yesOrNo = guiCreateLabel ( 50, 45, 160, 50, "Leave group?", false, giuGroup5 )
	giuButtom12 = guiCreateButton ( 20, 105, 160, 35, "Yes", false, giuGroup5 )
	giuButtom11 = guiCreateButton ( 20, 145, 160, 35, "No", false, giuGroup5 )
	
	guiSetFont(yesOrNo,ChunkfiveFontSmall)
	guiSetFont(giuButtom12,ChunkfiveFontSmall)
	guiSetFont(giuButtom11,ChunkfiveFontSmall)
	
	-- group creation window
	giuGroup3 = guiCreateWindow ( 400, 400, 300, 280, " ", false ) --Create group
	centerWindow ( giuGroup3 )
	guiSetAlpha ( giuGroup3, 1.0 )
	--guiSetProperty ( giuGroup3 )
	guiWindowSetSizable ( giuGroup3, false )
	guiSetVisible ( giuGroup3, false )
	
	-- buttons
	guiLabel1 = guiCreateLabel ( 20, 30, 260, 20, "Group name:", false, giuGroup3 )
	guiEdit1 = guiCreateEdit ( 20, 55, 260, 32, "", false, giuGroup3 )
	guiEditSetMaxLength ( guiEdit1, 32 )
	guiLabel2 = guiCreateLabel ( 20, 100, 260, 20, "Tag:", false, giuGroup3 )
	guiEdit2 = guiCreateEdit ( 20, 125, 260, 32, "", false, giuGroup3 )
	guiEditSetMaxLength ( guiEdit2, 6 )
	giuButtom5 = guiCreateButton ( 20, 175, 260, 35, "Create", false, giuGroup3 )
	giuButtom6 = guiCreateButton ( 20, 225, 260, 35, "Close", false, giuGroup3 )
	
	-- window of your group
	giuGroup4 = guiCreateWindow ( 400, 400, 300, 420, "Invites", false )
	centerWindow ( giuGroup4 )
	guiSetAlpha ( giuGroup4, 1.0 )
	--guiSetProperty ( giuGroup4 )
	guiWindowSetSizable ( giuGroup4, false )
	guiSetVisible ( giuGroup4, false )
	
	-- buttons
	giuButtom9 = guiCreateButton ( 20, 310, 260, 35, "Reject all", false, giuGroup4 )
	giuButtom7 = guiCreateButton ( 20, 365, 260, 35, "Close", false, giuGroup4 )
	
	guiSetFont(giuButtom1,ChunkfiveFontSmall)
	guiSetFont(giuButtom2,ChunkfiveFontSmall)
	guiSetFont(giuButtom3,ChunkfiveFontSmall)
	guiSetFont(giuButtom4,ChunkfiveFontSmall)
	guiSetFont(giuButtom5,ChunkfiveFontSmall)
	guiSetFont(giuButtom6,ChunkfiveFontSmall)
	guiSetFont(giuButtom7,ChunkfiveFontSmall)
	guiSetFont(giuButtom9,ChunkfiveFontSmall)
	guiSetFont(giuButtom13,ChunkfiveFontSmall)
	
	
	guiSetFont(guiLabel1,ChunkfiveFontSmall)
	guiSetFont(guiLabel2,ChunkfiveFontSmall)
	
	-- Button events
	addEventHandler("onClientGUIClick", giuButtom1, upravlenie)
	addEventHandler("onClientGUIClick", giuButtom2, upravlenie)
	addEventHandler("onClientGUIClick", giuButtom9, upravlenie)
	addEventHandler("onClientGUIClick", giuButtom4, upravlenie)
	addEventHandler("onClientGUIClick", giuButtom11, upravlenie)
	addEventHandler("onClientGUIClick", giuButtom12, upravlenie)
	addEventHandler("onClientGUIClick", giuButtom5, upravlenie)
	addEventHandler("onClientGUIClick", giuButtom13, upravlenie)
	addEventHandler("onClientGUIClick", giuButtom6, openGui)
	addEventHandler("onClientGUIClick", giuButtom3, openGui)
	addEventHandler("onClientGUIClick", giuButtom7, openGui)
end
addEventHandler("onClientResourceStart", getRootElement(), GUI)

-- button actions
function upravlenie ( button, state )
	if ( button == "left" ) then
		if ( source == giuButtom1 ) then
			guiSetVisible ( giuGroup1, false )
			guiSetVisible ( giuGroup3, true )
		elseif ( source == giuButtom2 ) then
			triggerServerEvent ( "ClientInvait", localPlayer )
			guiSetVisible ( giuGroup1, false )
			guiSetInputEnabled ( false )
		elseif ( source == giuButtom9 ) then
			triggerServerEvent ( "ClientSellAllInvait", localPlayer )
			guiSetVisible ( giuGroup4, false )
			guiSetVisible ( giuGroup1, true )
		elseif ( source == giuButtom4 ) then
			guiSetVisible ( giuGroup2, false )
			guiSetVisible ( giuGroup5, true )
		elseif ( source == giuButtom11 ) then
			guiSetVisible ( giuGroup5, false )
			guiSetVisible ( giuGroup2, true )
		elseif ( source == giuButtom12 ) then
			triggerServerEvent ( "exitGrops", localPlayer )
			guiSetVisible ( giuGroup5, false )
			showCursor ( false )
			guiSetInputEnabled ( false )
		elseif ( source == giuButtom13 ) then
			guiSetVisible ( giuGroup2, false )
			listPlayerInvait ()
			showCursor ( true )
		elseif ( source == giuButtom5 ) then
			local nameGroupText = guiGetText ( guiEdit1 )
			local tegGroupText = guiGetText ( guiEdit2 )
			if ( nameGroupText == "" or tegGroupText == "" or nameGroupText == "  " or tegGroupText == "  " or nameGroupText == "   " or tegGroupText == "   " or nameGroupText == "N/A" or tegGroupText == "N/A" or nameGroupText == nil or tegGroupText == nil ) then
				outputChatBox ( "Complete all fields", 255, 0, 0, true )
			else
				if ( string.len ( nameGroupText ) > 2 and string.len ( nameGroupText ) < 33 ) then
					if ( string.len ( tegGroupText ) > 1 and string.len ( tegGroupText ) < 5 ) then
						guiSetVisible ( giuGroup3, false )
						triggerServerEvent ( "clientCreateGroup", localPlayer, nameGroupText, tegGroupText )
					else
						outputChatBox ( "Required tag size: 2-4 chars", 255, 0, 0, true )
					end
				else
					outputChatBox ( "Required name size: 3-32 chars", 255, 0, 0, true )
				end
			end
		end
	end
end

function listPlayerInvait ()
	-- list of all players
	giuGroup6 = guiCreateWindow ( 400, 400, 300, 220, " ", false )
	centerWindow ( giuGroup6 )
	guiSetAlpha ( giuGroup6, 1.0 )
	--guiSetProperty ( giuGroup6 )
	guiWindowSetSizable ( giuGroup6, false )
	guiSetVisible ( giuGroup6, true )
	giuInfoName = guiCreateLabel ( 20, 35, 260, 20, "Player nickname:", false, giuGroup6 )
	guiSetFont(giuInfoName,ChunkfiveFontSmall)
	guiEditInv = guiCreateEdit ( 20, 60, 260, 32, "", false, giuGroup6 )
	guiEditSetMaxLength ( guiEditInv, 24 )
	giuButtomP2 = guiCreateButton ( 20, 115, 260, 35, "Invite", false, giuGroup6 )
	giuButtomP1 = guiCreateButton ( 20, 165, 260, 35, "Close", false, giuGroup6 )
	guiSetFont(giuButtomP2,ChunkfiveFontSmall)
	guiSetFont(giuButtomP1,ChunkfiveFontSmall)

	addEventHandler ( "onClientGUIClick", giuButtomP1, openGui )
	addEventHandler ( "onClientGUIClick", giuButtomP2, 
	function ()
		local tegNamPlay = guiGetText ( guiEditInv )
		if ( tegNamPlay == "" or tegNamPlay == nil) then
			outputChatBox ( "Insert player nickname", 255, 0, 0, true )
		else
			triggerServerEvent ( "ClientPlayerInvait", localPlayer, tegNamPlay )
		end
	end, false )
end

-- triggers
function createGuiGroup ()
	guiSetVisible ( giuGroup1, true )
end
addEvent( "guiGroup", true )
addEventHandler( "guiGroup", localPlayer, createGuiGroup )

-- group window
function createGuiGroup2 ( res2, res3 )
	if res2 and res3 then
		guiSetVisible ( giuGroup2, true )
		local resPlayer = {}
		local resPlayer = res2
		local resInfo = res3
		--destroyElement ( ones )
		--destroyElement ( twos )
		--destroyElement ( playerListColun )
		ones = guiCreateLabel ( 0.1, 0.06, 0.8, 0.4, ""..resInfo[1].groupName.."", true, giuGroup2 )
		twos = guiCreateLabel ( 0.1, 0.12, 0.8, 0.4, "["..resInfo[1].groupTag.."]", true, giuGroup2 )
		guiSetFont(ones,ChunkfiveFont)
		guiSetFont(twos,ChunkfiveFontSmall)
		guiLabelSetHorizontalAlign(ones,"center")
		guiLabelSetHorizontalAlign(twos,"center")
		
		local playerListColun = guiCreateGridList ( 20, 80, 260, 205, false, giuGroup2 )
		local column2 = guiGridListAddColumn( playerListColun, "Members", 0.6 )
		local column3 = guiGridListAddColumn( playerListColun, "Status", 0.3 )
		guiGridListSetColumnWidth(playerListColun,1,0.6,true)
		guiGridListSetColumnWidth(playerListColun,2,0.3,true)
		if ( column2 ) then
			for i, playertData in ipairs ( resPlayer ) do
				row2 = guiGridListAddRow ( playerListColun )
				text2 = guiGridListSetItemText ( playerListColun, row2, column2, playertData.groupUser, false, false )
				text3 = guiGridListSetItemText ( playerListColun, row2, column3, playertData.groupStatus, false, false )
			end
		end
		giuButtom10 = guiCreateButton ( 20, 300, 260, 35, "Expel", false, giuGroup2 )
		guiSetFont(giuButtom10,ChunkfiveFontSmall)

		addEventHandler ( "onClientGUIClick", giuButtom10, 
		function ()
			local row2, column2 = guiGridListGetSelectedItem ( playerListColun )  
			if ( row2 and column2 ) then
				local pKick = guiGridListGetItemText ( playerListColun, row2, column2 )
				if pKick ~= "" then
					triggerServerEvent ( "ClientKickGrop", localPlayer, pKick )
				else
					outputChatBox ( "Select player", 255, 0, 0, true )
				end
			end
		end, false )
	end
end
addEvent( "guiGroup2", true )
addEventHandler( "guiGroup2", localPlayer, createGuiGroup2 )

-- list of invites
function invaitList ( resInvaitList )
	if resInvaitList then
		guiSetVisible ( giuGroup4, true )
		local resInvait = {}
		local resInvait = resInvaitList
		destroyElement ( invaitListColun )
		destroyElement ( column )
		destroyElement ( row )
		destroyElement ( text )
		local invaitListColun = guiCreateGridList ( 20, 30, 260, 205, false, giuGroup4 )
		local column = guiGridListAddColumn( invaitListColun, "You are invited to:", 0.94 )
		if ( column ) then
			for i, invaitData in ipairs ( resInvait ) do
				row = guiGridListAddRow ( invaitListColun )
				text = guiGridListSetItemText ( invaitListColun, row, column, invaitData.groupTag, false, false )
			end
		end
		giuButtom8 = guiCreateButton ( 20, 255, 260, 35, "Join group", false, giuGroup4 )
		guiSetFont(giuButtom8,ChunkfiveFontSmall)
		addEventHandler ( "onClientGUIClick", giuButtom8, 
		function ()
			local row, column = guiGridListGetSelectedItem ( invaitListColun )  
			if ( row and column ) then
				local inv = guiGridListGetItemText ( invaitListColun, row, column )
				if inv ~= "" then
					triggerServerEvent ( "ClientInvaitAdd", localPlayer, inv )
					guiSetVisible ( giuGroup4, false )
				else
					outputChatBox ( "Select invite", 255, 0, 0, true )
				end
			end
		end, false )
	end
end
addEvent( "serverInvaitList", true )
addEventHandler( "serverInvaitList", localPlayer, invaitList )

-- open the required window
function openGui ()
	if guiGetVisible ( giuGroup1 ) == true or 
	guiGetVisible ( giuGroup2 ) == true or 
	guiGetVisible ( giuGroup3 ) == true or 
	guiGetVisible ( giuGroup4 ) == true or
	guiGetVisible ( giuGroup6 ) == true or
	guiGetVisible ( giuGroup5 ) == true then
		
		showCursor ( false )
        guiSetVisible ( giuGroup1, false )
		guiSetVisible ( giuGroup2, false )
		guiSetVisible ( giuGroup3, false )
		guiSetVisible ( giuGroup4, false )
		guiSetVisible ( giuGroup5, false )
		guiSetVisible ( giuGroup6, false )
		guiSetInputEnabled ( false )
	else
		triggerServerEvent ( "startGroup", localPlayer )
		showCursor ( true )
		guiSetInputEnabled ( true )
	end
end
bindKey ( "f4", "down", openGui )