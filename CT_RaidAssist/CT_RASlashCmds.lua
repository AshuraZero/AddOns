tinsert(UISpecialFrames, "CT_RA_SlashCmdFrame");
function CT_RASlashCmd_DisplayDialog()
	table.sort(CT_RA_SlashCmds, function(t1, t2)
		return t1[2] < t2[2]
	end);
	-- Initialize dialog
	local totalHeight = 0;
	for i = 1, 30, 1 do
		local obj = getglobal("CT_RA_SlashCmdFrameScrollFrameCmdsCmd" .. i);
		if ( CT_RA_SlashCmds[i] ) then
			obj.slashCommand = CT_RA_SlashCmds[i][2];
			obj:Show();
			getglobal(obj:GetName() .. "Text"):SetText(CT_RA_SlashCmds[i][2]);
			getglobal(obj:GetName() .. "Description"):SetText(CT_RA_SlashCmds[i][3]);
			if ( strlen(CT_RA_SlashCmds[i][4]) > 0 ) then
				getglobal(obj:GetName() .. "Available"):SetText("快捷命令：|c00FFFFFF" .. CT_RA_SlashCmds[i][4] .. "|r");
				obj:SetHeight(CT_RA_SlashCmds[i][1]+33);
			else
				getglobal(obj:GetName() .. "Available"):SetText("");
				obj:SetHeight(CT_RA_SlashCmds[i][1]+25);
			end
			getglobal(obj:GetName() .. "Description"):SetHeight(CT_RA_SlashCmds[i][1]);
			totalHeight = totalHeight + CT_RA_SlashCmds[i][1];
		else
			obj:Hide();
		end
		if ( i > 1 ) then
			obj:SetPoint("TOPLEFT", "CT_RA_SlashCmdFrameScrollFrameCmdsCmd" .. (i-1), "BOTTOMLEFT");
		end
	end
	CT_RA_SlashCmdFrameScrollFrameCmds:SetHeight(totalHeight);
	ShowUIPanel(CT_RA_SlashCmdFrame);
	CT_RA_SlashCmdFrameScrollFrame:UpdateScrollChildRect();
	
	local minVal, maxVal = CT_RA_SlashCmdFrameScrollFrameScrollBar:GetMinMaxValues();
	if ( maxVal == 0 ) then
		CT_RA_SlashCmdFrameScrollFrameScrollBar:Hide();
	else
		CT_RA_SlashCmdFrameScrollFrameScrollBar:Show();
	end
end

CT_RA_SlashCmds = { };

function CT_RA_RegisterSlashCmd(title, description, height, identifier, func, ...)
	SlashCmdList[identifier] = func;
	local otherCmds = "";
	for i = 1, arg.n, 1 do
		setglobal("SLASH_" .. identifier .. i, arg[i]);
		if ( i > 1 ) then
			if ( strlen(otherCmds) > 0 ) then
				otherCmds = otherCmds .. ", ";
			end
			otherCmds = otherCmds .. arg[i];
		end
	end
	local num = 0;
	while ( string.find(description, "|b.-|eb") ) do
		description = string.gsub(description, "^(.*)|b(.-)|eb(.*)$", "%1|c00FFD100%2|r%3");
		num = num + 1;
		if ( num > 10 ) then
			break;
		end
	end
	tinsert(CT_RA_SlashCmds, { height, title, description, otherCmds });
end


