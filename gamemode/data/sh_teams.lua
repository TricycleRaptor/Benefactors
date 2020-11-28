--- Globals ---

TEAM_COMBINE = 1
TEAM_REBELS = 2

local logoParams = "smooth"

GM.Teams = {
	[TEAM_COMBINE] = {
		name = "Benefactors",
		color = Color(99, 66, 245, 255),
		joinable = true,
		logo = CLIENT and Material("vgui/bfrs/team_benefactors.png", logoParams),
		models = {
			Model("models/player/combine_super_soldier_player_nova.mdl"), -- Elite Nova Soldier
			Model("models/player/combine_soldier_prisonguard.mdl") -- Common Nova Soldier
		}
	},
	[TEAM_REBELS]= {
		name = "Resistance",
		color = Color(245, 129, 66, 255),
		joinable = true,
		logo = CLIENT and Material("vgui/bfrs/team_resistance.png", logoParams),
		models = {
			Model("models/player/group03/male_06.mdl"), -- White male
			Model("models/player/group03/male_03.mdl"), -- Black male
			Model("models/player/group03/male_05.mdl"), -- Asian male
			Model("models/player/group03/female_02.mdl"), -- White female
			Model("models/player/group03/female_05.mdl"), -- Black female
			Model("models/player/group03/female_04.mdl") -- Asian female
		}
	}
}


--- End Globals ---

function GM:CreateTeams()
	for teamKey, teamData in pairs(GAMEMODE.Teams) do
		team.SetUp(teamKey, teamData.name, teamData.color, teamData.joinable)
	end
end

--- Playermodels ---
function GetRandomPlayerModel(teamKey)
	local teamData = GAMEMODE.Teams[teamKey]
	return teamData and teamData.models and table.Random(teamData.models) or nil
end