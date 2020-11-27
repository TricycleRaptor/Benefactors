GM.Name		= "Benefactors"
GM.Author	= "TricycleRaptor"
GM.Email	= "arrinbevers@yahoo.com"
GM.Website  = ""
GM.TeamBased = true

DeriveGamemode( "base" )

--- Globals ---

TEAM_COMBINE = 1
TEAM_REBELS = 2

--- End Globals ---

function GM:CreateTeams()

   team.SetUp(TEAM_COMBINE, "Benefactors", Color(99, 66, 245, 255), true)
   team.SetUp(TEAM_REBELS, "Resistance", Color(245, 129, 66, 255), true)

end

--- Playermodels ---

local bfrs_combine_playermodels = {
   Model("models/player/combine_super_soldier_player_nova.mdl"), -- Elite Nova Soldier
   Model("models/player/combine_soldier_prisonguard.mdl") -- Common Nova Soldier
};

local bfrs_rebel_playermodels = {
   Model("models/player/group03/male_06.mdl"), -- White male
   Model("models/player/group03/male_03.mdl"), -- Black male
   Model("models/player/group03/male_05.mdl"), -- Asian male
   Model("models/player/group03/female_02.mdl"), -- White female
   Model("models/player/group03/female_05.mdl"), -- Black female
   Model("models/player/group03/female_04.mdl") -- Asian female
};

function GetRandomPlayerModel(ply)

	if(ply:Team() == TEAM_COMBINE) then
		return table.Random(bfrs_combine_playermodels) --Index a random model from the table of potential models.
	elseif (ply:Team() == TEAM_REBELS) then
		return table.Random(bfrs_rebel_playermodels) --Index a random model from the table of potential models.
	else
		return Model("")
	end

end

--- Playermodels End ---

--- Map Cleanup ---

function CleanupMapEntities()

	-- This function will remove items we don't want from the map such as healthkits, ammo, and weapons. This is important for loadout integrity and also ensures
	-- that we can use any maps that may come with items on the map by default, such as the Half-Life 2: Deathmatch maps or something like gm_boreas.

	local items = ents.FindByClass("item_*") -- Parse any item entities spawned by the map like healthkits or ammo for removal
	local weapons = ents.FindByClass("weapon_*") -- Parse any weapon entities spawned by the map for remvoval

	for k, v in pairs(items) do -- Find each item
		v:Remove() -- Remove it
	end

	for k, v in pairs(weapons) do -- Find each weapon
		v:Remove() -- Remove it
	end

	--print("[BFRS:] Map entities cleanup operated successfully.")

end

--game.CleanUpMap( false, { "bfrs_*" } )

-- This is commented out for now, but what the above function does is allow us to put in filters for ignoring entities when a map is cleaned up. This is especially
-- helpful for when we want to start new rounds and reset the map without removing critical entities like the team spawns and objectives established in the setup phase.
-- I added a wildcard example in the filter table that should encompass all entities we'll be making for the gamemode. This can and probably will change later.

function GM:PostCleanupMap() -- This is called after game.CleanUpMap is executed. This will be useful for removing entities we don't want in the map after a reset

	CleanupMapEntities() -- We'll call this again so we can clean up unwanted item and weapon entities that may come with the map by default

end

--- Map Cleanup End ---

--- Movement ---

hook.Add("OnPlayerHitGround", "BFRS.Land", function(ply, inWater, onFloater, speed)
	local pingTime = ply:Ping() * 0.001
	local lockTime = math.max(0.1 - pingTime, 0.01) -- account for player ping weirdness
	ply._landingTime = CurTime() + lockTime
end)

hook.Add("StartCommand", "BFRS.LandMovement", function(ply, cmd)
	if ply._landingTime then
		if CurTime() <= ply._landingTime then
			cmd:ClearMovement()
			cmd:RemoveKey(IN_JUMP)
		else
			ply._landingTime = nil
		end
	end
end)

--- Movement End ---