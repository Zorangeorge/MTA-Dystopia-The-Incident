sw, sh = guiGetScreenSize()
rRoot = getResourceRootElement(getThisResource())
lp = getLocalPlayer()
xml = false
gui = {}

function scaleReset(on)
  radar = {
  north = "img/radarnorth.png",
  scan = "img/scans.png",
  circle = "img/radius.png",
  miniback = "img/miniback.png",
  size = 1024,
  minsize = 500,
  maxsize = 1500,
  w = 1024,
  h = 1024,
  x = 1,
  y = 1,
  range = 250,
  maxrange = 250,
  radius = 444,
  grad = 50,
  scale = 1,
  blipsize = 16,
  on = false }

  mini = {
  size = 256,
  bigsize = 1024,
  scale = 2.75,
  on = false }
  
--[[ map
  map = {
  img = "img/map.png",
  size = 6000,
  scaler = 1,
  alpha = 128,
  color = 0,
  w = 1024,
  h = 1024,
  x = 0,
  y = 0,
  on = true }
--]]

  blip = {
  ped = "blips/ped.png",
  veh = "blips/vehicle.png",
  pedveh = "blips/pedvehicle.png",
  default = "blips/0.png",
  unscaled = 20,
  size = 20, 
  big = 25, 
  bhalf = 25, 
  maxsize = 32,
  minsize = 12,
  xtext = 4,
  ytext = 4,
  xc = 0,
  yc = 0,
  textsize = 4,
  half = 10 }

  if on then radar.on = true end
end    

setup = {
  peds = true,
  vehicles = true,
  players = true,
  blips = true,
  blipsoutofrange = true,
  teamcolors = true,
  pedpointers = true,
  pednames = true,
  vehiclepointers = true,
  playerpointers = true,
  vehiclenames = true,
  blipnames = true,
  deadvehicles = false,
  passengers = true,
  onelinepointers = false,
  pickups = false,
  pickuppointers = false,
  pickupnames = false }

tick = 0

function rescaleRadar()
  if mini.on then 
    radar.scale = sh/mini.scale/radar.size
    radar.radius = 128*0.8671875*radar.scale
  else 
    radar.scale = sh/radar.size 
    radar.radius = 512*0.8671875*radar.scale
  end
  radar.w = radar.size*radar.scale
  radar.h = radar.w
  if mini.on then 
    radar.x = sw*0.1359-radar.w/2
    radar.y = sh*0.85625-radar.h/2
  else 
    radar.x = sw/2-radar.w/2
    radar.y = sh/2-radar.h/2
  end  
  radar.xc = radar.x+radar.w/2
  radar.yc = radar.y+radar.h/2
  
  if mini.on then 
    blip.size = blip.unscaled/2
  else
    blip.size = blip.unscaled
  end  
  blip.half = blip.size/2
  blip.big = blip.size+blip.half
  blip.bhalf = blip.big/2
  blip.xtext = blip.size+radar.w/256
  blip.ytext = radar.w/256
  blip.textsize = blip.half/10
  
  --[[ map
  map.scaler = map.size/6000
  map.w = sw+sh/2
  map.h = map.w
  map.x = sw/2 - map.w/2
  map.y = sh/2 - map.h/2
  map.rw = (map.w*radar.range/radar.radius)*map.scaler
  map.rh = map.rw
  map.color = tocolor(255,255,255,map.alpha)
  --]]
end

addCommandHandler("bigradar", 
	function(_, action)
    if action == "setup" then
      showCursor(true)
      guiSetVisible(gui.win, true)
    elseif action == "reset" then
      scaleReset(radar.on)
      rescaleRadar()
    else 
      if radar.on and not mini.on then 
        miniSwitch()
      elseif radar.on and mini.on then 
        miniSwitch()
        radar.on = false
      else
        radar.on = true
      end
    end
  end
)  

