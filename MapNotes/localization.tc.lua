if (GetLocale()=="zhTW") then

-- Version : Chinese (by iWOW)
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
MAPNOTES_WORLDMAPHELP = "雙擊地圖打開地圖標記菜單";
MAPNOTES_CLICK_ON_SECOND_NOTE = "|cFFFF0000地圖標記:|r 選擇第二個標記以畫出/清除一條線";

MAPNOTES_NEW_MENU = "地圖標記";
MAPNOTES_NEW_NOTE = "創建標記";
MAPNOTES_MININOTE_OFF = "關閉小地圖上的標記";
MAPNOTES_OPTIONS = "選項";
MAPNOTES_CANCEL = "取消";

MAPNOTES_POI_MENU = "地圖標記";
MAPNOTES_EDIT_NOTE = "編輯標記";
MAPNOTES_MININOTE_ON = "設置為小地圖標記";
MAPNOTES_SPECIAL_ACTIONS = "特殊操作";
MAPNOTES_SEND_NOTE = "發送標記";

MAPNOTES_SPECIALACTION_MENU = "特殊操作";
MAPNOTES_TOGGLELINE = "切換線條";
MAPNOTES_DELETE_NOTE = "刪除標記";

MAPNOTES_EDIT_MENU = "編輯標記";
MAPNOTES_SAVE_NOTE = "保存";
MAPNOTES_EDIT_TITLE = "標題 (必填):";
MAPNOTES_EDIT_INFO1 = "信息行 1 (可選):";
MAPNOTES_EDIT_INFO2 = "信息行 2 (可選):";

MAPNOTES_SEND_MENU = "發送標記";
MAPNOTES_SLASHCOMMAND = "改變模式";
MAPNOTES_SEND_COSMOSTITLE = "發送標記:";
MAPNOTES_SEND_COSMOSTIP = "這些標記可以被其他地圖標記使用者接收\n('發送給隊友'功能必須配合Cosmos才可使用)";
MAPNOTES_SEND_PLAYER = "輸入玩家名字:";
MAPNOTES_SENDTOPLAYER = "發送給玩家";
MAPNOTES_SENDTOPARTY = "發送給隊友";
MAPNOTES_SHOWSEND = "改變模式";
MAPNOTES_SEND_SLASHTITLE = "得到斜線命令:";
MAPNOTES_SEND_SLASHTIP = "選中這些並使用 CTRL+C 復制到剪切板\n(之後可以將它進行上傳論壇等處理)";
MAPNOTES_SEND_SLASHCOMMAND = "/Command:";

MAPNOTES_OPTIONS_MENU = "選項";
MAPNOTES_SAVE_OPTIONS = "保存";
MAPNOTES_OWNNOTES = "顯示自己建立的標記";
MAPNOTES_OTHERNOTES = "顯示收到的標記";
MAPNOTES_HIGHLIGHT_LASTCREATED = "高亮提示最後建立的標記為|cFFFF0000紅色|r";
MAPNOTES_HIGHLIGHT_MININOTE = "高亮提示最後選擇為小地圖標記的標記為|cFF6666FF藍色|r";
MAPNOTES_ACCEPTINCOMING = "接受其他玩家傳入的標記";
MAPNOTES_INCOMING_CAP = "Decline notes if they would leave less than 5 notes free";
MAPNOTES_AUTOPARTYASMININOTE = "自動將團隊標記設為小地圖標記."

