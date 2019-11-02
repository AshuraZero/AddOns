IEPrefix = "#IEDKP#";

SlashCmdList["MerDKP"] = function() MerDKPFrame:Show()  end
SLASH_MerDKP1 = "/merdkp"

if Mer_DKP_Table then
	MerDKP_Table = {}
	for k, v in pairs(Mer_DKP_Table) do
		v.title = k
		v.key = k
		tinsert(MerDKP_Table, v)
	end
end


--region variable

MerDKP = {}

MerDKP.db = {}

MerDKP.opt = {
    rp          = "ie", --查询指令
    mydkp       = "iedkp", --个人所有DKP查询指令
    rplist      = "ielist", --指令查询命令
    prefix      = "#IEDKP#", --密语发送前缀

    enabled     = true, --是否开启密语
    rpexact     = nil, --精确查询or模糊查询
    CurrentRaid = nil, --当前团队or所有DKP
    SaveDkplist = nil, --保存记录到本地
    ConfirmSend = nil, --发送前确认
    HideWhisper = true, --是否显示|隐藏查询的纪录
    IgnoreOffline = nil, --不显示离线成员
    InitClasses = nil, --载入后 检查职业并分类

    Datafrom    = 1, -- 数据来源 1-website 2-local 3-publicnote 4-officernote
    Outputmax   = 20, --一次性发送的最多条数
    Minimap     = 360, --小地图图标位置 0-隐藏
}

MerDKP.tmp = {
    id          = 0, --GUI显示的DKP id 
    DkpMin      = -9000, --显示的最小dkp分数,太低的就不显示
    total       = 0, --列表总数
    channel     = "RAID", --发送的频道
    sortkey     = "dkp", --排序关键字-显示
    sortway     = "desc", --排序方式-显示
    rp_word     = {}, --密语关键字 字段表
    rp_class    = {}, --密语职业 字段表
    raidmembers = {}, --团队成员表
    LIST        = {}, --显示列表
    list_class  = {},--显示职业
}

MerDKP.tmp.tbc = {
    {text = "布甲", "牧师","法师","术士",},
    {text = "皮甲", "潜行者","德鲁伊",},
    {text = "锁甲", "猎人","萨满祭司",},
    {text = "板甲", "战士","圣骑士",},
    {text = "所有职业", "圣骑士","战士","牧师","法师","萨满祭司","德鲁伊","潜行者","猎人","术士",},
}

MerDKP.tmp.classes = {
    ["战士"]  = { hex = "|cffA39402", r = 0.78, g = 0.61, b = 0.43 },
    ["法师"]  = { hex = "|cff00FFFF", r = 0.41, g = 0.85, b = 0.94 },
    ["潜行者"]     = { hex = "|cffFFFF00", r = 0.95, g = 0.96, b = 0.41 },
    ["德鲁伊"]     = { hex = "|cffFF8A00", r = 0.95, g = 0.49, b = 0.04 },
    ["猎人"]  = { hex = "|cff00FF00", r = 0.67, g = 0.83, b = 0.45 },
    ["萨满祭司"]    = { hex = "|cff2459EE", r = 0.00, g = 0.00, b = 0.99 },
    ["牧师"]  = { hex = "|cffDFDFDF", r = 0.95, g = 0.95, b = 0.95 },
    ["术士"]  = { hex = "|cff8D54FB", r = 0.58, g = 0.51, b = 0.79 },
    ["圣骑士"]     = { hex = "|cffFF71A8", r = 0.96, g = 0.55, b = 0.73 },
}

MerDKP.tmp.initclass = {
    ["战士"]  = "战士",
    ["法师"]  = "法师",
    ["潜行者"]     = "潜行者",
    ["德鲁伊"]     = "德鲁伊",
    ["猎人"]  = "猎人",
    ["萨满祭司"]    = "萨满祭司",
    ["牧师"]  = "牧师",
    ["术士"]  = "术士",
    ["圣骑士"]     = "圣骑士",
    ---自己添加要初始化的职业,如 ["MS"] = "牧师",
}

MerDKP.loc = {
    leftText = "(.+)离开了团队",
    totalText = "当前显示成员 (|cff3FFF3F%d/%d|r)",
    sendText = "确定发送?",
    bateditText = "请输入批量修改的分数",
    guildrosterdkp = "数据将重新读取，确认?",

    MerDKPFrameTab1 = "显示",
    MerDKPFrameTab2 = "设置",
    MerDKPFrameListBatEditButtonText = "批量修改",
    MerDKPFrameListWhisperButton = "群体密语",
    MerDKPFrameListRaidCheckButtonText = "显示当前团队",
}

