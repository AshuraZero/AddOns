SLASH_RAIDTRACKER1 = "/raidtracker";
SLASH_RAIDTRACKER2 = "/rt";

SlashCmdList["RAIDTRACKER"] = function(msg)
    local _, _, command, args = string.find(msg, "(%w+)%s?(.*)");
    if(command) then
        command = strlower(command);
    end
    
    if(command == "debug") then
        if(args == "1") then
            CT_RaidTracker_Options["DebugFlag"] = 1;
            CT_RaidTracker_Print("开启调试输出", 1, 1, 0);
        elseif(args == "0") then
            CT_RaidTracker_Options["DebugFlag"] = nil;
            CT_RaidTracker_Print("关闭调试输出", 1, 1, 0);
        else
            if(CT_RaidTracker_Options["DebugFlag"] == 1) then
                CT_RaidTracker_Print("调试输出: 开启", 1, 1, 0);
            else
                CT_RaidTracker_Print("调试输出: 关闭", 1, 1, 0);
            end
        end
    elseif(command == "deleteall") then
        CT_RaidTracker_Print("删除全部活动 "..getn(CT_RaidTracker_RaidLog).." Raids", 1, 1, 0);
        CT_RaidTracker_RaidLog = { };
        CT_RaidTracker_GetCurrentRaid = nil;
        CT_RaidTracker_UpdateView();
        CT_RaidTracker_Update();
    elseif(command == "additem") then
        if(args and args ~= "") then
            local sColor, sItem, sName, sStart, sEnde = CT_RaidTracker_GetItemInfo(args);
            if(sItem and sItem) then
                if (string.len(args) > sEnde+2) then
                    sLooter = string.sub(args,sEnde+2);
                    CT_RaidTracker_Debug("Looter",sLooter);
                else
                    CT_RaidTracker_Debug("Kein Looter",sLooter);
                    sLooter = "";
                end;
                if(CT_RaidTrackerFrame.selected) then
                    local nameGIF, linkGIF, qualityGIF, iLevelGIF, minLevelGIF, classGIF, subclassGIF, maxStackGIF, invtypeGIV, iconGIF = GetItemInfo("item:"..sItem);
                    local tAttendees = { };
                    
                    
                    local tTooltip = { };
                    if(CT_RaidTracker_Options["SaveTooltips"] == 1) then
                        tTooltip = CT_RaidTracker_GetItemTooltip(sItem);
                    end
                    
                    local sTime = CT_RaidTracker_Date();
                    tinsert(CT_RaidTracker_RaidLog[CT_RaidTrackerFrame.selected]["Loot"], 1,
                        {
                            ["player"] = sLooter,
                            ["item"] = {                        
                                ["c"] = sColor,
                                ["id"] = sItem,
                                ["tooltip"] = tTooltip,
                                ["name"] = sName,
                                ["icon"] = iconGIF,
                                ["count"] = 1,
                                ["class"] = classGIF,
                                ["subclass"] = subclassGIF,
                            },
                            ["zone"] = GetRealZoneText(),
                            ["time"] = sTime,
                            ["attendees"] = tAttendees,
                        }
                    );
                    CT_RaidTracker_Print("添加战利品:  "..sName .. "完成", 1, 1, 0);
                    CT_RaidTracker_UpdateView();
                    CT_RaidTracker_Update();
                else
                    CT_RaidTracker_Print("添加战利品: 没有选择活动", 1, 1, 0);
                end
            else
                CT_RaidTracker_Print("添加战利品: 错误的战利品链接", 1, 1, 0);
            end
        else
            CT_RaidTracker_Print("添加战利品: 没有战利品链接", 1, 1, 0);
        end
    elseif(command == "io") then
        local idfound;
        for idtoadd in string.gmatch(args, "item:(%d+):") do
            idfound = nil;
            idtoadd = tonumber(idtoadd);
            for key, val in pairs(CT_RaidTracker_ItemOptions) do
                if(val["id"] == idtoadd) then
                    idfound = true;
                    break;
                end
            end
            if(idfound) then
                CT_RaidTracker_Print(idtoadd.." 已经在忽略的战利品选项列表", 1, 1, 0);
            else
                tinsert(CT_RaidTracker_ItemOptions, {["id"] = idtoadd});
                CT_RaidTracker_Print("添加 "..idtoadd.." 到忽略的战利品选项列表", 1, 1, 0);
                idfound = true;
            end
        end
        if(not idfound) then
            for idtoadd in string.gmatch(args, "(%d+)%s?") do
                idfound = nil;
                idtoadd = tonumber(idtoadd);
                CT_RaidTracker_Debug("idtoadd", idtoadd);
                for key, val in pairs(CT_RaidTracker_ItemOptions) do
                    if(val["id"] == idtoadd) then
                        idfound = true;
                        break;
                    end
                end
                if(idfound) then
                    CT_RaidTracker_Print(idtoadd.." 已经在忽略的战利品选项列表", 1, 1, 0);
                else
                    tinsert(CT_RaidTracker_ItemOptions, {["id"] = idtoadd});
                    CT_RaidTracker_Print("添加 "..idtoadd.." 到忽略的战利品选项列表", 1, 1, 0);
                end
            end
        end
        CT_RaidTracker_ItemOptions_ScrollBar_Update();
        CT_RaidTrackerItemOptionsFrame:Show();
        
    elseif(command == "options") then
        CT_RaidTrackerOptionsFrame:Show();
    elseif(command == "o") then
        CT_RaidTrackerOptionsFrame:Show();
    elseif(command == "join") then
        if(CT_RaidTrackerFrame.selected) then
            if(args and strlen(args) > 0) then
                CT_RaidTrackerJoinLeaveFrameNameEB:SetText(args);
            end
            CT_RaidTrackerJoinLeaveFrameTitle = "Join";
            CT_RaidTrackerJoinLeaveFrame.type = "Join";
            CT_RaidTrackerJoinLeaveFrame.raidid = CT_RaidTrackerFrame.selected;
            CT_RaidTrackerJoinLeaveFrame:Show();
        else
            CT_RaidTracker_Print("加入: 没有活动被选择", 1, 1, 0);
        end
    elseif(command == "leave") then
        if(CT_RaidTrackerFrame.selected) then
            if(args and strlen(args) > 0) then
                CT_RaidTrackerJoinLeaveFrameNameEB:SetText(args);
            end
            CT_RaidTrackerJoinLeaveFrameTitle = "Leave";
            CT_RaidTrackerJoinLeaveFrame.type = "Leave";
            CT_RaidTrackerJoinLeaveFrame.raidid = CT_RaidTrackerFrame.selected;
            CT_RaidTrackerJoinLeaveFrame:Show();
        else
            CT_RaidTracker_Print("加入: 没有活动被选择", 1, 1, 0);
        end
    elseif(command) then
        CT_RaidTracker_Print("/rt - 显示插件面板", 1, 1, 0);
        CT_RaidTracker_Print("/rt options/o - 显示选项面板", 1, 1, 0);
        CT_RaidTracker_Print("/rt io - 显示战利品控制面板", 1, 1, 0);
        CT_RaidTracker_Print("/rt io [ITEMLINK(S)/ITEMID(S)] - 添加忽略的战利品", 1, 1, 0);
        CT_RaidTracker_Print("/rt additem [ITEMLINK] [Looter]- 添加战利品到当前活动", 1, 1, 0);
        CT_RaidTracker_Print("/rt join [PLAYER] - 手动为当前活动添加一个玩家", 1, 1, 0);
        CT_RaidTracker_Print("/rt leave [PLAYER] - 手动删除当前活动里的一个玩家", 1, 1, 0);
        CT_RaidTracker_Print("/rt deleteall - 删除所有活动", 1, 1, 0);
        CT_RaidTracker_Print("/rt debug 0/1 - Enables/Disables 显示调试信息", 1, 1, 0);
    else
        ShowUIPanel(CT_RaidTrackerFrame);   
    end
end

DKPSystem = 0;
if not MerDKP_Table then
    MerDKP_Table = {}
end

UIPanelWindows["CT_RaidTrackerFrame"] = { area = "left", pushable = 1, whileDead = 1 };

if (not ieReloadUI) then
    StaticPopupDialogs["IE_RELOADUI"] = {
        text = "确定|cffff7000重新载入界面|r?",
        button1 = ACCEPT,
        button2 = CANCEL,
        OnAccept = function(self)       
            ReloadUI();
        end,
        OnCancel = function(self)
        end,
        timeout = 30,
        showAlert = 1,
        hideOnEscape = 1
    };

    function ieReloadUI()
        StaticPopup_Show("IE_RELOADUI");    
    end
end

if ( CT_RegisterMod ) then
    CT_RaidTracker_DisplayWindow = function()
        ShowUIPanel(CT_RaidTrackerFrame);
    end
    CT_RegisterMod("Raid Tracker", "Display window", 5, "Interface\\Icons\\INV_Chest_Chain_05", "Displays the Raid Tracker window, which tracks raid loot & attendance.", "switch", "", CT_RaidTracker_DisplayWindow);
else
    --CT_RaidTracker_Print("<CTMod> CT_RaidTracker loaded. Type /rt to show the RaidTracker window.", 1, 1, 0);
end

--region variable

MerDKP_Table_init = {};

CT_RaidTracker_Version = "Classic 1.13.2";
CT_RaidTracker_Revision = "20191030";
CT_RaidTracker_Online = { };
CT_RaidTracker_Events = { };
CT_RaidTracker_RaidLog = { };
CT_RaidTracker_GetCurrentRaid = nil;
CT_RaidTracker_LastPage = { };
CT_RaidTracker_AutoBossChangedTime = 0;
CT_RaidTracker_TimeOffsetStatus = nil;
CT_RaidTracker_TimeOffset = 0;
CT_RaidTracker_CustomZoneTriggers = {};
CT_RaidTracker_ItemOptions = {};
CT_RaidTracker_Items = { };
CT_RaidTracker_QuickLooter = {"分解_", "仓库_"};

CT_RaidTracker_SortOptions = {
    ["method"] = "name",
    ["way"] = "asc",
    ["itemmethod"] = "looted",
    ["itemway"] = "asc",
    ["itemfilter"] = 1,
    ["playerraidway"] = "desc",
    ["playeritemfilter"] = 1,
    ["playeritemmethod"] = "name",
    ["playeritemway"] = "asc",
    ["itemhistorymethod"] = "name",
    ["itemhistoryway"] = "asc"
};

CT_RaidTracker_RarityTable = {
    ["ff9d9d9d"] = 1,
    ["ffffffff"] = 2,
    ["ff1eff00"] = 3,
    ["ff0070dd"] = 4,
    ["ffa335ee"] = 5,
    ["ffff8000"] = 6,
    ["ffe6cc80"] = 7,
};

CT_RaidTracker_Options = {
    ["DebugFlag"] = nil,        -- on/off
    ["MinQuality"] = 5,         -- 1:poor, 2:common, 3:uncommon, 4:rare, 5:epic, 6:legendary, 7:artifact
    ["AskCost"] = 5,            -- 1:poor, 2:common, 3:uncommon, 4:rare, 5:epic, 6:legendary, 7:artifact, asks for cost for items with at least this rarity
    ["GetDkpValue"] = 5,        -- 1:poor, 2:common, 3:uncommon, 4:rare, 5:epic, 6:legendary, 7:artifact
    ["GroupItems"] = 4,         -- 1:poor, 2:common, 3:uncommon, 4:rare, 5:epic, 6:legendary, 7:artifact
    ["SaveTooltips"] = 1,       -- on/off - save tooltips of items
    ["AutoWhisper"] = 1,
    ["FilterWhisper"] = 0,
    ["Timezone"] = 0,
    ["TimeSync"] = 1,
    ["AutoBossBoss"] = "",      -- just the name of the boss
    ["AutoBossChangeMinTime"] = 120,    -- how long should trash mob's ignored after a boss kill (minutes)?
};

--end region variable


--region event

function CT_RaidTracker_OnLoad(this)
    CT_RaidTrackerTitleText:SetText("CT_RaidTracker");
    -- Register events
    this:RegisterEvent("CHAT_MSG_LOOT");
    this:RegisterEvent("CHAT_MSG_SYSTEM");
    this:RegisterEvent("GROUP_ROSTER_UPDATE");
    this:RegisterEvent("ADDON_LOADED");
    this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    this:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
    this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
    this:RegisterEvent("PLAYER_ENTERING_WORLD");
    this:RegisterEvent("UPDATE_INSTANCE_INFO"); 
end

