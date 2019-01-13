function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function centerWindow(center_window) 
    local screenW,screenH=guiGetScreenSize() 
    local windowW,windowH=guiGetSize(center_window,false) 
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2 
    guiSetPosition(center_window,x,y,false) 
end 

 function table.contains(table, element)
  for index, value in pairs(table) do
    if value == element then
      return index
    end
  end
  return false
end

function getLocationName ()

x,y,z = getElementPosition (localPlayer)

location = getZoneName (x,y,z)

outputChatBox(location)

end
addCommandHandler ("location", getLocationName)
addCommandHandler ("/", getLocationName)

---------STARTUP----------
setTrafficLightState("disabled")  -- traffic lights off 
setInteriorSoundsEnabled (false)  -- no standard interior music 
--setTime(19,58) -- 19:59 because at 20:00 the night textures get enabled. we'll use 19:59 as the 'night' of the game, triggering the night shader
setMinuteDuration (10000)-- one game minute is 10 sec real time, one game day is 4 hours real time; should be the same with the respawn period of objects, items and vehicles; I must alter the time cycle to obtain 1 h night time for 3 hours daytime
setOcclusionsEnabled( false )

-------------OBJECTS LOD DISTANCE ADJUSTMENTS-----NEEDS SOME MO' LOD WORK!!!----------------
local LODAdjustObjectsTable = {
 3593,  --la_fuckedcar1
 3594,  --la_fuckedcar2
 874,  -- veg_procgrasspatch
 2415,  --CJ_fryer, used for camp fire smoke etc
 10828,  --boat camp outer walls
 3568,  --orange trailer
 4100,  --often used fence
 3415,  --wooden hut
 3418,  --wooden hut2
 2934,  --red container
 3565,  --grey container
 3570,  --grey container
 3571,  --grey container
 3572,  --grey container
 3425,  --windmill
 10230,  --ship hull
 10771,  --carrier deck
 10770,  --carrier twr
 11149,  --carrier corridors
 11146,  --carrier hangar
 18248,  --claw crane
 12990,  --wood deck1
 11496,  --wood deck2
 11495,  --wood deck3
 11292,  --wood deck3
 3286,  --water twr
 3252,  --water twr2
 980,  --airport gate
 3330,  --concrete bridge foot
 9907,  --SF broken build
 --1378,  --huge dock crane
 8883,  --dock container stack
 10793,  --ship 
 10795,  --ship
 3585,  --train cart
 1683,  --plane
 971,  --gate
 3866,  --broken building
 13590,  --yello buses
 16082,  --orange walkway
 13435,  --wooden logs
 3700,  --house
 17036,  --carport
 3279,  --army twr
 987,  --elec fence
 3269,  --plane crash
 3271,  --plane crash2
 3270,  --plane crash3
 16773,  --hangar door1
 16775,  --hangar door2
 3050,  --quarry fence
 13367,  --tall water twr
 12913,  --fuel drums
 13831,  --vinewood sign 1
 13722,  --vinewood sign 2
 3763,  --tall antenna
-- 4571,  --LS build
 --4550,  --LS skyscraper
 17037,  --canopy
 3359,  --wooden barn
 16370,  --fuel_fence
 1595,  --sat dish1
 3620,  --red dock crane
 3745,  --road sign large
 3256,  --large smoke tower
 3258,  --large smoke tower2
 5299,  --red reservoir
 --4832,  --LS control tower
 10985,  --dirt mound
 16317,  --dirt mound2
 12957,  --pickup wreck
 8885,  --colored container stack
 7040,  --colored container stack2
 3566,  --grey trailer
 3567,  --flat grey trailer
 3722,  --dirt container
 7102,  --colored containers
 10814,  --huge drums
 5259,  --huge crate stack1
 5269,  --huge crate stack2
 3475,  --large fence
 --11011,  --warehouse ruins ramp
 11293,  --large drums rusty 
 1267,  --billboard
 3575,  --stacked containers
 2669,  --red chris container
 3630,  --stacked cardboard boxes
 1681,  --lear jet
 3574,  --containers
 2932,  --blue container
 2935,  --yellow container 
 3573,  --containers 
 --10357,  --large antena missionary
 2933,  --gate
 3199,  --ship bits carrier
 9901,  --ferry build
 12990,  --wood jetty
 9623,  --road checkpoint
 --354,  --flare
 --4336,  --seabottom dune obj
 --8489,  --LV hotel
 8882,  --LV excal hotel
 9132,  --LV chinese casino
 --8464,  --LV crater
 --8390,  --LV parking
 8538,  --LV tiki
 --8392,  --LV hotel
 8493,  --LV pirate ship
 --8421,  --LV pirate hotel
 --7584,  --LV visage
 --6994,  --LV clown
 --16258,  --LV dunes 
 --1383,  --LV cranes 
 --1388,  --LV cranes 
 --1391,  --LV cranes 
 925,  --rack2 
 931,  --rack3 
-- 8464,  --crater1 
 --8464,  --crater2 
 --8464  --crater3 
 3114, --carrier elevator
 3406, --scaffolds
 9767,
 3498,
}

