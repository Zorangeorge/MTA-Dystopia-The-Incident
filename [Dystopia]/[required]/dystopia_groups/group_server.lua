function createsql ()
	executeSQLQuery ( "CREATE TABLE IF NOT EXISTS group_list ( groupName TEXT, groupSmallName TEXT, groupTag TEXT, groupSmallTag TEXT, groupAdmin TEXT )" )
	executeSQLQuery ( "CREATE TABLE IF NOT EXISTS group_user ( groupUser TEXT, groupStatus TEXT, groupTag TEXT, groupInvait NUMERIC )" )
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), createsql )

-- Selecting a group window by pressing f4
function startGui ()
	local account = getPlayerAccount ( source )
	if not isGuestAccount ( account ) then
		local name = getAccountName ( account )
		local res = executeSQLQuery ( "SELECT groupTag FROM group_user WHERE groupUser = ? and groupInvait = ?", tostring ( name ), tonumber ( "1" )  )
		if #res > 0 then
			local small = utf8.lower ( res[1].groupTag )
			local res2 = executeSQLQuery ( "SELECT groupUser, groupStatus FROM group_user WHERE groupTag = ? and groupInvait = ?", tostring ( res[1].groupTag ), tonumber ( "1" ) )
			local res3 = executeSQLQuery ( "SELECT groupName, groupTag FROM group_list WHERE groupSmallTag = ?", tostring ( small ) )
			if res2 and res3 then
				triggerClientEvent ( "guiGroup2", source, res2, res3 )
			end
		else
			triggerClientEvent ( "guiGroup", source, "no" )
		end
	end
end
addEvent( "startGroup", true )
addEventHandler( "startGroup", root, startGui )

-- kick out a player
function kickPlayer ( pKick )
	if pKick then
		local account = getPlayerAccount ( source )
		local name = getAccountName ( account )
		if name ~= pKick then
			local resKick = executeSQLQuery ( "SELECT groupTag FROM group_user WHERE groupUser = ?", tostring ( pKick ) )
			local admin = executeSQLQuery ( "SELECT groupAdmin FROM group_list WHERE groupTag = ?", tostring ( resKick[1].groupTag ) )
			if admin[1].groupAdmin == name then
				local resKick2 = executeSQLQuery ( "DELETE FROM group_user WHERE groupUser = ? and groupTag = ?", tostring ( pKick ), tostring ( resKick[1].groupTag ) )
				if resKick2 then
					startGui ( source )
					setElementData ( source, "Group", "--",true )
					outputChatBox ( "You kicked "..pKick.." ", source, 255, 255, 255, true )
				end
			else
				outputChatBox ( "You can't kick others!", source, 255, 255, 255, true )
			end
		else
			outputChatBox ( "You can't kick yourself!", source, 255, 255, 255, true )
		end
	end
end
addEvent( "ClientKickGrop", true )
addEventHandler( "ClientKickGrop", root, kickPlayer )

--exit from the group
function exitGroup ()
	local account = getPlayerAccount ( source )
	local name = getAccountName ( account )
	local adminExit = executeSQLQuery ( "SELECT groupTag FROM group_list WHERE groupAdmin = ?", tostring ( name ) )
	if #adminExit > 0 then
		local dellGroup = executeSQLQuery ( "DELETE FROM group_list WHERE groupAdmin = ?", tostring ( name ) )
		local dellUser = executeSQLQuery ( "DELETE FROM group_user WHERE groupTag = ?", tostring ( adminExit[1].groupTag ) )
		if dellGroup and dellUser then
			setElementData ( source, "Group", "--",true)
			outputChatBox ( "You left the group", source, 255, 255, 255, true )
			outputChatBox ( "Group deleted", source, 255, 255, 255, true )
		end
	else
		local resLeave = executeSQLQuery ( "DELETE FROM group_user WHERE groupUser = ? and groupInvait = ?", tostring ( name ), tonumber ( "1" ) )
		if resLeave then
			setElementData ( source, "Group", "--",true)
			outputChatBox ( "You left the group", source, 255, 255, 255, true )
		end
	end
end
addEvent( "exitGrops", true )
addEventHandler( "exitGrops", root, exitGroup )

-- list of invites
function invaitList ()
	local account = getPlayerAccount ( source )
	local name = getAccountName ( account )
	local resInvaitList = executeSQLQuery ( "SELECT groupTag FROM group_user WHERE groupUser = ? and groupInvait = ?", tostring ( name ), tonumber ( "2" ) )
	if #resInvaitList > 0 then
		triggerClientEvent ( "serverInvaitList", source, resInvaitList )
	else
		outputChatBox ( "No invites", source, 255, 255, 255, true )
	end
end
addEvent( "ClientInvait", true )
addEventHandler( "ClientInvait", root, invaitList )

-- join the group
function addToGroup ( inv )
	if inv then
		local account = getPlayerAccount ( source )
		local name = getAccountName ( account )
		local dellAll = executeSQLQuery ( "DELETE FROM group_user WHERE groupUser = ?", tostring ( name ) )
		if dellAll then
			local addPlayerToGroup = executeSQLQuery ( "INSERT INTO group_user ( groupUser, groupStatus, groupTag, groupInvait ) VALUES ( ?, ?, ?, ? )", tostring ( name ), tostring ( "Online" ), tostring ( inv ), tonumber ( "1" ) )
			if addPlayerToGroup then
				startGui ( source )
				setElementData ( source, "Group", inv ,true)
				outputChatBox ( "Group "..inv.." joined", source, 255, 255, 255, true )
			end
		end
	end
end
addEvent( "ClientInvaitAdd", true )
addEventHandler( "ClientInvaitAdd", root, addToGroup )

