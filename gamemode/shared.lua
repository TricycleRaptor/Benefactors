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