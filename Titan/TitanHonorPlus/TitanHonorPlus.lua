----------------------------
-- Variables + Constants
----------------------------
-- Keeps track of player class and level for the session.
local playerList = {};

-- Time until accepting battlegrounds invite
local TITAN_HONORPLUS_BGCONFIRM = 0;

-- Time of last PvP damage
local TITAN_HONORPLUS_PVPDMG = 0;

-- Timer
local TITAN_HONORPLUS_BGAUTOJOINTIMER = 30;

-- Gives standard class colour
TITAN_HONORPLUS_CLASSCOLORINDEX = {
	[1] = "|cffff7d0a",
	[2] = "|cffaad2aa",
	[3] = "|cff69cdf0",
	[4] = "|cfff58cb9",
	[5] = "|cffffffff",
	[6] = "|cfffff569",	
	[7] = "|cfff58cb9",
	[8] = "|cffc88296",
	[9] = "|cffc89b6e",
}

-- Default saved values.
TITAN_HONORPLUS_DEFAULTS = {
	['todayd'] = 0,
	['todayb'] = 0,
	['todaydk'] = 0,
	['todayhk'] = 0,
	['todaycp'] = 0,
	['yesterday'] = 0,
	['yesterday2'] = 0,
	['lastweek'] = 0,
	['weekdk'] = 0,
	['log'] = {},
};

-- Titan ID
local TITAN_HONORPLUS_ID = "HonorPlus";

-- PvP Icon Directory
local TITAN_HONORPLUS_ICON_PATH = "Interface\\PvPRankBadges\\PvPRank";

-- Converting honor-gain string format to double-format.
local TITAN_HONORPLUS_SEARCH = string.gsub(COMBATLOG_HONORGAIN,'%(','%%(');
local TITAN_HONORPLUS_SEARCH = string.gsub(TITAN_HONORPLUS_SEARCH,'%)','%%)');
local TITAN_HONORPLUS_SEARCH = string.gsub(TITAN_HONORPLUS_SEARCH,'%%s','(.+)');
local TITAN_HONORPLUS_SEARCH = string.gsub(TITAN_HONORPLUS_SEARCH,'%%d','(%%d+)');

-- Set when loaded
local vLoaded = nil;
local vVar = nil;

-- Playername|Realmname
local vC = nil;

----------------------------
-- Function Hooks
----------------------------
local old_WorldStateScoreFrame_Update; 		-- Battlegrounds score sheet. Display update.
local old_WorldStateScoreFrame_Resize; 		-- When we add a new column to the scoreboard we need to resize it differently.
local old_StaticPopup_OnHide;				-- Detects when you click 'hide' on BG invite request.

----------------------------
-- On Load
----------------------------
function TitanPanelHonorPlusButton_OnLoad()

	-- Register for TitanPanel
	TitanPanelHonorPlus_Register();
	
	-- ** Events **
	-- For initialisation
	this:RegisterEvent("VARIABLES_LOADED");
	-- For registering deaths by Players.
	this:RegisterEvent("PLAYER_DEAD"); -- And auto-release
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	-- Tooltip modifications
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	-- Updating titan button/tooltip
	this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
	-- For checking BG queue status
	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
	-- For showing the battlemap
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	
	-- Get LeftClick Event
	this:RegisterForClicks("LeftButtonUp");

	-- ** Function hooks **
	-- Update of BG scoreboard
	old_WorldStateScoreFrame_Update = WorldStateScoreFrame_Update;
	WorldStateScoreFrame_Update = TitanHonorPlus_WorldStateScoreFrame_Update;
	-- Resizing the BG scoreboard
	old_WorldStateScoreFrame_Resize = WorldStateScoreFrame_Resize;
	WorldStateScoreFrame_Resize = TitanHonorPlus_WorldStateScoreFrame_Resize
	-- Dynamic query dialog is hidden
	old_StaticPopup_OnHide = StaticPopup_OnHide;
	StaticPopup_OnHide = TitanHonorPlus_StaticPopup_OnHide;

	
	-- Kill List.
	SlashCmdList["TITANHONORPLUS"] = TitanHonorPlus_PrintKills;
	SLASH_TITANHONORPLUS1 = "/titanhonorplus";
	SLASH_TITANHONORPLUS2 = "/thp";
end

-- Setup Titan Registry
function TitanPanelHonorPlus_Register()
	this.registry = {
		id = TITAN_HONORPLUS_ID,
		menuText = TITAN_HONORPLUS_MENU_TEXT,
		buttonTextFunction = "TitanPanelHonorPlusButton_GetButtonText", 
		tooltipTitle = TITAN_HONORPLUS_TOOLTIP, 
		tooltipTextFunction = "TitanPanelHonorPlusButton_GetTooltipText",
		frequency = 1,
		category = "Combat",
		version = "[Cera 1.16]",
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			
			AlternateDisplay = 0,	
			SortByHonor = 0,
			SortByKills = 1,
			
			UseCalculatedToday = 0,
		
			Print_Bonus = 1,
			
			ScoreBoard_Kills = 1,
			ScoreBoard_Opium = 1,
			ScoreBoard_ClassColorSymbol = 0,
			ScoreBoard_ClassColorList = 1,
			
			Tooltip = 1,
			
			AutoRelease = 1,
			AutoJoinBG = 1,
			AutoBGMap = 1,
		}
	};	
end

----------------------------
-- Initialization
----------------------------
function TitanHonorPlus_Initialize()
	if (vVar) then
		local iName, xName;
		if (TITAN_HONORPLUS == nil) then TITAN_HONORPLUS = { }; end
		vC = UnitName("player").."|"..GetCVar("realmName");
		if (TITAN_HONORPLUS[vC] == nil) then TITAN_HONORPLUS[vC] = { }; end
		for iName, xName in TITAN_HONORPLUS_DEFAULTS do
			if (TITAN_HONORPLUS[vC][iName] == nil) then TITAN_HONORPLUS[vC][iName] = xName; end
		end
		for iName, xName in TITAN_HONORPLUS[vC]['log'] do
			if (type(xName) == "number") then TITAN_HONORPLUS[vC]['log'][iName] = { ['k'] = xName, ['h'] = 0, ['r'] = "Unknown Rank" }; end
		end
		if (TITAN_HONORPLUS_CHATINFO[UnitName("Player")]) then
			info = TITAN_HONORPLUS_CHATINFO[UnitName("Player")];
		else
			info = TITAN_HONORPLUS_CHATINFO["Default"];
		end
		ChatTypeInfo["HONORPLUS"] = info;
	
		if (type(TipBuddy_TargetName_Text) == "table") and (type(TipBuddy_Main_Frame) == "table") then
			TitanHonorPlus_TipBuddy_Main_Frame:Show();
			TitanHonorPlus_TipBuddy_TargetName_Text:ClearAllPoints();
			TitanHonorPlus_TipBuddy_TargetName_Text:SetPoint("BOTTOMLEFT", "TipBuddy_Main_Frame", "TOPLEFT", 0, 0);
		end
		TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
		TitanPanelButton_UpdateTooltip();
		vLoaded = true;
	end