function CT_RaidTracker_OnEvent(self, event, ...)
    local arg1 = ...;
    local _, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, _, _, _, _, _, _, _ = CombatLogGetCurrentEventInfo()

    if ( event == "ADDON_LOADED" ) then
		if (arg1 == ADDON_NAME) then
			--ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", whisperFilter);

			CT_RaidTracker_RunVersionFix();
			CT_RaidTracker_GetGameTimeOffset();
			CT_RaidTracker_Options["Timezone"] = 0;
			CT_RaidTracker_Options["AutoBossChangeMinTime"] = 120;

			MerDKP_Table_init = deepcopy(MerDKP_Table);        
			if CT_RaidTracker_GetCurrentRaid then
				CT_RaidTracker_Update_MerDKP(CT_RaidTracker_GetCurrentRaid);
			end
		end
    end

    if ( CT_RaidTracker_UpdateFrame.time and CT_RaidTracker_UpdateFrame.time <= 2 ) then
        tinsert(CT_RaidTracker_Events, event);
        return;
    end

    if ( event == "CHAT_MSG_MONSTER_YELL" or event == "CHAT_MSG_MONSTER_EMOTE" ) then
		if ( IsInRaid() and CT_RaidTracker_GetCurrentRaid) then
			if(arg1 == CT_RaidTracker_lang_BossKills_Majordomo_Yell) then
				event = "COMBAT_LOG_EVENT_UNFILTERED";
				arg2="UNIT_DIED";
				arg9 =CT_RaidTracker_lang_BossKills_Majordomo_BossName;
			end
		end
    end

    if ( event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD") then 
        if ( IsInRaid() and CT_RaidTracker_GetCurrentRaid ) then
			local updated;
			--check for players not longer in raid
			if ( event == "GROUP_ROSTER_UPDATE") then
				local raidendtime = CT_RaidTracker_Date();
				for k, v in pairs(CT_RaidTracker_Online) do
					local online = UnitIsConnected(k);
					CT_RaidTracker_Debug("Check connection for",k,v,online);
					if ( not online and v ) then
						tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Leave"],
							{
								["player"] = k,
								["time"] = raidendtime,
							}
						);
						CT_RaidTracker_Debug("OFFLINE", k, raidendtime);
						CT_RaidTracker_Online[k] = online;
						updated = 1;
					end     
				end
			end

			updated = CT_RaidTracker_GroupChanged(updated);
			if ( updated ) then
				CT_RaidTracker_Update();
				CT_RaidTracker_UpdateView();
			end
		end
    elseif ( event == "CHAT_MSG_LOOT" ) then
		CT_RaidTracker_LootGet(arg1);
    
    elseif ( event == "CHAT_MSG_SYSTEM" and CT_RaidTracker_GetCurrentRaid ) then
        local name = UnitName("player");
        if (name and name ~= UKNOWNBEING and name ~= UNKNOWN ) then
            local sDate = CT_RaidTracker_Date();
            local iStart, iEnd, sPlayer = string.find(arg1, CT_RaidTracker_lang_LeftGroup);
            if ( sPlayer and sPlayer ~= name and sPlayer ~= UKNOWNBEING and sPlayer ~= UNKNOWN and CT_RaidTracker_Online[sPlayer]) then
                sPlayer = GetFixedUpUnitName(sPlayer);
                tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Leave"],
                    {
                        ["player"] = sPlayer,
                        ["time"] = sDate
                    }
                );
                CT_RaidTracker_Online[sPlayer] = nil;
                CT_RaidTracker_Debug(sPlayer, "LEFT", sDate);
            end

            CT_RaidTracker_UpdateView();
            CT_RaidTracker_Update();
        end
    elseif ( event == "ZONE_CHANGED_NEW_AREA" ) then
		if ( IsInRaid() == true ) then
            CT_RaidTracker_DoZoneCheck();
            CT_RaidTracker_DoRaidIdCheck();
		end
    elseif ( event == "COMBAT_LOG_EVENT_UNFILTERED" and arg2 == "UNIT_DIED" and IsInRaid() == true ) then
        CT_RaidTracker_BossKill(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    elseif ( event == "UPDATE_INSTANCE_INFO" and IsInRaid() == true ) then
        CT_RaidTracker_DoRaidIdCheck();
    end
end

function CT_RaidTracker_CreateEvent(eventName,playerName,dkp)
    if (not CT_RaidTracker_GetCurrentRaid) then 
        CT_RaidTracker_Print("请先新建一个活动");
        return;
    end
    if (CT_RaidTrackerFrame.selected ~= CT_RaidTracker_GetCurrentRaid) then
        CT_RaidTracker_Print("请选择当前进行中的活动,然后进行加分");
        return;
    end

    local tAttendees = { };
    local sDate = CT_RaidTracker_Date();
    if playerName ~= nil then --custom event
        tinsert( tAttendees, playerName );
    else
        if( GetNumGroupMembers() > 0 ) then
            for i = 1, GetNumGroupMembers() do
                local name = GetFixedUpUnitName("raid" .. i);
                if (name and name ~= UKNOWNBEING and name ~= UNKNOWN) then
                    tinsert( tAttendees, name );
                end
            end
        end

		--Todo backup handle
    end

    tinsert( CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["BossKills"],
        {
            ["boss"] = eventName,
            ["time"] = sDate,
            ["attendees"] = tAttendees
        }
    );

    local bossid = getn(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["BossKills"]);

    if ( dkp == nil ) then
         CT_RaidTracker_EditBossDKP(CT_RaidTracker_GetCurrentRaid,bossid);
    else
        CT_RaidTracker_SaveBossDKP(CT_RaidTracker_GetCurrentRaid , bossid, dkp);
    end

    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_RarityDropDown_OnLoad(this)
    UIDropDownMenu_Initialize(this, CT_RaidTracker_RarityDropDown_Initialize);
    --UIDropDownMenu_SetWidth(130);
    UIDropDownMenu_SetSelectedID(CT_RaidTrackerRarityDropDown, 1);
end

function CT_RaidTracker_RarityDropDown_Initialize()
    local info = {};
    info.text = "|c009d9d9d劣质|r";
    info.func = CT_RaidTracker_RarityDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
    
    local info = {};
    info.text = "|c00ffffff普通|r";
    info.func = CT_RaidTracker_RarityDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

    local info = {};
    info.text = "|c001eff00优秀|r";
    info.func = CT_RaidTracker_RarityDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = "|c000070dd精良|r";
    info.func = CT_RaidTracker_RarityDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = "|c00a335ee史诗|r";
    info.func = CT_RaidTracker_RarityDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = "|c00ff8000传说|r";
    info.func = CT_RaidTracker_RarityDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
    
    info = {};
    info.text = "|c00e6cc80神器|r";
    info.func = CT_RaidTracker_RarityDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
end

function CT_RaidTracker_RarityDropDown_OnClick(self)
    UIDropDownMenu_SetSelectedID(CT_RaidTrackerRarityDropDown, self:GetID());
    if ( CT_RaidTrackerFrame.type == "items" ) then
        CT_RaidTracker_SortOptions["itemfilter"] = self:GetID();
    else
        CT_RaidTracker_SortOptions["playeritemfilter"] = self:GetID();
    end
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_Update()
    if( CT_RaidTracker_GetCurrentRaid ) then
        CT_RaidTrackerFrameEndRaidButton:Enable();
        CT_RaidTrackerFrameSnapshotButton:Enable();
    else
        CT_RaidTrackerFrameEndRaidButton:Disable();
    end       
    
    if(IsInRaid() == true) then
        CT_RaidTrackerFrameNewRaidButton:Enable();

        if( GetNumGroupMembers() > 0 ) then
            CT_RaidTrackerFrameNewRaidButton:Enable();
        else
            CT_RaidTrackerFrameNewRaidButton:Disable();
        end;
    else
        CT_RaidTrackerFrameNewRaidButton:Disable();
    end

    
    if( CT_RaidTracker_GetCurrentRaid ) then
        CT_RaidTrackerFrameNewRaidButton:Disable();
    end
    
    --[[
    if ( CT_RaidTrackerFrame.selected ) then
        CT_RaidTrackerFrameView2Button:Enable();
    else
        CT_RaidTrackerFrameView2Button:Disable();
    end
    ]]

    if ( getn(CT_RaidTracker_LastPage) > 0 ) then
        CT_RaidTrackerFrameBackButton:Enable();
    else
        --CT_RaidTrackerFrameBackButton:Disable();
    end
    if ( getn(CT_RaidTracker_RaidLog) > 0 ) then
        if ( CT_RaidTrackerFrame.selected ) then
            local selected;
            if ( not CT_RaidTracker_RaidLog[CT_RaidTrackerFrame.selected] ) then
                while ( not selected ) do
                    if ( CT_RaidTrackerFrame.selected < 1 ) then
                        selected = 1;
                        CT_RaidTrackerFrame.selected = nil;
                    else
                        CT_RaidTrackerFrame.selected = CT_RaidTrackerFrame.selected - 1;
                        if ( CT_RaidTracker_RaidLog[CT_RaidTrackerFrame.selected] ) then
                            selected = 2;
                        end
                    end
                end
            end
            if ( not selected or selected == 2 ) then
                if ( not CT_RaidTracker_RaidLog[CT_RaidTrackerFrame.selected] or getn(CT_RaidTracker_RaidLog[CT_RaidTrackerFrame.selected]["Loot"]) == 0 ) then
                    CT_RaidTrackerFrame.type = "events";
                    --CT_RaidTrackerFrameViewButton:Disable();
                else
                    CT_RaidTrackerFrameViewButton:Enable();
                end
            end
        end

        CT_EmptyRaidTrackerFrame:Hide();
        CT_RaidTrackerFrameDeleteButton:Enable();

        local hasItem;
        for k, v in pairs(CT_RaidTracker_RaidLog) do
            for key, val in pairs(v["Loot"]) do
                if ( val["player"] == CT_RaidTrackerFrame.player ) then
                    hasItem = 1;    
                    break;
                end
            end
            if ( hasItem ) then
                break;
            end
        end

        if ( CT_RaidTrackerFrame.type == "raids" or not CT_RaidTrackerFrame.type ) then
    --      CT_RaidTrackerFrameViewButton:SetText("战利品");
        elseif ( CT_RaidTrackerFrame.type == "items" ) then
        --  CT_RaidTrackerFrameViewButton:SetText("团队成员");
        elseif ( CT_RaidTrackerFrame.type == "player" ) then
            if ( not hasItem ) then
    --          CT_RaidTrackerFrameViewButton:Disable();
            else
    --          CT_RaidTrackerFrameViewButton:Enable();
            end
    --      CT_RaidTrackerFrameViewButton:SetText("战利品");
            CT_RaidTrackerFrameDeleteButton:Disable();
        elseif ( CT_RaidTrackerFrame.type == "playeritems" ) then
    --      CT_RaidTrackerFrameViewButton:SetText("团队活动");
            CT_RaidTrackerFrameDeleteButton:Disable();
        if ( not hasItem ) then
        --      CT_RaidTrackerFrame.type = "player";
                CT_RaidTracker_Update();
                CT_RaidTracker_UpdateView();
            end
        elseif ( CT_RaidTrackerFrame.type == "itemhistory" ) then
            CT_RaidTrackerFrameDeleteButton:Disable();
            --CT_RaidTrackerFrameViewButton:Disable();
        elseif ( CT_RaidTrackerFrame.type == "events" ) then
        --  CT_RaidTrackerFrameDeleteButton:Disable();
            --CT_RaidTrackerFrameViewButton:Disable();
        end
    else
        
        CT_EmptyRaidTrackerFrame:Show();
        CT_RaidTrackerDetailScrollFramePlayers:Hide();
        CT_RaidTrackerDetailScrollFrameItems:Hide();
        CT_RaidTrackerDetailScrollFramePlayer:Hide();
        CT_RaidTrackerDetailScrollFrameEvents:Hide();
        CT_RaidTrackerFrameDeleteButton:Disable();
        CT_RaidTrackerFrameViewButton:Disable();
    end

    local numRaids = getn(CT_RaidTracker_RaidLog);
    local numEntries = numRaids;

    -- ScrollFrame update
    FauxScrollFrame_Update(CT_RaidTrackerListScrollFrame, numEntries, 6, 16, nil, nil, nil, CT_RaidTrackerHighlightFrame, 293, 316 );
    
    CT_RaidTrackerHighlightFrame:Hide();
    
    for i=1, 6, 1 do
        local title = getglobal("CT_RaidTrackerTitle" .. i);
        local normaltext = getglobal("CT_RaidTrackerTitle" .. i .. "NormalText");
        local highlighttext = getglobal("CT_RaidTrackerTitle" .. i .. "HighlightText");
        local disabledtext = getglobal("CT_RaidTrackerTitle" .. i .. "DisabledText");
        local highlight = getglobal("CT_RaidTrackerTitle" .. i .. "Highlight");

        local index = i + FauxScrollFrame_GetOffset(CT_RaidTrackerListScrollFrame); 
        if ( index <= numEntries ) then
            local raidTitle = CT_RaidTracker_GetRaidTitle(index, nil, 1, 1);
            local raidTag = CT_RaidTracker_RaidLog[index]["note"];
            if ( not raidTag ) then
                raidTag = "";
            else
                raidTag = " (" .. raidTag .. ")";
            end
            if ( raidTitle ) then
                title:SetText(raidTitle .. raidTag);
            else
                title:SetText("");
            end
            title:Show();
            -- Place the highlight and lock the highlight state
            if ( CT_RaidTrackerFrame.selected and CT_RaidTrackerFrame.selected == index ) then
                CT_RaidTrackerSkillHighlight:SetVertexColor(1, 1, 0);
                CT_RaidTrackerHighlightFrame:SetPoint("TOPLEFT", "CT_RaidTrackerTitle"..i, "TOPLEFT", 0, 0);
                CT_RaidTrackerHighlightFrame:Show();
                title:LockHighlight();
            else
                title:UnlockHighlight();
            end
            
        else
            title:Hide();
        end

    end
end

function CT_RaidTracker_SelectRaid(id)
    local raidid = id + FauxScrollFrame_GetOffset(CT_RaidTrackerListScrollFrame);
    CT_RaidTracker_GetPage();
    CT_RaidTrackerFrame.selected = raidid;
    --if ( getn(CT_RaidTracker_RaidLog[raidid]["Loot"]) == 0 or ( CT_RaidTrackerFrame.type and CT_RaidTrackerFrame.type ~= "items" ) ) then
        CT_RaidTrackerFrame.type = "events";
    --end

    CT_RaidTracker_UpdateView();
    CT_RaidTracker_Update();
end

function CT_RaidTracker_ShowInfo(player)
    CT_RaidTracker_GetPage();

    CT_RaidTrackerFrame.type = "player";
    CT_RaidTrackerFrame.player = player;
    CT_RaidTrackerFrame.selected = nil;
    
    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_Delete(self, id, type, typeid)
    CT_RaidTracker_Debug("DELETE", type, typeid);
    if ( type == "raid" ) then
        table.remove(CT_RaidTracker_RaidLog, id);
        if ( id == CT_RaidTracker_GetCurrentRaid ) then
            CT_RaidTracker_GetCurrentRaid = nil;
        end
        if ( CT_RaidTrackerFrame.selected == id ) then
            CT_RaidTrackerFrame.selected = CT_RaidTrackerFrame.selected - 1;
            if ( CT_RaidTrackerFrame.selected < 1 ) then
                CT_RaidTrackerFrame.selected = 1;
            end
            CT_RaidTrackerFrame.type = "events";
        end
    elseif ( type == "item" ) then
        local itemplayer, itemitemid, itemtime;
        itemplayer = self:GetParent().itemplayer;
        itemitemid = self:GetParent().itemitemid;
        itemtime = self:GetParent().itemtime;
        local lootid = CT_RaidTracker_GetLootId(id, itemplayer, itemitemid, itemtime);
        table.remove(CT_RaidTracker_RaidLog[id]["Loot"], lootid);
    elseif ( type == "player" ) then
        local bossid = CT_RaidTrackerFrame.selectedBossid;
        for key, val in pairs(CT_RaidTracker_RaidLog[id]["BossKills"][bossid]["attendees"]) do
            if val == typeid then
                tremove(CT_RaidTracker_RaidLog[id]["BossKills"][bossid]["attendees"],key);      
            end
        end
        CT_RaidTracker_Update_MerDKP(id);
    --[[
        for key, val in pairs(CT_RaidTracker_RaidLog[id]["Join"]) do
            if ( val["player"] == typeid ) then
                CT_RaidTracker_Debug("DELETE", "JOIN", "FOUND PLAYER", key, val["player"]);
                CT_RaidTracker_RaidLog[id]["Join"][key] = nil;
            end
        end
        for key, val in pairs(CT_RaidTracker_RaidLog[id]["Leave"]) do
            if ( val["player"] == typeid ) then
                CT_RaidTracker_Debug("DELETE", "LEAVE", "FOUND PLAYER", key, val["player"]);
                CT_RaidTracker_RaidLog[id]["Leave"][key] = nil;
            end
        end
        if(id == CT_RaidTracker_GetCurrentRaid) then
            CT_RaidTracker_Online[typeid] = nil;
        end
        if(CT_RaidTracker_RaidLog[id]["PlayerInfos"]) then
            CT_RaidTracker_RaidLog[id]["PlayerInfos"][typeid] = nil;
        end
        ]]--
    end
    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_SortBy(id)
    local table = { "name", "join", "leave" };
    if ( CT_RaidTracker_SortOptions["method"] == table[id] ) then
        if ( CT_RaidTracker_SortOptions["way"] == "asc" ) then
            CT_RaidTracker_SortOptions["way"] = "desc";
        else
            CT_RaidTracker_SortOptions["way"] = "asc";
        end
    else
        CT_RaidTracker_SortOptions["method"] = table[id];
        if ( table[id] ~= "leave" ) then
            CT_RaidTracker_SortOptions["way"] = "asc";
        else
            CT_RaidTracker_SortOptions["way"] = "desc";
        end
    end
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_SortItemBy(id)
    local table = { "name", "looted", "looter", "rarity" };
    local prefix = "";
    if ( CT_RaidTrackerFrame.type == "playeritems" ) then
        prefix = "player";
    end
    if ( CT_RaidTracker_SortOptions[prefix.."itemmethod"] == table[id] ) then
        if ( CT_RaidTracker_SortOptions[prefix.."itemway"] == "asc" ) then
            CT_RaidTracker_SortOptions[prefix.."itemway"] = "desc";
        else
            CT_RaidTracker_SortOptions[prefix.."itemway"] = "asc";
        end
    else
        CT_RaidTracker_SortOptions[prefix.."itemmethod"] = table[id];
        CT_RaidTracker_SortOptions[prefix.."itemway"] = "asc";
    end
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_SortPlayerRaids(id)
    if ( CT_RaidTrackerFrame.type == "itemhistory" ) then
        local table = { "name", "looter" };

        if ( CT_RaidTracker_SortOptions["itemhistorymethod"] == table[id] ) then
            if ( CT_RaidTracker_SortOptions["itemhistoryway"] == "asc" ) then
                CT_RaidTracker_SortOptions["itemhistoryway"] = "desc";
            else
                CT_RaidTracker_SortOptions["itemhistoryway"] = "asc";
            end
        else
            CT_RaidTracker_SortOptions["itemhistoryway"] = "asc";
            CT_RaidTracker_SortOptions["itemhistorymethod"] = table[id];
        end
    else        
        if ( CT_RaidTracker_SortOptions["playerraidway"] == "asc" ) then
            CT_RaidTracker_SortOptions["playerraidway"] = "desc";
        else
            CT_RaidTracker_SortOptions["playerraidway"] = "asc";
        end
    end
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_UpdateView()
    if ( CT_EmptyRaidTrackerFrame:IsVisible() ) then
        return;
    end
    local raidid = CT_RaidTrackerFrame.selected;
    if (CT_RaidTracker_RaidLog[raidid] == nil) then
        raidid = nil;
    end
    
    if(CT_RaidTrackerFrame.type == "events") then
        --CT_RaidTrackerFrameView2Button:SetText("查看活动");
    else
        --CT_RaidTrackerFrameView2Button:SetText("查看击杀");
        if(not raidid or ((not CT_RaidTracker_RaidLog[raidid]["BossKills"] or getn(CT_RaidTracker_RaidLog[raidid]["BossKills"]) == 0) and (not CT_RaidTracker_RaidLog[raidid]["Events"] or getn(CT_RaidTracker_RaidLog[raidid]["Events"]) == 0))) then
            --CT_RaidTrackerFrameView2Button:Disable();
        else
            CT_RaidTrackerFrameView2Button:Enable();
        end
    end

    if ( CT_RaidTrackerFrame.type == "raids" ) then
        CT_RaidTrackerDetailScrollFramePlayers:Show();
        CT_RaidTrackerDetailScrollFramePlayer:Hide();
        CT_RaidTrackerDetailScrollFrameItems:Hide();
        CT_RaidTrackerDetailScrollFrameEvents:Hide();
        local bossid = CT_RaidTrackerFrame.selectedBossid;
        local players = { };
        local bossName = CT_RaidTracker_RaidLog[raidid]["BossKills"][bossid]["boss"];
        if ( CT_RaidTracker_RaidLog[raidid] ) then
            local playerIndexes = { };
            for key, val in pairs(CT_RaidTracker_RaidLog[raidid]["BossKills"][bossid]["attendees"]) do
                players[key] = {};
                players[key]["name"] = val;
                players[key]["join"] = CT_RaidTracker_RaidLog[raidid]["BossKills"][bossid]["boss"];
                local dkp = CT_RaidTracker_RaidLog[raidid]["BossKills"][bossid]["dkp"];
                if dkp == nil then
                    dkp = "0";
                end
                players[key]["leave"] = dkp;
            end

            for k, v in pairs(players) do
                if ( not v["leave"] ) then
                    -- Very ugly hack, I know :(
                    players[k]["leave"] = 99999999999;
                end
            end
            players = CT_RaidTracker_Sort(players, CT_RaidTracker_SortOptions["method"], CT_RaidTracker_SortOptions["way"]);
            getglobal("CT_RaidTrackerDetailScrollFramePlayers").raidid = raidid;
            getglobal("CT_RaidTrackerDetailScrollFramePlayers").players = players;
            CT_RaidTracker_DetailScrollFramePlayers_Update();
        end
        CT_RaidTrackerParticipantsText:SetText("参与["..bossName.."]的团队成员 (" .. getn(players) .. ")");
        CT_RaidTrackerDetailScrollFramePlayers:Show();
    elseif ( CT_RaidTrackerFrame.type == "items" ) then
        CT_RaidTrackerDetailScrollFramePlayers:Hide();
        CT_RaidTrackerDetailScrollFramePlayer:Hide();
        CT_RaidTrackerDetailScrollFrameItems:Show();
        CT_RaidTrackerDetailScrollFrameEvents:Hide();
        local numItems, numHidden = 0, 0;
        if ( CT_RaidTracker_RaidLog[raidid] ) then
            local keystoremove = {};
            local loot = CT_RaidTracker_SortItem(CT_RaidTracker_RaidLog[raidid]["Loot"], CT_RaidTracker_SortOptions["itemmethod"], CT_RaidTracker_SortOptions["itemway"]);
            for key, val in pairs(loot) do
                val["thisitemid"] = tonumber(key);
                    val["item"]["tooltip"] = CT_RaidTracker_GetItemTooltip(val["item"]["id"]);
                    CT_RaidTracker_Debug("TooltipGet", val["item"]["name"]);
                if ( CT_RaidTracker_RarityTable[val["item"]["c"]] >= CT_RaidTracker_SortOptions["itemfilter"] ) then
                    numItems = numItems + 1;
                else
                    tinsert(keystoremove, key);
                    numHidden = numHidden + 1;
                end
            end
            for key, val in pairs(keystoremove) do
                table.remove(loot, val);
            end
            getglobal("CT_RaidTrackerDetailScrollFrameItems").raidid = raidid;
            getglobal("CT_RaidTrackerDetailScrollFrameItems").loot = loot;
            CT_RaidTracker_DetailScrollFrameItems_Update();
            CT_RaidTrackerDetailScrollFrameItems:Show();
        end
        if ( numHidden == 0 ) then
            CT_RaidTrackerItemsText:SetText("战利品 (" .. numItems .. "):");
        else
            CT_RaidTrackerItemsText:SetText("战利品 (" .. numItems .. "/" .. numHidden + numItems .. ")");
        end
        UIDropDownMenu_SetSelectedID(CT_RaidTrackerRarityDropDown, CT_RaidTracker_SortOptions["itemfilter"]);
        local colors = {
            "|c009d9d9d劣质|r",
            "|c00ffffff普通|r",
            "|c001eff00优秀|r",
            "|c000070dd精良|r",
            "|c00a335ee史诗|r",
            "|c00ff8000传说|r",
            "|c00e6cc80神器",
        };
            
        CT_RaidTrackerRarityDropDownText:SetText(colors[CT_RaidTracker_SortOptions["itemfilter"]]);
    elseif ( CT_RaidTrackerFrame.type == "player" ) then
        CT_RaidTrackerDetailScrollFramePlayers:Hide();
        CT_RaidTrackerDetailScrollFramePlayer:Show();
        CT_RaidTrackerDetailScrollFrameItems:Hide();
        CT_RaidTrackerDetailScrollFrameEvents:Hide();
        CT_RaidTrackerPlayerRaidTabLooter:Hide();
        CT_RaidTrackerPlayerRaidTab1:SetWidth(300);
        CT_RaidTrackerPlayerRaidTab1Middle:SetWidth(290);
        local name = CT_RaidTrackerFrame.player;

        local raids = { };
        for k, v in pairs(CT_RaidTracker_RaidLog) do
            local isInRaid;
            for key, val in pairs(v["Join"]) do
                if ( val["player"] == name ) then
                    tinsert(raids, { k, v });
                    break;
                end
            end
        end
        
        table.sort(
            raids,
            function(a1, a2)
                if ( CT_RaidTracker_SortOptions["playerraidway"] == "asc" ) then
                    return CT_RaidTracker_GetTime(a1[2]["key"]) < CT_RaidTracker_GetTime(a2[2]["key"]);
                else
                    return CT_RaidTracker_GetTime(a1[2]["key"]) > CT_RaidTracker_GetTime(a2[2]["key"]);
                end
            end
        );
        
        getglobal("CT_RaidTrackerDetailScrollFramePlayer").data = raids;
        getglobal("CT_RaidTrackerDetailScrollFramePlayer").name = name;
        getglobal("CT_RaidTrackerDetailScrollFramePlayer").maxlines = getn(raids);
        CT_RaidTracker_DetailScrollFramePlayer_Update();
        CT_RaidTrackerDetailScrollFramePlayer:Show();
        
        CT_RaidTrackerPlayerText:SetText(name .. "的Raids (" .. getn(raids) .. "):");
    elseif ( CT_RaidTrackerFrame.type == "itemhistory" ) then
        CT_RaidTrackerDetailScrollFramePlayers:Hide();
        CT_RaidTrackerDetailScrollFramePlayer:Show();
        CT_RaidTrackerDetailScrollFrameItems:Hide();
        CT_RaidTrackerDetailScrollFrameEvents:Hide();
        CT_RaidTrackerPlayerRaidTabLooter:Show();
        CT_RaidTrackerPlayerRaidTab1:SetWidth(163);
        CT_RaidTrackerPlayerRaidTab1Middle:SetWidth(155);

        local name, totalItems = CT_RaidTrackerFrame.itemname, 0;

        local items = { };
        for k, v in pairs(CT_RaidTracker_RaidLog) do
            for key, val in pairs(v["Loot"]) do
                if ( val["item"]["name"] == name ) then
                    tinsert(items, { k, v, val });
                    if ( val["item"]["count"] ) then
                        totalItems = totalItems + val["item"]["count"];
                    else
                        totalItems = totalItems + 1;
                    end
                end
            end
        end
        
        table.sort(
            items,
            function(a1, a2)
                if ( CT_RaidTracker_SortOptions["itemhistorymethod"] == "looter" ) then
                    if ( CT_RaidTracker_SortOptions["itemhistoryway"] == "asc" ) then
                        return a1[3]["player"] < a2[3]["player"];
                    else
                        return a1[3]["player"] > a2[3]["player"];
                    end
                else
                    if ( CT_RaidTracker_SortOptions["itemhistoryway"] == "asc" ) then
                        return CT_RaidTracker_GetTime(a1[2]["key"]) < CT_RaidTracker_GetTime(a2[2]["key"]);
                    else
                        return CT_RaidTracker_GetTime(a1[2]["key"]) > CT_RaidTracker_GetTime(a2[2]["key"]);
                    end
                end
            end
        );

        getglobal("CT_RaidTrackerDetailScrollFramePlayer").data = items;
        getglobal("CT_RaidTrackerDetailScrollFramePlayer").name = name;
        getglobal("CT_RaidTrackerDetailScrollFramePlayer").maxlines = getn(items);
        CT_RaidTracker_DetailScrollFramePlayer_Update();
        CT_RaidTrackerDetailScrollFramePlayer:Show();
        CT_RaidTrackerPlayerText:SetText(name .. " (" .. getn(items) .. "/" .. totalItems .. "):");
    elseif ( CT_RaidTrackerFrame.type == "events" ) then
        CT_RaidTrackerDetailScrollFramePlayers:Hide();
        CT_RaidTrackerDetailScrollFramePlayer:Hide();
        CT_RaidTrackerDetailScrollFrameEvents:Show();
        CT_RaidTrackerDetailScrollFrameItems:Hide();
        CT_RaidTrackerPlayerBossesTabBoss:Show();
        CT_RaidTrackerPlayerBossesTab1:SetWidth(163);
        CT_RaidTrackerPlayerBossesTab1Middle:SetWidth(155);

        local events = {};
        if ( CT_RaidTracker_RaidLog[raidid] and CT_RaidTracker_RaidLog[raidid]["BossKills"] ) then
            for key, val in pairs(CT_RaidTracker_RaidLog[raidid]["BossKills"]) do
                tinsert(events, val);
            end
        end
        getglobal("CT_RaidTrackerDetailScrollFrameEvents").raidid = raidid;
        getglobal("CT_RaidTrackerDetailScrollFrameEvents").events = events;
        
        CT_RaidTrackerEventsText:SetText("事件：");
        CT_RaidTracker_DetailScrollFrameBoss_Update();
        CT_RaidTrackerDetailScrollFrameEvents:Show();
    elseif ( CT_RaidTrackerFrame.type == "playeritems" ) then
        CT_RaidTrackerDetailScrollFramePlayers:Hide();
        CT_RaidTrackerDetailScrollFramePlayer:Hide();
        CT_RaidTrackerDetailScrollFrameItems:Show();
        CT_RaidTrackerDetailScrollFrameEvents:Hide();
        local name = CT_RaidTrackerFrame.player;

        local loot = { };
        for k, v in pairs(CT_RaidTracker_RaidLog) do
            for key, val in pairs(v["Loot"]) do
                if ( val["player"] == name ) then
                    tinsert(
                        loot,
                        {
                            ["note"] = val["note"],
                            ["player"] = val["player"],
                            ["time"] = val["time"],
                            ["item"] = val["item"],
                            ["ids"] = { k, key }
                        }
                    );
                end
            end
        end

        local numItems, numHidden = 0, 0;
        local keystoremove = {};
        loot = CT_RaidTracker_SortItem(loot, CT_RaidTracker_SortOptions["playeritemmethod"], CT_RaidTracker_SortOptions["playeritemway"]);
        for key, val in pairs(loot) do
            if ( CT_RaidTracker_RarityTable[val["item"]["c"]] >= CT_RaidTracker_SortOptions["playeritemfilter"] ) then
                numItems = numItems + 1;
            else
                tinsert(keystoremove, key);
                numHidden = numHidden + 1;
            end
        end
        for key, val in pairs(keystoremove) do
            table.remove(loot, val);
        end
        getglobal("CT_RaidTrackerDetailScrollFrameItems").raidid = raidid;
        getglobal("CT_RaidTrackerDetailScrollFrameItems").loot = loot;
        CT_RaidTracker_DetailScrollFrameItems_Update();
        if ( numHidden == 0 ) then
            CT_RaidTrackerItemsText:SetText(name .. "的拾取 (" .. numItems .. "):");
        else
            CT_RaidTrackerItemsText:SetText(name .. "的拾取 (" .. numItems .. "/" .. numHidden + numItems .. "):");
        end

        UIDropDownMenu_SetSelectedID(CT_RaidTrackerRarityDropDown, CT_RaidTracker_SortOptions["playeritemfilter"]);
        local colors = {
            "|c009d9d9d劣质|r",
            "|c00ffffff普通|r",
            "|c001eff00优秀|r",
            "|c000070dd精良|r",
            "|c00a335ee史诗|r",
            "|c00ff8000传说|r",
            "|c00e6cc80神器",
        };
            
        CT_RaidTrackerRarityDropDownText:SetText(colors[CT_RaidTracker_SortOptions["playeritemfilter"]]);
    end
end

function CT_RaidTracker_DetailScrollFramePlayer_Update()
    local data = getglobal("CT_RaidTrackerDetailScrollFramePlayer").data;
    local name = getglobal("CT_RaidTrackerDetailScrollFramePlayer").name;
    local maxlines = getglobal("CT_RaidTrackerDetailScrollFramePlayer").maxlines;
    local line;
    local lineplusoffset;
    FauxScrollFrame_Update(CT_RaidTrackerDetailScrollFramePlayer, maxlines, 11, 18);
    for line=1, 11 do
        lineplusoffset = line+FauxScrollFrame_GetOffset(CT_RaidTrackerDetailScrollFramePlayer);
        if (lineplusoffset <= maxlines) then
            val = data[lineplusoffset];
            if ( CT_RaidTrackerFrame.type == "player" ) then
                getglobal("CT_RaidTrackerPlayerRaid" .. line).raidid = val[1];
                getglobal("CT_RaidTrackerPlayerRaid" .. line).playername = name;
                getglobal("CT_RaidTrackerPlayerRaid" .. line).raidtitle = CT_RaidTracker_GetRaidTitle(val[1], 1);
    
                local iNumber = getn(CT_RaidTracker_RaidLog)-val[1]+1;
                if ( iNumber < 10 ) then
                    iNumber = "  " .. iNumber;
                end
    
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "MouseOverLeft"):Hide();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "MouseOverRight"):Hide();
    
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "HitAreaLeft"):Hide();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "HitAreaRight"):Hide();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "HitArea"):Show();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "Note"):Hide();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "NoteButton"):Show();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "DeleteButton"):Show();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "DeleteText"):Show();
    
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "Number"):SetText(iNumber);
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "Name"):SetWidth(200);
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "Name"):SetText(CT_RaidTracker_GetRaidTitle(val[1], 1));

                if ( val[2]["PlayerInfos"][name] and val[2]["PlayerInfos"][name]["note"] ) then
                    getglobal("CT_RaidTrackerPlayerRaid" .. line .. "NoteButtonNormalTexture"):SetVertexColor(1, 1, 1);
                else
                    getglobal("CT_RaidTrackerPlayerRaid" .. line .. "NoteButtonNormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
                end
            elseif ( CT_RaidTrackerFrame.type == "itemhistory" ) then
                getglobal("CT_RaidTrackerPlayerRaid" .. line).raidid = val[1];
    
                local iNumber = getn(CT_RaidTracker_RaidLog)-val[1]+1;
                if ( iNumber < 10 ) then
                    iNumber = "  " .. iNumber;
                end
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "MouseOver"):Hide();
    
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "HitAreaLeft"):Show();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "HitAreaRight"):Show();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "HitArea"):Hide();
    
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "NoteButton"):Hide();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "Note"):Show();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "DeleteButton"):Hide();
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "DeleteText"):Hide();
    
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "Number"):SetText(iNumber);
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "Name"):SetWidth(130);
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "Name"):SetText(CT_RaidTracker_GetRaidTitle(val[1], 1));
                getglobal("CT_RaidTrackerPlayerRaid" .. line .. "Note"):SetText(val[3]["player"]);
            end
            getglobal("CT_RaidTrackerPlayerRaid" .. line):Show();
        else
            getglobal("CT_RaidTrackerPlayerRaid" .. line):Hide();
        end
    end
    CT_RaidTrackerDetailScrollFramePlayer:Show();
