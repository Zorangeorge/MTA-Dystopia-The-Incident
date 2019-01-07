maskTable = {}   
vestTable = {} 

vestTable["khakivest"] = {1922, 1, 90} 
vestTable["estabvest"] = {1923, 1, 90} 
vestTable["blackvest"] = {1924, 1, 90} 


maskTable["devil"] = {1512, 1, 90} 
maskTable["vendetta"] = {1455, 1, 90} 
maskTable["darth"] = {1484, 1, 90} 
maskTable["redberet"] = {1485, 1, 90} 
maskTable["gasmask"] = {1487, 1, 90} 
maskTable["cowboy"] = {1543, 1, 90} 
maskTable["zombie"] = {1544, 1, 90} 
maskTable["vampire"] = {1666, 1, 90} 
maskTable["skull"] = {1667, 1, 90} 
maskTable["raccoon"] = {1668, 1, 180} 
maskTable["owl"] = {1950, 1, 180} 
maskTable["bloodhokey"] = {1951, 1, 180} 
maskTable["bag"] = {1551, 1, 90} 
maskTable["dog"] = {1546, 1, 90} 
maskTable["biomask"] = {1669, 1, 90} 
maskTable["monster"] = {1853, 1, 90} 
maskTable["respirator"] = {1854, 1, 90} 
maskTable["admin"] = {1855, 1, 90} 

mask = {}
vest = {}
obj = {}

function importqqqures2()
		
	mask_guyfawkes_txd = engineLoadTXD ( "object/mask_guyfawkes.txd" ) 
	engineImportTXD ( mask_guyfawkes_txd, 1455 )
	mask_guyfawkes_dff = engineLoadDFF ( "object/mask_guyfawkes.dff", 0 )
	engineReplaceModel ( mask_guyfawkes_dff, 1455 )
	engineSetModelLODDistance(1455, 2000)
	
	hat_cowboy_txd = engineLoadTXD ( "object/hat_cowboy.txd" ) 
	engineImportTXD ( hat_cowboy_txd, 1543 )
	hat_cowboy_dff = engineLoadDFF ( "object/hat_cowboy.dff", 0 )
	engineReplaceModel ( hat_cowboy_dff, 1543 )
	engineSetModelLODDistance(1543, 2000)
	
	mask_bloodhokey_txd = engineLoadTXD ( "object/mask_bloodhokey.txd" ) 
	engineImportTXD ( mask_bloodhokey_txd, 1951 )
	mask_bloodhokey_dff = engineLoadDFF ( "object/mask_bloodhokey.dff", 0 )
	engineReplaceModel ( mask_bloodhokey_dff, 1951 )
	engineSetModelLODDistance(1951, 2000)		
	
	mask_bag_txd = engineLoadTXD ( "object/mask_bag.txd" ) 
	engineImportTXD ( mask_bag_txd, 1551 )
	mask_bag_dff = engineLoadDFF ( "object/mask_bag.dff", 0 )
	engineReplaceModel ( mask_bag_dff, 1551 )
	engineSetModelLODDistance(1551, 2000)	

	gasmask1_txd = engineLoadTXD ( "object/gasmask1.txd" ) 
	engineImportTXD ( gasmask1_txd, 1669 )
	gasmask1_dff = engineLoadDFF ( "object/gasmask1.dff", 0 )
	engineReplaceModel ( gasmask1_dff, 1669 )
	engineSetModelLODDistance(1669, 2000)	
	
	gasmask2_txd = engineLoadTXD ( "object/gasmask2.txd" ) 
	engineImportTXD ( gasmask2_txd, 1487 )
	gasmask2_dff = engineLoadDFF ( "object/gasmask2.dff", 0 )
	engineReplaceModel ( gasmask2_dff, 1487 )
	engineSetModelLODDistance(1487, 2000)
	
	hat_airborne_txd = engineLoadTXD ( "object/gasmask3.txd" ) 
	engineImportTXD ( hat_airborne_txd, 1854 )
	hat_airborne_dff = engineLoadDFF ( "object/gasmask3.dff", 0 ) 
	engineReplaceModel ( hat_airborne_dff, 1854 )
	engineSetModelLODDistance(1854, 2000)
	
	vest1_txd = engineLoadTXD ( "object/vest1.txd" ) 
	engineImportTXD ( vest1_txd, 1922 )
	vest1_dff = engineLoadDFF ( "object/vest1.dff", 0 )
	engineReplaceModel ( vest1_dff, 1922 )
	engineSetModelLODDistance(1922, 2000)
	
	vest2_txd = engineLoadTXD ( "object/vest2.txd" ) 
	engineImportTXD ( vest2_txd, 1923 )
	vest2_dff = engineLoadDFF ( "object/vest2.dff", 0 )
	engineReplaceModel ( vest2_dff, 1923 )
	engineSetModelLODDistance(1923, 2000)
	
	vest3_txd = engineLoadTXD ( "object/vest3.txd" ) 
	engineImportTXD ( vest3_txd, 1924 )
	vest3_dff = engineLoadDFF ( "object/vest3.dff", 0 )
	engineReplaceModel ( vest3_dff, 1924 )
	engineSetModelLODDistance(1924, 2000)

