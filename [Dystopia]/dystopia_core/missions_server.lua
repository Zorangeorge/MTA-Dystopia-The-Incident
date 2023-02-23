local MISSION_ELEMENT_DESTROY_DELAY = 10000 -- Delay (in ms) between mission end and mission cleanup


addEvent("GiveReputation",true)
function givePlayerRep (amount)
givePlayerMoney(client,amount)
end
addEventHandler("GiveReputation",root,givePlayerRep)

addEvent("RemoveItemInSync",true)
function removeAnItemInSync(index)
		triggerEvent("RefreshDraw",client)
		PlayersItens[client][index]="Empty"
		triggerClientEvent(client,"RefreshDraw",client)
		--triggerClientEvent(client,"ReopenTradePanel",client)--?
		triggerClientEvent(client,"synchronizeTables",client,PlayersItens)
end
addEventHandler("RemoveItemInSync",root,removeAnItemInSync)

addEvent("changePlayerTeam",true)

function changePlayerTeam_func (team_string)
local player = client
local team = getTeamFromName(team_string)
setPlayerTeam(player,team)
local acc = getPlayerAccount(player)
setAccountData(acc,"team", team_string); setElementData(player,"factionkills",0)
setTimer(outputInteractInfo,6000,1, "[ you joined the "..team_string.." ]",player,255,200,0)
end
addEventHandler("changePlayerTeam",root,changePlayerTeam_func)

addEvent("DystopiaTowRespawnVehicle",true)
function dyst_respawn_veh(veh)
	if veh then 
		local x,y,z = getElementPosition(veh)
		setElementPosition(veh,x,y,z-500)
		setTimer(respawnVehicle,30*60000,1,veh) --scrapped vehicles respawn after 30 mins
	end
end
addEventHandler("DystopiaTowRespawnVehicle",root,dyst_respawn_veh)

------mission vehicles & peds

playerMissionVehicles = {}
playerMissionPeds = {}
addEvent("Dystopia_create_mission_vehicle_for_player",true)
addEvent("Dystopia_create_mission_ped_for_player",true)
addEvent("Dystopia_destroy_mission_vehicle_for_player",true)
addEvent("Dystopia_destroy_mission_ped_for_player",true)
addEvent("Dystopia_warpAPedInVehicle",true)

function create_mission_ped_for_player (skin,x,y,z,name,team,pedtype,block,anim)

local ped = createPed(skin,x,y,z)
setElementData(ped,"name",name,true)
setElementData(ped,"BotTeam",getTeamFromName(team),true)
setPedAnimation(ped,block,anim)
playerMissionPeds[client] = ped
triggerClientEvent(client,"SetCurrentMissionPed",root,ped)
--[[if pedtype = "sloth" then ...
elseif pedtype = "civ" then ...
elseif pedtype = "zed" then...
end]]
end
addEventHandler("Dystopia_create_mission_ped_for_player",root,create_mission_ped_for_player)

function warp_ped_into_vehicle(ped,vehicle)

	if (getVehicleOccupant ( vehicle, 1 ) == false) then
		warpPedIntoVehicle ( ped, vehicle, 1 )
	elseif (getVehicleOccupant ( vehicle, 2 ) == false) then
		warpPedIntoVehicle ( ped, vehicle, 2 )
	elseif (getVehicleOccupant ( vehicle, 3 ) == false) then
		warpPedIntoVehicle ( ped, vehicle, 3 )
	else
		outputInteractInfo("[ vehicle is full! ]",client,255,50,0)
		outputDebugString("no free veh slot")
	end

end
addEventHandler("Dystopia_warpAPedInVehicle",root,warp_ped_into_vehicle)

function create_mission_vehicle_for_player(model,x,y,z,r,plate,r1,g1,b1,r2,g2,b2)
	local vehicle = createVehicle ( model, x, y, z, 0, 0, r, plate )
	playerMissionVehicles[client] = vehicle
	triggerClientEvent(client,"SetCurrentMissionVehicle",root,vehicle)
	if r1 then setVehicleColor(vehicle,r1,g1,b1,r2,g2,b2) end
end
addEventHandler("Dystopia_create_mission_vehicle_for_player",root,create_mission_vehicle_for_player)


function destroyMissionElementsForPlayer(player)
	player = player and player or client
	iprint(player)

	local element = playerMissionVehicles[player]
	if isElement(element) then
		setElementAlpha(element, 150)
		setTimer(function(element)
			if isElement(element) then
				destroyElement(element)
				playerMissionVehicles[player] = nil
			end
		end, MISSION_ELEMENT_DESTROY_DELAY, 1, element)
	end

	element = playerMissionPeds[player]
	if isElement(element) then
		setElementAlpha(element, 150)
		setTimer(function(element)
			if isElement(element) then
				destroyElement(element)
				playerMissionPeds[player] = nil
			end
		end, MISSION_ELEMENT_DESTROY_DELAY, 1, element)
	end
end
addEventHandler("Dystopia_destroy_mission_vehicle_for_player", root, destroyMissionElementsForPlayer)
addEventHandler("Dystopia_destroy_mission_ped_for_player", root, destroyMissionElementsForPlayer)
addEventHandler("onPlayerWasted", root, destroyMissionElementsForPlayer)
addEventHandler("onPlayerQuit", root, destroyMissionElementsForPlayer)

----------------CHIPPING AMBULANCE STUFF
chipAmbulance = getElementByID("Chip_Ambulance")

