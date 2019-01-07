-- Plugin made by LagParty, do whatever you want with it.

-- posY represents the relative vertical position of the text on the screen. 0 = top, 1 = bottom.
local posY = 0.78

-- fontWidth (in pixels) determines the x position of the text
local fontWidth = 20

-- totalFrames determines how much time (in milliseconds) the text will be shown.
-- Use values greater than 2000 (over 9000 works too!)
local totalTime = 5000

-- Some needed variables
local rootElement = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize()
local x,y = 0,screenHeight*posY
local carName = "default"
local startTime = 0

-- Based on the current time this function returns an alpha value to create the fade in/out effect.
function getAlpha(aux)
	if aux > totalTime then 
		return 0
	end

	local alpha = 255
	
	if aux <= 1000 then
		alpha = aux/4
	elseif aux >= totalTime-1000 then 
		alpha = (totalTime-aux)/4
	end
	
	return alpha
end

-- This function shows the text, you could experiment with different fonts and colors.
function createVehNameText()

	local aux = getTickCount() - startTime
	local alpha = getAlpha(aux)
	
	-- Black border
    dxDrawText( carName, x+1, y, screenWidth, screenHeight, tocolor ( 0, 0, 0, alpha ), 1, "bankgothic" )
	dxDrawText( carName, x-1, y, screenWidth, screenHeight, tocolor ( 0, 0, 0, alpha ), 1, "bankgothic" )
	dxDrawText( carName, x, y+1, screenWidth, screenHeight, tocolor ( 0, 0, 0, alpha ), 1, "bankgothic" )
	dxDrawText( carName, x, y-1, screenWidth, screenHeight, tocolor ( 0, 0, 0, alpha ), 1, "bankgothic" )
	-- Green text
    dxDrawText( carName, x, y, screenWidth, screenHeight, tocolor ( 240, 240, 240, alpha ), 1, "bankgothic" )
	
	-- Stop showing the text
	if aux > totalTime then
		removeEventHandler("onClientRender", rootElement, createVehNameText)
	end
end

-- This function is called by the server when someone gets into a custom named car.
function HandleText(var)
	carName = var
	x = (screenWidth - fontWidth*string.len(carName))/2
	startTime = getTickCount()
	
    addEventHandler("onClientRender", rootElement, createVehNameText)
end

-- This is the event triggered by the server
addEvent("ShowCustomCarName", true)
addEventHandler("ShowCustomCarName", rootElement, HandleText)