end

setTimer ( importqqqures2, 1000, 1)

addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()),
	function()

		
		engineRestoreModel(1669)
		destroyElement(gasmask2_txd)
		destroyElement(gasmask2_dff)
		
		engineRestoreModel(1551)
		destroyElement(mask_bag_txd)
		destroyElement(mask_bag_dff)	
		
		engineRestoreModel(1924)
		destroyElement(vest3_txd)
		destroyElement(vest3_dff)	
		
		engineRestoreModel(1923)
		destroyElement(vest2_txd)
		destroyElement(vest2_dff)	
		
		engineRestoreModel(1922)
		destroyElement(vest1_txd)
		destroyElement(vest1_dff)		
		
		engineRestoreModel(1951)
		destroyElement(mask_bloodhokey_txd)
		destroyElement(mask_bloodhokey_dff)	
		
		engineRestoreModel(1455)
		destroyElement(mask_guyfawkes_txd)
		destroyElement(mask_guyfawkes_dff)
		
		engineRestoreModel(1485)
		destroyElement(mask_terrorist_txd)
		destroyElement(mask_terrorist_dff)
		
		engineRestoreModel(1487)
		destroyElement(gasmask1_txd)
		destroyElement(gasmask1_dff)		
		
		engineRestoreModel(1543)
		destroyElement(hat_cowboy_txd)
		destroyElement(hat_cowboy_dff)		
		
	end
)

