--[[

Forest Generator v1.0.0
autor: Essle Jaxcate | essle.55@yandex.ru

[clientside]

]]

--

local generatorData = {
	pause = 50,		-- Pause between steps
	frequency = 40.0,	-- Frequency of trees
	stream = 5,		-- Stream multiplier (stream * frequency <= 200)
	size = 5800.0,  -- World size
}

--

local generatedPositions = {}

--

addCommandHandler("generate", function(_, frequency)

	generatorData.frequency = (frequency or 40.0)
	generatorData.stream = (200.0 / generatorData.frequency)

	sleepCall(generateObjects)

end)

--

function generateObjects()

	generatedPositions = {}

	setCameraTarget(localPlayer)

	local count, step, lp = (generatorData.size / generatorData.frequency) - 1, 1, nil

	for i = 0, count do
		for k = 0, count do

			local position = {
				-(generatorData.size / 2) + (i * generatorData.frequency) + math.randomf(-generatorData.frequency / 2, generatorData.frequency / 2), 
				-(generatorData.size / 2) + (k * generatorData.frequency) + math.randomf(-generatorData.frequency / 2, generatorData.frequency / 2), 
			}
			position[3] = getGroundPosition(position[1], position[2], 500.0)

			if k % generatorData.stream == 0 then
				setCameraMatrix(position[1], position[2], position[3] + generatorData.frequency, position[1], position[2], position[3])
			end

			local hit, _, _, _, _, _, _, _, material = processLineOfSight(
				position[1], position[2], position[3] + 50.0, 
				position[1], position[2], position[3] - 50.0, 
				true, true, true, true, true, false, false, false, nil, true
			)

			if hit and table.of(material, {
				--[[ 9,  10,  11,  12,  13,  14,  15,  16,  17,  20,  80,  81, 
				 82, 115, 116, 117, 118, 119, 120, 121, 122, 125, 146, 147, 
				148, 149, 150, 151, 152, 153, 160 --all grass]]
				
				--[[121,122,125,151,152,22,83,84,110,128,129,130,132]] --forest floor
				
				--[[1, 2, 3, 4, 5, 7, 89, 135, 138, 85 --urban]]
				
				24,126,110,155,156 --river weeds
				
				
			}) then
				table.insert(generatedPositions, position)
			end

			local np = math.ceil((step / ((count + 1) * (count + 1))) * 100)
			if np ~= lp then
				outputChatBox(np.."%")
				outputDebugString(np.."%")
				lp = np
			end

			step = step + 1

			if k % generatorData.stream == 0 then
				sleep(generatorData.pause)
			end

		end
	end

	setCameraTarget(localPlayer)

	triggerServerEvent("call.generateObjects", localPlayer, generatedPositions)

end

--

function sleepCall(callback, ...) 

	local co = coroutine.create(callback)
	coroutine.resume(co, ...)

end

--

function sleep(time) 

	local co = coroutine.running() 

	setTimer(function()
		coroutine.resume(co)
	end, time, 1)

	coroutine.yield()

end

--

function table.of(a, b)

	for theKey, argument in ipairs(b or {}) do
		if argument == a then
			return theKey
		end
	end

	return nil

end

--

function math.randomf(a, b)

	local random = math.random(a * 100, b * 100)

	return ((random ~= 0) and (random / 100) or random)

end