-- the efect settings
local colorizePed={1,0.5,0,1}; 
local specularPower=2;
local effectMaxDistance=20
-- don't touch
local wallShader={}
local effectOn=false

addEventHandler( "onClientResourceStart", resourceRoot,
    function()
        -- Version check
        if getVersion ().sortable < "1.3.1-9.04939" then
            outputChatBox( "Resource is not compatible with this client." )
            outputChatBox( "Please update MTA:SA." )
            return
        end
            effectOn=true;  
    end
)

addEventHandler( "onClientResourceStop", resourceRoot,
    function()
            effectOn=false;
            wallShader=nil;
    end
)

function createWallEffectForPlayer(thisPlayer)
    if not wallShader[thisPlayer] and isPedDucked(localPlayer) == true then
        wallShader[thisPlayer] = dxCreateShader ( "shaders/ped_wall.fx", 1, 0, true, "ped" )
        if not wallShader then return false
        else
        dxSetShaderValue( wallShader[thisPlayer], "sColorizePed",colorizePed )
        dxSetShaderValue( wallShader[thisPlayer], "sSpecularPower",specularPower )
        engineApplyShaderToWorldTexture ( wallShader[thisPlayer], "*" , thisPlayer )
        engineRemoveShaderFromWorldTexture( wallShader[thisPlayer],"muzzle_texture*" , thisPlayer )
        if getElementAlpha(thisPlayer)==255 then setElementAlpha( thisPlayer, 254 ) end
        return true
        end
    end
end

function destroyShaderForPlayer(thisPlayer)
    if wallShader[thisPlayer] then
        engineRemoveShaderFromWorldTexture( wallShader[thisPlayer], "*" , thisPlayer)
        destroyElement(wallShader[thisPlayer])
        wallShader[thisPlayer]=nil
    end
end

addEventHandler("onClientRender",getRootElement(),
    function() 
    if not effectOn then return end 
    for index,thisPlayer in ipairs(getElementsByType("ped")) do
      if isElementStreamedIn(thisPlayer) and thisPlayer~=localPlayer then
        local hx,hy,hz = getElementPosition(thisPlayer)            
        local cx,cy,cz,clx,cly,clz,crz,cfov = getCameraMatrix()
        local dist = getDistanceBetweenPoints3D(cx,cy,cz,hx,hy,hz)
        local isItClear = isLineOfSightClear (cx,cy,cz, hx,hy, hz, true, false, false, true, false, true, false, thisPlayer )
        if (dist<effectMaxDistance ) and not isItClear then createWallEffectForPlayer(thisPlayer) end 
        if (dist>effectMaxDistance ) or  isItClear then destroyShaderForPlayer(thisPlayer)  end
      end
      if not isElementStreamedIn(thisPlayer) then destroyShaderForPlayer(thisPlayer) end
    end
end
)