end
function TitanHonorPlus_PrintKills()
	TITAN_HONORPLUS[vC]['todayb'] = TITAN_HONORPLUS[vC]['todayb'] -2500
end
----------------------------
-- Slash Commands
----------------------------
-- The one and only slash command prints all of todays kills
function TitanHonorPlus_PrintKills()
	local rankName, rankNumber, todayHK, todayDK, todayCP, todayB, ydayHK, ydayDK, ydayCP, ydayCP2,
		weekHK, weekDK, weekCP, lastweekHK, lastweekDK, lastweekCP, lastweekRank,
		lifetimeHK, lifetimeDK, highestRankName, highestRankNumber = TitanPanelHonorPlusGetPVPData("Slashcommand");
	DEFAULT_CHAT_FRAME:AddMessage("Todays Kills:");
	local s;
	if (TitanGetVar(TITAN_HONORPLUS_ID, "SortByKills") == 1) then s = "k"; else s = "h"; end
	local done = {};
	local a, b, x, y, i, c, high, text;
	local c1, c2 = "", "";
	i = 0;
	for a, b in TITAN_HONORPLUS[vC]['log'] do
		text, high = "", nil;
		for x, y in TITAN_HONORPLUS[vC]['log'] do
			if (not done[x]) then
				if (high == nil) then high = x; end
				if (y[s] > TITAN_HONORPLUS[vC]['log'][high][s]) then high = x; end
			end
		end
		done[high] = 1;
		c = "|cffd0d0ff";
		if (TITAN_HONORPLUS[vC]['log'][high]['k'] > 3) then c = "|cffffd0d0"; end
		if (TITAN_HONORPLUS[vC]['log'][high]['c']) then local oclass = TITAN_HONORPLUS[vC]['log'][high]['c']; c1 = TITAN_HONORPLUS_CLASSCOLORINDEX[oclass]; c2 = "|r"; end
		text = text..c..TITAN_HONORPLUS[vC]['log'][high]['k'].." "..c1..high..c2.."|r"..
								"|cffd0d0d0".." (";
		if (TITAN_HONORPLUS[vC]['log'][high]['l']) then text = text.."L"..TITAN_HONORPLUS[vC]['log'][high]['l'].." "; end
								text = text..TITAN_HONORPLUS[vC]['log'][high]['r']..")".."|r".."  "..
								"|cffdacda1"..TitanPanelHonorPlusRound(TITAN_HONORPLUS[vC]['log'][high]['h']).." "..HONOR_CONTRIBUTION_POINTS;
		i = i+1;
		DEFAULT_CHAT_FRAME:AddMessage(text);
	end
	if (i == 0) then DEFAULT_CHAT_FRAME:AddMessage("|cffffa0a0".."No Kills.".."|r"); end
end

----------------------------
-- On Event
----------------------------
function TitanPanelHonorPlusButton_OnEvent()

	if (event == "VARIABLES_LOADED") then
		vVar = true;
		TitanHonorPlus_Initialize();
---------------------------------------

	elseif (event == "CHAT_MSG_COMBAT_HONOR_GAIN") then
		local x, p, h, s ,e, f, k;
		local s, e, name, rank, honor = string.find(arg1, TITAN_HONORPLUS_SEARCH);
		if (name) and (rank) and (honor) then
			
			if (TITAN_HONORPLUS[vC]['log'][name] == nil) then TITAN_HONORPLUS[vC]['log'][name] = { ['h'] = 0, ['k'] = 0, }; end
			TITAN_HONORPLUS[vC]['todayhk'] = TITAN_HONORPLUS[vC]['todayhk'] +1;
			TITAN_HONORPLUS[vC]['log'][name]['k'] = TITAN_HONORPLUS[vC]['log'][name]['k'] +1;
			x = TITAN_HONORPLUS[vC]['log'][name]['k'];

			if (x > 10) then p = 0;
			else p = (11-x)/10; end

			h = TitanPanelHonorPlusRound(honor * p);
			TITAN_HONORPLUS[vC]['todaycp'] = TITAN_HONORPLUS[vC]['todaycp'] + h;
			local text = string.format(TITAN_HONORPLUS_ESTIMATED,rank, name, x, h);
			TitanPanelHonorPlusButton_PrintMsg(text);
			
			TITAN_HONORPLUS[vC]['log'][name]['h'] = TITAN_HONORPLUS[vC]['log'][name]['h'] + h;
			TITAN_HONORPLUS[vC]['log'][name]['r'] = rank;
			local oclass, olevel;
			if (playerList[name]) then
				if (playerList[name]['l']) then olevel = playerList[name]['l']; end
				if (playerList[name]['c']) then oclass = playerList[name]['c']; end
			end
			if ((not oclass) or (not olevel)) and (type(Opium_TimeToString) == "function") and (type(OpiumData) == "table") then
				local playerData = OpiumData["playerLinks"][GetCVar("realmName")][string.lower(name)];
				if playerData then
					olevel = playerData[OPIUM_INDEX_LEVEL];
					oclass = playerData[OPIUM_INDEX_CLASS];
				end
			end
			if (olevel) then
				TITAN_HONORPLUS[vC]['log'][name]['l'] = olevel;
			end
			if (oclass) then
				TITAN_HONORPLUS[vC]['log'][name]['c'] = oclass;
			end

		TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
		TitanPanelButton_UpdateTooltip();
		end

		-- Bonus honor gain
		local bonusHonor = 0;
		for bonusHonor in string.gfind(arg1, TITAN_HONORPLUS_BONUSHONOR) do
			TITAN_HONORPLUS[vC]['todayb'] = TITAN_HONORPLUS[vC]['todayb'] + bonusHonor;
			if (TitanGetVar(TITAN_HONORPLUS_ID, "Print_Bonus") == 1) then
				TitanPanelHonorPlusButton_PrintMsg(string.format(TITAN_HONORPLUS_BONUSHONORGAINED, bonusHonor));
			end
		TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
		TitanPanelButton_UpdateTooltip();
		end
