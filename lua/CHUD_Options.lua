local function CHUDRestartScripts(scripts)

	for _, currentScript in pairs(scripts) do
		local script = ClientUI.GetScript(currentScript)
		if script then
			script:Uninitialize()
			script:Initialize()
		end
	end
	
end

CHUDOptions =
{
			mingui = {
				name    = "CHUD_MinGUI",
				label   = "Minimal GUI",
				tooltip = "Removes backgrounds/scanlines from all UI elements.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				applyFunction = function() CHUDRestartScripts({
					"Hud/Marine/GUIMarineHUD",
					"GUIAlienHUD",
					}) end,
				sort = "A1",
			},
			wps = {
				name    = "CHUD_Waypoints",
				label   = "Waypoints",
				tooltip = "Disables or enables all waypoints except Attack orders (waypoints can still be seen on minimap).",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "A2",
			},
			autowps = { 
                name    = "CHUD_AutoWPs",
                label   = "Automatic waypoints",
				tooltip = "Enables or disables automatic waypoints (not given by the commander).",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "A3",
            },
			minwps = {
				name    = "CHUD_MinWaypoints",
				label   = "Minimal waypoints",
				tooltip = "Toggles all text/backgrounds and only leaves the waypoint icon.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "A4",
			},
			minnps = {
				name    = "CHUD_MinNameplates",
				label   = "Minimal nameplates",
				tooltip = "Toggles building names and health/armor bars with a simple %.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "A5",
			},
			smallnps = {
				name    = "CHUD_SmallNameplates",
				label   = "Small nameplates",
				tooltip = "Makes fonts in the nameplates smaller.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "A6",
			},
			smalldmg = {
				name    = "CHUD_SmallDMG",
				label   = "Small damage numbers",
				tooltip = "Makes the damage numbers smaller.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "A7",
			}, 
			av = {
				name    = "CHUD_AV",
				label   = "Alien vision",
				tooltip = "Lets you choose between different Alien Vision types.",
				type    = "select",
				values  = { "Default", "Huze's Old AV", "Huze's Minimal AV", "Uke's AV" },
				valueTable = {
					"shaders/DarkVision.screenfx",
					"shaders/HuzeOldAV.screenfx",
					"shaders/HuzeMinAV.screenfx",
					"shaders/UkeAV.screenfx",
				},
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "func",
				valueType = "int",
				applyFunction = function() CHUDRestartScripts({	"GUIAlienHUD" }) end,
				sort = "B1",
			},
			avstate = { 
                name    = "CHUD_AVState",
                label   = "Default AV state",
				tooltip = "Sets the state the alien vision will be in when you respawn.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "B2",
            },
			hpbar = {
				name    = "CHUD_HPBar",
				label   = "Marine health bars",
				tooltip = "Enables or disables the health bars from the marine HUD.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "func",
				valueType = "bool",
				applyFunction = function() CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" }) end,
				sort = "C1",
			},
			alienbars = {
				name    = "CHUD_AlienBars",
				label   = "Alien bars",
				tooltip = "Lets you choose between different alien bars.",
				type    = "select",
				values  = { "Default", "Oma", "Rantology" },
				valueTable  = { "ui/alien_hud_health.dds", "ui/oma_alien_hud_health.dds", "ui/rant_alien_hud_health.dds" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "func",
				valueType = "int",
				applyFunction = function() CHUDRestartScripts({	"GUIAlienHUD" }) end,
				sort = "C2",
			}, 
			instantalienhealth = {
				name    = "CHUD_InstantAlienHealth",
				label   = "Instant Alien Health Bar",
				tooltip = "Update alien health bar instantly instead of animating.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				sort = "C3"
			},
			motiontracking = {
				name    = "CHUD_MotionTracking",
				label   = "Motion tracking circle",
				tooltip = "Lets you choose between default scan circles and a minimal one.",
				type    = "select",
				values  = { "Default", "Minimal" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "func",
				valueType = "int",
				sort = "C4"
			},
			dmgcolor_m = {
				name    = "CHUD_DMGColorM",
				label   = "Marine damage numbers color",
				tooltip = "Changes the color of the marine damage numbers.",
				type    = "select",
				values  = { "Default", "Red", "Green", "Blue", "Yellow", "Magenta", "Cyan", "Orange", "Black", "White" },
				valueTable = { 0x4DDBFF, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0xFF00FF, 0x00FFFF, 0xFFA500, 0x000000, 0xFFFFFF },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "func",
				valueType = "int",
				sort = "D1",
			},
			dmgcolor_a = {
				name    = "CHUD_DMGColorA",
				label   = "Alien damage numbers color",
				tooltip = "Changes the color of the alien damage numbers.",
				type    = "select",
				values  = { "Default", "Red", "Green", "Blue", "Yellow", "Magenta", "Cyan", "Orange", "Black", "White" },
				valueTable = { 0xFFCA3A, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0xFF00FF, 0x00FFFF, 0xFFA500, 0x000000, 0xFFFFFF },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "func",
				valueType = "int",
				sort = "D2",
			},
			blur = {
				name    = "CHUD_Blur",
				label   = "Blur",
				tooltip = "Removes the background blur from menus/minimap.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "E1"
			},
			particles = {
				name    = "CHUD_Particles",
				label   = "Minimal particles",
				tooltip = "Toggles between default and less vision obscuring particles.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "func",
				valueType = "bool",
				applyFunction = SetCHUDCinematics,
				sort = "E2"
			}, 
			tracers = {
				name    = "CHUD_Tracers",
				label   = "Weapon tracers",
				tooltip = "Enables or disables weapon tracers.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "func",
				valueType = "bool",
				sort = "E3",
			},
			
			
			score = {
				name    = "CHUD_ScorePopup",
				label   = "Score popup",
				tooltip = "Disables or enables score popup (+5).",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "A1",
			},
			assists = {
				name    = "CHUD_Assists",
				label   = "Assist score popup",
				tooltip = "Disables or enables the assists score popup.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "A2",
			},
			banners = {
				name    = "CHUD_Banners",
				label   = "Objective banners",
				tooltip = "Removes the banners in the center of the screen (\"Commander needed\", \"Power node under attack\", \"Evolution lost\", etc.).",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "B1",
			},
			unlocks = {
				name    = "CHUD_Unlocks",
				label   = "Research notifications",
				tooltip = "Removes the research completed notifications on the right side of the screen.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "B2",
			}, 
			minimap = {
				name    = "CHUD_Minimap",
				label   = "Marine minimap",
				tooltip = "Toggles the minimap and location name.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "C1",
				applyFunction = function() CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" }) end,
			},
			showcomm = {
				name    = "CHUD_CommName",
				label   = "Comm name/Team res",
				tooltip = "Enables or disables showing the commander name and team resources.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "C2",
				applyFunction = function() CHUDRestartScripts({
					"Hud/Marine/GUIMarineHUD",
					"GUIAlienHUD",
					}) end,
			}, 
			gametime = {
				name    = "CHUD_Gametime",
				label   = "Game time",
				tooltip = "Adds or removes the game time on the top left.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				sort = "C3",
				applyFunction = function() CHUDRestartScripts({
					"Hud/Marine/GUIMarineHUD",
					"GUIAlienHUD",
					}) end,
			},
			commactions = {
				name    = "CHUD_CommActions",
				label   = "Marine comm actions",
				tooltip = "Shows or hides the last commander actions.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				sort = "C4",
				applyFunction = function() CHUDRestartScripts({ "Hud/Marine/GUIMarineHUD" }) end,
			}, 
			minimapalpha = { 
                name    = "CHUD_MinimapAlpha",
                label   = "Overview transparency",
				tooltip = "Sets the trasparency of the map overview.",
				type    = "slider",
				sliderCallback = CHUDMinimapSlider,
				defaultValue = 0.85,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					local minimapScript = ClientUI.GetScript("GUIMinimapFrame")
					minimapScript:GetMinimapItem():SetColor(Color(1,1,1,CHUDGetOption("minimapalpha")))
				end,
				sort = "C5",
            },
            locationalpha = { 
                name    = "CHUD_LocationAlpha",
                label   = "Location transparency",
				tooltip = "Sets the trasparency of the location text on the minimap.",
				type    = "slider",
				sliderCallback = CHUDLocationSlider,
				defaultValue = 0.65,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function()
					OnCommandSetMapLocationColor("255", "255", "255", tostring(tonumber(CHUDGetOption("locationalpha"))*255))
				end,
				sort = "C6",
            },
			classicammo = {
				name    = "CHUD_ClassicAmmo",
				label   = "Classic ammo counter",
				tooltip = "Toggles a classic ammo counter on the bottom right of the HUD.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "hud",
				valueType = "bool",
			},
			friends = {
				name    = "CHUD_Friends",
				label   = "Friends highlighting",
				tooltip = "Enables or disables the friend highlighting in the scoreboard/nameplates.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool",
				applyFunction = function() 	local friends = CHUDGetOption("friends")
					ReplaceLocals(PlayerUI_GetStaticMapBlips, { kMinimapBlipTeamFriendAlien =
						ConditionalValue(friends, kMinimapBlipTeam.FriendAlien, kMinimapBlipTeam.Alien) } )
					ReplaceLocals(PlayerUI_GetStaticMapBlips, { kMinimapBlipTeamFriendMarine =
						ConditionalValue(friends, kMinimapBlipTeam.FriendMarine, kMinimapBlipTeam.Marine) } )
				end,
			}, 
			hitindicator = { 
                name    = "CHUD_HitIndicator",
                label   = "Hit indicator fade time",
				tooltip = "Controls the speed of the crosshair hit indicator.",
                type    = "slider",
				sliderCallback = CHUDHitIndicatorSlider,
				defaultValue = 1,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "hud",
				valueType = "float",
				applyFunction = function() Player.kShowGiveDamageTime = CHUDGetOption("hitindicator") end,
            },
			kda = {
				name    = "CHUD_KDA",
				label   = "KDA/KAD",
				tooltip = "Switches the scoreboard between KAD and KDA.",
				type    = "select",
				values  = { "KAD", "KDA" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "hud",
				valueType = "bool",
				applyFunction = function() CHUDRestartScripts({ "GUIScoreboard" }) end,
			},
			rtcount = {
				name    = "CHUD_RTcount",
				label   = "RT count dots",
				tooltip = "Toggles the RT count dots at the bottom and replaces them with a number.",
				type    = "select",
				values  = { "Number", "Dots" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "hud",
				valueType = "bool"
			},
			uplvl = {
				name    = "CHUD_UpgradeLevel",
				label   = "Upgrade level UI",
				tooltip = "Changes between disabled, default or old icons for marine upgrades.",
				type    = "select",
				values  = { "Disabled", "Default", "NS2 Beta" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 1,
				category = "hud",
				valueType = "int",
				applyFunction = function() local script = ClientUI.GetScript("Hud/Marine/GUIMarineHUD")
					if script then
						script:ShowNewWeaponLevel(PlayerUI_GetWeaponLevel())
						script:ShowNewArmorLevel(PlayerUI_GetArmorLevel())
					end
				end,
			}, 
			
			
			hitsounds = {
				name    = "CHUD_Hitsounds",
				label   = "Hitsounds",
				tooltip = "Enables or disables server confirmed hitsounds.",
				type    = "select",
				values  = { "Disabled", "Quake 3", "Quake 4", "Dystopia" },
				valueTable = { "null",
					"sound/hitsounds.fev/hitsounds/q3",
					"sound/hitsounds.fev/hitsounds/q4",
					"sound/hitsounds.fev/hitsounds/dys",
				},
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "A1",
			},
			hitsounds_pitch = { 
                name    = "CHUD_HitsoundsPitch",
                label   = "Hitsounds pitch modifier",
				tooltip = "Sets the pitch for high damage hits (only shotgun).",
				type    = "select",
				values  = { "Low pitch", "High pitch" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 0,
				category = "comp",
				valueType = "int",
				sort = "A2",
            },
			hitsounds_vol = { 
                name    = "CHUD_HitsoundsVolume",
                label   = "Hitsounds volume",
				tooltip = "Sets the volume for hitsounds.",
				type    = "slider",
				sliderCallback = CHUDHitsoundsSlider,
				defaultValue = 0.75,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "comp",
				valueType = "float",
				sort = "A3",
            },
			ambient = {
				name    = "CHUD_Ambient",
				label   = "Ambient sounds",
				tooltip = "Enables or disables map ambient sounds.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "comp",
				valueType = "bool",
				applyFunction = SetCHUDAmbients,
				sort = "B1",
			}, 
			mapparticles = {
				name    = "CHUD_MapParticles",
				label   = "Map particles",
				tooltip = "Enables or disables particles, holograms and other map specific effects.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = true,
				category = "comp",
				valueType = "bool",
				applyFunction = SetCHUDCinematics,
				sort = "B2",
			}, 
			nsllights = {
				name    = "lowLights",
				label   = "NSL Low lights",
				tooltip = "Replaces the low quality option lights with the lights from the NSL maps.",
				type    = "select",
				values  = { "Off", "On" },
				callback = CHUDSaveMenuSettings,
				defaultValue = false,
				category = "comp",
				valueType = "bool",
				applyFunction = function()
					lowLightsSwitched = false
					CHUDLoadLights()
				end,
				sort = "B3",
			}, 
			flashatmos = { 
                name    = "CHUD_FlashAtmos",
                label   = "Flashlight atmospherics",
				tooltip = "Sets the atmospheric density of flashlights.",
				type    = "slider",
				sliderCallback = CHUDFlashAtmosSlider,
				defaultValue = 1,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "comp",
				valueType = "float",
				sort = "C1",
            },
			mapatmos = { 
                name    = "CHUD_MapAtmos",
                label   = "Map atmospherics",
				tooltip = "Sets the atmospheric density of the map lights.",
				type    = "slider",
				sliderCallback = CHUDMapAtmosSlider,
				defaultValue = 1,
				minValue = 0,
				maxValue = 1,
				multiplier = 100,
				category = "comp",
				valueType = "float",
				sort = "C2",
				applyFunction = CHUDApplyMapAtmos,
            },
			deathstats = { 
                name    = "CHUD_DeathStats",
                label   = "Death stats UI",
				tooltip = "Enables or disables the stats you get after you die. Also visible on voiceover menu (default: X).",
				type    = "select",
				values  = { "Fully disabled", "Only voiceover menu", "Enabled" },
				callback = CHUDSaveMenuSettings,
				defaultValue = 2,
				disabledValue = 0,
				category = "comp",
				valueType = "int",
				sort = "D1",
            },
}