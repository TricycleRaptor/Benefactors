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

function GetRandomPlayerModel(team)
	if(team == TEAM_COMBINE) then
		return table.Random(bfrs_combine_playermodels) --Index a random model from the table of potential models.
	elseif (team == TEAM_REBELS) then
		return table.Random(bfrs_rebel_playermodels) --Index a random model from the table of potential models.
	else
		return Model("")
	end

end