MAPNOTES_CREATEDBY = "創建人:";
MAPNOTES_CHAT_COMMAND_ENABLE_INFO = "這個命令允許你插入從其他地方得到的標記(如網頁).";
MAPNOTES_CHAT_COMMAND_ONENOTE_INFO = "忽略選項設置, 使你可以接收下一個傳入的標記.";
MAPNOTES_CHAT_COMMAND_MININOTE_INFO = "將下一個傳入的標記直接設置為小地圖標記 (同時在地圖上插入標記):";
MAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO = "將下一個傳入的標記僅設置為小地圖標記 (不在地圖上插入標記).";
MAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO = "關閉小地圖標記.";
MAPNOTES_CHAT_COMMAND_MNTLOC_INFO = "在地圖上創建 tloc 標記.";
MAPNOTES_CHAT_COMMAND_QUICKNOTE = "在地圖上創建當前位置的標記.";
MAPNOTES_CHAT_COMMAND_QUICKTLOC = "在當前區域地圖上創建一個 tloc 制定位置的標記.";
MAPNOTES_MAPNOTEHELP = "這個命令隻能用來創建標記";
MAPNOTES_ONENOTE_OFF = "允許一個標記傳入: 關閉";
MAPNOTES_ONENOTE_ON = "允許一個標記傳入: 打開";
MAPNOTES_MININOTE_SHOW_0 = "下一個傳入標記作為小地圖標記: 關閉";
MAPNOTES_MININOTE_SHOW_1 = "下一個傳入標記作為小地圖標記: 打開";
MAPNOTES_MININOTE_SHOW_2 = "下一個傳入標記作為小地圖標記: 僅小地圖標記";
MAPNOTES_DECLINE_SLASH = "無法增加，太多標記在 |cFFFFD100%s|r.";
MAPNOTES_DECLINE_SLASH_NEAR = "無法增加, 這個標記太接近 |cFFFFD100%q|r 在 |cFFFFD100%s|r.";
MAPNOTES_DECLINE_GET = "無法接收 |cFFFFD100%s|r傳入的標記: 太多標記在 |cFFFFD100%s|r, 或設置中禁止接收該標記.";
MAPNOTES_ACCEPT_SLASH = "標記增加到了 |cFFFFD100%s|r 的地圖上.";
MAPNOTES_ACCEPT_GET = "你接收到一個從 |cFFFFD100%s|r 發來的標記在 |cFFFFD100%s|r.";
MAPNOTES_PARTY_GET = "|cFFFFD100%s|r 在 |cFFFFD100%s|r設置了一個新的團隊標記.";
MAPNOTES_DECLINE_NOTETONEAR = "|cFFFFD100%s|r 試圖給你發送一個在 |cFFFFD100%s|r 的標記, 但是它太接近 |cFFFFD100%q|r 了.";
MAPNOTES_QUICKNOTE_NOTETONEAR = "無法創建標記. 你太接近 |cFFFFD100%s|r 了.";
MAPNOTES_QUICKNOTE_NOPOSITION = "無法創建標記: 無法得到當前位置.";
MAPNOTES_QUICKNOTE_DEFAULTNAME = "快速標記";
MAPNOTES_QUICKNOTE_OK = "在地圖 |cFFFFD100%s|r 上創建標記.";
MAPNOTES_QUICKNOTE_TOOMANY = "已經有太多標記在 |cFFFFD100%s|r 的地圖上了.";
MAPNOTES_QUICKTLOC_NOTETONEAR = "無法創建標記. 位置太接近標記 |cFFFFD100%s|r 了.";
MAPNOTES_QUICKTLOC_NOZONE = "無法創建標記: 無法得到當前區域.";
MAPNOTES_QUICKTLOC_NOARGUMENT = "用法: '/quicktloc xx,yy [icon] [title]'.";
MAPNOTES_SETMININOTE = "將標記設置為新的小地圖標記";
MAPNOTES_THOTTBOTLOC = "Thottbot 坐標";
MAPNOTES_PARTYNOTE = "團隊標記";

-- Drop Down Menu
MAPNOTES_SHOWNOTES = "顯示標記";
MAPNOTES_DROPDOWNTITLE = "地圖標記";
MAPNOTES_DROPDOWNMENUTEXT = "快速標記";

MapNotes_ZoneShift = {
	[0] = { [0] = 0 },
	[1] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
	[2] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 },
};

MapNotes_ZoneShift[1][0] = 0;
MapNotes_ZoneShift[2][0] = 0;

MapNotes_Const = {};
MapNotes_Const["戰歌峽谷"] = { scale = 0.035, xoffset = 0.41757282062541, 
                         yoffset = 0.33126468682991, xscale = 12897.3, yscale = 8638.1 };
MapNotes_Const["奧特蘭克山谷"] = { scale = 0.035, xoffset = 0.41757282062541, 
                         yoffset = 0.33126468682991, xscale = 12897.3, yscale = 8638.1 };


end