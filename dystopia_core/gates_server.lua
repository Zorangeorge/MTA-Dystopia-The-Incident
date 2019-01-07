--[[function StartResource()
outputChatBox("http://Rick - Load new gate.")
end
StartResource()]]

GateA51_Back = createObject ( 974, 286, 1821.3, 19.9, 0, 0, 89.5 ) --a51 back
GateA51_Front = createObject ( 974, 134.2, 1942.2, 21.6, 0, 0, 180 ) --a51 front
GateA51_Under_Left = createObject ( 2929, 215.8, 1875.8, 13.9, 0, 0, 180 ) --a51 under 
GateA51_Under_Right = createObject ( 2927, 211.8, 1875.8, 13.9, 0, 0, 180.25 )--a51 under
Gate_Reffinery = createObject ( 2933, 287.6, 1412, 11.3, 0, 0, 90 ) --reffinery
Gate_ArcoOeste = createObject ( 988,-809, 2371.9, 151.60000610352, 0, 2.5, 2.25 ) 
Gate_RefCampPeacekeeperHut = createObject (2930,270.89,2022.09,19.5,0,0,0 )
Gate_CranberryStation = createObject(989,-1961.5,148.69999694824,28.39999961853,0,0,196.74865722656) 
Gate_ChinaStreet = createObject(3036,-2241.1999511719,645.59997558594,50.200000762939,0,0,270) 
Gate_ChinaMarket = createObject(3036,-2209.5,624.7998046875,50.099998474121,0,0,0) 
Gate_ChinaInner = createObject(969,-2174.6000976563,661.29998779297,48.599998474121,0,0,180) 
Gate_BoatTown = createObject(980,-1389.2998046875,1539.099609375,2.2000000476837,0,0,270) 
Gate_Bayview = createObject(971, -2616.5,2275.8999023438,9.6000003814697,0,0,180.25) 
Gate_Junkyard = createObject(971, -1935.2998046875,-1774.2001953125,29.200000762939,0,0,341.74072265625) 
Gate_JunkyardRoad = createObject(2933,-1906.5,-1778.5,31.60000038147,0,270.24169921875,301.99768066406) 
Gate_ShadyCreek = createObject(2930,-1638.3000488281,-2238.5,33.099998474121,0,0,3) 
Gate_Carnival = createObject(2933,372.29998779297,-1973.6999511719,8.3999996185303,0,0,182) 
Gate_RanchFront = createObject(969,-716.79998779297,964,11.300000190735,0,0,87.494995117188)
Gate_RanchBack = createObject(969,-665.69921875,929.69921875,11.199999809265,0,0,270)
Gate_PalominoCreek = createObject(2930,2320.1000976563,80.900001525879,28.799999237061,0,0,89.245361328125) 
Gate_PalominoCreekBank = createObject(2930,2314.7998046875,0.7998046875,27.89999961853,0,0,88.997802734375) 
Gate_Panopticon = createObject(988,-540.5,-190.10000610352,78.400001525879,0,0,86.25) 
Gate_Refugee = createObject(971,344.89999389648,1798,17.200000762939,0,0,35.996704101563) 

setElementDoubleSided(GateA51_Back,true)
setElementDoubleSided(GateA51_Front,true)
setObjectScale(Gate_PalominoCreek,1.24)
setObjectScale(Gate_Refugee,1.2)
setObjectScale(Gate_JunkyardRoad,1.4)
setObjectScale(Gate_ChinaMarket,1.2)

createObject ( 989, 75.5, 1917.2, 18.5, 0, 0, 225.75 )
createObject ( 3095, 268.89999, 1884.4, 16 )
createObject(16094,191.10001,1870.6,21.5)
createObject ( 3881, 93.3, 1924.6, 18.9, 0, 0, 90.995 )
createObject ( 1671, 94.9, 1923.69995, 17.6 )
createObject ( 1411, 81.5, 1921.8, 18.3, 0, 0, 187.999 )
createObject ( 1411, 86.6, 1922.2, 18.4, 0, 0, 183.999 )
createObject ( 1411, 76.7, 1920.3, 18.2, 0, 0, 207.998 )
createObject ( 1411, 89.3, 1918.6, 18.5, 0, 0, 15.988 )
createObject ( 1411, 94.4, 1919.3, 18.7, 0, 0, 1.488 )
createObject ( 1411, 84.3, 1917.2, 18.3, 0, 0, 17.984 )
createObject ( 1411, 79.3, 1915.7, 18.2, 0, 0, 17.979 )

