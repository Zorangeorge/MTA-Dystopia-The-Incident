-- Create the shield / change the model 
function clientshieldstarter( theResource )
	if ( theResource == getThisResource() ) then
		local txd_shield = engineLoadTXD("riot_shield.txd")
		engineImportTXD(txd_shield,1631)
		local col_shield = engineLoadCOL("riot_shield.col")
		local dff_shield = engineLoadDFF("riot_shield.dff", 1631 )
		engineReplaceCOL(col_shield,1631)
		engineReplaceModel(dff_shield,1631)
	end
end
addEventHandler("onClientResourceStart", root, clientshieldstarter)

function shieldingyet ()
--if (getTeamName(getPlayerTeam( localPlayer )) == "Survivors") then
	local currenttask = getPedSimplestTask (localPlayer)
	if shieldon ~= 1 then
		if currenttask == "TASK_SIMPLE_PLAYER_ON_FOOT" and getControlState("jump") == true and getControlState("aim_weapon") == true then
			--currentweapon = getPedWeapon (localPlayer)
			currentweaponslot = getPedWeaponSlot (localPlayer)
			shieldon = 1
			setPedAnimation( localPlayer )
			--givePedWeapon ( localPlayer, 0, 0, true ) --try to cancel the anim!!
			triggerServerEvent ("shieldup", localPlayer)
		end
	elseif shieldon == 1 then
		if currenttask ~= "TASK_SIMPLE_PLAYER_ON_FOOT" or getControlState("jump") == false or getControlState("aim_weapon") == false then
			shieldon = 0
			triggerServerEvent ("shielddown", localPlayer, currentweaponslot )
		end
	end
--end
end

function shieldLeggDamageControl ( attacker, weapon, bodypart )
	if ( bodypart == 7 or  bodypart == 8 ) and ( shieldon == 1 ) then
		cancelEvent()
	end
end
addEventHandler ( "onClientPlayerDamage", localPlayer, shieldLeggDamageControl )

function shieldtimer( key, keyState )
	--if (getTeamName(getPlayerTeam( localPlayer )) == "Survivors") then
		--local theWeapon = getPedWeaponSlot (localPlayer)
		--if ( theWeapon == 1 or theWeapon == 10 or theWeapon == 0 or theWeapon == 2 or theWeapon == 4 ) then
			if keyState == "down" then
				blockcheck = setTimer ( shieldingyet, 50, 0, localPlayer )
			else
				if blockcheck then
					killTimer(blockcheck)
					blockcheck = nil
					if shieldon == 1 then
						shieldon = 0
						currentweaponslot = getPedWeaponSlot (localPlayer)
						triggerServerEvent ("shielddown", localPlayer, currentweaponslot )
					end
				end
			end
		--end
	--end
end
bindKey ( "jump", "both", shieldtimer )
