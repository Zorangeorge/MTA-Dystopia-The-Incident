----CHAT RADIUS SIZE
local chatRadius = 40 --units
local yellRadius = 70 --units
--local radioRadius = 300

------------------CHAT ANIMATION-----------------
function playerChatting()
	if getPedOccupiedVehicle(source) or player_in_bed[source] or getElementData(source, "glued")== true or getElementData(source,"incapacitated")== true then 
	return 
	end
	setPedAnimation(source, "ped", "IDLE_chat")
end
addEvent("playerChatting", true )
addEventHandler("playerChatting", getRootElement(), playerChatting)

function playerNotChatting()
--if getPedOccupiedVehicle(source) or player_in_bed[source] then return end
	setPedAnimation(source)
end
addEvent("playerNotChatting", true )
addEventHandler("playerNotChatting", getRootElement(), playerNotChatting)

addEventHandler ("onPlayerQuit", getRootElement(), playerNotChatting )
-------------------------------------

addEvent("PositiveAnswer",true)
addEvent("NegativeAnswer",true)
addEvent("HelloWave",true)
addEvent("FollowMe",true)
addEvent("WaitHere",true)
addEvent("HelpMe",true)
addEvent("SendChatToNearbyPlayers",true)
addEvent("SendYellToNearbyPlayers",true)

function sendToNearbyPlayers (chattingped,message)
-- get the chatting player's position
        local posX, posY, posZ = getElementPosition( chattingped )
		
		local chattingpedType = getElementType(chattingped)
		local chattingpedName
		if chattingpedType == "player" then 
			chattingpedName = getPlayerName(chattingped)
		elseif chattingpedType == "ped" then 
			chattingpedName = getElementData(chattingped,"name") or ""
		else
			chattingpedName = " "
		end
        
        -- create a sphere of the specified radius at that position
        local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
        -- get a table w/ all player elements inside it
        local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
        -- and destroy the sphere, since we're done with it
        destroyElement( chatSphere )
        if nearbyPlayers then
        -- deliver the message to each player in the table
			for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			triggerClientEvent(nearbyPlayer,"onChatIncome", chattingped, message)	--this ADDs BUBBLE CLIENTSIDE
			outputChat(message, nearbyPlayer, chattingpedName, "Local", byResource)
			end
		--triggerEvent("sendText", nearbyPlayer, chattingpedName..": "..message, "Local", true)			
		
		end
end

function yellToNearbyPlayers (chattingped,message)
-- get the chatting player's position
        local posX, posY, posZ = getElementPosition( chattingped )
		
		local chattingpedType = getElementType(chattingped)
		local chattingpedName
		if chattingpedType == "player" then 
			chattingpedName = getPlayerName(chattingped)
		elseif chattingpedType == "ped" then 
			chattingpedName = getElementData(chattingped,"name") or ""
		else
			chattingpedName = " "
		end
        
        -- create a sphere of the specified radius in that position
        local chatSphere = createColSphere( posX, posY, posZ, yellRadius )
        -- get a table all player elements inside it
        local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
        -- and destroy the sphere, since we're done with it
        destroyElement( chatSphere )
        if nearbyPlayers then
        -- deliver the message to each player in that table
        for index, nearbyPlayer in ipairs( nearbyPlayers ) do
		triggerClientEvent(nearbyPlayer,"onChatIncome", chattingped, message)	--this ADDs BUBBLE CLIENTSIDE
		outputChat(message, nearbyPlayer, getPlayerName(chattingped) or getElementData(chattingped,"name"), "Local", byResource)
		end
		--triggerEvent("sendText", nearbyPlayer, chattingpedName..": "..message, "Local", true)			
		end
end

addEventHandler("SendChatToNearbyPlayers",root,sendToNearbyPlayers)
addEventHandler("SendYellToNearbyPlayers",root,yellToNearbyPlayers)

function positiveAnswer ()
if getElementData(client, "sleeping")== true or getElementData(client,"incapacitated")== true then return end
	if not isPedDucked(client) then
		local anim = setPedAnimation(client,"ped", "IDLE_chat")
		local ped = client
		setTimer(function()setPedAnimation(ped)end,1000,1)
	end
local message = table.random(positiveAnswers)
triggerEvent("onPlayerEmoteChat",client,message,0)
sendToNearbyPlayers(client,message)
end

