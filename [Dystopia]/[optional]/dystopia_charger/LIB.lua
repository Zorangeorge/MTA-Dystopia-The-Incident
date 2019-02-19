-- // LIB

local tablaAlmacenamiento = { } 
  
function setData( element, dataName, value ) 
    if not tablaAlmacenamiento[element] then 
        tablaAlmacenamiento[element] = { } 
    end 
  
    if not tablaAlmacenamiento[element][dataName] then 
        tablaAlmacenamiento[element][dataName] = value 
        return true 
    else 
        tablaAlmacenamiento[element][dataName] = value 
        return true 
    end 
  
    return false 
end 
  
function getData( element, dataName ) 
    if tablaAlmacenamiento[element] and tablaAlmacenamiento[element][dataName] then 
  
        return tablaAlmacenamiento[element][dataName] 
    end 
  
    return false 
end 
  
function clearTheElementData( element ) 
    if tablaAlmacenamiento[element] then 
        tablaAlmacenamiento[element] = false 
        tablaAlmacenamiento[element] = { } 
    end 
end

local elements =  { 
    "player", 
    "ped", 
    "water", 
    "sound", 
    "vehicle", 
    "object", 
    "pickup", 
    "marker", 
    "colshape", 
    "blip", 
    "radararea", 
    "team", 
    "spawnpoint", 
    "projectile", 
    "effect", 
    "light", 
    "searchlight", 
    "shader", 
    "texture", 
} 
  
function onStop( resource ) 
    for _, element in ipairs( elements ) do 
  
        for _, object in ipairs( getElementsByType ( element, getResourceRootElement( resource ) ) ) do 
            clearTheElementData ( object ) 
        end 
  
    end 
end 
addEventHandler( "onResourceStop", getRootElement(  ), onStop )

local function tableCount(t)

	local c = 0

	for k,v in pairs(t) do
		c=c+1
	end
	
	return c

end

-- GET NEAREST PLAYER FUNC 


function getNearestPlayer(zombie, zone, checkZ)

    if not zombie then return false end
    if not isElement(zombie) then return false end

        local players = getElementsWithinColShape( zone, "player" )
        local shortestDistance = 10000
        local shortestPlayer = false
        local shortestDistance2 = 10000
        local allShortestPlayer = false
        for index,player in ipairs(players) do
            if isPedDead( player ) == false then 
                local distance = getDistanceBetweenPoints3D(zombie.position,player.position)
                if distance < shortestDistance then
                    local playerOnGround = true
                    if checkZ then
                        playerOnGround = (player.position.z > 127 and player.position.z < 131)
                    end
                    if playerOnGround then
                        shortestDistance = distance
                        shortestPlayer = player
                    end
                end
            end
            
        end
    
    
    return shortestPlayer, shortestDistance

end

function getNearestVehicle(zombie, zone, checkZ)

    if not zombie then return false end
    if not isElement(zombie) then return false end

        local players = getElementsWithinColShape( zone, "vehicle" )
        local shortestDistance = 10000
        local shortestPlayer = false
        local shortestDistance2 = 10000
        local allShortestPlayer = false
        for index,player in ipairs(players) do
           
            local distance = getDistanceBetweenPoints3D(zombie.position,player.position)
            if distance < shortestDistance then
                local playerOnGround = true
                if checkZ then
                    playerOnGround = (player.position.z > 127 and player.position.z < 131)
                end
                if playerOnGround then
                    shortestDistance = distance
                    shortestPlayer = player
                end 
            end   
        end
    
    
    return shortestPlayer, shortestDistance

end

function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end