function checkagainsttable(objtocheck,thetable)
	for _,objid in pairs(thetable) do
		if objid == objtocheck then
			return true
			--break
		end
	end	
	return false
end

for _,objID in ipairs (LODAdjustObjectsTable) do
--local lowLOD = getLowLODElement(objID)
--if lowLOD then setLowLODElement(objID,lowLOD) else setLowLODElement(objID,objID) end
engineSetModelLODDistance(objID,500)
end

engineSetModelLODDistance(9584,850) --freighter LS
engineSetModelLODDistance(9585,850)
engineSetModelLODDistance(9586,850)
engineSetModelLODDistance(9958,850)
engineSetModelLODDistance(8464, 850) --crater1
engineSetModelLODDistance(8392, 850) --LV hotel
engineSetModelLODDistance(8390, 850) --LV parking
engineSetModelLODDistance(7584, 850) --LV visage
engineSetModelLODDistance(8421, 850) --LV pirate hotel
engineSetModelLODDistance(4336, 850) ----seabottom dune obj
engineSetModelLODDistance(8489, 850) ------LV hotel
engineSetModelLODDistance(10357, 850) --large antena missionary
engineSetModelLODDistance(354, 850) --flare
engineSetModelLODDistance(16258, 850) --LV dunes
engineSetModelLODDistance(6994, 850) --LV clown
engineSetModelLODDistance(1383, 850) --LV cranes
engineSetModelLODDistance(1388, 850) --LV cranes
engineSetModelLODDistance(1391, 850) --LV cranes
engineSetModelLODDistance(3887, 850) --ruins SF
engineSetModelLODDistance(3866, 850) --ruins SF2
engineSetModelLODDistance(11011, 850) ----warehouse ruins ramp
engineSetModelLODDistance(4550, 850) ----LS skyscrap
engineSetModelLODDistance(4571, 850) ----LS build
engineSetModelLODDistance(4832, 850) ----LS contr tower
engineSetModelLODDistance(3814, 850) ----SF hangars
engineSetModelLODDistance(10847, 850) ----SF ctrl1
engineSetModelLODDistance(10844, 850) ----SF ctrl2
engineSetModelLODDistance(11244, 850) ----SF ctrl3
engineSetModelLODDistance(1378, 850) ---- dock huge crane
engineSetModelLODDistance(16656, 850) ---- depot bunker (A51 rocket lab)


