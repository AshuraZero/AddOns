-- Version : Chinese (by duowan.com)
-- Last Update : 03/17/2005

-- Commands
MAPNOTES_ENABLE_COMMANDS = { "/mapnote" };
MAPNOTES_ONEOTE_COMMANDS = { "/onenote", "/allowonenote", "/aon" };
MAPNOTES_MININOTE_COMMANDS = { "/nextmininote", "/nmn" };
MAPNOTES_MININOTEONLY_COMMANDS = { "/nextmininoteonly", "/nmno" };
MAPNOTES_MININOTEOFF_COMMANDS = { "/mininoteoff", "/mno" };
MAPNOTES_MNTLOC_COMMANDS = { "/mntloc" };
MAPNOTES_QUICKNOTE_COMMANDS = { "/quicknote", "/qnote" };
MAPNOTES_QUICKTLOC_COMMANDS = { "/quicktloc", "/qtloc" };

-- Interface Configuration
MAPNOTES_WORLDMAPHELP = "双击地图打开地图标记菜单";
MAPNOTES_CLICK_ON_SECOND_NOTE = "|cFFFF0000地图标记:|r 选择第二个标记以画出/清除一条线";

MAPNOTES_NEW_MENU = "地图标记";
MAPNOTES_NEW_NOTE = "创建标记";
MAPNOTES_MININOTE_OFF = "关闭小地图上的标记";
MAPNOTES_OPTIONS = "选项";
MAPNOTES_CANCEL = "取消";

MAPNOTES_POI_MENU = "地图标记";
MAPNOTES_EDIT_NOTE = "编辑标记";
MAPNOTES_MININOTE_ON = "设置为小地图标记";
MAPNOTES_SPECIAL_ACTIONS = "特殊操作";
MAPNOTES_SEND_NOTE = "发送标记";

MAPNOTES_SPECIALACTION_MENU = "特殊操作";
MAPNOTES_TOGGLELINE = "切换线条";
MAPNOTES_DELETE_NOTE = "删除标记";

MAPNOTES_EDIT_MENU = "编辑标记";
MAPNOTES_SAVE_NOTE = "保存";
MAPNOTES_EDIT_TITLE = "标题 (必填):";
MAPNOTES_EDIT_INFO1 = "信息行 1 (可选):";
MAPNOTES_EDIT_INFO2 = "信息行 2 (可选):";

MAPNOTES_SEND_MENU = "发送标记";
MAPNOTES_SLASHCOMMAND = "改变模式";
MAPNOTES_SEND_COSMOSTITLE = "发送标记:";
MAPNOTES_SEND_COSMOSTIP = "这些标记可以被其他地图标记使用者接收\n('发送给队友'功能必须配合Cosmos才可使用)";
MAPNOTES_SEND_PLAYER = "输入玩家名字:";
MAPNOTES_SENDTOPLAYER = "发送给玩家";
MAPNOTES_SENDTOPARTY = "发送给队友";
MAPNOTES_SHOWSEND = "改变模式";
MAPNOTES_SEND_SLASHTITLE = "得到斜线命令:";
MAPNOTES_SEND_SLASHTIP = "选中这些并使用 CTRL+C 复制到剪切板\n(之后可以将它进行上传论坛等处理)";
MAPNOTES_SEND_SLASHCOMMAND = "/Command:";

MAPNOTES_OPTIONS_MENU = "选项";
MAPNOTES_SAVE_OPTIONS = "保存";
MAPNOTES_OWNNOTES = "显示自己建立的标记";
MAPNOTES_OTHERNOTES = "显示收到的标记";
MAPNOTES_HIGHLIGHT_LASTCREATED = "高亮提示最后建立的标记为|cFFFF0000红色|r";
MAPNOTES_HIGHLIGHT_MININOTE = "高亮提示最后选择为小地图标记的标记为|cFF6666FF蓝色|r";
MAPNOTES_ACCEPTINCOMING = "接受其他玩家传入的标记";
MAPNOTES_INCOMING_CAP = "Decline notes if they would leave less than 5 notes free";
MAPNOTES_AUTOPARTYASMININOTE = "自动将团队标记设为小地图标记."

