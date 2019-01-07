local chatmsgindex = 0
local screenX, screenY = guiGetScreenSize()

bubbleMessages = {} -- {text, player, lastTick, alpha, yPos}

local timeVisible = 8500
local distanceVisible = 40
local bubble = true -- Rectangle rounded(true) or not(false)
local ticktock = 0
local selfVisible = true -- Want to see your own messages?
localPlayerBubbleActive = 0

---------------------

function addBubble(text, player, tick)

	if player == localPlayer then 
	localPlayerBubbleActive = 1 
	setTimer(function() localPlayerBubbleActive = 0 end,9000,1)
	end

	table.insert(bubbleMessages, {["text"] = text, ["player"] = player, ["tick"] = tick, ["endTime"] = tick + 2000, ["alpha"] = 0})
end

function removeBubble()
	table.remove(bubbleMessages)
end



addEvent("onChatIncome", true)

addEventHandler("onChatIncome", root,
		function(message, messagetype)
		if source ~= localPlayer then
			addBubble(message, source, getTickCount())
		elseif selfVisible then
			addBubble(message, source, getTickCount())
		end
	end
	--[[function(message)
		addBubble(message, source, getTickCount())
	end]]
)

addEventHandler("onClientRender", root, --render bubble chat
	function()
		if #bubbleMessages > 0 then
			local tick = getTickCount()
			local x, y, z = getElementPosition(localPlayer)
			for i, v in ipairs(bubbleMessages) do
				if isElement(v.player)  and not isPedDead(v.player) then
					if tick-v.tick < timeVisible then
						if getDistanceBetweenPoints3D(x, y, z, getElementPosition(v.player)) < distanceVisible then
							v.alpha = v.alpha < 200 and v.alpha + 5 or v.alpha
							local bx, by, bz = getPedBonePosition(v.player, 6)
							local sx, sy = getScreenFromWorldPosition(bx, by, bz)
		
							local elapsedTime = tick - v.tick
							local duration = v.endTime - v.tick
							local progress = elapsedTime / duration
							
							if sx and sy then
								if not v.yPos then v.yPos = sy end
								local width = dxGetTextWidth(v.text:gsub("#%x%x%x%x%x%x", ""), 1, "default-bold")
								local yPos = interpolateBetween ( v.yPos, 0, 0, sy - 22*i, 0, 0, progress, progress > 1 and "Linear" or "OutElastic")
								if bubble then
									local i
									if width < 100 then
										i = 2
									elseif width > 100 and width < 400 then
										i = 1
									else
										i = 3
									end
									dxDrawImage ( sx-width/2-.01*screenX, yPos - .03*screenY, width+.02*screenX, 30, "images/bubble["..i.."].png", _, _, tocolor(255, 255, 255, v.alpha) )
								else
									dxDrawRectangle(sx-width/2-.01*screenX, yPos - .03*screenY, width+.02*screenX, 30, tocolor(0, 0, 0, v.alpha))
								end
								dxDrawText(v.text, sx-width/2, yPos - .02*screenY, width, 20, tocolor( 255, 255, 255, v.alpha+50), 1, "default-bold", "left", "top", false, false, false, true)
							end
						end
					else
						table.remove(bubbleMessages, i)
					end
				else
					table.remove(bubbleMessages, i)
				end
			end
		end
	end
							
)

function clearChat() --outputs 20 lines of text, effectively clearing the chat
	for i=1,20 do 
	outputChatBox ( " ")
	end
end

function positiveAnswer ()
triggerServerEvent("PositiveAnswer",localPlayer)
end
addCommandHandler("Yes (emote)",positiveAnswer)
bindKey ( "2", "down", "Yes (emote)" )

function negativeAnswer ()
triggerServerEvent("NegativeAnswer",localPlayer)
end
addCommandHandler("No (emote)",negativeAnswer)
bindKey ( "3", "down", "No (emote)" ) 

function helloWave ()
triggerServerEvent("HelloWave",localPlayer)
end
addCommandHandler("Hello (emote)",helloWave)
bindKey ( "1", "down", "Hello (emote)" )

function followMe ()
triggerServerEvent("FollowMe",localPlayer)
end
addCommandHandler("Follow (emote)",followMe)
bindKey ( "8", "down", "Follow (emote)" )

function waitHere ()
triggerServerEvent("WaitHere",localPlayer)
end
addCommandHandler("Wait (emote)",waitHere)
bindKey ( "9", "down", "Wait (emote)" )

function helpMe ()
triggerServerEvent("HelpMe",localPlayer)
end
addCommandHandler("Help (emote)",helpMe)
bindKey ( "0", "down", "Help (emote)" )

----------------------------------
--original script by Bonsai (ccs_chatbox)

local chatbox = {}

