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
		
		engineRestoreModel(1854)
		destroyElement(hat_airborne_txd)
		destroyElement(hat_airborne_dff)
		
		engineRestoreModel(1487)
		destroyElement(gasmask1_txd)
		destroyElement(gasmask1_dff)		
		
		engineRestoreModel(1543)
		destroyElement(hat_cowboy_txd)
		destroyElement(hat_cowboy_dff)		
	end
)