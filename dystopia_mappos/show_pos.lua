--[[
local localPlayer = getLocalPlayer()
local screenWidth, screenHeight = guiGetScreenSize()
local position_lbl = guiCreateLabel( 10, screenHeight-24, screenWidth, 22, " ", false )

function renderPosition()
    local _x, _y, _z = getElementPosition( localPlayer )
    local _rot = getPlayerRotation( localPlayer )
    guiSetText( position_lbl, "X: " .. tostring( _x ) .. ";   Y: " .. tostring( _y ) .. ";   Z: " .. tostring( _z ) .. "; RotZ: " .. tostring(_rot) )
    end
addEventHandler( "onClientRender", getResourceRootElement( getThisResource( ) ), renderPosition )]]