GateBack_ColShape = createColSphere ( 285.9150390625, 1820.796875, 17.640625,7 )
GateFront_ColShape = createColSphere ( 135.173828125, 1941.744140625, 19.303453445435,7 )
UnderCover_ColShape = createColSphere ( 213.962890625, 1875.6376953125, 8.14695930481, 7 )	
Gate_Reffinery_ColShape = createColSphere ( 287.599609375, 1412, 10,7 )
Gate_ArcoOeste_Col = createColSphere ( -809, 2371.9, 150,7 )	
Gate_RefCampPeacekeeperHut_Col = createColSphere(270.89,2022.09,18.5,2.5)
Gate_CranberryStation_Col = createColSphere(-1961.5,148.69999694824,28.39999961853,3.5)
Gate_ChinaStreet_Col = createColSphere(-2241.1999511719,645.59997558594,49.200000762939,7)
Gate_ChinaMarket_Col = createColSphere(-2210.5,624.7998046875,49.099998474121,7)
Gate_ChinaInner_Col = createColSphere(-2174.6000976563,661.29998779297,47.599998474121,7)
Gate_BoatTown_Col = createColSphere(-1389.2998046875,1539.099609375,0.2000000476837,7)
Gate_Bayview_Col = createColSphere(-2616.5,2275.8999023438,8.6000003814697,7)
Gate_Junkyard_Col = createColSphere(-1935.2998046875,-1774.2001953125,29.200000762939,7)
Gate_JunkyardRoad_Col = createColSphere(-1906.5,-1778.5,28.60000038147,7)
Gate_ShadyCreek_Col = createColSphere(-1638.3000488281,-2238.5,32.099998474121,2.5)
Gate_Carnival_Col = createColSphere(372.29998779297,-1973.6999511719,6.3999996185303,6)
Gate_RanchFront_Col = createColSphere(-716.79998779297,964,10.300000190735,7)
Gate_RanchBack_Col = createColSphere(-665.69921875,929.69921875,10.199999809265,7)
Gate_PalominoCreek_Col = createColSphere(2320.1000976563,80.900001525879,27.799999237061,2.5)
Gate_PalominoCreekBank_Col = createColSphere(2314.7998046875,0.7998046875,26.89999961853,2.5)
Gate_Panopticon_Col = createColSphere(-540.5,-190.10000610352,77.400001525879,7)
Gate_Refugee_Col = createColSphere(344.89999389648,1798,16.200000762939,7)


function Toggle_Gate_Refugee(toggle,time)
local x,y,z = 344.89999389648,1798,17.200000762939
local x1,y1,z1 =  353.29998779297,1804,17.200000762939
if toggle == true and getElementData(Gate_Refugee,"Gate:Animation") == false then
setElementData(Gate_Refugee,"Gate:Animation",true)
moveObject(Gate_Refugee,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_Refugee,"Gate:Animation")
setTimer ( Toggle_Gate_Refugee, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_Refugee,"Gate:Animation") == false then
setElementData(Gate_Refugee,"Gate:Animation",true)
moveObject(Gate_Refugee,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_Refugee,"Gate:Animation")
end
end	

function Gate_Refugee_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_Refugee(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_Refugee_Col,Gate_Refugee_ColShapeEnter)

function Gate_Refugee_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_Refugee(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_Refugee_Col,Gate_Refugee_ColShape_Leave)


function Toggle_Gate_Panopticon(toggle,time)
local x,y,z = -540.5,-190.10000610352,78.400001525879
local x1,y1,z1 =  -540.5,-190.10000610352,81.599998474121
if toggle == true and getElementData(Gate_Panopticon,"Gate:Animation") == false then
setElementData(Gate_Panopticon,"Gate:Animation",true)
moveObject(Gate_Panopticon,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_Panopticon,"Gate:Animation")
setTimer ( Toggle_Gate_Panopticon, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_Panopticon,"Gate:Animation") == false then
setElementData(Gate_Panopticon,"Gate:Animation",true)
moveObject(Gate_Panopticon,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_Panopticon,"Gate:Animation")
end
end	

function Gate_Panopticon_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_Panopticon(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_Panopticon_Col,Gate_Panopticon_ColShapeEnter)

function Gate_Panopticon_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_Panopticon(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_Panopticon_Col,Gate_Panopticon_ColShape_Leave)