if isElement(chipAmbulance) then 
	setElementFrozen(chipAmbulance,true)
	setVehicleEngineState(chipAmbulance,false) 
	ChippingMedPed = createPed ( 274, 0, 0, 3 )
	setVehicleDamageProof(chipAmbulance,true)
	setElementData(ChippingMedPed,"BotTeam",Establishment)
	setElementData(ChippingMedPed,"name","Screening Medtech")
	warpPedIntoVehicle ( ChippingMedPed, chipAmbulance,2) 
	MedScreenerPed = getElementData(getElementByID("Medtech_Screener"),"theSpawnedBotPed") or false
end

function chipPlayerIfStillInside (player)
	if isPedInVehicle(player) and getPedOccupiedVehicle(player) == chipAmbulance then
		local acc = getPlayerAccount(player)
		setElementData(player,"chipped",true)
		setAccountData(acc,"chipped",true)
		sendToNearbyPlayers(player,"Oww.. What the fuck!?")
		outputInteractInfo("[ you have been chipped ]",player, 240,20,0 )
		if ChippingMedPed then 
			setTimer(triggerClientEvent,4000,1,"onChatIncome",ChippingMedPed,"Good, now go see the Registry Bureaucrat!")
			setTimer(triggerClientEvent,4000,1,player,"PlayerWasChipped",root)
			setTimer(outputChat,4000,1,"Good, now go see the Registry Bureaucrat!",player,"Medtech","Local")
		end
		local theplayer = player
		setTimer(setControlState,3000,1, theplayer,"enter_exit",true)
		setTimer(setControlState,4000,1, theplayer,"enter_exit",false)
		
	end
end

addEvent("MakePlayerRefugee",true)
function makePlayerARefugee(var)
	setPlayerTeam(client,Establishment)
	local acc = getPlayerAccount(client)
	local faction = getTeamName(getPlayerTeam(client))
	local image = faction and ":dystopia_core/images/"..string.lower(faction).."_logo.png" 
	setElementData(client, "    ", image and {type = "image", src =  image, height = 20, width = 20} or " ",true)
	setAccountData(acc,"team",getTeamName(Establishment))
	setTimer(outputInteractInfo,6000,1, "[ you joined the Establishment ]",client,255,200,0)
	setTimer(outputInteractInfo,7000,1, "[ you are now a Refugee ]",client,255,200,0)
end
addEventHandler("MakePlayerRefugee",root,makePlayerARefugee)

function removeChipFromPlayer(playerSource)
	if playerSource then
	setElementData(playerSource,"chipped",false,true)
	local acc = getPlayerAccount(playerSource)
	setAccountData(acc,"chipped",true)
	outputDebugString("player chip removed")
	end
end
addCommandHandler("removechip",removeChipFromPlayer)

function checkChipAmbulance(enteringPlayer, seatNo, playerJacked)

	if enteringPlayer and seatNo == 0 or seatNo == 1 then
		local theplayer = enteringPlayer
		triggerClientEvent(enteringPlayer,"onChatIncome", ChippingMedPed,"You there! Medical exam is here in the back!")
		outputChat("You there! Medical exam is here in the back!", enteringPlayer, "Medtech", "Local")
		--sendToNearbyPlayers (ChippingMedPed,"You there! Medical exam is here in the back!")
		setTimer(setControlState,2000,1, theplayer,"enter_exit",true)
		setTimer(setControlState,3000,1, theplayer,"enter_exit",false)
	elseif enteringPlayer and seatNo == 3 and getPlayerTeam(enteringPlayer)== Establishment then
		triggerClientEvent(enteringPlayer,"onChatIncome", ChippingMedPed, "Get outta here, I've seen you before!")	--this ADDs BUBBLE CLIENTSIDE
		outputChat("Get outta here, I've seen you before!", enteringPlayer, "Medtech", "Local")
		local theplayer = enteringPlayer
		setTimer(setControlState,2000,1, theplayer,"enter_exit",true)
		setTimer(setControlState,3000,1, theplayer,"enter_exit",false)
	elseif enteringPlayer and seatNo == 3 and getElementData(enteringPlayer,"infection") and getElementData(enteringPlayer,"infection") ~= "uninfected" then	
		setTimer(triggerClientEvent,2000,1,"onChatIncome",ChippingMedPed,"Get outta here! You're infected!")
		setTimer(outputChat,2000,1,"Get outta here! You're infected!",enteringPlayer,"Medtech","Local")
		local theplayer = enteringPlayer
		setTimer(setControlState,3000,1, theplayer,"enter_exit",true)
		setTimer(setControlState,4000,1, theplayer,"enter_exit",false)
		setTimer(triggerClientEvent,5000,1,"onChatIncome",ChippingMedPed,"Guards! Somebody put this guy out before it turns!")
		setTimer(outputChat,5000,1,"Guards! Somebody put this guy out before it turns!",enteringPlayer,"Medtech","Local")
	elseif enteringPlayer and seatNo == 3 and getPlayerTeam(enteringPlayer)~= Establishment and getPlayerTeam(enteringPlayer)~= Raiders and getElementData(enteringPlayer,"infection") == "uninfected" then
		triggerClientEvent(enteringPlayer,"onChatIncome", ChippingMedPed, "Take a seat and let me check your vitals...")	--this ADDs BUBBLE CLIENTSIDE
		outputChat("Take a seat and let me check your vitals...", enteringPlayer, "Medtech", "Local")
		setTimer(triggerClientEvent,4000,1,"onChatIncome",ChippingMedPed,"Hold on! This might sting a little...")
		setTimer(outputChat,4000,1,"Hold on! This might sting a little...",enteringPlayer,"Medtech","Local")
		setTimer(chipPlayerIfStillInside,6000,1,enteringPlayer)
	end
end
addEventHandler("onVehicleEnter",chipAmbulance,checkChipAmbulance)
