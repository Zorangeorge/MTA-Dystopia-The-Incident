function airstrike ()
	if not isPedDead (localPlayer) then
	outputDebugString("AAAAIRSTRIKEEEE!")
		local x,y,z = getElementPosition(localPlayer)
		createProjectile(localPlayer, 20, x,y,z+100, 2.0, localPlayer)
		createProjectile(localPlayer, 20, x,y+30,z+100, 2.0, localPlayer)
		createProjectile(localPlayer, 20, x,y-30,z+100, 2.0, localPlayer)
		createProjectile(localPlayer, 20, x+30,y,z+100, 2.0, localPlayer)
		createProjectile(localPlayer, 20, x-30,y,z+100, 2.0, localPlayer)
	end
end

playeroutsidebounds = false
playerescaped = false
won = false

function watchForEscapeAttempt()
	
	local x,y,z =  getElementPosition(localPlayer)
	
	if (x >= 8000 or x <= -8000 or y >= 8000 or y <= -8000) then
		playerescaped = true
		outputDebugString("YAY! YOU ESCAPED!")
	elseif (x >= 4000 or x <= -4000 or y >= 4000 or y <= -4000) then
		playeroutsidebounds = true
		outputDebugString("Outside bounds!")
	else 
		playeroutsidebounds = false
		playerescaped = false
		won = false
	end

	if playeroutsidebounds == true then
		airstrike()
	elseif playerescaped == true and won == false then
	local player = localPlayer	
		triggerEvent("EscapedScreen", player)
		won = true
	end
	playeroutsidebounds = false
	playerescaped = false
end
setTimer(watchForEscapeAttempt,10000,0)
