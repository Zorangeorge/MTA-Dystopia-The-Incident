
function createCDFHunter(x,y,z,r,team,name,botSkinID)

if not botSkinID then botSkinID = table.random(CDFMilitiaskins) end
if (not name or name == "") then name = "Militia" end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, botSkinID, int, int, CDF, table.random(CampGuardWeapons), "hunting", nil)
    			setElementData(ped, "name", name)
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "cdf", true)
				triggerClientEvent("PropPed",root,ped) 
		return ped
end

function createCDFStaff (x,y,z,r,team)

local ped = createPed(table.random(CDFStaffSkins), x, y, z)
				setElementData(ped, "sex", "male")
                setElementData(ped, "type", "civilian")
				setElementData(ped, "name", "Citizen")
                setElementData(ped, "BotTeam", CDF)
				setElementData(ped, "cdf", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end	

function createCDFVendor (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(CDFVendorSkins), int, int, CDF, 24, "guarding", nil)
               	setElementData(ped, "name", "Quartermaster")
				setElementData(ped, "cdf", true)
				setElementData(ped, "vendor", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end	

function createCDFQuestGiver (x,y,z,r,team,name,skin)

if (not name or name == "") then name = "Militia Leader" end
if not skin then skin = table.random(CDFVendorSkins) end

	if name == "CDF Recruiter" then
		local ped = createPed(skin,x,y,z,r)
					setElementData(ped,"BotTeam",getTeamFromName("CDF"))
					setElementData(ped, "cdf", true)
					setElementData(ped, "questgiver", true,true)
					setElementData(ped, "name", name)
					triggerClientEvent("PropPed",root,ped)
			return ped
	else

		local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, skin, int, int, CDF, 0, "guarding", nil)
					setElementData(ped, "cdf", true)
					setElementData(ped, "questgiver", true,true)
					setElementData(ped, "name", name)
					triggerClientEvent("PropPed",root,ped)
			return ped
	end
	
end	


function createRaiderGuard(x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(raiderSkin), int, int, Raiders, table.random(CampGuardWeapons), "guarding", nil)
              
				setElementData(ped, "name", "Raider Barker")
				setElementData(ped, "raider", true)
		
		triggerClientEvent("PropPed",root,ped)
		return ped
end

function createCDFGuard (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(CDFMilitiaskins), int, int, CDF, table.random(CampGuardWeapons), "guarding", nil)
				setElementData(ped, "name", "Militia")
				setElementData(ped, "cdf", true)
		triggerClientEvent("PropPed",root,ped)
		return ped
end	

function createRaiderHunter(x,y,z,r,team)


local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(raiderSkin), int, int, Raiders, table.random(raiderWeapons), "hunting", nil)
    			setElementData(ped, "name", "Raider Mongrel")
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "raider", true)
				
		triggerClientEvent("PropPed",root,ped)
		return ped
end

function createRaiderMeat (x,y,z,r,team)

local ped = createPed(table.random(meatSkin), x, y, z)
               	setElementData(ped, "name", "Meat")
                setElementData(ped, "BotTeam", Raiders)
				local randnum = math.random(0,3)
				if randnum == 0 then 
							setPedAnimation(ped,"BEACH","ParkSit_M_Loop",-1, true, false, true, false)
				elseif randnum == 1 then
							setPedAnimation(ped,"SWEET","Sweet_injuredloop",-1, true, false, true, false)
				elseif randnum == 2 then
							setPedAnimation(ped, "CRACK", "crckidle2", -1, false, true, false, true)
				elseif randnum == 3 then
							setPedAnimation(ped, "GRAVEYARD", "mrnF_loop", -1, true, false, true, false)
				end
				setElementData (ped,"raidermeat",true)
				triggerClientEvent("PropPed",root,ped)
return ped
						
end

function createRaiderSlave (x,y,z,r,team)