function table.random ( theTable )
    return theTable[math.random ( #theTable )]
end

local gasmasks_tbl = {"none","gasmask","respirator","biomask"}
--local trooperhead_tbl = {"respirator"}
local civvests_tbl = {"none","khakivest","blackvest"}
local raiderhead_tbl = {"none","gasmask","respirator","biomask","bloodhokey"}
local militiahead_tbl = {"none","respirator","biomask","cowboy","gasmask"}
local nomadhead_tbl = {"none","gasmask","respirator","biomask","bag"}
local bandithead_tbl = {"none","gasmask","respirator","biomask","cowboy"}
local heavytrooperhead_tbl = {"none","cowboy","respirator","biomask"}

--[[function rigPeacekeepers ()
local peds = getElementsByType("ped")
	for _,ped in ipairs(peds) do
	local name = getElementData(ped,"name")
		if name == "Trooper" then
			triggerServerEvent( "setmask", ped, table.random(trooperhead_tbl) )
			triggerServerEvent( "setvest", ped, "khakivest")
		elseif name == "Peacekeeper" then
			triggerServerEvent( "setmask", ped, table.random(gasmasks_tbl) )
			triggerServerEvent( "setvest", ped, "estabvest")
		elseif name == "Heavy Trooper" then
			triggerServerEvent( "setvest", ped, "estabvest")
			triggerServerEvent( "setmask", ped, table.random(heavytrooperhead_tbl) )
		elseif name == "R/01 Spec" then
			triggerServerEvent( "setvest", ped, "estabvest")
			triggerServerEvent( "setmask", ped, "biomask" )
		elseif name == "R/01 Agent" then
			triggerServerEvent( "setvest", ped, "estabvest")
			triggerServerEvent( "setmask", ped, "biomask" )
		elseif name == "R/01 Operator" then
			triggerServerEvent( "setvest", ped, "estabvest")
			triggerServerEvent( "setmask", ped, "biomask" )
		elseif name == "Raider" then
			triggerServerEvent( "setmask", ped, table.random(raiderhead_tbl) )
			triggerServerEvent( "setvest", ped, table.random(civvests_tbl) )
		elseif name == "Nomad" then
			triggerServerEvent( "setmask", ped, table.random(nomadhead_tbl) )
			triggerServerEvent( "setvest", ped, table.random(civvests_tbl) )
		elseif name == "Militia" then
			triggerServerEvent( "setmask", ped, table.random(militiahead_tbl) )
			triggerServerEvent( "setvest", ped, table.random(civvests_tbl) )
		end
	end
end

addCommandHandler("rig",rigPeacekeepers)]]

addEvent("PropPed",true)
pedPropsEnabled = true
addCommandHandler("pedprops",function() pedPropsEnabled = not pedPropsEnabled; outputDebugString(tostring(pedPropsEnabled))end)
function addPropsToPed (ped)

if pedPropsEnabled then 

	local rand1 = math.random(0,1)
	local rand2 = math.random(0,1)
	local rand3 = math.random(0,1)

	local name = getElementData(ped,"name")

		if name == "Trooper" then
			if rand1>0 then
			triggerServerEvent( "setvest", ped, "khakivest")
			end
		elseif name == "Peacekeeper" then
			if rand1>0 then
			triggerServerEvent( "setmask", ped, table.random(gasmasks_tbl) )
			end
			triggerServerEvent( "setvest", ped, "estabvest")
		elseif name == "Heavy Trooper" then
			triggerServerEvent( "setvest", ped, "khakivest")
			if rand1>0 then
				local mask = table.random(heavytrooperhead_tbl)
			triggerServerEvent( "setmask", ped, mask )
			end
		elseif name == "R/01 Spec" then
			triggerServerEvent( "setvest", ped, "estabvest")
			if rand1>0 then
			triggerServerEvent( "setmask", ped, "biomask" )
			end
		elseif name == "R/01 Agent" then
			if rand1>0 then
			triggerServerEvent( "setvest", ped, "estabvest")
			end
			if rand2>0 then
			triggerServerEvent( "setmask", ped, "biomask" )
			end
		elseif name == "R/01 Operator" then
			triggerServerEvent( "setvest", ped, "estabvest")
			if rand1>0 then
			triggerServerEvent( "setmask", ped, "biomask" )	
			end
		elseif name == "R/01 Grunt" then
			if rand1>0 then
			triggerServerEvent( "setvest", ped, "estabvest")
			end
			if rand2>0 then
			triggerServerEvent( "setmask", ped, "biomask" )
			end
		elseif name == "Raider Barker" or name == "Raider Mongrel" then
			if rand1>0 then
				local mask = table.random(raiderhead_tbl)
				if mask ~= "none" then 
					triggerServerEvent( "setmask", ped, mask )
					setElementData(ped,"name","Raider Hound",true)
					setElementHealth(ped,130)
				end
			end
			if rand2>0 then
				local vest = table.random(civvests_tbl)
				if vest ~= "none" then 
				triggerServerEvent( "setvest", ped, vest )
				setElementData(ped,"name","Raider Pitdog",true)
				setElementHealth(ped,160)
				end
			end
		elseif name == "Nomad" or name == "Thug" or name == "Robber" then
			if rand1>0 then
				triggerServerEvent( "setmask", ped, table.random(nomadhead_tbl) )
			end
			if rand2>0 then
				triggerServerEvent( "setvest", ped, table.random(civvests_tbl) )
			end
		elseif name == "Bandit" then
			if rand1>0 then
					local mask = table.random(raiderhead_tbl)
					if mask ~= "none" then 
						triggerServerEvent( "setmask", ped, mask )
						--setElementData(ped,"name","Bandit Heavy",true)
						setElementHealth(ped,130)
					end
			end
			if rand2>0 then
					local vest = table.random(civvests_tbl)
					if vest ~= "none" then 
						triggerServerEvent( "setvest", ped, vest )
						setElementData(ped,"name","Bandit Veteran",true)
						setElementHealth(ped,160)
					end
			end
		elseif name == "Militia" then
			if rand1>0 then
				triggerServerEvent( "setmask", ped, table.random(militiahead_tbl) )
			end
			if rand2>0 then
					local vest = table.random(civvests_tbl)
					if vest ~= "none" then
						triggerServerEvent( "setvest", ped, vest )
						setElementData(ped,"name","Militia Ranger",true)
						setElementHealth(ped,180)
					end
			end
		elseif name == "Guard" or name == "Scavenger" then
			if rand1>0 then
				triggerServerEvent( "setvest", ped, table.random(civvests_tbl) )
			end
		elseif name == "Wastelander" then
			if rand1>0 then
				triggerServerEvent( "setmask", ped, "cowboy" )
				triggerServerEvent( "setvest", ped, table.random(civvests_tbl) )
			end
		end
	end
end

addEventHandler("PropPed",root,addPropsToPed)