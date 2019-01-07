  
 function replaceModel()
   local col = engineLoadCOL ( "data/hubprops6_SFSe.col" )
   engineReplaceCOL ( col, 11391 )
   local col = engineLoadCOL ( "data/hubprops1_SFS.col")
   engineReplaceCOL ( col, 11393 )
   local txd = engineLoadTXD ( "data/oldgarage_sfse.txd")
   engineImportTXD ( txd, 11387 )
 end
 addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()),
     function()
         replaceModel()
         setTimer (replaceModel, 1000, 1)
     end
)

-- Col dont load? use this command =)
addCommandHandler("reloadmod", replaceModel)