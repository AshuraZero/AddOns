-- CTRaidAssist - Boss Mods - visual sync counter frame

-- onLoad counter frame
function CT_RABossCount_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
end

-- onEvent counter frame
function CT_RABossCount_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		UIDropDownMenu_Initialize(CT_RABossCountFrame_DropDown, CT_RABossCount_InitializeMenuArray, "MENU");

		CT_RABossCountFrame:SetAlpha(CT_RABoss_Options["CounterAlpha"]);
	end
end

-- drop-down menu initialize
function CT_RABossCount_InitializeMenuArray()
	local info = { };
	table.insert(info, { text = "- " .. CT_RABOSS_COUNT_MENU_HEADER .. " -", isTitle = 1 });

	if ( CT_RABoss_Options["CounterLocked"] ) then
		table.insert(info, { text = CT_RABOSS_COUNT_MENU_UNLOCK, func = CT_RABossCount_FrameOptions, value = "framelock", notCheckable = 1; });
	else
		table.insert(info, { text = CT_RABOSS_COUNT_MENU_LOCK, func = CT_RABossCount_FrameOptions, value = "framelock", notCheckable = 1; });
	end

	table.insert(info, { text = CT_RA_RS_MENU_OPACITY, func = CT_RABossCount_FrameOptions, value = "Opacity", notCheckable = 1; });

	table.insert(info, { text = "|c00FF8080" .. CT_RABOSS_COUNT_MENU_HIDE .. "|r", func = CT_RABossCount_FrameOptions, value = "hide", notCheckable = 1; });
	
	for index, menuLine in info do
		UIDropDownMenu_AddButton(menuLine);
	end
end

-- counter frame options
function CT_RABossCount_FrameOptions()
	if ( this.value == "framelock" ) then
		if ( CT_RABoss_Options["CounterLocked"] ) then
			CT_RABoss_Options["CounterLocked"] = false;
			this:SetText(CT_RABOSS_COUNT_MENU_LOCK);
		else
			CT_RABoss_Options["CounterLocked"] = true;
			this:SetText(CT_RABOSS_COUNT_MENU_UNLOCK);
		end
	elseif ( this.value == "hide" ) then
		CT_RABossCountFrame:Hide();
	elseif ( this.value == "Opacity" ) then
		if ( not OpacityFrame:IsVisible() ) then
			CT_RABossCount_FrameOpacityShow();
		else
			OpacityFrame:Hide();
		end
	end
end

CT_RABossCount_FrameOpacityShow = function()
	OpacityFrame:ClearAllPoints();
	OpacityFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	OpacityFrameSlider:SetValue(CT_RABoss_Options["CounterAlpha"]);
	OpacityFrame.opacityFunc = CT_RABossCount_FrameOpacitySet;
	OpacityFrame.saveOpacityFunc = CT_RABossCount_FrameOpacitySave;
	OpacityFrame:Show();
end

CT_RABossCount_FrameOpacitySet = function()
	local alpha = OpacityFrameSlider:GetValue();			
	if ( alpha < 0.2 ) then
		alpha = 0.2;
	end
			
	CT_RABossCountFrame:SetAlpha(alpha);
end

CT_RABossCount_FrameOpacitySave = function()
	local alpha = OpacityFrameSlider:GetValue();
	
	CT_RABoss_Options["CounterAlpha"] = alpha;
end