---------------------------------------

	elseif (event == "UPDATE_MOUSEOVER_UNIT") then
		
		if (UnitExists("mouseover")) and (TitanGetVar(TITAN_HONORPLUS_ID, "Tooltip") == 1) and -- Longest ever if statement? lol
			(not UnitIsFriend("player", "mouseover")) and (UnitIsPlayer("mouseover")) and
			(GetDifficultyColor(UnitLevel("mouseover")) ~= QuestDifficultyColor["trivial"]) then
			
			local oclass, olevel = TITAN_HONORPLUS_CLASSINDEX[UnitClass("mouseover")], UnitLevel("mouseover");
			playerList[UnitName("mouseover")] = { ['c'] = oclass, ['l'] = olevel } 
			local i;
			local z = TITAN_HONORPLUS[vC]['log'][UnitName("mouseover")];
			if (z) then
				TITAN_HONORPLUS[vC]['log'][UnitName("mouseover")]['c'] = oclass;
				TITAN_HONORPLUS[vC]['log'][UnitName("mouseover")]['l'] = olevel;
				i = z['k'];
			end
			local text, color;
			if (type(i) ~= "number") then i = 0; end
			if (i > 9) then text = "0% ";
			else local j = (10-i); text = j .."0%"; end
			text = text.." "..HONOR_CONTRIBUTION_POINTS;
			color = TitanHonorPlus_SmoothColor(i);
			if (type(TipBuddy_TargetName_Text) == "table") and (type(TipBuddy_Main_Frame) == "table") then
				TitanHonorPlus_TipBuddy_Main_Frame:SetParent(TipBuddy_Main_Frame);
				TitanHonorPlus_TipBuddy_TargetName_Text:Show();
				TitanHonorPlus_TipBuddy_TargetName_Text:SetWidth(TipBuddy_Main_Frame:GetWidth());
				TitanHonorPlus_TipBuddy_TargetName_Text:SetText(text);
			end

			GameTooltip:AddLine(text);
			GameTooltip:Show();
		else
			TitanHonorPlus_TipBuddy_TargetName_Text:SetText("");
		end
---------------------------------------

	elseif (event == "UPDATE_BATTLEFIELD_STATUS") then
		TitanHonorPlus_CheckBGConfirm();
---------------------------------------

	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		TitanHonorPlus_ShowBGMap();
---------------------------------------
		
	elseif (event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS") or (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then
		TITAN_HONORPLUS_PVPDMG = GetTime();
---------------------------------------

	elseif (event == "PLAYER_DEAD") then
		-- Auto-Release upon death. But not when soulstoned, and only in battlegrounds.
		local status;
		for i=1, MAX_BATTLEFIELD_QUEUES do
			local s, _, _ = GetBattlefieldStatus(i);
			if (s == "active") then	
				status = "active";
				break;
			end
		end
		
		if (status == "active") and (not HasSoulstone()) and (TitanGetVar(TITAN_HONORPLUS_ID, "AutoRelease") == 1) then
			RepopMe();
		end
		local x = GetTime() -15;
		if (x <= TITAN_HONORPLUS_PVPDMG) then TITAN_HONORPLUS[vC]['todayd'] = TITAN_HONORPLUS[vC]['todayd'] +1; end
		TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
		TitanPanelButton_UpdateTooltip();
---------------------------------------
	end
------------------------------------------------------------------------------------------------------------------------------------------------------------	

end


----------------------------
-- Auto-Show Battlemap
----------------------------
function TitanHonorPlus_ShowBGMap()
	if(TitanGetVar(TITAN_HONORPLUS_ID, "AutoBGMap") == 1 ) then
	local zone_text = GetZoneText()
		if (zone_text == TITAN_HONORPLUS_BGZONES[1] or zone_text == TITAN_HONORPLUS_BGZONES[2] or zone_text == TITAN_HONORPLUS_BGZONES[3]) then
			BattlefieldMinimap:Show();
		end
	end
end

----------------------------
-- Auto-join Battlegrounds
----------------------------
function TitanHonorPlus_CheckBGConfirm()
	if (not TitanGetVar(TITAN_HONORPLUS_ID, "AutoJoinBG")) then return; end
	local status, index;

	for i=1,MAX_BATTLEFIELD_QUEUES do
		status,_,_ = GetBattlefieldStatus(i);
		if(status == "confirm") then
			index = i;
			break					
		end
	end

	if (status == "confirm") then
		if (StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY")) then
			if (TITAN_HONORPLUS_BGCONFIRM == 0) then
				DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR_CODE..TITAN_HONORPLUS_AUTOJOINBG..FONT_COLOR_CODE_CLOSE);
				TITAN_HONORPLUS_BGCONFIRM = GetTime() + TITAN_HONORPLUS_BGAUTOJOINTIMER;
			elseif (GetTime() > TITAN_HONORPLUS_BGCONFIRM) then
				TITAN_HONORPLUS_BGCONFIRM = 0;
				if (TITAN_HONORPLUS_AFK) then
					DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR_CODE..TITAN_HONORPLUS_AFKERROR..FONT_COLOR_CODE_CLOSE);
				else
					DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR_CODE..TITAN_HONORPLUS_AUTOJOINBG_DONE..FONT_COLOR_CODE_CLOSE);
					AcceptBattlefieldPort(index,1)
				end
				StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
			end
		end
	end
end

-- If the "Hide" button is clicked when ready to enter BG.
-- It means the user doesn't want to join, so we disable auto-join.
function TitanHonorPlus_StaticPopup_OnHide()
	old_StaticPopup_OnHide();
	if (this.which == "CONFIRM_BATTLEFIELD_ENTRY") and (TITAN_HONORPLUS_BGCONFIRM ~= 0) then
		TITAN_HONORPLUS_BGCONFIRM = 0;
		DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR_CODE..TITAN_HONORPLUS_AUTOJOINBG_CANCEL..FONT_COLOR_CODE_CLOSE);
	end
end



----------------------------
-- Return Button text
----------------------------
function TitanPanelHonorPlusButton_GetButtonText(id)
	if (not vLoaded) then return "Loading.."; end
	TitanHonorPlus_CheckBGConfirm();
	local rankName, rankNumber, todayHK, todayDK, todayCP, todayB, ydayHK, ydayDK, ydayCP, ydayCP2,
		weekHK, weekDK, weekCP, lastweekHK, lastweekDK, lastweekCP, lastweekRank,
		lifetimeHK, lifetimeDK, highestRankName, highestRankNumber = TitanPanelHonorPlusGetPVPData("Button");
		
	if (TitanGetVar(TITAN_HONORPLUS_ID, "AlternateDisplay") == 1) then
	

		local todayD = TITAN_HONORPLUS[vC]['todayd'];
		return ""..
			HONOR_CONTRIBUTION_POINTS..": ", TitanUtils_GetHighlightText(todayCP + todayB),
			TITAN_HONORPLUS_KILLS..": ", TitanUtils_GetGreenText(todayHK),
			TITAN_HONORPLUS_DEATHS..": ", TitanUtils_GetRedText(todayD);
	else
		return ""..
			TITAN_HONORPLUS_BUTTON_LABEL_RANK, TitanUtils_GetHighlightText(rankNumber),
			TITAN_HONORPLUS_BUTTON_LABEL_HK, TitanUtils_GetGreenText(todayHK),
			TITAN_HONORPLUS_BUTTON_LABEL_DK, TitanUtils_GetRedText(todayDK);
	end
