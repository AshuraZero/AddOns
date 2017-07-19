CT_RA_VersionNumber = 1.55; -- Used for number comparisons

CT_RA_Version = "v" .. CT_RA_VersionNumber;
CT_RA_MOVINGMEMBER = nil;
CT_RA_CURRSLOT = nil;
CT_RA_CurrPositions = { };
CT_RA_CustomPositions = { };
CT_RA_MainTanks = { };
CT_RA_CurrMembers = { };
CT_RA_ButtonIndexes = { };

function CT_RATab_OnLoad()
	PanelTemplates_SetNumTabs(FriendsFrame, 5);
	tinsert(FRIENDSFRAME_SUBFRAMES, "CT_RAOptionsFrame");
	PanelTemplates_TabResize(0, this, 100);
end

CT_oldFriendsFrame_Update = FriendsFrame_Update;

function CT_newFriendsFrame_Update()
	if ( FriendsFrame.selectedTab == 5 ) then
		FriendsFrameTopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft");
		FriendsFrameTopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight");
		FriendsFrameBottomLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomLeft");
		FriendsFrameBottomRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomRight");
		FriendsFrameTitleText:SetText("团队助手 " .. CT_RA_Version);
		FriendsFrame_ShowSubFrame("CT_RAOptionsFrame");
	else
		CT_oldFriendsFrame_Update();
	end
end

FriendsFrame_Update = CT_newFriendsFrame_Update;

function CT_RAOptionsGroupButton_OnMouseDown(button)
	if ( button == "LeftButton" and CT_RAMenu_Options["temp"]["SORTTYPE"] == "custom" ) then
		this:StartMoving();
		CT_RA_MOVINGMEMBER = this;
	elseif ( button == "RightButton" and this.name ) then
		ToggleDropDownMenu(1, nil, getglobal("CT_RAOptionsGroupButton"..this:GetID().."DropDown"));
	end
end

function CT_RAOptionsGroupButton_OnMouseUp(button, raidButton)
	if ( not raidButton ) then
		raidButton = this;
	end
	if ( button ~= "RightButton" ) then
		raidButton:StopMovingOrSizing();
		CT_RA_MOVINGMEMBER = nil;
		if ( CT_RA_CURRSLOT and CT_RA_CURRSLOT:GetParent():GetID() ~= raidButton.subgroup ) then
			if (CT_RA_CURRSLOT.button) then
				local target = getglobal(CT_RA_CURRSLOT.button);
				CT_RA_CurrPositions[UnitName("raid" .. raidButton:GetID())] = { CT_RA_CURRSLOT:GetParent():GetID(), raidButton:GetID() };
				CT_RA_CurrPositions[UnitName("raid" .. target:GetID())] = { raidButton.subgroup, target:GetID() };
			else
				CT_RA_CURRSLOT:UnlockHighlight();
				local slot = CT_RA_CURRSLOT:GetParent():GetName().."Slot"..CT_RA_CURRSLOT:GetParent().nextIndex;
				raidButton:SetPoint("TOPLEFT", slot, "TOPLEFT", 0, 0);
				CT_RA_CurrPositions[UnitName("raid" .. raidButton:GetID())] = { CT_RA_CURRSLOT:GetParent():GetID(), raidButton:GetID() };
			end
		else
			if ( CT_RA_CURRSLOT ) then
				CT_RA_CURRSLOT:UnlockHighlight();
			end
			raidButton:SetPoint("TOPLEFT", raidButton.slot, "TOPLEFT", 0, 0);
		end
	end
	CT_RAOptions_Update();
	CT_RA_UpdateRaidGroup(0);
end

