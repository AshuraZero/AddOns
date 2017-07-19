CT_RABoss_RangeCheck = {
	InCombat = false,
	CurrentTime = 0,
	LastTimeCheck = 0,
	LastTimeSound = 0,
	RangeStatus = false,
	Players = {},

	Enable = function ()
		CT_RABossRangeCheckFrame:Show();
	end,

	Disable = function ()
		CT_RABoss_RangeCheck.InCombat = false;
		CT_RABossRangeCheckFrame:Hide();
		CT_RABossRangeCheckTooltip:Hide();
	end,

	onLoad = function ()
		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("PLAYER_REGEN_ENABLED");
		this:RegisterEvent("PLAYER_REGEN_DISABLED");
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
	end,

	onEvent = function (event)
		if ( event == "VARIABLES_LOADED" ) then
			UIDropDownMenu_Initialize(CT_RABossRangeCheckFrame_DropDown, CT_RABoss_RangeCheck.initializeMenuArray, "MENU");
		elseif ( event == "PLAYER_REGEN_DISABLED" ) then
			CT_RABoss_RangeCheck.InCombat = true;
		elseif ( event == "PLAYER_REGEN_ENABLED" ) then
			CT_RABoss_RangeCheck.InCombat = false;
		elseif ( event == "PLAYER_ENTERING_WORLD" ) then
			CT_RABoss_RangeCheck.Disable();
		end
	end,

	onUpdate = function (arg1)
		CT_RABoss_RangeCheck.CurrentTime = CT_RABoss_RangeCheck.CurrentTime + arg1;
		if ( CT_RABoss_RangeCheck.CurrentTime > (CT_RABoss_RangeCheck.LastTimeCheck + 0.1) ) then
			local unitid;
			CT_RABoss_RangeCheck.Players = {};
			for i = 1, GetNumRaidMembers(), 1 do
				unitid = "raid" .. i;
				if(not UnitIsDeadOrGhost(unitid) and not UnitIsUnit(unitid, "player") and CheckInteractDistance(unitid, 3)) then
					tinsert(CT_RABoss_RangeCheck.Players, (UnitName(unitid)));
				end
			end

			if ( getn(CT_RABoss_RangeCheck.Players) > 0 ) then
				CT_RABoss_RangeCheck.RangeStatus = true;
				CT_RABossRangeCheckStatusTexture:SetVertexColor(1,0,0);
				if (CT_RABoss_RangeCheck.InCombat and CT_RABoss_RangeCheck.CurrentTime > (CT_RABoss_RangeCheck.LastTimeSound + 1)) then
					PlaySoundFile("Interface\\AddOns\\CT_RABossMods\\beep.mp3");
					CT_RABoss_RangeCheck.LastTimeSound = CT_RABoss_RangeCheck.CurrentTime;
				end
			else
				CT_RABoss_RangeCheck.RangeStatus = false;
				CT_RABossRangeCheckStatusTexture:SetVertexColor(0,1,0);
			end
			CT_RABoss_RangeCheck.updateList();
			CT_RABoss_RangeCheck.LastTimeCheck = CT_RABoss_RangeCheck.CurrentTime;
		end
	end,

	updateList = function ()
		CT_RABossRangeCheckTooltip:SetOwner(CT_RABossRangeCheckFrame, "ANCHOR_BOTTOMRIGHT");
		CT_RABossRangeCheckTooltip:SetFrameStrata("HIGH");
		if (not CT_RABoss_RangeCheck.RangeStatus) then
			CT_RABossRangeCheckTooltip:Hide();
		else
			CT_RABossRangeCheckTooltip:ClearLines();
			CT_RABossRangeCheckTooltip:AddLine(CT_RABOSS_RANGECHECK_TOOCLOSE);
			local index = 1;
			for key, player in CT_RABoss_RangeCheck.Players do
				CT_RABossRangeCheckTooltip:AddLine("- "..player);
				if(index >= 5) then
					break;
				end
				index = index + 1;
			end
			CT_RABossRangeCheckTooltip:Show();
		end
	end,

	initializeMenuArray = function ()
		local info = {};
		table.insert(info, { text = "- " .. CT_RABOSS_RANGECHECK_MENU_HEADER .. " -", isTitle = 1, notCheckable = 1; });

		if ( CT_RABoss_Options["RangeCheckLocked"] ) then
			table.insert(info, { text = CT_RABOSS_RANGECHECK_MENU_UNLOCK, func = CT_RABoss_RangeCheck.frameOptions, value = "framelock", notCheckable = 1; });
		else
			table.insert(info, { text = CT_RABOSS_RANGECHECK_MENU_LOCK, func = CT_RABoss_RangeCheck.frameOptions, value = "framelock", notCheckable = 1; });
		end

		table.insert(info, { text = "|c00FF8080" .. CT_RABOSS_RANGECHECK_MENU_HIDE .. "|r", func = CT_RABoss_RangeCheck.frameOptions, value = "hide", notCheckable = 1; });

		for index, menuLine in info do
			UIDropDownMenu_AddButton(menuLine);
		end
	end,

	frameOptions = function ()
		if (this.value == "framelock" ) then
			if ( CT_RABoss_Options["RangeCheckLocked"] ) then
				CT_RABoss_Options["RangeCheckLocked"] = false;
				this:SetText(CT_RABOSS_RANGECHECK_MENU_LOCK);
			else
				CT_RABoss_Options["RangeCheckLocked"] = true;
				this:SetText(CT_RABOSS_RANGECHECK_MENU_UNLOCK);
			end
		elseif (this.value == "hide" ) then
			CT_RABoss_RangeCheck.Disable();
		end
	end,

	reset = function ()
		CT_RABossRangeCheckFrame:ClearAllPoints();
		CT_RABossRangeCheckFrame:SetPoint("CENTER", "UIParent");
		CT_RABossRangeCheckFrame:Show();
	end
};