MerDKP.DROPMENU = {
    channel ={
        { text = "团队频道", value = "RAID", func = DropDownChannel,},
        { text = "普通频道", value = "SAY", func = DropDownChannel,},
        { text = "公会频道", value = "GUILD", func = DropDownChannel,},
        { text = "小队频道", value = "PARTY", func = DropDownChannel,},
        { text = "官员频道", value = "OFFICER", func = DropDownChannel,},
    },
    dkpscore = {
        { text = "所有", value = -5000, func = DropDownMinDKP,},
        { text = "正分", value = 0.01, func = DropDownMinDKP,},
        { text = "10分", value = 10, func = DropDownMinDKP,},
        { text = "20分", value = 20, func = DropDownMinDKP,},
        { text = "30分", value = 30, func = DropDownMinDKP,},
        { text = "40分", value = 40, func = DropDownMinDKP,},
        { text = "50分", value = 50, func = DropDownMinDKP,},
        { text = "60分", value = 60, func = DropDownMinDKP,},
        { text = "80分", value = 80, func = DropDownMinDKP,},
        { text = "100分", value = 100, func = DropDownMinDKP,},
    },
    member = {
        { text = "%1", isTitle = true, },
        { text = "密语通告", value = "WHISPER", func = DropDownMember,},
        { text = "团队通告", value = "RAID", func = DropDownMember,},
        { text = "小队通告", value = "PARTY", func = DropDownMember,},
        { text = "公会通告", value = "GUILD", func = DropDownMember,},
        { text = "普通频道", value = "SAY", func = DropDownMember,},
    --  { text = "修改", value = "CLASS", func = function(id,name,dkp) MerDKP_OpenPopupFrame("edit", MerDKP.tmp.id, name, this.value, dkp) end, },
      --  { text = "刪除", value = "CLASS", func = function(id,name,dkp) MerDKP_OpenPopupFrame("delete", MerDKP.tmp.id, name, this.value, dkp, "确定刪除?") end, },
        { text = "取消", func = function(self) HideDropDownMenu(1) end, },
    },
    checkbutton = {
        { text = "开启密语查询", key = "enabled", tooltipText = "开启后，别人可以通过发送特定的密语命令来向你查询分数",},
        { text = "隐藏查询的记录", key = "HideWhisper", tooltipText = "隐藏查询的有关聊天记录，让你免受刷频的烦恼",},
        { text = "仅查询当前团员", key = "CurrentRaid", tooltipText = "只回复当前团队内人员的分数，非团队成员的分数将不回复",},
        { text = "开启精确查询", key = "rpexact", tooltipText = "密语查询时,只有100%符合的结果才回复给他",},
        { text = "不显示离线团员", key = "IgnoreOffline", tooltipText = "离线的团队成员将不显示在你的列表中",},
        { text = "发送前提示确认", key = "ConfirmSend", tooltipText = "发送前将弹出一个确认框",},
        { text = "保存分数到本地", key = "SaveDkplist", tooltipText = "保存DKP分数到本地SavedVariables",},
        { text = "载入时检测职业", key = "InitClasses", tooltipText = "加载插件后,自动检测职业",},
    },
    slider = {
        datafrom = {"网站系统","本地缓存","公共注释","官员注释"},
        { text = "设置最大发送数目", Min = 1, Max = 100, Step = 1, key = "Outputmax",
          tooltipText = "设置一次发送的最大数目,以免发送太多断线",
          Onshow = function(self) self:SetValue(MerDKP.opt.Outputmax) end,
          OnValueChang = function(self)
            getglobal(self:GetName().."Value"):SetText(self:GetValue())
            MerDKP.opt.Outputmax = self:GetValue()
          end,
        },
        --[[{ text = "迷你地图按钮位置", Min = 0, Max = 360, Step = 1, key = "Minimap",
          tooltipText = "设置迷你地图按钮的位置",
          Onshow = function(self) self:SetValue(MerDKP.opt.Minimap) end,
          OnValueChang = function(self)
            getglobal(this:GetName().."Value"):SetText(self:GetValue())
            --MerDKP.opt.Minimap = self:GetValue()
            if MerDKP.opt.Minimap == 0 then
                MerDKPMinimapButton:Hide()
            else
                MerDKPMinimapButton:Show()
                MerDKPMinimapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 55 - (84 * cos(MerDKP.opt.Minimap)), (84 * sin(MerDKP.opt.Minimap)) - 55)
            end
          end,
        },--]]
        { text = "数据信息来源设置", Min = 1, Max = 4, Step = 1, key = "Datafrom",
          tooltipText = "设置数据来源，网站:本地计算机:公共注释:官员注释",
          Onshow = function(self) self:SetValue(MerDKP.opt.Datafrom) end,
          OnValueChang = function(self)
            getglobal(self:GetName().."Value"):SetText(MerDKP.DROPMENU.slider.datafrom[self:GetValue()])
            MerDKP.opt.Datafrom = self:GetValue()
          end,
        },
    },
}

MerDKP.tmp.SubFrames = {
    "MerDKPFrameList",
    "MerDKPFrameOption",
}

gbkToBig5Table = {
    ["盗贼"]  = "潜行者",    
}

--end region variable


--region event

function MerDKP_OnLoad(this)
        this:RegisterEvent("ADDON_LOADED");
        this:RegisterEvent("PLAYER_LOGOUT");
        this:RegisterEvent("CHAT_MSG_WHISPER");
        this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
end

function MerDKP_OnEvent(this, event, ...)
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9= ...;

    if ( event == "ADDON_LOADED" ) then
		MerDKP_ADDON_LOADED(arg1)
	end

	if ( event == "PLAYER_LOGOUT" ) then 
		MerDKP_PLAYER_LOGOUT();
	end

    if( event == "CHAT_MSG_WHISPER" ) then --Reviewed
        MerDKP_CHAT_MSG_WHISPER(arg1, arg2);
    end

    if event == "CHAT_MSG_CHANNEL_NOTICE" then
		--MerDKP_CHAT_MSG_CHANNEL_NOTICE(arg1, arg8, arg9);
        return
    end


	if ( event == "CHAT_MSG_SYSTEM" ) then
		MerDKP_CHAT_MSG_SYSTEM(arg1);
	end

    if ( event == "GROUP_ROSTER_UPDATE" ) then 
		MerDKP_GROUP_ROSTER_UPDATE();

	end
end

function MerDKP_ADDON_LOADED(arg1)
    if (arg1 == "IEDKP") then   
        MerDKPDB = MerDKPDB or {}
        MerDKP.opt = MerDKPDB.opt or MerDKP.opt
        MerDKP.opt = {
            rp          = "ie", --查询指令
            mydkp       = "iedkp", --个人所有DKP查询指令
            rplist      = "ielist", --指令查询命令
            prefix      = "#IEDKP#", --密语发送前缀

            enabled     = true, --是否开启密语
            rpexact     = nil, --精确查询or模糊查询
            CurrentRaid = nil, --当前团队or所有DKP
            SaveDkplist = nil, --保存记录到本地
            ConfirmSend = nil, --发送前确认
            HideWhisper = true, --是否显示|隐藏查询的纪录
            IgnoreOffline = nil, --不显示离线成员
            InitClasses = nil, --载入后 检查职业并分类

            Datafrom    = 1, -- 数据来源 1-website 2-local 3-publicnote 4-officernote
            Outputmax   = 20, --一次性发送的最多条数
            Minimap     = 360, --小地图图标位置 0-隐藏
        }   
        gbkToBig5();
        MerDKP_InitDataFrom()
        MerDKP_OnVarsLoaded()
    end