function Toggle_Gate_PalominoCreekBank(toggle,time)
local x,y,z = 2314.7998046875,0.7998046875,27.89999961853
local x1,y1,z1 =  2316.7998046875, 0.7998046875, 27.89999961853
if toggle == true and getElementData(Gate_PalominoCreekBank,"Gate:Animation") == false then
setElementData(Gate_PalominoCreekBank,"Gate:Animation",true)
moveObject(Gate_PalominoCreekBank,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_PalominoCreekBank,"Gate:Animation")
setTimer ( Toggle_Gate_PalominoCreekBank, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_PalominoCreekBank,"Gate:Animation") == false then
setElementData(Gate_PalominoCreekBank,"Gate:Animation",true)
moveObject(Gate_PalominoCreekBank,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_PalominoCreekBank,"Gate:Animation")
end
end	

function Gate_PalominoCreekBank_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_PalominoCreekBank(true,3000)
    end
end
addEventHandler("onColShapeHit",Gate_PalominoCreekBank_Col,Gate_PalominoCreekBank_ColShapeEnter)

function Gate_PalominoCreekBank_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_PalominoCreekBank(false,3000)
    end
end
addEventHandler("onColShapeLeave",Gate_PalominoCreekBank_Col,Gate_PalominoCreekBank_ColShape_Leave)

function Toggle_Gate_PalominoCreek(toggle,time)
local x,y,z = 2320.1000976563,80.900001525879,28.799999237061
local x1,y1,z1 =  2322.1999511719,80.900001525879,28.799999237061
if toggle == true and getElementData(Gate_PalominoCreek,"Gate:Animation") == false then
setElementData(Gate_PalominoCreek,"Gate:Animation",true)
moveObject(Gate_PalominoCreek,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_PalominoCreek,"Gate:Animation")
setTimer ( Toggle_Gate_PalominoCreek, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_PalominoCreek,"Gate:Animation") == false then
setElementData(Gate_PalominoCreek,"Gate:Animation",true)
moveObject(Gate_PalominoCreek,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_PalominoCreek,"Gate:Animation")
end
end	

function Gate_PalominoCreek_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_PalominoCreek(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_PalominoCreek_Col,Gate_PalominoCreek_ColShapeEnter)

function Gate_PalominoCreek_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_PalominoCreek(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_PalominoCreek_Col,Gate_PalominoCreek_ColShape_Leave)

function Toggle_Gate_RanchBack(toggle,time)
local x,y,z = -665.69921875,929.69921875,11.199999809265
local x1,y1,z1 = -665.70001220703,934,11.199999809265
if toggle == true and getElementData(Gate_RanchBack,"Gate:Animation") == false then
setElementData(Gate_RanchBack,"Gate:Animation",true)
moveObject(Gate_RanchBack,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_RanchBack,"Gate:Animation")
setTimer ( Toggle_Gate_RanchBack, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_RanchBack,"Gate:Animation") == false then
setElementData(Gate_RanchBack,"Gate:Animation",true)
moveObject(Gate_RanchBack,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_RanchBack,"Gate:Animation")
end
end	

function Gate_RanchBack_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_RanchBack(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_RanchBack_Col,Gate_RanchBack_ColShapeEnter)

function Gate_RanchBack_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_RanchBack(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_RanchBack_Col,Gate_RanchBack_ColShape_Leave)

function Toggle_Gate_RanchFront(toggle,time)
local x,y,z = -716.79998779297,964,11.300000190735
local x1,y1,z1 = -717.09997558594,958.20001220703,11.300000190735
if toggle == true and getElementData(Gate_RanchFront,"Gate:Animation") == false then
setElementData(Gate_RanchFront,"Gate:Animation",true)
moveObject(Gate_RanchFront,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_RanchFront,"Gate:Animation")
setTimer ( Toggle_Gate_RanchFront, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_RanchFront,"Gate:Animation") == false then
setElementData(Gate_RanchFront,"Gate:Animation",true)
moveObject(Gate_RanchFront,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_RanchFront,"Gate:Animation")
end
end	

function Gate_RanchFront_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_RanchFront(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_RanchFront_Col,Gate_RanchFront_ColShapeEnter)

function Gate_RanchFront_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_RanchFront(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_RanchFront_Col,Gate_RanchFront_ColShape_Leave)

