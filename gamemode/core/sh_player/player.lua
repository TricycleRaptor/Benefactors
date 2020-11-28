function GM:PlayerSpawn(ply)

   --hook.Call("PlayerLoadout", GAMEMODE, ply)
   hook.Call("PlayerSetModel", GAMEMODE, ply)

   ply:SetupHands()

end

function GM:PlayerSetModel(ply)

	-- Grab a random model from the two indexed team model tables
	local mdl = GetRandomPlayerModel(ply:Team()) or "models/player/kleiner.mdl"
	util.PrecacheModel(mdl)
	ply:SetModel(mdl)
	-- Playermodel is set
end

function GM:PlayerFootstep(ply, pos, foot)
	if(ply:Team() == TEAM_COMBINE) then
		if( ply:GetVelocity():Length2D() > 150 ) then -- Gear shuffle when moving at a certain speed
			local soundFile = foot == 0 and "NPC_MetroPolice.RunFootstepLeft" or "NPC_MetroPolice.RunFootstepRight"
			if CLIENT and ply == LocalPlayer() then
				ply:EmitSound(soundFile, 70, 100, 0.7)
			elseif SERVER then
				local filter = RecipientFilter()
				filter:AddPAS(ply:GetPos())
				filter:RemovePlayer(ply)

				local footSound = CreateSound(ply, soundFile, filter)
				footSound:SetSoundLevel(75)
				footSound:Play()
			end

			return true

		elseif ply:OnGround() then
			return false -- No gear shuffle
		end

	else -- Rebel team

		if( ply:GetVelocity():Length2D() > 150 ) then
			return false
		else
			return true -- Silent footsteps when crouch walking
		end

	end

	self.BaseClass:PlayerFootstep( ply, pos, foot, s, vol, rf );

end

function GM:PlayerCanJoinTeam( ply, teamid )

	local TimeBetweenSwitches = GAMEMODE.SecondsBetweenTeamSwitches or 10
	if ( ply.LastTeamSwitch && RealTime()-ply.LastTeamSwitch < TimeBetweenSwitches ) then
		ply.LastTeamSwitch = ply.LastTeamSwitch + 1
		ply:ChatPrint( Format( "[BFRS:] Please wait %i seconds before trying to change teams.", ( TimeBetweenSwitches - ( RealTime() - ply.LastTeamSwitch ) ) + 1 ) )
		return false
	end

	-- Already on this team!
	if ( ply:Team() == teamid ) then
		ply:ChatPrint( "[BFRS:] You're already on that team." )
		return false
	end

	return true

end

function GM:PlayerRequestTeam( ply, teamid )

	-- This team isn't joinable
	if ( !team.Joinable( teamid ) ) then
		ply:ChatPrint( "[BFRS:] You can't join that team." )
	return end

	-- This team isn't joinable
	if ( !GAMEMODE:PlayerCanJoinTeam( ply, teamid ) ) then
		-- Messages here should be outputted by this function
	return end

	GAMEMODE:PlayerJoinTeam( ply, teamid )

end

function GM:PlayerJoinTeam( ply, teamid )

	local iOldTeam = ply:Team()

	if ( ply:Alive() ) then
		if ( iOldTeam == TEAM_SPECTATOR || iOldTeam == TEAM_UNASSIGNED ) then
			ply:KillSilent()
		else
			ply:Kill()
		end
	end

	ply:SetTeam( teamid )
	ply.LastTeamSwitch = RealTime()

	GAMEMODE:OnPlayerChangedTeam( ply, iOldTeam, teamid )

end

function GM:OnPlayerChangedTeam( ply, oldteam, newteam )

	-- Here's an immediate respawn thing by default. If you want to
	-- re-create something more like CS or some shit you could probably
	-- change to a spectator or something while dead.
	if ( newteam == TEAM_SPECTATOR ) then

		-- If we changed to spectator mode, respawn where we are
		local Pos = ply:EyePos()
		ply:Spawn()
		ply:SetPos( Pos )

	elseif ( oldteam == TEAM_SPECTATOR ) then

		-- If we're changing from spectator, join the game
		ply:Spawn()

	else

		-- If we're straight up changing teams just hang
		-- around until we're ready to respawn onto the
		-- team that we chose

	end

	PrintMessage( HUD_PRINTTALK, Format( "[BFRS:] %s joined the %s!", ply:Nick(), team.GetName( newteam ) ) )

end