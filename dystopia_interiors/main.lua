local objects = {}

objects.replace = {
	-- id, dff/col, txd
	{3976, "policest02_lan"},
	{18023, "int_pizzaplace"},
	{5418, "lae711block01"},
	{17700, "pigpenblok1_lae2"},
	{14838, "int_strip_club"},
	{14785, "gen_otb"},
	{4683, "ladtbuild2_lan2"},
	{5732, "donut01_lawn"},
	{18021, "int_din_donut_main"},
	{12853, "sw_gas01"},
	{17534, "cluckinbell1_lae"},
	{5168, "cluckinbell1_las2"},
	{5813, "lawnshop1"},
	{18022, "int_chick_main"},
	{18030, "gap"},
	{4572, "stolenbuilds11"},
	{4584, "halgroundlan2"},
	{18026, "clothes_shit"},
	{17517, "barberblock1_lae"},
	{5521, "idlewofuk06_lae"},
	{18007, "int_barbera12"},
	{14682, "int_tatooa10"},
	{18082, "cj_barber2"},
	{6095, "offvensp02_law"},
	{18045, "mp_ammu01"},
	{5106, "roadsbx_las2"},
	{18033, "munation_main"},
	{4552, "amubloksun1_lan"},
	{18018, "int_bars"},
	{5408, "laeexaminerbuild1"},
	{14665, "int_7_11a40"},
	{4022, "foodmart1_lan"},
	{18031, "clothesexl"},
	{6334, "rodeo02_law2"},
	{18008, "int_clothinga01"},
	{6385, "rodeo02tr_law2"},
	{6351, "rodeo05_law2"},
	{18025, "clothes_sports"},
	{6353, "sunbils04_law2"},
	{18024, "int_clothe_ship"},
	{5414, "laejeffers02"},
	{5637, "laealpha5"},
	{5459, "laejeffers01"},
	{12948, "sw_block01a"},
	{18065, "ab_sfammumain"},
	{12976, "sw_diner1"},
	{14655, "trukstp01"},
	{7497, "vgnorthwrehse14"},
	{12862, "sw_block03"},
	{5762, "foodmartlawn"},
	{14667, "int_7_11a41"},
	{5040, "unionliq_las"},
	{14670, "int_7_11a42"},
	{4858, "snpedland1_las"},
	{13361, "ce_pizza1"},
	{12924, "sw_block06"},
	{5140, "snpedtatshp"},
	{5853, "sunset21_lawn"},
	{18038, "gun-shop-vegas"},
	{13131, "sw_block05"},
	{12984, "sw_block11"},
	{18282, "cw_tsblock"},
	{9106, "vgseamuntn"},
	{18552, "cunts_ammun"},
	{18237, "cuntw_dinerwst"},
	{5403, "laehospital1"},
	{5402, "laehospground1"},
	{18028, "smllbarinterior"},
	{7088, "casinoshops1"},
	{7027, "vgnamunation1"},
	{7037, "vgnwalburger1"},
	{18020, "int_6burger_main"},
	{6907, "vgndwntwnshop1"},
	{6232, "canal_arch"},
	{8591, "olympic01_lvs"},
	{8592, "olympcrail01_lvs"},
	{14808, "strip2_building"},
	{8639, "chnatwnmll01_lvs"},
	{9055, "chnatwnmll15_lvs"},
	{6977, "stripshopn1"},
	{7599, "stripshopstat"},
	{7035, "vgsnwrehse17"},
	{16769, "desn2_ammun04"},
	{16563, "cn2_polis"},
	{14881, "barbara-cop"},
	--{6010, "lawnboigashot25"}, DON'T TOUCH THIS ONE
	{16387, "desn2_ammun"},
	{6946, "vgnwalgren1"},
	{6997, "strfshcpark69"},
	{7506, "vgnlowbuild057"},
	{18049, "ammu_twofloor"},
	{6947, "vgnmall258"},
	{17515, "scumgym1_lae"},
	{8242, "vegassedge10"},
	{6944, "vgnshopnmall02"},
	{7048, "vgnorthcoast03"},
	{7306, "vgnmallsigns04"},
	{7307, "vgnmallsigns05"},
	{7308, "vgnmallsigns06"},
	{7184, "vgnpolicebuild1"},
	{7009, "vgnpolicebuild2"},
	{7213, "vgnpolicecpark3"},
	{7658, "vgnbuild1new"},
	{14672, "int_sex01"},
	{7531, "vgnlowmall2"},
	{16055, "quarry_bit04"},
}

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		setCameraMatrix( 1000000, 1000000, 1000000)
		setElementFrozen(localPlayer, true)

		setTimer(
			function()
				for k, v in pairs(objects.replace) do
					local model = "files/" .. v[2] .. ".dff"
					local collision = "files/cols/" .. v[2] .. ".col"
					if not fileExists(model) then
						outputDebugString("FCEB: " .. model .. " doesn't exist.")
					elseif not fileExists(collision) then
						outputDebugString("FCEB: " .. collision .. " doesn't exist.")
					else
						engineReplaceCOL(engineLoadCOL(collision), v[1])
						engineReplaceModel(engineLoadDFF(model, v[1]), v[1])
					end
				end
			end, 500, 1)
		setTimer(
			function()
				setCameraTarget(localPlayer)
				setElementFrozen(localPlayer, false)
			end, 1000, 1)
	end
)
--Exclusive objects with just 1 collision or texture to replace for
-- Collisions
function flowerCols()
cola = engineLoadCOL( "col/lm_stripbar.col" )
engineReplaceCOL( cola, 14831 )
colb = engineLoadCOL( "col/int_ppol.col" )
engineReplaceCOL( colb, 14846 )
colc = engineLoadCOL( "col/laeroad23.col" )
engineReplaceCOL( colc, 5488 )
cold = engineLoadCOL( "col/laeroad33.col" )
engineReplaceCOL( cold, 5498 )
cole = engineLoadCOL( "col/laeroadsblk.col" )
engineReplaceCOL( cole, 5411 )
colf = engineLoadCOL( "col/dkcargohull2bd.col" )
engineReplaceCOL( colf, 5166 )
colg = engineLoadCOL( "col/laeroad26.col" )
engineReplaceCOL( colg, 5491 )
colh = engineLoadCOL( "col/laeroad29.col" )
engineReplaceCOL( colh, 5494 )
coli = engineLoadCOL( "col/road_lawn31.col" )
engineReplaceCOL( coli, 5862 )
colj = engineLoadCOL( "col/clifftestgrnd.col" )
engineReplaceCOL( colj, 4898 )
colk = engineLoadCOL( "col/laeroad17.col" )
engineReplaceCOL( colk, 5483 )
coll = engineLoadCOL( "col/laeroad16.col" )
engineReplaceCOL( coll, 5482 )
colm = engineLoadCOL( "col/gnhotel01_lvs.col" )
engineReplaceCOL( colm, 8409 )
coln = engineLoadCOL( "col/carparkhut02_lvs.col" )
engineReplaceCOL( coln, 8410 )
colo = engineLoadCOL( "col/int_boxing07.col" )
engineReplaceCOL( colo, 14825 )
colp = engineLoadCOL( "col/munation_xtras04.col" )
engineReplaceCOL( colp, 18053 )
colq = engineLoadCOL( "col/munation_xtras03.col" )
engineReplaceCOL( colq, 18052 )
colr = engineLoadCOL( "col/vendin3.col" )
engineReplaceCOL( colr, 1977 )
end
addEventHandler("onClientResourceStart", resourceRoot, flowerCols)

-- Textures
txda = engineLoadTXD ( "txd/vgnretail2.txd" )
engineImportTXD ( txda, 7506 )

-- World objects that can't be removed via Map Editor

removeWorldModel(1498,10,2229.66,-1720.42,12.5547) --LS Gym Door