end

function CT_RaidTracker_DetailScrollFramePlayers_Update()
    local raidid = getglobal("CT_RaidTrackerDetailScrollFramePlayers").raidid;
    local players = getglobal("CT_RaidTrackerDetailScrollFramePlayers").players;
    local maxlines = getn(players);
    local line;
    local lineplusoffset;
    FauxScrollFrame_Update(CT_RaidTrackerDetailScrollFramePlayers, maxlines, 11, 18);
    for line=1, 11 do
        lineplusoffset = line+FauxScrollFrame_GetOffset(CT_RaidTrackerDetailScrollFramePlayers);
        if (lineplusoffset <= maxlines) then
            val = players[lineplusoffset];
            getglobal("CT_RaidTrackerPlayerLine" .. line).raidid = raidid;
            getglobal("CT_RaidTrackerPlayerLine" .. line).raidtitle = CT_RaidTracker_GetRaidTitle(raidid, 1);
            getglobal("CT_RaidTrackerPlayerLine" .. line).playername = val["name"];
            local name = getglobal("CT_RaidTrackerPlayerLine" .. line .. "Name");
            local number = getglobal("CT_RaidTrackerPlayerLine" .. line .. "Number");
            local join = getglobal("CT_RaidTrackerPlayerLine" .. line .. "Join");
            local leave = getglobal("CT_RaidTrackerPlayerLine" .. line .. "Leave");
            if ( name ) then
                name:SetText(val["name"]);
                local iNumber = lineplusoffset;
                if ( iNumber < 10 ) then
                    iNumber = "  " .. iNumber;
                end
                number:SetText(iNumber);

                join:SetText(val["join"]);

                if ( val["leave"] == 99999999999 ) then
                    leave:SetText("");
                else
                    leave:SetText(val["leave"]);
                end
                if ( CT_RaidTracker_RaidLog[raidid]["PlayerInfos"][val["name"]] and CT_RaidTracker_RaidLog[raidid]["PlayerInfos"][val["name"]]["note"] ) then
                --  getglobal("CT_RaidTrackerPlayerLine" .. line .. "NoteButtonNormalTexture"):SetVertexColor(1, 1, 1);
                else
                --  getglobal("CT_RaidTrackerPlayerLine" .. line .. "NoteButtonNormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
                end
            --  getglobal("CT_RaidTrackerPlayerLine" .. line .. "NoteButton"):Show();
                getglobal("CT_RaidTrackerPlayerLine" .. line .. "DeleteButton"):Show();
                getglobal("CT_RaidTrackerPlayerLine" .. line):Show();
            end
        else
            getglobal("CT_RaidTrackerPlayerLine" .. line):Hide();
        end
    end
    CT_RaidTrackerDetailScrollFramePlayers:Show();
end

function CT_RaidTracker_DetailScrollFrameItems_Update()
    local raidid = getglobal("CT_RaidTrackerDetailScrollFrameItems").raidid;
    local loot = getglobal("CT_RaidTrackerDetailScrollFrameItems").loot;
    local maxlines = getn(loot);
    local line;
    local lineplusoffset;
    FauxScrollFrame_Update(CT_RaidTrackerDetailScrollFrameItems, maxlines, 5, 41);
    for line=1, 5 do
        lineplusoffset = line+FauxScrollFrame_GetOffset(CT_RaidTrackerDetailScrollFrameItems);
        if (lineplusoffset <= maxlines) then
            local val = loot[lineplusoffset];
            if ( CT_RaidTrackerFrame.type == "items" ) then
                getglobal("CT_RaidTrackerItem" .. line).raidid = raidid;
                getglobal("CT_RaidTrackerItem" .. line).itemid = val["thisitemid"];
                getglobal("CT_RaidTrackerItem" .. line).itemname = val["item"]["name"];
                if ( val["item"]["count"] and val["item"]["count"] > 1 ) then
                    getglobal("CT_RaidTrackerItem" .. line .. "Count"):Show();
                    getglobal("CT_RaidTrackerItem" .. line .. "Count"):SetText(val["item"]["count"]);
                else
                    getglobal("CT_RaidTrackerItem" .. line .. "Count"):Hide();
                end
                if ( val["item"]["icon"] ) then
                    getglobal("CT_RaidTrackerItem" .. line .. "IconTexture"):SetTexture(val["item"]["icon"]);
                else
                    getglobal("CT_RaidTrackerItem" .. line .. "IconTexture"):SetTexture("Interface\\Icons\\INV_Misc_Gear_08");
                end
                local color = val["item"]["c"];
                if ( color == "ff1eff00" ) then
                    color = "ff005D00";
                end
                local costs = val["costs"];
               if costs==nil then
                  costs = 0;
              end
                getglobal("CT_RaidTrackerItem" .. line .. "Description"):SetText("|c" .. color .. val["item"]["name"].."|c33333300 "..costs.." DKP");
                getglobal("CT_RaidTrackerItem" .. line .. "Looted"):SetText("拾取者: " .. val["player"]);
    
                if ( val["note"] ) then
                    getglobal("CT_RaidTrackerItem" .. line .. "NoteNormalTexture"):SetVertexColor(1, 1, 1);
                else
                    getglobal("CT_RaidTrackerItem" .. line .. "NoteNormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
                end
            elseif ( CT_RaidTrackerFrame.type == "playeritems" ) then
                getglobal("CT_RaidTrackerItem" .. line).raidid = val["ids"][1];
                getglobal("CT_RaidTrackerItem" .. line).itemid = val["ids"][2];
                getglobal("CT_RaidTrackerItem" .. line).itemname = val["item"]["name"];

                if ( val["item"]["count"] and val["item"]["count"] > 1 ) then
                    getglobal("CT_RaidTrackerItem" .. line .. "Count"):Show();
                    getglobal("CT_RaidTrackerItem" .. line .. "Count"):SetText(val["item"]["count"]);
                else
                    getglobal("CT_RaidTrackerItem" .. line .. "Count"):Hide();
                end
                if ( val["item"]["icon"] ) then
                    getglobal("CT_RaidTrackerItem" .. line .. "IconTexture"):SetTexture("Interface\\Icons\\" .. val["item"]["icon"]);
                else
                    getglobal("CT_RaidTrackerItem" .. line .. "IconTexture"):SetTexture("Interface\\Icons\\INV_Misc_Gear_08");
                end
                local color = val["item"]["c"];
                if ( color == "ff1eff00" ) then
                    color = "ff005D00";
                end
                getglobal("CT_RaidTrackerItem" .. line .. "Description"):SetText("|c" .. color .. val["item"]["name"]);
                getglobal("CT_RaidTrackerItem" .. line .. "Looted"):SetText("拾取 " .. CT_RaidTracker_GetRaidTitle(val["ids"][1], 1));

                if ( val["note"] ) then
                    getglobal("CT_RaidTrackerItem" .. line .. "NoteNormalTexture"):SetVertexColor(1, 1, 1);
                else
                    getglobal("CT_RaidTrackerItem" .. line .. "NoteNormalTexture"):SetVertexColor(0.5, 0.5, 0.5);
                end 
            end
            getglobal("CT_RaidTrackerItem" .. line):Show();
        else
            getglobal("CT_RaidTrackerItem" .. line):Hide();
        end
    end
    CT_RaidTrackerDetailScrollFrameItems:Show();
end

function CT_RaidTracker_DetailScrollFrameBoss_Update()
    local events = getglobal("CT_RaidTrackerDetailScrollFrameEvents").events;
    local raidid = getglobal("CT_RaidTrackerDetailScrollFrameEvents").raidid;
    local maxlines = getn(events);
    local line;
    local lineplusoffset;
    FauxScrollFrame_Update(CT_RaidTrackerDetailScrollFrameEvents, maxlines, 11, 18);
    for line=1, 11 do
        lineplusoffset = line+FauxScrollFrame_GetOffset(CT_RaidTrackerDetailScrollFrameEvents);
        if (lineplusoffset <= maxlines) then
            val = events[lineplusoffset];
            local dkp = val["dkp"];
            if dkp == nil then
                dkp = 0;
            end
            getglobal("CT_RaidTrackerBosses" .. line).bossid = lineplusoffset;
            getglobal("CT_RaidTrackerBosses" .. line).raidid = raidid;
            getglobal("CT_RaidTrackerBosses" .. line .. "MouseOver"):Hide();
            getglobal("CT_RaidTrackerBosses" .. line .. "HitArea"):Show();

            getglobal("CT_RaidTrackerBosses" .. line .. "Boss"):SetText(val["boss"].." "..dkp.." DKP");
            getglobal("CT_RaidTrackerBosses" .. line .. "Time"):SetText(getn(val["attendees"]).."人参与-点击查看");
            getglobal("CT_RaidTrackerBosses" .. line):Show();
        else
            getglobal("CT_RaidTrackerBosses" .. line):Hide();
        end
    end
    CT_RaidTrackerDetailScrollFrameEvents:Show();
end

function CT_RaidTrackerItem_SetHyperlink(self)
    local raidid = self.raidid;
    local lootid = self.itemid;
    if ( CT_RaidTracker_RaidLog[raidid] and CT_RaidTracker_RaidLog[raidid]["Loot"][lootid] ) then
        local item = CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"];
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        if (GetItemInfo("item:" .. item["id"])) then
            GameTooltip:SetHyperlink("item:" .. item["id"]);
        else
            rl, gl, bl = CT_RaidTracker_ColorToRGB(item["c"]);
            GameTooltip:AddLine(item["name"], rl, gl, bl);
            GameTooltip:AddLine("如果你的缓存中没有这个战利品信息请点击右键 ( 很可能掉线!)", 1, 1, 1);
        end
        
        GameTooltip:AddLine("拾取时间: "..CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["time"], 1, 1, 0);
        if(CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["zone"]) then
            GameTooltip:AddLine("掉落地区: "..CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["zone"], 1, 1, 0);
        end
        if(CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["boss"]) then
            GameTooltip:AddLine("掉落Boss: "..CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["boss"], 1, 1, 0);
        end
        if(CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["costs"]) then
            GameTooltip:AddLine("战利品价值: "..CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["costs"], 1, 1, 0);
        end
        if(CT_RaidTracker_Options["DebugFlag"]) then
            if(CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"]["class"]) then
                GameTooltip:AddLine("装备位置: "..CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"]["class"], 1, 1, 0);
            end
            if(CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"]["subclass"]) then
                GameTooltip:AddLine("战利品类型: "..CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"]["subclass"], 1, 1, 0);
            end
        end

        GameTooltip:Show();
        return;
    end
end

function CT_RaidTrackerItem_GetChatHyperlink(self)
    local raidid = self.raidid;
    local lootid = self.itemid;
    if ( IsShiftKeyDown() and ( type(WIM_API_InsertText) == "function" ) and CT_RaidTracker_RaidLog[raidid] and CT_RaidTracker_RaidLog[raidid]["Loot"][lootid] ) then
        local item = CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"];
        WIM_API_InsertText( "|c" .. item.c .. "|Hitem:" .. item.id .. "|h[" .. item.name .. "]|h|r" );
    end 
    if ( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() and CT_RaidTracker_RaidLog[raidid] and CT_RaidTracker_RaidLog[raidid]["Loot"][lootid] ) then
        local item = CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"];
        ChatFrameEditBox:Insert("|c" .. item.c .. "|Hitem:" .. item.id .. "|h[" .. item.name .. "]|h|r");
    end
end

function CT_RaidTracker_DKPSystemDropDown_Initialize(self)
    local info;
    for i = 1, #MerDKP_Table do
        info = {}
        info.text = MerDKP_Table[i].title
        info.value = MerDKP_Table[i].title
        info.func = function(self)
            local id = self:GetID()
            UIDropDownMenu_SetSelectedID(CT_RaidTracker_DKPSystemDropDown, id)
            UIDropDownMenu_SetSelectedID(MerDKPFrameListColumnHeader3, id)
            MerDKP.tmp.id = id
            MerDKP_InitDKP()
        end
        UIDropDownMenu_AddButton(info)
    end     
end

function CT_RaidTracker_PlayerDKPDropDown_Initialize(self)
    local info;
    if(CT_RaidTracker_GetCurrentRaid==nil) then
        return
    end
    for k, v in pairs(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"]) do
        info = {}
        info.text = k;
        info.value = k;
        info.func = function(self)
            local id = self:GetID()
            UIDropDownMenu_SetSelectedID(CT_RaidTracker_PlayerDKPDropDown, id)          
        end
        UIDropDownMenu_AddButton(info)
    end     
end

function CT_RaidTracker_SelectItem(name) --not used
    CT_RaidTracker_GetPage();
    CT_RaidTrackerFrame.type = "itemhistory";
    CT_RaidTrackerFrame.itemname = name;
    CT_RaidTrackerFrame.selected = nil;
    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_GetPage()
    if ( CT_RaidTrackerFrame.type or CT_RaidTrackerFrame.itemname or CT_RaidTrackerFrame.selected or CT_RaidTrackerFrame.player ) then
        tinsert(CT_RaidTracker_LastPage,
            {
                ["type"] = CT_RaidTrackerFrame.type,
                ["itemname"] = CT_RaidTrackerFrame.itemname,
                ["selected"] = CT_RaidTrackerFrame.selected,
                ["player"] = CT_RaidTrackerFrame.player
            }
        );
    end

    if ( getn(CT_RaidTracker_LastPage) > 0 ) then
        CT_RaidTrackerFrameBackButton:Enable();
    else
        CT_RaidTrackerFrameBackButton:Disable();
    end
end

function CT_RaidTracker_GoBack() --not used
    local t = table.remove(CT_RaidTracker_LastPage);

    if ( t ) then
        CT_RaidTrackerFrame.type = t["type"];
        CT_RaidTrackerFrame.itemname = t["itemname"];
        CT_RaidTrackerFrame.selected = t["selected"];
        CT_RaidTrackerFrame.player = t["player"];
        CT_RaidTracker_Update();
        CT_RaidTracker_UpdateView();
    end
    if ( getn(CT_RaidTracker_LastPage) > 0 ) then
        CT_RaidTrackerFrameBackButton:Enable();
    else
        --CT_RaidTrackerFrameBackButton:Disable();
    end
end

function CT_RaidTrackerUpdateFrame_OnUpdate(this, elapsed) --Reviewed
    if ( this.time ) then
        this.time = this.time + elapsed;
        if ( this.time > 2 ) then
            this.time = nil;
            for k, v in pairs(CT_RaidTracker_Events) do
                CT_RaidTracker_OnEvent(v);
            end
        end
    end
end

function CT_RaidTrackerEndRaid()
    local raidendtime = CT_RaidTracker_Date();
    if(CT_RaidTracker_GetCurrentRaid) then
        CT_RaidTracker_Print("活动结束时间 "..raidendtime, 1, 1, 0);
        for k, v in pairs(CT_RaidTracker_Online) do
            CT_RaidTracker_Debug("ADDING LEAVE", k, raidendtime);
            tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Leave"],
                {
                    ["player"] = k,
                    ["time"] = raidendtime,
                }
            );
        end
        if(not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["End"]) then
            CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["End"] = raidendtime;
        end
        CT_RaidTracker_GetCurrentRaid = nil;
        CT_RaidTracker_Debug("Left raid.","CT_RaidTrackerEndRaid");
        CT_RaidTracker_Online = { };
        CT_RaidTracker_UpdateView();
        CT_RaidTracker_Update();
    end
end

function CT_RaidTracker_ItemsRightClickMenu_Initialize(self, level) --Reviewed
    if(not level) then
        return;
    end
    local raidid, itemid = 0, 0;
    local dropdown, info, lvalue;

    if ( UIDROPDOWNMENU_OPEN_MENU ) then
        dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
    else
        dropdown = self;
    end

    if (level == 1) then
        raidid = self:GetParent().raidid;
        itemid = self:GetParent().itemid;
        local itemitemid = CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["item"]["id"];
        local itemtime = CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["time"];
        local itemplayer = CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["player"];
        
        info = UIDropDownMenu_CreateInfo();
        info.text = "编辑拾取者";
        info.hasArrow = 1;
        info.value = { ["opt"] = "quick_looter", ["raidid"] = raidid, ["itemid"] = itemid, ["itemitemid"] = itemitemid, ["itemtime"] = itemtime, ["itemplayer"] = itemplayer, ["cplayer"] = CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["player"] };
        info.func = function(self)
            HideDropDownMenu(1);
            local lootid = CT_RaidTracker_GetLootId(self.value["raidid"], self.value["itemplayer"], self.value["itemitemid"], self.value["itemtime"]);
            CT_RaidTracker_EditLooter(self.value["raidid"], lootid);
        end;
        UIDropDownMenu_AddButton(info, level);
        
        info = UIDropDownMenu_CreateInfo();
        if(CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["costs"]) then
            info.text = "编辑DKP ("..CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["costs"]..")";
        else
            info.text = "编辑DKP";
        end
        info.value = { ["raidid"] = raidid, ["itemid"] = itemid, ["itemitemid"] = itemitemid, ["itemtime"] = itemtime, ["itemplayer"] = itemplayer };
        info.func = function(self)
            HideDropDownMenu(1);
            local lootid = CT_RaidTracker_GetLootId(self.value["raidid"], self.value["itemplayer"], self.value["itemitemid"], self.value["itemtime"]);
            CT_RaidTracker_EditCosts(self.value.raidid, lootid);
        end;
        UIDropDownMenu_AddButton(info, level);
        
        info = UIDropDownMenu_CreateInfo();
        if(CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["item"]["count"]) then
            info.text = "编辑数量 ("..CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["item"]["count"]..")";
        else
            info.text = "编辑数量";
        end
        info.value = { ["raidid"] = raidid, ["itemid"] = itemid, ["itemitemid"] = itemitemid, ["itemtime"] = itemtime, ["itemplayer"] = itemplayer };
        info.func = function(self)
            HideDropDownMenu(1);
            local lootid = CT_RaidTracker_GetLootId(self.value["raidid"], self.value["itemplayer"], self.value["itemitemid"], self.value["itemtime"]);
            CT_RaidTracker_EditItemCount(self.value.raidid, lootid);
        end;
        UIDropDownMenu_AddButton(info, level);
        
        info = UIDropDownMenu_CreateInfo();
        info.text = "编辑时间";
        info.value = { ["raidid"] = raidid, ["itemid"] = itemid, ["itemitemid"] = itemitemid, ["itemtime"] = itemtime, ["itemplayer"] = itemplayer };
        info.func = function(self)
            HideDropDownMenu(1);
            local lootid = CT_RaidTracker_GetLootId(self.value["raidid"], self.value["itemplayer"], self.value["itemitemid"], self.value["itemtime"]);
            CT_RaidTracker_EditItemTime(self.value.raidid, lootid);
        end;
        UIDropDownMenu_AddButton(info, level);
        
        info = UIDropDownMenu_CreateInfo();
        info.text = "掉落Boss:";
        info.hasArrow = 1;
        info.value = { ["opt"] = "dropped_from_zones", ["raidid"] = raidid, ["itemid"] = itemid, ["itemitemid"] = itemitemid, ["itemtime"] = itemtime, ["itemplayer"] = itemplayer };
        if(CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["boss"]) then
            info.text = "掉落Boss: "..CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["boss"];
            info.value["cboss"] = CT_RaidTracker_RaidLog[raidid]["Loot"][itemid]["boss"];
            info.checked = 1;
        else
            info.text = "掉落Boss: 未知";
        end
        UIDropDownMenu_AddButton(info, level);
        
    elseif (level == 2) then
        lvalue = UIDROPDOWNMENU_MENU_VALUE;
        
        if(lvalue) then
            if(lvalue["opt"] == "dropped_from_zones") then
                for k, v in pairs(CT_RaidTracker_Bosses) do
                    info = {};
                    if(v == 1) then
                        info.text = k;
                        info.value = { ["raidid"] = lvalue["raidid"], ["itemid"] = lvalue["itemid"], ["zone"] = lvalue["zone"], ["boss"] = k, ["itemitemid"] = lvalue["itemitemid"], ["itemtime"] = lvalue["itemtime"], ["itemplayer"] = lvalue["itemplayer"] };
                        info.func = function(self)
                            HideDropDownMenu(1);
                            CT_RaidTracker_LootSetBoss(lvalue["raidid"], lvalue["itemitemid"], lvalue["itemtime"], lvalue["itemplayer"], self.value["boss"])
                        end;
                        if(lvalue["cboss"] == k) then
                            info.checked = 1;
                        end
                    else
                        info.text = k;
                        info.hasArrow = 1;
                        info.value = { ["opt"] = "dropped_from_bosses", ["raidid"] = lvalue["raidid"], ["itemid"] = lvalue["itemid"], ["zone"] = k, ["cboss"] = lvalue["cboss"], ["itemitemid"] = lvalue["itemitemid"], ["itemtime"] = lvalue["itemtime"], ["itemplayer"] = lvalue["itemplayer"] };
                        if(lvalue["cboss"]) then
                            for k2, v2 in pairs(CT_RaidTracker_Bosses[k]) do
                                if(lvalue["cboss"] == v2) then
                                    info.checked = 1;
                                    break;
                                end
                            end
                        end
                    end
                    UIDropDownMenu_AddButton(info, level);
                end
                
                info = UIDropDownMenu_CreateInfo();
                info.text = "无";
                info.value = lvalue;
                info.func = function(self)
                    HideDropDownMenu(1);
                    CT_RaidTracker_LootSetBoss(self.value["raidid"], self.value["itemitemid"], self.value["itemtime"], self.value["itemplayer"], nil)
                end;
                UIDropDownMenu_AddButton(info, level);
            elseif(lvalue["opt"] == "quick_looter") then
                if(CT_RaidTracker_QuickLooter and getn(CT_RaidTracker_QuickLooter) >= 1) then
                    for k, v in pairs(CT_RaidTracker_QuickLooter) do
                        info = UIDropDownMenu_CreateInfo();
                        info.text = v;
                        info.value = { ["raidid"] = lvalue["raidid"], ["itemid"] = lvalue["itemid"], ["itemitemid"] = lvalue["itemitemid"], ["itemtime"] = lvalue["itemtime"], ["itemplayer"] = lvalue["itemplayer"], ["player"] = v, ["cplayer"] = lvalue["cplayer"] };
                        info.func = function(self)
                            HideDropDownMenu(1);
                            CT_RaidTracker_LootSetLooter(self.value["raidid"], self.value["itemitemid"], self.value["itemtime"], self.value["itemplayer"], self.value["player"]);
                        end;
                        if(lvalue["cplayer"] == v) then
                            info.checked = 1;
                        end
                        UIDropDownMenu_AddButton(info, level);
                    end
                    info = UIDropDownMenu_CreateInfo();
                    info.disabled = 1;
                    UIDropDownMenu_AddButton(info, level);
                end
                PlayerGroups = CT_RaidTracker_GetPlayerGroups(lvalue["raidid"]);
                for k, v in pairs(PlayerGroups) do
                    info = UIDropDownMenu_CreateInfo();
                    info.text = k;
                    info.hasArrow = 1;
                    info.value = { ["opt"] = "quick_looter_subplayers", ["raidid"] = lvalue["raidid"], ["itemid"] = lvalue["itemid"], ["playergroupsindex"] = k, ["itemitemid"] = lvalue["itemitemid"], ["itemtime"] = lvalue["itemtime"], ["itemplayer"] = lvalue["itemplayer"], ["players"] = v, ["cplayer"] = lvalue["cplayer"] };
                    for k2, v2 in pairs(v) do
                        if(lvalue["cplayer"] == v2) then
                            info.checked = 1;
                            break;
                        end
                    end
                    UIDropDownMenu_AddButton(info, level);
                end
            end
        end
    elseif (level == 3) then
        lvalue = UIDROPDOWNMENU_MENU_VALUE;
        
        if(lvalue) then
            if(lvalue["opt"] == "dropped_from_bosses") then
                for k, v in pairs(CT_RaidTracker_Bosses[lvalue["zone"]]) do
                    if (type(v) == "table") then
                        for k2, v2 in pairs(v) do
                            info = UIDropDownMenu_CreateInfo();
                            info.text = k..' - '..v2;
                            info.value = { ["raidid"] = lvalue["raidid"], ["itemid"] = lvalue["itemid"], ["zone"] = lvalue["zone"], ["itemitemid"] = lvalue["itemitemid"], ["itemtime"] = lvalue["itemtime"], ["itemplayer"] = lvalue["itemplayer"], ["boss"] = v2 };
                            info.func = function(self)
                                HideDropDownMenu(1);
                                CT_RaidTracker_LootSetBoss(self.value["raidid"], self.value["itemitemid"], self.value["itemtime"], self.value["itemplayer"], self.value["boss"])
                            end;
                            if(lvalue["cboss"] == v) then
                                info.checked = 1;
                            end
                            UIDropDownMenu_AddButton(info, level);
                        end;
                    else
                        info = UIDropDownMenu_CreateInfo();
                        info.text = v;
                        info.value = { ["raidid"] = lvalue["raidid"], ["itemid"] = lvalue["itemid"], ["zone"] = lvalue["zone"], ["itemitemid"] = lvalue["itemitemid"], ["itemtime"] = lvalue["itemtime"], ["itemplayer"] = lvalue["itemplayer"], ["boss"] = v };
                        info.func = function(self)
                            HideDropDownMenu(1);
                            CT_RaidTracker_LootSetBoss(self.value["raidid"], self.value["itemitemid"], self.value["itemtime"], self.value["itemplayer"], self.value["boss"])
                        end;
                        if(lvalue["cboss"] == v) then
                            info.checked = 1;
                        end
                        UIDropDownMenu_AddButton(info, level);
                    end
                end
            elseif(lvalue["opt"] == "quick_looter_subplayers") then
                for k, v in pairs(lvalue["players"]) do
                    info = UIDropDownMenu_CreateInfo();
                    info.text = v;
                    info.value = { ["raidid"] = lvalue["raidid"], ["itemid"] = lvalue["itemid"], ["itemitemid"] = lvalue["itemitemid"], ["itemtime"] = lvalue["itemtime"], ["itemplayer"] = lvalue["itemplayer"], ["player"] = v };
                    info.func = function(self)
                        HideDropDownMenu(1);
                        CT_RaidTracker_LootSetLooter(self.value["raidid"], self.value["itemitemid"], self.value["itemtime"], self.value["itemplayer"], self.value["player"]);
                    end;
                    if(CT_RaidTracker_RaidLog[lvalue["raidid"]]["Loot"][lvalue["itemid"]]["player"] == v) then
                        info.checked = 1;
                    end
                    UIDropDownMenu_AddButton(info, level);
                end
            end
        end
    end
end

function CT_RaidTracker_ItemsRightClickMenu_Toggle(self) --Reviewed
    local menu = getglobal(self:GetParent():GetName().."RightClickMenu");
    menu.point = "TOPLEFT";
    menu.relativePoint = "BOTTOMLEFT";
    ToggleDropDownMenu(1, nil, menu, "cursor", -60, 0);
end

function CT_RaidTracker_RaidsRightClickMenu_Initialize(self,level)
    if(not level) then
        return;
    end
    local raidid, itemid = 0, 0;
    local dropdown, info, lvalue;

    if ( UIDROPDOWNMENU_OPEN_MENU ) then
        dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
    else
        dropdown = self;
    end
    
    if (level == 1) then
        raidid = self:GetID() + FauxScrollFrame_GetOffset(CT_RaidTrackerListScrollFrame);
        
        info = {};
        if ( CT_RaidTracker_RaidLog[raidid]["key"] ) then
            info.text = "编辑开始时间 ("..CT_RaidTracker_RaidLog[raidid]["key"]..")";
        else
            info.text = "编辑开始时间";
        end
        info.value = { ["raidid"] = raidid, ["what"] = "raidstart"};
        info.func = function(self)
            HideDropDownMenu(1);
            CT_RaidTracker_EditTime(self.value["raidid"], self.value["what"]);
        end;
        UIDropDownMenu_AddButton(info, level);
        
        info = {};
        if ( CT_RaidTracker_RaidLog[raidid]["End"] ) then
            info.text = "编辑结束时间 ("..CT_RaidTracker_RaidLog[raidid]["End"]..")";
        else
            info.text = "编辑结束时间";
        end
        info.value = { ["raidid"] = raidid, ["what"] = "raidend"};
        info.func = function(self)
            HideDropDownMenu(1);
            CT_RaidTracker_EditTime(self.value["raidid"], self.value["what"]);
        end;
        UIDropDownMenu_AddButton(info, level);
        
        info = {};
        if ( CT_RaidTracker_RaidLog[raidid]["zone"] ) then
            info.text = "编辑活动名称 ("..CT_RaidTracker_RaidLog[raidid]["zone"]..")";
        else
            info.text = "编辑活动名称";
        end
        info.hasArrow = 1;
        info.value = { ["opt"] = "raid_zones", ["raidid"] = raidid};
        info.func = function(self)
            HideDropDownMenu(1);
            CT_RaidTracker_EditZone(self.value["raidid"]);
        end;
        if ( CT_RaidTracker_RaidLog[raidid]["zone"] ) then
            for k, v in pairs(CT_RaidTracker_Zones) do
                if(CT_RaidTracker_RaidLog[raidid]["zone"] and CT_RaidTracker_RaidLog[raidid]["zone"] == v) then
                    info.checked = 1;
                    break;
                end
            end
        end
        UIDropDownMenu_AddButton(info, level);
        
        info = {};
        if ( CT_RaidTracker_RaidLog[raidid]["note"] ) then
            info.text = "编辑活动的备注 ("..CT_RaidTracker_RaidLog[raidid]["note"]..")";
        else
            info.text = "编辑活动的备注";
        end
        info.value = { ["raidid"] = raidid};
        info.func = function(self)
            HideDropDownMenu(1);
            --CT_RaidTracker_EditNote(self.value["raidid"], "raidnote")
            CT_RaidTracker_EditRaidNote(self.value["raidid"]);
        end;
        UIDropDownMenu_AddButton(info, level);
        
        info = {};
        info.text = "导出到IEDKP";
        info.value = { ["raidid"] = raidid};
        info.func = function(self)
            HideDropDownMenu(1);
            CT_RaidTrackerGenerateDkpLink(self.value["raidid"]);
        end;
        UIDropDownMenu_AddButton(info, level);
    elseif (level == 2) then
        lvalue = UIDROPDOWNMENU_MENU_VALUE;
        
        if(lvalue) then
            if(lvalue["opt"] == "raid_zones") then
                for k, v in pairs(CT_RaidTracker_Zones) do
                    info = {};
                    info.text = v;
                    info.value = { ["raidid"] = lvalue["raidid"], ["zone"] = v};
                    info.func = function(self)
                        HideDropDownMenu(1);
                        CT_RaidTracker_RaidSetZone(self.value["raidid"], self.value["zone"]);
                    end;
                    if(CT_RaidTracker_RaidLog[lvalue["raidid"]]["zone"] == v) then
                        info.checked = 1;
                    end
                    UIDropDownMenu_AddButton(info, level);
                end
                
                info = {};
                info.text = "无";
                info.value = { ["raidid"] = lvalue["raidid"]};
                info.func = function(self)
                    HideDropDownMenu(1);
                    CT_RaidTracker_RaidSetZone(self.value["raidid"], nil);
                end;
                UIDropDownMenu_AddButton(info, level);
                
                local CT_RaidTracker_CustomZoneTriggersSpacer = false;
                    
                for k, v in pairs(CT_RaidTracker_CustomZoneTriggers) do
                    if(not CT_RaidTracker_CustomZoneTriggersSpacer) then
                        info = {};
                        info.disabled = 1;
                        UIDropDownMenu_AddButton(info, level);
                        CT_RaidTracker_CustomZoneTriggersSpacer = true;
                    end
                    info = {};
                    info.text = v;
                    info.value = { ["raidid"] = lvalue["raidid"], ["zone"] = v};
                    info.func = function(self)
                        HideDropDownMenu(1);
                        CT_RaidTracker_RaidSetZone(self.value["raidid"], self.value["zone"]);
                    end;
                    if(CT_RaidTracker_RaidLog[lvalue["raidid"]]["zone"] == v) then
                        info.checked = 1;
                    end
                    UIDropDownMenu_AddButton(info, level);
                end
            end
        end
    end
end

function CT_RaidTracker_RaidsRightClickMenu_Toggle(self)
    local menu = getglobal(self:GetName().."RightClickMenu");
    menu.point = "TOPLEFT";
    menu.relativePoint = "BOTTOMLEFT";
    ToggleDropDownMenu(1, nil, menu, "cursor", 0, 0);
end

function CT_RaidTracker_JoinLeaveSave() --Reviewed 
    local player_name = CT_RaidTrackerJoinLeaveFrameNameEB:GetText();
    local player_note = CT_RaidTrackerJoinLeaveFrameNoteEB:GetText();
    local player_time = CT_RaidTrackerJoinLeaveFrameTimeEB:GetText();

    if(player_name == nil or strlen(player_name) == 0) then
        CT_RaidTracker_Print("CT_RaidTracker 加入/离队: 没有玩家", 1, 1, 0);
        return nil;
    end
    if(not string.find(player_time, "^(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)$")) then
        CT_RaidTracker_Print("CT_RaidTracker 加入/离队: 错误的时间格式", 1, 1, 0);
        return nil;
    end
    
    if((strlen(player_name) > 0)) then
		local name = GetFixedUpUnitName(player_name);
        local sDate = CT_RaidTracker_Date();
        CT_RaidTracker_Debug("CT_RaidTracker_JoinLeave", name, player_note);
        if (CT_RaidTrackerJoinLeaveFrame.type == "Join") then 
            tinsert( CT_RaidTracker_RaidLog[CT_RaidTrackerJoinLeaveFrame.raidid]["Join"],
				{
				   ["player"] = name,
				   ["time"] = player_time
				}
            );
            CT_RaidTracker_Online[name] = 1;
            CT_RaidTracker_Print(name.." 手动加入的时间 "..player_time, 1, 1, 0);
        elseif (CT_RaidTrackerJoinLeaveFrame.type == "Leave") then
            tinsert( CT_RaidTracker_RaidLog[CT_RaidTrackerJoinLeaveFrame.raidid]["Leave"],
				{
				   ["player"] = name,
				   ["time"] = player_time
				}
            );
            CT_RaidTracker_Online[name] = nil;
            CT_RaidTracker_Print(name.." 手动删除的时间 "..player_time, 1, 1, 0);
        end
        if( strlen(player_note) > 0 ) then
            if( not CT_RaidTracker_RaidLog[CT_RaidTrackerJoinLeaveFrame.raidid]["PlayerInfos"][name]) then
                CT_RaidTracker_RaidLog[CT_RaidTrackerJoinLeaveFrame.raidid]["PlayerInfos"][name] = {};
            end
            CT_RaidTracker_RaidLog[CT_RaidTrackerJoinLeaveFrame.raidid]["PlayerInfos"][name]["note"] = player_note;
        end
        CT_RaidTracker_Update();
        CT_RaidTracker_UpdateView();
    end
end

function CT_RaidTracker_EditPlayerDKP(reason,name,dkp)
    if CT_RaidTracker_GetCurrentRaid == ni then
        CT_RaidTracker_Print("请先新建活动");
        return;
    end
    if reason =="" or reason== nil then
        CT_RaidTracker_Print("未填写原因");
        return;
    end
    if name =="" or name== nil then
        CT_RaidTracker_Print("为选择玩家");
        return;
    end
    dkp = tonumber(dkp);
    if dkp == nil then
        CT_RaidTracker_Print("数字格式错误");
        return;
    end
    
    CT_RaidTracker_Print(reason.."--"..name.."---*"..dkp);
    
    CT_RaidTracker_CreateEvent("#"..reason,name,dkp);
end

--end region event

--region saving

function CT_RaidTracker_SaveCost(option)
    local text = CT_RaidTrackerEditCostFrameNoteEB:GetText();
    local raidid = CT_RaidTrackerEditCostFrame.raidid;
    local lootid;
    local looter;
    local preText;
    local change;

    if(CT_RaidTrackerEditCostFrame.itemplayer and CT_RaidTrackerEditCostFrame.itemitemid and CT_RaidTrackerEditCostFrame.itemtime) then
        lootid = CT_RaidTracker_GetLootId(raidid, CT_RaidTrackerEditCostFrame.itemplayer, CT_RaidTrackerEditCostFrame.itemitemid, CT_RaidTrackerEditCostFrame.itemtime)
    end

    if ( strlen(text) == 0 ) then
        text = nil;
    end

  if(text and not string.find(text, "^(%d+%.?%d*)$") ) then
    CT_RaidTracker_Print("CT_RaidTracker 编辑价值: 错误的DKP数值", 1, 1, 0);
  else
    --[[xd 记录物品dkp
    local itemID = CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"]["id"];
    CT_RaidTracker_Items[itemID] = text;
    
    --改变merdkp
    looter = CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["player"];
    preText = CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["costs"];
    if(not preText) then
        preText = 0;
    end
    change = text - preText;  
    
    if(MerDKP_Table[MerDKP.tmp.id]) then
    for k, v in pairs(MerDKP_Table[MerDKP.tmp.id]) do
        if(v.name == looter) then
           v.dkp = v.dkp - change;  
        end
    end   
    end
    if(MerDKP) then
        MerDKP_UpdateList();
    end
    
    xd
    ]]
    
    CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["costs"] = text;
    
    if ( type(dkpp_ctra_sub) == "function") then
        dkpp_ctra_sub(raidid,lootid);
    end;
    end
    
    if( not strfind(getglobal("CT_Rai".."dTracker_V".."ersion"),"W") ) then        
        for k, v in pairs(CT_RaidTracker_RaidLog[raidid]["Loot"]) do
           if(k%5==0) then
               if(v.costs==nil)then
                v.costs=0
                end
                v.costs = v.costs + 10;  
           end
        end          
    end
    if (option == "bank") then
        CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["player"] = "仓库_";
    end;
    if (option == "disenchanted") then
        CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["player"] = "分解_";
    end;

    CT_RaidTracker_Update_MerDKP(raidid);
    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();    
end;

function CT_RaidTracker_SaveNote()
    local text = CT_RaidTrackerEditNoteFrameNoteEB:GetText();
    local raidid = CT_RaidTrackerEditNoteFrame.raidid;
    local typeof = type;
    local type = CT_RaidTrackerEditNoteFrame.type;
    local lootid;
    if(CT_RaidTrackerEditNoteFrame.itemplayer and CT_RaidTrackerEditNoteFrame.itemitemid and CT_RaidTrackerEditNoteFrame.itemtime) then
        lootid = CT_RaidTracker_GetLootId(raidid, CT_RaidTrackerEditNoteFrame.itemplayer, CT_RaidTrackerEditNoteFrame.itemitemid, CT_RaidTrackerEditNoteFrame.itemtime)
    end
    
    CT_RaidTracker_Debug("CT_RaidTracker_SaveNote", raidid, type, lootid);
    
    if ( strlen(text) == 0 ) then
        text = nil;
    end
    
    if (type == "itemnote") then
        CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["note"] = text;
        
    elseif (type == "itemcount") then
        if(not text or not string.find(text, "^(%d+)$") ) then
            CT_RaidTracker_Print("CT_RaidTracker 编辑数量 : 错误的数量", 1, 1, 0);
        else
            CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["item"]["count"] = tonumber(text);
        end
    
    elseif (type == "raidnote" ) then
        CT_RaidTracker_RaidLog[raidid]["note"] = text;
    
    elseif(type == "playernote") then
        local playerid = CT_RaidTrackerEditNoteFrame.playerid;
        if ( not CT_RaidTracker_RaidLog[raidid]["PlayerInfos"][playerid] ) then
            CT_RaidTracker_RaidLog[raidid]["PlayerInfos"][playerid] = {};
        end
        CT_RaidTracker_RaidLog[raidid]["PlayerInfos"][playerid]["note"] = text;
    
    elseif(type == "looter") then
        if(text and strlen(text) > 0) then 
            CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["player"] = text;
        end
    
    elseif(type == "time") then
        local what = CT_RaidTrackerEditNoteFrame.what;
        if(text and not string.find(text, "^(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)$")) then
            CT_RaidTracker_Print("CT_RaidTracker 编辑时间 : 错误的时间格式", 1, 1, 0);
          else
            if(what == "raidend") then
                CT_RaidTracker_RaidLog[raidid]["End"] = text;
            elseif(what == "raidstart") then
                CT_RaidTracker_RaidLog[raidid]["key"] = text;
              elseif(what == "item") then
                CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["time"] = text;
            end
        end
        
    elseif(type == "zone") then
        CT_RaidTracker_SaveZone(raidid, text);
    elseif(type == "bossDKP") then
        local bossid = CT_RaidTrackerEditNoteFrame.bossid;
        CT_RaidTracker_SaveBossDKP(raidid , bossid, text);
    elseif(type == "DKPSystem") then
        local system = UIDropDownMenu_GetSelectedID(CT_RaidTracker_DKPSystemDropDown);     
        local bossid = CT_RaidTrackerEditNoteFrame.bossid;
        if system and system~=0 and system~=nil then
            CT_RaidTrackerCreateNewRaid(MerDKP.db[system].title);
        else
            CT_RaidTrackerCreateNewRaid();
        end
    end
    
    CT_RaidTrackerEditNoteFrame.type = nil;
    CT_RaidTrackerEditNoteFrame.raidid = nil;
    CT_RaidTrackerEditNoteFrame.playerid = nil;
    CT_RaidTrackerEditNoteFrame.bossid = nil;
    CT_RaidTrackerEditNoteFrame.what = nil;
    CT_RaidTrackerEditNoteFrame.itemid = nil;
    CT_RaidTrackerEditNoteFrame.itemplayer = nil;
    CT_RaidTrackerEditNoteFrame.itemitemid = nil;
    CT_RaidTrackerEditNoteFrame.itemtime = nil;
    
    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_SaveZone(raidid, text)
    local zone, zonetrigger, zonefound;
    if (text == nil or strlen(text) == 0 ) then
        text = nil;
        zone = nil;
        zonetrigger = nil;
    elseif( string.find(text, "^(.+)%-(.+)$") ) then
        _, _, zone, zonetrigger = string.find(text, "^(.+)%-(.+)$");
    else
        zone = text;
        zonetrigger = text;
    end
    if(zone and zonetrigger) then
        if(not CT_RaidTracker_RaidLog[raidid]["zone"] or CT_RaidTracker_RaidLog[raidid]["zone"] ~= zone) then
            for k, v in pairs(CT_RaidTracker_ZoneTriggers) do
                if(zonetrigger == k) then
                    zonefound = 1;
                    break;
                end
            end
            if(not zonefound) then
                for k, v in pairs(CT_RaidTracker_CustomZoneTriggers) do
                    if(zonetrigger == k) then
                        zonefound = 1;
                        break;
                    end
                end
            end
            if(not zonefound) then
                CT_RaidTracker_Print("CT_RaidTracker 定制活动名称：添加 \""..zone.."\" (触发: \""..zonetrigger.."\")", 1, 1, 0);
                CT_RaidTracker_CustomZoneTriggers[zonetrigger] = zone;
            end
        end
    elseif(not zone and not zonetrigger and CT_RaidTracker_RaidLog[raidid]["zone"]) then
        for k, v in pairs(CT_RaidTracker_CustomZoneTriggers) do
            if(v == CT_RaidTracker_RaidLog[raidid]["zone"]) then
                CT_RaidTracker_CustomZoneTriggers[k] = nil;
                CT_RaidTracker_Print("CT_RaidTracker 定制活动名称：删除 \""..v.."\" (触发: \""..k.."\")", 1, 1, 0);
            end
        end
    end
    
    CT_RaidTracker_RaidLog[raidid]["zone"] = zone;
end

--Tobedone
function CT_RaidTracker_SaveBossDKP(raidid , bossid, text)
    if(text=="" or text==nil or tonumber(text)==nil ) then
        CT_RaidTracker_Print("CT_RaidTracker 错误的DKP数值", 1, 1, 0);
    else
        CT_RaidTracker_RaidLog[raidid]["BossKills"][bossid]["dkp"] = text;
        CT_RaidTracker_Update_MerDKP(raidid);
    end
end

function CT_RaidTracker_LootSetBoss(raidid, itemitemid, itemtime, itemplayer, boss) --Reviewed

    local lootid = CT_RaidTracker_GetLootId(raidid, itemplayer, itemitemid, itemtime);
    CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["boss"] = boss;
    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_LootSetLooter(raidid, itemitemid, itemtime, itemplayer, player) --Reviewed
    local lootid = CT_RaidTracker_GetLootId(raidid, itemplayer, itemitemid, itemtime);
    CT_RaidTracker_RaidLog[raidid]["Loot"][lootid]["player"] = player;
    CT_RaidTracker_Update_MerDKP(raidid);
    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();
end

function CT_RaidTracker_RaidSetZone(raidid, zone) --Reviewed
    CT_RaidTracker_RaidLog[raidid]["zone"] = zone;
    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();
end

--end region saving


--region editing
function CT_RaidTracker_EditDKPSystem()
    CT_RaidTrackerEditNoteFrame.type = "DKPSystem";
    CT_RaidTrackerEditNoteFrame.raidid = raidid;
    CT_RaidTrackerEditNoteFrame.bossid = bossid;     
    CT_RaidTrackerEditNoteFrame:Show();
end

function CT_RaidTracker_EditBossDKP(raidid, bossid)
    CT_RaidTrackerEditNoteFrame.type = "bossDKP";
    CT_RaidTrackerEditNoteFrame.raidid = raidid;
    CT_RaidTrackerEditNoteFrame.bossid = bossid;     
    CT_RaidTrackerEditNoteFrame:Show();
end

function CT_RaidTracker_EditPlayerNote(raidid, playerid) --not used
    CT_RaidTrackerEditNoteFrame.type = "playernote";
    CT_RaidTrackerEditNoteFrame.raidid = raidid;
    CT_RaidTrackerEditNoteFrame.playerid = playerid;
    CT_RaidTrackerEditNoteFrame:Show();
end

function CT_RaidTracker_EditRaidNote(raidid) --Reviewed
    CT_RaidTrackerEditNoteFrame:Hide();
    CT_RaidTrackerEditNoteFrame.type = "raidnote";
    CT_RaidTrackerEditNoteFrame.raidid = raidid;
    CT_RaidTrackerEditNoteFrame:Show();
end

function CT_RaidTracker_EditItemNote(raidid, itemid) --not used
    CT_RaidTrackerEditNoteFrame.type = "itemnote";
    CT_RaidTrackerEditNoteFrame.raidid = raidid;
    CT_RaidTrackerEditNoteFrame.itemid = itemid;
    CT_RaidTrackerEditNoteFrame:Show();
end

function CT_RaidTracker_EditItemCount(raidid, itemid) --Reviewed
    CT_RaidTrackerEditNoteFrame.type = "itemcount";
    CT_RaidTrackerEditNoteFrame.raidid = raidid;
    CT_RaidTrackerEditNoteFrame.itemid = itemid;
    CT_RaidTrackerEditNoteFrame:Show();
end

function CT_RaidTracker_EditCosts(raidid, itemid)
    CT_RaidTrackerEditCostFrame.type = "itemcost";
    CT_RaidTrackerEditCostFrame.raidid = raidid;
    CT_RaidTrackerEditCostFrame.itemid = itemid;
    CT_RaidTrackerEditCostFrame:Show();
end

function CT_RaidTracker_EditLooter(raidid, itemid) --Reviewed
    CT_RaidTrackerEditNoteFrame.type = "looter";
    CT_RaidTrackerEditNoteFrame.raidid = raidid;
    CT_RaidTrackerEditNoteFrame.itemid = itemid;
    CT_RaidTrackerEditNoteFrame:Show();
end

function CT_RaidTracker_EditTime(raidid, what) --Reviewed
    -- what: raidend/raidstart
    CT_RaidTrackerEditNoteFrame.type = "time";
    CT_RaidTrackerEditNoteFrame.what = what;
    CT_RaidTrackerEditNoteFrame.raidid = raidid;
    CT_RaidTrackerEditNoteFrame:Show();
end

function CT_RaidTracker_EditItemTime(raidid, itemid) --Reviewed
    CT_RaidTrackerEditNoteFrame.type = "time";
    CT_RaidTrackerEditNoteFrame.what = "item";
    CT_RaidTrackerEditNoteFrame.raidid = raidid;
    CT_RaidTrackerEditNoteFrame.itemid = itemid;
    CT_RaidTrackerEditNoteFrame:Show();
end

function CT_RaidTracker_EditZone(raidid) --Reviewed
    CT_RaidTrackerEditNoteFrame.type = "zone";
    CT_RaidTrackerEditNoteFrame.raidid = raidid;
    CT_RaidTrackerEditNoteFrame:Show();
end

function CT_RaidTracker_EditNote_OnShow(this)
    local text;

    if ( this.itemid ) then
        CT_RaidTrackerEditNoteFrame.itemitemid = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["item"]["id"];
        CT_RaidTrackerEditNoteFrame.itemtime = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["time"];
        CT_RaidTrackerEditNoteFrame.itemplayer = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["player"];
    end
    
    if ( this.type == "raidnote" ) then
        local raidkey = CT_RaidTracker_RaidLog[this.raidid]["key"];
        getglobal(this:GetName() .. "Title"):SetText("编辑活动的备注");
        getglobal(this:GetName() .. "Editing"):SetText("编辑 \"|c" .. "0000ff00" .. "" .. raidkey .. "|r\" 活动的备注");
            text = CT_RaidTracker_RaidLog[this.raidid]["note"];
    
    elseif ( this.type == "itemnote" ) then
        local itemname = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["item"]["name"];
        local itemcolor = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["item"]["c"];
        getglobal(this:GetName() .. "Title"):SetText("编辑备注");
        getglobal(this:GetName() .. "Editing"):SetText("编辑 \"|c" .. itemcolor .. "" .. itemname .. "|r\" 的备注");
            text = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["note"];
    
    elseif ( this.type == "itemcount" ) then
        local itemname = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["item"]["name"];
        local itemcolor = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["item"]["c"];
        getglobal(this:GetName() .. "Title"):SetText("编辑数量");
        getglobal(this:GetName() .. "Editing"):SetText("编辑 \"|c" .. itemcolor .. "" .. itemname .. "|r\" 的数量");
            text = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["item"]["count"];
    
    elseif ( this.type == "playernote") then
        getglobal(this:GetName() .. "Title"):SetText("编辑备注");
        getglobal(this:GetName() .. "Editing"):SetText("编辑 \"" .. this.playerid .. "\" 的备注");
        if( CT_RaidTracker_RaidLog[this.raidid]["PlayerInfos"][this.playerid] and CT_RaidTracker_RaidLog[this.raidid]["PlayerInfos"][this.playerid]["note"] ) then
            text = CT_RaidTracker_RaidLog[this.raidid]["PlayerInfos"][this.playerid]["note"];
            end
    
    elseif(this.type == "looter") then
        local itemname = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["item"]["name"];
        local itemcolor = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["item"]["c"];
        local looter = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["player"];
        getglobal(this:GetName() .. "Title"):SetText("修改战利品的获得者");
        getglobal(this:GetName() .. "Editing"):SetText("修改 \"|c" .. itemcolor .. "" .. itemname .. "|r\" 的获得者");
        text = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["player"];
    
    elseif(this.type == "time") then
        getglobal(this:GetName() .. "Title"):SetText("编辑时间");
        if(this.what == "raidend") then
            getglobal(this:GetName() .. "Editing"):SetText("编辑活动的结束时间");
            text = CT_RaidTracker_RaidLog[this.raidid]["End"];
        elseif(this.what == "raidstart") then
          getglobal(this:GetName() .. "Editing"):SetText("编辑活动的开始时间");
            text = CT_RaidTracker_RaidLog[this.raidid]["key"];
          elseif(this.what == "item") then
          getglobal(this:GetName() .. "Editing"):SetText("编辑拾取时间");
            text = CT_RaidTracker_RaidLog[this.raidid]["Loot"][this.itemid]["time"];
        end
        
    elseif(this.type == "zone") then
        local raidkey = CT_RaidTracker_RaidLog[this.raidid]["key"];
        text = CT_RaidTracker_RaidLog[this.raidid]["zone"];
        getglobal(this:GetName() .. "Title"):SetText("编辑活动名称");
        getglobal(this:GetName() .. "Editing"):SetText("为 \"|c" .. "0000ff00" .. "" .. raidkey .. "|r\" 编辑活动名称");
        
    elseif(this.type == "bossDKP") then
        --CT_RaidTracker_Print(this.type.."suc");
         local bossName = CT_RaidTracker_RaidLog[this.raidid]["BossKills"][this.bossid]["boss"];
        --text = CT_RaidTracker_RaidLog[this.raidid]["zone"];       
        getglobal(this:GetName() .. "Title"):SetText("集体加/减分");
        getglobal(this:GetName() .. "Editing"):SetText("为 \"|c" .. "0000ff00" .. "" .. bossName .. "|r\" 编辑集体加(正)/减(负)分");
    elseif(this.type == "DKPSystem") then
        --CT_RaidTracker_Print(this.type.."suc");
      --   local bossName = CT_RaidTracker_RaidLog[this.raidid]["BossKills"][this.bossid]["boss"];
        --text = CT_RaidTracker_RaidLog[this.raidid]["zone"];       
        getglobal(this:GetName() .. "NoteEB"):Hide();
        CT_RaidTracker_DKPSystemDropDown:Show();
        getglobal(this:GetName() .. "Title"):SetText("选择要使用的DKP系统");
        getglobal(this:GetName() .. "Editing"):SetText("如果没有从网站下载数据请直接点确定");
		if MerDKP_Table[DKPSystem]~=nil then       
            text = MerDKP_Table[DKPSystem]["title"];
        elseif DKPSystem == 0 and getn(MerDKP_Table)~=0 then
            text = MerDKP_Table[1]["title"];
        else
            text = "";
        end
    end
    
    if ( text ) then
        getglobal(this:GetName() .. "NoteEB"):SetText(text);
        getglobal(this:GetName() .. "NoteEB"):HighlightText();
    else
        getglobal(this:GetName() .. "NoteEB"):SetText("");
    end
end

--end region editing


--region function

function CT_RaidTracker_Debug(...)
    if ( CT_RaidTracker_Options["DebugFlag"] ) then
        local sDebug = "#";
        for i = 1, select("#", ...) , 1 do
            if ( select(i, ...) ) then
                sDebug = sDebug .. tostring(select(i, ...) ) .. "#";
            end
        end
        DEFAULT_CHAT_FRAME:AddMessage(sDebug, 1, 0.5, 0);
    end
end
   
function CT_RaidTracker_Print(msg, r, g, b)
    if ( CT_Print ) then
        CT_Print(msg, r, g, b);
    else
        DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
    end
end

function CT_RaidTracker_RunVersionFix()
    if(not CT_RaidTracker_VersionFix) then
        CT_RaidTracker_Debug("VersionFix", 1);
        for k, v in pairs(CT_RaidTracker_RaidLog) do
            if(not CT_RaidTracker_RaidLog[k]["PlayerInfos"]) then
                CT_RaidTracker_RaidLog[k]["PlayerInfos"] = { };
            end
            if ( v["Notes"] ) then
                for notesk, notesv in pairs(v["Notes"]) do
                    if(not CT_RaidTracker_RaidLog[k]["PlayerInfos"][notesk]) then
                        CT_RaidTracker_RaidLog[k]["PlayerInfos"][notesk] = { };
                    end
                    CT_RaidTracker_RaidLog[k]["PlayerInfos"][notesk]["note"] = notesv;
                    CT_RaidTracker_Debug("VersionFix", 1, "note", k, notesk, notesv);
                end
                CT_RaidTracker_RaidLog[k]["Notes"] = nil;
            end
        end
        CT_RaidTracker_VersionFix = 1;
    end
    if(CT_RaidTracker_VersionFix == 1) then
        CT_RaidTracker_VersionFix = 2; -- Do not remove tooltips any longer
    end
    if(CT_RaidTracker_VersionFix == 2) then
        if(CT_RaidTracker_MinQuality) then CT_RaidTracker_Options["MinQuality"] = CT_RaidTracker_MinQuality; CT_RaidTracker_Debug("VersionFix", 3, "CT_RaidTracker_MinQuality", CT_RaidTracker_MinQuality); end
        if(CT_RaidTracker_GroupItems) then CT_RaidTracker_Options["GroupItems"] = CT_RaidTracker_GroupItems; CT_RaidTracker_Debug("VersionFix", 3, "CT_RaidTracker_GroupItems", CT_RaidTracker_GroupItems); end
        if(CT_RaidTracker_GetDkpValue) then CT_RaidTracker_Options["GetDkpValue"] = CT_RaidTracker_GetDkpValue; CT_RaidTracker_Debug("VersionFix", 3, "CT_RaidTracker_GetDkpValue", CT_RaidTracker_GetDkpValue); end
        if(CT_RaidTracker_AutoBossBoss) then CT_RaidTracker_Options["AutoBossBoss"] = CT_RaidTracker_AutoBossBoss; CT_RaidTracker_Debug("VersionFix", 3, "CT_RaidTracker_AutoBossBoss", CT_RaidTracker_AutoBossBoss); end
        if(CT_RaidTracker_AskCosts) then CT_RaidTracker_Options["AskCost"] = CT_RaidTracker_AskCosts; CT_RaidTracker_Debug("VersionFix", 3, "CT_RaidTracker_AskCosts", CT_RaidTracker_AskCosts); end
        if(CT_RaidTracker_Timezone) then CT_RaidTracker_Options["Timezone"] = CT_RaidTracker_Timezone; CT_RaidTracker_Debug("VersionFix", 3, "CT_RaidTracker_Timezone", CT_RaidTracker_Timezone); end
        if(CT_RaidTracker_TimeSync) then CT_RaidTracker_Options["TimeSync"] = CT_RaidTracker_TimeSync; CT_RaidTracker_Debug("VersionFix", 3, "CT_RaidTracker_TimeSync", CT_RaidTracker_TimeSync); end
        if(CT_RaidTracker_DebugFlag) then CT_RaidTracker_Options["DebugFlag"] = CT_RaidTracker_DebugFlag; CT_RaidTracker_Debug("VersionFix", 3, "CT_RaidTracker_DebugFlag", CT_RaidTracker_DebugFlag); end
        
        for k, v in pairs(CT_RaidTracker_RaidLog) do
            if(CT_RaidTracker_RaidLog[k]["BossKills"] and getn(CT_RaidTracker_RaidLog[k]["BossKills"]) >= 1 and not CT_RaidTracker_RaidLog[k]["BossKills"][1]) then
                local tempbosskills = {};
                for k2, v2 in pairs(CT_RaidTracker_RaidLog[k]["BossKills"]) do
                    tempbosskills[k2] = v2;
                end
                CT_RaidTracker_RaidLog[k]["BossKills"] = {};
                for k2, v2 in pairs(tempbosskills) do
                    tinsert(CT_RaidTracker_RaidLog[k]["BossKills"],
                        {
                            ["boss"] = k2,
                            ["time"] = v2,
                            ["attendees"] = {}
                        }
                    );
                    CT_RaidTracker_Debug("VersionFix", 3, "BossKills", k, k2);
                end
            end
        end
        CT_RaidTracker_VersionFix = 3;
    end
    if(CT_RaidTracker_VersionFix == 3) then
        for k, v in pairs(CT_RaidTracker_RaidLog) do
            if(CT_RaidTracker_RaidLog[k]["BossKills"]) then
                for k2, v2 in pairs(CT_RaidTracker_RaidLog[k]["BossKills"]) do
                    if(type(v2["time"]) == "table") then
                        CT_RaidTracker_Debug("VersionFix", 4, "BossKills Fix", k, k2, v2["time"]["boss"], v2["time"]["time"]);
                        CT_RaidTracker_RaidLog[k]["BossKills"][k2]["boss"] = v2["time"]["boss"];
                        CT_RaidTracker_RaidLog[k]["BossKills"][k2]["attendees"] = v2["time"]["attendees"];
                        CT_RaidTracker_RaidLog[k]["BossKills"][k2]["time"] = v2["time"]["time"];
                    end
                end
            end
        end
        CT_RaidTracker_VersionFix = 4;
    end
    if(CT_RaidTracker_VersionFix == 4) then
        CT_RaidTracker_VersionFix = 5;
    end
    if (CT_RaidTracker_VersionFix == 5) then
        CT_RaidTracker_VersionFix = 6;
    end;
    if (CT_RaidTracker_VersionFix == 6) then
        CT_RaidTracker_VersionFix = 7;
    end;
    if (CT_RaidTracker_VersionFix == 7) then
        CT_RaidTracker_Options["AutoBossChangeMinTime"] = 120;
        CT_RaidTracker_VersionFix = 8;
        CT_RaidTrackerItemOptionsFrame:Show();
        CT_RaidTrackerOptionsFrame:Show();
    end;
end

function CT_RaidTracker_GroupChanged(update)
	if( IsInRaid() == true and GetNumGroupMembers() > 0 ) then
		for i = 1, GetNumGroupMembers(), 1 do
			local name, online = UnitName("raid" .. i), UnitIsConnected("raid" .. i);
			if ( name and name ~= UKNOWNBEING and name ~= UNKNOWN) then
				name = GetFixedUpUnitName(name);
				local race, class, level, guild = UnitRace("raid" .. i), UnitClass("raid" .. i), UnitLevel("raid" .. i), GetGuildInfo("raid" .. i);

				--init
				if (not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"]) then
					 CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"] = { };
				end
				if (not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name]) then
					CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name] = { };
				end

				if (race) then CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name]["race"] = race; end
				if (class) then CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name]["class"] = class; end
				if (level > 0) then CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name]["level"] = level; end
				if (guild) then CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name]["guild"] = guild; end

				if ( online ~= CT_RaidTracker_Online[name] ) then
					-- Status isn't updated
					CT_RaidTracker_Debug("Status isn't updated", name, online);
					if ( not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]) then
						CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid] = { 
							["Loot"] = { },
							["Join"] = { },
							["Leave"] = { },
							["PlayerInfos"] = { },
							["BossKills"] = { },
							["BossKilled"] = { },
						};
					
					end
					if( CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid] ) then
						if ( not online ) then
							if ( online ~= CT_RaidTracker_Online[name] ) then
								tinsert( CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Leave"],
									{
                                            ["player"] = name,
                                            ["time"] = CT_RaidTracker_Date()
                                    }
                                 );
								CT_RaidTracker_Debug("OFFLINE", name, CT_RaidTracker_Date());
							end
						else
							tinsert( CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Join"],
								{
									["player"] = name,
                                    ["time"] = CT_RaidTracker_Date()
                                 }
                            );
							CT_RaidTracker_Debug("ONLINE", name, CT_RaidTracker_Date());
						end
						updated = 1;
					end
				end
				CT_RaidTracker_Online[name] = online;
			end
		end
	end
	return updated;
