local kBlipColorType 	= GetUpValue( GUIMinimap.Initialize,   "kBlipColorType", 		{ LocateRecurse = true } )
local kStaticBlipsLayer = GetUpValue( GUIMinimap.Initialize,   "kStaticBlipsLayer", 	{ LocateRecurse = true } )
local kBlipSize 		= GetUpValue( GUIMinimap.SetBlipScale, "kBlipSize", 			{ LocateRecurse = true } )
local kBlipSizeType 	= GetUpValue( GUIMinimap.Initialize,   "kBlipSizeType", 		{ LocateRecurse = true } )
local kBlipInfo 		= GetUpValue( GUIMinimap.Initialize,   "kBlipInfo", 			{ LocateRecurse = true } )

Class_AddMethod("GUIMinimap", "UpdateCHUDCommSettings",
	function(self)
		local player = Client.GetLocalPlayer()
		if player:isa("Commander") then
			local mingui = not CHUDGetOption("mingui")
		
			local selectionPanelScript = GetGUIManager():GetGUIScriptSingle("GUISelectionPanel")
			local minimapButtons = GetGUIManager():GetGUIScriptSingle("GUIMinimapButtons")
			local resourceDisplay = GetGUIManager():GetGUIScriptSingle("GUIResourceDisplay")
			local logoutScript = GetGUIManager():GetGUIScriptSingle("GUICommanderLogout")
			local commanderTooltip = GetGUIManager():GetGUIScriptSingle("GUICommanderTooltip")
			local minimapFrame = ClientUI.GetScript("GUIMinimapFrame")
			
			// Move buttons off-screen so we can click through
			local buttonPos = ConditionalValue(mingui, 0, -9999)
			minimapButtons.background:SetIsVisible(mingui)
			minimapButtons.pingButton:SetPosition(Vector(buttonPos,0,0))
			minimapButtons.techMapButton:SetPosition(Vector(buttonPos,0,0))
			
			if player:isa("MarineCommander") then
				local frameTexture = ConditionalValue(mingui, "ui/marine_commander_textures.dds", "ui/transparent.dds")
				local buttonsTexture = ConditionalValue(mingui, GUICommanderButtonsMarines:GetBackgroundTextureName(), "ui/transparent.dds")
				local selectionTexture = ConditionalValue(mingui, GUISelectionPanel.kSelectionTextureMarines, "ui/transparent.dds")
				local logoutTexture = ConditionalValue(mingui, GUICommanderLogout.kLogoutMarineTextureName, "ui/transparent.dds")
				local tooltipTexture = ConditionalValue(mingui, GUICommanderTooltip.kMarineBackgroundTexture, "ui/transparent.dds")
				
				minimapFrame.minimapFrame:SetTexture(frameTexture)
				minimapFrame.buttonsScript.background:SetTexture(buttonsTexture)
				selectionPanelScript.background:SetTexture(selectionTexture)
				logoutScript.background:SetTexture(logoutTexture)
				commanderTooltip.backgroundTop:SetTexture(tooltipTexture)
				commanderTooltip.backgroundCenter:SetTexture(tooltipTexture)
				commanderTooltip.backgroundBottom:SetTexture(tooltipTexture)
			elseif player:isa("AlienCommander") then
				local buttonsTexture = ConditionalValue(mingui, "ui/alien_commander_smkmask.dds", "ui/transparent.dds")
				local selectionTexture = ConditionalValue(mingui, "ui/alien_logout_smkmask.dds", "ui/transparent.dds")
				local smokeTexture = ConditionalValue(mingui, "ui/alien_minimap_smkmask.dds", "ui/transparent.dds")
				local resourceTexture = ConditionalValue(mingui, "ui/alien_ressources_smkmask.dds", "ui/transparent.dds")
				local logoutTexture = ConditionalValue(mingui, "ui/alien_logout_smkmask.dds", "ui/transparent.dds")
				local tooltipTexture = ConditionalValue(mingui, "ui/alien_logout_smkmask.dds", "ui/transparent.dds")

				minimapFrame.buttonsScript.smokeyBackground:SetTexture(buttonsTexture)
				selectionPanelScript.smokeyBackground:SetTexture(selectionTexture)
				minimapFrame.smokeyBackground:SetTexture(smokeTexture)
				resourceDisplay.smokeyBackground:SetTexture(resourceTexture)
				logoutScript.smokeyBackground:SetTexture(logoutTexture)
				commanderTooltip.smokeyBackground:SetTexture(tooltipTexture)
				
				local biomass = ClientUI.GetScript("GUIBioMassDisplay")
				local biomassTexture = ConditionalValue(mingui, "ui/biomass_bar.dds", "ui/transparent.dds")
				
				biomass.smokeyBackground:SetIsVisible(mingui)
				biomass.background:SetTexture(biomassTexture)
			end
		end
	end)