function initChatBox()

	local layout = getChatboxLayout()
	
	chatbox.text = "" 
	chatbox.InputLineText = ""
	if layout["chat_font"] == 0 then
		chatbox.font = "default"
	elseif layout["chat_font"] == 1 then
		chatbox.font = "clear"
	elseif layout["chat_font"] == 2 then
		chatbox.font = "default-bold"
	else
		chatbox.font = "arial"
	end
	chatbox.fontSizeX = layout["chat_scale"][1]
	chatbox.fontSizeY = layout["chat_scale"][2]
	chatbox.tabHeight = dxGetFontHeight(chatbox.fontSizeY, chatbox.font) + 2
	chatbox.tabOffset = 5
	chatbox.selectedTabIndex = 1
	chatbox.selectedTabName = "All"
	chatbox.tabs = {}
	chatbox.lines = layout["chat_lines"]
	chatbox.lineLife = layout["chat_line_life"]
	if layout["chat_width"] < 1 then 
		chatbox.width = 320
	else
		chatbox.width = 320*layout["chat_width"]
	end

	--------LOADING POSITION
	if not fileExists("settings.xml") then
		local settingsXML = xmlCreateFile("settings.xml", "settings")
		xmlNodeSetAttribute(xmlCreateChild(settingsXML, "positionX"), "x", "false")
		xmlNodeSetAttribute(xmlCreateChild(settingsXML, "positionY"), "y", "false")
		xmlSaveFile(settingsXML)
		xmlUnloadFile(settingsXML)
		chatbox.posX = 10
		chatbox.posY = 10 + chatbox.tabHeight
	else
		local settingsXML = xmlLoadFile("settings.xml")
		local positionX = xmlFindChild(settingsXML, "positionX", 0)
		if positionX then
			local x = xmlNodeGetAttribute(positionX, "x")
			chatbox.posX = tonumber(x) or 10
		end
		local positionY = xmlFindChild(settingsXML, "positionY", 0)
		if positionY then
			local y = xmlNodeGetAttribute(positionY, "y")
			chatbox.posY = tonumber(y) or 10 + chatbox.tabHeight
		end
		xmlUnloadFile(settingsXML)
	end
	-------------------------
	
	chatbox.tabX = chatbox.posX
	chatbox.history = 100
	chatbox.scroll = 0
	chatbox.edge = 2
	chatbox.fontColorA = layout["chat_text_color"][4]
	chatbox.fontColorHex = string.format("#%02X%02X%02X", layout["chat_text_color"][1],layout["chat_text_color"][2],layout["chat_text_color"][3])
	chatbox.selectedTabFontColor = tocolor(0,255,0,0)
	chatbox.lineHeight = dxGetFontHeight(chatbox.fontSizeY, chatbox.font)
	chatbox.height = chatbox.lineHeight*chatbox.lines
	chatbox.alpha = layout["chat_color"][4]
	chatbox.color = tocolor(layout["chat_color"][1],layout["chat_color"][2],layout["chat_color"][3],chatbox.alpha)
	chatbox.tabAlertColor = tocolor(255,255,0,0)
	chatbox.postGUI = false
	chatbox.fontColor = tocolor(255,255,255,255)
	chatbox.maxTextLength = 80
	chatbox.textOffset = 4
	chatbox.inputX = chatbox.posX+chatbox.textOffset
	chatbox.inputY = chatbox.height+chatbox.posY+chatbox.edge
	chatbox.inputHeight = 3*chatbox.lineHeight
	chatbox.shown = false
	chatbox.inputShown = false
	chatbox.positioning = false
	chatbox.inputColor = tocolor(255,255,255,255)
	chatbox.textPosX = chatbox.textOffset
	chatbox.textPosY = 0
	chatbox.inputType = ""
	chatbox.fadeOut = layout["chat_css_style_background"]
	chatbox.fadeOutLines = layout["chat_css_style_text"]
	chatbox.removeTextTick = getTickCount()
	chatbox.lastMenuStatus = nil
	chatbox.isChatboxAllowed = true
	chatbox.removeTextTimer = nil
	chatbox.alertTick = getTickCount()
	chatbox.newMessageScrollValue = 0
	chatbox.newMessageScrollSpeed = 0.07
	chatbox.useNewMessageScrollAnimation = true
	chatbox.scrollSpeed = 0.2
	chatbox.extraLineForAnimation = 1	
	
	addTab("All")
	addTab("Local")
	addTab("OOC", "#aab2a7")
	addTab("Squad", "#5ba049")

	if chatbox.width < getMinWidth() then
		chatbox.width = getMinWidth()
	end
	
	chatbox.renderTarget = dxCreateRenderTarget(chatbox.width, chatbox.height, true)
	
	if not chatbox.renderTarget or not chatbox.useNewMessageScrollAnimation then
		chatbox.useNewMessageScrollAnimation = false
		chatbox.textPosX = chatbox.posX+chatbox.textOffset
		chatbox.textPosY = chatbox.posY
		chatbox.extraLineForAnimation = 0
	end
	
	--[[receiveChat("", "#00ff00Note: Use Numbers to switch Tab.", "Local", true)
	receiveChat("", "#00ff00Note: MTA Menu Settings also apply for this chatbox.", "Local", true)
	receiveChat("", "#00ff00Note: Use /create to create a Group.", "Local", true)
	receiveChat("", "#00ff00Note: Use /invite to invite a Player.", "Local", true)
	receiveChat("", "#00ff00Note: Use /leave to leave a Group.", "Local", true)
	receiveChat("", "#00ff00Note: Use /remove to remove a Player.", "Local", true)
	receiveChat("", "#00ff00Note: You can drag and drop the Chatbox for positioning.", "Local", true)
	receiveChat("", "#00ff00Note: Keys: T, G, Y, X.", "Local", true)
	receiveChat("", '#00ff00Usage: "name message"', "PM", true)]]
	
	if not chatbox.useNewMessageScrollAnimation then
		receiveChat("", "#ffff00Warning: Not enough Memory - Animation disabled.", "Local", true)
	end
	
	toggleChatBox(true)

