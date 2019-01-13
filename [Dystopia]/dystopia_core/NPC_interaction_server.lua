addEvent("onPlayerEmoteChat",true)
addEvent("pedWasDamaged", true)
addEvent("BodyButchered",true)

function talking ( message, messageType ) --partially phased out
	local response
	local player = source
	if message == "Yes" or message == "Yeah" or message == "Okay" then response = "positiveanswer"
	elseif message == "No" or message == "No way..." or message == "Hell no!" then response = "negativeanswer" end
    if messageType == 0 then
        for index, ped in ipairs(getElementsByType ( "ped" )) do
            if ped and getElementType(ped) == "ped" and getElementHealth(ped) > 0 then
            local x, y, z = getElementPosition ( source )
            local x1, y1, z1 = getElementPosition ( ped )
            local distance = getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 )
                if distance < NPC_INTERACTION_DISTANCE then --NPC interact distance
						local pedangle = ( 360 - math.deg ( math.atan2 ( ( x - x1 ), ( y - y1 ) ) ) ) % 360 --MAGIC SPELL TO MAKE PEDS LOOK AT STUFF
						setPedRotation( ped, pedangle )
						setPedAnimation(ped,"ped", table.random(chat_anims))
                   		setTimer ( deployChat, 2000, 1, ped,response,player)
				end
            end
        end
    end
end
addEventHandler( "onPlayerChat", getRootElement(), talking )
addEventHandler( "onPlayerEmoteChat", getRootElement(), talking )

function deployChat(ped,response,player)
		
	if ( getElementData ( ped, "talking" ) == false or getElementData(ped,"answerexpected") == true or getElementData(ped,"confirmationexpected") == true ) and getElementHealth(ped) > 0 then 
		
	local name = getElementData(ped, "name") or ""
	local message
	
		if getElementData ( ped,"questgiver") == true or getElementData(ped,"name") == "Meat" or getElementData(ped,"name") == "Slave" then
			--[[if	getElementData(ped,"confirmationexpected") == true then
					setElementData(ped,"answerexpected",false)
					setElementData(ped,"confirmationexpected",false)
					if  response == "positiveanswer" then
						message = tostring(table.random(QuestsPositive))
					elseif response == "negativeanswer" then
						   message = tostring(table.random(QuestsNegative))
				    end
			elseif  getElementData(ped,"answerexpected") == true then
					if  response == "positiveanswer" then
						setElementData(ped,"answerexpected",false)
						setElementData(ped,"confirmationexpected",false)
						message = "..."--tostring(table.random(refugeequesthubQuests))
						triggerClientEvent(player,"ShowQuestWindow",root,ped)
					elseif response == "negativeanswer" then	
						setElementData(ped,"answerexpected",false)
						setElementData(ped,"confirmationexpected",false)
						message = tostring(table.random(QuestsNegative))
					else message = tostring(table.random(QuestsIntroLines))
					end	
			else
				message = tostring(table.random(QuestsIntroLines))
				setElementData(ped,"answerexpected",true); --outputDebugString("Answer expected")
			end]]
				message = tostring(table.random(QuestsIntroLines))
				triggerClientEvent(player,"ShowQuestWindow",root,ped)
				sendToNearbyPlayers (ped,message)
			--end
	
		elseif getElementData ( ped,"panic") == true then
		local message = tostring(table.random(panicChat))
		sendToNearbyPlayers (ped,message)
		
		elseif getElementData ( ped,"vendor") == true then
		local message = tostring(table.random(traderChat))
		triggerClientEvent(player,"ShowQuestWindow",root,ped)
		sendToNearbyPlayers (ped,message)
		
		elseif getElementData ( ped,"cdf") == true then
		local message = tostring(table.random(CDFChat))
		sendToNearbyPlayers (ped,message)
		
		elseif getElementData ( ped,"refugee") == true then
		local message = tostring(table.random(refugeeChat))
		sendToNearbyPlayers (ped,message)

		elseif getElementData ( ped,"bandit") == true then
		local message = tostring(table.random(banditChat))
		sendToNearbyPlayers (ped,message)
		
		elseif getElementData ( ped,"peacekeeper") == true then
		local message = tostring(table.random(peacekeepersChat))
		sendToNearbyPlayers (ped,message)
		
		elseif getElementData ( ped,"raider") == true then
		local message = tostring(table.random(raiderChat))
		sendToNearbyPlayers (ped,message)
		
		elseif getElementData ( ped,"scavenger") == true then
		local message = tostring(table.random(civilianChat))
		sendToNearbyPlayers (ped,message)

		elseif getElementData ( ped,"wastelander") == true then
		local message = tostring(table.random(guardchat))
		sendToNearbyPlayers (ped,message)

		elseif getElementData ( ped,"freelancer") == true then
		local message = tostring(table.random(guardchat))
		sendToNearbyPlayers (ped,message)	

		elseif getElementData ( ped,"syndicate") == true then
		local message = tostring(table.random(campguardChat))
		sendToNearbyPlayers (ped,message)
		
		elseif getElementData ( ped,"raiderslave") == true then
		local message = tostring(table.random(victimChat)) 
		sendToNearbyPlayers (ped,message)		
		
		elseif getElementData ( ped,"raidermeat") == true then
		local message = tostring(table.random(victimChat)) 
		sendToNearbyPlayers (ped,message)		
		
		elseif getElementData ( ped,"cleaner") == true then
		local message = tostring(table.random(abusivecopChat)) 
		sendToNearbyPlayers (ped,message)		
		
		elseif getElementData ( ped,"suit") == true then
		local message = tostring(table.random(suitChat)) 
		sendToNearbyPlayers (ped,message)
		
		elseif getElementData ( ped,"establishment") == true then
		local message = tostring(table.random(guardchat)) 
		sendToNearbyPlayers (ped,message)		
		

		
