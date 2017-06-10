--[[
 Decursive (v 1.9.8) add-on for World of Warcraft UI
 Copyright (C) 2006 Archarodim ( http://www.2072productions.com/?to=decursive-continued.txt )
 This is the continued work of the original Decursive (v1.9.4) by Quu
 Decursive 1.9.4 is in public domain ( www.quutar.com )
 
 License:
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
 
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]

-------------------------------------------------------------------------------
-- the constants for the mod (non localized)
-------------------------------------------------------------------------------
DCR_VERSION_STRING = "Decursive 1.9.8.4";
BINDING_HEADER_DECURSIVE = "Decursive";

DCR_MACRO_COMMAND  = "/decursive";
DCR_MACRO_SHOW     = "/dcrshow";
DCR_MACRO_HIDE     = "/dcrhide";
DCR_MACRO_OPTION   = "/dcroption";
DCR_MACRO_RESET    = "/dcrreset";

DCR_MACRO_PRADD    = "/dcrpradd";
DCR_MACRO_PRCLEAR  = "/dcrprclear";
DCR_MACRO_PRLIST   = "/dcrprlist";
DCR_MACRO_PRSHOW   = "/dcrprshow";

DCR_MACRO_SKADD    = "/dcrskadd";
DCR_MACRO_SKCLEAR  = "/dcrskclear";
DCR_MACRO_SKLIST   = "/dcrsklist";
DCR_MACRO_SKSHOW   = "/dcrskshow";
DCR_MACRO_DEBUG	   = "/dcrdebug";

-- DO NOT TRANSLATE, THOSE ARE ALWAYS ENGLISH
DCR_CLASS_DRUID   = 'DRUID';
DCR_CLASS_HUNTER  = 'HUNTER';
DCR_CLASS_MAGE    = 'MAGE';
DCR_CLASS_PALADIN = 'PALADIN';
DCR_CLASS_PRIEST  = 'PRIEST';
DCR_CLASS_ROGUE   = 'ROGUE';
DCR_CLASS_SHAMAN  = 'SHAMAN';
DCR_CLASS_WARLOCK = 'WARLOCK';
DCR_CLASS_WARRIOR = 'WARRIOR';

DCR_DISEASE = 'Disease';
DCR_MAGIC   = 'Magic';
DCR_POISON  = 'Poison';
DCR_CURSE   = 'Curse';
DCR_CHARMED = 'Charm';

----------------------------------------------------------------------------------
-- Traditional Chinese localization
----------------------------------------------------------------------------------
if ( GetLocale() == "zhTW" ) then

DCR_ALLIANCE_NAME = '聯盟';

DCR_LOC_CLASS_DRUID   = '德魯伊';
DCR_LOC_CLASS_HUNTER  = '獵人';
DCR_LOC_CLASS_MAGE    = '法師';
DCR_LOC_CLASS_PALADIN = '聖騎士';
DCR_LOC_CLASS_PRIEST  = '牧師';
DCR_LOC_CLASS_ROGUE   = '盜賊';
DCR_LOC_CLASS_SHAMAN  = '薩滿';
DCR_LOC_CLASS_WARLOCK = '術士';
DCR_LOC_CLASS_WARRIOR = '戰士';

DCR_STR_OTHER	    = '其它';
DCR_STR_ANCHOR	    = '定位點';
DCR_STR_OPTIONS	    = '選項設置';
DCR_STR_CLOSE	    = '關閉';
DCR_STR_DCR_PRIO    = '優先清單';
DCR_STR_DCR_SKIP    = '忽略清單';
DCR_STR_QUICK_POP   = '快速添加器';
DCR_STR_POP	    = '快速添加清單';
DCR_STR_GROUP	    = '隊伍 ';

DCR_STR_NOMANA	    = '法力不足。';
DCR_STR_UNUSABLE    = '暫時不能淨化。';
DCR_STR_NEED_CURE_ACTION_IN_BARS = 'Decursive在你的動作條上找不到任何可用的淨化法術圖標。Decursive需要它來檢查施法距離。';


DCR_UP		    = '上移';
DCR_DOWN	    = '下移';

DCR_PRIORITY_SHOW   = 'P';
DCR_POPULATE	    = 'P';
DCR_SKIP_SHOW	    = 'S';
DCR_ANCHOR_SHOW	    = 'A';
DCR_OPTION_SHOW	    = 'O';
DCR_CLEAR_PRIO	    = 'C';
DCR_CLEAR_SKIP	    = 'C';


DCR_LOC_AF_TYPE = {};
DCR_LOC_AF_TYPE [DCR_DISEASE] = '疾病';
DCR_LOC_AF_TYPE [DCR_MAGIC]   = '魔法';
DCR_LOC_AF_TYPE [DCR_POISON]  = '中毒';
DCR_LOC_AF_TYPE [DCR_CURSE]   = '詛咒';
DCR_LOC_AF_TYPE [DCR_CHARMED] = '誘惑';


DCR_PET_FELHUNTER = "地獄獵犬";
DCR_PET_DOOMGUARD = "末日守衛";
DCR_PET_FEL_CAST  = "吞噬魔法";
DCR_PET_DOOM_CAST = "驅散魔法";

DCR_SPELL_CURE_DISEASE        = '祛病術';
DCR_SPELL_ABOLISH_DISEASE     = '驅除疾病';
DCR_SPELL_PURIFY              = '純淨術';
DCR_SPELL_CLEANSE             = '清潔術';
DCR_SPELL_DISPELL_MAGIC       = '驅散魔法';
DCR_SPELL_CURE_POISON         = '消毒術';
DCR_SPELL_ABOLISH_POISON      = '驅毒術';
DCR_SPELL_REMOVE_LESSER_CURSE = '解除次級詛咒';
DCR_SPELL_REMOVE_CURSE        = '解除詛咒';
DCR_SPELL_PURGE               = '淨化術';
DCR_SPELL_NO_RANK             = '';
DCR_SPELL_RANK_1              = '等級 1';
DCR_SPELL_RANK_2              = '等級 2';

BINDING_NAME_DCRCLEAN   = "淨化隊伍";
BINDING_NAME_DCRSHOW    = "顯示/隱藏工具條";
BINDING_NAME_DCROPTION  = "顯示/隱藏選項設置视窗";

BINDING_NAME_DCRPRADD     = "將目標添加到優先清單";
BINDING_NAME_DCRPRCLEAR   = "清空優先清單";
BINDING_NAME_DCRPRLIST    = "在聊天視窗顯示優先清單內容";
BINDING_NAME_DCRPRSHOW    = "顯示/隱藏優先清單视窗";

BINDING_NAME_DCRSKADD   = "將目標添加到忽略清單";
BINDING_NAME_DCRSKCLEAR = "清空忽略清單";
BINDING_NAME_DCRSKLIST  = "在聊天視窗顯示忽略清單內容";
BINDING_NAME_DCRSKSHOW  = "顯示/隱藏忽略清單视窗";


DCR_DISABLE_AUTOSELFCAST = "Decursive檢測到選項設置「%s」已啟用。\n\n此選項激活時，Decursive將不能正常工作。\n\n你想要禁用這個選項設置嗎？";

DCR_PRIORITY_LIST  = "設置優先清單";
DCR_SKIP_LIST_STR  = "設置忽略清單";
DCR_SKIP_OPT_STR   = "選項設置";
DCR_POPULATE_LIST  = "清單快速添加器";
DCR_MOVE_ID        = "左鍵上移\n右鍵下移\nShift+點擊刪除";
DCR_HIDE_MAIN      = "隱藏工具條";
DCR_SHOW_MSG	   = "如果你想要顯示Decursive的工具條，輸入/dcrshow。";
DCR_IS_HERE_MSG	   = "Decursive初始化完畢。";

DCR_PRINT_CHATFRAME = "在聊天視窗顯示訊息";
DCR_PRINT_CUSTOM    = "在遊戲畫面中顯示訊息";
DCR_PRINT_ERRORS    = "顯示錯誤訊息";

DCR_SHOW_TOOLTIP    = "在即時清單中顯示浮動提示";
DCR_REVERSE_LIVELIST= "反向顯示即時清單";
DCR_TIE_LIVELIST    = "根據工具條是否可見顯示/隱藏即時清單";
DCR_HIDE_LIVELIST   = "隱藏即時清單";

DCR_AMOUNT_AFFLIC   = "即時清單顯示人數：";
DCR_BLACK_LENGTH    = "黑名單持續時間(秒)：";
DCR_SCAN_LENGTH     = "即時檢測時間間隔(秒)：";
DCR_ABOLISH_CHECK   = "在施法前檢查是否需要淨化";
DCR_BEST_SPELL      = "總是使用最高等級法術進行淨化";
DCR_RANDOM_ORDER    = "隨機淨化玩家";
DCR_CURE_PETS       = "檢測並淨化寵物";
DCR_IGNORE_STEALTH  = "忽略潛行的玩家";
DCR_PLAY_SOUND	    = "有玩家需要淨化時播放音效提示";
DCR_ANCHOR          = "Decursive文字定位";
DCR_CHECK_RANGE     = "在淨化前檢查是否超出施法距離";
DCR_FAST_RANGE_CHECK= "啓用快速(不精確)距離檢測";
DCR_DONOT_BL_PRIO   = "不將優先清單中的玩家加入黑名單";
DCR_CHOOSE_CURE	    = "淨化類型選擇";
DCR_ABORT_SIP	    = "在淨化前中止正在施放的法術";


-- $s is spell name
-- $a is affliction name/type
-- $t is target name
DCR_DISPELL_ENEMY    = "對敵方施放$s。";
DCR_NOT_CLEANED      = "沒有任何效果被驅除。";
DCR_CLEAN_STRING     = "驅除$t受到的$a效果。";
DCR_SPELL_FOUND      = "找到$s法術。";
DCR_NO_SPELLS        = "沒有找到驅除不良效果的法術。";
DCR_NO_SPELLS_RDY    = "驅除不良效果的法術尚未準備好。";
DCR_OUT_OF_RANGE     = "$t距離太遠。$a效果無法被驅除。";
DCR_IGNORE_STRING    = "忽略$t受到的$a效果。";

DCR_INVISIBLE_LIST = {
	["潛伏"]     = true,
	["潛行"]     = true,
	["影遁"]     = true,
}

-- this causes the target to be ignored!!!!
DCR_IGNORELIST = {
	["放逐術"]   = true,
	["相位變換"] = true,
};

-- ignore this effect
DCR_SKIP_LIST = {
	["無夢睡眠"]	= true,
	["強效無夢睡眠"]= true,
	["昏睡"]        = true,
	["強效昏睡"]    = true,
	["心靈視界"]    = true,
	["變異注射"]    = true,
	["腐蝕耐力"]    = true,
	["淹沒"]        = true,
};

-- ignore the effect bassed on the class
DCR_SKIP_BY_CLASS_LIST = {
    [DCR_CLASS_WARRIOR] = {
		["上古狂亂"]   = true,
		["點燃法力"]   = true,
		["污濁之魂"]   = true,
		["法力燃燒"]   = true,
    };
    [DCR_CLASS_ROGUE] = {
		["沉默"]       = true,
		["上古狂亂"]   = true,
		["點燃法力"]   = true,
		["污濁之魂"]   = true,
		["法力燃燒"]   = true,
		["音素爆破"]   = true,
    };
    [DCR_CLASS_HUNTER] = {
		["熔岩鐐銬"]   = true,
    };
    [DCR_CLASS_MAGE] = {
		["熔岩鐐銬"]   = true,
    };
};

DCR_USER_CHECK_DETECT1  = "DECURSIVE";
DCR_USER_CHECK_DETECT2  = "檢查";
DCR_USER_CHECK_RESPONSE = "姓名：%s  /  職業：%s  /  版本：%s";

end
