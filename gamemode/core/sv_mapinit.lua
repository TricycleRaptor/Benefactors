local cleanUpEntities = {
	"item_*",  -- Parse any item entities spawned by the map like healthkits or ammo for removal
	"weapon_*"  -- Parse any weapon entities spawned by the map for remvoval
}

function CleanupMapEntities()
	-- This function will remove items we don't want from the map such as healthkits, ammo, and weapons. This is important for loadout integrity and also ensures
	-- that we can use any maps that may come with items on the map by default, such as the Half-Life 2: Deathmatch maps or something like gm_boreas.
	for _, class in pairs(cleanUpEntities) do
		for _, ent in pairs(ents.FindByClass(class)) do -- Find each weapon
			ent:Remove() -- Remove it
		end
	end
	--print("[BFRS:] Map entities cleanup operated successfully.")
end

--game.CleanUpMap( false, { "bfrs_*" } )

-- This is commented out for now, but what the above function does is allow us to put in filters for ignoring entities when a map is cleaned up. This is especially
-- helpful for when we want to start new rounds and reset the map without removing critical entities like the team spawns and objectives established in the setup phase.
-- I added a wildcard example in the filter table that should encompass all entities we'll be making for the gamemode. This can and probably will change later.

function GM:InitPostEntity() -- This is called after the server has initialized the map and all entities within it
	CleanupMapEntities() -- Remove the entities we don't want in the map using the function defined in shared.lua
end