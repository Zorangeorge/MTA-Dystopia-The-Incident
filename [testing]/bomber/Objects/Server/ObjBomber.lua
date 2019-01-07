-- server script
-- MTA:SA Deathmatch 1.0 Developer preview 2 compatible

ObjBomber = {}
ObjBomber.__index = ObjBomber

function ObjBomber.create(resource)
  local _objBomber = {}
  setmetatable(_objBomber, ObjBomber)
  _objBomber._resource = resource
  _objBomber._settingNames =
    {
      "andromada",
      "at400",
      "beagle",
      "cargobob",
      "cropduster",
      "dodo",
      "hunter",
      "hydra",
      "leviathan",
      "maverick",
      "nevada",
      "newschopper",
      "policemaverick",
      "raindance",
      "rustler",
      "seasparrow",
      "shamal",
      "skimmer",
      "sparrow",
      "stuntplane",
      "coastguard",
      "dinghy",
      "jetmax",
      "launch",
      "marquis",
      "predator",
      "reefer",
      "speeder",
      "squalo",
      "tropic",
      "fbirancher",
      "patriot",
      "policecar",
      "policeranger",
      "rhino"
    }
  _objBomber._validVehicles = {}
  return _objBomber
end

function ObjBomber:regBomber()
  local settingValue = ""
  local settingValues = {}
  for _, setting in ipairs(self._settingNames) do
    settingValue = get(getResourceName(self._resource) .. "." .. setting)
    if (settingValue) then
      settingValues = split(settingValue, string.byte(' '))
      self._validVehicles[tonumber(settingValues[1])] =
        {
          ["vehicleID"] = tonumber(settingValues[1]),
          ["modelID"] = tonumber(settingValues[2]),
          ["xPosOffset"] = tonumber(settingValues[3]),
          ["yPosOffset"] = tonumber(settingValues[4]),
          ["zPosOffset"] = tonumber(settingValues[5]),
          ["xRotOffset"] = tonumber(settingValues[6]),
          ["yRotOffset"] = tonumber(settingValues[7]),
          ["zRotOffset"] = tonumber(settingValues[8]),
          ["depthBomb"] = (tonumber(settingValues[9]) == 1)
        }
      outputDebugString("* " .. setting .. " (Registered)")
    end
  end
end

function ObjBomber:isVehicleController(player)
  if (isPedInVehicle(player)) then
    if (getVehicleController(getPedOccupiedVehicle(player)) == player) then
      return getElementModel(getPedOccupiedVehicle(player))
    end
  end
  return 0
end

function ObjBomber:isValidVehicle(vehicleID)
  return (self._validVehicles[vehicleID] ~= nil)
end

function ObjBomber:callbackFunc(request, player, ...)
  if (request == "funcRegBomber") then
    triggerClientEvent(player, "callbackClientBomber", player, "funcRegBomber", self._validVehicles)
  end
  if (request == "funcReloadBomber") then
    --if (self:isValidVehicle(self:isVehicleController(player))) then
      triggerClientEvent(player, "callbackClientBomber", player, "funcReloadBomber")
    --end
  end
  if (request == "funcDetonateBomb") then
    createExplosion(arg[1].posX, arg[1].posY, arg[1].posZ, 10, player)
    createExplosion(arg[1].posX, arg[1].posY, arg[1].posZ, 7, player)
  end
end

-- Author: Ace_Gambit