--[[engineSetModelLODDistance(3593,300) --la_fuckedcar1
engineSetModelLODDistance(3594,300) --la_fuckedcar2
engineSetModelLODDistance(874,300) -- veg_procgrasspatch
engineSetModelLODDistance(2415,300) --CJ_fryer, used for camp fire smoke etc
engineSetModelLODDistance(10828,300) --boat camp outer walls
engineSetModelLODDistance(3568,300) --orange trailer
engineSetModelLODDistance(4100,300) --often used fence
engineSetModelLODDistance(3415,300) --wooden hut
engineSetModelLODDistance(3418,300) --wooden hut2
engineSetModelLODDistance(2934,300) --red container
engineSetModelLODDistance(3565,300) --grey container
engineSetModelLODDistance(3570,300) --grey container
engineSetModelLODDistance(3571,300) --grey container
engineSetModelLODDistance(3572,300) --grey container
engineSetModelLODDistance(3425,300) --windmill
engineSetModelLODDistance(10230,300) --ship hull
engineSetModelLODDistance(10771,300) --carrier deck
engineSetModelLODDistance(10770,300) --carrier twr
engineSetModelLODDistance(11149,300) --carrier corridors
engineSetModelLODDistance(11146,300) --carrier hangar
engineSetModelLODDistance(18248,300) --claw crane
engineSetModelLODDistance(12990,300) --wood deck1
engineSetModelLODDistance(11496,300) --wood deck2
engineSetModelLODDistance(11495,300) --wood deck3
engineSetModelLODDistance(11292,300) --wood deck3
engineSetModelLODDistance(3286,300) --water twr
engineSetModelLODDistance(3252,300) --water twr2
engineSetModelLODDistance(980,300) --airport gate
engineSetModelLODDistance(3330,300) --concrete bridge foot
engineSetModelLODDistance(9907,300) --SF broken build
engineSetModelLODDistance(1378,300) --huge dock crane
engineSetModelLODDistance(8883,300) --dock container stack
engineSetModelLODDistance(10793,300) --ship 
engineSetModelLODDistance(10795,300) --ship
engineSetModelLODDistance(3585,300) --train cart
engineSetModelLODDistance(1683,300) --plane
engineSetModelLODDistance(971,300) --gate
engineSetModelLODDistance(3866,300) --broken building
engineSetModelLODDistance(13590,300) --yello buses
engineSetModelLODDistance(16082,300) --orange walkway
engineSetModelLODDistance(13435,300) --wooden logs
engineSetModelLODDistance(3700,300) --house
engineSetModelLODDistance(17036,300) --carport
engineSetModelLODDistance(3279,300) --army twr
engineSetModelLODDistance(987,300) --elec fence
engineSetModelLODDistance(3269,300) --plane crash
engineSetModelLODDistance(3271,300) --plane crash2
engineSetModelLODDistance(3270,300) --plane crash3
engineSetModelLODDistance(16773,300) --hangar door1
engineSetModelLODDistance(16775,300) --hangar door2
engineSetModelLODDistance(3050,300) --quarry fence
engineSetModelLODDistance(13367,300) --tall water twr
engineSetModelLODDistance(12913,300) --fuel drums
engineSetModelLODDistance(13831,300) --vinewood sign 1
engineSetModelLODDistance(13722,300) --vinewood sign 2
engineSetModelLODDistance(3763,300) --tall antenna
engineSetModelLODDistance(4571,300) --LS build
engineSetModelLODDistance(4550,300) --LS skyscraper
engineSetModelLODDistance(17037,300) --canopy
engineSetModelLODDistance(3359,300) --wooden barn
engineSetModelLODDistance(16370,300) --fuel_fence
engineSetModelLODDistance(1595,300) --sat dish1
engineSetModelLODDistance(3620,300) --red dock crane
engineSetModelLODDistance(3745,300) --road sign large
engineSetModelLODDistance(3256,300) --large smoke tower
engineSetModelLODDistance(3258,300) --large smoke tower2
engineSetModelLODDistance(5299,300) --red reservoir
engineSetModelLODDistance(4832,300) --LS control tower
engineSetModelLODDistance(10985,300) --dirt mound
engineSetModelLODDistance(16317,300) --dirt mound2
engineSetModelLODDistance(12957,300) --pickup wreck
engineSetModelLODDistance(8885,300) --colored container stack
engineSetModelLODDistance(7040,300) --colored container stack2
engineSetModelLODDistance(3566,300) --grey trailer
engineSetModelLODDistance(3567,300) --flat grey trailer
engineSetModelLODDistance(3722,300) --dirt container
engineSetModelLODDistance(7102,300) --colored containers
engineSetModelLODDistance(10814,300) --huge drums
engineSetModelLODDistance(5259,300) --huge crate stack1
engineSetModelLODDistance(5269,300) --huge crate stack2
engineSetModelLODDistance(3475,300) --large fence
engineSetModelLODDistance(11011,300) --warehouse ruins ramp
engineSetModelLODDistance(11293,300) --large drums rusty 
engineSetModelLODDistance(1267,300) --billboard
engineSetModelLODDistance(3575,300) --stacked containers
engineSetModelLODDistance(2669,300) --red chris container
engineSetModelLODDistance(3630,300) --stacked cardboard boxes
engineSetModelLODDistance(1681,300) --lear jet
engineSetModelLODDistance(3574,300) --containers
engineSetModelLODDistance(2932,300) --blue container
engineSetModelLODDistance(2935,300) --yellow container 
engineSetModelLODDistance(3573,300) --containers 
engineSetModelLODDistance(10357,300) --large antena missionary
engineSetModelLODDistance(2933,300) --gate
engineSetModelLODDistance(3199,300) --ship bits carrier
engineSetModelLODDistance(9901,300) --ferry build
engineSetModelLODDistance(12990,300) --wood jetty
engineSetModelLODDistance(9623,300) --road checkpoint
engineSetModelLODDistance(354,300) --flare
engineSetModelLODDistance(4336,300) --seabottom dune obj
engineSetModelLODDistance(8489,300) --LV hotel
engineSetModelLODDistance(8882,300) --LV excal hotel
engineSetModelLODDistance(9132,300) --LV chinese casino
engineSetModelLODDistance(8464,300) --LV crater
engineSetModelLODDistance(8390,300) --LV parking
engineSetModelLODDistance(8538,300) --LV tiki
engineSetModelLODDistance(8392,300) --LV hotel
engineSetModelLODDistance(8493,300) --LV pirate ship
engineSetModelLODDistance(8421,300) --LV pirate hotel
engineSetModelLODDistance(7584,300) --LV visage
engineSetModelLODDistance(6994,300) --LV clown
engineSetModelLODDistance(16258,300) --LV dunes 
engineSetModelLODDistance(1383,300) --LV cranes 
engineSetModelLODDistance(1388,300) --LV cranes 
engineSetModelLODDistance(1391,300) --LV cranes ]]
------------------------------------------------------------------]]