function miniSwitch()
  if not radar.on then return false end
  if mini.on then
    setup.pickuppointers, setup.vehiclepointers, setup.pedpointers, setup.playerpointers = mini.playerpointers, mini.pedpointers, mini.vehiclepointers, mini.pickuppointers
    mini.on = false
    radar.size = mini.bigsize
    rescaleRadar()
  else 
    mini.playerpointers, mini.pedpointers, mini.vehiclepointers, mini.pickuppointers = setup.pickuppointers, setup.vehiclepointers, setup.pedpointers, setup.playerpointers
    setup.pickuppointers, setup.vehiclepointers, setup.pedpointers, setup.playerpointers = false, false, false, false
    mini.on = true
    mini.bigsize = radar.size
    radar.size = mini.size
    rescaleRadar()
  end
end
  
  
addEventHandler("onClientResourceStart", rRoot,
	function()
    scaleReset()
    loadSettings()
    rescaleRadar()
    gui.win = guiCreateWindow(sw - 450, sh - 180, 430, 160, "BigRadar setup:", false)
    guiWindowSetSizable(gui.win, false)	
    
    gui.close = guiCreateButton(.9, .8, .1, .2, "X", true, gui.win)
    
    gui.pl = guiCreateCheckBox(.01, .15, .2, .1, "Players:", false, true, gui.win)
    gui.plpointers = guiCreateCheckBox(.01, .27, .2, .1, "XYZpointers", false, true, gui.win)
    guiSetFont(gui.plpointers, "default-small")
    gui.plteams = guiCreateCheckBox(.01, .39, .2, .1, "Team colors", false, true, gui.win)
    guiSetFont(gui.plteams, "default-small")
    guiCheckBoxSetSelected(gui.pl, setup.players) 
    guiCheckBoxSetSelected(gui.plpointers, setup.playerpointers) 
    guiCheckBoxSetSelected(gui.plteams, setup.teamcolors) 

    gui.vh = guiCreateCheckBox(.22, .15, .2, .1, "Vehicles:", false, true, gui.win)
    gui.vhpointers = guiCreateCheckBox(.22, .27, .2, .1, "XYZpointers", false, true, gui.win)
    guiSetFont(gui.vhpointers, "default-small")
    gui.vhnames = guiCreateCheckBox(.22, .39, .2, .1, "Vehicle names", false, true, gui.win)
    guiSetFont(gui.vhnames, "default-small")
    gui.vhpass = guiCreateCheckBox(.22, .51, .2, .1, "Passengers", false, true, gui.win)
    guiSetFont(gui.vhpass, "default-small")
    gui.vhdead = guiCreateCheckBox(.22, .63, .2, .1, "Dead vehicles", false, true, gui.win)
    guiSetFont(gui.vhdead, "default-small")
    guiCheckBoxSetSelected(gui.vh, setup.vehicles) 
    guiCheckBoxSetSelected(gui.vhpointers, setup.vehiclepointers) 
    guiCheckBoxSetSelected(gui.vhnames, setup.vehiclenames) 
    guiCheckBoxSetSelected(gui.vhpass, setup.passengers) 
    guiCheckBoxSetSelected(gui.vhdead, setup.deadvehicles) 
    
    gui.pd = guiCreateCheckBox(.42, .15, .2, .1, "Peds:", false, true, gui.win)
    gui.pdpointers = guiCreateCheckBox(.42, .27, .2, .1, "XYZpointers", false, true, gui.win)
    gui.pdnames = guiCreateCheckBox(.42, .39, .2, .1, "Ped names", false, true, gui.win)
    guiSetFont(gui.pdpointers, "default-small")
    guiSetFont(gui.pdnames, "default-small")
    guiCheckBoxSetSelected(gui.pd, setup.peds) 
    guiCheckBoxSetSelected(gui.pdpointers, setup.pedpointers) 
    guiCheckBoxSetSelected(gui.pdnames, setup.pednames) 

    gui.bl = guiCreateCheckBox(.61, .15, .2, .1, "MTA blips:", false, true, gui.win)
    gui.outofrange = guiCreateCheckBox(.61, .27, .2, .1, "Out of range", false, true, gui.win)
    gui.blipnames = guiCreateCheckBox(.61, .39, .2, .1, "Blip names", false, true, gui.win)
    guiSetFont(gui.outofrange, "default-small")
    guiSetFont(gui.blipnames, "default-small")
    guiCheckBoxSetSelected(gui.bl, setup.blips) 
    guiCheckBoxSetSelected(gui.outofrange, setup.blipsoutofrange) 
    guiCheckBoxSetSelected(gui.blipnames, setup.blipnames) 

    gui.pk = guiCreateCheckBox(.81, .15, .2, .1, "Pickups:", false, true, gui.win)
    gui.pkpointers = guiCreateCheckBox(.81, .27, .2, .1, "XYZpointers", false, true, gui.win)
    gui.pknames = guiCreateCheckBox(.81, .39, .2, .1, "Names", false, true, gui.win)
    guiSetFont(gui.pknames, "default-small")
    guiSetFont(gui.pkpointers, "default-small")
    guiCheckBoxSetSelected(gui.pk, setup.pickups) 
    guiCheckBoxSetSelected(gui.pknames, setup.pickupnames) 
    guiCheckBoxSetSelected(gui.pkpointers, setup.pickuppointers) 
    
    gui.oneline = guiCreateCheckBox(.5, .63, .5, .1, "Use one-line XYZpointers", false, true, gui.win)
    guiSetFont(gui.oneline, "default-small")
    guiCheckBoxSetSelected(gui.oneline, setup.onelinepointers) 
    
    --[[ huge ass map removed
    gui.map = guiCreateCheckBox(.81, .63, .5, .1, "Map overlay", false, true, gui.win)
    guiSetFont(gui.map, "default-small")
    guiCheckBoxSetSelected(gui.map, map.on) 
    --]]
    
    gui.info = guiCreateLabel(.02, .8, .85, .2, "Use <NUM +> and <NUM -> buttons to change radar range when radar is open\nHold ALT to change blip size, hold CTRL to change radar size", true, gui.win)
    guiSetFont(gui.info, "default-small")
    guiSetVisible(gui.win, false)
    
    addEventHandler("onClientGUIClick", source,
			function()
        if source == gui.close then
          guiSetVisible(gui.win, false)
          showCursor(false)
        elseif source == gui.pl then setup.players = guiCheckBoxGetSelected(source) 
        elseif source == gui.vh then setup.vehicles = guiCheckBoxGetSelected(source) 
        elseif source == gui.pd then setup.peds = guiCheckBoxGetSelected(source) 
        elseif source == gui.plpointers then setup.playerpointers = guiCheckBoxGetSelected(source) 
        elseif source == gui.pdpointers then setup.pedpointers = guiCheckBoxGetSelected(source) 
        elseif source == gui.pdnames then setup.pednames = guiCheckBoxGetSelected(source) 
        elseif source == gui.vhpointers then setup.vehiclepointers = guiCheckBoxGetSelected(source) 
        elseif source == gui.vhdead then setup.deadvehicles = guiCheckBoxGetSelected(source) 
        elseif source == gui.plteams then setup.teamcolors = guiCheckBoxGetSelected(source) 
        elseif source == gui.vhnames then setup.vehiclenames = guiCheckBoxGetSelected(source) 
        elseif source == gui.vhpass then setup.passengers = guiCheckBoxGetSelected(source) 
        elseif source == gui.bl then setup.blips = guiCheckBoxGetSelected(source) 
        elseif source == gui.outofrange then setup.blipsoutofrange = guiCheckBoxGetSelected(source) 
        elseif source == gui.oneline then setup.onelinepointers = guiCheckBoxGetSelected(source) 
        elseif source == gui.blipnames then setup.blipnames = guiCheckBoxGetSelected(source) 
        elseif source == gui.pk then setup.pickups = guiCheckBoxGetSelected(source) 
        elseif source == gui.pknames then setup.pickupnames = guiCheckBoxGetSelected(source) 
        elseif source == gui.pkpointers then setup.pickuppointers = guiCheckBoxGetSelected(source) 
        --[[ map
        elseif source == gui.map then map.on = guiCheckBoxGetSelected(source) 
        --]]
        end        
      end
    )  
	end
)  