function Toggle_Gate_Carnival(toggle,time)
local x,y,z = 372.29998779297,-1973.6999511719,8.3999996185303
local x1,y1,z1 = 375.39999389648,-1973.8000488281,8.3999996185303
if toggle == true and getElementData(Gate_Carnival,"Gate:Animation") == false then
setElementData(Gate_Carnival,"Gate:Animation",true)
moveObject(Gate_Carnival,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_Carnival,"Gate:Animation")
setTimer ( Toggle_Gate_Carnival, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_Carnival,"Gate:Animation") == false then
setElementData(Gate_Carnival,"Gate:Animation",true)
moveObject(Gate_Carnival,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_Carnival,"Gate:Animation")
end
end	

function Gate_Carnival_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_Carnival(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_Carnival_Col,Gate_Carnival_ColShapeEnter)

function Gate_Carnival_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_Carnival(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_Carnival_Col,Gate_Carnival_ColShape_Leave)

function Toggle_Gate_ShadyCreek(toggle,time)
local x,y,z = -1638.3000488281,-2238.5,33.099998474121
local x1,y1,z1 = -1638.4000244141,-2236.5,33.099998474121
if toggle == true and getElementData(Gate_ShadyCreek,"Gate:Animation") == false then
setElementData(Gate_ShadyCreek,"Gate:Animation",true)
moveObject(Gate_ShadyCreek,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_ShadyCreek,"Gate:Animation")
setTimer ( Toggle_Gate_ShadyCreek, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_ShadyCreek,"Gate:Animation") == false then
setElementData(Gate_ShadyCreek,"Gate:Animation",true)
moveObject(Gate_ShadyCreek,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_ShadyCreek,"Gate:Animation")
end
end	

function Gate_ShadyCreek_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_ShadyCreek(true,3000)
    end
end
addEventHandler("onColShapeHit",Gate_ShadyCreek_Col,Gate_ShadyCreek_ColShapeEnter)

function Gate_ShadyCreek_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_ShadyCreek(false,3000)
    end
end
addEventHandler("onColShapeLeave",Gate_ShadyCreek_Col,Gate_ShadyCreek_ColShape_Leave)

function Toggle_Gate_JunkyardRoad(toggle,time)
local x,y,z = -1906.5,-1778.5,31.60000038147
local x1,y1,z1 = -1906.5,-1778.5,40.900001525879
if toggle == true and getElementData(Gate_JunkyardRoad,"Gate:Animation") == false then
setElementData(Gate_JunkyardRoad,"Gate:Animation",true)
moveObject(Gate_JunkyardRoad,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_JunkyardRoad,"Gate:Animation")
setTimer ( Toggle_Gate_JunkyardRoad, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_JunkyardRoad,"Gate:Animation") == false then
setElementData(Gate_JunkyardRoad,"Gate:Animation",true)
moveObject(Gate_JunkyardRoad,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_JunkyardRoad,"Gate:Animation")
end
end	

function Gate_JunkyardRoad_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_JunkyardRoad(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_JunkyardRoad_Col,Gate_JunkyardRoad_ColShapeEnter)

function Gate_JunkyardRoad_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_JunkyardRoad(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_JunkyardRoad_Col,Gate_JunkyardRoad_ColShape_Leave)

function Toggle_Gate_Junkyard(toggle,time)
local x,y,z = -1935.2998046875,-1774.2001953125,29.200000762939
local x1,y1,z1 = -1935.2998046875,-1774.2001953125,35.2
if toggle == true and getElementData(Gate_Junkyard,"Gate:Animation") == false then
setElementData(Gate_Junkyard,"Gate:Animation",true)
moveObject(Gate_Junkyard,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_Junkyard,"Gate:Animation")
setTimer ( Toggle_Gate_Junkyard, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_Junkyard,"Gate:Animation") == false then
setElementData(Gate_Junkyard,"Gate:Animation",true)
moveObject(Gate_Junkyard,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_Junkyard,"Gate:Animation")
end
end	

function Gate_Junkyard_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_Junkyard(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_Junkyard_Col,Gate_Junkyard_ColShapeEnter)

function Gate_Junkyard_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_Junkyard(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_Junkyard_Col,Gate_Junkyard_ColShape_Leave)