bridgesf = getElementByID("object (baybridge4_SFSe) (1)") -- create LOD for broken SF bridge
if bridgesf then
x,y,z = getElementPosition(bridgesf)
rx,ry,rz = getElementRotation(bridgesf)
bridgesf_lowlod = createObject ( 11248, x,y,z,rx,ry,rz,true )
engineSetModelLODDistance(10823,300) --SF broken bridge
engineSetModelLODDistance(11248,300) --SF broken bridge lod
setLowLODElement(bridgesf,bridgesf_lowlod)
end
-------REMOVE THE night lights & other stuff from deleted buildings ------------ looks like the list is incomplete, in SF there are still some building lights at night, maybe in more areas, haven't checked all 
local objtoremove = {9934,9933,9932,9886,6196,6195,6194,6193,6192,5059,5058,5057,4222,4221,4220,4219,4218,4217,
4216,4215,4214,4213,4212,13493,13485,13484,13461,10147,10146,10058,10057,4715,4716,4717,4720,4721,4722,4723,4725,4739,
4740,4741,4742,4743,4744,4745,4746,4747,4748,4749,4750,4751,4752,5661,5662,5665,5990,5991,5992,
7206,7207,7208,7221,7222,7280,7333,9088,9089,9125,9154,9277,9278,9279,9280,9281,9282,9283,9885,
 8502,9159,7233,8981,14628,3437,8371,8370,17957,17956,17955,17954,9129,9128,9127,9126,
9124,9123,9122,9121,8372,7944,7943,7942,7892,7332,7331,7226,7097,14561,14811,7268,9094,9095,11412,11411,11410,11324,14605,
14473,14470,14460,14406,7290,7314,7289,7266,7264,7220,7072,8395,9104,9175,8982,7666,7230,9100,9101,8840,7232}

for _,obj in ipairs (objtoremove) do
removeWorldModel (obj, 10000, 0, 0, 0)
end
--[[removeWorldModel (9094, 10000, 0, 0, 0) -- the caligula's night lights; they seem to ignore anything I try, just like 9100 and 9101 (the pyramid tip)
removeWorldModel (9095, 10000, 0, 0, 0)]]

