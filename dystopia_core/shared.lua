-- shared functions and config

--QUEST = exports.dystopia_quests

NPC_INTERACTION_DISTANCE = 2.5

function table.random ( theTable ) -- evrika! theTable e folosit ca "jolly" pentru orice tabel pasat cand call-ui functia. punctul zero Zoran - lua
    return theTable[math.random ( #theTable )]
end

function RGBToHex(red, green, blue, alpha)

if not red then return end
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

-- function to get player current level
function getPlayerLevel(player)
local level = tonumber(getElementData(player,"level")) or 1
return level
end

-- function to set player level
function setPlayerLevel(player,n)
if(n) and tonumber(n) then
return setElementData(player,"level",n)
else
return false
end
end

-- function to get player exp amount
function getPlayerExp(player)
local exp = tonumber(getElementData(player,"experience")) or 0
return exp
end

-- function to set player exp amount
function setPlayerExp(player,n)
if(n) and tonumber(n) then
return setElementData(player,"experience",n)
else
return false
end
end

-- function to add player exp amount
function addPlayerExp(player,n)
if(n) and tonumber(n) then
local exp = (getElementData(player,"experience")) or 0
return setElementData(player,"experience",exp+n)
else
return false
end
end

-- function to get player exp to level up, and level name
function getLevelValues(level)

	if not level then 
		level = 1 
		if source and getElementType(source) == "player" then 
		setElementData(source,"level",1,true) 
		else  
		setElementData(source,"level",1,true) 
		end
	elseif level <= 0 then 
		level = 1 
		if source and getElementType(source) == "player" then 
		setElementData(source,"level",1,true) 
		end
	end

	if(level) and tonumber(level) then
	
		local Expreq,Name 
		
		if level == 12 then 
		
			Expreq = 3000; Name = "Legend" 

		else
		
			Expreq,Name = Levels[level].Expreq, Levels[level].Name
			
		end
	
		return Expreq,Name
	
	end
end

function cutExp()
setPlayerExp(source,0) 
end
addEventHandler("onPlayerWasted",root,cutExp)

----KARMA functions (clones of manawydan's exp functions)

-- function to get player karma amount
function getPlayerKarma(player)
local karma = tonumber(getElementData(player,"karma")) or 0
return karma
end

-- function to set player karma amount
function setPlayerKarma(player,n)
if(n) and tonumber(n) then
return setElementData(player,"karma",n)
else
return false
end
end

-- function to add player karma amount
function addPlayerKarma(player,n)
if(n) and tonumber(n) then
local karma = (getElementData(player,"karma")) or 0
return setElementData(player,"karma",karma+n) -- setElementData(getPlayerFromName("Opie_Winston"),"karma",0,true)
else
return false
end
end