function Toggle_Gate_Bayview(toggle,time)
local x,y,z = -2616.5,2275.8999023438,9.6000003814697
local x1,y1,z1 = -2607.6999511719, 2275.8999023438, 9.6000003814697
if toggle == true and getElementData(Gate_Bayview,"Gate:Animation") == false then
setElementData(Gate_Bayview,"Gate:Animation",true)
moveObject(Gate_Bayview,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_Bayview,"Gate:Animation")
setTimer ( Toggle_Gate_Bayview, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_Bayview,"Gate:Animation") == false then
setElementData(Gate_Bayview,"Gate:Animation",true)
moveObject(Gate_Bayview,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_Bayview,"Gate:Animation")
end
end	

function Gate_Bayview_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_Bayview(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_Bayview_Col,Gate_Bayview_ColShapeEnter)

function Gate_Bayview_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_Bayview(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_Bayview_Col,Gate_Bayview_ColShape_Leave)

function Toggle_Gate_BoatTown(toggle,time)
local x,y,z = -1389.2998046875,1539.099609375,2.2000000476837
local x1,y1,z1 = -1389.3000488281,1529.5999755859,2.2000000476837
if toggle == true and getElementData(Gate_BoatTown,"Gate:Animation") == false then
setElementData(Gate_BoatTown,"Gate:Animation",true)
moveObject(Gate_BoatTown,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_BoatTown,"Gate:Animation")
setTimer ( Toggle_Gate_BoatTown, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_BoatTown,"Gate:Animation") == false then
setElementData(Gate_BoatTown,"Gate:Animation",true)
moveObject(Gate_BoatTown,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_BoatTown,"Gate:Animation")
end
end	

function Gate_BoatTown_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_BoatTown(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_BoatTown_Col,Gate_BoatTown_ColShapeEnter)

function Gate_BoatTown_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_BoatTown(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_BoatTown_Col,Gate_BoatTown_ColShape_Leave)

function Toggle_Gate_ChinaInner(toggle,time)
local x,y,z = -2174.6000976563,661.29998779297,48.599998474121
local x1,y1,z1 = -2179.1999511719,661.29998779297,48.599998474121
if toggle == true and getElementData(Gate_ChinaInner,"Gate:Animation") == false then
setElementData(Gate_ChinaInner,"Gate:Animation",true)
moveObject(Gate_ChinaInner,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_ChinaInner,"Gate:Animation")
setTimer ( Toggle_Gate_ChinaInner, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_ChinaInner,"Gate:Animation") == false then
setElementData(Gate_ChinaInner,"Gate:Animation",true)
moveObject(Gate_ChinaInner,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_ChinaInner,"Gate:Animation")
end
end	

function Gate_ChinaInner_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_ChinaInner(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_ChinaInner_Col,Gate_ChinaInner_ColShapeEnter)

function Gate_ChinaInner_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_ChinaInner(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_ChinaInner_Col,Gate_ChinaInner_ColShape_Leave)

function Toggle_Gate_ChinaMarket(toggle,time)
local x,y,z = -2210.5,624.7998046875,50.099998474121
local x1,y1,z1 = -2210.5,624.7998046875,54
if toggle == true and getElementData(Gate_ChinaMarket,"Gate:Animation") == false then
setElementData(Gate_ChinaMarket,"Gate:Animation",true)
moveObject(Gate_ChinaMarket,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_ChinaMarket,"Gate:Animation")
setTimer ( Toggle_Gate_ChinaMarket, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_ChinaMarket,"Gate:Animation") == false then
setElementData(Gate_ChinaMarket,"Gate:Animation",true)
moveObject(Gate_ChinaMarket,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_ChinaMarket,"Gate:Animation")
end
end	

function Gate_ChinaMarket_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_ChinaMarket(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_ChinaMarket_Col,Gate_ChinaMarket_ColShapeEnter)

function Gate_ChinaMarket_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_ChinaMarket(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_ChinaMarket_Col,Gate_ChinaMarket_ColShape_Leave)

function Toggle_Gate_ChinaStreet(toggle,time)
local x,y,z = -2241.1999511719,645.59997558594,50.200000762939
local x1,y1,z1 = -2241.1999511719,641.40002441406,50.200000762939
if toggle == true and getElementData(Gate_ChinaStreet,"Gate:Animation") == false then
setElementData(Gate_ChinaStreet,"Gate:Animation",true)
moveObject(Gate_ChinaStreet,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_ChinaStreet,"Gate:Animation")
setTimer ( Toggle_Gate_ChinaStreet, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_ChinaStreet,"Gate:Animation") == false then
setElementData(Gate_ChinaStreet,"Gate:Animation",true)
moveObject(Gate_ChinaStreet,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_ChinaStreet,"Gate:Animation")
end
end	