local minimapScript

local originalMinimapInit
originalMinimapInit = Class_ReplaceMethod( "GUIMinimap", "Initialize",
function(self)
	originalMinimapInit(self)
	
	self.minimap:SetColor(Color(1,1,1,CHUDGetOption("minimapalpha")))
	self.lastMinGUI = CHUDGetOption("mingui")
	
	local friends = CHUDGetOption("friends")
	ReplaceLocals(PlayerUI_GetStaticMapBlips, { kMinimapBlipTeamFriendAlien =
		ConditionalValue(friends, kMinimapBlipTeam.FriendAlien, kMinimapBlipTeam.Alien) } )
	ReplaceLocals(PlayerUI_GetStaticMapBlips, { kMinimapBlipTeamFriendMarine =
		ConditionalValue(friends, kMinimapBlipTeam.FriendMarine, kMinimapBlipTeam.Marine) } )
	
	minimapScript = self
end)
	
	
local originalCommanderInit
originalCommanderInit = Class_ReplaceMethod( "Commander", "OnInitLocalClient",
function(self)
	originalCommanderInit(self)
	
	minimapScript:UpdateCHUDCommSettings()
	
	self.gameTime = GUIManager:CreateTextItem()
	self.gameTime:SetFontName(GUIMarineHUD.kTextFontName)
	self.gameTime:SetFontIsBold(true)
	self.gameTime:SetLayer(kGUILayerPlayerHUDForeground2)
	self.gameTime:SetColor(Color(0.5, 0.5, 0.5, 1))
	self.gameTime:SetPosition(Vector(35, 60, 0))
end)

local originalCommanderUpdate
originalCommanderUpdate = Class_ReplaceMethod( "Commander", "UpdateMisc",
function(self, input)
	originalCommanderUpdate(self, input)
	
	if self.gameTime then
		self.gameTime:SetText(CHUDGetGameTime())
		self.gameTime:SetIsVisible(CHUDGetOption("gametime"))
	end
end)

local originalCommanderOnDestroy
originalCommanderOnDestroy = Class_ReplaceMethod( "Commander", "OnDestroy",
function(self)
	GUI.DestroyItem(self.gameTime)
	self.gameTime = nil
	originalCommanderOnDestroy(self)
end)


local marinePlayers = set {
	kMinimapBlipType.Marine, kMinimapBlipType.JetpackMarine, kMinimapBlipType.Exo
}
local alienPlayers = set {
	kMinimapBlipType.Skulk, kMinimapBlipType.Gorge, kMinimapBlipType.Lerk, kMinimapBlipType.Fade, kMinimapBlipType.Onos, 
}

local OnSameMinimapBlipTeam, MinimapBlipTeamIsActive, PulseRed, PulseDarkRed

