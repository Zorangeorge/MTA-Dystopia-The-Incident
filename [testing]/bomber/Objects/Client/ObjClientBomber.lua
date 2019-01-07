-- client script
-- MTA:SA Deathmatch 1.0 Developer preview 2 compatible

ObjClientBomber = {}
ObjClientBomber.__index = ObjClientBomber

function ObjClientBomber.create(player)
  local _objClientBomber = {}
  setmetatable(_objClientBomber, ObjClientBomber)
  _objClientBomber._source = player
  _objClientBomber._settings = {}
  _objClientBomber._traceTimer = false
  _objClientBomber._fuseTimers = {false, false, false}
  _objClientBomber._bomb = false
  _objClientBomber._stickyObject = false
  _objClientBomber._depthFuse = 2.5
  _objClientBomber._depthLimit = 0
  _objClientBomber._cameraMode = "player"
  _objClientBomber._cameraRot = 0
  _objClientBomber._cameraPosOffset = 10.0
  _objClientBomber._cameraRotVelocity = 1.2
  _objClientBomber._funcInput = nil
  _objClientBomber._funcDropBomb = nil
  _objClientBomber._funcArmBomb = nil
  _objClientBomber._funcDetonateBomb = nil
  _objClientBomber._funcTraceDepthBomb = nil
  return _objClientBomber
end

function ObjClientBomber:regBomber()
  self._funcInput =
    function (key, keyState)
      if (key == "lshift" and keyState == "down") then
        self._funcDropBomb()
        unbindKey("lshift", "down", self._funcInput)
      end
      if (key == "mouse2" and keyState == "down") then
        self:togglePlayerView()
        unbindKey("mouse2", "down", self._funcInput)
      end
    end
  self._funcArmBomb =
    function (vehicleID, tracing, depthArmed)
      local vX, vY, vZ = 0, 0, 0
      local posX, posY, posZ = 0, 0, 0
      local depthBomb = self._settings[vehicleID].depthBomb
      if (not tracing) then
        playSoundFrontEnd(42)
        detachElements(self._stickyObject)
        if (not depthBomb) then
          self._fuseTimers[1] = setTimer(setElementCollisionsEnabled, 500, 1, self._bomb, true)
          self._fuseTimers[3] = setTimer(outputChatBox, 2500, 1, "* Bomb is armed!")
        else
          self:lookAtDepthBomb()
          self._fuseTimers[4] = setTimer(self._funcTraceDepthBomb, 15000, 1)
        end
        self._fuseTimers[2] = setTimer(self._funcArmBomb, 2500, 1, vehicleID, true, false)
      else
        vX, vY, vZ = getElementVelocity(self._stickyObject)
        posX, posY, posZ = getElementPosition(self._bomb)
        if (((vZ > 0) or (vX == 0 and vY == 0 and vZ == 0)) and not depthBomb) then
          self._funcDetonateBomb(false)
        elseif (posZ <= -(self._depthFuse) and depthBomb and not depthArmed) then
          self:togglePlayerView()
          setElementCollisionsEnabled(self._bomb, true)
          self._funcArmBomb(vehicleID, true, true)
          outputChatBox("* Depth bomb is armed!")
        elseif (((vZ > 0) or (posZ <= self._depthLimit) or (vX == 0 and vY == 0 and vZ == 0)) and depthBomb and depthArmed) then
          self._funcDetonateBomb(true)
        else
          self._traceTimer = setTimer(self._funcArmBomb, 50, 1, vehicleID, true, depthArmed)
        end
      end
    end
  self._funcDropBomb =
    function ()
      local playerVehicle = getPedOccupiedVehicle(self._source)
      local playerVehicleID = getElementModel(playerVehicle)
      if (self:canPlayerDropBomb()) then
        self:createBomb(playerVehicleID)
        self:createStickyObject()
        if (isElement(self._bomb) and isElement(self._stickyObject)) then
          attachElements(self._bomb, self._stickyObject, 0, 0, 0,
              self._settings[playerVehicleID].xRotOffset,
              self._settings[playerVehicleID].yRotOffset,
              self._settings[playerVehicleID].zRotOffset
            )
          attachElements(self._stickyObject, playerVehicle,
              self._settings[playerVehicleID].xPosOffset,
              self._settings[playerVehicleID].yPosOffset,
              self._settings[playerVehicleID].zPosOffset,
              0, 0, 0
            )
          self._depthLimit = -(math.random(self._depthFuse, 25))
          self._traceTimer = setTimer(self._funcArmBomb, 500, 1, playerVehicleID, false, false)
        end
      end
    end
  self._funcDetonateBomb =
    function (depthBomb)
      local posX, posY, posZ = 0, 0, 0
      if (self:isTimerStarted(self._fuseTimers[4])) then
        killTimer(self._fuseTimers[4])
      end
      if (isElement(self._bomb) and isElement(self._stickyObject)) then
        posX, posY, posZ = getElementPosition(self._bomb)
        destroyElement(self._bomb)
        blowVehicle(self._stickyObject, true)
        destroyElement(self._stickyObject)
        triggerServerEvent("callbackServerBomber", self._source, "funcDetonateBomb", {["posX"] = posX, ["posY"] = posY, ["posZ"] = posZ})
        if (not depthBomb) then
          for flare = 1, 8 do
            self:createFlare(posX, posY, posZ)
          end
        end
      end
      self:togglePlayerView()
    end
  self._funcTraceDepthBomb =
    function ()
      local vX, vY, vZ = getElementVelocity(self._stickyObject)
      local posX, posY, posZ = getElementPosition(self._bomb)
      if ((posZ > -(self._depthFuse)) and ((vZ > 0) or (vX == 0 and vY == 0 and vZ == 0))) then
        outputChatBox("* Depth bomb is armed!")
        self._funcDetonateBomb(true)
      else
        self._fuseTimers[4] = setTimer(self._funcTraceDepthBomb, 15000, 1)
      end
    end
  triggerServerEvent("callbackServerBomber", self._source, "funcRegBomber")