end

----------------------------
-- Return all PvP data
----------------------------
function TitanPanelHonorPlusGetPVPData(msg)
	-- Current rank
	local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("player"));
	if (not rankName) then
		rankName = NONE;
	end

	-- This session's values
	local todayHK, todayDK = GetPVPSessionStats();
	
	local todayB = TITAN_HONORPLUS[vC]['todayb'];
	
	-- Yesterday's values
	local ydayHK, ydayDK, ydayCP = GetPVPYesterdayStats();

	-- This Week's values
	local weekHK, weekCP = GetPVPThisWeekStats();
	
	-- Last Week's values
	local lastweekHK, lastweekDK, lastweekCP, lastweekRank = GetPVPLastWeekStats();
	
	-- Lifetime stats
	local lifetimeHK, lifetimeDK, highestRank = GetPVPLifetimeStats();	
	local highestRankName, highestRankNumber = GetPVPRankInfo(highestRank);
	if ( not highestRankName ) then
		highestRankName = NONE;
	end
		
	if (ydayCP ~= TITAN_HONORPLUS[vC]['yesterday']) and (not ((ydayCP == 0) and (lifetimeHK == 0))) then
		-- Yesterday has been updated.
		TITAN_HONORPLUS[vC]['yesterday'] = ydayCP;
		TITAN_HONORPLUS[vC]['yesterday2'] = TITAN_HONORPLUS[vC]['todaycp'] + TITAN_HONORPLUS[vC]['todayb'];
		TITAN_HONORPLUS[vC]['weekdk'] = TITAN_HONORPLUS[vC]['weekdk'] + ydayDK;
		TITAN_HONORPLUS[vC]['log'] = { };
		TITAN_HONORPLUS[vC]['todayhk'] = 0;
		TITAN_HONORPLUS[vC]['todaydk'] = 0;
		TITAN_HONORPLUS[vC]['todaycp'] = 0;
		TITAN_HONORPLUS[vC]['todayb'] = 0;
		TITAN_HONORPLUS[vC]['todayd'] = 0;
		TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
		TitanPanelButton_UpdateTooltip();
	end
	if (TitanGetVar(TITAN_HONORPLUS_ID, "UseCalculatedToday") == 1) then todayHK = TITAN_HONORPLUS[vC]['todayhk']; end
	local todayCP = TITAN_HONORPLUS[vC]['todaycp'];
	local ydayCP2 = TITAN_HONORPLUS[vC]['yesterday2'];
	
	-- reset if new week
	if (lastweekCP ~= TITAN_HONORPLUS[vC]['lastweek']) then
		TITAN_HONORPLUS[vC]['lastweek'] = lastweekCP;
		TITAN_HONORPLUS[vC]['weekcp'] = 0;
		TITAN_HONORPLUS[vC]['weekdk'] = 0;
		TitanPanelButton_UpdateTooltip();
	end
	local weekDK = TITAN_HONORPLUS[vC]['weekdk'];
		
	return rankName, rankNumber, todayHK, todayDK, todayCP, todayB, ydayHK, ydayDK, ydayCP, ydayCP2,
		weekHK, weekDK, weekCP, lastweekHK, lastweekDK, lastweekCP, lastweekRank,
		lifetimeHK, lifetimeDK, highestRankName, highestRankNumber;
end

function TitanPanelHonorPlusButton_OnClick()
	if (arg1 == "LeftButton") then
		TitanPanelHonorPlus_ToggleVar_AlternateDisplay();
		TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
		TitanPanelButton_UpdateTooltip();
	else
		TitanPanelButton_OnClick(arg1);
	end
end

