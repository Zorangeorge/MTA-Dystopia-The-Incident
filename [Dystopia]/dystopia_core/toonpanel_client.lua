
function Draw_ToonPanel()

local screenX, screenY = guiGetScreenSize()
local name = getPlayerName(localPlayer)
local lvl = getPlayerLevel(localPlayer)
	if lvl == 1 then lvl = "Lvl 1"
		elseif lvl == 2 then lvl = "Lvl 2"
		elseif lvl == 3 then lvl = "Lvl 3"
		elseif lvl == 4 then lvl = "Lvl 4"
		elseif lvl == 5 then lvl = "Lvl 5"
		elseif lvl == 6 then lvl = "Lvl 6"
		elseif lvl == 7 then lvl = "Lvl 7"
		elseif lvl == 8 then lvl = "Lvl 8"
		elseif lvl == 9 then lvl = "Lvl 9"
		elseif lvl == 10 then lvl = "Lvl 10"
		elseif lvl == 11 then lvl = "Hero"
		elseif lvl == 12 then lvl = "Legend"
	end
ToonPanel = guiCreateWindow ( screenX/2 - 350, screenY/2 - 190, 700, 500, "", false )

local titlelabel = guiCreateLabel(500, 35, 500, 300, name..",  "..lvl, false, ToonPanel)
local tabPanel = guiCreateTabPanel ( 0, 0.1, 1, 1, true, ToonPanel ) 
local tab2 = guiCreateTab( "Character", tabPanel ) 
local tab1 = guiCreateTab( "Skills", tabPanel ) 
local tab3 = guiCreateTab( "Proficiencies", tabPanel ) 
--local tab4 = guiCreateTab( "Missions", tabPanel ) 
local abilitytitlelabel = guiCreateLabel(0.02, 0.78, 0.35, 0.22, "", true, tab1)
local abilitytxtlabel = guiCreateLabel(0.02, 0.825, 0.70, 0.45, "", true, tab1) -- four lines max

guiWindowSetSizable(ToonPanel,false)
guiSetFont ( abilitytitlelabel, ChunkfiveFont )
guiSetFont ( titlelabel, ChunkfiveFont )
guiSetFont(abilitytxtlabel,"default-bold-small")

local lives = getElementData(localPlayer,"lives")
local hp = tostring(math.round(getElementHealth(localPlayer)))
local healthlabel = guiCreateLabel(0.02, 0.06, 0.35, 0.22, "HP: "..hp.."/100", true, tab2)
guiSetFont ( healthlabel, ChunkfiveFont )
local liveslabel = guiCreateLabel(0.02, 0.13, 0.35, 0.22, "Lives: "..lives.."/3", true, tab2)
guiSetFont ( liveslabel, ChunkfiveFont )

local missionlabel = guiCreateLabel(0.02, 0.2, 0.35, 0.22, "CURRENT MISSION:", true, tab2)
abandonmissionbutton = guiCreateButton(0.02, 0.3, 0.15, 0.05, "Abandon", true, tab2)
local missiondescriptionlabel = guiCreateLabel(0.03, 0.25, 0.9, 0.1, currentMission, true, tab2)
guiBringToFront(abandonmissionbutton)
guiSetFont ( missionlabel, ChunkfiveFont )
guiSetFont ( abandonmissionbutton, "default-bold-small" )
guiSetFont ( missiondescriptionlabel, "default-bold-small" )
--local reputation = 

local levellabel
local experiencelabel
local factionlabel
local factionlogo

local fracturelabel
local bleedinglabel

local infectionlabel
local hungerlabel
local thirstlabel
local staminalabel
local weightlabel
local classlabel
local karmalabel

local playerkillslabel
local botkillslabel
local zombiekillslabel
local alivetimelabel
local bestalivetimelabel
local totalplayedtimelabel

local RESILIENT_B = guiCreateButton( 0.02, 0.06, 0.22, 0.15, "RESILIENT", true, tab1 )
local OUTDOORSMAN_B = guiCreateButton( 0.02, 0.24, 0.22, 0.15, "OUTDOORSMAN", true, tab1 )
local PREPPER_B = guiCreateButton( 0.02, 0.42, 0.22, 0.15, "PREPPER", true, tab1 )
local INFILTRATOR_B = guiCreateButton( 0.02, 0.60, 0.22, 0.15, "INFILTRATOR", true, tab1 )
guiSetFont(RESILIENT_B,ChunkfiveFontSmall)
guiSetFont(OUTDOORSMAN_B,ChunkfiveFontSmall)
guiSetFont(PREPPER_B,ChunkfiveFontSmall)
guiSetFont(INFILTRATOR_B,ChunkfiveFontSmall)