end

function MerDKP_OnVarsLoaded()
    for k, v in ipairs(MerDKP.DROPMENU.checkbutton) do
        getglobal("MerDKPFrameOptionCheckButtons"..k):Show()
        getglobal("MerDKPFrameOptionCheckButtons"..k.."Text"):SetText(v.text)
        getglobal("MerDKPFrameOptionCheckButtons"..k).tooltipText = v.tooltipText
        getglobal("MerDKPFrameOptionCheckButtons"..k).key = v.key
        if MerDKP.opt[v.key] then
            getglobal("MerDKPFrameOptionCheckButtons"..k):SetChecked(1)
        end
    end
    for k, v in ipairs(MerDKP.DROPMENU.slider) do
        getglobal("MerDKPFrameOptionSliders"..k):Show()
        getglobal("MerDKPFrameOptionSliders"..k.."Text"):SetText(v.text)
        getglobal("MerDKPFrameOptionSliders"..k).tooltipText = v.tooltipText
        getglobal("MerDKPFrameOptionSliders"..k).key = v.key
        getglobal("MerDKPFrameOptionSliders"..k):SetMinMaxValues(v.Min, v.Max)
        getglobal("MerDKPFrameOptionSliders"..k):SetValueStep(v.Step)
        getglobal("MerDKPFrameOptionSliders"..k).Onshow = v.Onshow
        getglobal("MerDKPFrameOptionSliders"..k).OnValueChang = v.OnValueChang
    end

   --[[
    MerDKP_ChatFrame_OnEvent = ChatFrame_OnEvent
    ChatFrame_OnEvent = function(self,event)
        if MerDKP.opt.HideWhisper and event == "CHAT_MSG_WHISPER" then
            if strfind(arg1,"^"..MerDKP.opt.rp) or strlower(arg1)==MerDKP.opt.rplist or strlower(arg1)==MerDKP.opt.mydkp then
                return
            end
        end
        if MerDKP.opt.HideWhisper and event == "CHAT_MSG_WHISPER_INFORM" and strfind(arg1,"^"..IEPrefix) then
            return
        end
        MerDKP_ChatFrame_OnEvent(self,event)      
    end
    ]]--
    MerDKPFrameTab1:SetText(MerDKP.loc.MerDKPFrameTab1)
    MerDKPFrameTab2:SetText(MerDKP.loc.MerDKPFrameTab2)
    MerDKPFrameListBatEditButtonText:SetText(MerDKP.loc.MerDKPFrameListBatEditButtonText)
    MerDKPFrameListWhisperButton:SetText(MerDKP.loc.MerDKPFrameListWhisperButton)
    MerDKPFrameListRaidCheckButtonText:SetText(MerDKP.loc.MerDKPFrameListRaidCheckButtonText)

    --[[if MerDKP.opt.Minimap == 0 then
        MerDKPMinimapButton:Hide()
    else
        MerDKPMinimapButton:Show()
        MerDKPMinimapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 55 - (84 * cos(MerDKP.opt.Minimap)), (84 * sin(MerDKP.opt.Minimap)) - 55)
    end--]]
end

function MerDKP_PLAYER_LOGOUT()
    MerDKPDB = MerDKPDB or {}
    MerDKPDB.opt = MerDKP.opt
    if MerDKP.opt.SaveDkplist then
        MerDKPDB.db = MerDKP.db
    end
    MerDKPDB.savedtime = time()
end