----------------------------
-- Return Tooltip text
----------------------------
function TitanPanelHonorPlusButton_GetTooltipText()
	if (not vLoaded) then return "Loading.."; end
	
	local rankName, rankNumber, todayHK, todayDK, todayCP, todayB, ydayHK, ydayDK, ydayCP, ydayCP2,
		weekHK, weekDK, weekCP, lastweekHK, lastweekDK, lastweekCP, lastweekRank,
		lifetimeHK, lifetimeDK, highestRankName, highestRankNumber = TitanPanelHonorPlusGetPVPData("Tooltip");
	
	local progress = TitanPanelHonorPlusRound(GetPVPRankProgress() *100);
	local todayD = TITAN_HONORPLUS[vC]['todayd'];
	local s;
	if (TitanGetVar(TITAN_HONORPLUS_ID, "SortByKills") == 1) then s = "k"; else s = "h"; end
	local done = {};
	local high;

	if (TitanGetVar(TITAN_HONORPLUS_ID, "AlternateDisplay") == 1) then
	
		local text = ""..
			RANK..": "..TitanUtils_GetHighlightText(rankName.." ("..RANK.." "..rankNumber..")").."\n"..
			TITAN_HONORPLUS_PROGRESS..": "..TitanUtils_GetHighlightText(progress.."%").."\n"..
			"\n"..
			TitanUtils_GetHighlightText(TITAN_HONORPLUS_PVPSTATS).."\n"..
			TITAN_HONORPLUS_KILLS..": \t"..TitanUtils_GetGreenText(todayHK).."\n"..
			TITAN_HONORPLUS_DEATHS..": \t"..TitanUtils_GetRedText(todayD).."\n"..
			"\n"..
			TitanUtils_GetHighlightText(HONOR_CONTRIBUTION_POINTS).."\n"..
			TITAN_HONORPLUS_KILLS..": \t"..TitanUtils_GetHighlightText(todayCP).."\n"..
			TITAN_HONORPLUS_BONUS..": \t"..TitanUtils_GetHighlightText(todayB).."\n"..
			TITAN_HONORPLUS_TOTAL..": \t"..TitanUtils_GetHighlightText(todayCP + todayB).."\n"..
			"\n"..
			TitanUtils_GetHighlightText(TITAN_HONORPLUS_TOP15);
			
				local a, b, x, y, i, c;
				local c1 = "|cffd0d0d0";
				i = 0;
				for a, b in TITAN_HONORPLUS[vC]['log'] do
					high = nil;
					for x, y in TITAN_HONORPLUS[vC]['log'] do
						if (not done[x]) then
							if (high == nil) then high = x; end
							if (y[s] > TITAN_HONORPLUS[vC]['log'][high][s]) then high = x; end
						end
					end
					done[high] = 1;
					c = "|cffd0d0ff";
					if (TITAN_HONORPLUS[vC]['log'][high]['k'] > 3) then c = "|cffffd0d0"; end
					if (TITAN_HONORPLUS[vC]['log'][high]['c']) then local oclass = TITAN_HONORPLUS[vC]['log'][high]['c']; c1 = TITAN_HONORPLUS_CLASSCOLORINDEX[oclass]; end
					text = text.."\n"..c..TITAN_HONORPLUS[vC]['log'][high]['k'].." "..c1..high.."|r"..
											"|cffd0d0d0".." (";
					if (TITAN_HONORPLUS[vC]['log'][high]['l']) then text = text.."L"..TITAN_HONORPLUS[vC]['log'][high]['l'].." "; end
											text = text..TITAN_HONORPLUS[vC]['log'][high]['r']..")".."|r".."\t"..
											"|cffdacda1"..TitanPanelHonorPlusRound(TITAN_HONORPLUS[vC]['log'][high]['h']).." "..HONOR_CONTRIBUTION_POINTS;
					i = i+1;
					if (i == 15) then break; end
				end
				if (i == 0) then text = text.."\n"..TITAN_HONORPLUS_NOKILLS; end
		return text;
	else
	
		return ""..
			RANK..": "..TitanUtils_GetHighlightText(rankName.." ("..RANK.." "..rankNumber..")").."\n"..
			TITAN_HONORPLUS_PROGRESS..": "..TitanUtils_GetHighlightText(progress.."%").."\n"..
			"\n"..
			TitanUtils_GetHighlightText(HONOR_THIS_SESSION).." ".."|cffa0a0a0"..TITAN_HONORPLUS_HINT_TOOLTIP.."|r".."\n"..
			HONORABLE_KILLS..": \t"..TitanUtils_GetGreenText(todayHK).."\n"..
			DISHONORABLE_KILLS..": \t"..TitanUtils_GetRedText(todayDK).."\n"..
			TITAN_HONORPLUS_BONUS..": \t"..TitanUtils_GetHighlightText(todayB).."\n"..
			TITAN_HONORPLUS_HONORESTIMATION..": \t".."|cffa0a0ff"..(todayCP + todayB).."|r".."\n"..
			"\n"..
			TitanUtils_GetHighlightText(HONOR_YESTERDAY).."\n"..
			HONORABLE_KILLS..": \t"..TitanUtils_GetGreenText(ydayHK).."\n"..
			DISHONORABLE_KILLS..": \t"..TitanUtils_GetRedText(ydayDK).."\n"..
			HONOR_CONTRIBUTION_POINTS..": \t"..TitanUtils_GetHighlightText(ydayCP).."\n"..
			TITAN_HONORPLUS_HONORESTIMATED..": \t".."|cffa0a0ff"..ydayCP2.."|r".."\n"..
			"\n"..
			TitanUtils_GetHighlightText(HONOR_THISWEEK).."\n"..
			HONORABLE_KILLS..": \t"..TitanUtils_GetGreenText(weekHK).."\n"..
			DISHONORABLE_KILLS..": \t"..TitanUtils_GetRedText(weekDK).."\n"..
			HONOR_CONTRIBUTION_POINTS..": \t"..TitanUtils_GetHighlightText(weekCP).."\n"..
			TITAN_HONORPLUS_HONORESTIMATION..": \t".."|cffa0a0ff"..(weekCP + todayCP + todayB).."|r".."\n"..
			"\n"..
			TitanUtils_GetHighlightText(HONOR_LASTWEEK).."\n"..
			HONORABLE_KILLS..": \t"..TitanUtils_GetGreenText(lastweekHK).."\n"..
			DISHONORABLE_KILLS..": \t"..TitanUtils_GetRedText(lastweekDK).."\n"..
			HONOR_CONTRIBUTION_POINTS..": \t"..TitanUtils_GetHighlightText(lastweekCP).."\n"..
			HONOR_STANDING..": \t"..TitanUtils_GetHighlightText(lastweekRank).."\n"..
			"\n"..
			TitanUtils_GetHighlightText(HONOR_LIFETIME).."\n"..
			HONORABLE_KILLS..": \t"..TitanUtils_GetGreenText(lifetimeHK).."\n"..
			DISHONORABLE_KILLS..": \t"..TitanUtils_GetRedText(lifetimeDK).."\n"..
			HONOR_HIGHEST_RANK..": \t"..TitanUtils_GetHighlightText(highestRankName);
			
	end
end

----------------------------
-- PvP Icon
----------------------------
function TitanPanelHonorPlusButton_OnShow()
	TitanPanelHonorPlusButton_SetPVPHonorIcon();
end

function TitanPanelHonorPlusButton_SetPVPHonorIcon()
	local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("player"));	
	if (rankNumber > 0) then
		TitanPanelHonorPlusButtonIcon:SetTexture(format("%s%02d", TITAN_HONORPLUS_ICON_PATH, rankNumber));
		TitanPanelHonorPlusButtonIcon:SetWidth(16);
	end
end

----------------------------
-- TitanVar Toggles
----------------------------
function TitanPanelHonorPlus_ToggleVar_UseCalculatedToday()
	TitanToggleVar(TITAN_HONORPLUS_ID, "UseCalculatedToday");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
end
function TitanPanelHonorPlus_ToggleVar_Print_Bonus()
	TitanToggleVar(TITAN_HONORPLUS_ID, "Print_Bonus");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
end
function TitanPanelHonorPlus_ToggleVar_ScoreBoard_Opium()
	TitanToggleVar(TITAN_HONORPLUS_ID, "ScoreBoard_Opium");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
end
function TitanPanelHonorPlus_ToggleVar_ScoreBoard_ClassColorSymbol()
	TitanToggleVar(TITAN_HONORPLUS_ID, "ScoreBoard_ClassColorSymbol");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
end
function TitanPanelHonorPlus_ToggleVar_ScoreBoard_ClassColorList()
	TitanToggleVar(TITAN_HONORPLUS_ID, "ScoreBoard_ClassColorList");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
