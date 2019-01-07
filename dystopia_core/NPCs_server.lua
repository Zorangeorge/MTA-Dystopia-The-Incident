local lastX = {}
local lastY = {}
local lastZ = {}
local lastHealth = {}

setTimer(   --ANIMALS AI
    function()
	
        for i, peds in ipairs(getElementsByType("ped")) do
            if getElementData(peds, "type") == "animal" then
			
					if getElementHealth(peds) <= 0 then
						local bx, by, bz = getElementPosition(peds)
						setPedAnimation(peds, "CRACK", "crckidle2", -1, false, true, false, true)
						setElementData(peds, "type", "animal_carcass")
						setTimer(function()if isElement(peds) then destroyElement(peds) end end,120000,1) -- DEAD ANIMALS DELETION INTERVAL
						setElementCollisionsEnabled(peds, false)
					end
		
                if getElementHealth(peds) > 0 then
                    if getElementData(peds, "genus") == "farm" then
                        if getElementData(peds, "panic") == true then
                            setPedAnimation(peds, "ped", "run_civi")
                        else
                            setPedAnimation(peds, "ped", table.random(animalAnims))
                        end
                    else
                        if getElementData(peds, "panic") == true then
                            setPedAnimation(peds, "ped", "sprint_civi")
                        else
                            setPedAnimation(peds, "ped", table.random(animalAnims))
                        end
                    end
                end
                if getElementHealth(peds) > 0 and getElementData(peds, "Rotating") == false and isPedDead(peds) == false then
                    if lastX[peds] == nil then
                        local x, y, z = getElementPosition(peds)
                        lastX[peds] = x
                        lastY[peds] = y
                        lastZ[peds] = z
                        lastHealth[peds] = getElementHealth(peds)
                    end
                    local x, y, z = getElementPosition(peds)
                    if lastHealth[peds] > getElementHealth(peds) then
                        lastHealth[peds] = getElementHealth(peds)
                        setElementData(peds, "panic", true)
						triggerClientEvent(root,"sync.message", peds, peds, 255, 204, 0, "SCARED")
                        setTimer(
                            function()
                                if isElement(peds) then
                                    setElementData(peds, "panic", false)
                                end
                            end
                        , 30000, 1)
                    end
                    local g = 0.5
                    if getElementData(peds, "panic") == true then
                        g = 0.25
                    end
                    if getDistanceBetweenPoints3D(x, y, z, lastX[peds], lastY[peds], lastZ[peds]) < g then
                        local success = false
                        local rot = getPedRotation(peds)
                        setElementData(peds, "Rotating", true)
                        local module = "positive"
                        local executed = 0
                        local rand = math.random(0, 1)
                        if rand == 0 then
                            module = "negative"
                        end
                        setTimer(
                            function()
                                if isElement(peds) == false then return end
                                executed = executed + 1
                                local rot = getPedRotation(peds)
                                if module == "positive" then
                                    setPedRotation(peds, rot + math.random(5, 10))
                                else
                                    setPedRotation(peds, rot - math.random(5, 10))
                                end
                                if executed == 18 then
                                    setElementData(peds, "Rotating", false)
                                end
                            end
                        , 50, 18)
                    else
                        lastX[peds] = x
                        lastY[peds] = y
                        lastZ[peds] = z
                        local c = math.random(0, 1)
                        for i, elements in ipairs(getElementsByType("player")) do
                            local x, y, z = getElementPosition(peds)
                            local rot = getPedRotation(peds)
                            local mrot = rot + 90
                            mrot = math.rad(mrot)
                            local jx = x + 1 * math.cos(mrot)
                            local jy = y + 1 * math.sin(mrot)
                            local ex, ey, ez = getElementPosition(elements)
                            if getDistanceBetweenPoints3D(jx, jy, z, ex, ey, ez) < 1 then
                                c = 0
                                setElementData(peds, "Rotating", true)
                                local genus
                                if getElementData(peds, "genus") == "farm" then
                                    genus = "farm"
                                else
                                    genus = "wild"
                                end
                                if getElementData(peds, "panic") ~= true then
                                    local message = math.random(0, 4)
                                    if message == 4 then
                                        outputChatBox("", getRootElement(), 0, 255, 0, true)
                                    elseif message == 3 then
                                        outputChatBox("", getRootElement(), 0, 255, 0, true)
                                    elseif message == 2 then
                                        outputChatBox("", getRootElement(), 0, 255, 0, true)
                                    elseif message == 1 then
                                        outputChatBox("", getRootElement(), 0, 255, 0, true)
                                    elseif message == 0 then
                                        outputChatBox("", getRootElement(), 0, 255, 0, true)
                                    end 
                                end
                                local rand = math.random(0, 1)
                                local module = "positive"
                                local executed = 0
                                if rand == 0 then
                                    module = "negative"
                                end
                                setTimer(
                                    function()
                                        if isElement(peds) == false then return end
                                        executed = executed + 1
                                        local rot = getPedRotation(peds)
                                        if module == "positive" then
                                            setPedRotation(peds, rot + 10)
                                        else
                                            setPedRotation(peds, rot - 10)
                                        end
                                        if executed == 9 then
                                            setElementData(peds, "Rotating", false)
                                        end
                                    end
                                , 50, 9)
                            end
                        end
                        for i, elements in ipairs(getElementsByType("ped")) do
                            if elements ~= peds then
                            local x, y, z = getElementPosition(peds)
                            local rot = getPedRotation(peds)
                            local mrot = rot + 90
                            mrot = math.rad(mrot)
                            local jx = x + 1 * math.cos(mrot)
                            local jy = y + 1 * math.sin(mrot)
                            local ex, ey, ez = getElementPosition(elements)
                            if getDistanceBetweenPoints3D(jx, jy, z, ex, ey, ez) < 1 then
                                c = 0
                                setElementData(peds, "Rotating", true)
                                local rand = math.random(0, 1)
                                local module = "positive"
                                local executed = 0
                                if rand == 0 then
                                    module = "negative"
                                end
                                setTimer(
                                    function()
                                        if isElement(peds) == false then return end
                                        executed = executed + 1
                                        local rot = getPedRotation(peds)
                                        if module == "positive" then
                                            setPedRotation(peds, rot + 10)
                                        else
                                            setPedRotation(peds, rot - 10)
                                        end
                                        if executed == 9 then
                                            setElementData(peds, "Rotating", false)
                                        end
                                    end
                                , 50, 9)
                            end
                            end
                        end
                        for i, elements in ipairs(getElementsByType("vehicle")) do
                            local x, y, z = getElementPosition(peds)
                            local rot = getPedRotation(peds)
                            local mrot = rot + 90
                            mrot = math.rad(mrot)
                            local jx = x + 2.5 * math.cos(mrot)
                            local jy = y + 2.5 * math.sin(mrot)
                            local ex, ey, ez = getElementPosition(elements)
                            if getDistanceBetweenPoints3D(jx, jy, z, ex, ey, ez) < 2.5 then
                                c = 0
                                setElementData(peds, "Rotating", true)
                                local rand = math.random(0, 1)
                                local module = "positive"
                                local executed = 0
                                if rand == 0 then
                                    module = "negative"
                                end
                                setTimer(
                                    function()
                                        if isElement(peds) == false then return end
                                        executed = executed + 1
                                        local rot = getPedRotation(peds)
                                        if module == "positive" then
                                            setPedRotation(peds, rot + 10)
                                        else
                                            setPedRotation(peds, rot - 10)
                                        end
                                        if executed == 9 then
                                            setElementData(peds, "Rotating", false)
                                        end
                                    end
                                , 50, 9)
                            end
                        end
                        if c == 1 then
                            local rot = getPedRotation(peds)
                            local rand = math.random(0, 1)
                            setElementData(peds, "Rotating", true)
                            local module = "positive"
                            local executed = 0
                            if rand == 0 then
                                module = "negative"
                            end
                            setTimer(
                                function()
                                    if isElement(peds) == false then return end
                                    executed = executed + 1
                                    local rot = getPedRotation(peds)
                                    if module == "positive" then
                                        setPedRotation(peds, rot + math.random(5, 10))
                                    else
                                        setPedRotation(peds, rot - math.random(5, 10))
                                    end
                                    if executed == 5 then
                                        setElementData(peds, "Rotating", false)
                                    end
                                end
                            , 50, 5)
                        end
                    end
                end
            end
        end
    end
, 2000, 0)