function Gate_ChinaStreet_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_ChinaStreet(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_ChinaStreet_Col,Gate_ChinaStreet_ColShapeEnter)

function Gate_ChinaStreet_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_ChinaStreet(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_ChinaStreet_Col,Gate_ChinaStreet_ColShape_Leave)

function Toggle_Gate_CranberryStation(toggle,time)
local x,y,z = -1961.5,148.69999694824,28.39999961853
local x1,y1,z1 = -1961.5,144.30000305176,28.39999961853
if toggle == true and getElementData(Gate_CranberryStation,"Gate:Animation") == false then
setElementData(Gate_CranberryStation,"Gate:Animation",true)
moveObject(Gate_CranberryStation,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_CranberryStation,"Gate:Animation")
setTimer ( Toggle_Gate_CranberryStation, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_CranberryStation,"Gate:Animation") == false then
setElementData(Gate_CranberryStation,"Gate:Animation",true)
moveObject(Gate_CranberryStation,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_CranberryStation,"Gate:Animation")
end
end	

function Gate_CranberryStation_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_CranberryStation(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_CranberryStation_Col,Gate_CranberryStation_ColShapeEnter)

function Gate_CranberryStation_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_CranberryStation(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_CranberryStation_Col,Gate_CranberryStation_ColShape_Leave)

function Toggle_Gate_RefCampPeacekeeperHut(toggle,time)
local x,y,z = 270.89,2022.09,19.5
local x1,y1,z1 = 270.9, 2023, 19.5
if toggle == true and getElementData(Gate_RefCampPeacekeeperHut,"Gate:Animation") == false then
setElementData(Gate_RefCampPeacekeeperHut,"Gate:Animation",true)
moveObject(Gate_RefCampPeacekeeperHut,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_RefCampPeacekeeperHut,"Gate:Animation")
setTimer ( Toggle_Gate_RefCampPeacekeeperHut, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_RefCampPeacekeeperHut,"Gate:Animation") == false then
setElementData(Gate_RefCampPeacekeeperHut,"Gate:Animation",true)
moveObject(Gate_RefCampPeacekeeperHut,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_RefCampPeacekeeperHut,"Gate:Animation")
end
end	

function Gate_RefCampPeacekeeperHut_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_RefCampPeacekeeperHut(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_RefCampPeacekeeperHut_Col,Gate_RefCampPeacekeeperHut_ColShapeEnter)

function Gate_RefCampPeacekeeperHut_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_RefCampPeacekeeperHut(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_RefCampPeacekeeperHut_Col,Gate_RefCampPeacekeeperHut_ColShape_Leave)

function Toggle_Gate_ArcoOeste(toggle,time)
local x,y,z = -809, 2371.9, 151.6
local x1,y1,z1 = -809,2371.9,155
if toggle == true and getElementData(Gate_ArcoOeste,"Gate:Animation") == false then
setElementData(Gate_ArcoOeste,"Gate:Animation",true)
moveObject(Gate_ArcoOeste,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_ArcoOeste,"Gate:Animation")
setTimer ( Toggle_Gate_ArcoOeste, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_ArcoOeste,"Gate:Animation") == false then
setElementData(Gate_ArcoOeste,"Gate:Animation",true)
moveObject(Gate_ArcoOeste,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_ArcoOeste,"Gate:Animation")
end
end	

function Gate_ArcoOeste_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_ArcoOeste(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_ArcoOeste_Col,Gate_ArcoOeste_ColShapeEnter)

function Gate_ArcoOeste_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_ArcoOeste(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_ArcoOeste_Col,Gate_ArcoOeste_ColShape_Leave)	

function Toggle_Gate_Reffinery(toggle,time)
local x,y,z = 287.6, 1412, 11.3
local x1,y1,z1 = 287.6,1403.9,11.3
if toggle == true and getElementData(Gate_Reffinery,"Gate:Animation") == false then
setElementData(Gate_Reffinery,"Gate:Animation",true)
moveObject(Gate_Reffinery,time,x1,y1,z1)
setTimer ( removeElementData, time, 1,Gate_Reffinery,"Gate:Animation")
setTimer ( Toggle_Gate_Reffinery, time+1000, 1,false,time )
elseif toggle == false and getElementData(Gate_Reffinery,"Gate:Animation") == false then
setElementData(Gate_Reffinery,"Gate:Animation",true)
moveObject(Gate_Reffinery,time,x,y,z)
setTimer ( removeElementData, time, 1,Gate_Reffinery,"Gate:Animation")
end
end	