end
addEventHandler("onClientResourceStart", resourceRoot, initChatBox)


function toggleChatBox(state)

	if state and chatbox.shown then return end
	
	if state == false and not chatbox.shown then return end


	if not chatbox.shown and chatbox.isChatboxAllowed then
		addEventHandler("onClientRender", root, showChatBox)
		addEventHandler("onClientKey", root, buttonHandling)
		bindKey("u", "down", toggleInput, "OOC")	
		bindKey("t", "down", toggleInput, "Local")	
		bindKey("y", "down", toggleInput, "Radio")	
		bindKey("i", "down", toggleInput, "Squad")	
		bindKey("backspace", "up", resetRemoveTick)
		showChat(false)
		chatbox.shown = true
	elseif chatbox.shown then
		removeEventHandler("onClientRender", root, showChatBox)
		removeEventHandler("onClientKey", root, buttonHandling)
		unbindKey("u", "down", toggleInput)	
		unbindKey("t", "down", toggleInput)	
		unbindKey("y", "down", toggleInput)
		unbindKey("i", "down", toggleInput)	
		unbindKey("backspace", "up", resetRemoveTick)
		chatbox.shown = false
		if chatbox.inputShown == true then
			removeEventHandler("onClientCharacter", root, fillInput)
			chatbox.text = ""
			chatbox.InputLineText = ""
			chatbox.inputShown = false
		end
	end

end


function toggleCommand()

	toggleChatBox()

end
addCommandHandler("chat", toggleCommand)


function showChatBoxS(state)

	chatbox.isChatboxAllowed = state
	toggleChatBox(state)

end
addEvent("showChatBox", true)
addEventHandler("showChatBox", root, showChatBoxS)