local ped = createPed(table.random(slaveSkin), x, y, z)
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
                setElementData(ped, "name", "Slave")
                setElementData(ped, "BotTeam", Raiders)
				setElementData (ped,"raiderslave",true)
				triggerClientEvent("PropPed",root,ped)
				return ped
		
end		

function createRaiderVendor (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(raiderSkin), int, int, Raiders, table.random(randomMelee), "guarding", nil)
               	setElementData(ped, "name", "Trader")
				setElementData(ped, "raider", true)
				setElementData(ped, "vendor", true)
		triggerClientEvent("PropPed",root,ped)
		return ped
end	
	
function createRaiderQuestGiver (x,y,z,r,team,name,skin)

if not team then team = Raiders end
if (not name or name == "") then name = "Warchief" end
if not skin then skin = table.random(raiderSkin) end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, skin, int, int, Raiders, table.random(raiderBossWeapons), "guarding", nil)
				setElementData(ped,"name",name)
				setElementData(ped, "raider", true)
				setElementData(ped, "questgiver", true,true)
		
		triggerClientEvent("PropPed",root,ped)
		return ped
end	

function createScavengerVendor (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(ScavengersVendorSkins), int, int, Scavengers, 24, "guarding", nil)
               	setElementData(ped, "name", "Trader")
				setElementData(ped, "scavenger", true)
				setElementData(ped, "vendor", true)
		triggerClientEvent("PropPed",root,ped)
		return ped
end	

function createSyndicateNang(x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(SyndicateDaNangSkin), int, int, Scavengers, table.random(CampGuardWeapons), "guarding", nil)

				setElementData(ped, "name", "Guard")
                setElementData(ped, "syndicate", true)

		triggerClientEvent("PropPed",root,ped)
		return ped
end

function createSyndicateTriad(x,y,z,r,team,weap)

if not team then team = Scavengers end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(SyndicateTriadSkin), int, int, Scavengers, table.random(SyndicateTriadWeapons), "guarding", nil)

				setElementData(ped, "name", "Guard")
				setElementData(ped, "syndicate", true)

		triggerClientEvent("PropPed",root,ped)
		return ped
end

function createSyndicateCiv (x,y,z,r,team)

local ped = createPed(table.random(SyndicateCivSkin), x, y, z)
				setElementData(ped, "BotTeam", Scavengers)
				setElementData(ped, "sex", "male")
                setElementData(ped, "type", "civilian")
				setElementData(ped, "name", "Survivor")
                setElementData(ped, "syndicate", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
		
end	

function createPig (x,y,z,r,team)

local pig = createPed(table.random(animalFarmSkins), x, y, z,r)
                setElementData(pig, "genus", "farm")
                setElementData(pig, "name", "Pig")
                setElementData(pig, "BotTeam", Scavengers)
		
		return pig
end	

function createGoat (x,y,z,r,team)

local goat = createPed(table.random(animalWildSkins), x, y, z,r)
                setElementData(goat, "genus", "wild")
                setElementData(goat, "name", "Goat")
				setElementData(goat, "type", "animal")
                setElementData(goat, "BotTeam", Neutral)

		return goat
end	

function createWildPig (x,y,z,r,team)

local wildpig = createPed(table.random(animalFarmSkins), x, y, z,r)
                setElementData(wildpig, "genus", "wild")
                setElementData(wildpig, "name", "Wild Pig")
				setElementData(wildpig, "type", "animal")
                setElementData(wildpig, "BotTeam", Neutral)

		return wildpig
end	

function createScavengerCiv (x,y,z,team)

local ped = createPed(table.random(dumpSkins), x, y, z)
                setElementData(ped, "BotTeam", Scavengers)
				setElementData(ped, "sex", "male")
                setElementData(ped, "type", "civilian")
				setElementData(ped, "name", "Survivor")
				setElementData(ped, "scavenger", true)
		triggerClientEvent("PropPed",root,ped)
		return ped
end	

function createEstablishmentRefugee (x,y,z,team)

local ped = createPed(table.random(refugeeSkins), x, y, z)
				setElementData(ped, "sex", "male")
                setElementData(ped, "type", "civilian")
				setElementData(ped, "name", "Refugee")
                setElementData(ped, "BotTeam", Establishment)
				setElementData(ped, "refugee", true)
				triggerClientEvent("PropPed",root,ped)

		return ped
end	

function createEstablishmentGrunt (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, 287, int, int, Establishment, table.random(ESTgruntWeapons), "guarding", nil)
				setElementData(ped, "name", "Trooper")
				setElementData(ped, "establishment", true)
				setPedArmor(ped,25)
				triggerClientEvent("PropPed",root,ped)

		return ped
end	

function createEstablishmentHeavy (x,y,z,r,team,weap)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, 277, int, int, Establishment, table.random(ESTgruntHeavyWeapons), "guarding", nil)
				setElementData(ped, "name", "Heavy Trooper")
				setElementData(ped, "heavy", true)
				setElementData(ped, "establishment", true)
				setPedArmor(ped,50)
				triggerClientEvent("PropPed",root,ped)
				setElementData(ped, "laser.on",true,true)

		return ped
