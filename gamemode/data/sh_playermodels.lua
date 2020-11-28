hook.Add("Initialize", "BFRS.LoadPlayerModels", function()
	-- Nova Prospect Elite
	player_manager.AddValidModel( "Nova Prospekt Elite", "models/player/combine_super_soldier_player_nova.mdl", true ) -- Add C_Hands for the custom Prison Elite Combine
	player_manager.AddValidHands( "Nova Prospekt Elite", "models/weapons/c_arms_combine.mdl", 0, "00000000" ) -- End C_Hands Registration
end)