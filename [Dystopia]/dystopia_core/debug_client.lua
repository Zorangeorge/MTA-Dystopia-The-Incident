local checkframes=0

fps=36
hours=0
minutes=0
frames,lastsec=0,0,0
localPlayer = getLocalPlayer()

function checkInfo ()
	local frameticks=getTickCount()
	frames=frames+1
	if frameticks-1000>lastsec then
		local prog=(frameticks-lastsec)
		lastsec=frameticks
		fps=frames/(prog/1000)
		frames=fps*((prog-1000)/1000)
	end
end

local sWidth, sHeight = guiGetScreenSize() 
local Background = guiCreateStaticImage( 0, 0, sWidth , 16, "images/beltblack.png", false )
guiSetAlpha ( Background, 0.5 )
local label = guiCreateLabel(10, 0, 1000, 23,"", false)
guiSetVisible(label, false)
guiSetVisible(Background, false)

function convertNumber(number)  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

function WriteToLine ()

local ping = convertNumber((getPlayerPing(localPlayer)) or 0)
local team = getPlayerTeam(localPlayer)
local teamname
if team == false then teamname = "None" else teamname = getTeamName(team) end
local hunger = getHungerState(localPlayer)
local thirst = getThirstState(localPlayer)
local level = getPlayerLevel(localPlayer)
local expe = getPlayerExp(localPlayer)
local lives = getElementData(localPlayer,"lives")
if lives == false then setElementData(localPlayer,"lives",3,true) end
local playersonline = getElementsByType("player")
local allpeds = getElementsByType("ped")
local numbotsspawned = (#allpeds-#playersonline)
local karma = getElementData(localPlayer,"karma") or 0
local infection = getElementData(localPlayer,"infection") or " "
local mission = currentMission or "None"

--guiSetText (label,"PST: "..s_pistolammo.." | CRSBW: "..s_crossbowammo.." | TASR: "..s_taserammo.." | SMG: "..s_smgammo.." | SHTG: "..s_shotgunammo.." | ASLT: "..s_assaultammo.." | RFL: "..s_rifleammo.." | LIVEs: "..tostring(lives).." | FCTN: "..teamname.." | LVL: "..(level-1).." | EXP: "..expe.." | HNGR: "..hunger.." | THRS: "..thirst.."  | FPS: "..string.gsub(fps,"%.%d*","").." | PING: "..ping.." | PEDs: "..numbotsspawned.."")

guiSetText (label, " "..tostring(lives).." ❤ | Faction: "..teamname.." | Level: "..(level).." | XP: "..expe.." | Karma: "..karma.." | Hunger: "..hunger.." | Thirst: "..thirst.." | Infection: "..infection.." | FPS: "..string.gsub(fps,"%.%d*","").." | Ping: "..ping.." | Peds#: "..numbotsspawned.." | Mission: "..mission.." ")

end

addEventHandler ( "onClientRender", getRootElement(), checkInfo)
addEventHandler ( "onClientRender", getRootElement(), WriteToLine)

function toggledebug ()
    local Alpha = guiGetVisible(label) and guiGetVisible(Background)
    guiSetVisible(label, not Alpha)
	guiSetVisible(Background, not Alpha)
end
bindKey("F5","down",toggledebug)
bindKey("F7","down","report")