function showChatBox()

	--Update settings
	if chatbox.lastMenuStatus ~= isMainMenuActive() then
		local layout = getChatboxLayout()
		if layout["chat_font"] == 0 then
			chatbox.font = "default"
		elseif layout["chat_font"] == 1 then
			chatbox.font = "clear"
		elseif layout["chat_font"] == 2 then
			chatbox.font = "default-bold"
		else
			chatbox.font = "arial"
		end
		if layout["chat_width"] < 1 then 
			chatbox.width = 320
		else
			chatbox.width = 320*layout["chat_width"]
		end
		chatbox.fontColorHex = string.format("#%02X%02X%02X", layout["chat_text_color"][1],layout["chat_text_color"][2],layout["chat_text_color"][3])
		chatbox.fontColorA = layout["chat_text_color"][4]
		chatbox.alpha = layout["chat_color"][4]
		chatbox.color = tocolor(layout["chat_color"][1],layout["chat_color"][2],layout["chat_color"][3],chatbox.alpha)
		chatbox.lines = layout["chat_lines"]
		chatbox.inputHeight = chatbox.lines*chatbox.lineHeight
		chatbox.height = chatbox.lineHeight*chatbox.lines
		chatbox.fadeOut = layout["chat_css_style_background"]
		chatbox.lineLife = layout["chat_line_life"]
		chatbox.fadeOutLines = layout["chat_css_style_text"]
		chatbox.inputY = chatbox.height+chatbox.posY+chatbox.edge
		if chatbox.renderTarget then destroyElement(chatbox.renderTarget) end
		chatbox.renderTarget = dxCreateRenderTarget(chatbox.width, chatbox.height, true)
	end
	
	chatbox.lastMenuStatus = isMainMenuActive()
	
	if chatbox.width < getMinWidth() then
		chatbox.width = getMinWidth()
		if chatbox.renderTarget then destroyElement(chatbox.renderTarget) end
		chatbox.renderTarget = dxCreateRenderTarget(chatbox.width, chatbox.height, true)
	end
	
	--Disable Chat
	if isChatVisible() then showChat(false) end

	
	if chatbox.useNewMessageScrollAnimation then
	
		--Scroll Up
		if getKeyState("pgup") then
		
			if #chatbox.tabs[chatbox.selectedTabIndex].chats-chatbox.lines > chatbox.scroll then
			
				chatbox.scroll = chatbox.scroll+chatbox.scrollSpeed
				
				if chatbox.scroll > #chatbox.tabs[chatbox.selectedTabIndex].chats-chatbox.lines then
					chatbox.scroll = #chatbox.tabs[chatbox.selectedTabIndex].chats-chatbox.lines
				end
				
			end
			
		end
		
		
		--Scroll Down
		if getKeyState("pgdn") then
	
			if chatbox.scroll > 0 then
			
				chatbox.scroll = chatbox.scroll-chatbox.scrollSpeed
				
				if chatbox.scroll < 0 then
					chatbox.scroll = 0
				end
				
			end
			
		end	
	
	end
	
	
	--Tabs
	chatbox.tabX = chatbox.posX

	for i, tab in ipairs(chatbox.tabs) do
	
		chatbox.tabWidth = dxGetTextWidth("  "..tab.name.."  ", chatbox.fontSizeX, chatbox.font)
	
		dxDrawRectangle(chatbox.tabX, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.tabWidth, chatbox.tabHeight+chatbox.edge, chatbox.color, chatbox.postGUI)

		if tab.alert then
		
			if getTickCount()-chatbox.alertTick < 1000 then
				dxDrawRectangle(chatbox.tabX, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.tabWidth, chatbox.tabHeight, chatbox.tabAlertColor, chatbox.postGUI)
			elseif getTickCount()-chatbox.alertTick > 3000 then
				chatbox.alertTick = getTickCount()			
			end
				
		end
	
		if i == chatbox.selectedTabIndex then
					
			--dxDrawText(tab.name, chatbox.tabX+1, chatbox.posY-chatbox.edge-chatbox.tabHeight+1, chatbox.tabX+chatbox.tabWidth+1, chatbox.posY+1, tocolor(0,0,0,0), chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "center", "center", false, false, chatbox.postGUI, true) 
			--dxDrawText(tab.name, chatbox.tabX, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.tabX+chatbox.tabWidth, chatbox.posY, chatbox.selectedTabFontColor, chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "center", "center", false, false, chatbox.postGUI, true) 
			chatbox.selectedTabName = tab.name
			
			if tab.alert and chatbox.scroll == 0 then
				tab.alert = false
			end
			
		else
		
			dxDrawRectangle(chatbox.tabX, chatbox.posY-chatbox.edge, chatbox.tabWidth, chatbox.edge, tocolor(0,0,0,0), chatbox.postGUI)
			--dxDrawText(tab.name, chatbox.tabX+1, chatbox.posY-chatbox.edge-chatbox.tabHeight+1, chatbox.tabX+chatbox.tabWidth+1, chatbox.posY+1, tocolor(0,0,0,0), chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "center", "center", false, true, chatbox.postGUI, true) 
			--dxDrawText(tab.name, chatbox.tabX, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.tabX+chatbox.tabWidth, chatbox.posY, chatbox.fontColor, chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "center", "center", false, true, chatbox.postGUI, true) 
		
		end
		

		dxDrawRectangle(chatbox.tabX+chatbox.tabWidth, chatbox.posY-chatbox.edge, chatbox.tabOffset, chatbox.edge, tocolor(0,0,0,0), chatbox.postGUI)
		
		dxDrawRectangle(chatbox.tabX, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.tabWidth, chatbox.edge, tocolor(0,0,0,0), chatbox.postGUI)

		dxDrawRectangle(chatbox.tabX, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.edge, chatbox.tabHeight+chatbox.edge, tocolor(0,0,0,0), chatbox.postGUI)

		dxDrawRectangle(chatbox.tabX+chatbox.tabWidth-chatbox.edge, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.edge, chatbox.tabHeight+chatbox.edge, tocolor(0,0,0,0), chatbox.postGUI)

		chatbox.tabX = chatbox.tabX + chatbox.tabWidth + chatbox.tabOffset

	end

	
	--Clock
	--[[local h, m, s = getTime()
	local time = "  "..h..":"..m..":"..s.."  "
	chatbox.tabWidth = dxGetTextWidth(time, chatbox.fontSizeX, chatbox.font)
	dxDrawRectangle(chatbox.posX+chatbox.width-chatbox.tabWidth, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.tabWidth, chatbox.tabHeight, chatbox.color, chatbox.postGUI)
	dxDrawText(time, chatbox.posX+chatbox.width-chatbox.tabWidth+1, chatbox.posY-chatbox.edge-chatbox.tabHeight+1, chatbox.posX+chatbox.width+chatbox.edge+1, chatbox.posY+1, tocolor(0, 0, 0, 255), chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "center", "center", false, true, chatbox.postGUI, true) 
	dxDrawText(time, chatbox.posX+chatbox.width-chatbox.tabWidth, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.posX+chatbox.width+chatbox.edge, chatbox.posY, chatbox.fontColor, chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "center", "center", false, true, chatbox.postGUI, true) 
	dxDrawRectangle(chatbox.posX+chatbox.width-chatbox.tabWidth, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.tabWidth, chatbox.edge, tocolor(0,0,0,255), chatbox.postGUI)
	dxDrawRectangle(chatbox.posX+chatbox.width-chatbox.tabWidth, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.edge, chatbox.tabHeight, tocolor(0,0,0,255), chatbox.postGUI)
	dxDrawRectangle(chatbox.posX+chatbox.width, chatbox.posY-chatbox.edge-chatbox.tabHeight, chatbox.edge, chatbox.tabHeight, tocolor(0,0,0,255), chatbox.postGUI) ]]

	
	--Background
	dxDrawRectangle(chatbox.tabX, chatbox.posY-chatbox.edge, chatbox.posX+chatbox.width-chatbox.tabX+chatbox.edge, chatbox.edge, tocolor(0,0,0,0), chatbox.postGUI)

	if chatbox.fadeOut == 0 or (chatbox.fadeOut == 1 and chatbox.inputShown) then 
	
		dxDrawRectangle(chatbox.posX, chatbox.posY, chatbox.width, chatbox.height, chatbox.color, chatbox.postGUI)
		dxDrawRectangle(chatbox.posX, chatbox.posY-chatbox.edge, chatbox.edge, chatbox.height+2*chatbox.edge, tocolor(0,0,0,0), chatbox.postGUI)
		dxDrawRectangle(chatbox.posX, chatbox.posY+chatbox.height, chatbox.width, chatbox.edge, tocolor(0,0,0,0), chatbox.postGUI)
		dxDrawRectangle(chatbox.posX+chatbox.width, chatbox.posY-chatbox.edge, chatbox.edge, chatbox.height+2*chatbox.edge, tocolor(0,0,0,0), chatbox.postGUI)
	
	end

	if chatbox.useNewMessageScrollAnimation then
	
		dxSetRenderTarget(chatbox.renderTarget, true)
		dxSetBlendMode("modulate_add")
		
		if chatbox.newMessageScrollValue > 0 then
	
			chatbox.newMessageScrollValue = chatbox.newMessageScrollValue - chatbox.newMessageScrollSpeed 
			
			if chatbox.newMessageScrollValue < 0 then 
				newMessageScrollValue = 0
			end
				
		end

	end
	
	--Lines
	for i, chat in ipairs(chatbox.tabs[chatbox.selectedTabIndex].chats) do

		if i > chatbox.scroll+chatbox.newMessageScrollValue then
			
			if i > chatbox.lines+chatbox.scroll+chatbox.newMessageScrollValue + chatbox.extraLineForAnimation then break end
		
			if getTickCount() - chat.time < chatbox.lineLife or chatbox.inputShown or chatbox.scroll ~= 0 or chatbox.fadeOutLines == 0 then
				
				if string.find (chat.line, "OOC") ~= nil --[[or string.find (chat.line[i-1], "OOC") ~= nil]] then
				chat.alpha = 150
				else				
				chat.alpha = 255
				end
				
			elseif chatbox.fadeOutLines == 1 then
				if chat.alpha > 0 then
					chat.alpha = chat.alpha - 1
				end
			end
			
			
			dxDrawText(clean(chat.line), chatbox.textPosX+1, chatbox.textPosY+chatbox.height-(chatbox.lineHeight*(i-chatbox.scroll))+(chatbox.lineHeight*chatbox.newMessageScrollValue)+1, chatbox.width+1, chatbox.height+1, tocolor(0, 0, 0, chat.alpha), chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "left", "top", false, false, false, true) 
			dxDrawText(chat.line, chatbox.textPosX, chatbox.textPosY+chatbox.height-(chatbox.lineHeight*(i-chatbox.scroll))+(chatbox.lineHeight*chatbox.newMessageScrollValue), chatbox.width, chatbox.height, tocolor(255, 255, 255, chat.alpha), chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "left", "top", false, false, false, true) 
		
		end
		
		
	end
	
	if chatbox.useNewMessageScrollAnimation then
		
		dxSetRenderTarget()
		
		dxSetBlendMode("add")
		dxDrawImage(chatbox.posX, chatbox.posY, chatbox.width, chatbox.height, chatbox.renderTarget, 0, 0, 0, tocolor(255,255,255,255), chatbox.postGUI)
		dxSetBlendMode("blend")
		
	end
	
	--INPUT
	if chatbox.inputShown then
		dxDrawText(chatbox.inputType..": "..chatbox.InputLineText, chatbox.posX+chatbox.textOffset+1, chatbox.posY+chatbox.height+1, chatbox.posX+chatbox.width+1, chatbox.posY+chatbox.height+chatbox.inputHeight+1, tocolor(0,0,0,255), chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "left", "top", false, false, chatbox.postGUI) 
		dxDrawText(chatbox.inputType..": "..chatbox.InputLineText, chatbox.posX+chatbox.textOffset, chatbox.posY+chatbox.height, chatbox.posX+chatbox.width, chatbox.posY+chatbox.height+chatbox.inputHeight, chatbox.inputColor, chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "left", "top", false, false, chatbox.postGUI) 
	end

		
	--Team Tab
	if getPlayerTeam(localPlayer) and not getTabByName("Radio") then
		addTab("Radio", "#66adaf")
	elseif not getPlayerTeam(localPlayer) and getTabByName("Radio") then
		removeTab("Radio")
	end
	
	
	--Group Tab
	if getElementData(localPlayer, "chatgroup") and not getTabByName("Squad") then
		addTab("Squad", "#5ba049")
	elseif not getElementData(localPlayer, "chatgroup") and getTabByName("Squad") then
		removeTab("Squad")
	end
	
	
	--Positioning
	
	if chatbox.positioning then 
	
		if isCursorShowing() then
		
			local absoluteX, absoluteY = getAbsoluteCursorPosition()
			chatbox.posX = absoluteX-chatbox.positioningX
			chatbox.posY = absoluteY-chatbox.positioningY
		
		else
			
			chatbox.positioning = false
			
		end
	end
	
