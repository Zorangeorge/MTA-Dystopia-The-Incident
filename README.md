## MTA:SA 
# Dystopia:The Incident v0.75

Dystopia: The Incident is my attempt at creating a story-driven post-apocalyptic MMO-RPG for the MTA San Andreas platform.
Some of the code is original but huge amounts of it comes from the MTA community, edited, re-purposed sometimes and patched together to power a seamless, feature rich game world, designed to be also enjoyable as a single-player experience.  

### Test server:
mtasa://37.187.171.204:22008

### More details:

On Dystopia:
https://forum.mtasa.com/topic/98093-action-rpg-zombie-sandbox-dystopia-the-incident-en/
https://discord.gg/Zs5bWSX

On MTA:
https://www.multitheftauto.com/

## Installation:
1. Copy all files in your 'Resources' folder. 

2. Edit your server's mtaserver.conf file and replace the resource lines with the following:
```xml
    <resource src="admin" startup="1" protected="0" />
    <resource src="defaultstats" startup="1" protected="0" />
    <resource src="parachute" startup="1" protected="0" />
    <resource src="performancebrowser" startup="1" protected="0" />
    <resource src="resourcebrowser" startup="1" protected="1" default="true" />
    <resource src="resourcemanager" startup="1" protected="1" />
    <resource src="scoreboard" startup="1" protected="0" />
    <resource src="spawnmanager" startup="1" protected="0" />
    <resource src="mapmanager" startup="1" protected="0" />
    <resource src="votemanager" startup="0" protected="0" />
    <resource src="webadmin" startup="1" protected="0" />
    <resource src="heligrab" startup="1" protected="0" />
    <resource src="abseil" startup="1" protected="0" />
    <resource src="bone_attach" startup="1" protected="0" />
    <resource src="glue_new" startup="1" protected="0" />
    <resource src="skinloader" startup="1" protected="0" />
    <resource src="explosionshader" startup="1" protected="0" />
    <resource src="dystopia_slothbot" startup="1" protected="0" />
    <resource src="dystopia_mappos" startup="1" protected="0" />
    <resource src="dystopia_map" startup="1" protected="0" />
    <resource src="dystopia_interiors" startup="1" protected="0" />
    <resource src="dystopia_interiorcontents" startup="1" protected="0" />
    <resource src="dystopia_gen_map" startup="1" protected="0" />
    <resource src="dys_WetCourts" startup="1" protected="0" />
    <resource src="dys_LVComs" startup="1" protected="0" />
    <resource src="Freighter" startup="1" protected="0" />
    <resource src="RaiderVrock" startup="1" protected="0" />
    <resource src="CDF-Reefer-Mission" startup="1" protected="0" />
    <resource src="dyst_LVfence" startup="1" protected="0" />
    <resource src="dyst_radzones" startup="1" protected="0" />
    <resource src="dys_oldgarage" startup="1" protected="0" />
    <resource src="dystopia_vehicles" startup="1" protected="0" />
    <resource src="dystopia_vehreplacer" startup="1" protected="0" />
    <resource src="dystopia_groups" startup="1" protected="0" />
    <resource src="dystopia_pedprops" startup="1" protected="0" />
    <resource src="dystopia_armed" startup="1" protected="0" />
    <resource src="drawtag_bc" startup="1" protected="0" />
    <resource src="shoutall" startup="1" protected="0" />
    <resource src="dgs" startup="1" protected="0" />
    <resource src="dystopia_core" startup="1" protected="0" />
    <resource src="dystopia_minigun" startup="1" protected="0" />
    <resource src="dystopia_poker" startup="1" protected="0" />
    <resource src="policecruiser" startup="1" protected="0" />
    <resource src="roadwarrior" startup="1" protected="0" />
    <resource src="cdfpatroller" startup="1" protected="0" />
    <resource src="kamikaboom" startup="1" protected="0" />
    <resource src="peacekeepervan" startup="1" protected="0" />
    <resource src="cdftruck" startup="1" protected="0" />
    <resource src="warrig" startup="1" protected="0" />
    <resource src="meatwagon" startup="1" protected="0" />
    <resource src="tradeboat" startup="1" protected="0" />
    <resource src="watertruck" startup="1" protected="0" />
    <resource src="tradertruck" startup="1" protected="0" />
    <resource src="missileboat" startup="1" protected="0" />
    <resource src="missiletruck" startup="1" protected="0" />
    <resource src="fieldburner" startup="1" protected="0" />
    <resource src="siegetruck" startup="1" protected="0" />
    <resource src="alivetime" startup="1" protected="0" />
    <resource src="playtime" startup="1" protected="0" />
    <resource src="dystopia_zombies" startup="1" protected="0" />
    <resource src="dystopia_charger" startup="1" protected="0" />
    <resource src="dystopia_airstrike" startup="1" protected="0" />
    <resource src="killmessages" startup="1" protected="0" />
    <resource src="dystopia_traffic" startup="1" protected="0" />
    <resource src="dystopia_sync" startup="1" protected="0" />
```
3. You're all set up, run the server and have fun.

_Note: Some resources (like 'killmessages') might be already present in your MTA installation - make sure you delete the original resources and use those provided here._