-- Functions used by slash commands
function CT_RA_CheckReady()
	if ( CT_RA_Level >= 1 ) then
		SendChatMessage("<团队助手> " .. UnitName("player") .. "开始进行准备检查。", "RAID");
		CT_RA_AddMessage("CHECKREADY");
		local numValid = 0;
		for i = 1, GetNumRaidMembers(), 1 do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if ( name ~= UnitName("player") and CT_RA_Stats[name] and CT_RA_Stats[name]["Reporting"] and online and CT_RA_Stats[name]["Version"] and CT_RA_Stats[name]["Version"] >= 1.097 ) then
				numValid = numValid + 1;
				CT_RA_Stats[name]["notready"] = 1;
			end
		end
		CT_RA_Print("<团队助手> 正在检查|c00FFFFFF" .. numValid .. "|r 团队成员的准备状态。", 1, 1, 0);
		CT_RA_UpdateFrame.readyTimer = 30;
		CT_RA_UpdateRaidGroup(0);
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或助理才能那么做！", 1, 1, 0);
	end
end

function CT_RA_CheckVote(question)
	if ( CT_RA_Level >= 1 ) then
		SendChatMessage("<团队助手> " .. UnitName("player") .. "发起了一次投票:" .. question, "RAID");
		CT_RA_AddMessage("VOTE " .. question);
		CT_RA_Print("<团队助手> 正在进行投票：|c00FFFFFF" .. question .. "|r", 1, 1, 0);
		CT_RA_UpdateFrame.voteTimer = 30;
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或助理才能那么做！", 1, 1, 0);
	end
end

function CT_RA_CheckRly()
	if ( CT_RA_Level >= 1 ) then
		CT_RA_AddMessage("CHECKRLY");
		local numValid = 0;
		for i = 1, GetNumRaidMembers(), 1 do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if ( name ~= UnitName("player") and CT_RA_Stats[name] and CT_RA_Stats[name]["Reporting"] and online and CT_RA_Stats[name]["Version"] and CT_RA_Stats[name]["Version"] >= 1.097 ) then
				numValid = numValid + 1;
				CT_RA_Stats[name]["rly"] = 1;
			end
		end
		if ( numValid == 1 ) then
			CT_RA_Print("<团队助手> 在|c00FFFFFF" .. numValid .. "|r名团队成员中检查是否准备好。", 1, 1, 0);
		else
			CT_RA_Print("<团队助手> 在|c00FFFFFF" .. numValid .. "|r名团队成员中检查是否准备好。", 1, 1, 0);
		end
		CT_RA_UpdateFrame.rlyTimer = 30;
		CT_RA_UpdateRaidGroup(0);
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或者助理才能那么做！", 1, 1, 0);
	end
end

function CT_RA_Invite(msg)
	if ( not GetGuildInfo("player") ) then
		CT_RA_Print("<团队助手> 你必须在一个公会中才能批量邀请。");
		return;
	end
	if ( ( not CT_RA_Level or CT_RA_Level == 0 ) and GetNumRaidMembers() > 0 ) then
		CT_RA_Print("<团队助手> 你必须是团队领袖或助理才能批量邀请。", 1, 1, 0);
		return;
	end
	local inZone = "";
	if ( CT_RA_ZoneInvite ) then
		inZone = " 在 " .. GetRealZoneText();
	end
	local useless, useless, min, max = string.find(msg, "^(%d+)-(%d+)$");
	min = tonumber(min);
	max = tonumber(max);
	if ( min and max ) then
		if ( min > max ) then
			local temp = min;
			min = max;
			max = temp;
		end
		if ( min < 1 ) then min = 1; end
		if ( max > 60 ) then max = 60; end
		if ( min == max ) then
			SendChatMessage("等级" .. min .. inZone .. " 的玩家将在10秒钟内收到团队邀请，请离开你当前的队伍。", "GUILD");
		else
			SendChatMessage("等级" .. min .. "到" .. max .. inZone .. " 的玩家将在10秒钟内收到团队邀请，请离开你当前的队伍。", "GUILD");
		end
		GuildRoster();
		CT_RA_MinLevel = min;
		CT_RA_MaxLevel = max;
		CT_RA_UpdateFrame.startinviting = 10;
	else
		useless, useless, min = string.find(msg, "^(%d+)$");
		min = tonumber(min);
		if ( min ) then
			if ( min < 1 ) then min = 1; end
			if ( min > 60 ) then min = 60; end
			GuildRoster();
			SendChatMessage("等级" .. min .. inZone .. " 的玩家将在10秒钟内收到团队邀请，请离开你当前的队伍。", "GUILD");
			CT_RA_MinLevel = min;
			CT_RA_MaxLevel = min;
			CT_RA_UpdateFrame.startinviting = 10;
		else
			if ( CT_RA_ZoneInvite ) then
				CT_RA_Print("<团队助手> 语法错误。用法：|c00FFFFFF/razinvite 等级|r 或 |c00FFFFFF/rainvite 最低等级-最高等级|r.", 1, 0.5, 0);
				CT_RA_Print("<团队助手> 这条命令可以批量邀请当前区域公会内的每一个符合等级要求的成员（如果最高等级一项留空，则只邀请指定等级的成员）。", 1, 0.5, 0);
			else
				CT_RA_Print("<团队助手> 语法错误。用法：|c00FFFFFF/rainvite 等级|r 或 |c00FFFFFF/rainvite 最低等级-最高等级|r.", 1, 0.5, 0);
				CT_RA_Print("<团队助手> 这条命令可以批量邀请公会内的每一个符合等级要求的成员（如果最高等级一项留空，则只邀请指定等级的成员）。", 1, 0.5, 0);
			end
		end
	end
