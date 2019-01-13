--HELP SCREEN

function showClientImage()
	local x,y = guiGetScreenSize()
    backgrectangle = guiCreateStaticImage ( 0, 0, x, y, "images/beltblack.png", false )
	helpImage = guiCreateStaticImage( (x-1024)/2,0.0,1024,768, "images/helpscreen.png", false )
	centerWindow(helpImage)--fadeCamera( false, 0.5, 0, 0, 0)
	--toggleHUD()
end
bindKey("F1", "down", showClientImage)
 
function hideClientImage()
    if isElement ( helpImage ) then destroyElement ( helpImage ) end
	if isElement ( backgrectangle ) then destroyElement ( backgrectangle ) end
	--fadeCamera( true)
	--toggleHUD()
end
bindKey("F1", "up", hideClientImage)