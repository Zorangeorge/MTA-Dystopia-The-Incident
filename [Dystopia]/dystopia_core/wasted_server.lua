playerRespawnTime = 10000 -- miliseconds; player respawn time

addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
		DeadTimer = setTimer( spawnDeadPlayer, playerRespawnTime, 1, source, "dead") 
   		triggerClientEvent ( source, "startDead", source, playerRespawnTime )
   		setElementData(source, "dead:dead", 1)
	end
)

function spawnDeadPlayer(player, deadtype)
if player then
	if deadtype == "dead" then
  	 	triggerClientEvent ( player, "stopDead", player )
   		setElementData(player, "dead:dead", 0)
   	end
end
end