--[[		elseif getElementData ( ped,"dumpquesthub") == true then
		local message = tostring(table.random(dumpsitebosschat)) --this part needs various checks to see who's who and what they should say
		sendToNearbyPlayers (ped,message)]]
--------------------------------------------------- Random Quest givers		

			
--[[-----------------------EXAMPLE DIALOGUE TREE----------------------------------------SLIT--------			
		elseif getElementData ( ped,"name") == "Slit" then
																
			if	getElementData(ped,"confirmationexpected") == true then
					setElementData(ped,"answerexpected",false)
					setElementData(ped,"confirmationexpected",false)
					
					if  response == "positiveanswer" then
						message = tostring(table.random(SlitQuestsPositive))
						triggerClientEvent( player, "SlitMission1", ped)
						
					elseif response == "negativeanswer" then
						   message = tostring(table.random(SlitQuestsNegative))
						   SlitSplits(ped)
				    end
					
			elseif  getElementData(ped,"answerexpected") == true then
			
					if  response == "positiveanswer" then
						setElementData(ped,"answerexpected",false)
						setElementData(ped,"confirmationexpected",true)
						message = tostring(table.random(SlitQuests))
												
					elseif response == "negativeanswer" then	
						setElementData(ped,"answerexpected",false)
						setElementData(ped,"confirmationexpected",false)
						message = tostring(table.random(SlitQuestsNegative))
						SlitSplits(ped)
												
					else message = tostring(table.random(SlitQuests))
					end
										
			else
				
				message = tostring(table.random(SlitChat))
				setElementData(ped,"answerexpected",true); outputDebugString("Answer expected")
			
			end
		
			sendPedMessageToClient(player,message, 0, ped)
			outputChatBox ( name..": "..message, source, 255, 255, 255 )]]