function negativeAnswer ()
if getElementData(client, "sleeping")== true or getElementData(client,"incapacitated")== true then return end
	if not isPedDucked(client) then
		local anim = setPedAnimation(client,"ped",table.random(nope_anims))
		local ped = client
		setTimer(function()setPedAnimation(ped)end,1000,1)
	end
local message = table.random(negativeAnswers)
triggerEvent("onPlayerEmoteChat",client,message,0)
sendToNearbyPlayers(client,message)
end

function helloWave ()
if getElementData(client, "sleeping")== true or getElementData(client,"incapacitated")== true then return end
	if not isPedDucked(client) then
		local anim = setPedAnimation(client,"ped","endchat_03")
		local ped = client
		setTimer(function()setPedAnimation(ped)end,1000,1)
	end
local message = table.random(greetings)
triggerEvent("onPlayerEmoteChat",client,message,0)
sendToNearbyPlayers(client,message)
end

function followMe ()
if getElementData(client, "sleeping")== true or getElementData(client,"incapacitated")== true then return end
	if not isPedDucked(client) then
		local anim = setPedAnimation(client,"RYDER","RYD_Beckon_01") --
		local ped = client
		setTimer(function()setPedAnimation(ped)end,1000,1)
	end
local message = table.random(followchat)
triggerEvent("onPlayerEmoteChat",client,message,0)
sendToNearbyPlayers(client,message)

	local target = getPedTarget(client)
	if target and getElementType(target) == "ped" then
		if getElementData(target,"slothbot") == true then
			if getElementData(target,"BotTeam") == getPlayerTeam(client) then
				local name = getElementData(target,"name") 
				if name == "Raider" 
				or name == "Raider Barker" 
				or name == "Raider Pitdog" 
				or name == "Raider Hound" 
				or name == "Guard" 
				or name == "Bandit" 
				or name == "Bandit Veteran" 
				or name == "Scavenger" 
				or name == "Wastelander" 
				or name == "Militia" 
				or name == "Militia Ranger" 
				or name == "Trooper" 
				or name == "Heavy Trooper" 
				or name == "Peacekeeper"
				or name == "Cleaner"
				then
					if not getElementData(target,"followingPlayer") then
						if getElementData(client,"botBodyguard") then 
						outputTopBar("You already have a follower",client,240,200,0)
						return
						end
						local REP = getPlayerMoney(client)
						if REP >= 50 then
							if getElementData(target,"type") == "civilian" then setElementData(target,"type","follower") end
							exports["dystopia_slothbot"]:setBotFollow(target,client)
							local followerSpawnCol = getElementData(target,"botSpawnCol")
							sendToNearbyPlayers(target,table.random(followingAknowledgments))
							setElementData(followerSpawnCol,"botWasSpawned", false)
							setElementData(target,"followingPlayer", client)
							setElementData(client,"botBodyguard", target)
							setPlayerMoney(client,REP-50)
						else
							sendToNearbyPlayers(target,table.random(followingRefused))
							setPedAnimation(target,"ped",table.random(nope_anims))
							setTimer(function()setPedAnimation(target)end,1000,1)
						end
					elseif getElementData(target,"followingPlayer") == client then
						exports["dystopia_slothbot"]:setBotFollow(target,client)
						local followerSpawnCol = getElementData(target,"botSpawnCol")
						sendToNearbyPlayers(target,table.random(resumingFollow))
						setPedAnimation(target,"ped",table.random(chat_anims))
						setTimer(function()setPedAnimation(target)end,1000,1)
					end
				end
			end
		end
	end
				

end

function clearFollower ()
	if getElementData(source,"slothbot") == true then
		local botLeader = getElementData(source,"followingPlayer")
			if botLeader and isElement(botLeader)then
				setElementData(botLeader,"botBodyguard", nil)
				outputTopBar("Your follower is dead",client,240,200,0)
				local bot = source
				setTimer(function()destroyElement(bot)end,60000,1)
			end
	end		
end
addEventHandler("onPedWasted",root,clearFollower)

function waitMe ()
if getElementData(client, "sleeping")== true or getElementData(client,"incapacitated")== true then return end
	if not isPedDucked(client) then
		local anim = setPedAnimation(client,"RYDER","RYD_Beckon_03") --
		local ped = client
		setTimer(function()setPedAnimation(ped)end,1000,1)
	end
local message = table.random(waitchat)
triggerEvent("onPlayerEmoteChat",client,message,0)
sendToNearbyPlayers(client,message)

