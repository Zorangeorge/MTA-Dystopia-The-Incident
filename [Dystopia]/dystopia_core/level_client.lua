-- Exp.client by Manawydan
local x,y = guiGetScreenSize()

addEvent("playSoundToServer",true)
local soundF = function(som,dis,volume)
local x,y,z=getElementPosition(source)
local som = playSound3D(som,x,y,z,false)
if(dis)then
setSoundMaxDistance(som,dis)
end
if(volume)then
setSoundVolume(som,volume)
end
return som
end
addEventHandler("playSoundToServer",root,soundF)

