GUIEditor_Window = {}
GUIEditor_Button = {}
GUIEditor_Label = {} 

dialogueGuiShowed = 0

--createPed ( 1, -688.556640625, 956.6904296875, 12.159048080444, 85.345855712891 )
--createPed ( 1, 1447.2002, -1381.0996, 13.5, 85.345855712891 ) --posX="1447.2002" posY="-1380.0996" posZ="13.5"

--ChunkfiveFont = guiCreateFont ( "fonts/Chunkfive.otf", 15 )
--ChunkfiveFontSmall = guiCreateFont ( "fonts/Chunkfive.otf", 11 )

function showQuestWindow ( person, text, var1, var1_do, var2, var2_do, var3, var3_do, var4, var4_do )
	if dialogueGuiShowed == 0 then
	
	dialogueGuiShowed = 1

	weight = 0.5389

	if var4 ~= "0" then
		weight = 0.5389
	else
		if var3 ~= "0" then
			weight = 0.4544
		else
			if var2 ~= "0" then
				weight = 0.3911
			else
				weight = 0.3311
			end
		end
	end
	
	GUIEditor_Window[1] = guiCreateWindow(0.3031,0.2689,0.435,0.5389," ",true)
	guiSetAlpha(GUIEditor_Window[1],100)
	GUIEditor_Button[1] = guiCreateButton(0.0316,0.501,0.9339,0.0804,var1,true,GUIEditor_Window[1])
	guiSetFont(GUIEditor_Button[1],ChunkfiveFontSmall)
	GUIEditor_Button[2] = guiCreateButton(0.0316,0.6144,0.9339,0.0804,var2,true,GUIEditor_Window[1])
	guiSetFont(GUIEditor_Button[2],ChunkfiveFontSmall)
	GUIEditor_Button[3] = guiCreateButton(0.0316,0.732,0.9339,0.0804,var3,true,GUIEditor_Window[1])
	guiSetFont(GUIEditor_Button[3],ChunkfiveFontSmall)	
	GUIEditor_Button[4] = guiCreateButton(0.0316,0.8557,0.9339,0.0804,var4,true,GUIEditor_Window[1])
	guiSetFont(GUIEditor_Button[4],ChunkfiveFontSmall)
	GUIEditor_Label[1] = guiCreateLabel(0.1,0.073,0.8,0.08,person,true,GUIEditor_Window[1]) --NPC name
	guiSetFont(GUIEditor_Label[1],ChunkfiveFont)
	GUIEditor_Label[2] = guiCreateLabel(0.0575,0.2,0.8764,0.30,text,true,GUIEditor_Window[1]) --NPC dialogue
	--guiSetFont(GUIEditor_Label[2],ChunkfiveFontSmall)
	guiLabelSetHorizontalAlign(GUIEditor_Label[2],"left",true)
	guiLabelSetHorizontalAlign(GUIEditor_Label[1],"center",true)
	guiMoveToBack(GUIEditor_Label[2])
	guiMoveToBack(GUIEditor_Label[1])
	
	guiSetVisible ( GUIEditor_Window[1], true )
	
	--addEventHandler("onClientRender",root,forceShowCursor)
	showCursor(true)
	
	guiSetSize ( GUIEditor_Window[1], 0.435, weight, true )
	guiWindowSetSizable(GUIEditor_Window[1],false)
	addEventHandler("onClientGUIClick", GUIEditor_Button[1],
		function ()
			guiSetVisible ( GUIEditor_Window[1], false )
		showCursor(false)	--removeEventHandler("onClientRender",root,forceShowCursor)
			dialogueGuiShowed = 0
			assert(loadstring(var1_do))()
		end
	,false)
	if var2 ~= "0" then
	addEventHandler("onClientGUIClick", GUIEditor_Button[2],
		function ()
			guiSetVisible ( GUIEditor_Window[1], false )
			showCursor(false)--removeEventHandler("onClientRender",root,forceShowCursor)
			dialogueGuiShowed = 0
			assert(loadstring(var2_do))()
		end
	,false)
	else
		guiSetVisible ( GUIEditor_Button[2], false )
	end
	if var3 ~= "0" then
		addEventHandler("onClientGUIClick", GUIEditor_Button[3],
			function ()
				guiSetVisible ( GUIEditor_Window[1], false )
				showCursor(false)--removeEventHandler("onClientRender",root,forceShowCursor)
				dialogueGuiShowed = 0
				assert(loadstring(var3_do))()
			end
		,false)
	else
		guiSetVisible ( GUIEditor_Button[3], false )
	end
	if var4 ~= "0" then
		addEventHandler("onClientGUIClick", GUIEditor_Button[4],
			function ()
				guiSetVisible ( GUIEditor_Window[1], false )
				showCursor(false)--removeEventHandler("onClientRender",root,forceShowCursor)
				dialogueGuiShowed = 0
				assert(loadstring(var4_do))()
			end
		,false)
	else
		guiSetVisible ( GUIEditor_Button[4], false )
	end
	
	end

end



--[[function playerToPointClient( radius, x, y, z )
    if isElement( localPlayer ) and radius and x and y and z then
        return getDistanceBetweenPoints3D( x, y, z, getElementPosition( localPlayer ) ) <= radius
    end
    return false
end

function checkNearQuest () --Проверка ближайшего квеста
	if playerToPointClient ( 3, 1447.2002, -1381.0996, 13.5 ) then
		start_Main_Q ()
	end	
end

addEventHandler( "onClientResourceStart", getRootElement( ),
    function ( startedRes )
		bindKey ( "space", "down", checkNearQuest ) 
    end
)]]

--guiSetSize ( GUIEditor_Window[1], 0.435, 0.3311, true )