end	

function createEstablishmentR01 (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, 265, int, int, Establishment, table.random(ESTgruntWeapons), "guarding", nil)
				setElementData(ped, "name", "R/01 Grunt")
				setElementData(ped, "establishment", true)
				setPedArmor(ped,50)
				triggerClientEvent("PropPed",root,ped)
				setElementData(ped, "laser.on",true,true)

		return ped
end	

function createEstablishmentR01H (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, 279, int, int, Establishment, table.random(ESTgruntHeavyWeapons), "guarding", nil)
				setElementData(ped, "name", "R/01 Heavy")
				setElementData(ped, "heavy", true)
				setPedArmor(ped,75)
				setElementData(ped, "establishment", true)
				triggerClientEvent("PropPed",root,ped)
				setElementData(ped, "laser.on",true,true)
		return ped
end	

function createEstablishmentSpec (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, 285, int, int, Establishment, table.random(ESTSpecWeapons), "hunting", nil)
				setElementData(ped, "name", "R/01 Spec")
				setElementData(ped, "spec", true)
				setPedArmor(ped,50)
				setElementData(ped, "establishment", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createEstablishmentCleaner (x,y,z,r,team,name,skin)

if (not name or name == "") then name = "Cleaner" end
if not skin then skin = 281 end
local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, skin, int, int, Establishment, table.random(ESTCleanerWeapons), "hunting", nil)
				setElementData(ped, "name", name)
				setElementData(ped, "establishment", true)
				setElementData(ped, "type", "civilian")
				setElementData(ped, "cleaner", true)
				setPedArmor(ped,25)
				triggerClientEvent("PropPed",root,ped)
			return ped
end	

function createEstablishmentPeacekeeper (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(EstablishmentPeacekeeperSkins), int, int, Establishment, table.random(CampGuardWeapons), "guarding", nil)
               
				setElementData(ped, "name", "Peacekeeper")
				setElementData(ped, "establishment", true)
				setElementData(ped, "peacekeeper", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createEstablishmentQuestGiver (x,y,z,r,team,name,skin)
if not skin then skin = 286 end --286 estab beaurocrat (fbi skin)
local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, skin, int, int, Establishment, 0, "guarding", nil) 
				setElementData(ped,"name",name)
				setElementData(ped, "establishment", true)
				setElementData(ped, "questgiver", true,true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end	

function createEstablishmentArmyPatrol(x,y,z,r,team,name,botSkinID)

if not botSkinID then botSkinID = table.random(EstabTrooperSkins) end
if (not name or name == "") then name = "Trooper" end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, botSkinID, int, int, Establishment, table.random(ESTgruntWeapons), "hunting", nil)
    			setElementData(ped, "name", name)
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "armypatrol", true)
				setElementData(ped, "establishment", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createEstablishmentR01Patrol(x,y,z,r,team,name,botSkinID)

if not botSkinID then botSkinID = table.random(EstablishmentSpecSkins) end
if (not name or name == "") then name = "R/01 Operator" end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, botSkinID, int, int, Establishment, table.random(ESTgruntHeavyWeapons), "hunting", nil)
    			setElementData(ped, "name", name)
				setPedArmor(ped,25)
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "R01patrol", true)
				setElementData(ped, "establishment", true)
				triggerClientEvent("PropPed",root,ped)
				
				setElementData(ped, "laser.on",true,true)
				
		return ped