------MAP FIXES
-- CJ's Girlfriends home doors
createObject(1498, 2401.7580566406, -1714.5281982422, 13.1328125, 0, 0, 0) -- Denise (LS)
createObject(1498, 2036.5100097656, 2721.3891601563, 10.542951583862, 0, 0, 0) -- Milene (LV)
createObject(1498, -1390.7679443359, 2639.2072753906, 54.984375, 0, 0, 0) -- Barbara (SF/LV)
createObject(1505, -2574.5246582031, 1152.9309082031, 54.7265625, 0, 0, 341) -- Katie (SF)
createObject(1500, -1800.7263183594, 1201.0072021484, 24.119396209717, 0, 0, 0) -- Michelle (SF)
createObject(1498, -383.46957397461, -1439.6595458984, 25.307767868042, 0, 0, 90) -- Helena (Filint Country o.O) :D
-- Big Smokes crack palace entrance
createObject(17946, 2533.8, -1290.54, 36.94, 0, 0, 0)
-- In case you just want the crack palace blocked off, which I doubt
--createObject(3059, 2521.998046875, -1272.9383544922, 35.608306884766, 0, 0, 0)
--createObject(3059, 2521.9987792969, -1272.9284667969, 35.608306884766, 0, 0, 0)
-- Idlewood
createObject(3095, 2007.85, -1591, 16.1, 0, 0, 45)
createObject(3095, 1998.71, -1590.8, 16.103, 0, 0, 45)
createObject(3095, 1994.5, -1586.6, 16.1, 0, 0, 44.995)
createObject(2932, 2017.3, -1593.7, 17.56, 0, 0, 45)
createObject(3095, 1968.4, -1556.7, 16.1, 0, 0, 45)
createObject(3095, 1955, -1557, 16.1, 0, 0, 44.995)
createObject(3095, 1941.5, -1557.5, 16.1, 0, 0, 44.995)
createObject(3095, 1938.1, -1554.1, 16.11, 0, 0, 44.995)
createObject(3095, 1977.9, -1614.4, 19.4, 0, 0, 0)
createObject(3095, 1966.6, -1614.4, 19.4, 0, 0, 0)
createObject(3095, 1972.2, -1614.4, 19.41, 0, 0, 0)
createObject(3095, 1968.2, -1585.7, 16.11, 0, 0, 44.995)
createObject(3095, 1959.9, -1589, 16.1, 0, 0, 44.995)
createObject(3095, 1951.2, -1580.3, 16.1, 0, 0, 44.995)
createObject(3095, 1955.8, -1584.9, 16.11, 0, 0, 44.995)
-- LS
createObject(2932, 396.10001, -2058.5, 11.3, 0, 0, 0)
createObject(2932, 397.29999, -2058.5, 11.3, 0, 0, 0)
-- LV Balcony drop exploit
createObject(2932, 2506.5, 1146.4, 19.2, 0, 0, 90)
createObject(2932, 2514.2, 1151.1, 19.2, 0, 0, 0)
createObject(2932, 2512.3, 1146.3, 19.2, 0, 0, 90)
-- LV Casino
createObject(3095, 2491.6001, 2167.7, 13.4, 0, 0, 0)
createObject(3095, 2474.6001, 2167.6001, 13.4, 0, 0, 0)
createObject(3095, 2449.8, 2167.7, 13.4, 0, 0, 0)
createObject(3095, 2441.1001, 2167.8, 13.4, 0, 0, 0)
createObject(3095, 2416.1001, 2167.7, 13.4, 0, 0, 0)
createObject(3095, 2399.3, 2167.7, 13.4, 0, 0, 0)
-- LV
createObject(3095, 1897.9, 2234.3, 14.1, 0, 0, 0)
createObject(3095, 1888.9, 2234.3, 14.1, 0, 0, 0)
createObject(3095, 1879.9, 2234.3, 14.1, 0, 0, 0)
createObject(3095, 1870.9, 2234.3, 14.1, 0, 0, 0)
createObject(3095, 1861.9, 2234.3, 14.1, 0, 0, 0)
createObject(3095, 1854.2, 2234.3, 14.1, 0, 0, 0)
createObject(3095, 1845.8, 2223.7, 14.1, 0, 0, 0)
createObject(3095, 1845.8, 2214.7, 14.1, 0, 0, 0)
createObject(3095, 1845.8, 2205.7, 14.1, 0, 0, 0)
createObject(3095, 1845.8, 2200, 14.1, 0, 0, 0)
createObject(3095, 1854.2, 2191.6001, 14.1, 0, 0, 0)
createObject(3095, 1863.2, 2191.6001, 14.1, 0, 0, 0)
createObject(3095, 1872.2, 2191.6001, 14.1, 0, 0, 0)
createObject(3095, 1881.2, 2191.6001, 14.1, 0, 0, 0)
createObject(3095, 1890.2, 2191.6001, 14.1, 0, 0, 0)
createObject(3095, 1897.9, 2191.6001, 14.1, 0, 0, 0)
createObject(3095, 1906.3, 2200.1001, 14.1, 0, 0, 0)
createObject(3095, 1906.3, 2209.1001, 14.1, 0, 0, 0)
createObject(3095, 1906.3, 2218.1001, 14.1, 0, 0, 0)
createObject(3095, 1906.3, 2223.8, 14.1, 0, 0, 0)
-- LV Pink Wall
createObject(3095, 1726.5, 2122.8, 11.3, 90, 0, 0)
-- LV Window
createObject(2932, 1275.2, 2532.0, 15.7, 90, 0, 38)
createObject(2932, 1276.1, 2529.6, 15.7, 90, 0, 90)
createObject(2932, 1275.1, 2527.0, 15.7, 90, 0, 322)
-- SF
createObject(3095, -2557.7, 991.20001, 78.9, 90, 0, 0)
createObject(3095, -2557.6001, 986.79999, 78.9, 90, 0, 0)

addEvent("onServerCallsClientFunction", true)
function callClientFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEventHandler("onServerCallsClientFunction", resourceRoot, callClientFunction)

function toggleCursorForPlayer()
if not isCursorShowing() then 
addEventHandler("onClientRender",root,forceShowCursor) ---ZZZZ
else 
removeEventHandler("onClientRender",root,forceShowCursor) --ZZZZZ
end
end
addCommandHandler("Toggle cursor",toggleCursorForPlayer)		
--bindKey ("/", "down", "Toggle cursor")                        -- binds "/" key to toggle cursor state

function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end
--[[-- Get the position of a point 3 units to the right of the element:
x,y,z = getPositionFromElementOffset(element,3,0,0)

-- Get the position of a point 2 units in front of the element:
x,y,z = getPositionFromElementOffset(element,0,2,0)

-- Get the position of a point 1 unit above the element:
x,y,z = getPositionFromElementOffset(element,0,0,1)]]

