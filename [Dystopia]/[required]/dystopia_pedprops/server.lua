maskTable = {}   
vestTable = {} 

vestTable["khakivest"] = {1922, 3, 90} 
vestTable["estabvest"] = {1923, 3, 90} 
vestTable["blackvest"] = {1924, 3, 90} 

maskTable["vendetta"] = {1455, 1, 90} 
maskTable["gasmask"] = {1487, 1, 90} 
maskTable["cowboy"] = {1543, 1, 90} 
maskTable["bloodhokey"] = {1951, 1, 90} 
maskTable["bag"] = {1551, 1, 90} 
maskTable["biomask"] = {1669, 1, 90} 
maskTable["respirator"] = {1854, 1, 90} 


obj = {}
vest = {}

function remove_mask()
	
	if obj[source] then
	exports.bone_attach:detachElementFromBone(obj[source])
	destroyElement(obj[source])
	obj[source] = nil
	end
		
end
addEvent("removemask",true) 
addEventHandler("removemask", root, remove_mask) 

function vest_remove()
	if vest[source] then
	exports.bone_attach:detachElementFromBone(vest[source])
	destroyElement(vest[source])
	vest[source] = nil
	end
end
addEvent("removevest",true) 
addEventHandler("removevest", root, vest_remove)

function clearPedAccessories ()
	if source and getElementType(source)== "ped" then
		if obj[source] then
		exports.bone_attach:detachElementFromBone(obj[source])
		destroyElement(obj[source])
		obj[source] = nil
		end
		if vest[source] then
		exports.bone_attach:detachElementFromBone(vest[source])
		destroyElement(vest[source])
		--iprint("destroyed: "..dest)
		vest[source] = nil
		end
	end
end

addEventHandler("onElementDestroy",root,clearPedAccessories)
--addEventHandler("onPedWasted",root,clearPedAccessories)

function mask_add(name)
if name == "none" then return end
		if obj[source] then
			destroyElement(obj[source])
		end
		
		local objeid = maskTable[name][1]
		local bodyattach = maskTable[name][2]
		local zROT = maskTable[name][3]
		obj[source] = createObject ( objeid, 0, 0, 0, 0, 0, 0 )
		exports.bone_attach:attachElementToBone(obj[source],source,bodyattach,0,0,-0.61,0,0,zROT) 

end 
addEvent("setmask",true) 
addEventHandler("setmask", root, mask_add) 

function vest_add(name)
if name == "none" then return end
		if vest[source] then
		destroyElement(vest[source])
		vest[source] = nil
		end
local objeid = vestTable[name][1]
local bodyattach = vestTable[name][2]
local zROT = vestTable[name][3]
vest[source] = createObject ( objeid, 0, 0, 0, 0, 0, 0 )
exports.bone_attach:attachElementToBone(vest[source],source,3,-0.03,0,-0.55,-0.5,2,90)
 
--if getElementType(source)== "ped" then setPedArmor(source,50) end

end

addEvent("setvest",true) 
addEventHandler("setvest", root, vest_add) 

addCommandHandler("vest",vest_add)
addCommandHandler("mask",mask_add)


function quitPlayer (  )
			if obj[source] then
		destroyElement(obj[source])
		end			
		if vest[source] then
		destroyElement(vest[source])
		end
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )