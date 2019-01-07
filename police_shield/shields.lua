local theShields = {}

addEvent ("shieldup", true )
addEventHandler("shieldup", root,
	function ()
		local x, y, z = getElementPosition( client )
		
		if not theShields[client] then
		theShields[source] = createObject ( 1631, x, y, z, 0, 0, 0 )
		setElementDimension(theShields[client], getElementDimension(client))
		setElementInterior(theShields[client], getElementInterior(client))
		setElementDoubleSided(theShields[client], true)
		--setElementData ( theShields[source], "type", "ashield", false )
		end
		detachElements(theShields[client])
		attachElements( theShields[client], client, 0, 0.5, 0.5, 0, 0, 180 )
		

		giveWeapon ( client, 0, 0, true )
		--toggleControl ( source, "forwards", false)
		toggleControl ( client, "backwards", false)
		toggleControl ( client, "left", false)
		toggleControl ( client, "right", false)
		toggleControl ( client, "sprint", false)
		toggleControl ( client, "fire", false)
	end
)

addEvent ("shielddown", true )
addEventHandler("shielddown", root,
	function ( currentweapon )
--[[	local theshield
		stuckstuff = getAttachedElements ( source )
		for ElementKey, ElementValue in ipairs(stuckstuff) do
			if ( getElementData ( ElementValue, "type" ) == "ashield" ) then
				theshield = ElementValue
			end
		end]]
		if theShields[client] then 
		exports.bone_attach:attachElementToBone(theShields[client],client,3,0,-0.1,0, 0,0,-20)
		--destroyElement ( theshield )
		end
		--giveWeapon ( source, 0, 0, true )
		setPedWeaponSlot(client,currentweapon)
		--toggleControl ( source, "forwards", true)
		toggleControl ( client, "backwards", true)
		toggleControl ( client, "left", true)
		toggleControl ( client, "right", true)
		toggleControl ( client, "sprint", true)
		toggleControl ( client, "fire", true)
	end
)

addEventHandler( "onPlayerQuit", root,
	function ()
		if ( theShields[source] ) then
			if ( isElement( theShields[source] ) ) then
				destroyElement( theShields[source] )
			end
		end
	end
)

--[[addEvent( "onPlayerPayfine", true )
addEventHandler( "onPlayerPayfine", root,
function ( theMoney )
	takePlayerMoney( source, theMoney )
	exports.server:removePlayerWantedPoints( source, 10 )
end
)]]
