-- the efect settings
local colorizePed={1,0.5,0,1}; 
local specularPower=2;
local effectMaxDistance=20
-- don't touch
local wallShaders = {}

local function createWallEffectForPed(ped)
    if wallShaders[ped] then
        return
    end
    if not isPedDucked(ped) then
        return
    end

    wallShaders[ped] = dxCreateShader ( "shaders/ped_wall.fx", 1, 0, true, "ped" )
    if not wallShaders[ped] then 
        outputDebugString("Failed to create wall effect shader for ped "..tostring(ped), 1)
        return
    end

    dxSetShaderValue( wallShaders[ped], "sColorizePed",colorizePed )
    dxSetShaderValue( wallShaders[ped], "sSpecularPower",specularPower )
    engineApplyShaderToWorldTexture ( wallShaders[ped], "*" , ped )
    engineRemoveShaderFromWorldTexture( wallShaders[ped],"muzzle_texture*" , ped )
    if getElementAlpha(ped) == 255 then 
        setElementAlpha( ped, 254 ) 
    end
end

local function destroyWallEffectForPed(ped)
    if wallShaders[ped] then
        engineRemoveShaderFromWorldTexture(wallShaders[ped], "*" , ped)
        destroyElement(wallShaders[ped])
        wallShaders[ped] = nil
    end
end

local function processEffects()
    local peds = getElementsByType("ped", root, true)
    for i=1,#peds do
        if isElementStreamedIn(peds[i]) then
            if peds[i] ~= localPlayer then
                local x, y, z = getElementPosition(peds[i])            
                local cx, cy, cz = getCameraMatrix()
                local distance = getDistanceBetweenPoints3D(cx, cy, cz, x, y, z)
                local hasLOS = isLineOfSightClear(cx, cy, cz, x, y, z, true, false, false, true, false, true, false, peds[i])
                if (distance < effectMaxDistance) and not hasLOS then 
                    createWallEffectForPed(peds[i])
                elseif (distance > effectMaxDistance) or hasLOS then
                    destroyWallEffectForPed(peds[i])
                end
            end
        else
            destroyWallEffectForPed(peds[i])
        end
    end
end
addEventHandler("onClientRender", root, processEffects)