function MerDKP_CHAT_MSG_WHISPER(msg, who)
	who = GetFixedUpUnitName(who);
	CT_RaidTracker_Debug(msg, who, MerDKP.opt.rplist);
    if not MerDKP.opt.enabled then return end

    msg = strlower(msg)
    if msg == MerDKP.opt.rplist then
        for i = 1, #MerDKP.db do
            local replay = "<" .. MerDKP.db[i].title .. "> " .. MerDKP.opt.rp .. i
            if MerDKP.db[i].whisper then
                replay = replay .. " (or) " .. MerDKP.db[i].whisper
            end
            SendChatMessage(MerDKP.opt.prefix..replay, "WHISPER", nil, who)
        end
        return
    end
    if msg == MerDKP.opt.mydkp then
        for i = 1, #MerDKP.db do
            for _, v in ipairs(MerDKP.db[i]) do
                if strlower(v.name) == strlower(who) then
                    SendChatMessage(MerDKP.opt.prefix.."<"..MerDKP.db[i].title.."> "..who.."："..v.dkp.." DKP", "WHISPER", nil, who)
                    break
                end
            end
        end
        return
    end
    if strfind(msg, "^"..MerDKP.opt.rp.."%d+") then
        id, text = select(3,strfind(arg1,"^"..MerDKP.opt.rp.."(%d+)(.*)"))
        id = tonumber(id)
        local tab = MerDKP.db[id]
        if not tab then
            SendChatMessage(MerDKP.opt.prefix.."<MerDKP> Out of search", "WHISPER", nil, who)
            return
        end
        if not text or gsub(text,"%s+","") == "" then
            for _, v in ipairs(tab) do
                if strlower(v.name) == strlower(who) then
                    SendChatMessage(MerDKP.opt.prefix.."<"..tab.title.."> "..who.."："..v.dkp.." DKP", "WHISPER", nil, who)
                    break
                end
            end
            return
        end
        for k in pairs(MerDKP.tmp.rp_class) do
            MerDKP.tmp.rp_class[k] = nil
        end
        for k in pairs(MerDKP.tmp.rp_word) do
            MerDKP.tmp.rp_word[k] = nil
        end
        for keyword in string.gmatch(text,"%S+") do
            if MerDKP.tmp.classes[keyword] then
                tinsert(MerDKP.tmp.rp_class,keyword)
            else
                tinsert(MerDKP.tmp.rp_word,keyword)
            end
        end
        if MerDKP.opt.CurrentRaid then
            tab = MerDKP.tmp.raidmembers
        end
        local j
        for _, v in ipairs(MerDKP.tmp.rp_class) do
            j = 1
            for kk, vv in pairs(tab) do
                if type(vv) == "table" and v == strlower(vv.class) then
                    SendChatMessage(MerDKP.opt.prefix..j..". <"..(tab.title or MerDKP.db[id].title or "").."-"..vv.class.."> "..vv.name.."："..vv.dkp.." DKP", "WHISPER", nil, who)
                    j = j + 1
                    if j > 10 then break end
                end
            end
        end
        for _, v in ipairs(MerDKP.tmp.rp_word) do
            j = 1
            for kk, vv in pairs(tab) do
                if MerDKP.opt.rpexact and type(vv) == "table" and v == strlower(vv.name) then
                    SendChatMessage(MerDKP.opt.prefix.."<"..(tab.title or MerDKP.db[id].title or "").."-"..vv.class.."> "..vv.name.."："..vv.dkp.." DKP", "WHISPER", nil, who)
                elseif not MerDKP.opt.rpexact and type(vv) == "table" and strfind(strlower(vv.name),v) then
                    SendChatMessage(MerDKP.opt.prefix.."<"..(tab.title or MerDKP.db[id].title or "").."-"..vv.class.."> "..vv.name.."："..vv.dkp.." DKP", "WHISPER", nil, who)
                    j = j + 1
                    if j > 10 then break end
                end
            end
        end
        return
    end
    for i = 1, #MerDKP.db do
        if MerDKP.db[i].whisper and strfind(msg,"^"..MerDKP.db[i].whisper) then
            local new_msg = gsub(msg, MerDKP.db[i].whisper, MerDKP.opt.rp..i, 1)
            MerDKP_CHAT_MSG_WHISPER(new_msg, who)
        end
    end
end

function MerDKP_CHAT_MSG_CHANNEL_NOTICE(arg1, arg8, arg9)
        if arg1 == "YOU_JOINED" or arg1 == "YOU_CHANGED" then
            for _, v in ipairs(MerDKP.DROPMENU.channel) do
                if v.value == "CHANNEL"..arg8 then
                    v.text = arg8..". "..arg9
                    return
                end
            end
            tinsert(MerDKP.DROPMENU.channel, {text = arg8..". "..arg9, value = "CHANNEL"..arg8, func = DropDownChannel})
        elseif arg1 == "YOU_LEFT" then
            for k, v in ipairs(MerDKP.DROPMENU.channel) do
                if v.value == "CHANNEL"..arg8 then
                    tremove(MerDKP.DROPMENU.channel, k)
                end
            end
        end
end

function MerDKP_CHAT_MSG_SYSTEM(arg1)
    if strfind(arg1, MerDKP.loc.leftText) then
        local name = select(3, strfind(arg1, MerDKP.loc.leftText))
        MerDKP.tmp.raidmembers[name] = nil
        if MerDKPFrameListRaidCheckButton:GetChecked() then
            MerDKP_DeleteMember(name)
            MerDKP_UpdateList()
        end
    end
end

function MerDKP_GROUP_ROSTER_UPDATE()
    local numMembers = GetNumGroupMembers()
    local toggle
    if numMembers < 1 then
        for k in pairs(MerDKP.tmp.raidmembers) do
            MerDKP.tmp.raidmembers[k] = nil
        end
        MerDKP_InitDKP()
        return
    end
    for i = 1, numMembers do
        name, _, _, _, class, _, _, online = GetRaidRosterInfo(i)
        if strfind(name,"%-") then
            name = select(3, strfind(name, "(.-)%-"))
        end
        if not MerDKP.tmp.raidmembers[name] then
            --dkp = MerDKP_GetDKPByName(name, class)
            MerDKP.tmp.raidmembers[name] = {name=name,class=class,online=online,dkp=0}
            toggle = true
        end
        if MerDKP.tmp.raidmembers[name].online ~= online then
            MerDKP.tmp.raidmembers[name].online = online
            if MerDKP.opt.IgnoreOffline then
                toggle = true
            else
                MerDKP_UpdateList()
            end
        end
    end
    if toggle then
        MerDKP_InitDKP()
    end
end

function MerDKP_InitDataFrom(fromID)
    fromID = fromID or MerDKP.opt.Datafrom
    if fromID == 1 then --website
        MerDKP.db = MerDKP_Table or {}
        MerDKPFrameListGuildRosterDKPButton:Hide()
    elseif fromID == 3 or fromID == 4 then --publicnote and officernote
        MerDKPFrameListGuildRosterDKPButton:Show()
    else --localost
        MerDKP.db = MerDKPDB.db or {}
        MerDKPFrameListGuildRosterDKPButton:Hide()
    end
    MerDKP_InitClass()
    for i = 1, #MerDKP.db do
        table.sort(MerDKP.db[i], function(a,b)
            return (a.class<b.class) or (a.class==b.class and a.dkp>b.dkp)
        end)
    end
end

function MerDKPFrame_DropDownDkpType_Init(self)
    local info
    for i = 1, #MerDKP.db do
        info = {}
        info.text = MerDKP.db[i].title
        info.value = MerDKP.db[i].title
        info.func = function(self)
            local id = self:GetID()
            UIDropDownMenu_SetSelectedID(MerDKPFrameListColumnHeader3, id)
            MerDKP.tmp.id = id
            MerDKP_InitDKP()
        end
        UIDropDownMenu_AddButton(info)
    end
end