end
function TitanPanelHonorPlus_ToggleVar_Tooltip()
	TitanToggleVar(TITAN_HONORPLUS_ID, "Tooltip");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
end
function TitanPanelHonorPlus_ToggleVar_ScoreBoard_Kills()
	TitanToggleVar(TITAN_HONORPLUS_ID, "ScoreBoard_Kills");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
	WorldStateScoreFrame_Update();
	WorldStateScoreFrame_Resize();
end
function TitanPanelHonorPlus_ToggleVar_AlternateDisplay()
	TitanToggleVar(TITAN_HONORPLUS_ID, "AlternateDisplay");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
end
function TitanPanelHonorPlus_ToggleVar_Sorting()
	TitanToggleVar(TITAN_HONORPLUS_ID, "SortByKills");
	TitanToggleVar(TITAN_HONORPLUS_ID, "SortByHonor");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
end
function TitanPanelHonorPlus_ToggleVar_AutoRelease()
	TitanToggleVar(TITAN_HONORPLUS_ID, "AutoRelease");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
end

function TitanPanelHonorPlus_ToggleVar_AutoJoinBG()
	TitanToggleVar(TITAN_HONORPLUS_ID, "AutoJoinBG");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
end

function TitanPanelHonorPlus_ToggleVar_AutoBGMap()
	TitanToggleVar(TITAN_HONORPLUS_ID, "AutoBGMap");
	TitanPanelButton_UpdateButton(TITAN_HONORPLUS_ID);
	
end

----------------------------
-- Rightclick Menu
----------------------------
function TitanPanelRightClickMenu_PrepareHonorPlusMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_HONORPLUS_ID].menuText);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_HONORPLUS_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_HONORPLUS_ID);
	TitanPanelRightClickMenu_AddSpacer();

	
	TitanPanelRightClickMenu_AddTitle("General Options");
	info = {};
	info.text = TITAN_HONORPLUS_MENU_TOOLTIP;
	info.func = TitanPanelHonorPlus_ToggleVar_Tooltip;
	info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "Tooltip");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	-- Add toggle for calculating today's values.
	info = {};
	info.text = TITAN_HONORPLUS_MENU_CALCTODAY;
	info.func = TitanPanelHonorPlus_ToggleVar_UseCalculatedToday;
	info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "UseCalculatedToday");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_HONORPLUS_MENU_PRINTBONUS;
	info.func = TitanPanelHonorPlus_ToggleVar_Print_Bonus;
	info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "Print_Bonus");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddTitle("Scoreboard Options");	
	
	info = {};
	info.text = TITAN_HONORPLUS_MENU_SCOREBOARDCLASSCOLORSYMBOL;
	info.func = TitanPanelHonorPlus_ToggleVar_ScoreBoard_ClassColorSymbol;
	info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "ScoreBoard_ClassColorSymbol");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	info = {};
	info.text = TITAN_HONORPLUS_MENU_SCOREBOARDCLASSCOLORLIST;
	info.func = TitanPanelHonorPlus_ToggleVar_ScoreBoard_ClassColorList;
	info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "ScoreBoard_ClassColorList");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	info = {};
	info.text = TITAN_HONORPLUS_MENU_SCOREBOARDKILLS;
	info.func = TitanPanelHonorPlus_ToggleVar_ScoreBoard_Kills;
	info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "ScoreBoard_Kills");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	if (type(Opium_TimeToString) == "function") and (type(OpiumData) == "table") then
		info = {};
		info.text = TITAN_HONORPLUS_MENU_OPIUM;
		info.func = TitanPanelHonorPlus_ToggleVar_ScoreBoard_Opium;
		info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "ScoreBoard_Opium");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);
	end
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddTitle("Battlegrounds");
	
	info = {};
	info.text = TITAN_HONORPLUS_MENU_AUTORELEASE;
	info.func = TitanPanelHonorPlus_ToggleVar_AutoRelease;
	info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "AutoRelease");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	info = {};
	info.text = TITAN_HONORPLUS_MENU_AUTOJOINBG;
	info.func = TitanPanelHonorPlus_ToggleVar_AutoJoinBG;
	info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "AutoJoinBG");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	info = {};
	info.text = TITAN_HONORPLUS_MENU_AUTOBGMAP;
	info.func = TitanPanelHonorPlus_ToggleVar_AutoBGMap;
	info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "AutoBGMap");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	if (TitanGetVar(TITAN_HONORPLUS_ID, "AlternateDisplay") == 1) then
		TitanPanelRightClickMenu_AddSpacer();
		TitanPanelRightClickMenu_AddTitle("Sorting");
		
		info = {};
		info.text = TITAN_HONORPLUS_MENU_SORTBYKILLS;
		info.func = TitanPanelHonorPlus_ToggleVar_Sorting;
		info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "SortByKills");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);
	
		info = {};
		info.text = TITAN_HONORPLUS_MENU_SORTBYHONOR;
		info.func = TitanPanelHonorPlus_ToggleVar_Sorting;
		info.checked = TitanGetVar(TITAN_HONORPLUS_ID, "SortByHonor");
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info);
	end
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddTitle(TITAN_HONORPLUS_HINT);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_HONORPLUS_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

----------------------------
-- Simple Round Function
----------------------------
function TitanPanelHonorPlusRound(x)
	if (x > 0) then
		return math.floor(x+0.5);
	else
		return math.ceil(x-0.5);
	end
end