end

-- Slash commands
	-- /raslash
CT_RA_RegisterSlashCmd("/rahelp", "显示此对话框。", 15, "RAHELP", CT_RASlashCmd_DisplayDialog, "/rahelp");

	-- /rares
CT_RA_RegisterSlashCmd("/rares", "|b/rares [show/hide]|eb，显示/隐藏复活监视器", 15, "RARES", function(msg)
	if ( msg == "show" ) then
		if ( GetNumRaidMembers() > 0 ) then
			CT_RA_ResFrame:Show();
		end
		CT_RAMenu_Options["temp"]["ShowMonitor"] = 1;
	elseif ( msg == "hide" ) then
		CT_RA_ResFrame:Hide();
		CT_RAMenu_Options["temp"]["ShowMonitor"] = nil;
	else
		CT_RA_Print("<团队助手> 用法：|c00FFFFFF/rares [show/hide]|r - 显示/隐藏复活监视器。", 1, 0.5, 0);
	end
end, "/rares");

	-- /rs
CT_RA_RegisterSlashCmd("/rs", "|b/rs [text]|eb, 对团队中的所有团队助手使用者发送一条信息，该信息将出现在屏幕中央（|b需要团队领袖或者助理权限|eb）。", 30, "RS", function(msg)
	if ( CT_RA_Level >= 1 ) then
		if ( CT_RAMenu_Options["temp"]["SendRARS"] ) then
			SendChatMessage(msg, "RAID");
		end
		CT_RA_AddMessage("MS " .. string.gsub(msg, "%%[tT]", UnitName("target") or TARGET_TOKEN_NOT_FOUND));
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或助理才能那么做！", 1, 1, 0);
	end
end, "/rs");

	-- /raupdate
CT_RA_RegisterSlashCmd("/raupdate", "更新团队状态（|b需要团队领袖或者助理权限|eb）。", 15, "RAUPDATE", function()
	if ( CT_RA_Level >= 1 ) then
		CT_RA_AddMessage("SR");
		CT_RA_Print("<团队助手> 团队状态已更新。", 1, 0.5, 0);
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或者助理才能那么做！", 1, 0.5, 0);
	end
end, "/raupdate", "/raupd");

	-- /rakeyword
