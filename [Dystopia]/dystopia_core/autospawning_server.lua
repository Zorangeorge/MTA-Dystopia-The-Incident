
addEventHandler ( "onPlayerWasted", getRootElement (), function(ammo,killer,weapon)
	
	local team = getPlayerTeam(source)
	if team == Establishment then outputDebugString("apprehension: team already estab") return end
	if weapon and not KOWeapons[weapon] then outputDebugString("apprehension: not a blunt weapon") return end
	local lives = getElementData (source,"lives")
	if lives < 1 then outputDebugString("apprehension: player dead anyway") return end
	if isElement(killer) and getElementType(killer) ~= "ped" then outputDebugString("killer was not ped") return end
		if killer then
			local acc = getPlayerAccount(source)
			local elemtype = getElementType(killer)
			if elemtype == "ped" then

				local killerTeam = getElementData(killer,"BotTeam") or getTeamFromName("Scavengers")
				if getTeamName(killerTeam) ~= "Establishment" then outputDebugString("killer was not Estab") return end
				
				setAccountData(acc,"positionx",234.1171875)
				setAccountData(acc,"positiony",2014.4580078125)
				setAccountData(acc,"positionz",17.640625)
				setAccountData(acc,"rotation",45.805450439453)
				outputDebugString("apprehension: account data set")

				setPlayerTeam(source,Establishment)
				outputDebugString("apprehension: new team set")
				triggerClientEvent(source,"DrawQuestTitle",source,"Ouch! You got chipped!","apprehended!","You are being processed and transported to the Refugee Camp...")
				setElementData(source,"chipped",true)
				setAccountData(acc,"chipped",true)
				setAccountData(acc,"team",getTeamName(Establishment))
				outputInteractInfo("[ you have been chipped ]",source, 240,0,0 )
			
			elseif elemtype == "player" then

				local killerTeam = getPlayerTeam(killer) 
				if getTeamName(killerTeam) ~= "Establishment" then outputDebugString("killer was not Estab") return end

				
				setAccountData(acc,"positionx",234.1171875)
				setAccountData(acc,"positiony",2014.4580078125)
				setAccountData(acc,"positionz",17.640625)
				setAccountData(acc,"rotation",45.805450439453)
				outputDebugString("account data set")

				setPlayerTeam(source,Establishment)
				outputDebugString("new team set")
				triggerClientEvent(source,"DrawQuestTitle",source,"Ouch! You got chipped!","apprehended!","You are being processed and transported to the Refugee Camp...")
				setElementData(source,"chipped",true)
				setAccountData(acc,"chipped",true)
				setAccountData(acc,"team",getTeamName(Establishment))
				outputInteractInfo("[ you have been chipped ]",source, 240,0,0 )
			else
				return
			end
		end
	
	

	
end)
