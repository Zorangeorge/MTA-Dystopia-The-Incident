function reward()
local ammount = getElementData(localPlayer,"ComBo")
local reward = 10
local bonus = ammount/10
local totaal = ammount*(reward*bonus)

--triggerServerEvent("killreward",localPlayer,totaal)

outputStatusInfo("+"..totaal.." xp", 240,240,240 )

local xp = getPlayerExp(localPlayer) -- give xp for the kill
setPlayerExp(localPlayer,xp+totaal)
setElementData(localPlayer,"ComBo",false)
end

function hupla (killer, weapon, bodypart)
    if ( killer and killer == localPlayer and source ~= killer ) then
	--if weapon == 0 then outputDebugString("melee weapon kill") end
      local x, y, z = getElementPosition( source )
      local randombloodamount = math.random( 1, 3 ) 
      fxAddBlood ( x, y, z-2, 0.00000, 0.00000, 0.00000, randombloodamount, 1 )
        
      local combo = getElementData(localPlayer,"ComBo") or 0
        if combotimer ~= nil and  isTimer(combotimer) then
        killTimer(combotimer)
        end
        if combo == 0 then
            setElementData(localPlayer,"ComBo",combo +1)
            combotimer = setTimer(reward,10000,1,localPlayer)
            else
            setElementData(localPlayer,"ComBo",combo +1)
            
            if isTimer(combotimer) then
            
               killTimer(combotimer)
               
            end
            combotimer = setTimer(reward,10000,1,localPlayer)
        end
    end
    
end

addEventHandler("onClientPedWasted", root, hupla)
addEventHandler("onClientPlayerWasted", root, hupla)

--killStrRndrTxt = "images/killstreak.png" or 0
 
function showcombo ( )
    local comboX = getElementData(localPlayer,"ComBo") or 0
    local screenWidth, screenHeight = guiGetScreenSize ()
 if comboX >= 2 then
    if killStrRndrTxt ~= 0 then
    dxDrawText ( "Kill".."\n".."streak", screenWidth/29, screenHeight/2, screenWidth/14, screenHeight/14, tocolor ( 170, 0, 0, 150 ), 1, "pricedown" )
    dxDrawText ( "\n"..comboX, screenWidth/7, screenHeight/2, screenWidth/2.15, screenHeight/2, tocolor ( 255, 255, 255, 150 ), 1, "pricedown" )
    --else killStrRndrTxt = "images/killstreak.png" or 0
    end
 end

end
 
function zz ( )
addEventHandler ( "onClientRender", root, showcombo )
end
 
addEventHandler ( "onClientResourceStart", resourceRoot, zz )


