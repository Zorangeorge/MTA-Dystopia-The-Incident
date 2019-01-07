--[[
keywords:

peace
peaceg
raibot
raibotg
cdfbot
cdfbotg
scavbot
scavbotg
bandbot
bandbotg
neutbot
animal

weaploot
milloot
resloot
indloot
medloot
fuelloot


<Raider_spawn id="Raider_spawn (74)" BotType="Hunter" name="" botDialogue="" botRange="100" alpha="255" interior="0" posX="376.60001" posY="-2057.1001" posZ="10.7" rotX="0" rotY="0" rotZ="0"></Raider_spawn>


]]
local eof = nil

function saveCoords( x, y, z, rot, comment, name )
    local fhnd = nil
    if fileOpen( "saved_coords.txt" ) then
        fhnd = fileOpen( "saved_coords.txt" )
        eof = fileGetSize( fhnd )
        fileSetPos( fhnd, eof )
    else
        fhnd = fileCreate( "saved_coords.txt" )
    end
	local str
	if comment == "raibotg" then 
		str = name..'<Raider_spawn id="Raider_spawn" BotType="Guard" name="" botDialogue="" botRange="50" alpha="255" interior="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Raider_spawn>'
	elseif comment == "raibot" then
		str = name..'<Raider_spawn id="Raider_spawn" BotType="Hunter" name="" botDialogue="" botRange="50" alpha="255" interior="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Raider_spawn>'
	elseif comment == "neutbot" then
		str = name..': '..'<Neutral_spawn id="Neutral_spawn" BotType="Freelance" name="" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Neutral_spawn>'
	elseif comment == "peace" then
		str = name..': '..'<Establishment_spawn id="Establishment_spawn" BotType="PeacekePatrol" name="" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Establishment_spawn>'
	elseif comment == "peaceg" then
		str = name..': '..'<Establishment_spawn id="Establishment_spawn" BotType="Peacekeeper" name="" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Establishment_spawn>'
	elseif comment == "quest" then
		str = name..': '..'<CDF_spawn id="CDF_spawn" BotType="Quest" name="Derrik" botDialogue="derrik" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></CDF_spawn>'
	elseif comment == "bandith" then
		str = name..': '..'<Bandit_spawn id="Bandit_spawn" BotType="Hunter" name="Bandit" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Bandit_spawn>'
	elseif comment == "banditg" then
		str = name..': '..'<Bandit_spawn id="Bandit_spawn" BotType="Guard" name="Bandit" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Bandit_spawn>'
