removeWorldModel(16094,120.46474,191.14063,1870.0391,21.47656)

col_floors = engineLoadCOL ( "objects/a51fencing.col" )
engineReplaceCOL ( col_floors, 16094 )
txd_floors = engineLoadTXD ( "objects/a51fencing.txd" )
engineImportTXD ( txd_floors, 16094 )
dff_floors = engineLoadDFF ( "objects/a51fencing.dff", 0 )
engineReplaceModel ( dff_floors, 16094 )

col_floors = engineLoadCOL ( "objects/a51fensin.col" )
engineReplaceCOL ( col_floors, 974 )
txd_floors = engineLoadTXD ( "objects/a51fencing.txd" )
engineImportTXD ( txd_floors, 974 )
dff_floors = engineLoadDFF ( "objects/a51fensin.dff", 0 )
engineReplaceModel ( dff_floors, 974 )

