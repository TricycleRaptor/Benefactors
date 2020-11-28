
-- function GM:ShowTeam()
-- 	if ( IsValid( self.TeamSelectFrame ) ) then return end
-- end

TEAM_FRAME = TEAM_FRAME or nil
function GM:ShowTeam()
	TEAM_FRAME = vgui.Create( "DFrame" )
	self.TeamSelectFrame = TEAM_FRAME

	TEAM_FRAME:SetTitle( "Pick Team" )
	TEAM_FRAME:SetBackgroundBlur(true)
	TEAM_FRAME:SetSize(ScrW(), ScrH())
	TEAM_FRAME:MakePopup()
	TEAM_FRAME:SetKeyboardInputEnabled( false )
	TEAM_FRAME:SetDraggable(false)
	TEAM_FRAME:ShowCloseButton(false)
	local startTime = SysTime()
	TEAM_FRAME.Paint = function(p)
		Derma_DrawBackgroundBlur(p, startTime - 1)
	end

	local title = vgui.Create("DLabel", TEAM_FRAME)
	title:SetTall(60)
	title:Dock(TOP)
	title:SetContentAlignment(8)
	title:SetFont("BFRS.MainTitle")
	title:SetColor(GAMEMODE.Color)
	title:SetText( string.upper(GAMEMODE.Name))

	local pickTeam = vgui.Create("DLabel", TEAM_FRAME)
	pickTeam:SetTall(40)
	pickTeam:Dock(TOP)
	pickTeam:SetContentAlignment(8)
	pickTeam:SetFont("BFRS.PickTeam")
	pickTeam:SetColor(GAMEMODE.Color)
	pickTeam:SetText( "Choose your side" )

	local bottomBar = vgui.Create("DPanel", TEAM_FRAME)
	bottomBar:SetTall(120)
	bottomBar:Dock(BOTTOM)
	bottomBar:InvalidateParent(true)
	bottomBar.Paint = nil

	local spectatorButton = vgui.Create("DButton", bottomBar)
	spectatorButton:SetFont("BFRS.PickTeam")
	spectatorButton:SetColor(GAMEMODE.Color)
	spectatorButton:SetText("Spectate")
	spectatorButton:SetTall(bottomBar:GetTall())
	spectatorButton.Paint = nil

	if ( GAMEMODE.AllowAutoTeam ) then
		local autoButton = vgui.Create("DButton", bottomBar)
		autoButton:SetFont("BFRS.PickTeam")
		autoButton:SetColor(GAMEMODE.Color)
		autoButton:SetText("Auto Team")
		autoButton:SetTall(bottomBar:GetTall())
		autoButton.Paint = nil

		autoButton.DoClick = function()
			self:HideTeam()
			RunConsoleCommand("autoteam")
		end
	end

	local bottomButtons = bottomBar:GetChildren()

	local bottomButtonCount = table.Count(bottomButtons)
	local buttonButtonWide = math.floor(bottomBar:GetWide()  / bottomButtonCount)
	for i, button in pairs(bottomButtons) do
		button:SetWide(buttonButtonWide)
		button:SetPos(buttonButtonWide * (i-1), 0)
	end


	local teamCount = table.Count(GAMEMODE.Teams)
	local teamWidth = math.floor(TEAM_FRAME:GetWide() / teamCount)

	for teamKey, teamData in pairs(GAMEMODE.Teams) do
		local teamPanel = vgui.Create("DPanel", TEAM_FRAME)

		local opacity = 0.1
		teamPanel.Paint = function(p, w, h)
			surface.SetAlphaMultiplier(opacity)
			surface.SetDrawColor(teamData.color)
			local size = w * 0.6
			local logoX, logoY = w*0.5 - size*0.5, h*0.5 - size*0.5
			surface.SetMaterial(teamData.logo)
			surface.DrawTexturedRect(logoX, logoY, size, size)

			surface.SetAlphaMultiplier(1)
		end

		teamPanel:SetWide( teamWidth )
		teamPanel:Dock(LEFT)
		teamPanel:DockPadding(10,10,10,10)

		teamLabel = vgui.Create("DLabel", teamPanel)
		teamLabel:SetTall(40)
		teamLabel:Dock(TOP)
		teamLabel:SetContentAlignment(8)
		teamLabel:SetFont("BFRS.PickTeam")
		teamLabel:SetColor(teamData.color)
		teamLabel:SetText(teamData.name)

		local model = table.Random(teamData.models)
		local modelPanel = vgui.Create("DModelPanel", teamPanel)
		modelPanel:Dock(FILL)
		modelPanel:SetModel(model)

		modelPanel.Think = function(p)
			if p:IsHovered() then
				opacity = math.Approach(opacity, 0.9, FrameTime() * 0.6)
			else
				opacity = math.Approach(opacity, 0.05, FrameTime() * 2)
			end
		end

		modelPanel.DoClick = function(p)
			self:HideTeam()
			RunConsoleCommand( "bfrs_changeteam", teamKey )
		end

	end
end

function GM:HideTeam()
	local teamFrame = self.TeamSelectFrame or TEAM_FRAME
	if ( IsValid(teamFrame) ) then
		teamFrame:Remove()
		teamFrame = nil
	end
end

GM:HideTeam()
GM:ShowTeam()