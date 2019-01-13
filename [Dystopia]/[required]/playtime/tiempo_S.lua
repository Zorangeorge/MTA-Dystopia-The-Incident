------------------------------------------------------------------------------------
--  RIGHTS:      All rights reserved by developers
--  DEVELOPERS:  Oscar Ernesto (The'Oskar)
-- Don't Touch This or a Cat will Die D:!!!!!!!!
------------------------------------------------------------------------------------
--call ( getResourceFromName ( "scoreboard" ), "scoreboardAddColumn", "Alive Time" ) ---Export of ScoreBoard
call ( getResourceFromName ( "scoreboard" ), "scoreboardAddColumn", "Play Time" ) ---Export of ScoreBoard

 
addEventHandler ( "onResourceStart" , resourceRoot ,
    function ( )
        for index , player in ipairs ( getElementsByType ( "player" ) ) do
            local pAccount = getPlayerAccount ( player )
            if not isGuestAccount ( pAccount ) then
                local minutes = getAccountData ( pAccount , "Online.minutes" )
                	if minutes then
						local hours = getAccountData ( pAccount , "Online.hours" )
						if # tostring ( minutes ) == 1 then
							minutes = "0" .. minutes
						end
						if # tostring ( hours ) == 1 then
							hours = "0" .. hours
						end
						setElementData ( player , "Play Time" , hours .. ":" .. minutes .. "" )
						local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , player )
						setElementData ( player , "Online.timer" , timer )
					else
						setAccountData ( pAccount , "Online.minutes" , 0 )
						setAccountData ( pAccount , "Online.hours" , 0 )
						setElementData ( player , "Play Time" , "00:00 " )
						local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , player )
						setElementData ( player , "Online.timer" , timer )
					end
            else
                setElementData ( player , "Play Time" , "N/A" )
            end
        end
    end
)
 
addEventHandler ( "onResourceStop" , resourceRoot ,
    function ( )
        for index , player in ipairs ( getElementsByType ( "player" ) ) do
            local pAccount = getPlayerAccount ( player )
            if not isGuestAccount ( pAccount ) then
                local timer = getElementData ( player , "Online.timer" )
                if isTimer ( timer ) then
                    killTimer ( timer )
                end
            end
        end
    end
)
 
addEventHandler ( "onPlayerLogin" , root ,
    function ( _ , pAccount )
        local minutes = getAccountData ( pAccount , "Online.minutes" )
        if minutes then
            local hours = getAccountData ( pAccount , "Online.hours" )
            if # tostring ( minutes ) == 1 then
                minutes = "0" .. minutes
            end
            if # tostring ( hours ) == 1 then
                hours = "0" .. hours
            end
            setElementData ( source , "Play Time" , hours .. ":" .. minutes .. "" )
            local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , source )
            setElementData ( source , "Online.timer" , timer )
        else
            setAccountData ( pAccount , "Online.minutes" , 0 )
            setAccountData ( pAccount , "Online.hours" , 0 )
            setElementData ( source , "Play Time" , "00:00" )
            local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , source )
            setElementData ( source , "Online.timer" , timer )
        end
    end
)
 
addEventHandler ( "onPlayerLogout" , root ,
    function ( pAccount )
        local timer = getElementData ( source , "Online.timer" )
        if isTimer ( timer ) then
            killTimer ( timer )
        end
    end
)
 
addEventHandler ( "onPlayerJoin" , root ,
    function ( )
        setElementData ( source , "Play Time" , "N/A" )
    end
)
 
addEventHandler ( "onPlayerQuit" , root ,
    function ( )
        local pAccount = getPlayerAccount ( source )
        if not isGuestAccount ( pAccount ) then
            local timer = getElementData ( source , "Online.timer" )
            if isTimer ( timer ) then
                killTimer ( timer )
            end
        end
    end
)
 
function actualizarJugadorOn ( player )
    local pAccount = getPlayerAccount ( player )
    local minutes = getAccountData ( pAccount , "Online.minutes" )
    local hours = getAccountData ( pAccount , "Online.hours" )
   -- local team = getAccountData ( pAccount , "Faction" )
    minutes = tostring ( tonumber ( minutes ) + 1 )
    if minutes == "60" then
        hours = tostring ( tonumber ( hours ) + 1 )
        minutes = "00"
    end
    setAccountData ( pAccount , "Online.minutes" , tonumber ( minutes ) )
    setAccountData ( pAccount , "Online.hours" , tonumber ( hours ) )
    if # tostring ( minutes ) == 1 then minutes = "0" .. minutes end
    if # tostring ( hours ) == 1 then hours = "0" .. hours end
    setElementData ( player , "Play Time" , hours .. ":" .. minutes .. "" )
 --   setElementData ( player , "Faction" , team )
    local timer = setTimer ( actualizarJugadorOn , 60000 , 1 , player )
    setElementData ( player , "Online.timer" , timer )
end