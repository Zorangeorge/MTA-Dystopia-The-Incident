------------------------------------------------------------------------------------
--  RIGHTS:      All rights reserved by developers
--  DEVELOPERS:  Oscar Ernesto (The'Oskar)
-- Don't Touch This or a Cat will Die D:!!!!!!!!
------------------------------------------------------------------------------------
call ( getResourceFromName ( "scoreboard" ), "scoreboardAddColumn", "Alive Time" ) ---Export of ScoreBoard

 
addEventHandler ( "onResourceStart" , resourceRoot ,
    function ( )
        for index , player in ipairs ( getElementsByType ( "player" ) ) do
            local pAccount = getPlayerAccount ( player )
            if not isGuestAccount ( pAccount ) then
                local minutes = getAccountData ( pAccount , "Alive.minutes" )
                	if minutes then
						local hours = getAccountData ( pAccount , "Alive.hours" )
						if # tostring ( minutes ) == 1 then
							minutes = "0" .. minutes
						end
						if # tostring ( hours ) == 1 then
							hours = "0" .. hours
						end
						setElementData ( player , "Alive Time" , hours .. ":" .. minutes .. "" )
						local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , player )
						setElementData ( player , "Alive.timer" , timer )
					else
						setAccountData ( pAccount , "Alive.minutes" , 0 )
						setAccountData ( pAccount , "Alive.hours" , 0 )
						setElementData ( player , "Alive Time" , "00:00 " )
						local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , player )
						setElementData ( player , "Alive.timer" , timer )
					end
            else
                setElementData ( player , "Alive Time" , "N/A" )
            end
        end
    end
)
 
addEventHandler ( "onResourceStop" , resourceRoot ,
    function ( )
        for index , player in ipairs ( getElementsByType ( "player" ) ) do
            local pAccount = getPlayerAccount ( player )
            if not isGuestAccount ( pAccount ) then
                local timer = getElementData ( player , "Alive.timer" )
                if isTimer ( timer ) then
                    killTimer ( timer )
                end
            end
        end
    end
)
 
addEventHandler ( "onPlayerLogin" , root ,
    function ( _ , pAccount )
        local minutes = getAccountData ( pAccount , "Alive.minutes" )
        if minutes then
            local hours = getAccountData ( pAccount , "Alive.hours" )
            if # tostring ( minutes ) == 1 then
                minutes = "0" .. minutes
            end
            if # tostring ( hours ) == 1 then
                hours = "0" .. hours
            end
            setElementData ( source , "Alive Time" , hours .. ":" .. minutes .. "" )
            local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , source )
            setElementData ( source , "Alive.timer" , timer )
        else
            setAccountData ( pAccount , "Alive.minutes" , 0 )
            setAccountData ( pAccount , "Alive.hours" , 0 )
            setElementData ( source , "Alive Time" , "00:00" )
            local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , source )
            setElementData ( source , "Alive.timer" , timer )
        end
    end
)
 
addEventHandler ( "onPlayerLogout" , root ,
    function ( pAccount )
        local timer = getElementData ( source , "Alive.timer" )
        if isTimer ( timer ) then
            killTimer ( timer )
        end
    end
)
 
addEventHandler ( "onPlayerJoin" , root ,
    function ( )
        setElementData ( source , "Alive Time" , "N/A" )
    end
)
 
addEventHandler ( "onPlayerQuit" , root ,
    function ( )
        local pAccount = getPlayerAccount ( source )
        if not isGuestAccount ( pAccount ) then
            local timer = getElementData ( source , "Alive.timer" )
            if isTimer ( timer ) then
                killTimer ( timer )
            end
        end
    end
)
 
function actualizarJugadorOn ( player )
	
	if getCameraTarget (player) then
		local pAccount = getPlayerAccount ( player )
		local minutes = getAccountData ( pAccount , "Alive.minutes" )
		local hours = getAccountData ( pAccount , "Alive.hours" )

		minutes = tostring ( tonumber ( minutes ) + 1 )
		if minutes == "60" then
			hours = tostring ( tonumber ( hours ) + 1 )
			minutes = "00"
		end
		setAccountData ( pAccount , "Alive.minutes" , tonumber ( minutes ) )
		setAccountData ( pAccount , "Alive.hours" , tonumber ( hours ) )
		if # tostring ( minutes ) == 1 then minutes = "0" .. minutes end
		if # tostring ( hours ) == 1 then hours = "0" .. hours end
		setElementData ( player , "Alive Time" , hours .. ":" .. minutes .. "" )
	end
	
    local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , player )
    setElementData ( player , "Alive.timer" , timer )
	
end

addEventHandler("onElementDataChange", root, function (dataname,olddatavalue)

if getElementType(source) ~= "player" or dataname ~= "lives" then return end

	if getElementData(source,"lives") == 0 then 
		local pAccount = getPlayerAccount(source)
			setAccountData ( pAccount , "Alive.minutes" , 0 )
			setAccountData ( pAccount , "Alive.hours" , 0 )
			setElementData ( source , "Alive Time" , "00:00" )

	end

end)