-----------------Breakable obj sync
function onClientBreak(attacker)
		if not getElementData(getRootElement(),"breakableObjectSyncTrustAttacker") then
		cancelEvent()
		end
	if isElement(attacker) and (attacker == getLocalPlayer() or isElementSyncer(attacker) or (getElementType(attacker) == "vehicle" and getVehicleController(attacker) == getLocalPlayer())) then -- for some reason the driver is not known as the syncer client side
		triggerServerEvent("objSBreak",getLocalPlayer(),source)
		
		if attacker == localPlayer then
		local xp = getPlayerExp(localPlayer) -- give xp for the obj break: careful here, needs testing; might give xp to all players streamed in; confirmed, it does give xp for all breakable objects that break in streaming range for any reason; should be fixed now, needs testing
			
			if checkagainsttable(getElementModel(source),lowXpObj) then
				local mydice = math.random(1,30)
					if mydice == 10 then
					setTimer(setPlayerExp,1000,1,localPlayer,xp+1)
					outputStatusInfo("+1 xp", 240,240,240 )
					end
			else
					setTimer(setPlayerExp,1000,1,localPlayer,xp+1)
					outputStatusInfo("+1 xp", 240,240,240 )
			end
		
		end

	else
		cancelEvent()
	end
end
addEventHandler("onClientObjectBreak",getRootElement(),onClientBreak)

addEvent("objCBreak",true)
addEventHandler("objCBreak",getRootElement(),
function (obj)
	removeEventHandler("onClientObjectBreak",getRootElement(),onClientBreak)
	breakObject(obj)
	addEventHandler("onClientObjectBreak",getRootElement(),onClientBreak)
end)

addEvent("onClientObjectRespawn",true)
addEventHandler("onClientObjectRespawn",getRootElement(),
function (triggeredByScript)
	if not wasEventCancelled() then
		respawnObject(source)
	end
end)

--[[addEventHandler("onClientExplosion",getRootElement(),
function (x,y,z,type)
	if type == 9 and getElementData(source,"objBroken") then
		cancelEvent()
	end
end)]]

addEventHandler("onClientElementStreamIn",getRootElement(),
function ()
	if getElementType(source) == "object" then
		if getElementData(source,"objBroken") then
			removeEventHandler("onClientObjectBreak",getRootElement(),onClientBreak)
			breakObject(source)
			addEventHandler("onClientObjectBreak",getRootElement(),onClientBreak)
		end
	end
end)

---------SHADER DEAD STREETS by Bluethefurry
--[[texShader = dxCreateShader ( "shaders/texreplace.fx" )
shad_exp = dxCreateTexture("shaders/shad_exp.png")
dxSetShaderValue(texShader,"gTexture",shad_exp)
engineApplyShaderToWorldTexture(texShader,"shad_exp")
texShader2 = dxCreateShader ( "shaders/texreplace.fx" )
coronastar = dxCreateTexture("shaders/coronastar.png")
dxSetShaderValue(texShader2,"gTexture",coronastar)
engineApplyShaderToWorldTexture(texShader2,"coronastar")]]

function toggleShaders(case,toggle)

	if toggle == "on" then
		texShader = dxCreateShader ( "shaders/texreplace.fx" )
		shad_exp = dxCreateTexture("shaders/shad_exp.png")
		dxSetShaderValue(texShader,"gTexture",shad_exp)
		engineApplyShaderToWorldTexture(texShader,"shad_exp")
		texShader2 = dxCreateShader ( "shaders/texreplace.fx" )
		coronastar = dxCreateTexture("shaders/coronastar.png")
		dxSetShaderValue(texShader2,"gTexture",coronastar)
		engineApplyShaderToWorldTexture(texShader2,"coronastar")
		--checkVersionAndCreateOldFilmShader()
	elseif toggle == "off" then
		destroyElement(texShader)
		destroyElement(shad_exp)
		destroyElement(texShader2)
		destroyElement(coronastar)
		
		destroyElement(oldFilmShader)
		
	else
		outputChatBox("Shader toggle syntax: /deadstreets [on/off]")
	end

end
addCommandHandler("shaders",toggleShaders)

function toggleShadersOnAtStart()
		
		texShader = dxCreateShader ( "shaders/texreplace.fx" )
		shad_exp = dxCreateTexture("shaders/shad_exp.png")
		dxSetShaderValue(texShader,"gTexture",shad_exp)
		engineApplyShaderToWorldTexture(texShader,"shad_exp")
		texShader2 = dxCreateShader ( "shaders/texreplace.fx" )
		coronastar = dxCreateTexture("shaders/coronastar.png")
		dxSetShaderValue(texShader2,"gTexture",coronastar)
		engineApplyShaderToWorldTexture(texShader2,"coronastar")
		--checkVersionAndCreateOldFilmShader()
		
end
toggleShadersOnAtStart()

