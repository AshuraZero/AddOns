-- variable initialization
CT_RABoss_Options_Loaded = false;
CT_RABoss_Options = {};
CT_RABoss_OptionsDefault = {
	["ShortRaidAnnounce"] = false,
	["NoChatSpam"] = false,
	["CounterShow"] = true,
	["CounterLocked"] = false,
	["CounterAlpha"] = 0.8,
	["CounterScale"] = 1,
	["VTimerShow"] = true,
	["VTimerLocked"] = false,
	["VTimerAlpha"] = 0.8,
	["VTimerScale"] = 1,
	["VTimerSync"] = false,
};

-- initialize the options frame
function CT_RABossOptions_Init()
	CT_RABossOptionsFrameShortRaidAnnounce:SetChecked(CT_RABoss_Options["ShortRaidAnnounce"]);
	CT_RABossOptionsFrameNoChatSpam:SetChecked(CT_RABoss_Options["NoChatSpam"]);
	CT_RABossOptionsFrameVTimerShow:SetChecked(CT_RABoss_Options["VTimerShow"]);
	CT_RABossOptionsFrameVTimerSync:SetChecked(CT_RABoss_Options["VTimerSync"]);
	CT_RABossOptionsFrameVTimerScale:SetValue(CT_RABoss_Options["VTimerScale"]);
	CT_RABossOptionsFrameCounterShow:SetChecked(CT_RABoss_Options["CounterShow"]);
	CT_RABossOptionsFrameCounterScale:SetValue(CT_RABoss_Options["CounterScale"]);
	CT_RABossOptionsFrameVTimerScaleInfo:SetText(CT_RABOSS_OPTIONS_VTIMERSCALE .. " (" .. ceil(CT_RABoss_Options["VTimerScale"] * 100) .. "%)");
	CT_RABossOptionsFrameCounterScaleInfo:SetText(CT_RABOSS_OPTIONS_COUNTERSCALE .. " (" .. ceil(CT_RABoss_Options["CounterScale"] * 100) .. "%)");
end

-- onLoad options frame
function CT_RABossOptions_OnLoad()
	UIPanelWindows["CT_RABossOptionsFrame"] = {area = "center", pushable = 0};

	this:RegisterEvent("VARIABLES_LOADED");
end

-- onEvent options frame
function CT_RABossOptions_OnEvent()
	if ( event == "VARIABLES_LOADED" ) then
		--allows options frame to be closed with the Escape key
		tinsert(UISpecialFrames, "CT_RABossOptionsFrame");

		CT_RABoss_Options_Loaded = true;
		CT_RABossOptions_SavedSync();

		CT_RABossOptions_Init();

		-- setup frames
		CT_RABossVisualTimerFrame:SetScale(CT_RABoss_Options["VTimerScale"]);
		CT_RABossCountFrame:SetScale(CT_RABoss_Options["CounterScale"]);
	end
end

-- onShow options frame
function CT_RABossOptions_OnShow()
	CT_RABossOptions_Init();
end

-- toggle options frame and options
function CT_RABossOptions_Toggle(item)
	if (item == nil) then
		if (CT_RABossOptionsFrame:IsVisible()) then
			CT_RABossOptionsFrame:Hide();
		else
			CT_RABossOptionsFrame:Show();
		end
	elseif (item == "ShortRaidAnnounce") then
		if (CT_RABoss_Options["ShortRaidAnnounce"]) then
			CT_RABoss_Options["ShortRaidAnnounce"] = false;
		else
			CT_RABoss_Options["ShortRaidAnnounce"] = true;
		end
	elseif (item == "NoChatSpam") then
		if (CT_RABoss_Options["NoChatSpam"]) then
			CT_RABoss_Options["NoChatSpam"] = false;
		else
			CT_RABoss_Options["NoChatSpam"] = true;
		end
	elseif (item == "CounterShow") then
		if (CT_RABoss_Options["CounterShow"]) then
			CT_RABoss_Options["CounterShow"] = false;

			if ( CT_RABossCountFrame:IsVisible() ) then
				CT_RABossCountFrame:Hide();
			end
		else
			CT_RABoss_Options["CounterShow"] = true;
		end
	elseif (item == "CounterPosReset") then
		CT_RABossCountFrame:ClearAllPoints();
		CT_RABossCountFrame:SetUserPlaced(false);
		CT_RABossCountFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	elseif (item == "VTimerShow") then
		if (CT_RABoss_Options["VTimerShow"]) then
			CT_RABoss_Options["VTimerShow"] = false;

			if ( CT_RABossVisualTimerFrame:IsVisible() ) then
				CT_RABossVisualTimerFrame:Hide();
			end
		else
			CT_RABoss_Options["VTimerShow"] = true;
		end
	elseif (item == "VTimerPosReset") then
		CT_RABossVisualTimerFrame:ClearAllPoints();
		CT_RABossVisualTimerFrame:SetUserPlaced(false);
		CT_RABossVisualTimerFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	elseif (item == "VTimerSync") then
		if (CT_RABoss_Options["VTimerSync"]) then
			CT_RABoss_Options["VTimerSync"] = false;
		else
			CT_RABoss_Options["VTimerSync"] = true;
		end
	end