end

function createEstablishmentPeacekeepPatrol(x,y,z,r,team,name,botSkinID)

if not botSkinID then botSkinID = table.random(EstablishmentPeacekeeperSkins) end
if (not name or name == "") then name = "Peacekeeper" end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, botSkinID, int, int, Establishment, 3, "hunting", nil)
    			setElementData(ped, "name", name)
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "peacekeeper", true)
				setElementData(ped, "establishment", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createEstablishmentSuit(x,y,z,r,team,name,botSkinID)

if not botSkinID then botSkinID = table.random(EstabSuitSkins) end
if (not name or name == "") then name = "R/01 Agent" end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, botSkinID, int, int, Establishment, 29, "hunting", nil)
    			setElementData(ped, "name", name)
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "suit", true)
				setElementData(ped, "establishment", true)
				setPedArmor(ped,25)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createEstablishmentStaff (x,y,z,r,team,name,botSkinID)

if not botSkinID then botSkinID = table.random(EstabStaffSkins) end

if botSkinID == 27 or botSkinID == 260 or botSkinID == 309 or botSkinID == 305 or botSkinID == 268 or botSkinID == 50 then name = "Worker" else name = "Servant" end

local ped = createPed(botSkinID, x, y, z)
				setElementData(ped, "sex", "male")
                setElementData(ped, "type", "civilian")
				setElementData(ped, "name", name)
                setElementData(ped, "BotTeam", Establishment)
				setElementData(ped, "establishment", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end	

function createEstablishmentVIP (x,y,z,r,team,name,botSkinID)

if not botSkinID then botSkinID = table.random(EstabVIPSkins) end
if (not name or name == "") then name = "Resident" end

local ped = createPed(botSkinID, x, y, z)
				setElementData(ped, "sex", "male")
                setElementData(ped, "type", "civilian")
				setElementData(ped, "name", name)
                setElementData(ped, "BotTeam", Establishment)
				setElementData(ped, "establishment", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createBanditGuard(x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(banditSkin), int, int, Bandits, table.random(banditWeapons), "guarding", nil)
				setElementData(ped, "name", "Bandit")
				setElementData(ped, "bandit", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createBanditHunter(x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(banditSkin), int, int, Bandits, table.random(banditWeapons), "hunting", nil)
    			setElementData(ped, "name", "Bandit")
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "bandit", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createBanditQuestGiver(x,y,z,r,team,name,skin)

if (not name or name == "") then name = "Gang Leader" end
if not skin then skin = table.random(banditSkin) end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, skin, int, int, Bandits, table.random(banditWeapons), "guarding", nil)
				setElementData(ped,"name",name)
				setElementData(ped, "bandit", true)
				setElementData(ped, "questgiver", true,true)

				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createNeutralFreelancer(x,y,z,r,team)

local names = {"Looter","Robber","Vagrant","Drifter","Nomad","Thug"}

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(NeutralFreelancerSkins), int, int, Neutral, table.random(NeutralFreelancerWeapons), "hunting", nil)
    			setElementData(ped, "name", table.random(names))
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "neutralfreelancer", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createBear(x,y,z,r,team,name,skin)

if (not name or name == "") then name = "Bear" end
if not skin then skin = 205 end
local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, skin, int, int, Neutral, 0, "hunting", nil)
    			setElementData(ped, "name", name)
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "bear", true)
				setPedArmor(ped,100)
		return ped