local target = getPedTarget(client)
	if target and getElementType(target) == "ped" then
		if getElementData(target,"slothbot") == true then
			if getElementData(target,"BotTeam") == getPlayerTeam(client) then
				if getElementData(target,"followingPlayer") == client then
				local x,y,z = getElementPosition(target)
						exports["dystopia_slothbot"]:setBotGuard(target,x,y,z,false)
						sendToNearbyPlayers(target,table.random(positiveAnswers))
						setPedAnimation(target,"ped",table.random(chat_anims))
						setTimer(function()setPedAnimation(target)end,1000,1)
				end
			end
		end
	end
end

function helpMe ()
if getElementData(client, "sleeping")== true or getElementData(client,"incapacitated")== true then return end
	if not isPedDucked(client) then
		local anim = setPedAnimation(client,"ON_LOOKERS","shout_in") --
		local ped = client
		setTimer(function()setPedAnimation(ped)end,1000,1)
	end
local message = table.random(helpchat)
triggerEvent("onPlayerEmoteChat",client,message,0)
sendToNearbyPlayers(client,message)
end

addEventHandler("PositiveAnswer",root,positiveAnswer)
addEventHandler("NegativeAnswer",root,negativeAnswer)
addEventHandler("HelloWave",root,helloWave)
addEventHandler("FollowMe",root,followMe)

function isPlayerInACL(player, acl)
   local accountName = getAccountName( getPlayerAccount(player) )
   if accountName ~= "guest" and type( aclGetGroup(acl) ) == "userdata" then
      return isObjectInACLGroup( "user."..accountName, aclGetGroup(acl) )
   end
   return false
end


addEventHandler("WaitHere",root,waitMe)
addEventHandler("HelpMe",root,helpMe)

--------------------------------------
--original script by Bonsai (ccs_chatbox)

function broadcast(text, type, byResource)
	
	if isPlayerMuted(source) then
	
		outputChat("#ff0000You are Muted!", source, getPlayerName(source), type, byResource)
		return
		
	end
	
	if type == "OOC" then
	
	local tagbit = " "
	if isPlayerInACL(source, "Moderator") then tagbit = "[Mod] " --[[elseif isPlayerInACL(source, "Admin") then tagbit = "[Adm] "]] end
	
		outputChat(text, root, tagbit..getPlayerName(source), type, byResource)
		
	elseif type == "Local" then
	
	    local posX, posY, posZ = getElementPosition( source )
-- create a sphere of the specified radius in that position
        local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
        -- get a table all player elements inside it
        local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
        -- and destroy the sphere, since we're done with it
        destroyElement( chatSphere )
        -- deliver the message to each player in that table
        for index, nearbyPlayer in ipairs( nearbyPlayers ) do
		triggerClientEvent(nearbyPlayer,"onChatIncome", source, text)	--this adds bubble clientside
		--triggerClientEvent(nearbyPlayer,"onChatIncome", source, message)	--this adds bubble clientside
		local speakername = getPlayerName(source) 
		if not speakername then speakername =  getElementData(source,"name") end
		outputChat(text, nearbyPlayer, speakername, "Local", byResource)
		end
		
	elseif type == "Radio" then
	
		if not hasPlayerBeltItem("Radio", source) then 
				outputChatBox("You have no radio device equipped.", source, 255, 153, 51)
				return
			end
	
		local team = getPlayerTeam(source)
		
		if not team then return end
		
		for i, p in pairs(getPlayersInTeam(team)) do 
		
			if not hasPlayerBeltItem("Radio", p) then
			
			--nada
			
			else
			
			outputChat(text, p, getPlayerName(source), type, byResource)
			
			end
			
		end
		
	elseif type == "Squad" then
	
		if not getElementData(source, "chatgroup") then return end
	
		for i, p in pairs(getElementsByType("player")) do 
		
			if getElementData(p, "chatgroup") == getElementData(source, "chatgroup") then
			
				outputChat(text, p, getPlayerName(source), type, byResource)
				
			end
			
		end
		
	else
	
		outputChat(text, getElementParent(source), getPlayerName(source), type, byResource)
		
	end
	
	outputServerLog("CHAT: "..getPlayerName(source)..": "..text)

	
end
addEvent("sendText", true)
addEventHandler("sendText", root, broadcast)


--Commands
function executeCommand(command, args)

	if not hasObjectPermissionTo(source, "command."..command[1], true) then return end
		
	executeCommandHandler(command[1], source, args)

end
addEvent("executeCommand", true)
addEventHandler("executeCommand", root, executeCommand)


