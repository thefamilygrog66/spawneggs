local spawneggs_list = {
	{ "Spawn Dirt Monster", "dirt_monster", "default:dirt"},
	{ "Spawn Dungeon Master", "dungeon_master", "default:mese"},	
	{ "Spawn Oerkki", "oerkki", "default:obsidian"},
	{ "Spawn Rat", "rat", "mobs:rat"},
	{ "Spawn Sand Monster", "sand_monster", "default:sand"},
	{ "Spawn Sheep", "sheep", "wool:white"},
	{ "Spawn Stone Monster", "stone_monster", "default:stone"},
	{ "Spawn Tree Monster", "tree_monster", "default:sapling"},
}

for i in ipairs(spawneggs_list) do
	local spawneggdesc = spawneggs_list[i][1]
	local eggtype = spawneggs_list[i][2]
	local ingredient = spawneggs_list[i][3]
	
	minetest.register_craftitem("spawneggs:"..eggtype, {
		description = spawneggdesc,
		inventory_image = "spawneggs_"..eggtype..".png",
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.above then
				minetest.env:add_entity(pointed_thing.above, "mobs:"..eggtype)
				itemstack:take_item()
			end
			return itemstack
		end,
	})
	
	minetest.register_craft({
		output = "spawneggs:"..eggtype,
		recipe = {
	                {"spawneggs:egg", ingredient, ""},
	                {"", "", ""},
	                {"", "", ""},
	        },
	})	
end

minetest.register_node("spawneggs:egg", {
	description = "Spawning Egg",
	drawtype = "plantlike",
	tiles = {"spawneggs_egg.png"},
	inventory_image = "spawneggs_egg.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3125, -0.5, -0.3125, 0.3125, 0.5, 0.3125}
	},
	groups = {cracky=3},
	drop = "spawneggs:egg",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_abm(
	{nodenames = {"default:grass_1"},
	interval = 30,
	chance = 100,
	action = function(pos)
	minetest.env:add_node(pos, {name="spawneggs:egg"})
	end,
})