CT_RA_RegisterSlashCmd("/rakeyword", "自动邀请对你发送了指定关键字的玩家。", 15, "RAKEYWORD", function(msg)
	if ( msg == "off" ) then
		CT_RAMenu_Options["temp"]["KeyWord"] = nil;
		CT_RA_Print("<团队助手> 关键字邀请已被关闭。", 1, 0.5, 0);
	elseif ( msg == "" ) then
		local kw = CT_RAMenu_Options["temp"]["KeyWord"];
		if ( kw ) then
			CT_RA_Print("<团队助手> 邀请关键字被设定为 '|c00FFFFFF" .. kw .. "|r'。使用 |c00FFFFFF/rakeyword off|r 来关闭关键字邀请功能。", 1, 0.5, 0);
		else
			CT_RA_Print("<团队助手> 没有设置自动邀请的关键字。", 1, 0.5, 0);
		end
	else
		CT_RAMenu_Options["temp"]["KeyWord"] = msg;
		CT_RA_Print("<团队助手> 邀请关键字被设定为 '|c00FFFFFF" .. msg .. "|r'。使用 |c00FFFFFF/rakeyword off|r 来关闭关键字邀请功能。", 1, 0.5, 0);
	end
end, "/rakeyword", "/rakw");

	-- /radisband
CT_RA_RegisterSlashCmd("/radisband", "解散团队（|b需要团队领袖或者助理权限|eb）", 15, "RADISBAND", function(msg)
	if ( CT_RA_Level and CT_RA_Level >= 1 ) then
		CT_RA_Print("<团队助手> 正在解散团队……", 1, 0.5, 0);
		SendChatMessage("<团队助手> 正在根据" .. UnitName("player") .. "的要求解散团队。", "RAID");
		for i = 1, GetNumRaidMembers(), 1 do
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if ( online and rank <= CT_RA_Level and name ~= UnitName("player") ) then
				UninviteByName(name);
			end
		end
		CT_RA_AddMessage("DB");
		LeaveParty();
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或助理才能那么做！", 1, 0.5, 0);
	end
end, "/radisband");

	-- /rashow
CT_RA_RegisterSlashCmd("/rashow", "|b/rashow|eb 或 |b/rashow all|eb, 显示隐藏的或全部的团队窗口。", 15, "RASHOW", function(msg)
	if ( msg == "all" ) then
		CT_RAMenu_Options["temp"]["ShowGroups"] = { 1, 1, 1, 1, 1, 1, 1, 1 };
		CT_RACheckAllGroups:SetChecked(1);
		for i = 1, 8, 1 do
			getglobal("CT_RAOptionsGroupCB" .. i):SetChecked(1);
		end
	else
		if ( not CT_RAMenu_Options["temp"]["HiddenGroups"] ) then return; end
		CT_RAMenu_Options["temp"]["ShowGroups"] = CT_RAMenu_Options["temp"]["HiddenGroups"];
		CT_RAMenu_Options["temp"]["HiddenGroups"] = nil;
		local num = 0;
		for k, v in CT_RAMenu_Options["temp"]["ShowGroups"] do
			num = num + 1;
			getglobal("CT_RAOptionsGroupCB" .. k):SetChecked(1);
		end
		if ( num > 0 ) then
			CT_RACheckAllGroups:SetChecked(1);
		else
			CT_RACheckAllGroups:SetChecked(nil);
		end
	end
	CT_RA_UpdateRaidGroup(0);
end, "/rashow");

	-- /rahide
CT_RA_RegisterSlashCmd("/rahide", "隐藏所有团队窗口。", 15, "RAHIDE", function()
	CT_RAMenu_Options["temp"]["HiddenGroups"] = CT_RAMenu_Options["temp"]["ShowGroups"];
	CT_RAMenu_Options["temp"]["ShowGroups"] = { };
	CT_RACheckAllGroups:SetChecked(nil);
	for i = 1, 8, 1 do
		getglobal("CT_RAOptionsGroupCB" .. i):SetChecked(nil);
	end
	CT_RA_UpdateRaidGroup(0);
end, "/rahide");

	-- /raoptions