function CT_RAOptions_Update()
	-- Reset group index counters;
	for i=1, NUM_RAID_GROUPS do
		getglobal("CT_RAOptionsGroup"..i).nextIndex = 1;
	end
	-- Clear out all the slots buttons
	CT_RAOptionsGroup_ResetSlotButtons();

	local numRaidMembers = GetNumRaidMembers();
	local raidGroup, color;
	local buttonName, buttonLevel, buttonClass, buttonRank;
	local name, rank, subgroup, level, class, fileName, zone, online, reqChange;
	local temp = { };
	for i=1, MAX_RAID_MEMBERS do
		button = getglobal("CT_RAOptionsGroupButton"..i);
		if ( i <= numRaidMembers ) then
			name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if ( name and CT_RAMenu_Options["temp"]["SORTTYPE"] == "custom" and CT_RA_CurrPositions[name] ) then
				subgroup = CT_RA_CurrPositions[name][1];
			elseif ( ( not name or not CT_RA_CurrPositions[name] ) and CT_RAMenu_Options["temp"]["SORTTYPE"] ~= "custom" ) then
				if ( name ) then
					CT_RA_CurrPositions[name] = { subgroup };
				end
			elseif ( CT_RAMenu_Options["temp"]["SORTTYPE"] == "custom" ) then
				subgroup = nil;
				reqChange = 1;
			end
			if ( name and CT_RA_CurrPositions[name] ) then
				CT_RA_CurrPositions[name][2] = i;
			end
			if ( subgroup ) then
				raidGroup = getglobal("CT_RAOptionsGroup"..subgroup);
				-- To prevent errors when the server hiccups
				if ( raidGroup.nextIndex <= MEMBERS_PER_RAID_GROUP ) then
					buttonName = getglobal("CT_RAOptionsGroupButton"..i.."Name");
					buttonLevel = getglobal("CT_RAOptionsGroupButton"..i.."Level");
					buttonClass = getglobal("CT_RAOptionsGroupButton"..i.."Class");
					buttonRank = getglobal("CT_RAOptionsGroupButton"..i.."Rank");
					button.id = i;
					
					button.name = name;
					
					if ( level == 0 ) then
						level = "";
					end
					
					if ( not name ) then
						name = UNKNOWN;
					end
					
					buttonName:SetText(name);
					buttonLevel:SetText(level);
					buttonClass:SetText(class);
					if ( CT_RAMenu_Options["temp"]["SORTTYPE"] ~= "class" ) then
						if ( isDead ) then
							buttonName:SetVertexColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
							buttonClass:SetVertexColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
							buttonLevel:SetVertexColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
						elseif ( online ) then
							color = RAID_CLASS_COLORS[fileName];
							if ( color ) then
								buttonName:SetVertexColor(color.r, color.g, color.b);
								buttonLevel:SetVertexColor(color.r, color.g, color.b);
								buttonClass:SetVertexColor(color.r, color.g, color.b);
							end
						else
							buttonName:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
							buttonClass:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
							buttonLevel:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
						end
					end
					
					buttonRank:SetText("");
					for k, v in CT_RA_MainTanks do
						if ( v == name ) then
							buttonRank:SetText(k);
							break;
						end
					end
					
					-- Anchor button to slot
					local slot = raidGroup.nextIndex;
					if ( not CT_RA_MOVINGMEMBER or CT_RA_MOVINGMEMBER ~= button  ) then
						button:SetPoint("TOPLEFT", "CT_RAOptionsGroup"..subgroup.."Slot"..slot, "TOPLEFT", 0, 0);
					end
					
					-- Save slot for future use
					button.slot = "CT_RAOptionsGroup"..subgroup.."Slot"..slot;
					-- Save the button's subgroup too
					button.subgroup = subgroup;
					-- Tell the slot what button is in it
					getglobal("CT_RAOptionsGroup"..subgroup.."Slot"..slot).button = button:GetName();
					raidGroup.nextIndex = raidGroup.nextIndex + 1;
					button:SetID(i);
					button:Show();
				end
			end
		else
			button:Hide();
		end
	end
	if ( reqChange and CT_RAMenu_Options["temp"]["SORTTYPE"] == "custom" ) then
		local changed;
		for i = 1, GetNumRaidMembers(), 1 do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if ( name and not CT_RA_CurrPositions[name] ) then
				changed = 1;
				if ( getglobal("CT_RAOptionsGroup" .. subgroup).nextIndex > 5 ) then
					for y = 1, 8, 1 do
						if ( not getglobal("CT_RAOptionsGroup" .. y).nextIndex or getglobal("CT_RAOptionsGroup" .. y).nextIndex <= 5 ) then
							subgroup = y;
							CT_RA_CurrPositions[name] = { y, i };
							break;
						end
					end
				end
				if ( not CT_RA_CurrPositions[name] ) then
					CT_RA_CurrPositions[name] = { subgroup, i };
				end
			end
		end
		if ( changed ) then
			CT_RAOptions_Update();
		end
	end
end

function CT_RA_UpdateCustomSorting()
	local buttons = { };
	for i = 1, 40, 1 do
		local btn = getglobal("CT_RAMember" .. i);
		local group = ceil(i/5);
		local index = i;
		if ( i <= GetNumRaidMembers() and CT_RA_CurrPositions[UnitName("raid" .. i)] ) then
			group = CT_RA_CurrPositions[UnitName("raid" .. i)][1];
		end
		if ( not buttons[group] ) then
			buttons[group] = { };
		end
		buttons[group][index] = i;
	end
	for i = 1, 8, 1 do
		if ( buttons[i] ) then
			for k, v in buttons[i] do
				if ( k == 1 ) then
					getglobal("CT_RAMember" .. v):SetPoint("TOPLEFT", "CT_RAGroup" .. i, "TOPLEFT", 0, -20);
				else
					if ( buttons[i][k-1] ) then
						getglobal("CT_RAMember" .. v):SetPoint("TOPLEFT", "CT_RAMember" .. (buttons[i][k-1]), "BOTTOMLEFT", 0, 4);
					end
				end
			end
		end
	end
end

function CT_RAOptionsGroup_ResetSlotButtons()
	for i=1, NUM_RAID_GROUPS do
		for j=1, MEMBERS_PER_RAID_GROUP do
			getglobal("CT_RAOptionsGroup"..i.."Slot"..j).button = nil;
		end
	end
end

