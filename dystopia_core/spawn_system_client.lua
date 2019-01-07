function player_spawn_surv()
local sW, sH = guiGetScreenSize()
local px,py = (sW/1024),(sH/768)
		dxDrawRectangle(sW*0.5, 0, sW, sH, tocolor(0, 0, 0, 182), true)
		dxDrawText("Help:\n[Right Arrow] & [Left Arrow]: Choose\n[Space]: Spawn", sW*0.5592972181551977, py*700, px*744, py*734, tocolor(200, 200, 200, 100), py*1, "default-bold", "left", "top",false, false, true, false, false)
        dxDrawText("choose your class:", sW*0.5592972181551977, sH*0.25, sW*0.7379209370424597, sH*0.359375, tocolor(200, 200, 200, 200), 1.0, "pricedown", "left", "top", false, false, true, false, false)
		dxDrawText("survival", sW*0.5592972181551977, sH*0.2942708333333333, sW*0.7379209370424597, sH*0.359375, tocolor(235, 235, 235, 235), 2.0, "pricedown", "left", "top", false, false, true, false, false)
        dxDrawText("An old hardy hobo, you're already well versed in the arts of surviving the decaying urban environment, eating leftovers and dealing with merciless people.", sW*0.5592972181551977, sH*0.3723958333333333, sW*0.9379209370424597, sH*0.4270833333333333, tocolor(255, 255, 255, 255), 1.6, "default", "left", "top", false, true, true, false, false)
        dxDrawText("Starting skill:", sW*0.5592972181551977, sH*0.71, sW*0.7379209370424597, sH*0.7434895833333333, tocolor(200, 200, 200, 200), 1.5, "default", "left", "top", false, false, true, false, false)
        dxDrawText("Resilient", sW*0.5592972181551977, sH*0.7565104166666667, sW*0.7379209370424597, sH*0.8111979166666667, tocolor(255, 255, 255, 255), 1.8, "default", "left", "top", false, false, true, false, false)
end

function player_spawn_mil()
local sW, sH = guiGetScreenSize()
local px,py = (sW/1024),(sH/768)
		dxDrawRectangle(sW*0.5, 0, sW, sH, tocolor(0, 0, 0, 182), true)
		dxDrawText("Help:\n[Right Arrow] & [Left Arrow]: Choose\n[Space]: Spawn", sW*0.5592972181551977, py*700, px*744, py*734, tocolor(200, 200, 200, 100), py*1, "default-bold", "left", "top",false, false, true, false, false)
        dxDrawText("choose your class:", sW*0.5592972181551977, sH*0.25, sW*0.7379209370424597, sH*0.359375, tocolor(200, 200, 200, 200), 1.0, "pricedown", "left", "top", false, false, true, false, false)
        dxDrawText("combat", sW*0.5592972181551977, sH*0.2942708333333333, sW*0.7379209370424597, sH*0.359375, tocolor(235, 235, 235, 235), 2.0, "pricedown", "left", "top", false, false, true, false, false)
        dxDrawText("A small time thug with a knack for violence. There's still room for improvement, but at least you know which part of the gun shoots the bullets.", sW*0.5592972181551977, sH*0.3723958333333333, sW*0.9379209370424597, sH*0.4270833333333333, tocolor(255, 255, 255, 255), 1.6, "default", "left", "top", false, true, true, false, false)
        dxDrawText("Starting skill:", sW*0.5592972181551977, sH*0.71, sW*0.7379209370424597, sH*0.7434895833333333, tocolor(200, 200, 200, 200), 1.5, "default", "left", "top", false, false, true, false, false)
        dxDrawText("Gunslinger", sW*0.5592972181551977, sH*0.7565104166666667, sW*0.7379209370424597, sH*0.8111979166666667, tocolor(255, 255, 255, 255), 1.8, "default", "left", "top", false, false, true, false, false)
end

function player_spawn_med()
local sW, sH = guiGetScreenSize()
local px,py = (sW/1024),(sH/768)
		dxDrawRectangle(sW*0.5, 0, sW, sH, tocolor(0, 0, 0, 182), true)
		dxDrawText("Help:\n[Right Arrow] & [Left Arrow]: Choose\n[Space]: Spawn", sW*0.5592972181551977, py*700, px*744, py*734, tocolor(200, 200, 200, 100), py*1, "default-bold", "left", "top",false, false, true, false, false)
        dxDrawText("choose your class:", sW*0.5592972181551977, sH*0.25, sW*0.7379209370424597, sH*0.359375, tocolor(200, 200, 200, 200), 1.0, "pricedown", "left", "top", false, false, true, false, false)
        dxDrawText("medical", sW*0.5592972181551977, sH*0.2942708333333333, sW*0.7379209370424597, sH*0.359375, tocolor(235, 235, 235, 235), 2.0, "pricedown", "left", "top", false, false, true, false, false)
        dxDrawText("Not really a medic, yet your empathy and goodwill makes you help the injured all the time. A rare sight during the End of Days.", sW*0.5592972181551977, sH*0.3723958333333333, sW*0.9379209370424597, sH*0.4270833333333333, tocolor(255, 255, 255, 255), 1.6, "default", "left", "top", false, true, true, false, false)
       dxDrawText("Starting skill:", sW*0.5592972181551977, sH*0.71, sW*0.7379209370424597, sH*0.7434895833333333, tocolor(200, 200, 200, 200), 1.5, "default", "left", "top", false, false, true, false, false)
       dxDrawText("First Aid", sW*0.5592972181551977, sH*0.7565104166666667, sW*0.7379209370424597, sH*0.8111979166666667, tocolor(255, 255, 255, 255), 1.8, "default", "left", "top", false, false, true, false, false)