addEventHandler("onClientRender", getRootElement(), 
  function()
    if radar.on and getElementData(lp, "bigradar") then
      local r,g,b,a = 255,255,255,200
    
      -- size adjust
      if getKeyState("num_sub") then 
        if getKeyState("lalt") or getKeyState("ralt") then 
          blip.unscaled = math.max(blip.unscaled-0.5, blip.minsize)
          rescaleRadar()
        elseif (getKeyState("lctrl") or getKeyState("rctrl")) and not mini.on then 
          radar.size = math.min(radar.size+10, radar.maxsize)
          rescaleRadar()
        --[[ map  
        elseif getKeyState("lshift") or getKeyState("rshift") then 
          map.alpha = math.max(map.alpha-2, 32)
          map.color = tocolor(255,255,255,map.alpha)
        --]]  
        else 
          radar.range = math.min(radar.range+5, radar.maxrange) 
          rescaleRadar()
        end
      end
      if getKeyState("num_add") then 
        if getKeyState("lalt") or getKeyState("ralt") then 
          blip.unscaled = math.min(blip.unscaled+0.5, blip.maxsize)
          rescaleRadar()
        elseif (getKeyState("lctrl") or getKeyState("rctrl")) and not mini.on then 
          radar.size = math.max(radar.size-10, radar.minsize)
          rescaleRadar()
        --[[ map  
        elseif getKeyState("lshift") or getKeyState("rshift") then 
          map.alpha = math.min(map.alpha+2, 255)
          map.color = tocolor(255,255,255,map.alpha)
        --]]  
        else 
          radar.range = math.max(radar.range-5, 50) 
          rescaleRadar()
        end
      end

      -- scanlines/miniback
      if mini.on then dxDrawImage(radar.x, radar.y, radar.w, radar.h, radar.miniback)
      else dxDrawImage(0, 0, sw, math.max(1024, sh), radar.scan) end
      
      -- range marks
      local px, py, pz = getElementPosition(lp)
      local pr = getPedRotation(lp)
      local cx,cy,_,tx,ty = getCameraMatrix()
      local north = findRotation(cx,cy,tx,ty)
      
      --[[ map overlay
      if map.on then
        dxDrawImageSection(map.x, map.y, map.w, map.h, (px+3000)*map.scaler-map.rw/2, (6000-py+3000)*map.scaler-map.rh/2, map.rw, map.rh, map.img, north, 0, 0, map.color)
      end      
      --]]
      
      local grad = math.floor(radar.range/radar.grad)
      local cimg = 1
      while cimg <= grad do
        local size = (cimg*radar.grad/radar.range)*radar.radius
        dxDrawImage(radar.xc-size, radar.yc-size, size*2, size*2, radar.circle)  
        if cimg <= grad and not mini.on then dxDrawText(tostring((cimg)*radar.grad), radar.xc+size-40, radar.yc+4, sw, sh, tocolor(0,0,0,155), 0.5, "bankgothic") end
        cimg = cimg + 1
      end
      
      -- compass layer
      dxDrawImage(radar.x, radar.y, radar.w, radar.h, radar.north, north)  
      
      -- local blip
      if isPedInVehicle(lp) then dxDrawImage(radar.xc-blip.half, radar.yc-blip.half, blip.size, blip.size, blip.pedveh, north-pr+45) 
      else dxDrawImage(radar.xc-blip.half, radar.yc-blip.half, blip.size, blip.size, blip.ped, north-pr+45) end

      -- MTA blip elements
      if setup.blips then
        for _, e in ipairs(getElementsByType("blip")) do    
          if not getElementData(e, "bigradar.noblip") then
            r,g,b,a = 255,255,255,200      
            local ex, ey, ez = getElementPosition(e)
            local dist = getDistanceBetweenPoints2D(px,py,ex,ey)
            if dist <= radar.range or setup.blipsoutofrange then
              if dist > radar.range then dist = radar.range end
              local angle = 180-north+findRotation(px,py,ex,ey)
              local blipx, blipy = getDistanceRotation(0, 0, radar.radius*(dist/radar.range), angle)
              local icon = getBlipIcon(e)
              if icon == 0 or icon == 1 then r,g,b,a = getBlipColor(e) end
              blipx = radar.xc+blipx-blip.bhalf
              blipy = radar.yc+blipy-blip.bhalf
              dxDrawImage(blipx, blipy, blip.big, blip.big, "blips/"..icon..".png", 0, 0, 0, tocolor(r,g,b,a))  
              if setup.blipnames then
                local name = getElementData(e, "bigradar.blipname")
                if name then dxDrawText(name, blipx+blip.big, blipy+blip.half*radar.scale, blipx, blipy, tocolor(r,g,b,a), blip.textsize, "default") end
              end  
            end  
          end  
        end
      end  

      -- pickups
      if setup.pickups then
        for _, e in ipairs(getElementsByType("pickup", getRootElement(), true)) do    
          r,g,b,a = 255,255,255,200    
          local ex, ey, ez = getElementPosition(e)
          local dist = getDistanceBetweenPoints2D(px,py,ex,ey)
          if dist <= radar.range then
            local angle = 180-north+findRotation(px,py,ex,ey)
            local cblipx, cblipy = getDistanceRotation(0, 0, radar.radius*(dist/radar.range), angle)
            local type = getPickupType(e)
            local icon = "blips/1.png"
            local name = getElementData(e, "bigradar.blipname")
            if type == 0 then 
              icon = "blips/health.png" 
              r,g,b,a = 255,25,25,200    
            elseif type == 1 then 
              icon = "blips/armor.png" 
              r,g,b,a = 125,125,255,200    
            elseif type == 2 then 
              icon = "blips/weapon.png" 
              r,g,b,a = 25,254,25,200    
              name = getWeaponNameFromID(getPickupWeapon(e))
            end
            local blipx = radar.xc+cblipx-blip.half
            local blipy = radar.yc+cblipy-blip.half
            if setup.pickuppointers then 
              local wx, wy = getScreenFromWorldPosition(ex, ey, ez, 1, true)
              if wx then        
                if setup.onelinepointers then dxDrawLine(wx, wy, radar.xc+cblipx, radar.yc+cblipy, tocolor(r,g,b,50), 1)
                else 
                  dxDrawLine(wx, wy, radar.xc+cblipx, wy, tocolor(r,g,b,50), 1)
                  dxDrawLine(radar.xc+cblipx, wy, radar.xc+cblipx, radar.yc+cblipy, tocolor(r,g,b,50), 1)
                end  
                dxDrawRectangle(wx-1, wy-1, 3, 3, tocolor(r,g,b,50))
              end 
            end  
            dxDrawImage(blipx, blipy, blip.size, blip.size, icon)  
            if setup.pickupnames and name then dxDrawText(name, blipx+blip.xtext, blipy+blip.ytext, blipx, blipy, tocolor(r,g,b,a), blip.textsize, "default") end
          end  
        end
      end  
      
      -- peds
      if setup.peds then
        r,g,b,a = 255,255,255,128
        for _, e in ipairs(getElementsByType("ped", getRootElement(), true)) do    
          local ex, ey, ez = getElementPosition(e)
          local dist = getDistanceBetweenPoints2D(px,py,ex,ey)
          if dist <= radar.range then
            local rot = getPedRotation(e)
            local angle = 180-north + findRotation(px,py,ex,ey)
            local cblipx, cblipy = getDistanceRotation(0, 0, radar.radius*(dist/radar.range), angle)
            local blipx = radar.xc+cblipx-blip.half
            local blipy = radar.yc+cblipy-blip.half
            dxDrawImage(blipx, blipy, blip.size, blip.size, blip.ped, north-rot+45, 0, 0, tocolor(r,g,b,a))  
            local name = getElementData(e, "bigradar.blipname")
            if setup.pednames and name then dxDrawText(name, blipx+blip.xtext, blipy+blip.ytext, blipx, blipy, tocolor(r,g,b,a), blip.textsize, "default") end
            if setup.pedpointers then 
              local wx, wy = getScreenFromWorldPosition(ex, ey, ez, 1, true)
              if wx then        
                if setup.onelinepointers then dxDrawLine(wx, wy, radar.xc+cblipx, radar.yc+cblipy, tocolor(r,g,b,50), 1)
                else 
                  dxDrawLine(wx, wy, radar.xc+cblipx, wy, tocolor(r,g,b,50), 1)
                  dxDrawLine(radar.xc+cblipx, wy, radar.xc+cblipx, radar.yc+cblipy, tocolor(r,g,b,50), 1)
                end
                dxDrawRectangle(wx-1, wy-1, 3, 3, tocolor(r,g,b,50))
              end 
            end  
          end  
        end
      end
      
      -- vehicles (players in vehicles)
      if setup.players or setup.vehicles then
        for _, e in ipairs(getElementsByType("vehicle", getRootElement(), true)) do    
          if e ~= getPedOccupiedVehicle(lp) and (getElementHealth(e) > 0 or setup.deadvehicles) then
            r,g,b,a = 255,255,255,200
            local driver = getVehicleOccupant(e, 0)
            if (driver and setup.players) or setup.vehicles then
              local ex, ey, ez = getElementPosition(e)
              local dist = getDistanceBetweenPoints2D(px,py,ex,ey)
              if dist <= radar.range then
                local _,_,rot = getElementRotation(e)
                local name = getVehicleName(e)
                local img = blip.veh
                local angle = 180-north + findRotation(px,py,ex,ey)
                local cblipx, cblipy = getDistanceRotation(0, 0, radar.radius*(dist/radar.range), angle)
                local blipx = radar.xc+cblipx-blip.half
                local blipy = radar.yc+cblipy-blip.half
                local yoff = 0
                if driver then
                  local team = setup.teamcolors and getPlayerTeam(driver) or false
                  if team then r,g,b = getTeamColor(team) end
                  name = getPlayerName(driver):gsub("#%x%x%x%x%x%x","").." ["..name.."]"
                  img = blip.pedveh
                end
                if (driver and setup.playerpointers) or setup.vehiclepointers then 
                  local wx, wy = getScreenFromWorldPosition(ex, ey, ez, 1, true)
                  if wx then        
                    if setup.onelinepointers then dxDrawLine(wx, wy, radar.xc+cblipx, radar.yc+cblipy, tocolor(r,g,b,50), 1)
                    else 
                      dxDrawLine(wx, wy, radar.xc+cblipx, wy, tocolor(r,g,b,50), 1)
                      dxDrawLine(radar.xc+cblipx, wy, radar.xc+cblipx, radar.yc+cblipy, tocolor(r,g,b,50), 1)
                    end  
                    dxDrawRectangle(wx-1, wy-1, 3, 3, tocolor(r,g,b,50))
                  end  
                end
                dxDrawImage(blipx, blipy, blip.size, blip.size, img, north-rot+45, 0, 0, tocolor(r,g,b,a))  
                if setup.vehiclenames or (driver and setup.players) then dxDrawText(name, blipx+blip.xtext, blipy+blip.ytext, blipx, blipy, tocolor(r,g,b,a), blip.textsize, "default") end
                if setup.passengers then 
                  local seats = getVehicleOccupants(e)
                  for seat = 1, getVehicleMaxPassengers(e) do
                    if seats[seat] and getElementType(seats[seat]) == "player" then
                      yoff = yoff + 10
                      local p = seats[seat]
                      local team = setup.teamcolors and getPlayerTeam(p) or false
                      if team then r,g,b = getTeamColor(team) 
                      else r,g,b,a = 255,255,255,200 end
                      dxDrawText(getPlayerName(p):gsub("#%x%x%x%x%x%x",""), blipx+blip.xtext, blipy+blip.ytext+yoff, blipx, blipy, tocolor(r,g,b,a), blip.textsize, "default")
                    end
                  end
                end
              end  
            end  
          end
        end
      end

      --players (players in vehicles rendered in vehicles loop, not here)
      if setup.players then
        for _, e in ipairs(getElementsByType("player", getRootElement(), true)) do    
          if e ~= lp and not isPedInVehicle(e) then
            local ex, ey, ez = getElementPosition(e)
            local dist = getDistanceBetweenPoints2D(px,py,ex,ey)
            if dist <= radar.range then
              r,g,b,a = 255,255,255,222
              local rot = getPedRotation(e)
              local name = getPlayerName(e)
              local team = setup.teamcolors and getPlayerTeam(e) or false
              if team then r,g,b = getTeamColor(team) end
              local angle = 180-north + findRotation(px,py,ex,ey)
              local cblipx, cblipy = getDistanceRotation(0, 0, radar.radius*(dist/radar.range), angle)
              local blipx = radar.xc+cblipx-blip.half
              local blipy = radar.yc+cblipy-blip.half
              if setup.playerpointers then 
                local wx, wy = getScreenFromWorldPosition(ex, ey, ez, 1, true)
                if wx then        
                  if setup.onelinepointers then dxDrawLine(wx, wy, radar.xc+cblipx, radar.yc+cblipy, tocolor(r,g,b,50), 1)
                  else 
                    dxDrawLine(wx, wy, radar.xc+cblipx, wy, tocolor(r,g,b,50), 1)
                    dxDrawLine(radar.xc+cblipx, wy, radar.xc+cblipx, radar.yc+cblipy, tocolor(r,g,b,50), 1)
                  end  
                  dxDrawRectangle(wx-1, wy-1, 3, 3, tocolor(r,g,b,50))
                end 
              end  
              dxDrawImage(blipx, blipy, blip.size, blip.size, blip.ped, north-rot+45, 0, 0, tocolor(r,g,b,a))  
              dxDrawText(name:gsub("#%x%x%x%x%x%x",""), blipx+blip.xtext, blipy+blip.ytext, blipx, blipy, tocolor(r,g,b,a), blip.textsize, "default")
            end  
          end
        end
      end  
      
      
      --[[-- custom added blips      
      for _, e in pairs(blips) do    
      end
      --]]-- not used

      tick = getTickCount()
    end
  end
)  