end

-- value change of an option object
function CT_RABossOptions_ValueChange(item)
	if (item == "VTimerScale") then
		local thisValue = this:GetValue();
		CT_RABossVisualTimerFrame:SetScale(thisValue);
		CT_RABossOptionsFrameVTimerScaleInfo:SetText(CT_RABOSS_OPTIONS_VTIMERSCALE .. " (" .. ceil(thisValue * 100) .. "%)");
		CT_RABoss_Options["VTimerScale"] = thisValue;
	elseif (item == "CounterScale") then
		local thisValue = this:GetValue();
		CT_RABossCountFrame:SetScale(thisValue);
		CT_RABossOptionsFrameCounterScaleInfo:SetText(CT_RABOSS_OPTIONS_COUNTERSCALE .. " (" .. ceil(thisValue * 100) .. "%)");
		CT_RABoss_Options["CounterScale"] = thisValue;
	end
end

-- show help tooltips
function CT_RABossOptions_ShowTooltip(item)
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");

	if (item == "ShortRaidAnnounce") then
		GameTooltip:SetText(CT_RABOSS_OPTIONS_SHORTANNOUNCE, 1, 1, 1, 1);
		GameTooltip:AddLine(CT_RABOSS_OPTIONS_SHORTANNOUNCE_HELP, nil, nil, nil, 1);
	elseif (item == "NoChatSpam") then
		GameTooltip:SetText(CT_RABOSS_OPTIONS_NOCHATSPAM, 1, 1, 1, 1);
		GameTooltip:AddLine(CT_RABOSS_OPTIONS_NOCHATSPAM_HELP, nil, nil, nil, 1);
	elseif (item == "CounterShow") then
		GameTooltip:SetText(CT_RABOSS_OPTIONS_COUNTERSHOW, 1, 1, 1, 1);
		GameTooltip:AddLine(CT_RABOSS_OPTIONS_COUNTERSHOW_HELP, nil, nil, nil, 1);
	elseif (item == "CounterPosReset") then
		GameTooltip:SetText(CT_RABOSS_OPTIONS_COUNTERPOSRESET, 1, 1, 1, 1);
		GameTooltip:AddLine(CT_RABOSS_OPTIONS_COUNTERPOSRESET_HELP, nil, nil, nil, 1);
	elseif (item == "CounterScale") then
		GameTooltip:SetText(CT_RABOSS_OPTIONS_COUNTERSCALE, 1, 1, 1, 1);
		GameTooltip:AddLine(CT_RABOSS_OPTIONS_COUNTERSCALE_HELP, nil, nil, nil, 1);
	elseif (item == "VTimerShow") then
		GameTooltip:SetText(CT_RABOSS_OPTIONS_VTIMERSHOW, 1, 1, 1, 1);
		GameTooltip:AddLine(CT_RABOSS_OPTIONS_VTIMERSHOW_HELP, nil, nil, nil, 1);
	elseif (item == "VTimerPosReset") then
		GameTooltip:SetText(CT_RABOSS_OPTIONS_VTIMERPOSRESET, 1, 1, 1, 1);
		GameTooltip:AddLine(CT_RABOSS_OPTIONS_VTIMERPOSRESET_HELP, nil, nil, nil, 1);
	elseif (item == "VTimerSync") then
		GameTooltip:SetText(CT_RABOSS_OPTIONS_VTIMERSYNC, 1, 1, 1, 1);
		GameTooltip:AddLine(CT_RABOSS_OPTIONS_VTIMERSYNC_HELP, nil, nil, nil, 1);
	elseif (item == "VTimerScale") then
		GameTooltip:SetText(CT_RABOSS_OPTIONS_VTIMERSCALE, 1, 1, 1, 1);
		GameTooltip:AddLine(CT_RABOSS_OPTIONS_VTIMERSCALE_HELP, nil, nil, nil, 1);
	end

	GameTooltip:Show();
end

-- hide help tooltip
function CT_RABossOptions_HideTooltip()
	GameTooltip:Hide();
end

function CT_RABossOptions_SavedSync()
	--sync saved values with internal values, else use default stored, else default to 0
	for index, var in CT_RABoss_OptionsDefault do
		if (CT_RABoss_Options[index] ~= nil) then
			--already saved
		else
			CT_RABoss_Options[index] = var;
		end
	end
end