end

function player_spawn_tech()
local sW, sH = guiGetScreenSize()
local px,py = (sW/1024),(sH/768)
		dxDrawRectangle(sW*0.5, 0, sW, sH, tocolor(0, 0, 0, 182), true)
		dxDrawText("Help:\n[Right Arrow] & [Left Arrow]: Choose\n[Space]: Spawn", sW*0.5592972181551977, py*700, px*744, py*734, tocolor(200, 200, 200, 100), py*1, "default-bold", "left", "top",false, false, true, false, false)
        dxDrawText("choose your class:", sW*0.5592972181551977, sH*0.25, sW*0.7379209370424597, sH*0.359375, tocolor(200, 200, 200, 200), 1.0, "pricedown", "left", "top", false, false, true, false, false)
        dxDrawText("technical", sW*0.5592972181551977, sH*0.2942708333333333, sW*0.7379209370424597, sH*0.359375, tocolor(235, 235, 235, 235), 2.0, "pricedown", "left", "top", false, false, true, false, false)
        dxDrawText("You're not well mannered, but you can craft something, fix an engine or drink a bottle of moonshine like no other 'round these parts.", sW*0.5592972181551977, sH*0.3723958333333333, sW*0.9379209370424597, sH*0.4270833333333333, tocolor(255, 255, 255, 255), 1.6, "default", "left", "top", false, true, true, false, false)
        dxDrawText("Starting skill:", sW*0.5592972181551977, sH*0.71, sW*0.7379209370424597, sH*0.7434895833333333, tocolor(200, 200, 200, 200), 1.5, "default", "left", "top", false, false, true, false, false)
        dxDrawText("Tinkerer", sW*0.5592972181551977, sH*0.7565104166666667, sW*0.7379209370424597, sH*0.8111979166666667, tocolor(255, 255, 255, 255), 1.8, "default", "left", "top", false, false, true, false, false)
end

  function spawn_menu_right()
 if (getElementModel(dummy) == 239) then
   setElementModel(dummy, 106)
    removeEventHandler("onClientRender", root, player_spawn_surv)
	addEventHandler("onClientRender", root, player_spawn_mil)
elseif (getElementModel(dummy) == 106) then
   setElementModel(dummy, 291)
    removeEventHandler("onClientRender", root, player_spawn_mil)
	addEventHandler("onClientRender", root, player_spawn_med)
elseif (getElementModel(dummy) == 291) then
   setElementModel(dummy, 161)
    removeEventHandler("onClientRender", root, player_spawn_med)
	addEventHandler("onClientRender", root, player_spawn_tech)
 end
end

  function spawn_menu_left()
 if (getElementModel(dummy) == 106) then
   setElementModel(dummy, 239)
    addEventHandler("onClientRender", root, player_spawn_surv)
	removeEventHandler("onClientRender", root, player_spawn_mil)
elseif (getElementModel(dummy) == 291) then
   setElementModel(dummy, 106)
    addEventHandler("onClientRender", root, player_spawn_mil)
	removeEventHandler("onClientRender", root, player_spawn_med)
elseif (getElementModel(dummy)) == 161 then
   setElementModel(dummy, 291)
    addEventHandler("onClientRender", root, player_spawn_med)
	removeEventHandler("onClientRender", root, player_spawn_tech)
elseif (getElementModel(dummy)) == 287 then
   setElementModel(dummy, 161)
    addEventHandler("onClientRender", root, player_spawn_tech)

 end
end
 
 function spawn_skin_choice_made()
 
 fadeCamera(false,0)
 
 if (getElementModel(dummy) == 239) then
  triggerServerEvent("spawn1", localPlayer)
  clear_spawn_keys_and_events ()
	   
elseif (getElementModel(dummy) == 106) then
  triggerServerEvent("spawn2", localPlayer)
  clear_spawn_keys_and_events ()
  
elseif (getElementModel(dummy) == 291) then
  triggerServerEvent("spawn3", localPlayer)
  clear_spawn_keys_and_events ()
  
elseif (getElementModel(dummy) == 161) then
  triggerServerEvent("spawn4", localPlayer)
  clear_spawn_keys_and_events ()

 end

end

function clear_spawn_keys_and_events ()
	destroyElement(dummy)
  setCameraTarget(getLocalPlayer())
	removeEventHandler("onClientRender", root, player_spawn_surv)
  removeEventHandler("onClientRender", root, player_spawn_mil)
  removeEventHandler("onClientRender", root, player_spawn_med)
  removeEventHandler("onClientRender", root, player_spawn_tech)
  unbindKey("space", "down", spawn_skin_choice_made)
  unbindKey("arrow_r", "down", spawn_menu_right) 
  unbindKey("arrow_l", "down", spawn_menu_left)
  unbindKey("enter", "down", spawn_skin_choice_made)
  unbindKey("d", "down", spawn_menu_right) 
  unbindKey("a", "down", spawn_menu_left)
end