end

function createScavengerGuard(x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(ScavengerGuardSkins), int, int, Scavengers, table.random(CampGuardWeapons), "guarding", nil)

				setElementData(ped, "name", "Guard")
				setElementData(ped, "scavenger", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createScavengerFreelancer(x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(ScavengerFreelancerSkins), int, int, Scavengers, table.random(banditWeapons), "hunting", nil)
    			setElementData(ped, "name", "Scavenger")
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "freelancer", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createWasteGuard(x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(wastelandersSkin), int, int, Scavengers, table.random(CampGuardWeapons), "guarding", nil)

				setElementData(ped, "name", "Wastelander")
				setElementData(ped, "wastelander", true)

				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createWasteCiv (x,y,z,team)

local ped = createPed(table.random(wastelanderCivSkin), x, y, z)
                setElementData(ped, "sex", "male")
                setElementData(ped, "type", "civilian")
				setElementData(ped, "name", "Wastelander")
                setElementData(ped, "BotTeam", Scavengers)
				setElementData(ped, "wastelander", true)
				triggerClientEvent("PropPed",root,ped)

		return ped
end	

function createWasteVendor (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(wastelanderCivSkin), int, int, Scavengers, 24, "guarding", nil)
               	setElementData(ped, "name", "Trader")
				setElementData(ped, "wastelander", true)
				setElementData(ped, "vendor", true)
		
				triggerClientEvent("PropPed",root,ped)
		return ped
end	

function createWastefreelancer(x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(WastelanderFreelancerSkins), int, int, Scavengers, table.random(banditWeapons), "hunting", nil)
    			setElementData(ped, "name", "Wastelander")
				setElementData(ped, "type", "civilian")
				setElementData(ped, "sex", "male")
				setElementData(ped, "freelancer", true)
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createSyndVendor (x,y,z,r,team)

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, table.random(SyndicateCivSkin), int, int, Scavengers, 24, "guarding", nil)
               	setElementData(ped, "name", "Trader")
				setElementData(ped, "syndicate", true)
				setElementData(ped, "vendor", true)
		
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createScavQuestGiver(x,y,z,r,team,name,skin)

if (not name or name == "") then name = "Scavenger Leader" end
if not skin then skin = table.random(ScavengerFreelancerSkins) end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, skin, int, int, Scavengers, 0, "guarding", nil)

				setElementData(ped, "name", name)
				setElementData(ped, "scavenger", true)
				setElementData(ped, "questgiver", true,true)
		
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createWasteQuestGiver(x,y,z,r,team,name,skin)

if (not name or name == "") then name = "Wastelander Leader" end
if not skin then skin = table.random(WastelanderFreelancerSkins) end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, skin, int, int, Scavengers, 0, "guarding", nil)

				setElementData(ped, "name", name)
				setElementData(ped, "wastelander", true)
				setElementData(ped, "questgiver", true,true)
		
				triggerClientEvent("PropPed",root,ped)
		return ped
end

function createSyndQuestGiver(x,y,z,r,team,name,skin)

if (not name or name == "") then name = "Syndicate Boss" end
if not skin then skin = table.random(SyndQuestgiverSkins) end

local ped = exports["dystopia_slothbot"]:spawnBot (x,y,z,r, skin, int, int, Scavengers, 0, "guarding", nil)

				setElementData(ped, "name", name)
				setElementData(ped, "syndicate", true)
				setElementData(ped, "questgiver", true,true)
		
				triggerClientEvent("PropPed",root,ped)
		return ped
end

----OK, A NEW SPAWNING APPROACH, USING THE EDF SPAWNPOINT ELEMENTS:

--1. parse through all "[..]_spawn" elements and create colshapes


bot_cols = {}
function setupBotSpawnCols (resource)

