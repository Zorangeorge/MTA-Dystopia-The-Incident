local eof = nil

addEvent("SaveObjLoc",true)

function saveCoords( x, y, z)
    local fhnd = nil
    if fileOpen( "saved_coords.txt" ) then
        fhnd = fileOpen( "saved_coords.txt" )
        eof = fileGetSize( fhnd )
        fileSetPos( fhnd, eof )
    else
        fhnd = fileCreate( "saved_coords.txt" )
    end
    local str = tostring( x ) .. ", " .. tostring( y ) .. ", " .. tostring( z );
    
    str = str .. "\r\n"
    eof = fileWrite( fhnd, str )
    fileSetPos( fhnd, eof )
    fileClose( fhnd )
    outputChatBox( "Position saved")
end

function savePos( x,y,z )
   -- local _x, _y, _z = getElementPosition( player )
   -- local _rot = getPedRotation( player )
   -- local comment = table.concat( arg, " " )
	--location = getElementPosition(get)
    saveCoords( x,y,z )
end
--addCommandHandler( "this", savePos )
--addCommandHandler( "/", savePos )
addEventHandler("SaveObjLoc",root,savePos)