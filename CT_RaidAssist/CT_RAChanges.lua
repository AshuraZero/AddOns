tinsert(UISpecialFrames, "CT_RA_ChangelogFrame");
CT_RACHANGES_HEIGHT = 500;
function CT_RAChanges_DisplayDialog()
	CT_RA_ChangelogFrame:SetHeight(CT_RACHANGES_HEIGHT+25);
	-- Initialize dialog
		-- Set title
	CT_RA_ChangelogFrameTitle:SetText(CT_RA_Changes["title"]);
	
		-- Show sections
	local section, totalHeight = 1, 0;
	while ( CT_RA_Changes["section" .. section] ) do
		local objSection = getglobal("CT_RA_ChangelogFrameScrollFrameSection" .. section);
		local part, partHeights = 1, 0;
		
			-- Show section
		objSection:Show();
		
			-- Set section title
		getglobal(objSection:GetName() .. "Title"):SetText(CT_RA_Changes["section" .. section]["title"]);
		
			-- Show parts
		while ( CT_RA_Changes["section" .. section][part] ) do
			local objPart = getglobal("CT_RA_ChangelogFrameScrollFrameSection" .. section .. "Part" .. part);
			
				-- Show part
			objPart:Show();
			
				-- Set part stuff
			getglobal(objPart:GetName() .. "Text"):SetText(CT_RA_Changes["section" .. section][part][2]);
			getglobal(objPart:GetName() .. "Text"):SetHeight(CT_RA_Changes["section" .. section][part][1]);
			objPart:SetHeight(CT_RA_Changes["section" .. section][part][1]);
			partHeights = partHeights + CT_RA_Changes["section" .. section][part][1];
			part = part + 1;
		end
		local addedHeight = ( CT_RA_Changes["section" .. section]["addedHeight"] or 0);
		objSection:SetHeight(partHeights+35+addedHeight);
		totalHeight = totalHeight + partHeights+35+addedHeight;
		section = section + 1;
	end
	CT_RA_ChangelogFrameScrollFrameSection:SetHeight(totalHeight);
	ShowUIPanel(CT_RA_ChangelogFrame);
	CT_RA_ChangelogFrameScrollFrame:UpdateScrollChildRect();
	local minVal, maxVal = CT_RA_ChangelogFrameScrollFrameScrollBar:GetMinMaxValues();
	if ( maxVal == 0 ) then
		CT_RA_ChangelogFrameScrollFrameScrollBar:Hide();
	else
		CT_RA_ChangelogFrameScrollFrameScrollBar:Show();
	end
	CT_RA_ChangelogFrameScrollFrame:SetHeight(CT_RACHANGES_HEIGHT-75);
end

-- Add slash command
CT_RA_RegisterSlashCmd("/ralog", "显示此版本的更新记录。", 15, "RALOG", CT_RAChanges_DisplayDialog, "/ralog");