local botspawns = { }
local Raider_spawns = getElementsByType ( "Raider_spawn" )
local CDF_spawns = getElementsByType ( "CDF_spawn" )
local Establishment_spawns = getElementsByType ( "Establishment_spawn" )
local Bandit_spawns = getElementsByType ( "Bandit_spawn" )
local Scavenger_spawns = getElementsByType ( "Scavenger_spawn" )
local Neutral_spawns = getElementsByType ( "Neutral_spawn" )
local Zombie_spawns = getElementsByType ( "Zombie_spawn" )

outputDebugString("loading bot spawnpoints...")

	for BotKey,theBot in ipairs(Raider_spawns) do
		table.insert( botspawns, theBot )
	end
	for BotKey,theBot in ipairs(CDF_spawns) do
		table.insert( botspawns, theBot )
	end
	for BotKey,theBot in ipairs(Establishment_spawns) do
		table.insert( botspawns, theBot )
	end
	for BotKey,theBot in ipairs(Bandit_spawns) do
		table.insert( botspawns, theBot )
	end
	for BotKey,theBot in ipairs(Scavenger_spawns) do
		table.insert( botspawns, theBot )
	end
	for BotKey,theBot in ipairs(Neutral_spawns) do
		table.insert( botspawns, theBot )
	end
	for BotKey,theBot in ipairs(Zombie_spawns) do
		table.insert( botspawns, theBot )
	end
	
	for _,botspawn in ipairs(botspawns) do

				local x = getElementData(botspawn, "posX") 
				local y = getElementData(botspawn, "posY") 
				local z = getElementData(botspawn, "posZ")
				local botRange = getElementData(botspawn, "botRange")
			
			local spawnRadiusCol = createColSphere (x,y,z,botRange) -- bot spawn col radius
			setElementData(spawnRadiusCol,"botToSpawn",botspawn)
			setElementData(spawnRadiusCol,"botWasSpawned",false)
			setElementData(source,"theSpawnedBotPed",false)

			table.insert(bot_cols, spawnRadiusCol)
	end

end

addEventHandler("onResourceStart",resourceRoot,setupBotSpawnCols)

--2. onColShapeHit: 
	-- is bot already spawned?
		-- Y: return
		-- N: spawn bot; mark as spawned

function onHitF(hitElem,dim)

if not getElementData(source,"botToSpawn") then return end --if it ain't a spawncol then return

if getElementType(hitElem) ~= "player" then return end --if it ain't a player involved then return