--SYNCHRONIZE TIME-------------------------------------
addEvent("SyncTime",true)
function syncMyTime (serverhour, serverminutes)
setTime(serverhour, serverminutes)
--outputDebugString("Time synchronized with server: "..serverhour..":"..serverminutes.."")
end
addEventHandler ( "SyncTime", resourceRoot, syncMyTime )

--[[--- GLUE to vehicle
-- Player to Vehicle
-- Original Script
function glue()
	local player = getLocalPlayer()
	if not getPedOccupiedVehicle(player) then
		local vehicle = getPedContactElement(player)
		
			if not (vehicle) or getElementType(vehicle) == false or getElementType(vehicle) ~= "vehicle" or getElementType(vehicle) == nil then return	end
		
			if getElementType(vehicle) == "vehicle" then
				
				local px, py, pz = getElementPosition(player)
				local vx, vy, vz = getElementPosition(vehicle)
				local sx = px - vx
				local sy = py - vy
				local sz = pz - vz
				
				local rotpX = 0
				local rotpY = 0
				local rotpZ = getPedRotation(player)
				
				local rotvX,rotvY,rotvZ = getElementRotation(vehicle)
				
				local t = math.rad(rotvX)
				local p = math.rad(rotvY)
				local f = math.rad(rotvZ)
				
				local ct = math.cos(t)
				local st = math.sin(t)
				local cp = math.cos(p)
				local sp = math.sin(p)
				local cf = math.cos(f)
				local sf = math.sin(f)
				
				local z = ct*cp*sz + (sf*st*cp + cf*sp)*sx + (-cf*st*cp + sf*sp)*sy
				local x = -ct*sp*sz + (-sf*st*sp + cf*cp)*sx + (cf*st*sp + sf*cp)*sy
				local y = st*sz - sf*ct*sx + cf*ct*sy
				
				local rotX = rotpX - rotvX
				local rotY = rotpY - rotvY
				local rotZ = rotpZ - rotvZ
				
				local slot = getPedWeaponSlot(player)

				triggerServerEvent("gluePlayer", player, slot, vehicle, x, y, z, rotX, rotY, rotZ)
				
				unbindKey("crouch","down",glue)
				bindKey("crouch","down",unglue)
				bindKey("jump","down",unglue)
			elseif getElementType(vehicle) == "vehicle" then
				local object = vehicle
				local px, py, pz = getElementPosition(player)
				local vx, vy, vz = getElementPosition(object)
				local sx = px - vx
				local sy = py - vy
				local sz = pz - vz
				
				local rotpX = 0
				local rotpY = 0
				local rotpZ = getPedRotation(player)
				
				local rotvX,rotvY,rotvZ = getElementRotation(object)
				
				local t = math.rad(rotvX)
				local p = math.rad(rotvY)
				local f = math.rad(rotvZ)
				
				local ct = math.cos(t)
				local st = math.sin(t)
				local cp = math.cos(p)
				local sp = math.sin(p)
				local cf = math.cos(f)
				local sf = math.sin(f)
				
				local z = ct*cp*sz + (sf*st*cp + cf*sp)*sx + (-cf*st*cp + sf*sp)*sy
				local x = -ct*sp*sz + (-sf*st*sp + cf*cp)*sx + (cf*st*sp + sf*cp)*sy
				local y = st*sz - sf*ct*sx + cf*ct*sy
				
				local rotX = rotpX - rotvX
				local rotY = rotpY - rotvY
				local rotZ = rotpZ - rotvZ
				
				local slot = getPedWeaponSlot(player)

				triggerServerEvent("gluePlayer", player, slot, vehicle, x, y, z, rotX, rotY, rotZ)
				
				unbindKey("crouch","down",glue)
				bindKey("crouch","down",unglue)
				bindKey("jump","down",unglue)			
		
			end
		end
	end
addCommandHandler("glue",glue)

function unglue ()
	local player = getLocalPlayer()
	triggerServerEvent("ungluePlayer", player)
	unbindKey("jump","down",unglue)
	unbindKey("crouch","down",unglue)
	bindKey("crouch","down",glue)
end
addCommandHandler("unglue",unglue)
bindKey("crouch","down",glue)

-- Vehicle to Vehicle // Auto con Auto
function gluev()
	-- viendo si funciona
	local outString
	local thePlayer = getLocalPlayer()
	local myVehicle = getPedOccupiedVehicle(thePlayer)
	if myVehicle then
		local attachMe, attachedTo
		local vehicles = getElementsByType("vehicle")
		local closest, cdist = nil, 100
		local mx,my,mz = getElementPosition(myVehicle)
		for k,v in ipairs(vehicles) do
			if isElementStreamedIn(v) and v ~= myVehicle then
				local x,y,z = getElementPosition(v)
				local tmpdist = getDistanceBetweenPoints3D(x,y,z,mx,my,mz)
				if tmpdist < cdist then
					cdist = tmpdist
					closest = v
				end
			end
		end -- final de los autos
		-- distancia minima
		if cdist > 5 or cdist == nil then
			return false
		end
		-- comprobando si esta en helicoptero
		local vtype = getElementModel(myVehicle)
		if vtype == (487 or 548 or 425 or 417 or 488 or 497 or 563 or 447 or 469) then
			attachMe = closest
			attachedTo = myVehicle
		else -- si no esta
			attachMe = myVehicle
			attachedTo = closest
		end	-- fin comprobacion
		
		local px, py, pz = getElementPosition(attachedTo)
		local vx, vy, vz = getElementPosition(attachMe)
		local sx = px - vx
		local sy = py - vy
		local sz = pz - vz
		
		local rotpX, rotpY, rotpZ = getElementRotation(attachedTo)
		local rotvX, rotvY, rotvZ = getElementRotation(attachMe)
		
		local t = math.rad(rotvX)
		local p = math.rad(rotvY)
		local f = math.rad(rotvZ)
		
		local ct = math.cos(t)
		local st = math.sin(t)
		local cp = math.cos(p)
		local sp = math.sin(p)
		local cf = math.cos(f)
		local sf = math.sin(f)
		
		local z = ct*cp*sz + (sf*st*cp + cf*sp)*sx + (-cf*st*cp + sf*sp)*sy
		local x = -ct*sp*sz + (-sf*st*sp + cf*cp)*sx + (cf*st*sp + sf*cp)*sy
		local y = st*sz - sf*ct*sx + cf*ct*sy
		
		local rotX = rotpX - rotvX
		local rotY = rotpY - rotvY
		local rotZ = rotpZ - rotvZ		
			
		triggerServerEvent("glueVehicle", attachMe, attachedTo, x*-1, y*-1, z*-1, rotX, rotY, rotZ)
		outputInteractInfo("Vehicle safely loaded",255,200,0)
		unbindKey("crouch","down",gluev)
		bindKey("crouch","down",ungluev)
	
	else -- else no myvehicle
	end -- end if myvehicle
	
end
addCommandHandler("gluev",gluev)

function ungluev ()
	local player = getLocalPlayer()
	local myVehicle = getPedOccupiedVehicle(player)
	local vtype = getElementModel(myVehicle)
	if vtype == (487 or 548 or 425 or 417 or 488 or 497 or 563 or 447 or 469) then
		local attached = getAttachedElements(myVehicle)
		for k,v in ipairs(attached) do
			if getElementType(v) == "vehicle" then
				myVehicle = v
			end
		end
	end
	triggerServerEvent("unglueVehicle", myVehicle)
	unbindKey("jump","down",ungluev)
	unbindKey("crouch","down",ungluev)
	bindKey("crouch","down",gluev)
end
addCommandHandler("unglue",ungluev)
bindKey("crouch","down",gluev)

]]
--- PLAYER HEAD MOVING
addEventHandler("onClientRender", getRootElement(), function()
for k,player in ipairs(getElementsByType("player")) do
if getElementHealth(player) >= 1 then
local width, height = guiGetScreenSize ()
local lx, ly, lz = getWorldFromScreenPosition ( width/2, height/2, 10 )
setPedLookAt(player, lx, ly, lz)
end 
end
end)