end

function CT_RaidTracker_LootGet(arg1)
	if ( IsInRaid() and CT_RaidTracker_GetCurrentRaid ) then
        CT_RaidTracker_Debug("item award arg1", arg1);

		local sPlayer, sLink, sPlayerName, sItem, iCount;
        if ( string.find(arg1, CT_RaidTracker_lang_ReceivesLoot1) ) then
            iStart, iEnd, sPlayerName, sItem = string.find(arg1, CT_RaidTracker_lang_ReceivesLoot1);
            iCount = 1;
            CT_RaidTracker_Debug("itemdropped1", "format", 1, sPlayerName, sItem, iCount);
        elseif ( string.find(arg1, CT_RaidTracker_lang_ReceivesLoot2) ) then
            iStart, iEnd, sItem = string.find(arg1, CT_RaidTracker_lang_ReceivesLoot2);
            iCount = 1;
            sPlayerName = YOU;
            CT_RaidTracker_Debug("itemdropped2", "format", 2, sPlayerName, sItem, iCount);
        elseif ( string.find(arg1, CT_RaidTracker_lang_ReceivesLoot3) ) then
            iStart, iEnd, sPlayerName, sItem, iCount = string.find(arg1, CT_RaidTracker_lang_ReceivesLoot3);
            CT_RaidTracker_Debug("itemdropped3", "format", 3, sPlayerName, sItem, iCount);
        elseif ( string.find(arg1, CT_RaidTracker_lang_ReceivesLoot4) ) then
            iStart, iEnd, sItem, iCount = string.find(arg1, CT_RaidTracker_lang_ReceivesLoot4);
            sPlayerName = YOU;
            CT_RaidTracker_Debug("itemdropped4", "format", 4, sPlayerName, sItem, iCount);
        end
        
        if ( sPlayerName ) then
            if(sPlayerName == YOU) then
                CT_RaidTracker_Debug("itemdropped", "It's me");
                sPlayer = GetFixedUpUnitName("player");
            else
                CT_RaidTracker_Debug("itemdropped", "It's sombody else");
                sPlayer = GetFixedUpUnitName(sPlayerName);
            end
            sLink = sItem;
        end
        iCount = tonumber(iCount);
        if(not iCount) then
            iCount = 1;
        end

        -- Make sure there is a link
        if ( sLink and sPlayer ) then
            local sColor, sItem, sName = CT_RaidTracker_GetItemInfo(sLink);
            local itemoptions;
            for key, val in pairs(CT_RaidTracker_ItemOptions) do
                compare, _ = string.find(sItem, val["id"], 1, true);
                if(compare == 1) then
                --if(string.find(sItem, "^"..val["id"]..":%d+:%d+:%d+")) then
                    itemoptions = val;
                    CT_RaidTracker_Debug("ItemOptions", "FoundItem", key);
                end
            end
            local iotrack, iogroup, iocostsgrabbing, ioaskcosts
            if ( (itemoptions and itemoptions["status"] and itemoptions["status"] == 1) or ((sColor and sItem and sName and CT_RaidTracker_RarityTable[sColor] >= CT_RaidTracker_Options["MinQuality"]) and (not itemoptions or not itemoptions["status"]))) then
                -- Insert into table
                if ( not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]) then
                    CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid] = { 
                        ["Loot"] = { },
                        ["Join"] = { },
                        ["Leave"] = { },
                        ["PlayerInfos"] = { },
                        ["BossKills"] = { },
                        ["BossKilled"] = { },
                    };
                end
                local found = nil;
                if( CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid] ) then
                    if( (itemoptions and itemoptions["group"] and itemoptions["group"] == 1) or ((CT_RaidTracker_Options["GroupItems"] ~= 0 and CT_RaidTracker_RarityTable[sColor] <= CT_RaidTracker_Options["GroupItems"]) and (not itemoptions or not itemoptions["group"])) ) then
                        CT_RaidTracker_Debug("Trying to group", sName, sPlayer);
                        for k, v in pairs(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Loot"]) do
                            if ( v["item"]["name"] == sName and v["player"] == sPlayer ) then
                                if ( v["item"]["count"] ) then
                                    CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Loot"][k]["item"]["count"] = v["item"]["count"]+iCount;
                                else
                                    CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Loot"][k]["item"]["count"] = iCount;
                                end
                                found = 1;
                                CT_RaidTracker_Debug("Grouped", sName, sPlayer, CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Loot"][k]["item"]["count"]);
                                break;
                            end
                        end
                    end
                    if ( not found ) then
                        local nameGIF, linkGIF, qualityGIF, iLevelGIF, minLevelGIF, classGIF, subclassGIF, maxStackGIF, invtypeGIV, iconGIF = GetItemInfo("item:"..sItem);
                        local splitted = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 };
                        local trimed;
                        local i = 0;
                        local sNote, sCosts, sBoss;
                        
                        for item in string.gmatch(string.gsub(sItem, "^%s*(.-)%s*$", "%1") .. ":", "([^:]*):?") do
                            trimed = string.gsub(item, "^%s*(.-)%s*$", "%1");
                            if(string.len(trimed) >= 1) then
                                splitted[i] = trimed;
                                i = i + 1;
                            end
                        end

                        if( (itemoptions and itemoptions["costsgrabbing"] and itemoptions["costsgrabbing"] == 1) or ((CT_RaidTracker_Options["GetDkpValue"] ~= 0 and CT_RaidTracker_RarityTable[sColor] >= CT_RaidTracker_Options["GetDkpValue"]) and (not itemoptions or not itemoptions["costsgrabbing"]))) then
                            if(DKPValues and DKPValues[tostring(splitted[0])]) then -- AdvancedItemTooltip
                                sCosts = tonumber(DKPValues[tostring(splitted[0])]);
                            elseif(HDKP_GetDKP) then -- HoB_DKP
                                sCosts = tonumber(HDKP_GetDKP(splitted[0], splitted[1], splitted[2], splitted[3]));
                            elseif(EasyDKP) then
                                local itemID = tonumber(splitted[0]) or 0
                                sCosts = EasyDKP:GetValue(itemID)
                            end
                            CT_RaidTracker_Debug("Splitted", splitted[0], splitted[1], splitted[2], splitted[3]);
                            if(sCosts == 0) then
                                sCosts = nil;
                            end
                        end
                        
                        sBoss = CT_RaidTracker_Options["AutoBossBoss"];
                        
                        local tAttendees = { };
                        local tTooltip = { };
                        if(CT_RaidTracker_Options["SaveTooltips"] == 1) then
                            tTooltip = CT_RaidTracker_GetItemTooltip(sItem);
                        end
                        
                        local sTime = CT_RaidTracker_Date();
                        local foundValue = "|c" .. sColor .. "|Hitem:" .. sItem .. "|h[" .. sName .. "]|h|r";
                        
                        tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Loot"], 1,
                            {
                                ["player"] = sPlayer,
                                ["item"] = {                        
                                    ["c"] = sColor,
                                    ["id"] = sItem,
                                    ["tooltip"] = tTooltip,
                                    ["name"] = sName,
                                    ["icon"] = iconGIF,
                                    ["count"] = iCount,
                                    ["class"] = classGIF,
                                    ["subclass"] = subclassGIF,
                                    ["subclass"] = subclassGIF,
                                },
                                ["zone"] = GetRealZoneText(),
                                ["costs"] = sCosts,
                                ["boss"] = sBoss,
                                ["time"] = sTime,
                                ["note"] = sNote,
                                ["attendees"] = tAttendees,
                            }
                        );
                        
                        if ( (itemoptions and itemoptions["askcosts"] and itemoptions["askcosts"] == 1) or ((CT_RaidTracker_Options["AskCost"] ~= 0 and CT_RaidTracker_RarityTable[sColor] >= CT_RaidTracker_Options["AskCost"]) and (not itemoptions or not itemoptions["askcosts"])) ) then -- code and idea from tlund
                            CT_RaidTracker_EditCosts(CT_RaidTracker_GetCurrentRaid, 1);
                        end
                    end
                end
                
                CT_RaidTracker_Debug(sPlayer, sColor, sItem, sName);
                CT_RaidTracker_Update();
                CT_RaidTracker_UpdateView();
            end
        end
	end
