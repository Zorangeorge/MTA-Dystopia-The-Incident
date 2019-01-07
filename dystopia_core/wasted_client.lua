local screenWidth, screenHeight = guiGetScreenSize()
local myScreenSource = dxCreateScreenSource(screenWidth, screenHeight)
local showHud = "false"
local flickerStrength = 10
local blurStrength = 0.001 
local noiseStrength = 0.001
local heartbeatsound = nil

function startDead(waitTimeS)
  attachrotatingcamera(not active,getLocalPlayer(),5,10)
  addEventHandler("onClientRender", root, deadRender)
  addEventHandler("onClientPreRender", root, updateShader)
  setElementData(getLocalPlayer(), "showHUD", 0)
  setElementData(getLocalPlayer(), "dead:timedead", getTickCount() + waitTimeS)
  if not heartbeatsound then
	heartbeatsound = playSound("sounds/heartbeat.mp3",true)
  end
end
addEvent( "startDead", true )
addEventHandler( "startDead", localPlayer, startDead )

function stopDead()
  attachrotatingcamera(false,getLocalPlayer(),5,10)
  removeEventHandler("onClientRender", root, deadRender)
  removeEventHandler("onClientPreRender", root, updateShader)
  if heartbeatsound then stopSound(heartbeatsound); heartbeatsound = nil end
    setElementData(getLocalPlayer(), "showHUD", 1)
  setElementData(getLocalPlayer(), "dead:timedead", 0)
  if getElementData(localPlayer,"lives")<1 then setCameraMatrix(1491.48572, -1402.52332, 23.61719, 1491.42236, -1407.00012, 23.61719) end
end
addEvent( "stopDead", true )
addEventHandler( "stopDead", localPlayer, stopDead )


function checkVersionAndCreateOldFilmShader()
    if getVersion ().sortable < "1.1.0" then
        return
    else
        createOldFilmShader()
    end
end


function createOldFilmShader()     
    oldFilmShader, oldFilmTec = dxCreateShader("shaders/old_film.fx")
end


function updateShader()
    if (showHud == "false") then
        setPlayerHudComponentVisible("all", false) 
        setPlayerHudComponentVisible("crosshair", true) 
    end
    
    upDateScreenSource()

    if (oldFilmShader) then
        local flickering = math.random(100 - flickerStrength, 100)/100
        dxSetShaderValue(oldFilmShader, "ScreenSource", myScreenSource);
        dxSetShaderValue(oldFilmShader, "Flickering", flickering);
        dxSetShaderValue(oldFilmShader, "Blurring", blurStrength);
        dxSetShaderValue(oldFilmShader, "Noise", noiseStrength);
        dxDrawImage(0, 0, screenWidth, screenHeight, oldFilmShader)
    end
end


function upDateScreenSource()
    dxUpdateScreenSource(myScreenSource)
end

monospacefont = dxCreateFont( "fonts/Westrider2057.ttf", 20 )

function deadRender()
  local time = getElementData(getLocalPlayer(), "dead:timedead") - getTickCount()
  local s = (time/1000)%60
  local divider = ":"
  if s < 10 then divider = ":0" end
  local m = (time/(1000*60))%60

  dxDrawImage ( 0, 0, screenWidth, screenHeight, "shaders/black_blur_borders.png")
  dxDrawRectangle ( 0, 0, screenWidth, 100, tocolor ( 0, 0, 0, 150 ) )
  dxDrawRectangle ( 0, screenHeight - 100, screenWidth, 100, tocolor ( 0, 0, 0, 150 ) )
  hou_bordertext(" ", 0, 50, screenWidth, 50, tocolor( 227, 0, 14, 255 ),tocolor( 0, 0, 0, 255 ), 1, monospacefont, "center", "center" )
  hou_bordertext("0"..math.floor(m)..divider..math.floor(s), 0, screenHeight - 50, screenWidth, screenHeight - 50, tocolor( 255, 255, 255, 255 ),tocolor( 0, 0, 0, 255 ), 1, monospacefont, "center", "center" )
end

-- EDIT ME
 
local rotSpeed = 1 -- How much degrees you want the camera to turn per frame
 
-- DON'T EDIT ME ANYMOAR
local angle = 0
local elem
local zOff
local dist
local active = false
 
function getPointFromDistanceRotation(x, y, dist, angle) --credits to robhol from wiki snippets
    local a = math.rad(90 - angle)
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end
 
function attachrotatingcamera(bool,element,Zoffset,distance)
   if bool then
      active=true
      elem,zOff,dist=element,Zoffset,distance --make values global
      addEventHandler("onClientRender",getRootElement(),createRotRamera)
   else
      removeEventHandler("onClientRender",getRootElement(),createRotRamera)
      setCameraTarget(getLocalPlayer(),getLocalPlayer())
      active=false
   end
end
 
function createRotRamera()
   local x,y,z=getElementPosition(elem)
   local camx,camy=getPointFromDistanceRotation(x, y, dist, angle)
   setCameraMatrix(camx,camy,z+zOff,x,y,z)
   angle=(angle+rotSpeed)%360
end

function hou_bordertext( text, x, y, w, h, color, color2, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, color2, scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, color2, scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, color2, scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, color2, scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, color2, scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, color2, scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, color2, scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, color2, scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end