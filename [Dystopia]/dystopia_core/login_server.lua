notification = {
[1] = "Username and/or password incorrect",
[2] = "Enter a password",
[3] = "Enter a username",
[4] = "Account name already in use",
[5] = "Enter a password",
[6] = "Enter a username",
[7] = "Account created, press 'Login'"
}

function requestLogin(accname,password)
    if not (accname == "") then
        if not (password == "") then
            local account = getAccount ( accname, password )
            if ( account ~= false ) then
                logIn(source, account, password)
				triggerClientEvent(source, "onPlayerLogged", source)
				local spawnmenuneededaccountcheck = getAccountData(account,"spawnmenuneeded")
				if spawnmenuneededaccountcheck == "true" then setElementData(source,"newchar",true) end
				local spawnmenuneeded = getElementData(source,"newchar")
				if spawnmenuneeded then 
				triggerClientEvent(source,"ShowSpawnMenu",resourceRoot)
				setElementData(client,"newchar",false)
				setAccountData(account,"spawnmenuneeded","false")
				else 
				fadeCamera(source, false,0)
				spawn(source)
				end
			else
			 outputTopBar(notification[1], client, 255,0,0) --message(notification[1])
			end
		else
		 outputTopBar(notification[2], client, 255,0,0) --message(notification[2])
		end
	else
	 outputTopBar(notification[3], client, 255,0,0) --message(notification[3])
	end
end
addEvent("onPlayerRequestLogin", true)
addEventHandler("onPlayerRequestLogin", getRootElement(), requestLogin)

function clearLoginInterfaceOnClient()
triggerClientEvent(source,"onPlayerLogged",source)
end
addEventHandler("onPlayerLogin", getRootElement(), clearLoginInterfaceOnClient)

function requestRegistration(regacc,regpass)
    if not (regacc == "") then
        if not (regpass == "") then
            local accountAdded = addAccount(regacc,regpass)
            if (accountAdded) then
			     outputTopBar(notification[7], client, 255,255,255)--message(notification[7])
				 setElementData(client,"newchar",true)
				 setAccountData(accountAdded,"spawnmenuneeded","true")
			else
			 outputTopBar(notification[4], client, 255,0,0)--message(notification[4])
		    end
		else
		 outputTopBar(notification[5], client, 255,0,0)--message(notification[5])			
		end
	else
	 outputTopBar(notification[6], client, 255,0,0)--message(notification[6])
    end
	
end
addEvent("onPlayerRequestRegistration", true)
addEventHandler("onPlayerRequestRegistration", getRootElement(), requestRegistration)

function message(text)
   return outputChatBox(text, source, 0, 255, 100, true)
end

function triggerlogout()

triggerClientEvent(source,"PlayerLoggedOut",source)

end
addEventHandler("onPlayerLogout", root, triggerlogout)