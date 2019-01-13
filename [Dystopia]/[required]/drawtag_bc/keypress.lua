function OpenDraw

if getKeyPress ('d') then
	local drawtag = getResourceFromName("drawtag")
	if not (drawtag and getResourceRootElement(drawtag)) then
 return 
end
	local show = not exports.drawtag:isDrawingWindowVisible()
	exports.drawtag:showDrawingWindow(show)
end

function bindTheKeys()
  bindKey(source, "d", "down", OpenDraw)