function CT_RAOptionsGroupFrame_OnUpdate(elapsed)
	if ( CT_RA_MOVINGMEMBER ) then
		local button, slot;
		CT_RA_CURRSLOT = nil;
		for i=1, NUM_RAID_GROUPS do
			for j=1, MEMBERS_PER_RAID_GROUP do
				slot = getglobal("CT_RAOptionsGroup"..i.."Slot"..j);
				if ( MouseIsOver(slot) ) then
					slot:LockHighlight();
					CT_RA_CURRSLOT = slot;
				else
					slot:UnlockHighlight();
				end
			end
		end
	end
end

function CT_RAMemberDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RAMemberDropDown_Initialize, "MENU");
end

function CT_RAMemberDropDown_Initialize()
	local dropdown, info;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end
	if ( type(UIDROPDOWNMENU_MENU_VALUE) == "table" and UIDROPDOWNMENU_MENU_VALUE[1] == "Main Tanks" ) then
		info = {};
		info.text = "主坦克";
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		for i = 1, 10, 1 do
			info = {};
			if ( CT_RA_MainTanks[i] and CT_RA_MainTanks[i] == UIDROPDOWNMENU_MENU_VALUE[2] ) then
				info.text = "|c00DFFFFF移除 MT #" .. i .. "|r";
				info.value = { UIDROPDOWNMENU_MENU_VALUE[1], UIDROPDOWNMENU_MENU_VALUE[2], i, 1 };
				info.tooltipTitle = "移除主坦克"
				info.tooltipText = "从MT窗口移除主坦克。";
			else
				info.text = "设置 MT #" .. i;
				info.value = { UIDROPDOWNMENU_MENU_VALUE[1], UIDROPDOWNMENU_MENU_VALUE[2], i };
				info.tooltipTitle = "设置主坦克"
				info.tooltipText = "设置一个主力坦克，每个人都可能看到主力坦克的目标信息";
			end
			info.func = CT_RAMemberDropDown_OnClick;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		return;
	end
	if ( type(UIDROPDOWNMENU_MENU_VALUE) == "table" and UIDROPDOWNMENU_MENU_VALUE[1] == "Player Targets" ) then
		info = {};
		info.text = "玩家目标";
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		for i = 1, 10, 1 do
			info = {};
			if ( CT_RA_PTargets and CT_RA_PTargets[i] == UIDROPDOWNMENU_MENU_VALUE[2] ) then
				info.text = "|c00DFFFFF移除 PT #" .. i .. "|r";
				info.value = { UIDROPDOWNMENU_MENU_VALUE[1], UIDROPDOWNMENU_MENU_VALUE[2], i, 1 };
				info.tooltipTitle = "移除玩家目标"
				info.tooltipText = "从PT窗口移除玩家目标。";
			else
				info.text = "设置 PT #" .. i;
				info.value = { UIDROPDOWNMENU_MENU_VALUE[1], UIDROPDOWNMENU_MENU_VALUE[2], i };
				info.tooltipTitle = "设置玩家目标"
				info.tooltipText = "设置一个玩家目标，你可以很容易的查看其生命值和目标。";
			end
			info.func = CT_RAMemberDropDown_OnClick;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		return;
	end
	info = {};
	info.text = this.name;
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	if ( CT_RA_Level < 1 ) then
		info = { };
		info.text = "|c00666666主坦克|r";
		info.tooltipTitle = "需要提升权限";
		info.tooltipText = "要设置主坦克,你必须是一个团队领袖或助理.";
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	else
		info = {};
		info.text = "主坦克";
		info.value = { "Main Tanks", this.name };
		info.hasArrow = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	end
	info = {};
	info.text = "玩家目标";
	info.value = { "Player Targets", this.name };
	info.hasArrow = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
end

function CT_RAMemberDropDown_OnClick()
	if ( this.value[1] == "Main Tanks" ) then
		if ( this.value[4] ) then
			CT_RA_SendMessage("R " .. this.value[2], 1);
		else
			CT_RA_SendMessage("SET " .. this.value[3] .. " " .. this.value[2], 1);
		end
	elseif ( this.value[1] == "Player Targets" ) then
		if ( this.value[4] ) then
			CT_RA_PTargets[this.value[3]] = nil;
		else
			CT_RA_PTargets[this.value[3]] = this.value[2];
		end
	end
	CloseMenus();
end

function CT_RAMemberDropDownRemove_OnLoad()
	UIDropDownMenu_Initialize(this, CT_RAMemberDropDownRemove_Initialize, "MENU");
end

function CT_RAMemberDropDownRemove_Initialize()
	local dropdown, info;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end
	if ( this.id and this.name ) then
		info = {};
		info.text = this.name;
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	
		info = {};
		info.text = "移除 MT";
		info.value = this.name;
		info.func = CT_RAMemberDropDownRemove_OnClick;
		info.notCheckable = 1;
		info.tooltipTitle = "移除主坦克"
		info.tooltipText = "移除此主坦克";
		UIDropDownMenu_AddButton(info);
	end
end

function CT_RAMemberDropDownRemove_OnClick()
	for k, v in CT_RA_MainTanks do
		if ( v == this.value ) then
			CT_RA_SendMessage("R " .. v, 1);
			return;
		end
	end
end