-------------------------------------------------------------------------------------------------	
		
		--[[elseif getElementData ( ped,"refugee") == true then
		local message = tostring(table.random(refugeeChat)) 
		sendPedMessageToClient(player,message, 0, ped)
		outputChatBox ( name..": "..message, source, 255, 255, 255 )
		
		elseif getElementData ( ped,"refugeecampguard") == true then
		local message = tostring(table.random(peacekeepersChat)) 
		sendPedMessageToClient(player,message, 0, ped)
		outputChatBox ( name..": "..message, source, 255, 255, 255 )
		
		elseif getElementData ( ped,"refugeecampdetainee") == true then
		local message = tostring(table.random(refugeecampdetaineeChat)) 
		sendPedMessageToClient(player,message, 0, ped)
		outputChatBox ( name..": "..message, source, 255, 255, 255 )
		
		elseif getElementData ( ped,"victim") == true then
		local message = tostring(table.random(victimChat)) 
		sendPedMessageToClient(player,message, 0, ped)
		outputChatBox ( name..": "..message, source, 255, 255, 255 )
		
		elseif getElementData ( ped,"abusivecop") == true then
		local message = tostring(table.random(abusivecopChat)) 
		sendPedMessageToClient(player,message, 0, ped)
		outputChatBox ( name..": "..message, source, 255, 255, 255 )
		
		elseif getElementData(ped, "raider") == true then
		local message = tostring(table.random(raiderChat)) 
		sendPedMessageToClient(player,message, 0, ped)
		outputChatBox ( name..": "..message, source, 255, 255, 255 )]]
		
		elseif getElementData ( ped,"zombie") == true then
		local message = tostring(table.random(zombieChat))
		sendPedMessageToClient(player,message, 0, ped)
		outputChatBox ( name..":"..message, source, 255, 255, 255 )
		
		elseif getElementData(ped, "type") == "animal" or getElementData(ped, "genus") ~= nil then
		-- animals don't talk, what is this, Animal Farm?
		

		
		elseif getElementData ( ped,"cdf") == true then
		local message = tostring(table.random(CDFChat))
		sendPedMessageToClient(player,message, 0, ped)
		outputChatBox ( name..":"..message, source, 255, 255, 255 )
		
		elseif getElementData(ped, "type") == "civilian" then
		local	message = tostring(table.random(civilianChat))
		sendPedMessageToClient(player,message, 0, ped)
		outputChatBox ( name..":"..message, source, 255, 255, 255 )
		
		elseif getElementData(ped, "name") == "Slit" then
		local message = tostring(table.random(SlitChat))
		sendPedMessageToClient(player,message, 0, ped)
		outputChatBox ( name..":"..message, source, 255, 255, 255 )
						
		else
		sendPedMessageToClient(player,"Hello, how are you?", 0, ped)
		outputChatBox ( name..": Hello, how are you?", source, 255, 255, 255 )
		end
		
		setElementData(ped, "talking", true)
		if getElementData ( ped,"refugeequesthub") == true or  getElementData ( ped,"dumpquesthub") == true or getElementData ( ped,"name") == "Slit" then 
		--- insert here what?
		end	
		setTimer(function() setElementData(ped, "talking", false) end, 8500,1) -- "talking" status counter; this interval needs to be set the same in the chat script 
		setTimer(setPedAnimation,8500,1,ped) -- "talking" status counter; this interval needs to be set the same in the chat script 
	end
end

function createButcherCol(ped)
if getElementData(ped,"zombie")== true then return end
--local deadbody = ped
local x,y,z = getElementPosition(ped)
local butcherCol = createColSphere (x, y, z, 0.7)
attachElements (butcherCol,ped)
setElementData(butcherCol, "type","butchercol")
setElementData(butcherCol, "owner", ped)
setTimer(deletebutchercol, 120000,1,butcherCol) --- needs to be the same with the dead body deletion interval

end

function deletebutchercol(butchercol)
	if isElement(butchercol) then 
	destroyElement(butchercol) 
	end 
end

function triggerListener(hitElement, dimension)