local randAnimInterval = math.random(1000,1000)

setTimer(   --CIVILIANS AI
    function()
	
        for i, peds in ipairs(getElementsByType("ped")) do
            if getElementData(peds, "type") == "civilian" then
					
					local pedhealth = getElementHealth(peds)
			
					if pedhealth <= 0 then
												
						local bx, by, bz = getElementPosition(peds)
						local body_loot = createObjectItem( table.random(scavengersLoot), bx, by, bz-0.95, 0,0, math.random(0,359), 0, 0)
						
						setElementData(peds, "type", "dead")
						setTimer(function()if isElement(peds) then destroyElement(peds) end end,120000,1) -- PED DEAD BODY DELETION TIME
						setElementCollisionsEnabled(peds, false)
					end
		
                if getElementHealth(peds) > 0 then
				local rando = math.random(0,1)
				if rando == 1 and getElementData(peds, "panic") ~= true then --[[ped takes a break]] else
                    if getElementData(peds, "sex") == "male" then
                        if getElementData(peds, "panic") == true then
                            setPedAnimation(peds, "ped", table.random(civiliansPanicAnims))
                        else
                            setPedAnimation(peds, "ped", table.random(civiliansAnims))
                        end
                    else
                        if getElementData(peds, "panic") == true then
                            setPedAnimation(peds, "ped", table.random(civiliansPanicAnims))
                        else
                            setPedAnimation(peds, "ped", table.random(civiliansAnims))
                        end
                    end
                end
				end
				local rando = math.random(0,1)
                if getElementHealth(peds) > 0 and getElementData(peds, "Rotating") == false and isPedDead(peds) == false and rando == 1 then
				
                    if lastX[peds] == nil then
                        local x, y, z = getElementPosition(peds)
                        lastX[peds] = x
                        lastY[peds] = y
                        lastZ[peds] = z
                        lastHealth[peds] = getElementHealth(peds)
                    end
                    local x, y, z = getElementPosition(peds)
					
					local isslothbot = getElementData(peds,"slothbot")--------zz
					
                    if lastHealth[peds] > getElementHealth(peds) then
					
					 if isslothbot == true then setElementData(peds,"type",nil) return end
					 
                        lastHealth[peds] = getElementHealth(peds)
                        setElementData(peds, "panic", true)
						triggerClientEvent(root,"sync.message", peds, peds, 255, 204, 0, "SCARED")
						setPedAnimation(peds)--stop current anim
                        setTimer(
                            function()
                                if isElement(peds) then
                                    setElementData(peds, "panic", false)
                                end
                            end
                        , 60000, 1) -- PED 'PANIC' STATE DURATION
                    end
					
                    local g = 0.5
                    if getElementData(peds, "panic") == true then
                        g = 0.25
                    end
                    if getDistanceBetweenPoints3D(x, y, z, lastX[peds], lastY[peds], lastZ[peds]) < g then
                        local success = false
                        local rot = getPedRotation(peds)
                        setElementData(peds, "Rotating", true)
                        local module = "positive"
                        local executed = 0
                        local rand = math.random(0, 1)
                        if rand == 0 then
                            module = "negative"
                        end
                        setTimer(
                            function()
                                if isElement(peds) == false then return end
                                executed = executed + 1
                                local rot = getPedRotation(peds)
                                if module == "positive" then
                                    setPedRotation(peds, rot + math.random(5, 10))
                                else
                                    setPedRotation(peds, rot - math.random(5, 10))
                                end
                                if executed == 18 then
                                    setElementData(peds, "Rotating", false)
                                end
                            end
                        , 50, 18)
                    else
                        lastX[peds] = x
                        lastY[peds] = y
                        lastZ[peds] = z
                        local c = math.random(0, 1)
                        for i, elements in ipairs(getElementsByType("player")) do
                            local x, y, z = getElementPosition(peds)
                            local rot = getPedRotation(peds)
                            local mrot = rot + 90
                            mrot = math.rad(mrot)
                            local jx = x + 1 * math.cos(mrot)
                            local jy = y + 1 * math.sin(mrot)
                            local ex, ey, ez = getElementPosition(elements)
                            if getDistanceBetweenPoints3D(jx, jy, z, ex, ey, ez) < 10 then
                                c = 0
                                setElementData(peds, "Rotating", true)
                                local sex
                                if getElementData(peds, "sex") == "male" then
                                    sex = "male"
                                else
                                    sex = "female"
                                end
								
                                if getElementData(peds, "panic") ~= true then
                                    local messagechance = math.random(0, 1000)
									local name = getElementData(peds, "name")
								
									if getElementData(peds,"cdf") == true then messageTable = CDFChat
										elseif getElementData(peds,"raider") == true then messageTable = raiderChat
										elseif getElementData(peds,"refugee") == true then messageTable = refugeeChat
										elseif getElementData(peds,"scavenger") == true then messageTable = civilianChat
										elseif getElementData(peds,"bandit") == true then messageTable = guardchat
										elseif getElementData(peds,"raiderslave") == true then messageTable = victimChat
										elseif getElementData(peds,"cleaner") == true then messageTable = guardchat
										elseif getElementData(peds,"raidermeat") == true then messageTable = victimChat
										elseif getElementData(peds,"peacekeeper") == true then messageTable = peacekeepersChat
										elseif getElementData(peds,"neutralfreelancer") == true then messageTable = guardchat
										elseif getElementData(peds,"freelancer") == true then messageTable =guardchat
										elseif getElementData(peds,"freelancer") == true then messageTable = guardchat
										elseif getElementData(peds,"wastelander") == true then messageTable = civilianChat
										elseif getElementData(peds,"syndicate") == true then messageTable = civilianChat
										elseif getElementData(peds,"vendor") == true then messageTable = traderChat
										elseif getElementData(peds,"establishment") == true then messageTable = guardchat
										else messageTable = {"Howdy!"}
									end
									
                                    if messagechance <= 10 then -- 1% chance for a random message
										local randommessage = table.random(messageTable) or "Howdy-ho!"
										messageTable = nil
											sendToNearbyPlayers(peds,randommessage)
											setElementData(peds, "talking", true)
											setTimer(function() if isElement(peds) then setElementData(peds, "talking", false) end end, 8500,1)
									
										--elseif messagechance > 4 then --  say nothing
									
                                    end 
                                end
                                local rand = math.random(0, 1)
                                local module = "positive"
                                local executed = 0
                                if rand == 0 then
                                    module = "negative"
                                end
                                setTimer(
                                    function()
                                        if isElement(peds) == false then return end
                                        executed = executed + 1
                                        local rot = getPedRotation(peds)
                                        if module == "positive" then
                                            setPedRotation(peds, rot + 10)
                                        else
                                            setPedRotation(peds, rot - 10)
                                        end
                                        if executed == 9 then
                                            setElementData(peds, "Rotating", false)
                                        end
                                    end
                                , 50, 9)
                            end
                        end
                        for i, elements in ipairs(getElementsByType("ped")) do
                            if elements ~= peds then
                            local x, y, z = getElementPosition(peds)
                            local rot = getPedRotation(peds)
                            local mrot = rot + 90
                            mrot = math.rad(mrot)
                            local jx = x + 1 * math.cos(mrot)
                            local jy = y + 1 * math.sin(mrot)
                            local ex, ey, ez = getElementPosition(elements)
                            if getDistanceBetweenPoints3D(jx, jy, z, ex, ey, ez) < 1 then
                                c = 0
                                setElementData(peds, "Rotating", true)
                                local rand = math.random(0, 1)
                                local module = "positive"
                                local executed = 0
                                if rand == 0 then
                                    module = "negative"
                                end
                                setTimer(
                                    function()
                                        if isElement(peds) == false then return end
                                        executed = executed + 1
                                        local rot = getPedRotation(peds)
                                        if module == "positive" then
                                            setPedRotation(peds, rot + 10)
                                        else
                                            setPedRotation(peds, rot - 10)
                                        end
                                        if executed == 9 then
                                            setElementData(peds, "Rotating", false)
                                        end
                                    end
                                , 50, 9)
                            end
                            end
                        end
                        for i, elements in ipairs(getElementsByType("vehicle")) do
                            local x, y, z = getElementPosition(peds)
                            local rot = getPedRotation(peds)
                            local mrot = rot + 90
                            mrot = math.rad(mrot)
                            local jx = x + 2.5 * math.cos(mrot)
                            local jy = y + 2.5 * math.sin(mrot)
                            local ex, ey, ez = getElementPosition(elements)
                            if getDistanceBetweenPoints3D(jx, jy, z, ex, ey, ez) < 2.5 then
                                c = 0
                                setElementData(peds, "Rotating", true)
                                local rand = math.random(0, 1)
                                local module = "positive"
                                local executed = 0
                                if rand == 0 then
                                    module = "negative"
                                end
                                setTimer(
                                    function()
                                        if isElement(peds) == false then return end
                                        executed = executed + 1
                                        local rot = getPedRotation(peds)
                                        if module == "positive" then
                                            setPedRotation(peds, rot + 10)
                                        else
                                            setPedRotation(peds, rot - 10)
                                        end
                                        if executed == 9 then
                                            setElementData(peds, "Rotating", false)
                                        end
                                    end
                                , 50, 9)
                            end
                        end
                        if c == 1 then
                            local rot = getPedRotation(peds)
                            local rand = math.random(0, 1)
                            setElementData(peds, "Rotating", true)
                            local module = "positive"
                            local executed = 0
                            if rand == 0 then
                                module = "negative"
                            end
                            setTimer(
                                function()
                                    if isElement(peds) == false then return end
                                    executed = executed + 1
                                    local rot = getPedRotation(peds)
                                    if module == "positive" then
                                        setPedRotation(peds, rot + math.random(5, 10))
                                    else
                                        setPedRotation(peds, rot - math.random(5, 10))
                                    end
                                    if executed == 5 then
                                        setElementData(peds, "Rotating", false)
                                    end
                                end
                            , 50, 5)
                        end
                    end
                end
            end
        end
    end
, randAnimInterval, 0)