-- To create a group
function createGroup ( nameS, tag )
	if nameS and tag then
		local account = getPlayerAccount ( source )
		local namePlayers = getAccountName ( account )
		--[[if isObjectInACLGroup ( "user." .. namePlayers, aclGetGroup ( "VIP" ) ) or 
			isObjectInACLGroup ( "user." .. namePlayers, aclGetGroup ( "WARRIOR" ) ) or 
			isObjectInACLGroup ( "user." .. namePlayers, aclGetGroup ( "HUNTER" ) ) then]]
			local smallName = utf8.lower ( nameS )
			local smallTag = utf8.lower ( tag )
			local addGroup = executeSQLQuery ( "INSERT INTO group_list ( groupName, groupSmallName, groupTag, groupSmallTag, groupAdmin ) VALUES ( ?, ?, ?, ?, ? )", tostring ( nameS ), tostring ( smallName ), tostring ( tag ), tostring ( smallTag ), tostring ( namePlayers ) )
			local addPlayerToNewGroup = executeSQLQuery ( "INSERT INTO group_user ( groupUser, groupStatus, groupTag, groupInvait ) VALUES ( ?, ?, ?, ? )", tostring ( namePlayers ), tostring ( "Online" ), tostring ( tag ), tonumber ( "1" ) )
			if addGroup and addPlayerToNewGroup then
				startGui ( source )
				setElementData ( source, "Group", tag ,true)
				outputChatBox ( "Group created: "..nameS.." ["..tag.."]", source, 255, 255, 255, true )
			end
		--[[else
			startGui ( source )
			outputChatBox ( "[Group] To create a group, you need a special account", source, 255, 255, 255, true )
		end]]
	end
end
addEvent( "clientCreateGroup", true )
addEventHandler( "clientCreateGroup", root, createGroup )

-- invite player
function createInvait ( tegNamPlay )
	if tegNamPlay then
		local NPI = getPlayerFromName ( tegNamPlay )
		if NPI then
			local me = getPlayerAccount ( source )
			local name = getAccountName ( me )
			local account = getPlayerAccount ( NPI )
			if not isGuestAccount ( account ) then
				local namePlayers = getAccountName ( account )
				if name ~= namePlayers then
					local adminFix = executeSQLQuery ( "SELECT groupTag FROM group_list WHERE groupAdmin = ?", tostring ( name ) )
					if #adminFix > 0 then
						local addFix2 = executeSQLQuery ( "SELECT groupTag FROM group_user WHERE groupUser = ? and groupInvait = ?", tostring ( namePlayers ), tonumber ( "1" ) )
						if #addFix2 > 0 then
							outputChatBox ( "Player already in a group: ["..tostring ( addFix2[1].groupTag ).."]", source, 255, 255, 255, true )
						else
							local addFix = executeSQLQuery ( "SELECT groupInvait FROM group_user WHERE groupUser = ? and groupTag = ?", tostring ( namePlayers ), tostring ( adminFix[1].groupTag ) )
							if #addFix > 0 then
								outputChatBox ( "Player already invited", source, 255, 255, 255, true )
							else
								local addPlayerInv = executeSQLQuery ( "INSERT INTO group_user ( groupUser, groupTag, groupInvait ) VALUES ( ?, ?, ? )", tostring ( namePlayers ), tostring ( adminFix[1].groupTag ), tonumber ( "2" ) )
								if addPlayerInv then
									outputChatBox ( "Player "..tegNamPlay.." received an invitation", source, 255, 255, 255, true )
									outputChatBox ( "You have been invited to group ["..adminFix[1].groupTag.."]", NPI, 255, 255, 255, true )
								end
							end
						end
					else
						outputChatBox ( "You can not invite players", source, 255, 255, 255, true )
					end
				else
					outputChatBox ( "You can not invite yourself", source, 255, 255, 255, true )
				end
			else
				outputChatBox ( "You can not invite guests", source, 255, 255, 255, true )
			end
		else
			outputChatBox ( "No player with this nickname", source, 255, 255, 255, true )
		end
	end
end
addEvent( "ClientPlayerInvait", true )
addEventHandler( "ClientPlayerInvait", root, createInvait )

-- server output
addEventHandler ( "onPlayerJoin", root,
	function ()
		setElementData ( source, "Group", "--", true )
	end
)

-- Player authorization
addEventHandler ( "onPlayerLogin", root,
	function ()
		local me = getPlayerAccount ( source )
		local name = getAccountName ( me )
		local loginPlayer = executeSQLQuery ( "SELECT groupTag FROM group_user WHERE groupUser = ? and groupInvait = ?", tostring ( name ), tonumber ( "1" ) )
		if #loginPlayer > 0 then
			executeSQLQuery ( "UPDATE group_user SET groupStatus = ? WHERE groupUser = ?", tostring ( "Online" ), tostring ( name ) )
			setElementData ( source, "Group", loginPlayer[1].groupTag, true )
		else
			setElementData ( source, "Group", "N/A", true )
		end
	end
)

-- player exit
addEventHandler ( "onPlayerQuit", root,
	function ()
		local me = getPlayerAccount ( source )
		local name = getAccountName ( me )
		local loginPlayer = executeSQLQuery ( "SELECT groupTag FROM group_user WHERE groupUser = ? and groupInvait = ?", tostring ( name ), tonumber ( "1" ) )
		if #loginPlayer > 0 then
			executeSQLQuery ( "UPDATE group_user SET groupStatus = ? WHERE groupUser = ?", tostring ( "---" ), tostring ( name ) )
		end
	end
)

-- item in the tab panel
addEventHandler ( "onResourceStart", root,
	function ()
		call ( getResourceFromName ( "scoreboard" ), "addScoreboardColumn", "Group", 8)
	end
)