function MerDKPFrame_DropDownMinDKP_Init(self)
    for _, v in ipairs(MerDKP.DROPMENU.dkpscore) do
        v.checked = nil
        UIDropDownMenu_AddButton(v)
    end
end

function MerDKPFrame_DropDownChannel_Init(self)
    for _, v in ipairs(MerDKP.DROPMENU.channel) do
        v.checked = nil
        UIDropDownMenu_AddButton(v)
    end
end

function MerDKPFrame_DkpClass_OnLoad(self, id)
    if MerDKP.tmp.tbc[5][id] then
        local color = MerDKP.tmp.classes[ MerDKP.tmp.tbc[5][id] ] or NORMAL_FONT_COLOR
        getglobal(self:GetName().."Text"):SetTextColor(color.r, color.g, color.b)
        getglobal(self:GetName().."Text"):SetText(MerDKP.tmp.tbc[5][id])
        self.class = MerDKP.tmp.tbc[5][id]
        self:Show()
    else
        self:Hide()
    end
end

function MerDKPFrame_DkpClass_OnClick(self, id)
    if self:GetChecked() then
        if not MerDKP.tmp.list_class[self.class] then
            MerDKP.tmp.list_class[self.class] = self.class
        end
    else
        MerDKP.tmp.list_class[self.class] = nil
    end
    MerDKP_InitDKP()
end

function MerDKPFrameClothButton_OnLoad(self, id)
    if MerDKP.tmp.tbc[id] then
        getglobal(self:GetName().."Text"):SetText(MerDKP.tmp.tbc[id].text)
        self:Show()
    else
        self:Hide()
    end
end

function MerDKPFrameClothButton_OnClick(self, id)
    for k in pairs(MerDKP.tmp.list_class) do
        MerDKP.tmp.list_class[k] = nil
    end
    if self:GetChecked() then
        for _, v in ipairs(MerDKP.tmp.tbc[id]) do
            MerDKP.tmp.list_class[v] = v
        end
        local class
        for i = 1, #MerDKP.tmp.tbc[5] do
            class = getglobal("MerDKPFrameListCheckButton"..i).class
            if MerDKP.tmp.list_class[class] then
                getglobal("MerDKPFrameListCheckButton"..i):SetChecked(1)
            else
                getglobal("MerDKPFrameListCheckButton"..i):SetChecked(0)
            end
        end
        for i = 1, #MerDKP.tmp.tbc do
            if i ~= id then
                getglobal("MerDKPFrameListClothButton"..i):SetChecked(0)
            end
        end
    else
        for i = 1, #MerDKP.tmp.tbc[5] do
            getglobal("MerDKPFrameListCheckButton"..i):SetChecked(0)
        end
    end
    MerDKP_InitDKP()
end

function MerDKPFrameList_OnVerticalScroll()
    MerDKP_UpdateList()
end

function MerDKP_DkpListButton_OnClick(this, button)
    if button == "RightButton" then
        HideDropDownMenu(1)
        MerDKPFrameDropDown.initialize = function(self)
            for _, v in ipairs(MerDKP.DROPMENU.member) do
                if v.isTitle then
                    v.text = self.name
                end
                if v.value then
                    v.arg1 = self.name
                    v.arg2 = self.dkp
                end
                if v.value == "CLASS" then
                    v.value = self.class
                    UIDropDownMenu_AddButton(v)
                    v.value = "CLASS"
                else
                    UIDropDownMenu_AddButton(v)
                end
            end
        end
        MerDKPFrameDropDown.displayMode = "MENU"
        ToggleDropDownMenu(1, nil,MerDKPFrameDropDown, "cursor")
    end
end

function MerDKP_RaidCheckButton_OnClick()
    if MerDKPFrameListRaidCheckButton:GetChecked() then
        MerDKPFrameListWhisperButton:Show()
        MerDKPFrame:RegisterEvent("CHAT_MSG_SYSTEM")
        MerDKPFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
        MerDKP_GROUP_ROSTER_UPDATE()
    else
        MerDKPFrameListWhisperButton:Hide()
        MerDKPFrame:UnregisterEvent("CHAT_MSG_SYSTEM")
        MerDKPFrame:UnregisterEvent("GROUP_ROSTER_UPDATE")
    end
    MerDKP_InitDKP()
end

function MerDKP_SendButton_OnClick(yes)
    if not yes and MerDKP.opt.ConfirmSend then
        StaticPopup_Show("MerDKP_ConfirmSend")
        return
    end
    if not MerDKP.tmp.id or not MerDKP.db[MerDKP.tmp.id] then return end
    if MerDKP.tmp.channel == "GUILD" or MerDKP.tmp.channel == "RAID" or MerDKP.tmp.channel == "PARTY" or MerDKP.tmp.channel == "SAY" or MerDKP.tmp.channel == "OFFICER" then
        for k, v in ipairs(MerDKP.tmp.LIST) do
            SendChatMessage("<"..MerDKP.db[MerDKP.tmp.id].title.."-"..v.class.."> "..v.name.."："..v.dkp.." DKP", MerDKP.tmp.channel)
            if k > MerDKP.opt.Outputmax then return end
        end
    elseif strfind(MerDKP.tmp.channel, "CHANNEL%d+") then
        local chanID = select(3,strfind(MerDKP.tmp.channel, "CHANNEL(%d+)"))
        for k, v in ipairs(MerDKP.tmp.LIST) do
            SendChatMessage("<"..MerDKP.db[MerDKP.tmp.id].title.."-"..v.class.."> "..v.name.."："..v.dkp.." DKP", "CHANNEL", nil, chanID)
            if k > MerDKP.opt.Outputmax then return end
        end
    end
end

function MerDKP_WhisperButton_OnClick()
    if not MerDKP.tmp.id or not MerDKP.db[MerDKP.tmp.id] then return end
    for k, v in ipairs(MerDKP.tmp.LIST) do
        if v.online == 1 then
        SendChatMessage(MerDKP.opt.prefix.."<"..MerDKP.db[MerDKP.tmp.id].title.."> "..v.name.."："..v.dkp.." DKP", "WHISPER", nil, v.name)
        end
    end