end

function ObjClientBomber:lookAtDepthBomb()
  if (self._cameraMode == "player") then
    toggleCameraFixedMode(true)
    self._cameraMode = "fixed"
    bindKey("mouse2", "down", self._funcInput)
    outputChatBox("* Depth camera is switched on")
    outputChatBox("* Press RMOUSE to switch off depth camera")
  end
end

function ObjClientBomber:togglePlayerView()
  if (self._cameraMode == "fixed") then
    self._cameraMode = "player"
    toggleCameraFixedMode(false)
  end
end

function ObjClientBomber:isVehicleController()
  if (isPedInVehicle(self._source)) then
    if (getVehicleController(getPedOccupiedVehicle(self._source)) == self._source) then
      return getElementModel(getPedOccupiedVehicle(self._source))
    end
  end
  return 0
end

function ObjClientBomber:isValidVehicle(vehicleID)
  return (self._settings[vehicleID] ~= nil)
end

function ObjClientBomber:isPlayerInAircraft()
  if (self:isValidVehicle(self:isVehicleController())) then
    if (getVehicleLandingGearDown(getPedOccupiedVehicle(self._source)) ~= nil) then
      return true
    end
  end
  return false
end

function ObjClientBomber:canPlayerReload()
  if (self:isValidVehicle(self:isVehicleController())) then
    return (#getAttachedElements(getPedOccupiedVehicle(self._source)) == 0)
  end
  return false
end

function ObjClientBomber:canPlayerDropBomb()
  if (self:isValidVehicle(self:isVehicleController())) then
    return (#getAttachedElements(getPedOccupiedVehicle(self._source)) > 0)
  end
  return false
end

function ObjClientBomber:callbackFunc(request, ...)
  if (request == "funcRegBomber") then
    self._settings = arg[1]
  end
  if (request == "funcReloadBomber") then
    if (self:canPlayerReload()) then
      self:loadBomb(getElementModel(getPedOccupiedVehicle(self._source)))
    end
  end
end

function ObjClientBomber:isTimerStarted(theTimer)
  for _, timer in ipairs(getTimers()) do
    if (timer == theTimer) then
      return true
    end
  end
  return false
end

function ObjClientBomber:createFlare(posX, posY, posZ)
  local dir = {1, -1}
  local vX, vY, vZ = 0, 0, 0
  vX = (math.random(2, 5) / 10) * dir[math.random(1, 2)]
  vY = (math.random(2, 5) / 10) * dir[math.random(1, 2)]
  vZ = math.random(1, 5) / 10
  createProjectile(self._source, 21, posX, posY, posZ, 1.0, nil, 0, 0, 0, vX, vY, vZ)
end

function ObjClientBomber:createStickyObject()
  if (isElement(self._stickyObject)) then
    destroyElement(self._stickyObject)
  end
  self._stickyObject = createVehicle(441, 0, 0, 0)
  setElementAlpha(self._stickyObject, 0)
end

function ObjClientBomber:createBomb(vehicleID)
  if (isElement(self._bomb)) then
    destroyElement(self._bomb)
  end
  self._bomb = createObject(self._settings[vehicleID].modelID, 0, 0, 0)
  setElementCollisionsEnabled(self._bomb, false)
end

function ObjClientBomber:loadBomb(vehicleID)
  self._funcDetonateBomb(self._settings[vehicleID].depthBomb)
  playSoundFrontEnd(46)
  self:togglePlayerView()
  if (self:isTimerStarted(self._traceTimer)) then
    killTimer(self._traceTimer)
  end
  for _, fuseTimer in ipairs(self._fuseTimers) do
    if (self:isTimerStarted(fuseTimer)) then
      killTimer(fuseTimer)
    end
  end
  self:createBomb(vehicleID)
  if (isElement(self._bomb)) then
    attachElements(self._bomb, getPedOccupiedVehicle(self._source),
        self._settings[vehicleID].xPosOffset,
        self._settings[vehicleID].yPosOffset,
        self._settings[vehicleID].zPosOffset,
        self._settings[vehicleID].xRotOffset,
        self._settings[vehicleID].yRotOffset,
        self._settings[vehicleID].zRotOffset
      )
    bindKey("lshift", "down", self._funcInput)
    outputChatBox("* Bomb is attached")
    outputChatBox("* Press LSHIFT to drop the bomb on target")
  end
end

function ObjClientBomber:callbackRender()
  local posX, posY, posZ = 0, 0, 0
  if (self._cameraMode == "fixed") then
    if (isElement(self._bomb)) then
      posX, posY, posZ = getElementPosition(self._bomb)
      setCameraLookAt(posX, posY, posZ)
      posX = posX - math.sin(math.rad(self._cameraRot)) * self._cameraPosOffset
      posY = posY + math.cos(math.rad(self._cameraRot)) * self._cameraPosOffset
      setCameraPosition(posX, posY, posZ - 5)
      if ((self._cameraRot + self._cameraRotVelocity) >= 360) then
        self._cameraRot = 0
      else
        self._cameraRot = self._cameraRot + self._cameraRotVelocity
      end
    end
  end
end

-- Author: Ace_Gambit