if getElementType(hitElement) ~= "player" then return end

	if getElementData(source, "type") == "guardcol" and isElement(getElementData(source, "botassigned")) and getElementType(getElementData(source, "botassigned"))== "ped" and not isPedDead(getElementData(source, "botassigned")) then
		triggerClientEvent(hitElement,"showHelpMessageEvent",hitElement,dialogue_help_messsage)
	end

if getElementData(source,"type") ~= "butchercol" then return end
if getElementData(source,"harvested") == true then return end
local owner = getElementData(source, "owner")
if isElement(owner) and getElementData(owner,"zombie")== true then return end
--if getElementData(source,"brute")== true then return end
		
			if bleedWeapons[getPedWeapon(hitElement)] == true and getPedWeapon(hitElement) ~= 23 and getPedWeapon(hitElement) ~= 14 then 
			outputInteractInfo("Butcher body\n[R]", hitElement, 255, 255, 255)
			triggerClientEvent(hitElement,"showHelpMessageEvent",hitElement,butcher_help_messsage)
			end
		setElementData(hitElement,"insidebutchercol",source);
		
end
addEventHandler("onColShapeHit",root,triggerListener)

function untriggerListener(leaveElement, dimension)
	if getElementData(source,"type") == "butchercol" and getElementType(leaveElement) == "player" and getElementData(leaveElement,"insidebutchercol") ~= nil then 
	setElementData(leaveElement,"insidebutchercol",nil);
	end
end
addEventHandler("onColShapeLeave",root,untriggerListener)

--[[function setTeamBack(attacker,playerTeam) -- used in function triggerAggro
		setPlayerTeam(attacker,playerTeam)
end]]

function triggerAggro( attacker, weapon, bodypart , loss)  --places you in an enemy faction for a second and sets the original team back afterwards; meanwhile you get targeted by all bots that see you

if isElement(attacker) == false then 

return

elseif isElement(attacker) and getElementType(attacker) ~= "player"  then 
   return
elseif getElementData(source,"zombie")==true then
	return
else
	local acc = getPlayerAccount(attacker)
	local originalTeamString = getAccountData (acc,"team") or "Scavengers"
	local originalTeam = getTeamFromName (originalTeamString)
	local pedTeam = getElementData(source, "BotTeam")
	
	if getElementData(source,"name") == "Pig" then setElementData(source,"type","animal"); setElementData(source,"panic",true) end
	
	if originalTeam == pedTeam and getElementData(source,"name") ~= "Pig" then 
		setPlayerTeam(attacker, Neutral)
		setTimer(setPlayerTeam,1000,1,attacker,originalTeam)
	end
	
end	
end
addEventHandler("pedWasDamaged", root, triggerAggro)


function manageFactionsOnMurder(totalammo,killer,weap,bodypart,stealth)

if not killer then return end
if getElementData(source,"zombie") then return end

if not isElement(killer) then -- exclude cases where killer is not a player or is generally... not
	return 
elseif getElementType(killer) ~= "player"  then 
	return