function checkIfPlayerIsBehind(player,bot)
	if getElementType(player) ~= "player" then return false end
	if isPedDead(bot) then return true end --you're always behind a bot that's dead :)
	local px,py,pz = getElementPosition(player)
	local bx,by,bz = getElementPosition(bot)
	local botBackCol = getElementData(bot,"backSide")
	local bbx,bby,bbz = getElementPosition(botBackCol)
		if getDistanceBetweenPoints3D(px,py,pz,bx,by,bz) < getDistanceBetweenPoints3D(px,py,pz,bbx,bby,bbz) then 
			return false 
		else 
			return true 
		end
end

threatenFriendlyMessages = {"Watch where you're pointing that!", "You don't wanna threaten me!", "Hey, I'm friendly!", "You're about to make a big mistake!", "Don't point that at me!", "Friendly here, watch out!", "Lower your weapon!","Put the gun down!" }
unholsteredFriendlyMessages = {"Put away the weapon!", "Careful with that gun!", "Stop waving that gun!", "Holster your weapon!" }
pedWasRobbedMessages = {"Help! I'm being robbed!", "Robbery! Heelp!","This is all I have!", "Take it, it's all I have!", "Damn you, take this and leave me alone!","Don't hurt me! Take this...","Take this and let me go!","You wretched thief!","That's all I got!"}
pedWasAlreadyRobbedMessages = {"You already took all I got!", "I have nothing left!", "I don't have anything of value!", "I swear, I have nothing left!"}
threatenRobbingMessages = {"Please don't hurt me!", "Don't shoot!", "Please sir, no!", "Oh no!", "Not again!", "What do you want?"}
meleeThreatenedMessages = {"Gun!","Whoa!","Don't shoot!","Wait, mister..."}
local distanceToTargetedPed
local theThreatenedPed = nil
local theTargetedElement = nil

