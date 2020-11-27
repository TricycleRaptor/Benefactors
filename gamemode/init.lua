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

function GM:InitPostEntity() -- This is called after the server has initialized the map and all entities within it

	CleanupMapEntities() -- Remove the entities we don't want in the map using the function defined in shared.lua

end