CT_RA_RegisterSlashCmd("/raoptions", "显示设置窗口。", 20, "RAOPTIONS", function(msg)
	CT_RAMenuFrame:Show();
end, "/raoptions");

	-- /raready
CT_RA_RegisterSlashCmd("/raready", "对团队中的每个团队助手使用者进行准备就绪检查（|b需要团队领袖或者助理权限|eb）", 30, "RAREADY", CT_RA_CheckReady, "/raready", "/rar");

	-- /readycheck
CT_RA_RegisterSlashCmd("/readycheck", "对每个团队成者进行准备就位检查（|b需要团队领袖或者助理权限|eb）", 30, "READYCHECK", DoReadyCheck, "/readycheck", "/rc");

	-- /ravote
CT_RA_RegisterSlashCmd("/ravote", "|b/ravote [question]|eb - 进行一次投票，询问团队成员关于某问题的意见。结果30秒后厚在团队频道公布。", 30, "RAVOTE", CT_RA_CheckVote, "/ravote");

	-- /rarly
CT_RA_RegisterSlashCmd("/rarly", "进行一次战斗准备检查，询问所有CTRA使用者是否战斗准备（|b需要团队领袖或者助理权限|eb）。", 30, "RARLY", CT_RA_CheckRly, "/rarly", "/rly");

	-- /rainvite
CT_RA_RegisterSlashCmd("/rainvite", "|b/rainvite 最低等级-最高等级|eb 或 |b/rainvite 级别|eb 这条命令可以批量邀请公会内的每一个符合等级要求的成员。", 30, "RAINVITE", function(msg)
	CT_RA_ZoneInvite = nil;
	CT_RA_Invite(msg);
end, "/rainvite", "/rainv");

	-- /razinvite
CT_RA_RegisterSlashCmd("/razinvite", "|b/razinvite 最低等级-最高等级|eb 或 |b/rainvite 级别|eb 这条命令可以批量邀请当前区域公会内的每一个符合等级要求的成员。", 30, "RAZINVITE", function(msg)
	CT_RA_ZoneInvite = 1;
	CT_RA_Invite(msg);
end, "/razinvite", "/razinv");

	-- /radur
CT_RA_RegisterSlashCmd("/radur", "进行耐久度检查，显示每个团队助手成员的耐久度百分比（|b需要团队领袖或者助理权限|eb）。", 30, "RADUR", function()
	if ( CT_RA_Level >= 1 ) then
		CT_RADurability_Shown = { };
		CT_RADurability_Sorting = {
			["curr"] = 4,
			[3] = { "a", "a" },
			[4] = { "a", "a" }
		};
		CT_RA_DurabilityFrame.type = "RADUR";
		CT_RA_DurabilityFrame.arg = nil;
		CT_RADurability_Update();
		ShowUIPanel(CT_RA_DurabilityFrame);
		CT_RA_DurabilityFrameValueTab:SetText("耐久度百分比");
		CT_RA_DurabilityFrameValueTab:Show();
		for i = 1, 5, 1 do
			getglobal("CT_RA_DurabilityFrameResistTab" .. i):Hide();
		end
		CT_RA_DurabilityFrameTitle:SetText("耐久度检查");
		CT_RA_AddMessage("DURC");
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或者助理才能那么做！", 1, 0.5, 0);
	end
end, "/radur");

	-- /rareg
CT_RA_RegisterSlashCmd("/rareg", "进行施法材料检查，显示每个团队助手成员的施法材料数量（|b需要团队领袖或者助理权限|eb）。", 30, "RAREG", function()
	if ( CT_RA_Level >= 1 ) then
		CT_RADurability_Shown = { };
		CT_RADurability_Sorting = {
			["curr"] = 3,
			[3] = { "a", "a" },
			[4] = { "a", "a" }
		};
		CT_RA_DurabilityFrame.type = "RAREG";
		CT_RA_DurabilityFrame.arg = nil;
		CT_RA_DurabilityFrameValueTab:SetText("施法材料数量");
		CT_RA_DurabilityFrameValueTab:Show();
		for i = 1, 5, 1 do
			getglobal("CT_RA_DurabilityFrameResistTab" .. i):Hide();
		end
		CT_RADurability_Update();
		ShowUIPanel(CT_RA_DurabilityFrame);
		CT_RA_DurabilityFrameTitle:SetText("施法材料检查");
		CT_RA_AddMessage("REAC");
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或者助理才能那么做！", 1, 0.5, 0);
	end
end, "/rareg");


	-- /raitem
