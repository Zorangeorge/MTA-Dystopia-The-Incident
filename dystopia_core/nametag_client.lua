-----------SCRIPT CREATED by yFletcher---------
-----------Favor não retirar os creditos-------
-----------------BR Mods MTA-------------------

addEventHandler( "onClientRender",root,
   function( )
      local px, py, pz, tx, ty, tz, dist
      px, py, pz = getCameraMatrix( )
      for _, v in ipairs( getElementsByType 'player' ) do
	  
		  if v == localPlayer then else
			 tx, ty, tz = getElementPosition( v )
			 dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
			 if dist < 5.0 then
				if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false--[[,localPlayer]] ) then
				   local sx, sy, sz = getPedBonePosition( v, 5 )
				   local x,y = getScreenFromWorldPosition( sx, sy, sz + 0.3 )
				   local playerTeam = getPlayerTeam( v )
				   if playerTeam == false then nameR, nameG, nameB = 255,255,255 else nameR, nameG, nameB = getTeamColor ( playerTeam ) end 
				   if x then
				   dxDrawText( string.gsub ( getPlayerName ( v ), "#%x%x%x%x%x%x", "" ).."", x-2, y-4, x-2, y-4, tocolor(0, 0, 0), (0.85 + ( 10 - dist ) * 0.1)/1.5, "pricedown", "center", "top" )                
				   dxDrawText( string.gsub ( getPlayerName ( v ), "#%x%x%x%x%x%x", "" ).."", x, y-6, x, y-6, tocolor(nameR, nameG, nameB), (0.85 + ( 10 - dist ) * 0.1)/1.5, "pricedown", "center", "top" )                
				   end
				end
			 end
		 end	 
      end
   end
)

addEventHandler( "onClientRender",root,
   function( )
      local px, py, pz, tx, ty, tz, dist
      px, py, pz = getCameraMatrix( )
      for _, v in ipairs( getElementsByType 'ped' ) do
	  
	  if getElementData(v,"zombie") == true then name = "Walker" else name = getElementData(v, "name") end
	  if getElementData(v,"zombie") == true and getElementData(v,"brute") == true then name = "Brute" end
	  if getElementData(v,"zombie") == true and getElementData(v,"runner") == true then name = "Runner" end
	  if getElementData(v,"zombie") == true and getElementData(v,"rammer") == true then name = "Rammer" end
	  
	  if getElementData ( v, "talking" ) == true then return else

	     tx, ty, tz = getElementPosition( v )
         dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
         if dist < 5.0 then
            if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
               local sx, sy, sz = getPedBonePosition( v, 5 )
               local x,y = getScreenFromWorldPosition( sx, sy, sz + 0.3 )
               if getElementData(v,"zombie") == true then nameR, nameG, nameB = 100,209,63 
               --elseif getElementData(v,"zombie") == "rammer" then nameR, nameG, nameB = 100,209,63 
			   elseif getElementData(v,"raider") == true then nameR, nameG, nameB = 235, 58, 19
			   elseif getElementData(v,"bandit") == true then nameR, nameG, nameB = 96, 77, 37 
			   elseif getElementData(v,"cdf") == true then nameR, nameG, nameB = 81, 121, 135 
			   elseif getElementData(v,"establishment") == true then nameR, nameG, nameB = 82, 85, 86 
			   
			   else nameR, nameG, nameB = 255,255,255 end            
               if x and name then
               dxDrawText( string.gsub ( name, "#%x%x%x%x%x%x", "" ).."", x-2, y-4, x-2, y-4, tocolor(0, 0, 0), (0.85 + ( 10 - dist ) * 0.1)/1.5, "pricedown", "center", "top" ) --name shadow               
			   dxDrawText( string.gsub ( name, "#%x%x%x%x%x%x", "" ).."", x, y-6, x, y-6, tocolor(nameR, nameG, nameB), (0.85 + ( 10 - dist ) * 0.1)/1.5, "pricedown", "center", "top" )                
					
--[[					if dist < 5 and bottomHelpLineVisible == false then
						showHelpMessage(dialogue_help_messsage)
						currentHelpText = dialogue_help_messsage
						bottomHelpLineVisible = true
					end]]
					
			   end
            end
		 end
		 end
	  end
   end
)