function getDistanceRotation(x, y, dist, angle)
  local a = math.rad(90 - angle)
  local dx = math.cos(a) * dist
  local dy = math.sin(a) * dist
  return x+dx, y+dy
end

function findRotation(x1,y1,x2,y2)
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end
  return t
end

function fromstring(value)
  if tonumber(value) then return tonumber(value)
  elseif value == "true" then return true
  else return false
  end
end

function loadSettings()
	xml = xmlLoadFile("radar.xml")
	if xml then
    for k, v in pairs(setup) do
      setup[k] = fromstring(xmlNodeGetValue(xmlFindChild(xml, k,0)))
    end
    radar.size = fromstring(xmlNodeGetValue(xmlFindChild(xml, "size",0)))
    radar.range = fromstring(xmlNodeGetValue(xmlFindChild(xml, "range",0)))
    blip.unscaled = fromstring(xmlNodeGetValue(xmlFindChild(xml, "blipsize",0)))
  else
    xml = xmlCreateFile("radar.xml", "settings")  
    for k, v in pairs(setup) do
      xmlNodeSetValue(xmlCreateChild(xml, k), tostring(v))
    end
    xmlNodeSetValue(xmlCreateChild(xml, "size"), tostring(radar.size))
    xmlNodeSetValue(xmlCreateChild(xml, "range"), tostring(radar.range))
    xmlNodeSetValue(xmlCreateChild(xml, "blipsize"), tostring(blip.unscaled))
  end
end  

function saveSettings()
  if xml then
    for k, v in pairs(setup) do
      xmlNodeSetValue(xmlFindChild(xml, k, 0), tostring(v))
    end
    xmlNodeSetValue(xmlFindChild(xml, "size", 0), tostring(radar.size))
    xmlNodeSetValue(xmlFindChild(xml, "range", 0), tostring(radar.range))
    xmlNodeSetValue(xmlFindChild(xml, "blipsize", 0), tostring(blip.unscaled))
  end
end

addEventHandler("onClientResourceStop", rRoot,
	function()
    saveSettings()
  	xmlSaveFile(xml)
  	xmlUnloadFile(xml)
  end
)  

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