CT_RA_RegisterSlashCmd("/raitem", "|b/raitem 物品名称|eb 或 |b/raitem [物品链接]|eb；允许你输入物品名称或者使用shift+点击物品来看团队中所有拥有某个物品的成员。（|b/raitem 水之精萃|eb 非常有用，查看谁是准备好了来熔火之心的）。", 45, "RAITEM", function(itemName)
	if ( CT_RA_Level >= 1 ) then
		if ( not itemName ) then
			CT_RA_Print("<团队助手> 用法：|c00FFFFFF/raitem 物品名称|r  注意：你也可以使用物品链接。", 1, 0.5, 0);
			return;
		end
		local _, _, linkName = string.find(itemName, "%[(.+)%]");
		if ( linkName ) then
			itemName = linkName;
		end
		CT_RADurability_Shown = { };
		CT_RADurability_Sorting = {
			["curr"] = 4,
			[3] = { "a", "a" },
			[4] = { "a", "a" }
		};
		CT_RA_DurabilityFrame.type = "RAITEM";
		CT_RA_DurabilityFrame.arg = itemName;
		CT_RA_DurabilityFrameValueTab:SetText("物品数量");
		CT_RA_DurabilityFrameValueTab:Show();
		for i = 1, 5, 1 do
			getglobal("CT_RA_DurabilityFrameResistTab" .. i):Hide();
		end
		CT_RADurability_Update();
		ShowUIPanel(CT_RA_DurabilityFrame);
		CT_RA_DurabilityFrameTitle:SetText("物品检查");
		CT_RA_AddMessage("ITMC " .. itemName);
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或者助理才能那么做！", 1, 0.5, 0);
	end
end, "/raitem");

	-- /raversion
CT_RA_RegisterSlashCmd("/raversion", "进行一次版本检查，显示每个团员的CTRA版本号。", 15, "RAVERSION", function()
		CT_RADurability_Shown = { };
		CT_RADurability_Sorting = {
			["curr"] = 4,
			[3] = { "a", "b" },
			[4] = { "a", "b" }
		};
		CT_RA_DurabilityFrame.type = "RAVERSION";
		CT_RA_DurabilityFrameValueTab:SetText("版本");
		CT_RA_DurabilityFrameValueTab:Show();
		for i = 1, 5, 1 do
			getglobal("CT_RA_DurabilityFrameResistTab" .. i):Hide();
		end
		CT_RADurability_Update();
		ShowUIPanel(CT_RA_DurabilityFrame);
		CT_RA_DurabilityFrameTitle:SetText("版本检查");
		for i = 1, GetNumRaidMembers(), 1 do
			local name = UnitName("raid" .. i);
			if ( CT_RA_Stats[name] and CT_RA_Stats[name]["Version"] ) then
				local name, rank, subgroup, level, class, fileName = GetRaidRosterInfo(i);
				CT_RADurability_Add(name, CT_RA_Stats[name]["Version"], fileName, CT_RA_Stats[name]["Version"]);
			else
				local name, rank, subgroup, level, class, fileName = GetRaidRosterInfo(i);
				CT_RADurability_Add(name, "|c00666666没有找到团队助手|r", fileName, 0);
			end
		end
end, "/raversion", "/raver");

	-- /raresist (Thanks Sudo!)
