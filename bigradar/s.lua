rRoot = getResourceRootElement(getThisResource())

addEventHandler("onResourceStart", rRoot,
	function()
    for i,p in ipairs(getElementsByType("player")) do
  		setElementData(p, "bigradar", true)
    end  
	end
)

addEventHandler("onPlayerJoin", getRootElement(),
	function()
		setElementData(source, "bigradar", true)
	end
)

function brSetPedName(element, name)
  if isElement(element) and getElementType(element) == "ped" then
    if name then 
      setElementData(element, "bigradar.blipname", tostring(name)) 
      return true
    else  
      setElementData(element, "bigradar.blipname", false) 
      return true
    end
  end
  return false
end

function brSetPickupName(element, name)
  if isElement(element) and getElementType(element) == "pickup" then
    if name then 
      setElementData(element, "bigradar.blipname", tostring(name)) 
      return true
    else  
      setElementData(element, "bigradar.blipname", false) 
      return true
    end
  end
  return false
end

function brShowBlip(blipElement, name)
  if isElement(blipElement) and getElementType(blipElement) == "blip" then
		setElementData(blipElement, "bigradar.noblip", false)
    if name then setElementData(blipElement, "bigradar.blipname", tostring(name)) 
    else setElementData(blipElement, "bigradar.blipname", false) end
    return true
  end
  return false
end

function brHideBlip(blipElement)
  if isElement(blipElement) and getElementType(blipElement) == "blip" then
    setElementData(blipElement, "bigradar.noblip", true)  
    setElementData(blipElement, "bigradar.blipname", false)  
    return true
  end
  return false
end