function aimAtNPC (ped)

if not ped then return end
if getElementType(ped)~= "ped" then return end
--if getElementData(ped,"slothbot") then iprint(getElementData(ped,"target")) end
	theTargetedElement = ped
	local aiming = getControlState(source,"aim_weapon")
	local validPed = false
	local armed
	
	local slot = getSlotFromWeapon(getPedWeapon(source))
	
	if slot > 1 and slot ~= 10 then 
		armed = true 
	else 
		armed = false 
	end
	
	if ped and getElementType(ped) == "ped" and not getElementData(ped,"threatened") and armed then

		local px, py, pz = getElementPosition(source)
		local ex, ey, ez = getElementPosition(ped)
		distanceToTargetedPed = getDistanceBetweenPoints3D(px, py, pz, ex, ey, ez)
		if distanceToTargetedPed < 4 then
			validPed = true
			theThreatenedPed = ped
		end
		--outputChatBox("element targeted")
	end

	if validPed then 
		--if getElementData(ped,"slothbot") then sloth = true end

		local sameteam
		local enemy
		local plteam = getPlayerTeam(source) or "Scavengers"	
		local pedteam = getElementData(ped,"BotTeam")
		local sloth = getElementData(ped,"slothbot")
		local civ = getElementData(ped,"type")
		
		if plteam == pedteam then
			sameteam = true 
		else 
			enemy = true 
		end
		
		if sameteam and sloth then
			setElementData(ped,"threatened",true)
				if aiming then 
				sendToNearbyPlayers(ped,table.random(threatenFriendlyMessages))
				triggerClientEvent(root, "sync.message", ped, ped, 255, 255, 255, "ANGRY")
				else
				sendToNearbyPlayers(ped,table.random(unholsteredFriendlyMessages))
				triggerClientEvent(root, "sync.message", ped, ped, 255, 255, 255, "ALERT")
				end
			setElementData(ped,"talking",true,true)
			setTimer(setElementData,8500,1,ped,"talking",false,true)
			setTimer(setElementData,11000,1,ped,"threatened",false)
		end
		
		if enemy and sloth then
			if aiming and (getSlotFromWeapon(getPedWeapon(ped)) < 2 or getSlotFromWeapon(getPedWeapon(ped)) == 10) then
				if not checkIfPlayerIsBehind(source,ped) then
					setElementData(ped,"threatened",true)
					setPedAnimation(ped,"ped","handscower",4000,false,true,false,false)
					sendToNearbyPlayers(ped,table.random(meleeThreatenedMessages))
					triggerClientEvent(root, "sync.message", root, ped, 255, 255, 255, "INTIMIDATED")
					setElementData(ped,"talking",true,true)
					setTimer(function(ped) if isElement(ped) then setElementData(ped,"talking",false,true) end end,8500,1,ped)

				end
			end
		end
		
		if not sloth and civ == "civilian" and aiming then 
		
		setElementData(ped,"threatened",true)
		setElementData(ped,"type","threatened")
		setPedAnimation(ped, "SHOP", "SHP_Rob_HandsUp", 10000, true, true, false, true)
		sendToNearbyPlayers(ped,table.random(threatenRobbingMessages))
		triggerClientEvent(root, "sync.message", ped, ped, 255, 255, 255, "SCARED")
		setTimer(setElementData,11000,1,ped,"threatened",false)
		setTimer(setElementData,11000,1,ped,"type","civilian")
					setElementData(ped,"talking",true,true)
					setTimer(setElementData,8500,1,ped,"talking",false,true)
		setTimer(setElementData,11000,1,ped,"panic",true)
		setTimer(function()
					if isElement(ped) then
						setElementData(ped, "panic", false)
					end
				end
				, 60000, 1) -- PED 'PANIC' STATE DURATION after threatened		setTimer(function()
		local player = source
		setTimer(function()
					if isElement(ped) and theTargetedElement == ped then
						if not getElementData(ped,"wasrobbed") then
							--robbing takes place
							local x,y,z = getElementPosition(ped)
							createObjectItem(table.random(pedRobberyLoot),x,y,z-0.95, 97.3,120, 0)
							outputInteractInfo("["..getElementData(ped,"name").." robbed]", player, 240, 240, 240)
							outputStatusInfo("- 1 karma", player, 240, 240, 240)
							addPlayerKarma(player,-1)
							sendToNearbyPlayers(ped,table.random(pedWasRobbedMessages))
							triggerClientEvent(root, "sync.message", ped, ped, 255, 255, 255, "ROBBED")
							setElementData(ped,"talking",true,true)
							setTimer(setElementData,8500,1,ped,"talking",false,true)
							setElementData(ped,"wasrobbed",true)
						else
							sendToNearbyPlayers(ped,table.random(pedWasAlreadyRobbedMessages))
							setElementData(ped,"talking",true,true)
							setTimer(setElementData,8500,1,ped,"talking",false,true)
						end
					end
				end
				, 9000, 1) -- PED 'PANIC' STATE DURATION after threatened
		end
		
	end

end
addEventHandler ("onPlayerTarget",root,aimAtNPC)


--[[function SlitSplits(ped)
				splitTimer = setTimer( function()if isElement(ped) then 
													local rot = getPedRotation(ped)
													setPedAnimation(ped);
													setPedRotation(ped, rot + math.random(5, 30))
													setPedAnimation(ped,"PED","sprint_civi")
												 else killTimer(splitTimer)
												 end
										end
										, 2000, 5)
				setTimer(function()destroyElement(ped)end,10000,1)
end]]

--create butcher colshape on ped wasted
addEventHandler("onPedWasted", root, 
	function ()
		if getElementData(source,"zombie") ~= true then 
		createButcherCol(source)
		end
	end
)