CT_RA_Changes = {
	["title"] = "团队助手 v1.5！",
	
	["section1"] = {
		["title"] = "一般",
		{ 60, "|g注意：你必须退出游戏安装团队助手1.5。另外，如果你要使用首领技能提示你需要额外的首领模块（从http://www.ctmod.net下载）。|eg" },
		{ 90, "团队助手现在采用了一种新格式。插件包含两个目录，|bCT_RaidAssist|eb和|bCT_RABossMods|eb。这表示首领模块成为了一个独立的插件，如果你需要它提供的功能的话得额外下载。直接覆盖你原有的目录不会导致错误。首领模块是依赖于团队助手来工作的。" },
		{ 60, "另一个大的改变是团队助手现在会取代暴雪的团队界面，这是由暴雪开发团队建议和推荐的，如果安装了团队助手，缺省的团队界面将不会被载入或在后台运行。这应该能提升整体性能。" }
	},
	["section2"] = {
		["title"] = "主要增加",
		["addedHeight"] = 30,
		{ 175, "加入|b玩家目标|eb。类似于主坦克目标不过是客户端决定。任何人都可以设置最多10个玩家目标，只能由你自己看到。玩家目标和主坦克目标稍有不同，更接近于暴雪自己的界面。设置一个玩家目标将增加一个显示他们生命/法力的框，就像一个普通的团队助手界面。，但是如果你启用了显示玩家目标的目标，你将看到一个扩展的框（跟主坦克目标类似），在其右边显示玩家的目标。\n\n|b这意味着任何人（不止队长）都能设置你所选择的人的目标。你只需要简单的在团队助手页卡右键点击你所选的玩家来设置玩家目标的目标。|eb" },
		{ 45, "加入一个选项，|b水平排序队伍|eb。这个选项可以从一般选项页面中找到。" },
		{ 30, "加入|b向上扩展队伍|eb选项，可以让你把队伍放在屏幕底部向上扩展。" },
		{ 45, "加入|b非团队时预先调整队伍|eb的功能。要载入虚拟队伍，在一般选项页面的排序下拉列表中选择“虚拟”。" },
		{ 45, "在团队页卡加入|b自动设置分配方式|eb选项。在组建团队时将自动设置你所选择的分配方式。" },
		{ 30, "加入队长|b自动提升|eb玩家权限的功能。当你是队长时，在团队页卡中右键点击他们的名字即可。" },
		{ 30, "加入|b去除空隙|eb的选项使边界隐藏时队伍框紧凑。" },
		{ 30, "加入|b坦克死亡通告|eb。启用此选项后某个主坦克死亡时将发出警报。" }
	},
	["section3"] = {
		["title"] = "次要增加",
		["addedHeight"] = 25,
		{ 75, "加入|b/ravote|eb命令。|b/ravote|eb允许你在团队中进行一次投票。使用|b/ravote 问题？|eb将把你的问题发送给整个团队。例如/ravote 你带了奥妮克希亚鳞片披风吗？ 团队成员将看到“是”和“否”的选项，结果将显示为：是、否或者没有投票。" },
		{ 45, "加入|b/raquiet|eb或|b/rasquelch|eb命令。队长可以使用|b/raquiet|eb禁止在团队频道中聊天。此选项将在5分钟后失效，或者由队长手动取消。" },
		{ 60, "加入队长文字颜色选项。此选项将改变队长在团队频道中名字的颜色，使他们的消息更醒目。缺省开启，你可以选择颜色或者从“其他选项”中取消此功能。" },
		{ 30, "对于那些没有安装团队助手的队员，|b/raver|eb命令的结果增加显示“没有找到团队助手”。" },
		{ 30, "加入一个取消法力节约的选项，使得某些战斗更容易的启用/禁用法力节约，例如堕落的瓦拉斯塔兹。" },
		{ 45, "加入一个选项允许你设置可见的主坦克数量，此选项在一般选项页面中。" },
		{ 30, "在团队助手窗口中加入消息提示谁绑定了灵魂石或者复生可用。" },
		{ 15, "加入将埃博诺克之影发送给/rs的选项。" }
	},
	["section4"] = {
		["title"] = "改变和更新",
		["addedHeight"] = 15,
		{ 45, "改变了复活监视器的外观。文字信息小有改动，“无人正在复活”的字样被去除。" },
		{ 30, "更新了哈卡首领模块，由于游戏本身的改动现在生命吸取计时器改为45秒。" },
		{ 30, "增强了法力节约检查，现在应该工作得更稳定。" },
		{ 20, "增强了复活监视器。" },
		{ 20, "增强了克诺玛古斯首领模块。" },
		{ 20, "改变主坦克目标颜色以表示其是友好还是敌对。" }
	},
	["section5"] = {
		["title"] = "修正",
		{ 30, "修正了一个输入错误，法力节约按百分比的时候说明是设置成0为禁用，而实际上是100%。" },
		{ 20, "修正了法语版的德鲁伊增益魔法翻译错误。" },
		{ 30, "修正一个关于选项设置的错误：当你登录游戏会显示“未保存”。" },
		{ 20, "修正一个CT_RATarget函数的问题。" },
		{ 30, "修正一个不常见的问题：有些用户反映当几个主坦克相同时目标管理器没有将该目标显示为红色。" },
		{ 30, "修正一个错误：不显示主坦克目标法力回复除非目标的生命值也将了下来。" },
		{ 30, "修正一个错误：|b/raready|eb在显示哪些人未准备就绪或者暂离以后提示“所有人都准备好了”。" },
		{ 30, "|b/raresist|eb结果窗口的滚动条做了修改，现在不会挡住奥术抗性的显示。" },
		{ 30, "修正一个错误：当你断线后重新登录上来或者加入一个已设置好主坦克的团队时主坦克目标窗口不显示。" },
		{ 30, "修正法语和德语版的各种翻译问题。" }
	}
};
for k, v in CT_RA_Changes do
	if ( type(v) == "table" ) then
		for key, val in v do
			if ( type(val) == "table" ) then
				while ( string.find(val[2], "|[bg].-|e[bg]") ) do
					CT_RA_Changes[k][key][2] = string.gsub(val[2], "^(.*)|b(.-)|eb(.*)$", "%1|c00FFD100%2|r%3");
					CT_RA_Changes[k][key][2] = string.gsub(CT_RA_Changes[k][key][2], "^(.*)|g(.-)|eg(.*)$", "%1|c00FF0000%2|r%3");
				end
			end
		end
	end
end