end

function MerDKP_ColumnHeader_OnClick(key)
    if MerDKP.tmp.sortway == "desc" then
        MerDKP.tmp.sortway = "asc"
        table.sort(MerDKP.tmp.LIST, function(a,b)
            if a[key] and b[key] then
                return  a[key] > b[key]
            end
        end)
    else
        MerDKP.tmp.sortway = "desc"
        table.sort(MerDKP.tmp.LIST, function(a,b)
            if a[key] and b[key] then
                return  a[key] < b[key]
            end
        end)
    end
    MerDKP.tmp.sortkey = key
    MerDKP_UpdateList()
end

function MerDKP_OpenPopupFrame(action, id, name, class, dkp, text)
    MerDKPEditFrame.action = action
    MerDKPEditFrame.id = id or MerDKP.tmp.id
    MerDKPEditFrame.name = name or ""
    MerDKPEditFrame.class = class or ""
    MerDKPEditFrame.dkp = dkp or 0
    MerDKPEditFrame:Show()
    if action == "delete" then
        MerDKPEditFrame:SetHeight(80)
        MerDKPEditFrameText:SetText(text or "")
        MerDKPEditFrameText:Show()
        MerDKPEditFrameType:Hide()
        MerDKPEditFrameTypeText:Hide()
        MerDKPEditFrameName:Hide()
        MerDKPEditFrameNameText:Hide()
        MerDKPEditFrameClass:Hide()
        MerDKPEditFrameClassText:Hide()
        MerDKPEditFrameDKP:Hide()
        MerDKPEditFrameDKPText:Hide()
        MerDKPEditFrameNameBox:Hide()
        MerDKPEditFrameClassBox:Hide()
        MerDKPEditFrameDKPBox:Hide()
    elseif action == "edit" then
        MerDKPEditFrame:SetHeight(180)
        MerDKPEditFrameText:Hide()
        MerDKPEditFrameType:Show()
        MerDKPEditFrameTypeText:Show()
        MerDKPEditFrameName:Show()
        MerDKPEditFrameNameText:Show()
        MerDKPEditFrameClass:Show()
        MerDKPEditFrameClassText:Hide()
        MerDKPEditFrameDKP:Show()
        MerDKPEditFrameDKPText:Hide()
        MerDKPEditFrameNameBox:Hide()
        MerDKPEditFrameClassBox:Show()
        MerDKPEditFrameDKPBox:Show()
        MerDKPEditFrameTypeText:SetText(text or MerDKP.db[id].title or "")
        MerDKPEditFrameNameText:SetText(name)
        MerDKPEditFrameClassBox:SetText(class)
        MerDKPEditFrameDKPBox:SetText("")
    elseif action == "add" then
        MerDKPEditFrame:SetHeight(180)
        MerDKPEditFrameText:Hide()
        MerDKPEditFrameType:Hide()
        MerDKPEditFrameTypeText:Hide()
        MerDKPEditFrameName:Show()
        MerDKPEditFrameNameText:Hide()
        MerDKPEditFrameClass:Show()
        MerDKPEditFrameClassText:Hide()
        MerDKPEditFrameDKP:Show()
        MerDKPEditFrameDKPText:Hide()
        MerDKPEditFrameNameBox:Show()
        MerDKPEditFrameClassBox:Show()
        MerDKPEditFrameDKPBox:Show()
        MerDKPEditFrameTypeText:SetText(text or "")
        MerDKPEditFrameNameBox:SetText("")
        MerDKPEditFrameClassBox:SetText("")
        MerDKPEditFrameDKPBox:SetText("")
    end
end

function MerDKP_SubmitPopupFrame(action)
    local id = MerDKPEditFrame.id
    if action == "delete" then
        local name = MerDKPEditFrame.name or ""
        MerDKP_DeleteMember(name, id)
    elseif action == "edit" then
        local name = MerDKPEditFrame.name or ""
        local class = MerDKPEditFrameClassBox:GetText()
        local dkp = MerDKPEditFrameDKPBox:GetText()
        MerDKP_EditMember(name, class, dkp, id)
    elseif action == "add" then
        local name = MerDKPEditFrameNameBox:GetText()
        local class = MerDKPEditFrameClassBox:GetText()
        local dkp = MerDKPEditFrameDKPBox:GetText()
        MerDKP_EditMember(name, class, dkp, id)
    end
    MerDKP_InitDKP()
end

function MerDKP_SubFrames_SelectTab(id)
    PanelTemplates_SetTab(MerDKPFrame, id)
    for k, v in ipairs(MerDKP.tmp.SubFrames) do
        if  k == id  then
            getglobal(v):Show()
        else
            getglobal(v):Hide()
        end
    end
end

function DropDownMember(self, id, name, dkp)
    local id = MerDKP.tmp.id
    if not id or not MerDKP.db[id] then return end
    if self.value == "WHISPER" then
        SendChatMessage(IEPrefix.."<"..MerDKP.db[id].title.."> "..name.."："..dkp.." DKP", "WHISPER", nil, name)
    else
        SendChatMessage("<"..MerDKP.db[id].title.."> "..name.."："..dkp.." DKP", self.value)
    end
end

function DropDownMinDKP(self)
    local id = self:GetID()
    UIDropDownMenu_SetSelectedID(MerDKPFrameListDropDownMinDKP , id)
    MerDKP.tmp.DkpMin = self.value
    MerDKP_InitDKP()
end

function DropDownChannel(self)
    local id = self:GetID()
    UIDropDownMenu_SetSelectedID(MerDKPFrameListDropDownChannel, id)
    MerDKP.tmp.channel = self.value
    if (self.value == "RAID" and GetNumGroupMembers() < 1)
        or ((self.value == "GUILD" or self.value == "OFFICER") and not IsInGuild() )
        or (self.value == "PARTY" and GetNumGroupMembers() < 1) then
        MerDKPFrameListSendButton:Disable()
    else
        MerDKPFrameListSendButton:Enable()
    end