--Output
function outputChat(msg, toElement, playerName, type, byResource, onlyTab)

	triggerLatentClientEvent(toElement, "receiveChat", root, playerName, msg, type, byResource, onlyTab)

end
addEvent("outputChat")
addEventHandler("outputChat", root, outputChat)


--Create Group
function createGroup(p, c)

	if getElementData(p, "chatgroup") then
		outputChat("#ff0000Error: You already have a group!", p, "", "Squad", true, false)
		return
	end

	setElementData(p, "chatgroup", getPlayerSerial(p))
	outputChat("#00ff00Info: You created a group!", p, "", "Local", true, false)

end
addCommandHandler("create", createGroup)


--Invite a Player
function invitePlayer(p, c, name)

	if not getElementData(p, "chatgroup") then
		outputChat("#ff0000Error: You don't have a group!", p, "", "Local", true, false)
		return
	end
	
	if not name then
		outputChat("#ff0000Error: You have to provide a player!", p, "", "Squad", true, false)
		return
	end

	local player = findPlayer(name)
	
	if not player then 
		outputChat("#ff0000Error: Player not found!", p, "", "Squad", true, false)
		return
	end
	
	if getElementData(player, "chatgroup") then
		outputChat("#ff0000Error: Player already has a group!", p, "", "Squad", true, false)
		return
	end
	
	
	setElementData(player, "chatgroup", getElementData(p, "chatgroup"))
	triggerEvent("sendText", player, "#00ff00Info: "..clean(getPlayerName(player)).." joined the group!", "Squad", true)


end
addCommandHandler("invite", invitePlayer)


--Leave Group
function leaveGroup(p, c, t)

	if not getElementData(p, "chatgroup") then		
		outputChat("#ff0000Error: You don't have a group!", p, "", "Local", true, false)
		return
	end

	triggerEvent("sendText", p, "#00ff00INFO: "..clean(getPlayerName(p)).." left the group!", "Squad", true)
	setElementData(p, "chatgroup", nil)
	outputChat("#00ff00Info: You left the group!", p, "", "Local", true, false)

end
addCommandHandler("leave", leaveGroup)


--Remove a Player
function removePlayer(p, c, name)

	if not getElementData(p, "chatgroup") then		
		outputChat("#ff0000Error: You don't have a group!", p, "", "Local", true, false)
		return
	end

	if getElementData(p, "chatgroup") ~= getPlayerSerial(p) then
		outputChat("#ff0000Error: You are not the group owner!", p, "", "Squad", true, false)
		return
	end
	
	if not name then
		outputChat("#ff0000Error: You have to provide a player!", p, "", "Squad", true, false)
		return
	end
	
	local player = findPlayer(name)
	
	if not player then 
		outputChat("#ff0000Error: Player not found!", p, "", "Squad", true, false)
		return
	end
	
	if not getElementData(player, "chatgroup") then
		outputChat("#ff0000Error: Player doesn't have a group!", p, "", "Squad", true, false)
		return
	end
	
	if getElementData(player, "chatgroup") ~= getElementData(p, "chatgroup") then
		outputChat("#ff0000Error: Player isn't in your group!", p, "", "Squad", true, false)
		return
	end
	
	triggerEvent("sendText", p, "#00ff00Info: "..clean(getPlayerName(player)).." left the group!", "Squad", true)
	outputChat("#00ff00Info:  You have been removed from the Group!", player, "", "Local", true, false)
	
	setElementData(player, "chatgroup", nil)

end
addCommandHandler("remove", removePlayer)


--Private Message
function private(p, c, t, ...)

	if t == nil then return end
	
	player = findPlayer(t)
	
	if not player then 
	
		outputChat("#ff0000Error: Player not found!", p, "", "PM", true, false)
		return 
	
	end
	
	local message = #{...}>0 and table.concat({...},' ') or nil
	
	if not message then return end
	
	outputChat(getPlayerName(player).."#ffffff: "..message, p, "", "PM", true, false)
	
	outputChat(getPlayerName(player).."#ffffff: "..message, player, "", "PM", true, false)

end
addCommandHandler("pm", private)


--Find a Player
function findPlayer(name)

    local name = name:lower()
	
    for i, p in ipairs(getElementsByType("player")) do
        local fullname = string.gsub(getPlayerName(p), '#%x%x%x%x%x%x', ''):lower()
        if string.find(fullname, name, 1, true) then
            return p
        end
    end
    return false
	
end


--Clean text
function clean(text)

	cleanText = string.gsub(text, '#%x%x%x%x%x%x', '')
	return cleanText

end