-------------------------
		elseif comment == "banditoutfit" then
		str = name..': '..'<Bandit_spawn id="Bandit_spawn" BotType="Quest" name="Outfitter" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Bandit_spawn>'

		elseif comment == "bandittrader" then
		str = name..': '..'<Bandit_spawn id="Bandit_spawn" BotType="Quest" name="Trader" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Bandit_spawn>'		
		
		elseif comment == "estabquart" then
		str = name..': '..'<Establishment_spawn id="Establishment_spawn" BotType="Quest" name="Quartermaster" botSkin="286" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Establishment_spawn>'

		elseif comment == "estabtrader" then
		str = name..': '..'<Establishment_spawn id="Establishment_spawn" BotType="Quest" name="Trader" botSkin="15" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Establishment_spawn>'		

		elseif comment == "CDFquart" then
		str = name..': '..'<CDF_spawn id="CDF_spawn" BotType="Quest" name="Quartermaster" botSkin="" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></CDF_spawn>'
		
		elseif comment == "CDFtrader" then
		str = name..': '..'<CDF_spawn id="CDF_spawn" BotType="Quest" name="Trader" botSkin="" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></CDF_spawn>'
		
		elseif comment == "scavtrader" then
		str = name..': '..'<Scavenger_spawn id="Scavenger_spawn" BotType="ScavVendor" name="Trader" botSkin="" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Scavenger_spawn>'
		
		elseif comment == "scavoutfit" then
		str = name..': '..'<Scavenger_spawn id="Scavenger_spawn" BotType="ScavQuest" name="Outfitter" botSkin="" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Scavenger_spawn>'
		
		elseif comment == "raideroutfit" then
		str = name..': '..'<Raider_spawn id="Raider_spawn" BotType="Quest" name="Outfitter" botSkin="" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Raider_spawn>'
		
		elseif comment == "raidertrader" then
		str = name..': '..'<Raider_spawn id="Raider_spawn" BotType="Quest" name="Trader" botSkin="" botDialogue="" botRange="50" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Raider_spawn>'
		
	elseif comment == "resloot1" then
		str = name..': '..'<object id="object (resloot)" breakable="true" interior="0" collisions="true" alpha="255" model="1221" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.55)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'
	elseif comment == "resloot2" then
		str = name..': '..'<object id="object (resloot)" breakable="true" interior="0" collisions="true" alpha="255" model="1220" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.6)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'
	elseif comment == "weaploot" then
		str = name..': '..'<object id="object (weaploot)" breakable="true" interior="0" collisions="true" alpha="255" model="1421" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.3)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'
	elseif comment == "milloot" then
		str = name..': '..'<object id="object (weaploot)" breakable="true" interior="0" collisions="true" alpha="255" model="2977" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-1.1)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'
	elseif comment == "medloot" then
		str = name..': '..'<object id="object (medloot)" breakable="true" interior="0" collisions="true" alpha="255" model="1558" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.43)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'
		
	elseif comment == "clothes" then
		str = name..': '..'<object id="object (clothes)" breakable="false" interior="0" collisions="true" alpha="255" model="2845" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-1)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	
	
	elseif comment == "fence" then
		str = name..': '..'<object id="object (fence)" breakable="true" interior="0" collisions="true" alpha="255" model="1447" doublesided="false" scale="1" MSTalpha="255" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'
	
	elseif comment == "stretcher" then
		str = name..': '..'<object id="object (medmisc)" breakable="true" interior="0" collisions="true" alpha="255" model="2146" doublesided="false" scale="1" MSTalpha="255" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.55)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'
	
		elseif comment == "stretcher2" then
		str = name..': '..'<object id="object (medmisc)" breakable="true" interior="0" collisions="true" alpha="255" model="1997" doublesided="false" scale="1" MSTalpha="255" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-1)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'
		
	elseif comment == "rollchair" then
		str = name..': '..'<object id="object (medmisc)" breakable="true" interior="0" collisions="true" alpha="255" model="1369" doublesided="false" scale="1" MSTalpha="255" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.4)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'
	
	elseif comment == "bodybags" then
		str = name..': '..'<object id="object (medmisc)" breakable="true" interior="0" collisions="true" alpha="255" model="16444" doublesided="false" scale="1" MSTalpha="255" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.8)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'
	
	elseif comment == "shoptrash1" then
		str = name..': '..'<object id="object (trash)" breakable="false" interior="0" collisions="true" alpha="255" model="853" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.8)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>' --broken cart	
	elseif comment == "shoptrash2" then
		str = name..': '..'<object id="object (trash)" breakable="false" interior="0" collisions="true" alpha="255" model="854" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.8)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	--trash pile
	elseif comment == "fencetrash" then
		str = name..': '..'<object id="object (trash)" breakable="false" interior="0" collisions="true" alpha="255" model="850" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.9)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	--dropped fence
	elseif comment == "shoprubbish1" then
		str = name..': '..'<object id="object (trash)" breakable="false" interior="0" collisions="true" alpha="255" model="2670" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.95)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	 --cigs and starbucks
	elseif comment == "shoprubbish2" then
		str = name..': '..'<object id="object (trash)" breakable="false" interior="0" collisions="true" alpha="255" model="2673" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.95)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	--beercans 
	elseif comment == "shoprubbish3" then
		str = name..': '..'<object id="object (trash)" breakable="false" interior="0" collisions="true" alpha="255" model="2674" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.95)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	--cigs and paper 
	elseif comment == "shoprubbish4" then
		str = name..': '..'<object id="object (trash)" breakable="false" interior="0" collisions="true" alpha="255" model="2676" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.95)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	--bags and paper 	
	elseif comment == "papers1" then
		str = name..': '..'<object id="object (trash)" breakable="false" interior="0" collisions="true" alpha="255" model="18100" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.95)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	--papers 
	elseif comment == "papers2" then
		str = name..': '..'<object id="object (trash)" breakable="false" interior="0" collisions="true" alpha="255" model="18099" doublesided="false" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.95)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	--papers 2
	elseif comment == "shopcart" then
		str = name..': '..'<object id="object (cart)" breakable="false" interior="0" collisions="true" alpha="255" model="1349" doublesided="true" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.45)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	--shopping cart
	elseif comment == "fuelloot" then
		str = name..': '..'<object id="object (cart)" breakable="false" interior="0" collisions="true" alpha="255" model="1349" doublesided="true" scale="1" dimension="0" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z-0.45)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></object>'	--shopping cart
	elseif comment == "zedw" then
		str = name..': '..'<Zombie_spawn id="Zombie_spawn" ZedType="Walker" name="" botRange="70" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Zombie_spawn>'
	elseif comment == "zedr" then
		str = name..': '..'<Zombie_spawn id="Zombie_spawn" ZedType="Runner" name="" botRange="70" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Zombie_spawn>'
	elseif comment == "zedb" then
		str = name..': '..'<Zombie_spawn id="Zombie_spawn" ZedType="Brute" name="" botRange="70" posX="'..tostring(x)..'" posY="'..tostring(y)..'" posZ="'..tostring(z)..'" rotX="0" rotY="0" rotZ="'..tostring(rot)..'"></Zombie_spawn>'
	
	
  --<Fuel_Source id="Fuel_Source (user)" FuelAmount="Low" posX="390.29999" posY="2450.8999" posZ="15.5" rotX="0" rotY="0" rotZ="0"></Fuel_Source>

	
	else
		str = name..": "..tostring( x ) .. ", " .. tostring( y ) .. ", " .. tostring( z ) .. ", " .. tostring( rot ) .. " ";
		if string.len( comment ) > 0 then
			str = str .. "// ".. comment
		end
	end
    str = str .. "\r\n"
    eof = fileWrite( fhnd, str )
    fileSetPos( fhnd, eof )
    fileClose( fhnd )
    outputChatBox( "Saved: "..comment, source )
end

function mapPos( player, command, ... )
    local _x, _y, _z = getElementPosition( player )
    local _rot = getPedRotation( player )
    local comment = table.concat( arg, " " )
    saveCoords( _x, _y, _z, _rot, comment, getPlayerName(player) )
end
addCommandHandler( "mappos", mapPos )
addCommandHandler( "/", mapPos )