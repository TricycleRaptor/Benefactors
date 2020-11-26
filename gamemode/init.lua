AddCSLuaFile("shared.lua")
AddCSLuaFile("concommands.lua")
AddCSLuaFile("player.lua")
AddCSLuaFile("cl_pickteam.lua")

include("shared.lua")
include("concommands.lua")
include ("player.lua")

function GM:Initialize()
	
	-- Add C_Hands for the custom Prison Elite Combine
	player_manager.AddValidModel( "Nova Prospekt Elite", "models/player/combine_super_soldier_player_nova.mdl", true )
	player_manager.AddValidHands( "Nova Prospekt Elite", "models/weapons/c_arms_combine.mdl", 0, "00000000" )
	-- End C_Hands Registration

	-- Nullify playermodel
	GAMEMODE.force_plymodel = ""
	GAMEMODE.playermodel = ""

end