----------------------------
-- Hooked Scoreboard Function
----------------------------
function TitanHonorPlus_WorldStateScoreFrame_Update()
	old_WorldStateScoreFrame_Update();

	local TitanHonorPlusColumn;
	if (TitanGetVar(TITAN_HONORPLUS_ID, "ScoreBoard_Kills")) then
		local text, icon, tooltip, columnButton;
		local numStatColumns = GetNumBattlefieldStats();
		local columnButton, columnButtonText, columnTextButton, columnIcon;
		local honorGainedAnchorFrame = "WorldStateScoreFrameHK";
		local i = numStatColumns+1;
		if (i <= MAX_NUM_STAT_COLUMNS) then
			TitanHonorPlusColumn = i;
			text, icon, tooltip = TITAN_HONORPLUS_KILLEDTODAY, "", TITAN_HONORPLUS_TOOLTIP_TODAYSKILLS;
			columnButton = getglobal("WorldStateScoreColumn"..i);
			columnButtonText = getglobal("WorldStateScoreColumn"..i.."Text");
			columnButtonText:SetText(text);
			columnButton.icon = icon;
			columnButton.tooltip = tooltip;
			
			columnTextButton = getglobal("WorldStateScoreButton1Column"..i.."Text");
			columnTextButton:SetPoint("CENTER", "WorldStateScoreColumn"..i, "CENTER", -1, -33);
			
			honorGainedAnchorFrame = "WorldStateScoreColumn"..i;
			WorldStateScoreFrameHonorGained:SetPoint("CENTER", honorGainedAnchorFrame, "CENTER", 88, 0);
			
			getglobal("WorldStateScoreColumn"..i):Show();
		end
	end
	local i;
	local numScores = GetNumBattlefieldScores();
	local name, faction, index, buttonName, log, kills, color, text;
	local buttonName, nameButton, todayColumn;

	for i=1, MAX_WORLDSTATE_SCORE_BUTTONS do
		-- Need to create an index adjusted by the scrollframe offset
		index = FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame) + i;
		if ( index <= numScores ) then
			buttonName = getglobal("WorldStateScoreButton"..i.."NameButtonName");
			nameButton = getglobal("WorldStateScoreButton"..i.."NameButton");
			if (TitanHonorPlusColumn) then todayColumn = getglobal("WorldStateScoreButton"..i.."Column"..TitanHonorPlusColumn.."Text"); end
			local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class = GetBattlefieldScore(index);
			if (name) then
				text = name;
				if (TitanGetVar(TITAN_HONORPLUS_ID, "ScoreBoard_Opium")) and (type(Opium_TimeToString) == "function") and (type(OpiumData) == "table") then
					local myfaction = OPIUM_FACTIONINDEX[UnitFactionGroup("player")];
					local oname, oline;
					local playerData = OpiumData["playerLinks"][GetCVar("realmName")][string.lower(name)];
					if playerData then
						local olevel, oclass, orace, ofaction, oguild, olastseen = playerData[OPIUM_INDEX_LEVEL], playerData[OPIUM_INDEX_CLASS], playerData[OPIUM_INDEX_RACE], playerData[OPIUM_INDEX_FACTION], playerData[OPIUM_INDEX_GUILD], playerData[OPIUM_INDEX_LASTSEEN];
						if (olevel == -1) then olevel = "??"; end
						olastseen = Opium_TimeToString(time() - OPIUM_TIMEOFFSET - olastseen);
						if (ofaction ~= myfaction) then oname = "|cffff5050"..name.."|r"; else oname = "|cff50ff50"..name.."|r"; end
						oline = oname.."\n"..HIGHLIGHT_FONT_COLOR_CODE..OPIUM_TEXT_LEVEL.." "..olevel.."|r".." "..OPIUM_RACEINDEX[orace].." "..TITAN_HONORPLUS_CLASSCOLORINDEX[oclass]..OPIUM_CLASSINDEX[oclass].."|r";
						if (oguild) then oline = oline.."\n".."|cff30ff30".."<"..oguild..">".."|r"; end
						oline = oline.."\nLast Seen: ".."|cffffa0a0"..olastseen.."|r";
						nameButton.tooltip = oline;
					end
				end
				if (faction == 1) then faction = "Alliance"; else faction = "Horde"; end
				local i = TITAN_HONORPLUS_CLASSINDEX[class];
				if (WorldStateScoreFrame.selectedTab == 1) then
					if (TitanGetVar(TITAN_HONORPLUS_ID, "ScoreBoard_ClassColorSymbol")) then text = text..TITAN_HONORPLUS_CLASSCOLORINDEX[i].."+".."|r"; end
				else
					if (TitanGetVar(TITAN_HONORPLUS_ID, "ScoreBoard_ClassColorList")) then text = TITAN_HONORPLUS_CLASSCOLORINDEX[i]..text.."|r"; end
				end
				buttonName:SetText(text);
				if (todayColumn) and (TitanGetVar(TITAN_HONORPLUS_ID, "ScoreBoard_Kills")) and (faction ~= UnitFactionGroup("player")) then
				local _, _, truncname = string.find(name, "(%a+)");
				local log = TITAN_HONORPLUS[vC]['log'][truncname];
					if (log) then log = log['k']; end
					if (type(log) ~= "number") then log = 0; end
					todayColumn:SetText(TitanHonorPlus_SmoothColor(log, 1)..log.."|r");
					todayColumn:Show();
				end
			end
		end
	end
end

-- Returns color based on number of kills, green to red. Red if more than 3 kills.
function TitanHonorPlus_SmoothColor(k, t)
	if (k > 10) then k = 10; end
	p = 1-(k/10);
	local r,g,b = 1, 0, 0;
	if (p > 0) then g = p; end
	if (not t) then return r, g, b; end
	r, g, b = TitanHonorPlus_base10to16(255*r), TitanHonorPlus_base10to16(255*g), TitanHonorPlus_base10to16(255*b);
	return "|cff"..r..g..b;
end