local GUNSLINGER_B = guiCreateButton( 0.26, 0.06, 0.22, 0.15, "GUNSLINGER", true, tab1 )
local BATTLE_READY_B = guiCreateButton( 0.26, 0.24, 0.22, 0.15, "BATTLE-READY", true, tab1 )
local VETERAN_B = guiCreateButton( 0.26, 0.42, 0.22, 0.15, "VETERAN", true, tab1 )
local ONE_MAN_ARMY_B = guiCreateButton( 0.26, 0.60, 0.22, 0.15, "ONE MAN ARMY", true, tab1 )
guiSetFont(GUNSLINGER_B,ChunkfiveFontSmall)
guiSetFont(BATTLE_READY_B,ChunkfiveFontSmall)
guiSetFont(VETERAN_B,ChunkfiveFontSmall)
guiSetFont(ONE_MAN_ARMY_B,ChunkfiveFontSmall)

local FIRST_AID_B = guiCreateButton( 0.52, 0.06, 0.22, 0.15, "FIRST AID", true, tab1 )
local FIELD_DOCTOR_B = guiCreateButton( 0.52, 0.24, 0.22, 0.15, "FIELD DOCTOR", true, tab1 )
local MEDIC_B = guiCreateButton( 0.52, 0.42, 0.22, 0.15, "MEDIC", true, tab1 )
local SURGEON_B = guiCreateButton( 0.52, 0.60, 0.22, 0.15, "SURGEON", true, tab1 )
guiSetFont(FIRST_AID_B,ChunkfiveFontSmall)
guiSetFont(FIELD_DOCTOR_B,ChunkfiveFontSmall)
guiSetFont(MEDIC_B,ChunkfiveFontSmall)
guiSetFont(SURGEON_B,ChunkfiveFontSmall)

local TINKERER_B = guiCreateButton( 0.76, 0.06, 0.22, 0.15, "TINKERER", true, tab1 )
local CRAFTER_B = guiCreateButton( 0.76, 0.24, 0.22, 0.15, "CRAFTER", true, tab1 )
local ENGINEER_B = guiCreateButton( 0.76, 0.42, 0.22, 0.15, "ENGINEER", true, tab1 )
local ARTISAN_B = guiCreateButton( 0.76, 0.60, 0.22, 0.15, "ARTISAN", true, tab1 )
guiSetFont(TINKERER_B,ChunkfiveFontSmall)
guiSetFont(CRAFTER_B,ChunkfiveFontSmall)
guiSetFont(ENGINEER_B,ChunkfiveFontSmall)
guiSetFont(ARTISAN_B,ChunkfiveFontSmall)

addEventHandler ( 'onClientMouseEnter', root,
	function ()
	local txt = guiGetText(source)
	if source == RESILIENT_B then if getElementData(localPlayer,"RESILIENT") == false then guiSetText(source,"RESILIENT\nClick to learn")end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 1 required)\n\n50% less hunger and thirst.\nYou can drink Dirty Water without negative effects.")
	elseif source == OUTDOORSMAN_B then if getElementData(localPlayer,"OUTDOORSMAN") == false then guiSetText(source,"OUTDOORSMAN\nClick to learn")end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 2 required)\n\nCamp fires last longer and don't emit smoke.\n50% chance to harvest more raw meat from carcasses.\nCrouch to sense creatures through obstacles.")
	elseif source == PREPPER_B then if getElementData(localPlayer,"Prepper") == false then guiSetText(source,"PREPPER\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 3 required)\n\nBury stockpiles to conceal them.\nCrouching still while wearing camouflage gear makes you harder\nto detect, but you can’t move without breaking stealth.")
	elseif source == INFILTRATOR_B then if getElementData(localPlayer,"INFILTRATOR") == false then guiSetText(source,"INFILTRATOR\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(HERO LVL required)\n\nYou can disguise as any dead NPC for a limited amount of time,\nallowing you to move freely in enemy camps.")
	elseif source == GUNSLINGER_B then if getElementData(localPlayer,"GUNSLINGER") == false then guiSetText(source,"GUNSLINGER\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 1 required)\n\nMove while in aiming stance,\nbetter lock-on range and accuracy.")
	elseif source == BATTLE_READY_B then if getElementData(localPlayer,"BATTLE-READY") == false then guiSetText(source,"BATTLE-READY\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 2 required)\n\nUse weapon gadgets, googles, parachute etc.\nMove faster while in aiming stance, superior lock-on range\nand accuracy.")
	elseif source == VETERAN_B then if getElementData(localPlayer,"VETERAN") == false then guiSetText(source,"VETERAN\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 3 required)\n\nDual wield Pistols and Uzis.\nUse Rocket Launchers, Satchel Charges, Miniguns\n+2 equipment weight.")
	elseif source == ONE_MAN_ARMY_B then if getElementData(localPlayer,"ONE MAN ARMY") == false then guiSetText(source,"ONE MAN ARMY\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(HERO LVL required)\n\nYou gain +25 HP and +500 stamina.\nYou cannot be incapacitated.\nDual wield Sawn-off shotguns.")
	elseif source == FIRST_AID_B then if getElementData(localPlayer,"FIRST AID") == false then guiSetText(source,"FIRST AID\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 1 required)\n\nEquip Medikits for permanent use\nand heal yourself and others for 10 hp.\nStop bleeding when healing others.")
	elseif source == FIELD_DOCTOR_B then if getElementData(localPlayer,"FIELD DOCTOR") == false then guiSetText(source,"FIELD DOCTOR\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 2 required)\n\nHeal 25 hp using an equipped Medikit.\nRelieve pain and mend broken bones\nwhen healing others.")
	elseif source == MEDIC_B then if getElementData(localPlayer,"MEDIC") == false then guiSetText(source,"MEDIC\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 3 required)\n\nHeal 30 hp using an equipped Medikit.\nRevive wasted players by administering Adrenaline Shot.")
	elseif source == SURGEON_B then if getElementData(localPlayer,"SURGEON") == false then guiSetText(source,"SURGEON\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(HERO LVL required)\n\nHeal 50 hp using an equipped Medikit.\nSurgically remove tracking chips.")
	elseif source == TINKERER_B then if getElementData(localPlayer,"TINKERER") == false then guiSetText(source,"TINKERER\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 1 required)\n\nCraft basic items using crafting materials from the inventory.")
	elseif source == CRAFTER_B then if getElementData(localPlayer,"CRAFTER") == false then guiSetText(source,"CRAFTER\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 2 required)\n\n50% faster vehicle repair.\nCraft complex items.")
	elseif source == ENGINEER_B then if getElementData(localPlayer,"ENGINEER") == false then guiSetText(source,"ENGINEER\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(LVL 3 required)\n\nRepair exploded vehicles.\nReinforce vehicles.")
	elseif source == ARTISAN_B then if getElementData(localPlayer,"ARTISAN") == false then guiSetText(source,"ARTISAN\nClick to learn") end guiSetText(abilitytitlelabel,txt); guiSetText(abilitytxtlabel,"(HERO LVL required)\n\nOverride systems: gates, soup machines, CCTV etc.")
	end
	end
	)