end

--end region event


--region static

StaticPopupDialogs["MerDKP_ConfirmSend"] = {
    text = MerDKP.loc.sendText,
    button1 = ACCEPT,
    button2 = CANCEL,
    OnAccept = function(self)
        MerDKP_SendButton_OnClick(true)
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
}

StaticPopupDialogs["MerDKP_BatEditDkp"] = {
    text = MerDKP.loc.bateditText,
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = 1,
    maxLetters = 12,
    OnAccept = function(self)
        local dkp = getglobal(self:GetParent():GetName().."EditBox"):GetText()
        dkp = tonumber(dkp) or 0
        dkp = tonumber(format("%.2f",dkp))
        if not MerDKP.tmp.id or not MerDKP.db[MerDKP.tmp.id] then
            return
        end
        for _, v in ipairs(MerDKP.tmp.LIST) do
            for _, vv in ipairs(MerDKP.db[MerDKP.tmp.id]) do
                if strlower(v.name) == strlower(vv.name) then
                    vv.dkp = vv.dkp + dkp
                    break
                end
            end
        end
        MerDKP_InitDKP()
        self:GetParent():Hide()
    end,
    OnShow = function(self)
        getglobal(self:GetName().."EditBox"):SetFocus();
    end,
    OnHide = function(self)
        if ( ChatFrameEditBox:IsVisible() ) then
            ChatFrameEditBox:SetFocus();
        end
        getglobal(self:GetName().."EditBox"):SetText("");
    end,
    EditBoxOnEnterPressed = function(self)
        local dkp = getglobal(self:GetParent():GetName().."EditBox"):GetText()
        dkp = tonumber(dkp) or 0
        dkp = tonumber(format("%.2f",dkp))
        if not MerDKP.tmp.id or not MerDKP.db[MerDKP.tmp.id] then
            return
        end
        for _, v in ipairs(MerDKP.tmp.LIST) do
            for _, vv in ipairs(MerDKP.db[MerDKP.tmp.id]) do
                if strlower(v.name) == strlower(vv.name) then
                    vv.dkp = vv.dkp + dkp
                    break
                end
            end
        end
        MerDKP_InitDKP()
        self:GetParent():Hide()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide();
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1
}

StaticPopupDialogs["MerDKP_GuildRosterDKP"] = {
    text = MerDKP.loc.guildrosterdkp,
    button1 = ACCEPT,
    button2 = CANCEL,
    OnAccept = function()
        MerDKP.db = MerDKP_GuildRoster_InitDKP() or {}
        MerDKP_InitDataFrom(MerDKP.opt.Datafrom)
    end,
    timeout = 0,
    whileDead = 1,
    showAlert = 1,
    hideOnEscape = 1,
}

--end region static


--region function

function MerDKP_InitClass()
    if MerDKP.opt.InitClasses then
        for i = 1, #MerDKP.db do
            for _, v in ipairs(MerDKP.db[i]) do
                v.class = MerDKP.tmp.initclass[v.class] or UNKNOWN
            end
        end
    end
end

function MerDKP_InitDKP()
    if not MerDKP.tmp.id or not MerDKP.db[MerDKP.tmp.id] then return end
    for k in pairs(MerDKP.tmp.LIST) do
        MerDKP.tmp.LIST[k] = nil
    end
    if MerDKPFrameListRaidCheckButton:GetChecked() then
        for k, v in pairs(MerDKP.tmp.raidmembers) do
            v.dkp = MerDKP_GetDKPByName(k,v.class)
            if MerDKP.tmp.list_class[v.class] and v.dkp >= MerDKP.tmp.DkpMin and not (MerDKP.opt.IgnoreOffline and v.online ~= 1) then
                tinsert(MerDKP.tmp.LIST, v)
            end
        end
    else
        for k, v in ipairs(MerDKP.db[MerDKP.tmp.id]) do
            if MerDKP.tmp.list_class[v.class] and v.dkp >= MerDKP.tmp.DkpMin then
                tinsert(MerDKP.tmp.LIST, v)
            end
        end
    end
    if MerDKP.tmp.sortway == "desc" then
        table.sort(MerDKP.tmp.LIST, function(a,b)
            return a[MerDKP.tmp.sortkey] < b[MerDKP.tmp.sortkey]
        end)
    else
        table.sort(MerDKP.tmp.LIST, function(a,b)
            return a[MerDKP.tmp.sortkey] > b[MerDKP.tmp.sortkey]
        end)
    end
    MerDKP.tmp.total = #MerDKP.db[MerDKP.tmp.id]
    MerDKP_UpdateList()
end

function MerDKP_DeleteMember(name, id)
    local tab
    if id then
        tab = MerDKP.db[id]
        if not tab then return end
    else
        tab = MerDKP.tmp.LIST
    end
    for k, v in ipairs(tab) do
        if strlower(name) == strlower(v.name) then
            tremove(tab,k)
            return
        end
    end
end

function MerDKP_EditMember(name, class, dkp, id)
    id = id or MerDKP.tmp.id
    if not id or not MerDKP.db[id] then return end
    dkp = tonumber(dkp) or 0
    dkp = tonumber(format("%.2f",dkp))
    class = MerDKP.tmp.classes[class] and class or UNKNOWN
    name = gsub(strlower(name), "%s", "")
    if strlen(name) == 0 then return end
    if strfind(name, "^%a") then name = strupper(strsub(name,1,1))..strsub(name,2,-1) end
    local toggle
    for _, v in ipairs(MerDKP.db[id]) do
        if strlower(name) == strlower(v.name) then
            v.dkp = v.dkp + dkp
            v.class = class
            toggle = true
            break
        end
    end
    if not toggle then
        tinsert(MerDKP.db[id],{ name=name, class=class or UNKNOWN, dkp=dkp, online=1 })
    end