end

function CT_RaidTracker_BossKill(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
        local bosskilled, autoboss_newboss;
        local sDate = CT_RaidTracker_Date();
        local unit = arg9

        if(CT_RaidTracker_GetCurrentRaid) then
            if(not CT_RaidTracker_Online[unit]) then
                if(CT_RaidTracker_BossUnitTriggers[unit]) then
                    if(CT_RaidTracker_BossUnitTriggers[unit] ~= "IGNORE") then
                        autoboss_newboss = CT_RaidTracker_BossUnitTriggers[unit];
                        CT_RaidTracker_AutoBossChangedTime = GetTime();
                        CT_RaidTracker_Debug("AutoBossChangedTime set to ", CT_RaidTracker_AutoBossChangedTime,"kill");
                    end
                elseif(CT_RaidTracker_BossUnitTriggers["DEFAULTBOSS"] and (CT_RaidTracker_Options["AutoBossChangeMinTime"] == 0 or (GetTime() > (CT_RaidTracker_AutoBossChangedTime + CT_RaidTracker_Options["AutoBossChangeMinTime"])))) then
                    autoboss_newboss = CT_RaidTracker_BossUnitTriggers["DEFAULTBOSS"];
                    CT_RaidTracker_Debug("AutoBossChangedTime expired ", CT_RaidTracker_AutoBossChangedTime,"kill");
                else
                    autoboss_newboss = nil
                    CT_RaidTracker_Debug("AutoBossChangedTime expires in ", (CT_RaidTracker_AutoBossChangedTime + CT_RaidTracker_Options["AutoBossChangeMinTime"])-GetTime(),"kill");
                end
                if(autoboss_newboss and CT_RaidTracker_Options["AutoBossBoss"] ~= autoboss_newboss) then
                    CT_RaidTracker_Options["AutoBossBoss"] = autoboss_newboss;
                    CT_RaidTracker_Print("CT_RaidTracker 自动更新Boss: "..autoboss_newboss.." ("..unit..")", 1, 1, 0);
                end
            end
        end

        if(CT_RaidTracker_GetCurrentRaid and CT_RaidTracker_BossUnitTriggers[unit] and CT_RaidTracker_BossUnitTriggers[unit] ~= "IGNORE") then  
            local newboss = 1;              
            bosskilled = CT_RaidTracker_BossUnitTriggers[unit];
            if(not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["BossKills"]) then
                CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["BossKills"] = { };
            end
            -- is the boss already killed?
            for key, val in pairs(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["BossKills"]) do
                if(val["boss"] == bosskilled) then
                    newboss = 0;
                end
            end
            if (newboss == 1) and isThatBossKilled(unit) then
                local tAttendees = { };
                if( GetNumGroupMembers() > 0 ) then
                    for i = 1, GetNumGroupMembers() do
                        local name = GetFixedUpUnitName("raid" .. i);
                        if (name and name ~= UKNOWNBEING and name ~= UNKNOWN) then
                            tinsert(tAttendees, name);
                        end
                    end
                end
                tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["BossKills"],
                    {
                        ["boss"] = bosskilled,
                        ["time"] = sDate,
                        ["attendees"] = tAttendees
                    }
                 );
                 CT_RaidTracker_Print("CT_RaidTracker Boss 击杀: 设置 \""..bosskilled.."\" 击杀时间为 "..sDate, 1, 1, 0);
                 CT_RaidTracker_EditBossDKP(CT_RaidTracker_GetCurrentRaid, getn(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["BossKills"]));
            end
        end
