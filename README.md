## MTA:SA 
# Dystopia: The Incident v0.75

Dystopia: The Incident is my attempt at creating a story-driven post-apocalyptic MMO-RPG for the MTA San Andreas platform.
Some of the code is original but huge amounts of it comes from the MTA community, edited, re-purposed sometimes and patched together to power a seamless, feature rich game world, designed to be also enjoyable as a single-player experience.  

_Explore a detailed post-apocalyptic map with many encounter zones. 2000+ NPCs, both friendlies and baddies. Dynamic faction and spawn system. More than 50 missions already in the game. Detailed inventory with more than 100 items to be found and used. Basic needs, stamina, infection, various other modifiers like pain, bleeding, exhaustion or inebriation. Innovative looting mechanic. Four zombie types, with different behavior. Scavenge the world for materials to build settlements or to use simple crafting and cooking. Upgrade and drive rugged vehicles across the wasteland and engage in vehicular combat. Trade, recruit and discover parts of the story by chatting with NPCs. Experience dark humor and some strong themes (16+). Simple interface, consistent graphic style._


### For server owners:
Gamemode is in playable state. Some aspects are still  not optimized, so you might experience low performance in certain map areas or when doing certain actions. There are still some bugs left (nothing that cannot be solved through a quick relog). You will find some unfinished features, but the gamemode will be updated on a regular basis at least until v 1.0. Keep an eye on the MTA forum topic or the Discord community provided below. Suggestions are welcome!

### For developers:
*All contributions are welcome*, but be aware: this project was and still is a learning experience for me. The codebase follows few to no standards, is poorly organized and is un-optimized; you're likely to encounter dead code, oddities, stupid stuff and just about any kind of mistake you would expect a beginner to make. To give you an idea, when I started this I had only a very vague notion of what a variable is. Nonetheless, the result itself is very much playable and enjoyable.

### Test server:
mtasa://37.187.171.204:22008

### More details:

On Dystopia:
- https://forum.mtasa.com/topic/98093-action-rpg-zombie-sandbox-dystopia-the-incident-en/
- https://discord.gg/Zs5bWSX
- https://dystopiatheincident.imgur.com/

On MTA:
- https://www.multitheftauto.com/

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

## Credits
The following people contributed (most of them unknowingly) to Dystopia's codebase or other assets:

_Manawydan, Slothman, Ransom, Acorp, Neargreen, XX3, CrystalMV, KingGTA1997, Gothem, Daffy, Suerte, alex17, Sasuke, JasperNL, Woovie, Fedor_S, eXo|dragon, RiginOAL, JTPenn, yFletcher, Ren712, Rage, [CN]Honey, Tectron, LagParty, Bluethefurry, Rick, [GER]Rafael-KP_Lead, Gastonito, Mr.Loki, Zorrigas, NinjaThePooh, Falke, SimplyMods, Gamesnert, Earl.4life, Aiboforcen, Adrenaline, Redemtion, Dzsozi, Bonsai, Mike Koenig, Ijudman, 50p, TheLozza, Flower Power, Vick, Karim, Noah_Antilles, Tomas, Houdini, FEAR, freesfx.co.uk, HerbertBoland, MadSick, Chris, fridobeck, PrettySweetie, Eren, r1k3, specahawk, FreeLANMan, Rinke, Myrfin, Kieran, Dutchman101, KWKSND, Tipirodrigo, K1parik, Cordex, ShockWave, IroNicolas, MadnessReloaded, MoDeR2014, Aleksander19_

I tried to maintain a complete credits  list, but since development spanned over more than five years (up to this point) and it started as a personal server project, I might have omitted to add here some people whose work I used or I could no longer identify the author. If you believe you are in this position, I apologize. Please notify me using the email provided below and I'll update the credits. Also, you may not want your name and/or work associated with this project - in this case let me know and I'll remove it.

### Contact:
zoran_georgevici@yahoo.com