local TITAN_HONORPLUS_BASE16 = { [0] = 0, [1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6, [7] = 7, [8] = 8, [9] = 9, [10] = "a", [11] = "b", [12] = "c", [13] = "d", [14] = "e", [15] = "f" };

function TitanHonorPlus_base10to16(n)
	if (type(n) ~= "number") then return; end
	n = math.floor(n);
	local r, d, x = nil, 0, "";
	while true do
		d = math.floor(n / 16);
		r = n - (d*16);
		n = d;
		x = TITAN_HONORPLUS_BASE16[r]..x;
		if (d == 0) then break; end
	end
	while (strlen(x) < 2) do x = "0"..x; end
	return x;
end

-- So we can grow the size of the BG scoreboard when we add the new column
function TitanHonorPlus_WorldStateScoreFrame_Resize(width)
	old_WorldStateScoreFrame_Resize();
	TitanHonorPlus_WorldStateScoreFrame_Resize_func();
end

function TitanHonorPlus_WorldStateScoreFrame_Resize_func()
	if (TitanGetVar(TITAN_HONORPLUS_ID, "ScoreBoard_Kills")) then
		local numColumns = GetNumBattlefieldStats() +1;
		if ( WorldStateScoreScrollFrame:IsVisible() ) then
			width = WORLDSTATESCOREFRAME_BASE_WIDTH + 37 + numColumns *WORLDSTATESCOREFRAME_COLUMN_SPACING;
		else
			width = WORLDSTATESCOREFRAME_BASE_WIDTH + numColumns *WORLDSTATESCOREFRAME_COLUMN_SPACING;
		end
		WorldStateScoreFrame:SetWidth(width);
		WorldStateScoreFrameTopBackground:SetWidth(WorldStateScoreFrame:GetWidth()-129);
		WorldStateScoreFrameTopBackground:SetTexCoord(0, WorldStateScoreFrameTopBackground:GetWidth()/256, 0, 1.0);
		WorldStateScoreFrame.scrollBarButtonWidth = WorldStateScoreFrame:GetWidth() - 165;
		WorldStateScoreFrame.buttonWidth = WorldStateScoreFrame:GetWidth() - 137;
		WorldStateScoreScrollFrame:SetWidth(WorldStateScoreFrame.scrollBarButtonWidth);
	end
end

----------------------------
-- Chat Options
----------------------------
CHAT_MSG_HONORPLUS = "Honor+";
ChatTypeGroup["HONORPLUS"] = {
	"CHAT_MSG_HONORPLUS"
};
ChatTypeInfo["HONORPLUS"] = { sticky = 0 };
tinsert(OtherMenuChatTypeGroups, "HONORPLUS");
CHAT_HONORPLUS_GET = "";
if (TITAN_HONORPLUS_CHATINFO == nil) then
	TITAN_HONORPLUS_CHATINFO = {
		["Default"] = {
			["r"] = 0.878,
			["g"] = 0.792,
			["b"] = 0.039,
			["show"] = {
				"ChatFrame1"
			}
		}
	};
end

function TitanPanelHonorPlusButton_PrintMsg(msg)
	event = "CHAT_MSG_HONORPLUS";
	arg1 = msg;
	arg2, arg3, arg4, arg6 = "", "", "", "";
	local info = TITAN_HONORPLUS_CHATINFO["Default"];
	if ( TITAN_HONORPLUS_CHATINFO[UnitName("player")] ) then
		info = TITAN_HONORPLUS_CHATINFO[UnitName("player")];
	end
	for i = 1, 7, 1 do
		for k, v in info["show"] do
			if ( v == "ChatFrame" .. i ) then
				this = getglobal("ChatFrame" .. i);
				ChatFrame_OnEvent(event);
			end
		end
	end
end

TitanPanelHonorPlusButton_oldFCF_Tab_OnClick = FCF_Tab_OnClick;
function TitanPanelHonorPlusButton_newFCF_Tab_OnClick(button)
	TitanPanelHonorPlusButton_oldFCF_Tab_OnClick(button);
	if ( button == "RightButton" ) then
		local frame = getglobal("ChatFrame" .. this:GetID());
		local info = TITAN_HONORPLUS_CHATINFO["Default"];
		if ( TITAN_HONORPLUS_CHATINFO[UnitName("player")] ) then
			info = TITAN_HONORPLUS_CHATINFO[UnitName("player")];
		end
		for k, v in info["show"] do
			if ( v == "ChatFrame" .. this:GetID() ) then
				local y = 1;
				while ( frame.messageTypeList[y] ) do
					y = y + 1;
				end
				frame.messageTypeList[y] = "HONORPLUS";
			end
		end
	end
end
FCF_Tab_OnClick = TitanPanelHonorPlusButton_newFCF_Tab_OnClick;

TitanPanelHonorPlusButton_oldFCF_SetChatTypeColor = FCF_SetChatTypeColor;
function TitanPanelHonorPlusButton_newFCF_SetChatTypeColor()
	TitanPanelHonorPlusButton_oldFCF_SetChatTypeColor();
	if ( UIDROPDOWNMENU_MENU_VALUE == "HONORPLUS" ) then
		local r,g,b = ColorPickerFrame:GetColorRGB();
		if ( not TITAN_HONORPLUS_CHATINFO[UnitName("player")] ) then
			TITAN_HONORPLUS_CHATINFO[UnitName("player")] = TITAN_HONORPLUS_CHATINFO["Default"];
		end
		TITAN_HONORPLUS_CHATINFO[UnitName("player")].r = r;
		TITAN_HONORPLUS_CHATINFO[UnitName("player")].g = g;
		TITAN_HONORPLUS_CHATINFO[UnitName("player")].b = b;
		ChatTypeInfo["HONORPLUS"].r = r;
		ChatTypeInfo["HONORPLUS"].g = g;
		ChatTypeInfo["HONORPLUS"].b = b;
	end
end
FCF_SetChatTypeColor = TitanPanelHonorPlusButton_newFCF_SetChatTypeColor;

TitanPanelHonorPlusButton_oldFCF_CancelFontColorSettings = FCF_CancelFontColorSettings;
function TitanPanelHonorPlusButton_newFCF_CancelFontColorSettings(prev)
	TitanPanelHonorPlusButton_oldFCF_CancelFontColorSettings(prev);
	if ( prev.r and UIDROPDOWNMENU_MENU_VALUE == "HONORPLUS" ) then
		if ( not TITAN_HONORPLUS_CHATINFO[UnitName("player")] ) then
			TITAN_HONORPLUS_CHATINFO[UnitName("player")] = TITAN_HONORPLUS_CHATINFO["Default"];
		end
		TITAN_HONORPLUS_CHATINFO[UnitName("player")].r = prev.r;
		TITAN_HONORPLUS_CHATINFO[UnitName("player")].g = prev.g;
		TITAN_HONORPLUS_CHATINFO[UnitName("player")].b = prev.b;
		ChatTypeInfo["HONORPLUS"].r = prev.r;
		ChatTypeInfo["HONORPLUS"].g = prev.g;
		ChatTypeInfo["HONORPLUS"].b = prev.b;
	end
end
FCF_CancelFontColorSettings = TitanPanelHonorPlusButton_newFCF_CancelFontColorSettings;

TitanPanelHonorPlusButton_oldFCFMessageTypeDropDown_OnClick = FCFMessageTypeDropDown_OnClick;
function TitanPanelHonorPlusButton_newFCFMessageTypeDropDown_OnClick()
	TitanPanelHonorPlusButton_oldFCFMessageTypeDropDown_OnClick();
	if ( not TITAN_HONORPLUS_CHATINFO[UnitName("player")] ) then
		TITAN_HONORPLUS_CHATINFO[UnitName("player")] = TITAN_HONORPLUS_CHATINFO["Default"];
	end
	if ( this.value == "HONORPLUS" ) then
		if ( UIDropDownMenuButton_GetChecked() ) then
			for k, v in TITAN_HONORPLUS_CHATINFO[UnitName("player")]["show"] do
				if ( v == FCF_GetCurrentChatFrame():GetName() ) then
					TITAN_HONORPLUS_CHATINFO[UnitName("player")]["show"][k] = nil;
					break;
				end
			end
		else
			tinsert(TITAN_HONORPLUS_CHATINFO[UnitName("player")]["show"], FCF_GetCurrentChatFrame():GetName());
		end
	end
end
FCFMessageTypeDropDown_OnClick = TitanPanelHonorPlusButton_newFCFMessageTypeDropDown_OnClick;