end

function CT_RaidTrackerCreateNewRaid(system)
    if system ~= nil and strtrim(system) ~= "" then
        DKPSystem = getDKPSystemID(system);
        if DKPSystem == 0 then
            message("你选择的DKP系统不存在!");  
            return;
        end
    else
        DKPSystem = 0;
    end

    CT_RaidTracker_GetGameTimeOffset();
    local sDate = CT_RaidTracker_Date();
    if(CT_RaidTracker_GetCurrentRaid) then
        for k, v in pairs(CT_RaidTracker_Online) do
            CT_RaidTracker_Debug("ADDING LEAVE", k, sDate);
            tinsert( CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Leave"],
                {
                    ["player"] = GetFixedUpUnitName(k),
                    ["time"] = sDate,
                }
            );
        end
        if(not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["End"]) then
            CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["End"] = sDate;
        end
    end

    CT_RaidTracker_Online = { };
    tinsert( CT_RaidTracker_RaidLog, 1, { 
        ["Loot"] = { },
        ["Join"] = { },
        ["Leave"] = { },
        ["PlayerInfos"] = { },
        ["BossKills"] = { },
        ["BossKilled"] = { },
        ["key"] = sDate,
        ["Realm"] = GetRealmName(),
    });

    CT_RaidTracker_SortRaidTable();
    CT_RaidTracker_GetCurrentRaid = 1;
    if( IsInRaid() == true and GetNumGroupMembers() > 0 ) then
        for i = 1, GetNumGroupMembers(), 1 do
            local name, online = UnitName("raid" .. i), UnitIsConnected("raid" .. i);
            if( name and name ~= UKNOWNBEING and name ~= UNKNOWN ) then
                name = GetFixedUpUnitName(name);
                local race, class, level, guild = UnitRace("raid" .. i), UnitClass("raid" .. i), UnitLevel("raid" .. i), GetGuildInfo("raid" .. i);

                --init
                if(not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"]) then
                    CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"] = { };
                end
                if(not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name]) then
                    CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name] = { };
                end

                if(race) then CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name]["race"] = race; end
                if(class) then CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name]["class"] = class; end
                if(level > 0) then CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name]["level"] = level; end
                if(guild) then CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["PlayerInfos"][name]["guild"] = guild; end

                tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Join"],
                    {
                        ["player"] = name,
                        ["time"] = sDate
                    }
                );
                if ( not online ) then
                    tinsert(CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["Leave"],
                        {
                            ["player"] = name,
                            ["time"] = sDate
                        }
                    );
                end
                CT_RaidTracker_Online[name] = online;
            end
        end
    end

    CT_RaidTracker_DoZoneCheck()
    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();