if isTimer(getElementData(source,"respawnTimer")) then return end --if there is a respawntimer active on the bot

	if getElementData (source,"botWasSpawned") == true then -- if the bot is already spawned then return
		return
	elseif getElementData (source,"botWasSpawned") == false then -- it's a spawn col and the bot has not spawned yet; we proceed with spawning

	spawnpoint = getElementData(source,"botToSpawn")

	local x = getElementData(spawnpoint, "posX") 
	local y = getElementData(spawnpoint, "posY") 
	local z = getElementData(spawnpoint, "posZ")
	local r = getElementData(spawnpoint, "rotZ")	
	spawnType = getElementType(spawnpoint)
	botType = getElementData (spawnpoint,"BotType") or false
	botName = getElementData (spawnpoint,"name") or false
	botSkinID = getElementData (spawnpoint,"botSkinID") or false
	ZedType = getElementData (spawnpoint,"ZedType") or false


		if spawnType == "Raider_spawn" then
			if botType == "Guard" then
				ped = createRaiderGuard(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
				
			elseif botType =="Hunter" then
				ped = createRaiderHunter(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Slave" then
				ped = createRaiderSlave(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Meat" then
				ped = createRaiderMeat(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Vendor" then
				ped = createRaiderVendor(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Quest" then
				ped = createRaiderQuestGiver(x,y,z,r,team,botName,botSkinID) 
				setElementData(source,"theSpawnedBotPed", ped)
			end

		elseif spawnType == "CDF_spawn" then
			if botType == "Guard" then
				ped = createCDFGuard(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Staff" then
				ped = createCDFStaff(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Vendor" then
				ped = createCDFVendor(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Quest" then
				ped = createCDFQuestGiver(x,y,z,r,team,botName,botSkinID)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Hunter" then
				ped = createCDFHunter(x,y,z,r,team,botName,botSkinID)	
				setElementData(source,"theSpawnedBotPed", ped)
			end
			
		elseif spawnType == "Establishment_spawn" then
			if botType == "Grunt" then
				ped = createEstablishmentGrunt(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Heavy" then
				ped = createEstablishmentHeavy(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Rescue01" then
				ped = createEstablishmentR01(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Rescue01heavy" then
				ped = createEstablishmentR01H(x,y,z,r,team,weap)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Spec" then
				ped = createEstablishmentSpec(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Peacekeeper" then
				ped = createEstablishmentPeacekeeper(x,y,z,r,team,weap)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Refugee" then
				ped = createEstablishmentRefugee(x,y,z,r,team,weap)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Quest" then
				ped = createEstablishmentQuestGiver(x,y,z,r,team,botName,botSkinID)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Cleaner" then
				ped = createEstablishmentCleaner(x,y,z,r,team,botName,botSkinID)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Staff" then
				ped = createEstablishmentStaff(x,y,z,r,team,botName,botSkinID)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="ArmyPatrol" then
				ped = createEstablishmentArmyPatrol(x,y,z,r,team,botName,botSkinID)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="R01Patrol" then
				ped = createEstablishmentR01Patrol(x,y,z,r,team,botName,botSkinID)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="PeacekePatrol" then
				ped = createEstablishmentPeacekeepPatrol(x,y,z,r,team,botName,botSkinID)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Suit" then
				ped = createEstablishmentSuit(x,y,z,r,team,botName,botSkinID)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="VIP" then
				ped = createEstablishmentVIP(x,y,z,r,team,botName,botSkinID)
				setElementData(source,"theSpawnedBotPed", ped)
			end
			

		elseif spawnType == "Bandit_spawn" then
			if botType =="Guard" then
				ped = createBanditGuard(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Hunter" then
				ped = createBanditHunter(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Quest" then
				ped = createBanditQuestGiver(x,y,z,r,team,botName,botSkinID)	
				setElementData(source,"theSpawnedBotPed", ped)
			end
			
		elseif spawnType == "Neutral_spawn" then
			if botType =="Goat" then
				ped = createGoat(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="WildPig" then
				ped = createWildPig(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Freelance" then
				ped = createNeutralFreelancer(x,y,z,r,team,weap)	 
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Bear" then
				ped = createBear(x,y,z,r,team,weap)	 
				setElementData(source,"theSpawnedBotPed", ped)
			end
			
		elseif spawnType == "Scavenger_spawn" then --place slothbot entries first, otherwise they engage the civs
			if botType =="ScavGuard" then
				ped = createScavengerGuard(x,y,z,r,team,weap) 
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="WasteFreelance" then
				ped = createWastefreelancer(x,y,z,r,team,weap) 
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Nang" then
				ped = createSyndicateNang(x,y,z,r,team,weap)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Triad" then
				ped = createSyndicateTriad(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Freelance" then
				ped = createScavengerFreelancer(x,y,z,r,team,weap)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="WasteGuard" then
				ped = createWasteGuard(x,y,z,r,team,weap) 
				setElementData(source,"theSpawnedBotPed", ped)
				
			elseif botType =="ScavVendor" then
				ped = createScavengerVendor(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="WasteVendor" then
				ped = createWasteVendor(x,y,z,r,team,weap)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="SyndVendor" then
				ped = createSyndVendor(x,y,z,r,team,weap)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="ScavQuest" then
				ped = createScavQuestGiver(x,y,z,r,team,botName,botSkinID) 
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="WasteQuest" then
				ped = createWasteQuestGiver(x,y,z,r,team,botName,botSkinID)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="SyndQuest" then
				ped = createSyndQuestGiver(x,y,z,r,team,botName,botSkinID)	
				setElementData(source,"theSpawnedBotPed", ped)	
				
			elseif botType =="Civ" then
				ped = createScavengerCiv(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="WasteCiv" then
				ped = createWasteCiv(x,y,z,r,team,weap)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="SyndCiv" then
				ped = createSyndicateCiv(x,y,z,r,team,weap)	
				setElementData(source,"theSpawnedBotPed", ped)
			elseif botType =="Pig" then
				ped = createPig(x,y,z,r,team,weap)
				setElementData(source,"theSpawnedBotPed", ped)
			end
			
		elseif spawnType == "Zombie_spawn" then --createZombie
			--if ZedType == "Walker" then
				ped = exports["dystopia_zombies"]:createZombie (ZedType,x,y,z,r)
				setElementData(source,"theSpawnedBotPed", ped)
			--elseif ZedType == "Runner" then
			--	ped = exports["dystopia_zombies"]:createZombie (ZedType,x,y,z,r)		
			--	setElementData(source,"theSpawnedBotPed", ped)
			--elseif ZedType == "Brute" then
			--	ped = exports["dystopia_zombies"]:createZombie (ZedType,x,y,z,r)	
			--	setElementData(source,"theSpawnedBotPed", ped)
			--end

		end
	
	setElementData(source,"botWasSpawned", true)
	if isElement(ped) then setElementData(ped,"botSpawnCol", source) end
	ped = nil	

	end
end
addEventHandler("onColShapeHit",resourceRoot,onHitF)

--3. onColShapeLeave:
	-- is there any other player left in colshape?
		-- Y: return
		-- N: delete bot; mark as unspawned

function onLeaveF (leaveElem,dim)

if not getElementData(source,"botToSpawn") then return end

	if getElementType(leaveElem) == "player" then 
		
		if getElementData (source,"botWasSpawned") == false then -- the bot is not spawned
			return
		elseif getElementData (source,"botWasSpawned") == true then -- it's a spawn col and the bot is spawned 
		
		local playersInColShape = getElementsWithinColShape ( source, "player")
		
			if #(playersInColShape) > 0 then 
				return
			else --if no players left in colshape
			botToDelete = getElementData(source,"theSpawnedBotPed")
			if isElement(botToDelete) then destroyElement(botToDelete) end -- spits an error if you kill the bot, wait until the body gets removed and then leave the area
			setElementData(source,"botWasSpawned", false)
			setElementData(source,"theSpawnedBotPed", false)
			botToDelete = nil
			end
		end
	else
		return
	end

end
addEventHandler("onColShapeLeave",resourceRoot,onLeaveF)

addEventHandler("onPlayerQuit", root,
	function ()
		for k, colshape in ipairs(bot_cols) do
			if isElementWithinColShape(source, colshape) then
				--print ("Is inside colshape.")
				--print ("Players inside colshape: "..tostring(#getElementsWithinColShape(colshape, "player")))
				if #getElementsWithinColShape(colshape, "player") == 1 then --no one but him is in the colshape
					local bot = getElementData(colshape, "theSpawnedBotPed")
					if isElement(bot) then
						destroyElement(bot)
						setElementData(colshape,"botWasSpawned", false)
						setElementData(colshape,"theSpawnedBotPed", false)
						--print ("Destroyed")
					end
				end
			end
		end
	end
)

deadBotsWaiting = {}


addEventHandler("onPedWasted", root,
	function ()
		local spawnpoint = getElementData(source,"botSpawnCol")
		if spawnpoint then
			local respawntimer = getElementData(spawnpoint,"respawnTimer")
			if respawntimer and isTimer(respawntimer) then 
				return 
			else
				local respawnTimerToAdd	= setTimer(function() end,600000,1)
				setElementData(spawnpoint,"respawnTimer",respawnTimerToAdd)
			end
		end
	end
		)