else
		
		local acc = getPlayerAccount(killer)
		local factionkills
		local newfactionkills
		local victimTeam
		local killerTeam = getAccountData(acc,"team")
		
		if not isElement(killer) then 
			return 
		else
		
			if getElementType(source) == "player" then 
				victimTeam = getPlayerTeam (source)
				--outputDebugString("Victim faction: "..getTeamName(victimTeam).."")
			elseif  getElementType(source) == "ped" then
				if source then victimTeam = getElementData(source,"BotTeam") or Zeds
				--if victimTeam then outputDebugString("Victim faction: "..getTeamName(victimTeam).."") end
				end
			end

		factionkills = getElementData(killer,"factionkills")
				--if factionkills then outputDebugString("Old faction kills: "..factionkills.."") end
		if not factionkills then factionkills = 0;  setElementData(killer,"factionkills",0) end
		
		if killerTeam == getTeamName(victimTeam) then 
		setElementData(killer,"factionkills",factionkills+1) 
		newfactionkills = getElementData(killer,"factionkills") or 0
		--outputDebugString("New faction kills: "..newfactionkills.."")
			
			--if newfactionkills>0 then outputDebugString("Faction murders: "..newfactionkills) end
			
			if newfactionkills >= 2 then 
				if killerTeam == "Establishment" then setTimer(setPlayerTeam,2000,1,killer,Scavengers); setAccountData(acc,"team", "Scavengers"); setElementData(killer,"factionkills",0); changeSkinOnFactionChange(killer,Scavengers); setTimer(triggerClientEvent,3000,1,killer,"RefreshBlips",killer);--[[outputDebugString("establishment -> scavengers")]]outputInteractInfo("You are now a Scavenger",killer,100,165,187); 
				elseif killerTeam == "Scavengers" then setTimer(setPlayerTeam,2000,1,killer,Bandits); setAccountData(acc,"team", "Bandits"); setElementData(killer,"factionkills",0); changeSkinOnFactionChange(killer,Bandits); setTimer(triggerClientEvent,3000,1,killer,"RefreshBlips",killer);--[[outputDebugString("scavengers -> bandits")]]outputInteractInfo("You are now a Bandit",killer,100,165,187)
				elseif killerTeam == "Bandits" then setTimer(setPlayerTeam,2000,1,killer,Scavengers); setAccountData(acc,"team", "Scavengers"); setElementData(killer,"factionkills",0); changeSkinOnFactionChange(killer,Scavengers); setTimer(triggerClientEvent,3000,1,killer,"RefreshBlips",killer);--[[outputDebugString("bandits -> scavengers")]]outputInteractInfo("You are now a Scavenger",killer,100,165,187)
				elseif killerTeam == "CDF" then setTimer(setPlayerTeam,2000,1,killer,Scavengers); setAccountData(acc,"team", "Scavengers"); setElementData(killer,"factionkills",0); changeSkinOnFactionChange(killer,Scavengers); setTimer(triggerClientEvent,3000,1,killer,"RefreshBlips",killer);--[[outputDebugString("CDF -> scavengers")]]outputInteractInfo("You are now a Scavenger",killer,100,165,187)
				elseif killerTeam == "Raiders" then setTimer(setPlayerTeam,2000,1,killer,Bandits); setAccountData(acc,"team", "Bandits"); setElementData(killer,"factionkills",0); changeSkinOnFactionChange(killer,Bandits); setTimer(triggerClientEvent,3000,1,killer,"RefreshBlips",killer); --[[outputDebugString("raiders -> bandits")]]outputInteractInfo("You are now a Bandit",killer,100,165,187)
				else 
				--outputDebugString("Faction murders: "..newfactionkills)
				end
					setTimer(function()
					local faction = getTeamName(getPlayerTeam(killer))
					local image = faction and ":dystopia_core/images/"..string.lower(faction).."_logo.png" 
					setElementData(killer, "    ", image and {type = "image", src =  image, height = 20, width = 20} or " ",true)
					end
					,3000,1)
			end
		end
		end
		end
		
		
	end
addEventHandler("onPlayerWasted",root,manageFactionsOnMurder)
addEventHandler("onPedWasted",root,manageFactionsOnMurder)

function manageKarmaOnMurder (totalammo,killer,weap,bodypart,stealth)
--source is the dead ped/player
if not killer then return end
if getElementData(source,"zombie") == true then return end
if getElementType(killer) ~= "player" then return end
if not getElementData(killer,"karma") then setElementData(killer,"karma",0) end

local karma = getElementData(killer,"karma")
--outputDebugString("initial karma is: "..karma)

local civilian = false
if getElementData(source,"type") == "civilian" then civilian = true end
--outputDebugString("civilian is: "..tostring(civilian))

local slothbot = getElementData(source,"slothbot") or false
--outputDebugString("slothbot is: "..tostring(slothbot))

local zombie = getElementData(source,"zombie") or false