function dumptable(o) --returns table contents as string (what does table.unpack do actually? the same? go'n'read about it)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dumptable(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, _)
			setRadioChannel (0)
			--outputDebugString("veh entered...")	
			if getVehicleName(source)== "RC Baron" --[[getElementModel(source) == 464]] then 
			--outputDebugString("...veh is an "..getVehicleName(source))	
			--setVehicleEngineState(source,true) 
			setVehicleEngineState(source,false) 
			--outputDebugString("veh engine stopped")	
			setElementData(thePlayer,"mountedgun",source,true)
			--outputDebugString("elemdata added")	
				if getElementAttachedTo(source) then 
				local vehicle = getElementAttachedTo(source)
					if getElementType(vehicle) == "vehicle" then
						setElementCollidableWith(source,vehicle,false)
						setElementCollidableWith(vehicle,source,false)
						outputDebugString("collisions disabled")
					end
				end
			end
	end)
	
addEventHandler("onClientVehicleExit", getRootElement(),
    function(thePlayer, _)
			--setRadioChannel (0)
			if getVehicleName(source)== "RC Baron" --[[getElementModel(source) == 464]] then 
			setVehicleEngineState(source,false) 
			setElementData(thePlayer,"mountedgun",false,true)
			outputDebugString("elemdata removed")
			end
	end)