MAPNOTES_CREATEDBY = "创建人:";
MAPNOTES_DUOWAN = "wow.duowan.com";
MAPNOTES_CHAT_COMMAND_ENABLE_INFO = "这个命令允许你插入从其他地方得到的标记(如网页).";
MAPNOTES_CHAT_COMMAND_ONENOTE_INFO = "忽略选项设置, 使你可以接收下一个传入的标记.";
MAPNOTES_CHAT_COMMAND_MININOTE_INFO = "将下一个传入的标记直接设置为小地图标记 (同时在地图上插入标记):";
MAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO = "将下一个传入的标记仅设置为小地图标记 (不在地图上插入标记).";
MAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO = "关闭小地图标记.";
MAPNOTES_CHAT_COMMAND_MNTLOC_INFO = "在地图上创建 tloc 标记.";
MAPNOTES_CHAT_COMMAND_QUICKNOTE = "在地图上创建当前位置的标记.";
MAPNOTES_CHAT_COMMAND_QUICKTLOC = "在当前区域地图上创建一个 tloc 制定位置的标记.";
MAPNOTES_MAPNOTEHELP = "这个命令只能用来创建标记";
MAPNOTES_ONENOTE_OFF = "允许一个标记传入: 关闭";
MAPNOTES_ONENOTE_ON = "允许一个标记传入: 打开";
MAPNOTES_MININOTE_SHOW_0 = "下一个传入标记作为小地图标记: 关闭";
MAPNOTES_MININOTE_SHOW_1 = "下一个传入标记作为小地图标记: 打开";
MAPNOTES_MININOTE_SHOW_2 = "下一个传入标记作为小地图标记: 仅小地图标记";
MAPNOTES_DECLINE_SLASH = "无法增加，太多标记在 |cFFFFD100%s|r.";
MAPNOTES_DECLINE_SLASH_NEAR = "无法增加, 这个标记太接近 |cFFFFD100%q|r 在 |cFFFFD100%s|r.";
MAPNOTES_DECLINE_GET = "无法接收 |cFFFFD100%s|r传入的标记: 太多标记在 |cFFFFD100%s|r, 或设置中禁止接收该标记.";
MAPNOTES_ACCEPT_SLASH = "标记增加到了 |cFFFFD100%s|r 的地图上.";
MAPNOTES_ACCEPT_GET = "你接收到一个从 |cFFFFD100%s|r 发来的标记在 |cFFFFD100%s|r.";
MAPNOTES_PARTY_GET = "|cFFFFD100%s|r 在 |cFFFFD100%s|r设置了一个新的团队标记.";
MAPNOTES_DECLINE_NOTETONEAR = "|cFFFFD100%s|r 试图给你发送一个在 |cFFFFD100%s|r 的标记, 但是它太接近 |cFFFFD100%q|r 了.";
MAPNOTES_QUICKNOTE_NOTETONEAR = "无法创建标记. 你太接近 |cFFFFD100%s|r 了.";
MAPNOTES_QUICKNOTE_NOPOSITION = "无法创建标记: 无法得到当前位置.";
MAPNOTES_QUICKNOTE_DEFAULTNAME = "快速标记";
MAPNOTES_QUICKNOTE_OK = "在地图 |cFFFFD100%s|r 上创建标记.";
MAPNOTES_QUICKNOTE_TOOMANY = "已经有太多标记在 |cFFFFD100%s|r 的地图上了.";
MAPNOTES_QUICKTLOC_NOTETONEAR = "无法创建标记. 位置太接近标记 |cFFFFD100%s|r 了.";
MAPNOTES_QUICKTLOC_NOZONE = "无法创建标记: 无法得到当前区域.";
MAPNOTES_QUICKTLOC_NOARGUMENT = "用法: '/quicktloc xx,yy [icon] [title]'.";
MAPNOTES_SETMININOTE = "将标记设置为新的小地图标记";
MAPNOTES_THOTTBOTLOC = "Thottbot 坐标";
MAPNOTES_PARTYNOTE = "团队标记";

-- Drop Down Menu
MAPNOTES_SHOWNOTES = "显示标记";
MAPNOTES_DROPDOWNTITLE = "地图标记";
MAPNOTES_DROPDOWNMENUTEXT = "快速标记";

MapNotes_ZoneShift = {
	[0] = { [0] = 0 },
	[1] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
	[2] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 },
};

MapNotes_ZoneShift[1][0] = 0;
MapNotes_ZoneShift[2][0] = 0;

MapNotes_Const = {};
MapNotes_Const["战歌峡谷"] = { scale = 0.035, xoffset = 0.41757282062541, 
                         yoffset = 0.33126468682991, xscale = 12897.3, yscale = 8638.1 };
MapNotes_Const["奥特兰克山谷"] = { scale = 0.035, xoffset = 0.41757282062541, 
                         yoffset = 0.33126468682991, xscale = 12897.3, yscale = 8638.1 };