end


function toggleInput(button, state, typ)

	if not chatbox.shown then return end

	if chatbox.inputShown then return end

	if chatbox.selectedTabName == "All" then
		chatbox.inputType = typ
		 
	else
		if button == "t" then
			chatbox.inputType = chatbox.selectedTabName
		else
			return
		end
	end
	
	chatbox.inputShown = true
	if not isCursorShowing() then showCursor(true) end
	
	--Avoid input button being added
	setTimer(function() addEventHandler("onClientCharacter", root, fillInput) end, 50, 1)

end


function buttonHandling(button, press)

	if not press then return end

	if button == "pgup" then

		if chatbox.useNewMessageScrollAnimation then return end
		scrollUp()
		return
		
	elseif button == "pgdn" then

		if chatbox.useNewMessageScrollAnimation then return end
		scrollDown()
		return
		
	end
	
	--Switch Tabs
--[[	if button == "F1" then tabb = 1 end
	if button == "F2" then tabb = 2 end
	if button == "F3" then tabb = 3 end
	if button == "F4" then tabb = 4 end
	if tabb then
		
		if tabb <= 0 or tabb > #chatbox.tabs then return end
		
		if chatbox.inputShown or guiGetInputEnabled() or isConsoleActive() then return end
		
		chatbox.selectedTabIndex = tabb
		chatbox.scroll = 0
		return
	
	end]]
	
	
	if not chatbox.inputShown then return end
	
	cancelEvent()
	
	if button == "escape" then

		chatbox.inputShown = false
		chatbox.text = ""
		chatbox.InputLineText = ""
		if isCursorShowing() then showCursor(false) end
		removeEventHandler("onClientCharacter", root, fillInput)
	
	elseif button == "enter" or button == "num_enter" then

	triggerServerEvent("ClientTriggersWakeUp",localPlayer,localPlayer)
	
		if #chatbox.text > 0 then
			send(chatbox.inputType, chatbox.text)
		end
		
		chatbox.inputShown = false
		if isCursorShowing()  then showCursor(false) end
		chatbox.text = ""
		chatbox.InputLineText = ""
		removeEventHandler("onClientCharacter", root, fillInput)
		
	elseif button == "backspace" then
	
		removeText(500)
		
	end