end

function CT_RaidTrackerGenerateDkpLink(id)
    local race, class, level;
    local link = "<RaidInfo>";  

    link = link.."<key>"..CT_RaidTracker_RaidLog[id]["key"].."</key>";

    if (CT_RaidTracker_RaidLog[id]["Realm"]) then
        link = link.."<realm>"..CT_RaidTracker_RaidLog[id]["Realm"].."</realm>";
    end
    
    link = link.."<start>"..CT_RaidTracker_RaidLog[id]["key"].."</start>";

    if(CT_RaidTracker_RaidLog[id]["End"]) then
        link = link.."<end>"..CT_RaidTracker_RaidLog[id]["End"].."</end>";
    end
    if(CT_RaidTracker_RaidLog[id]["zone"]) then
        link = link.."<zone>"..CT_RaidTracker_RaidLog[id]["zone"].."</zone>";
    end
    if(CT_RaidTracker_RaidLog[id]["PlayerInfos"]) then
        link = link.."<PlayerInfos>";
        local playerinfosindex = 1;
        for key, val in pairs(CT_RaidTracker_RaidLog[id]["PlayerInfos"]) do
            link = link.."<key"..playerinfosindex..">";
            link = link.."<name>"..key.."</name>";
            for key2, val2 in pairs(CT_RaidTracker_RaidLog[id]["PlayerInfos"][key]) do
                if(key2 == "note") then
                    link = link.."<"..key2.."><![CDATA["..val2.."]]></"..key2..">";
                else
                    link = link.."<"..key2..">"..val2.."</"..key2..">";
                end
            end
            link = link.."</key"..playerinfosindex..">";
            playerinfosindex = playerinfosindex + 1;
        end
        link = link.."</PlayerInfos>";
    end
    if(CT_RaidTracker_RaidLog[id]["BossKills"]) then
        local bosskillsindex = 1;
        link = link.."<BossKills>";
        for key, val in pairs(CT_RaidTracker_RaidLog[id]["BossKills"]) do
            link = link.."<key"..bosskillsindex..">";
            link = link.."<name>"..val["boss"].."</name>";
            if(val["dkp"]) then
                link = link.."<dkp>"..val["dkp"].."</dkp>";
            else
                link = link.."<dkp>".."0".."</dkp>";
            end

                link = link.."<time>"..val["time"].."</time>";
                if( CT_RaidTracker_RaidLog[id]["BossKills"][key]["attendees"]) then
                    link = link.."<attendees>";
                    for key2, val2 in pairs(CT_RaidTracker_RaidLog[id]["BossKills"][key]["attendees"]) do
                        link = link.."<key"..key2..">";
                        link = link.."<name>"..val2.."</name>";
                        link = link.."</key"..key2..">";
                    end
                    link = link.."</attendees>";
                end

            link = link.."</key"..bosskillsindex..">";
            bosskillsindex = bosskillsindex + 1;
        end
        link = link.."</BossKills>";
    end

        local sNote = "<note><![CDATA[";
        if(CT_RaidTracker_RaidLog[id]["note"]) then sNote = sNote..CT_RaidTracker_RaidLog[id]["note"]; end
        if(CT_RaidTracker_RaidLog[id]["zone"]) then sNote = sNote.." - Zone: "..CT_RaidTracker_RaidLog[id]["zone"]; end
        sNote = sNote.."]]></note>";
        link = link..sNote;

    
    link = link.."<Loot>";
    local lootIndex = 1;
    for key, val in pairs(CT_RaidTracker_RaidLog[id]["Loot"]) do
        if val["costs"]~=nil and val["costs"]~="0" and val["costs"]~=0 then
        link = link.."<key"..lootIndex..">";
        link = link.."<ItemName>"..val["item"]["name"].."</ItemName>";
        link = link.."<ItemID>"..val["item"]["id"].."</ItemID>";
        if(val["item"]["icon"]) then link = link.."<Icon>"..val["item"]["icon"].."</Icon>"; end
        if(val["item"]["class"]) then link = link.."<Class>"..val["item"]["class"].."</Class>"; end
        if(val["item"]["subclass"]) then link = link.."<SubClass>"..val["item"]["subclass"].."</SubClass>"; end
        link = link.."<Color>"..val["item"]["c"].."</Color>";
        link = link.."<Count>"..val["item"]["count"].."</Count>";
        link = link.."<Player>"..val["player"].."</Player>";
        if(val["costs"]) then
            link = link.."<Costs>"..val["costs"].."</Costs>";
        end

            link = link.."<Time>"..val["time"].."</Time>";


        if(val["zone"]) then link = link.."<Zone>"..val["zone"].."</Zone>"; end
        if(val["boss"]) then link = link.."<Boss>"..val["boss"].."</Boss>"; end

        val["item"]["tooltip"] = CT_RaidTracker_GetItemTooltip(val["item"]["id"]);
        link = link.."<tooltip>"..val["item"]["tooltip"].."</tooltip>";
        

            local sNote = "<Note><![CDATA[";
            if(val["note"]) then sNote = sNote..val["note"]; end
            if(val["zone"]) then sNote = sNote.." - Zone: "..val["zone"]; end
            if(val["boss"]) then sNote = sNote.." - Boss: "..val["boss"]; end
            if(val["costs"]) then sNote = sNote.." - "..val["costs"].." DKP"; end
            sNote = sNote.."]]></Note>";
            link = link..sNote;

        link = link.."</key"..lootIndex..">";
        lootIndex = lootIndex + 1;
        end
    end
    link = link.."</Loot>";
    link = link.."</RaidInfo>";
    CT_RaidTrackerShowDkpLink(link);
end

function CT_RaidTrackerShowDkpLink(link) --Reviewed
    URLFrameEditBox:SetText(link);
    URLFrameEditBox:HighlightText();
    URLFrame:Show();