function Gate_Reffinery_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_Gate_Reffinery(true,5000)
    end
end
addEventHandler("onColShapeHit",Gate_Reffinery_ColShape,Gate_Reffinery_ColShapeEnter)

function Gate_Reffinery_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_Gate_Reffinery(false,5000)
    end
end
addEventHandler("onColShapeLeave",Gate_Reffinery_ColShape,Gate_Reffinery_ColShape_Leave)	
	
function Toggle_GateBack(toggle,time)
local x,y,z = 286, 1821.3, 19.9
if toggle == true and getElementData(GateA51_Back,"Gate:Animation") == false then
setElementData(GateA51_Back,"Gate:Animation",true)
moveObject(GateA51_Back,time,x,y+12.5,z)
setTimer ( removeElementData, time, 1,GateA51_Back,"Gate:Animation")
setTimer ( Toggle_GateBack, time+1000, 1,false,time )
elseif toggle == false and getElementData(GateA51_Back,"Gate:Animation") == false then
setElementData(GateA51_Back,"Gate:Animation",true)
moveObject(GateA51_Back,time,x,y,z)
setTimer ( removeElementData, time, 1,GateA51_Back,"Gate:Animation")
end
end	
	
function GateBack_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_GateBack(true,5000)
    end
end
addEventHandler("onColShapeHit",GateBack_ColShape,GateBack_ColShapeEnter)

function GateBack_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_GateBack(false,5000)
    end
end
addEventHandler("onColShapeLeave",GateBack_ColShape,GateBack_ColShape_Leave)

function Toggle_GateFront(toggle,time)
local x,y,z = 134.2, 1942.2, 21.6
if toggle == true and getElementData(GateA51_Front,"Gate:Animation") == false then
setElementData(GateA51_Front,"Gate:Animation",true)
moveObject(GateA51_Front,time,x-12.5,y,z)
setTimer ( removeElementData, time, 1,GateA51_Front,"Gate:Animation")
setTimer ( Toggle_GateFront, time+1000, 1,false,time )
elseif toggle == false and getElementData(GateA51_Front,"Gate:Animation") == false then
setElementData(GateA51_Front,"Gate:Animation",true)
moveObject(GateA51_Front,time,x,y,z)
setTimer ( removeElementData, time, 1,GateA51_Front,"Gate:Animation")
end
end	
	
function GateFront_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_GateFront(true,5000)
    end
end
addEventHandler("onColShapeHit",GateFront_ColShape,GateFront_ColShapeEnter)

function GateFront_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_GateFront(false,5000)
    end
end
addEventHandler("onColShapeLeave",GateFront_ColShape,GateFront_ColShape_Leave)

function Toggle_UnderCoverGate(toggle,time)
local x,y,z = 215.8, 1875.8, 13.9
local x2,y2,z2 = 211.8, 1875.8, 13.9
if toggle == true and getElementData(GateA51_Under_Left,"Gate:Animation") == false then
setElementData(GateA51_Under_Left,"Gate:Animation",true)
moveObject(GateA51_Under_Left,time,x+3.2,y,z)
moveObject(GateA51_Under_Right,time,x2-3,y2,z2)
setTimer ( removeElementData, time, 1,GateA51_Under_Left,"Gate:Animation")
setTimer ( Toggle_UnderCoverGate, time+1000, 1,false,time )
elseif toggle == false and getElementData(GateA51_Under_Left,"Gate:Animation") == false then
setElementData(GateA51_Under_Left,"Gate:Animation",true)
moveObject(GateA51_Under_Left,time,x,y,z)
moveObject(GateA51_Under_Right,time,x2,y2,z2)
setTimer ( removeElementData, time, 1,GateA51_Under_Left,"Gate:Animation")
end
end
	
function UnderCover_ColShapeEnter( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then  
	Toggle_UnderCoverGate(true,5000)
 end
end
addEventHandler("onColShapeHit",UnderCover_ColShape,UnderCover_ColShapeEnter)

function UnderCover_ColShape_Leave( theElement, matchingDimension )
 if getElementType ( theElement ) == "player" then
	Toggle_UnderCoverGate(false,5000)
 end
end
addEventHandler("onColShapeLeave",UnderCover_ColShape,UnderCover_ColShape_Leave)
	
	
	