if Shared.GetBuildNumber() < 275 then
	OnSameMinimapBlipTeam = GetUpValue (GUIMinimap.Update,   "OnSameMinimapBlipTeam", { LocateRecurse = true } )
	MinimapBlipTeamIsActive = GetUpValue (GUIMinimap.Update, "MinimapBlipTeamIsActive", { LocateRecurse = true } )
	PulseRed = GetUpValue (GUIMinimap.Update, "PulseRed", { LocateRecurse = true } )
	PulseDarkRed = GetUpValue (GUIMinimap.Update, "PulseDarkRed", { LocateRecurse = true } )
else
	OnSameMinimapBlipTeam = MinimapMappableMixin.OnSameMinimapBlipTeam
	MinimapBlipTeamIsActive = MinimapMappableMixin.MinimapBlipTeamIsActive
	PulseRed = MinimapMappableMixin.PulseRed
	PulseDarkRed = MinimapMappableMixin.PulseDarkRed
end

local OldGUIItemSetColor = GUIItem.SetColor
local function NewGUIItemSetColor( blip, blipColor )
	local vars = GetLocalsFromCallingFunction()	
	local blipType, isHallucination, playerTeam, blipTeam, spectating, underAttack = 
		vars.blipType, vars.isHallucination, vars.playerTeam, vars.blipTeam, vars.spectating, vars.underAttack
	
	if blipType and playerTeam and blipTeam then
		if marinePlayers[blipType] then
			blipColor = ColorIntToColor(CHUDGetOption("playercolor_m"))
		elseif alienPlayers[blipType] then
			blipColor = ColorIntToColor(CHUDGetOption("playercolor_a"))
		end
			
		if blip and blipColor and not isHallucination then
			if OnSameMinimapBlipTeam(playerTeam, blipTeam) or spectating then

				if underAttack then
					if MinimapBlipTeamIsActive(blipTeam) then
						blipColor = PulseRed(1.0)
					else
						blipColor = PulseDarkRed(blipColor)
					end
				end
			end
		end
	end
	
	OldGUIItemSetColor( blip, blipColor )
end


local originalMinimapUpdate
originalMinimapUpdate = Class_ReplaceMethod( "GUIMinimap", "Update",
function(self, deltaTime)
	GUIItem.SetColor = NewGUIItemSetColor
	
	originalMinimapUpdate(self, deltaTime)
	
	GUIItem.SetColor = OldGUIItemSetColor
	
	local mingui = CHUDGetOption("mingui")
	if self.lastMinGUI ~= mingui then
		self:UpdateCHUDCommSettings()
		self.lastMinGUI = mingui
	end

end)


local originalLocationNameInit
originalLocationNameInit = Class_ReplaceMethod( "GUIMinimap", "InitializeLocationNames",
	function(self)
		originalLocationNameInit(self)
		if self.locationItems ~= nil then
			for _, locationItem in ipairs(self.locationItems) do
				locationItem.text:SetColor( Color(1, 1, 1, CHUDGetOption("locationalpha")) )
			end

		end
	end)

local originalMinimapSendKeyEvent
originalMinimapSendKeyEvent = Class_ReplaceMethod( "GUIMinimap", "SendKeyEvent",
	function(self, key, down)
	
		local player = Client.GetLocalPlayer()
		
		if GetIsBinding(key, "ShowMap") and not ChatUI_EnteringChatMessage() and not player:isa("Commander") and CHUDGetOption("minimaptoggle") == 1 then
		
			if not down then
		
				local showMap = not self.background:GetIsVisible()
				self:ShowMap(showMap)
				self:SetBackgroundMode(GUIMinimapFrame.kModeBig)
			
			end
			
			return true
			
		else
			originalMinimapSendKeyEvent(self, key, down)
		end
	end)

local oldSetPlayerIconColor
oldSetPlayerIconColor = Class_ReplaceMethod( "GUIMinimap", "SetPlayerIconColor",
	function(self, color)
		if CHUDGetOption("minimaparrowcolor") ~= 1 then
			self.playerIconColor = ColorIntToColor(CHUDGetOption("minimaparrowcolor"))
		else
			oldSetPlayerIconColor(self, color)
		end
	end)