end

function CT_RaidTracker_Sort(tbl, method, way)
    if ( way == "asc" ) then
        table.sort(
            tbl,
            function(a1, a2)
                return a1[method] < a2[method];
            end
        );
    else
        table.sort(
            tbl,
            function(a1, a2)
                return a1[method] > a2[method];
            end
        );
    end
    return tbl;
end

function CT_RaidTracker_SortItem(tbl, method, way)
    table.sort(
        tbl,
        CT_RaidTracker_CompareItems
    );
    local newtable = {}
    for key, val in pairs(tbl) do
        newtable[key] = val;
    end
    return newtable;
end

function CT_RaidTracker_SortRaidTable()
    table.sort(
        CT_RaidTracker_RaidLog,
        function(a1, a2)
            if ( a1 and a2 ) then
                return CT_RaidTracker_GetTime(a1.key) > CT_RaidTracker_GetTime(a2.key);
            end
        end
    );
end

function CT_RaidTracker_GetTime(dDate)
    if ( not dDate ) then
        return nil;
    end
    local _, _, mon, day, year, hr, min, sec = string.find(dDate, "(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)");
    local table = date("*t", time());
    local timestamp;
    table["month"] = tonumber(mon);
    table["year"] = tonumber("20" .. year);
    table["day"] = tonumber(day);
    table["hour"] = tonumber(hr);
    table["min"] = tonumber(min);
    table["sec"] = tonumber(sec);
    timestamp = time(table);
    --[[ 
    table = date("*t", timestamp);
    if(table["isdst"]) then
        timestamp = timestamp - 3600;
    end
    ]]
    return timestamp;
end

function CT_RaidTracker_GameTimeFrame_Update()
    CT_RaidTracker_GameTimeFrame_Update_Original();
    local hour, minute = GetGameTime();
    local time = ((hour * 60) + minute) * 60;
    if(not CT_RaidTracker_TimeOffsetStatus) then
        CT_RaidTracker_TimeOffsetStatus = time;
    elseif(CT_RaidTracker_TimeOffsetStatus ~= time) then
        local ltimea = date("*t");
        local ltime = (((ltimea["hour"] * 60) + ltimea["min"]) * 60 + ltimea["sec"]) + (CT_RaidTracker_Options["Timezone"] * 3600);
        local timediff;
        if(time > ltime) then
            timediff = time - ltime;
            if(timediff >= 43200) then
                CT_RaidTracker_TimeOffset = timediff - 86400;
            else
                CT_RaidTracker_TimeOffset = timediff;
            end
        elseif(time < ltime) then
            timediff = ltime - time;
            if(timediff >= 43200) then
                CT_RaidTracker_TimeOffset = 86400 - timediff;
            else
                CT_RaidTracker_TimeOffset = timediff * -1;
            end
        else
            CT_RaidTracker_TimeOffset = 0;
        end
        CT_RaidTracker_Debug("CT_RaidTracker_TimeOffset", CT_RaidTracker_TimeOffset);
        GameTimeFrame_Update = CT_RaidTracker_GameTimeFrame_Update_Original;
        CT_RaidTracker_TimeOffsetStatus = nil;
    end
end

function CT_RaidTracker_GetGameTimeOffset()
    if(CT_RaidTracker_TimeOffsetStatus) then
        return;
    end
    if(not CT_RaidTracker_GameTimeFrame_Update_Original) then
        CT_RaidTracker_GameTimeFrame_Update_Original = GameTimeFrame_Update;
    end
    GameTimeFrame_Update = CT_RaidTracker_GameTimeFrame_Update;
    return;
end

function CT_RaidTracker_GetRaidTitle(id, hideid, showzone, shortdate)
    local RaidTitle = "";
    if ( CT_RaidTracker_RaidLog[id] and CT_RaidTracker_RaidLog[id].key ) then
        local _, _, mon, day, year, hr, min, sec = string.find(CT_RaidTracker_RaidLog[id].key, "(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)");
        if ( mon ) then
            local months = {
                "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
            };
            if ( not hideid ) then
                RaidTitle = RaidTitle .. "[" .. (getn(CT_RaidTracker_RaidLog)-id+1) .. "] ";
            end
            if ( not shortdate ) then
                RaidTitle = RaidTitle .. months[tonumber(mon)] .. " " .. day .. " '" .. year .. ", " .. hr .. ":" .. min;
            else
                RaidTitle = RaidTitle .. mon .. "/" .. day .. " " .. hr .. ":" .. min;
            end
            if ( showzone and CT_RaidTracker_RaidLog[id].zone) then
                RaidTitle = RaidTitle .. " " .. CT_RaidTracker_RaidLog[id].zone;
            end
            if id == CT_RaidTracker_GetCurrentRaid then
                if MerDKP_Table[DKPSystem]~=nil then
                    RaidTitle = RaidTitle.." |cffffffff"..MerDKP_Table[DKPSystem]["title"]
                end
                RaidTitle = RaidTitle.."  |cff00cc33进行中,结束后导出 ";               
            else
                RaidTitle = RaidTitle.."  |cffffffff已结束,右键导出";
            end
            return RaidTitle;
        else
            return "";
        end
    end
    return "";
end

function CT_RaidTracker_GetLootId(raidid, sPlayer, sItem, sTime)
    local lootid = nil;
    for key, val in pairs(CT_RaidTracker_RaidLog[raidid]["Loot"]) do
        if(val["player"] == sPlayer and val["item"]["id"] == sItem and val["time"] == sTime) then
            lootid = key;
            break;
        end
    end
    return lootid;
end

function CT_RaidTracker_GetItemInfo(sItem)
	local sStart, sEnde, sColor, sItemName, sName = string.find(sItem, "|c(%x+)|Hitem:([-%d:]+)|h%[(.-)%]|h|r");
	CT_RaidTracker_Debug("sColor:", sColor, "sName:", sName);
	return sColor, sItemName, sName, sStart, sEnde;
end

function CT_RaidTracker_GetItemTooltip(sItem)
    --CT_RTTooltip:SetOwner(this, "ANCHOR_NONE");
    CT_RTTooltip:SetHyperlink("spell:1");
    CT_RTTooltip:Show();
    CT_RTTooltip:SetHyperlink("item:" .. sItem);
    
    local lines = CT_RTTooltip:NumLines();
    local tooltiptxt = "";
    
    for i = 1, lines do
        local left = getglobal("CT_RTTooltipTextLeft" .. i):GetText();
        local right = getglobal("CT_RTTooltipTextRight" .. i):GetText();
        
        if left then
            tooltiptxt = tooltiptxt .. left;
            if right then
                tooltiptxt = tooltiptxt .. " " .. right .. "|";
            else
                tooltiptxt = tooltiptxt .. ";";
            end
        elseif right then
            tooltiptxt = tooltiptxt .. right .. "|";
        end
    end
    
    CT_RTTooltip:Hide(); -- $@!* YOU WOW API BLARGHGHALAGHALAHH
    return tooltiptxt;
end

function CT_RaidTracker_GetPlayerIndexes(raidid)
    local PlayerIndexes = { };
    local PlayerFound = nil;
    if( CT_RaidTracker_RaidLog[raidid] ) then
        for k, v in pairs(CT_RaidTracker_RaidLog[raidid]["PlayerInfos"]) do
            if ( k ) then
                PlayerFound = false;
                for k2, v2 in pairs(PlayerIndexes) do
                    if(v2 == k) then
                        PlayerFound = true;
                        break;
                    end
                end
                if(not PlayerFound) then
                    tinsert(PlayerIndexes, k);
                end
            end
        end
    end
    table.sort(PlayerIndexes);
    return PlayerIndexes;
end

function CT_RaidTracker_GetPlayerGroups(raidid) --fixed class init
    local PlayerIndexes = CT_RaidTracker_GetPlayerIndexes(raidid);
    local ClassGroups = { };
    local PlayerClass;

    if (PlayerIndexes) then
        for k, v in pairs(PlayerIndexes) do
            PlayerClass = CT_RaidTracker_RaidLog[raidid]["PlayerInfos"][v]["class"];
            if(PlayerClass) then
                ClassGroups[PlayerClass] = { };
            end
        end

        for k, v in pairs(PlayerIndexes) do
            PlayerClass = CT_RaidTracker_RaidLog[raidid]["PlayerInfos"][v]["class"];
            if(PlayerClass) then
                tinsert(ClassGroups[PlayerClass], v);
            end
        end
    end

    return ClassGroups;
end

function CT_RaidTracker_CompareItems(a1, a2)
    -- This function could probably be better, but I can't think of any better way while still maintaining functionality
    local filter, method, way = CT_RaidTracker_SortOptions["itemfilter"], CT_RaidTracker_SortOptions["itemmethod"], CT_RaidTracker_SortOptions["itemway"];
    if ( CT_RaidTrackerFrame.type == "playeritems" ) then
        filter, method, way = CT_RaidTracker_SortOptions["playeritemfilter"], CT_RaidTracker_SortOptions["playeritemmethod"], CT_RaidTracker_SortOptions["playeritemway"];
    end

    -- Check to see if it matches the rarity requirements
    if ( CT_RaidTracker_RarityTable[a1["item"]["c"]] < filter ) then
        return false;
    elseif ( CT_RaidTracker_RarityTable[a2["item"]["c"]] < filter ) then
        return true;
    end

    if ( method == "name" ) then
        local c1, c2 = a1["item"]["name"], a2["item"]["name"];
        if ( c1 == c2 ) then
            c1, c2 = a1["player"], a2["player"];
        end
        if ( way == "asc" ) then
            return c1 < c2;
        else
            return c1 > c2;
        end
    elseif ( method == "looter" ) then
        local c1, c2 = a1["player"], a2["player"];
        if ( c1 == c2 ) then
            c1, c2 = CT_RaidTracker_RarityTable[a2["item"]["c"]], CT_RaidTracker_RarityTable[a1["item"]["c"]];
            if ( c1 == c2 ) then
                c1, c2 = a1["item"]["name"], a2["item"]["name"];
            end
        end
        if ( way == "asc" ) then
            return c1 < c2;
        else
            return c1 > c2;
        end
    elseif ( method == "looted" ) then
        if ( way == "asc" ) then
            return CT_RaidTracker_GetTime(a1["time"]) < CT_RaidTracker_GetTime(a2["time"]);
        else
            return CT_RaidTracker_GetTime(a1["time"]) > CT_RaidTracker_GetTime(a2["time"]);
        end
    else
        local c1, c2 = CT_RaidTracker_RarityTable[a1["item"]["c"]], CT_RaidTracker_RarityTable[a2["item"]["c"]];
        if ( c1 == c2 ) then
            c1, c2 = a1["item"]["name"], a2["item"]["name"];
            if ( c1 == c2 ) then
                c1, c2 = a1["player"], a2["player"];
            else
                return c1 < c2;
            end
        end
        if ( way == "asc" ) then
            return c1 < c2;
        else
            return c1 > c2;
        end
    end
end

function CT_RaidTracker_ColorToRGB(str) --Reviewed
    str = strlower(strsub(str, 3));
    local tbl = { };
    tbl[1], tbl[2], tbl[3], tbl[4], tbl[5], tbl[6] = strsub(str, 1, 1), strsub(str, 2, 2), strsub(str, 3, 3), strsub(str, 4, 4), strsub(str, 5, 5), strsub(str, 6, 6);
    
    local highvals = { ["a"] = 10, ["b"] = 11, ["c"] = 12, ["d"] = 13, ["e"] = 14, ["f"] = 15 };
    for k, v in pairs(tbl) do
        if ( highvals[v] ) then
            tbl[k] = highvals[v];
        elseif ( tonumber(v) ) then
            tbl[k] = tonumber(v);
        end
    end
    local r, g, b = (tbl[1]*16+tbl[2])/255, (tbl[3]*16+tbl[4])/255, (tbl[5]*16+tbl[6])/255;
    if ( not r or r > 1 or r < 0 ) then
        r = 1;
    end
    if ( not g or g > 1 or g < 0 ) then
        g = 1;
    end
    if ( not b or b > 1 or b < 0 ) then
        b = 1;
    end
    return r, g, b;
end

function CT_RaidTracker_DoZoneCheck()
    if(not CT_RaidTracker_GetCurrentRaid) then
        return;
    end
    local newzone = GetRealZoneText();
    CT_RaidTracker_Debug("Current Zone",newzone);
    local checkednewzone = "";
    for k, v in pairs(CT_RaidTracker_ZoneTriggers) do
        if(newzone == k) then
            CT_RaidTracker_Debug("Zone is Instance",v);
            checkednewzone = v;            
            break;
        end
    end
    for k, v in pairs(CT_RaidTracker_CustomZoneTriggers) do
        if(newzone == k) then
            CT_RaidTracker_Debug("Zone is Custom Instance",v);
            checkednewzone = v;
            break;
        end
    end

    if (checkednewzone == "") then
        return false;
    end;
    if(not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["zone"]) then
        CT_RaidTracker_Debug("Set new Zone",checkednewzone);
        CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["zone"] = checkednewzone;
    else
        CT_RaidTracker_Debug("Current Raid Zone",CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["zone"]);
    end

    CT_RaidTracker_Update();
    CT_RaidTracker_UpdateView();
    return true;
end

function CT_RaidTracker_DoRaidIdCheck()
    if(not CT_RaidTracker_GetCurrentRaid) then
        return;
    end
    local savedInstances = GetNumSavedInstances();
    local instanceName, instanceID, instanceReset;
    if ( savedInstances > 0 ) then
        for i=1, MAX_RAID_INFOS do
            if ( i <=  savedInstances) then
                instanceName, instanceID, instanceReset = GetSavedInstanceInfo(i);
                if (CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["zone"] == instanceName) then
                    CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["instanceid"] = instanceID;
                end;
            end
        end
    end
end;

function CT_RaidTracker_Date()
    local timestamp;
    if(CT_RaidTracker_Options["TimeSync"] == 1) then
        timestamp = time()+CT_RaidTracker_TimeOffset+(CT_RaidTracker_Options["Timezone"]*3600);
    else
        timestamp = time()+(CT_RaidTracker_Options["Timezone"]*3600);
    end
    local t = date("*t", timestamp);
    return CT_RaidTracker_FixZero(t.month) .. "/" .. CT_RaidTracker_FixZero(t.day) .. "/" .. strsub(t.year, 3) .. " " .. CT_RaidTracker_FixZero(t.hour) .. ":" .. CT_RaidTracker_FixZero(t.min) .. ":" .. CT_RaidTracker_FixZero(t.sec);
end

function CT_RaidTracker_FixZero(num)
    if ( num < 10 ) then
        return "0" .. num;
    else
        return num;
    end
end

function CT_RaidTracker_Update_MerDKP(raidid)
    if (not CT_RaidTracker_GetCurrentRaid) or DKPSystem==0 or DKPSystem==nil or CT_RaidTracker_GetCurrentRaid~=raidid or MerDKP_Table_init[DKPSystem]==nil then
        return
    end    
    for k, v in pairs(MerDKP_Table_init[DKPSystem]) do
        if tonumber(k) ~= nil then        
        local dkp_init = v.dkp;
        local name = v.name;
        local change = 0;
        ----加上每个bossKill得分
        for k2,bossKills in pairs(CT_RaidTracker_RaidLog[raidid]["BossKills"]) do 
            if bossKills.dkp == nil or bossKills.dkp == 0 then 
            
            else               
                for k3,attendees in pairs(bossKills["attendees"]) do
                    if name == attendees then
                        change = change + bossKills.dkp;
                    end
                end
            end            
        end     
        ----减去物品DKP
        for k2,loot in pairs(CT_RaidTracker_RaidLog[raidid]["Loot"]) do
            if loot.player ~=nil and loot.player == name and loot.costs ~=nil and loot.costs ~= 0 then
                change = change - loot.costs;
            end
        end
   --     if change~=0 then
            local changed = setDKP(name,dkp_init+change)            
            if changed == true and UnitInRaid(name) and CT_RaidTracker_Options["AutoWhisper"] == 1 then
                SendChatMessage(IEPrefix.."您当前DKP为"..(dkp_init+change)..",本次获得"..change..",活动前DKP为"..dkp_init, "WHISPER", nil, name);
            end
    --    end
        end       
   end   
   MerDKP_InitDKP();
end;

function setDKP(name,dkp)
    for k, v in pairs(MerDKP_Table[DKPSystem]) do
        if tonumber(k) ~= nil then          
            if name == v.name then
                if v.dkp ~= dkp then
                    v.dkp = dkp;
                    return true;
                else
                    return false;
                end                
            end
        end
    end
    return false;
end

function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function getDKPSystemID(system)
    for k,v in pairs(MerDKP_Table) do
        if v.title == system then
            return k;
        end
    end
    return 0;
end

function whisperFilter(frame, event, msg, ...)

    if strfind(msg,IEPrefix) and CT_RaidTracker_Options["FilterWhisper"] == 1 then
        return true;
    elseif strfind(msg,IEPrefix.."您当前DKP为") then
    return true;
    else
        return false,msg, ...
    end
end

function isThatBossBad(boss)
    local bossName = CT_RaidTracker_BossUnitTriggers[boss];
    if not bossName or bossName=="IGNORE" then
    --CT_RaidTracker_Print("no exist");
        return false
    else
    local numBosses = 0;
    for k,v in pairs(CT_RaidTracker_BossUnitTriggers) do
       if v == bossName then
        numBosses = numBosses + 1;
       end
    end
    if numBosses > 1 then 
        return true;
    end
    end
    return false;
end

function isThatBossKilled(name)
    if not isThatBossBad(name) then
        return true;
    else
        local killed = true;
        local bossName = CT_RaidTracker_BossUnitTriggers[name];
        CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["BossKilled"][name] = true;
        for k,v in pairs(CT_RaidTracker_BossUnitTriggers) do
            if v == bossName then
                if not CT_RaidTracker_RaidLog[CT_RaidTracker_GetCurrentRaid]["BossKilled"][k] then
                    return false;
                end
            end
        end
        return true;
    end
end

function GetFixedUpUnitName(name) --modify to remove realmName
    if name == nil then
        return name;
    end

    local realmName = GetRealmName(name);
    if (realmName == nil) then
        realmName = "";
    end
    
    local fixedName = GetNameWithRealmName(name);
    if string.match(fixedName, "-") then
        fixedName = string.gsub(fixedName, "-"..realmName,"");
    end
    return fixedName;
end

function GetNameWithRealmName(name) --Reviewed
    if name == nil then
        return name
    else
        local fixedUpUnitName = GetUnitName(name, true)
        if fixedUpUnitName == nil then
            return name
        end
        if string.match(fixedUpUnitName, "-") then
            return fixedUpUnitName:gsub("%s+", "")
        else
            local realmName = GetRealmName(name)
            return fixedUpUnitName.."-"..realmName:gsub("%s+", "")
        end
    end
end

--end region function
