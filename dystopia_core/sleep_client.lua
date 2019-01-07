local screenWidth, screenHeight = guiGetScreenSize ( )
local sleepW = 100
local sleepH = 8
local sleepX = screenWidth * 0.5
local sleepY = screenHeight * 0.7

local sleeping_start
local sleeping_end
local sleeping_interval

function drawSleepingText ( )
    local progress = (getTickCount()-sleeping_start)/(sleeping_end-sleeping_start)
    if sleepW*progress > sleepW then 
    	--sleeping_start = getTickCount()
    	--sleeping_end = getTickCount() + sleeping_interval
    	progress = 1
   	end

    dxDrawRectangle ( sleepX-(sleepW/2), sleepY-(sleepH/2), sleepW, sleepH, tocolor(0,0,0,80) )
    dxDrawRectangle ( sleepX-(sleepW/2), sleepY-(sleepH/2), sleepW+math.ceil(sleepW*-progress), sleepH, tocolor(245,245,245) )
end

local shaderAlpha = 0

function drawShader()
	dxDrawImage(0, 0, screenWidth, screenHeight, "shaders/black_blur_borders.png", 0, 0, 0, tocolor(255, 255, 255, shaderAlpha))
end

addEvent("sleep:addShader", true)
addEventHandler("sleep:addShader", root,
	function (fadingTime)
		local cycles = fadingTime/75
		local addBy = 255/cycles
		setTimer(
			function ()
				shaderAlpha = shaderAlpha + addBy
				if shaderAlpha >= 255 then killTimer(sourceTimer) end
			end, 75, cycles

		)
		addEventHandler("onClientRender", root, drawShader)
		shaderAlpha = 0
	end
)

addEvent("sleep:removeShader", true)
addEventHandler("sleep:removeShader", root,
	function (fadingTime)
		local cycles = fadingTime/75
		local substractBy = 255/cycles
		setTimer(
			function ()
				shaderAlpha = shaderAlpha - substractBy * 1.15
				if shaderAlpha <= 0 then killTimer(sourceTimer) shaderAlpha = 0 end
			end, 75, cycles

		)
		setTimer(
			function ()
				removeEventHandler("onClientRender", root, drawShader)
			end, fadingTime, 1
		)
	end
)

addEvent("sleep:collisions", true)
addEventHandler("sleep:collisions", root,
	function (player, bed, bool)
		setElementCollidableWith(player, bed, bool)
	end
)

addEvent("sleep:drawDXProgress", true)
addEventHandler("sleep:drawDXProgress", root,
	function (time, cycles)
    	dxProgressBar(time, cycles)
	end
)

addEvent("sleep:stopDXProgress", true)
addEventHandler("sleep:stopDXProgress", root,
	function (timeInterval)
		dxKillProgressBar()
	end
)

addEvent("sleep:updateHealth", true)
addEventHandler("sleep:updateHealth", root,
	function (newHP)
		setElementHealth(localPlayer, newHP)
	end
)

function dxProgressBar(time, cycles)
	sleeping_interval = time
	sleeping_start = getTickCount()
    sleeping_end = getTickCount() + sleeping_interval

    setTimer(
    	function ()
    		dxKillProgressBar()
    	end,
    time*cycles, 1)

    removeEventHandler("onClientRender", root, drawSleepingText)
    addEventHandler("onClientRender", root, drawSleepingText)
end

function dxKillProgressBar()
	removeEventHandler("onClientRender", root, drawSleepingText)
    sleeping_start = nil
    sleeping_end = nil
    sleeping_interval = nil
end

addEventHandler("onClientColShapeHit", resourceRoot,
	function (player)
		if getElementType(player) == "player" and player == localPlayer and isPedOnGround(player) and getElementData(source,"bedcol") then
			triggerServerEvent("sleep:onColShapeHit", resourceRoot, source)
			triggerEvent("showHelpMessageEvent",player,bed_help_messsage)
		end
	end
)

addEventHandler("onClientColShapeLeave", resourceRoot,
	function (player)
		if getElementType(player) == "player" and getElementData(source,"bedcol") then
			triggerServerEvent("sleep:onColShapeLeave", resourceRoot, source)
		end
	end
)