addEventHandler ( 'onClientMouseLeave', root,
	function ()
	if source == RESILIENT_B then guiSetText(source,"RESILIENT"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"")
	elseif source == OUTDOORSMAN_B then guiSetText(source,"OUTDOORSMAN"); guiSetText(abilitytitlelabel,"") ; guiSetText(abilitytxtlabel,"")
	elseif source == PREPPER_B then guiSetText(source,"PREPPER"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == INFILTRATOR_B then guiSetText(source,"INFILTRATOR"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == GUNSLINGER_B then guiSetText(source,"GUNSLINGER"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == BATTLE_READY_B then guiSetText(source,"BATTLE-READY"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == VETERAN_B then guiSetText(source,"VETERAN"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == ONE_MAN_ARMY_B then guiSetText(source,"ONE MAN ARMY"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == FIRST_AID_B then guiSetText(source,"FIRST AID"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == FIELD_DOCTOR_B then guiSetText(source,"FIELD DOCTOR"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == MEDIC_B then guiSetText(source,"MEDIC"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == SURGEON_B then guiSetText(source,"SURGEON"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == TINKERER_B then guiSetText(source,"TINKERER"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == CRAFTER_B then guiSetText(source,"CRAFTER"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == ENGINEER_B then guiSetText(source,"ENGINEER"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	elseif source == ARTISAN_B then guiSetText(source,"ARTISAN"); guiSetText(abilitytitlelabel,""); guiSetText(abilitytxtlabel,"") 
	end
	
	end
	)

addEventHandler ( 'onClientGUIClick', root, 
    function (  ) 

        if ( source == Closeb ) then 
			
		
			elseif ( source == RESILIENT_B) then
			
			elseif ( source == OUTDOORSMAN_B) then
		
			elseif ( source == PREPPER_B) then
		
			elseif ( source == INFILTRATOR_B) then
		
          	elseif ( source == GUNSLINGER_B) then
		
            elseif ( source == BATTLE_READY_B) then
		
			elseif ( source == VETERAN_B) then
		
			elseif ( source == ONE_MAN_ARMY_B) then
		
			elseif ( source == FIRST_AID_B) then
							             		
			elseif ( source == FIELD_DOCTOR_B) then
		
			elseif ( source == MEDIC_B) then
							
			elseif ( source == SURGEON_B) then
				
			elseif ( source == TINKERER_B) then
					
			elseif ( source == CRAFTER_B) then
					
			elseif ( source == ENGINEER_B) then
				
			elseif ( source == ARTISAN_B) then
			
			elseif ( source == abandonmissionbutton) then
				clearMissionData ()
				guiSetText(missiondescriptionlabel,"None")
				outputTopBar("Mission abandoned",255,100,100)

	end
	end) 
end

function open_closeToonPanel( playerSource )

if playerSource then 

	if (not ToonPanel) or ( guiGetVisible(ToonPanel) == false ) then
		Draw_ToonPanel()
		if not isCursorShowing () then 
			addEventHandler("onClientRender",root,forceShowCursor) ---ZZZZ
			showCursor(true) 
		end
	elseif guiGetVisible(ToonPanel) == true then
	removeEventHandler("onClientRender",root,forceShowCursor) --ZZZZZ
		showCursor(false)
		guiSetVisible(ToonPanel, false)
	end
end
end
addCommandHandler("Character Panel", open_closeToonPanel)
bindKey("O","down","Character Panel")