CT_RA_RegisterSlashCmd("/raresist", "进行抗性检查，显示每个团队助手成员的魔法抗性（|b需要团队领袖或者助理权限|eb）。", 30, "RARST", function(msg)
	if ( CT_RA_Level >= 1 ) then
		CT_RADurability_Shown = { };
		CT_RADurability_Sorting = {
			["curr"] = 3,
			[3] = { "a", "a" },
			[4] = { "b", "b" },
			[5] = { "b", "b" },
			[6] = { "b", "b" },
			[7] = { "b", "b" },
			[8] = { "b", "b" },
		};
		
		CT_RA_DurabilityFrame.type = "RARST";
		CT_RA_DurabilityFrameValueTab:Hide();
		for i = 1, 5, 1 do
			getglobal("CT_RA_DurabilityFrameResistTab" .. i):Show();
		end
		CT_RADurability_Update();
		ShowUIPanel(CT_RA_DurabilityFrame);
		CT_RA_DurabilityFrameTitle:SetText("抗性检查");
		CT_RA_AddMessage("RSTC");
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或者助理才能那么做！", 1, 0.5, 0);
	end
end, "/raresist", "/raresists");

	-- /razone
CT_RA_RegisterSlashCmd("/razone", "进行区域检查，显示不在当前区域的团队助手成员。", 30, "RAZONE", function(msg)
	CT_RADurability_Shown = { };
	CT_RADurability_Sorting = {
		["curr"] = 3,
		[3] = { "a", "a" },
		[4] = { "a", "a" }
	};
	CT_RA_DurabilityFrame.type = "RAZONE";
	CT_RA_DurabilityFrameValueTab:Show();
	for i = 1, 5, 1 do
		getglobal("CT_RA_DurabilityFrameResistTab" .. i):Hide();
	end
	CT_RADurability_Update();
	ShowUIPanel(CT_RA_DurabilityFrame);
	CT_RA_DurabilityFrameTitle:SetText("区域检查");
	CT_RA_DurabilityFrameValueTab:SetText("区域名字");
	
	local name, rank, subgroup, level, class, fileName, zone;
	for i = 1, GetNumRaidMembers(), 1 do
		name, rank, subgroup, level, class, fileName, zone = GetRaidRosterInfo(i);
		if ( name ~= UnitName("player") and zone and zone ~= "" and zone ~= "离线" and zone ~= GetRealZoneText() ) then
			CT_RADurability_Add(name, zone, fileName);
		end
	end
end, "/razone");

	-- /raquiet (by Angarth)
CT_RA_RegisterSlashCmd("/raquiet", "当队长讲解时实行团队频道禁言（|b需要团队领袖或者助理权限|eb）。", 15, "RASQUELCH", function()
	if ( CT_RA_Level >= 1 ) then
		if ( CT_RA_Squelch > 0 ) then
			SendChatMessage("<团队助手> 禁言模式结束。", "RAID");
			CT_RA_Print("<团队助手> 禁言模式取消。", 1, 0.5, 0);
			CT_RA_Squelch = 0;
		else
			SendChatMessage("<团队助手> 禁言模式，禁止发言。", "RAID");
			CT_RA_Print("<团队助手> 禁言模式启用。", 1, 0.5, 0);
			CT_RA_Squelch = 5*60;
		end
	else
		CT_RA_Print("<团队助手> 你必须是团队领袖或者助理才能那么做！", 1, 0.5, 0);
	end
end, "/raquiet", "/rasquelch");

oldSendChatMessage = SendChatMessage;
function SendChatMessage(msg, type, language, target)
	if ( type == "RAID" ) then
		if ( CT_RA_Squelch > 0 and CT_RA_Level < 1 ) then
			CT_RA_Print("<团队助手> 现在你不能在团队频道发言（禁言模式启用）。", 1, 0.5, 0);
			return;
		end
	end
	oldSendChatMessage(msg, type, language, target);
end