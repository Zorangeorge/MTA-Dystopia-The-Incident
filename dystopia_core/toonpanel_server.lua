--[[maskTable = {}   
yelekTable = {} 

yelekTable["yelek1"] = {1922, 3, 90} 
yelekTable["yelek2"] = {1923, 3, 90} 
yelekTable["yelek3"] = {1924, 3, 90} 

maskTable["devil"] = {1512, 1, 90} 
maskTable["vendetta"] = {1455, 1, 90} 
maskTable["darth"] = {1484, 1, 90} 
maskTable["horse"] = {1485, 1, 90} 
maskTable["gasmask"] = {1487, 1, 90} 
maskTable["kovboy"] = {1543, 1, 90} 
maskTable["zombie"] = {1544, 1, 90} 
maskTable["vampire"] = {1666, 1, 90} 
maskTable["skull"] = {1667, 1, 90} 
maskTable["raccoon"] = {1668, 1, 180} 
maskTable["owl"] = {1950, 1, 180} 
maskTable["cat"] = {1951, 1, 90} 
maskTable["bag"] = {1551, 1, 90} 
maskTable["dog"] = {1546, 1, 90} 
maskTable["baby"] = {1669, 1, 90} 
maskTable["monster"] = {1853, 1, 90} 
maskTable["tilki"] = {1854, 1, 90} 
maskTable["admin"] = {1855, 1, 180} 
obje = {}
yelek = {}

function maske_kaldir()
		if obje[source] then
		destroyElement(obje[source])
		
		end
end
addEvent("removemask",true) 
addEventHandler("removemask", root, maske_kaldir) 

function yelek_kaldir()
		if yelek[source] then
		destroyElement(yelek[source])
		
		end
end
addEvent("removeyelek",true) 
addEventHandler("removeyelek", root, yelek_kaldir) 

function maske_ekle(name)
if name == "admin" then
if ( hasObjectPermissionTo ( source, "function.kickPlayer" ) ) then
		if obje[source] then
		destroyElement(obje[source])
		end
local objeid = maskTable[name][1]
local bodyattach = maskTable[name][2]
local zROT = maskTable[name][3]
obje[source] = createObject ( objeid, 0, 0, 0, 0, 0, 0 )
exports.bone_attach:attachElementToBone(obje[source],source,bodyattach,0,0.02,-0.61,0,0,zROT) 
else
--outputChatBox("Bu maskeyi sadece adminler kullanabilir", source, 255, 0, 0)
end
elseif name == "horse" then
		if obje[source] then
		destroyElement(obje[source])
		end
local objeid = maskTable[name][1]
local bodyattach = maskTable[name][2]
local zROT = maskTable[name][3]
obje[source] = createObject ( objeid, 0, 0, 0, 0, 0, 0 )
exports.bone_attach:attachElementToBone(obje[source],source,bodyattach,-0.04,0,-0.55,0,0,zROT)
else
		if obje[source] then
		destroyElement(obje[source])
		end
local objeid = maskTable[name][1]
local bodyattach = maskTable[name][2]
local zROT = maskTable[name][3]
obje[source] = createObject ( objeid, 0, 0, 0, 0, 0, 0 )
exports.bone_attach:attachElementToBone(obje[source],source,bodyattach,0,0,-0.61,0,0,zROT) 
end
end 
addEvent("setmask",true) 
addEventHandler("setmask", root, maske_ekle) 

function yelek_ekle(name)
		if yelek[source] then
		destroyElement(yelek[source])
		yelek[source] = nil
		end
local objeid = yelekTable[name][1]
local bodyattach = yelekTable[name][2]
local zROT = yelekTable[name][3]
yelek[source] = createObject ( objeid, 0, 0, 0, 0, 0, 0 )
exports.bone_attach:attachElementToBone(yelek[source],source,3,-0.03,0,-0.55,-0.5,2,90) 
end
addEvent("setyelek",true) 
addEventHandler("setyelek", root, yelek_ekle) 


function quitPlayer (  )
			if obje[source] then
		destroyElement(obje[source])
		end			
		if yelek[source] then
		destroyElement(yelek[source])
		end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )]]