if zombie then return end 

local killerfaction = getPlayerTeam (killer)
--outputDebugString("killer faction is: "..tostring(getTeamName(killerfaction)))

local victimfaction 
if getElementType(source) == "player" then victimfaction = getPlayerTeam (source) else victimfaction = getElementData(source,"BotTeam") end
--outputDebugString("victim faction is: "..tostring(getTeamName(victimfaction)))

if slothbot then 
			if killerfaction == victimfaction then 
			addPlayerKarma(killer,-3) 
			outputStatusInfo("-3 karma",killer, 240,240,240 )
			else
			--not needed yet, maybe give karma bonus for killing raiders and bandits?
			--addPlayerKarma(killer,-2)
			end
		return
	end

	if civilian then
		if killerfaction == victimfaction then 
		addPlayerKarma(killer,-4) 
		outputStatusInfo("-4 karma",killer, 240,240,240 )
		else
		addPlayerKarma(killer,-2)
		outputStatusInfo("-2 karma",killer, 240,240,240 )
		end
	    return
	end
	
-- if civilian then karma = karma-2
-- if slothbot & samefaction then karma = karma-3
-- if civilian & samefaction then karma = karma-4
-- if eathuman then karma = -100
-- if savehuman then karma = karma+3
-- if healhuman then karma = karma+1
-- if goodmission then karma = karma+x --this needs to be triggered with the mission accomplished
-- if badmission then karma = karma-x

end

addEventHandler("onPlayerWasted",root,manageKarmaOnMurder)
addEventHandler("onPedWasted",root,manageKarmaOnMurder)

function changeSkinOnFactionChange(player,newfaction)

local weapslot = getPedWeaponSlot(player)

	if newfaction == Bandits then setElementModel(player,table.random(banditSkin))
	elseif newfaction == Scavengers then setElementModel(player,table.random(ScavengerGuardSkins))
	elseif newfaction == Raiders then setElementModel(player,table.random(raiderSkin))
	elseif newfaction == Establishment then setElementModel(player,table.random(refugeeSkins))
	elseif newfaction == CDF then setElementModel(player,table.random(CDFMilitiaskins))
	end
	
	setTimer(setPedWeaponSlot,200,1, player, weapslot) --re-equip weapon after model change
	
	local newskin = getElementModel(player)
	local acc = getPlayerAccount(player)
	setAccountData(acc,"currentSkin",newskin)
	
end

function createMeatPieces(butchercol)

	destroyElement(butchercol)
	setElementData(client,"insidebutchercol",nil)
	local name = getElementData(source,"name")
	local x,y,z = getElementPosition(source)
	local rand = math.random(0,4)
	local meattype

		if name == "Goat" or name == "Pig" or name == "Wild Pig" or name == "Bear" or name == "Wolf" then meattype = "animalmeat" else meattype = "humanmeat" end
	
		if meattype == "humanmeat" then 
			setTimer( function()
			meat = createObjectItem("Raw Human Meat", x,y,z-0.95, 97.3,120, math.random(0,359)) 
			end, 2000,1)
		elseif meattype == "animalmeat" then 
			setTimer( function()
			meat = createObjectItem("Raw Meat", x,y,z-0.95, 97.3,120, math.random(0,359))
			end, 2000,1)
		end
		
end
addEventHandler("BodyButchered", root, createMeatPieces)

addEvent("ButcherAnim",true)
function butcheranimfunc ()
setPedAnimation ( client, "BOMBER", "BOM_Plant_Loop", 5000, true, false, true, false)
outputStatusInfo("Butchering...",client, 245,0,0)
triggerClientEvent(client, "sleep:drawDXProgress", client, 4500,4500)
setTimer(triggerClientEvent,4500,1,client, "sleep:stopDXProgress", client)
local player = client
setTimer( function() setPedAnimation(player) end, 4500, 1)
end
addEventHandler("ButcherAnim",root,butcheranimfunc)