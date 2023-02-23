local HINT_INTERVAL = 180000 -- interval (in ms) between hints

local hints = {
	"HINT: Hold [F1] for help.",
	"HINT: Press [Q] to open inventory.",
	"HINT: Press [M] to display a map equipped in your belt.",
	"HINT: Press [X] to use current gadget.",
	"HINT: Press keys [1] to [0] to use emotes and stances.",
	"HINT: Press [/] to toggle the cursor.",
	"HINT: Press [4], [5] and [6] to change stance.",
	"HINT: Press [H] to carry small loot boxes and fuel barrels.",
	"HINT: Use Empty Bottle to get water from water sources.",
	"HINT: Use [LMB], [RMB] and [MMB] to interact with items in your inventory.",
	"HINT: Use Toolbox to repair vehicles or scavenge car wrecks.",
	"HINT: Use bladed weapons to butcher bodies.",
	"HINT: When carrying an object, press [H] while standing on a suitable vehicle to load it.",
	"HINT: Use a Fuel Canister near a vehicle to refuel it.",
	"HINT: Use Vehicle Parts near a vehicle to install them.",
	"HINT: Stand next to a fire to cook and slowly regain health.",
	"HINT: Press [J] to open the crafting panel.",
	"HINT: In the crafting panel you see only the objects you have materials for.",
	"HINT: Press [E] to pick up items.",
	"HINT: Find items by breaking loot boxes.",
	"HINT: Zombie Brutes are stronger and can't be headshot, but are unable to jump.",
	"HINT: Zombie Runners are fast and infect you more easily than the others.",
	"HINT: Zombie Walkers become faster at night.",
	"HINT: Shoot a zombie's legs to slow it down.",
	"HINT: Use [K], [-] and [+] to scan area when driving a Surveillance Van.",
	"HINT: Press [F9] to read the game manual.",
	"HINT: Hover over weapons in inventory to change current slot.",
	"HINT: Press [Q] to open storage containers and use RMB to transfer items.",
	"HINT: Press [F6] to save your player data.",
	"HINT: Press [Alt]+[H] to dismantle structures you built (toolbox required).",
	"HINT: Press [1] next to an NPC to initiate dialogue.",
	"HINT: Toggle shaders with /shaders [on/off]",
	"HINT: Build a Wooden Shelter to have a custom safe area for your vehicles."
	--"HINT: Double-jump while facing a tall object to climb (consumes stamina)."
}

function outputRandomHint()
	outputTopBar(hints[math.random(1, #hints)], root, 255, 200, 0)
end
setTimer(outputRandomHint, HINT_INTERVAL, 0)
