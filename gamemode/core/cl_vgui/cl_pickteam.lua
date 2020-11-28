
-- function GM:ShowTeam()
-- 	if ( IsValid( self.TeamSelectFrame ) ) then return end
-- end


function GM:ShowTeam()
		-- Simple team selection box
	self.TeamSelectFrame = vgui.Create( "DFrame" )
	self.TeamSelectFrame:SetTitle( "Pick Team" )
	-- self.TeamSelectFrame:SetWide(150)

	local AllTeams = team.GetAllTeams()
	self.TeamSelectFrame:DockPadding(10,30,10,10)

	for ID, TeamInfo in pairs ( AllTeams ) do
	
		if ( ID != TEAM_CONNECTING && ID != TEAM_UNASSIGNED ) then
	
			local Team = vgui.Create( "DButton", self.TeamSelectFrame )

			function Team.DoClick() 
                self:HideTeam() RunConsoleCommand( "bfrs_changeteam", ID ) 
            end

			Team:SetTall(20)
			Team:DockMargin(0, 0, 0, 5)
			Team:Dock(TOP)
			Team:SetSize( 130, 20 )
			Team:SetText( TeamInfo.Name )
			
			if ( IsValid( LocalPlayer() ) && LocalPlayer():Team() == ID ) then
				Team:SetDisabled( true )
			end
		
		end
		
	end

	if ( GAMEMODE.AllowAutoTeam ) then
	
		local Team = vgui.Create( "DButton", self.TeamSelectFrame )

		function Team.DoClick() 
			self:HideTeam() 
			RunConsoleCommand( "autoteam" ) 
		end

		Team:SetTall(20)
		Team:DockMargin(0, 0, 0, 5)
		Team:Dock(TOP)
		Team:SetText( "Auto" )
	end

	self.TeamSelectFrame:SetSize(150, 200)
	self.TeamSelectFrame:Center()
	self.TeamSelectFrame:MakePopup()
	self.TeamSelectFrame:SetKeyboardInputEnabled( false )

end

function GM:HideTeam()
	if ( IsValid(self.TeamSelectFrame) ) then
		self.TeamSelectFrame:Remove()
		self.TeamSelectFrame = nil
	end
end