end

function MerDKP_GetDKPByName(name, class, id)
    id = id or MerDKP.tmp.id
    if not id or not MerDKP.db[id] then
        return 0, class
    end
    for _, v in ipairs(MerDKP.db[id]) do
        if strlower(name) == strlower(v.name) then
            v.class = class or v.class
            return v.dkp, v.class
        end
    end
    tinsert(MerDKP.db[id], { name=name, class=class or UNKNOWN, dkp=0, online=1 })
    return 0, class
end

function MerDKP_GuildRoster_InitDKP()
    if not IsInGuild() then return end
    local numMembers = GetNumGuildMembers(true)
    local name, class, publicnote, officernote, online, dkp
    local tab = {}
    local dkpTable = {
        { title = "T4", whisper= "t4dkp" },
        { title = "T5", whisper= "t5dkp" },
        { title = "T6", whisper= "t6dkp" },
    }
    for k, v in ipairs(dkpTable) do
        tab[k] = {}
        tab[k].title = v.title
        tab[k].whisper = v.whisper
        for i = 1, numMembers do
            name, _, _, _, class, _, publicnote, officernote, online = GetGuildRosterInfo(i)
            if MerDKP.opt.Datafrom == 3 then
                dkp = MerDKP_GuildRoster_GetMemberDKP(publicnote, v.title) or 0
            elseif MerDKP.opt.Datafrom == 4 then
                dkp = MerDKP_GuildRoster_GetMemberDKP(officernote, v.title) or 0
            end
            tinsert(tab[k], {name=name,class=class,online=1,dkp=dkp or 0})
        end
    end
    return tab
end

function MerDKP_GuildRoster_GetMemberDKP(note, prefix)
    for word in string.gmatch(note, "[^#]+") do
        if strfind(word, "^"..prefix..":(%-?%d+%.?%d*)") then
            dkp = select(3,strfind(word, "^"..prefix..":(%-?%d+%.?%d*)"))
            dkp = tonumber(dkp) or 0
            dkp = tonumber(format("%.2f",dkp))
            return dkp
        end
    end
end

function MerDKP_GuildRoster_GetMemberNewNote(player)
    local note = "#"
    for i = 1, #MerDKP.db do
        local dkp = MerDKP_GetDKPByName(player, nil, i)
        note = note .. MerDKP.db[i].title .. ":" .. dkp .. "#"
    end
    return strsub(note,2,-2) or ""
end

function MerDKP_GuildRoster_GetMemberRank(player)
    local numMembers = GetNumGuildMembers(true)
    local name
    for i = 1, numMembers do
        name = GetGuildRosterInfo(i)
        if strlower(name) == strlower(player) then
            return i
        end
    end
end

function MerDKP_GuildRoster_UpdateNote(player) --not used
    local rank = MerDKP_GuildRoster_GetMemberRank(player)
    if rank then
        local note = MerDKP_GuildRoster_GetMemberNewNote(player)
        if MerDKP.opt.Datafrom == 3 then
            GuildRosterSetPublicNote(rank, note)
        elseif MerDKP.opt.Datafrom == 4 then
            GuildRosterSetOfficerNote(rank, note)
        end
    end
end

function MerDKP_ColorValue(val)
    if not val then
        return ""
    elseif tonumber(val) > 0 then
        return "|cff3fff3f" .. val .. "|r"
    elseif tonumber(val) < 0 then
        return "|cffff3f3f" .. val .. "|r"
    else
        return "|cffafafaf" .. val .. "|r"
    end
end

function MerDKP_UpdateList()
    local size = #MerDKP.tmp.LIST
    local offset = FauxScrollFrame_GetOffset(MerDKPFrameListScrollFrame)
    local id, button, list
    MerDKPFrameListTotal:SetText(format(MerDKP.loc.totalText, size, MerDKP.tmp.total))
    for i = 1, 13 do
        id = i + offset
        button = getglobal("MerDKPFrameListButton"..i)
        list = MerDKP.tmp.LIST[id]
        if size > 13 then
            button:SetWidth(350)
            getglobal("MerDKPFrameListButton"..i.."bg"):SetWidth(350)
        else
            button:SetWidth(370)
            getglobal("MerDKPFrameListButton"..i.."bg"):SetWidth(370)
        end
        if id <= size then
            button.id =  id
            button.name = list.name
            button.dkp = list.dkp
            button.class = list.class
            getglobal("MerDKPFrameListButton"..i.."Name"):SetText(list.name)
            getglobal("MerDKPFrameListButton"..i.."Class"):SetText(list.class)
            getglobal("MerDKPFrameListButton"..i.."DKP"):SetText(MerDKP_ColorValue(format("%.2f",list.dkp)))
            local color = MerDKP.tmp.classes[list.class] or NORMAL_FONT_COLOR
            getglobal("MerDKPFrameListButton"..i.."Name"):SetTextColor(color.r, color.g, color.b)
            getglobal("MerDKPFrameListButton"..i.."Class"):SetTextColor(color.r, color.g, color.b)
            getglobal("MerDKPFrameListButton"..i.."bg"):SetVertexColor(color.r, color.g, color.b)
            if list.online ~= 1 then
                getglobal("MerDKPFrameListButton"..i.."Name"):SetTextColor(0.4, 0.4, 0.4)
                getglobal("MerDKPFrameListButton"..i.."Class"):SetTextColor(0.4, 0.4, 0.4)
            end
            button:Show()
        else
            button:Hide()
        end
    end
    FauxScrollFrame_Update(MerDKPFrameListScrollFrame, size, 13, 16)
end

function gbkToBig5()
    for k,v in pairs(MerDKP_Table) do       
        for k2,v2 in pairs(v) do
            if tonumber(k2) and gbkToBig5Table[v2["class"]]~=nil then           
            v2["class"] = gbkToBig5Table[v2["class"]];          
            end
        end
    end
end

--end region function