end


function send(type, ...)

	local text = table.concat({...}," ")

	if type == "PM" then 
		text = "/pm "..text 
	end
	
	if isCommand(text) then
	
		return
	
	elseif #text > chatbox.maxTextLength then 
	
		receiveChat("", "#ffaa00Invalid Text Length.", "Local", true)
		return 
	
	end

	triggerServerEvent("sendText", localPlayer, text, type)

end


function fillInput(char)

	if #chatbox.text >= chatbox.maxTextLength then return end
	
	chatbox.text = chatbox.text..char
	chatbox.InputLineText = chatbox.InputLineText..char
	
	local width = dxGetTextWidth(chatbox.inputType..": "..chatbox.InputLineText, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset
	
	while width > chatbox.width do
	
		chatbox.InputLineText = chatbox.InputLineText:sub(2, #chatbox.InputLineText)
		
		width = dxGetTextWidth(chatbox.inputType..": "..chatbox.InputLineText, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset
		
	end
	
end


function removeText(delay)

	if not getKeyState("backspace") or getTickCount() - chatbox.removeTextTick < delay then return end
	
	chatbox.text = string.sub(chatbox.text, 1, #chatbox.text-1)
	
	chatbox.InputLineText = string.sub(chatbox.InputLineText, 1, #chatbox.InputLineText-1)
	
	local widthInput = dxGetTextWidth(chatbox.inputType..": "..chatbox.InputLineText, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset

	if widthInput < chatbox.width then
	
		chatbox.InputLineText = string.sub(chatbox.text, #chatbox.text-(#chatbox.InputLineText), #chatbox.text)
	
	end
	
	local widthInput = dxGetTextWidth(chatbox.inputType..": "..chatbox.InputLineText, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset

	local widthText = dxGetTextWidth(chatbox.inputType..": "..chatbox.text, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset

	while widthInput < chatbox.width and widthText > chatbox.width do
	
		chatbox.InputLineText = string.sub(chatbox.text, #chatbox.text-(#chatbox.InputLineText), #chatbox.text)
		
		widthInput = dxGetTextWidth(chatbox.inputType..": "..chatbox.InputLineText, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset
		
		widthText = dxGetTextWidth(chatbox.inputType..": "..chatbox.text, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset
		
	end

	
	chatbox.removeTextTick = getTickCount()
	
	chatbox.removeTextTimer = setTimer(removeText, delay, 1, 50)
	
end

function resetRemoveTick() 

	chatbox.removeTextTick = 400
	if isTimer(chatbox.removeTextTimer) then killTimer(chatbox.removeTextTimer) end
	
end

function scrollUp()
	
	if not getKeyState("pgup") then return end
	
	if #chatbox.tabs[chatbox.selectedTabIndex].chats-chatbox.lines > chatbox.scroll then
		
		chatbox.scroll = chatbox.scroll+1
		
	end

	setTimer(scrollUp, 80, 1)

end

function scrollDown()

	if not getKeyState("pgdn") then return end

	if chatbox.scroll > 0 then
			
		chatbox.scroll = chatbox.scroll-1
	
	end

	setTimer(scrollDown, 80, 1)

end

function receiveChat(player, text, type, byResource, onlyTab)
	
	local line

	if not byResource then
		line = player.."#ffffff: "..chatbox.fontColorHex..text
	else
		line = text
	end
	
	local lines = seperateToLines(line)

	local index = getTabByName(type)
	
	if not index then return end
	
	--TYPE
	for i, line in ipairs(lines) do
		
		table.insert(chatbox.tabs[index].chats, 1, {line = line, time = getTickCount(), alpha = 255})
		
	end
	
	while #chatbox.tabs[index].chats > chatbox.history do
		table.remove(chatbox.tabs[index].chats, #chatbox.tabs[index].chats)
	end
	
	--ALARM
	if chatbox.scroll ~= 0 or chatbox.selectedTabIndex ~= index then
	
		if chatbox.selectedTabName ~= "All" then
	
			chatbox.tabs[index].alert = true
			
		end
	
	end
	
	if chatbox.useNewMessageScrollAnimation and (type == chatbox.selectedTabName or chatbox.selectedTabName == "All") and chatbox.shown then
	
		chatbox.newMessageScrollValue = chatbox.newMessageScrollValue+#lines
		
	end
	
	if onlyTab then return end
	
	if type ~= "Local" then
	
		if not byResource then
			line = chatbox.tabs[index].color.."["..type.."] #ffffff"..player.."#ffffff: "..chatbox.fontColorHex..text
		else
			line = chatbox.tabs[index].color.."["..type.."] "..chatbox.fontColorHex..text
		end

	end
		
	outputConsole(clean(line))

	local lines = seperateToLines(line)
	
	local index = getTabByName("All")
	
	if not index then return end 
	
	if chatbox.selectedTabIndex == index and chatbox.scroll ~= 0 then
	
		chatbox.tabs[index].alert = true
		
	end
	
	--All
	for i, line in ipairs(lines) do
		
		table.insert(chatbox.tabs[index].chats, 1, {line = line, time = getTickCount(), alpha = 255})
	
	end
	
	while #chatbox.tabs[index].chats > chatbox.history do
		table.remove(chatbox.tabs[index].chats, #chatbox.tabs[index].chats)
	end
	
end
addEvent("receiveChat", true)
addEventHandler("receiveChat", root, receiveChat)

function getTabByName(name)

	for i, tab in ipairs(chatbox.tabs) do
	
		if tab.name == name then
			return i
		end
	
	end

	return false

end

function addTab(tabName, color)

	if not color then color = "#ffffff" end

	chatbox.tabs[#chatbox.tabs+1] = { name = tabName, alert = false, chats = {}, color = color }
	addCommandHandler(tabName, send)

end

function removeTab(tabName)

	local index = getTabByName(tabName)

	table.remove(chatbox.tabs, index)
	removeCommandHandler(tabName, send)
	
	if chatbox.selectedTabName == tabName then
		chatbox.selectedTabIndex = 1
	end
	
end

function isCommand(text)

	local c1, c2 = string.find(text, "/")
	
	if not c1 or c1 ~= 1 then return false end
	
	text = text:sub(2, #text)
	
	if #text:gsub("%s", "") == 0 then return true end
	
	local command = text:split(" ")
	
	local argList = ""
	
	for i=2, #command do
	
		argList = argList.." "..command[i]
	
	end
	
	executeCommandHandler(command[1], argList)
	triggerServerEvent("executeCommand", localPlayer, command, argList)
	
	return true 
	
end

function findColorCodes(str)

	local colorCodes = {}
	local c1, c2
	local startAt = 1
	local foundCodes = 0
	
	repeat
		c1, c2 = string.find(str, "#%x%x%x%x%x%x", startAt)
		if c1 then
			table.insert(colorCodes, {code =  string.sub(str, c1, c2), start = c1-foundCodes*7})
			startAt = c2
			foundCodes = foundCodes + 1
		end
	until not c1
	
	return colorCodes


end

function seperateToLines(text)

	local tempstring = clean(text)
	local codes = findColorCodes(text)
	text = clean(text)
	local lines = {}
	local lastColorCode = ""
	local length = 0
	local usedCodesInLine = 0
	
	if dxGetTextWidth(tempstring, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset <= chatbox.width then
		
		for i, c in pairs(codes) do 
			local colorCodePositon = c.start+(i-1)*7
			tempstring = tempstring:sub(1, colorCodePositon-1)..c.code..tempstring:sub(colorCodePositon)
		end
		
		table.insert(lines, tempstring)
		
		return lines
		
	end
	
	while true do 
	
		if dxGetTextWidth(tempstring, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset > chatbox.width then
	
			while true do 
					
				tempstring = string.sub(tempstring, 1, #tempstring-1)
					
				if dxGetTextWidth(tempstring, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset < chatbox.width then
			
					tempstring = findSmoothWrapPoint(tempstring)
					break
					
				end
				
			end
			
			local newLineStart = #tempstring+1
			
			--Put in color codes
			for i, c in pairs(codes) do 
				
				if c.code ~= "" then
					local colorCodePositon = c.start-length+usedCodesInLine*7
					if #tempstring >= colorCodePositon then
						tempstring = tempstring:sub(1, colorCodePositon-1)..c.code..tempstring:sub(colorCodePositon)
						lastColorCode = c.code
						c.code = ""
						usedCodesInLine = usedCodesInLine + 1
					end
				end
			end
			
			table.insert(lines, tempstring)	
			tempstring = string.sub(text, newLineStart, #text+1)
			length = length+newLineStart-1
			table.insert(codes, 1, {code =  lastColorCode, start = length+1})
			text = tempstring
			usedCodesInLine = 0
			
		else
			
			for i, c in pairs(codes) do 
				if c.code ~= "" then
					local colorCodePositon = c.start-length+usedCodesInLine*7
					if #tempstring >= colorCodePositon then
						tempstring = tempstring:sub(1, colorCodePositon-1)..c.code..tempstring:sub(colorCodePositon)
						usedCodesInLine = usedCodesInLine + 1
					end
				end
			end
		
			table.insert(lines, tempstring)
			break
			
		end
		
	end
	
	return lines
	
end

function findSmoothWrapPoint(text)

	local originalText = text

	while #text > 1 do
	
		local lastChar = string.sub(text, #text)
	
		if lastChar == " " or lastChar == "." or lastChar == "," then
		
			return text
			
		end
	
		text = string.sub(text, 1, #text-1)
	
	end
	
	return originalText

end

function string:split(sep)

    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
		
end


function getMinWidth()

	local width = 0

	for i, tab in pairs(chatbox.tabs) do 
	
		width = width + dxGetTextWidth("  "..tab.name.."  ", chatbox.fontSizeX, chatbox.font) + chatbox.tabOffset
	
	end
	
	width = width + dxGetTextWidth("  00:00:00  ", chatbox.fontSizeX, chatbox.font)
	
	return width

end

--[[function getTime()

	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
	if hours < 10 then hours = "0"..hours end
	if minutes < 10 then minutes = "0"..minutes end
	if seconds < 10 then seconds = "0"..seconds end
	return hours, minutes, seconds

end]]

function clean(text)

	cleanText = string.gsub(text, '#%x%x%x%x%x%x', '')
	return cleanText

end

function catchChatMessages(text,r,g,b)
	
	receiveChat("", string.format("#%02X%02X%02X", r,g,b)..text, "Local", true)
	cancelEvent()

end
addEventHandler("onClientChatMessage", root, catchChatMessages)

--Chatbox Positioning
function onChatBoxClick(button, state, absoluteX, absoluteY)

	if not isCursorShowing() or button ~= "left" then return end

	if state == "down" then
	
		if absoluteX < chatbox.posX or absoluteX > chatbox.posX+chatbox.width then return end
		if absoluteY < chatbox.posY or absoluteY > chatbox.posY+chatbox.height then return end	
		chatbox.positioning = true
		chatbox.positioningX = absoluteX - chatbox.posX
		chatbox.positioningY = absoluteY - chatbox.posY
		
	else
	
		chatbox.positioning = false
		
		if not fileExists("settings.xml") then return end
		
		local settingsXML = xmlLoadFile("settings.xml")
		local positionX = xmlFindChild(settingsXML, "positionX", 0)
		local positionY = xmlFindChild(settingsXML, "positionY", 0)		
		xmlNodeSetAttribute(positionX, "x", chatbox.posX)
		xmlNodeSetAttribute(positionY, "y", chatbox.posY)
		xmlSaveFile(settingsXML)
		xmlUnloadFile(settingsXML)
			
	end
	
end
--addEventHandler("onClientClick", root, onChatBoxClick)

function getAbsoluteCursorPosition()

	local cursorX, cursorY = getCursorPosition()
	local x, y = guiGetScreenSize()
	return cursorX*x, cursorY*y
	
end

function forceShowCursor()
showCursor(true)
end

------------Chat animation 
gChatting = false
 
function chatCheckPulse()
    
	local chatState = chatbox.inputShown --isChatBoxInputActive() or isConsoleActive()
 
    if chatState ~= gChatting then
        if chatState and getPedMoveState ( localPlayer ) == "stand" then
            triggerServerEvent("playerChatting", getLocalPlayer())
        else
            triggerServerEvent("playerNotChatting", getLocalPlayer())
        end
        gChatting = chatState
    end
    setTimer( chatCheckPulse, 3000, 1)
end
addEventHandler ( "onClientResourceStart", resourceRoot, chatCheckPulse )
addEventHandler ( "onClientPlayerJoin", getRootElement(), chatCheckPulse )