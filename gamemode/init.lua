AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function GM:Initialize()
	-- Nullify playermodel
	GAMEMODE.force_plymodel = ""
	GAMEMODE.playermodel = ""
end