-- This translation was provided by Mongris.

function Ace_Locals_zhCN() 

-- All text inside quotes is translatable, except for 'method' lines.

SLASH_RELOAD1	 = "/rl" 
SLASH_RELOAD2	 = "/reload" 

ACE_NAME					 = "Ace" 
ACE_DESCRIPTION				 = "插件开发与管理工具包."
ACE_VERSION_MISMATCH		 = "|cffff6060[Ace 版本错误]|r"

-- Various text strings 
ACE_TEXT_COMMANDS			 = "命令"
ACE_TEXT_ALL				 = "all" 
ACE_TEXT_OF					 = "of" 
ACE_TEXT_AUTHOR				 = "作者"
ACE_TEXT_EMAIL				 = "Email" 
ACE_TEXT_RELEASED			 = "Released" 
ACE_TEXT_WEBSITE			 = "网站"
ACE_TEXT_MEM_USAGE			 = "内存占用(MB)"
ACE_TEXT_TOTAL_ADDONS		 = "插件总数"
ACE_TEXT_TOTAL_LOADED		 = "已加载插件"
ACE_TEXT_ACE_ADDONS_LOADED	 = "Ace插件"
ACE_TEXT_ACE_REGISTERED		 = "Ace 注册程序"
ACE_TEXT_OTHERS_LOADED		 = "其它插件"
ACE_TEXT_NOT_LOADED			 = "未加载插件"
ACE_TEXT_LOADMSG			 = "启动时加载信息显示类型"
ACE_TEXT_NOW_SET_TO 		 = "已设置为"
ACE_TEXT_DEFAULT	 		 = "default" 

ACE_MAP_STANDBY				 = {[0]="已启用.", [1]="已挂起."} 
ACE_MAP_LOADMSG				 = {[0]="概要模式", addon="插件模式", none="无显示"}

ACE_DISPLAY_OPTION			 = "[|cfff5f530%s|r]" 

-- Load message locals 
ACE_LOAD_MSG_SUMMARY		 = "|cffffff78Ace 初始化完成|r\n"..
							   "|cffffff78"..ACE_TEXT_ACE_REGISTERED..":|r %s\n"..
							   "|cffffff78配置文件已读取:|r %s\n"..
							   "|cffffff78输入|r |cffd8c7ff/ace|r |cffffff78获取更多信息|r"

-- Addon locals 
ACE_ADDON_LOADED			 = "|cffffff78%s v%s|r |cffffffffby|r |cffd8c7ff%s|r |cffffffff已加载.|r" 
ACE_ADDON_CHAT_COMMAND		 = "|cffffff78(%s)" 
ACE_ADDON_STANDBY			 = "|cffff5050(挂起)|r"

-- Addon Categories 
ACE_CATEGORY_BARS			 = "动作条UI"
ACE_CATEGORY_CHAT			 = "聊天UI"
ACE_CATEGORY_CLASS			 = "职业UI"
ACE_CATEGORY_COMBAT			 = "战斗UI"
ACE_CATEGORY_COMPILATIONS	 = "接口增强"
ACE_CATEGORY_INTERFACE		 = "界面增强"
ACE_CATEGORY_INVENTORY		 = "物品UI"
ACE_CATEGORY_MAP			 = "地图UI"
ACE_CATEGORY_OTHERS			 = "其它UI"
ACE_CATEGORY_PROFESSIONS	 = "专业UI"
ACE_CATEGORY_QUESTS			 = "任务UI"
ACE_CATEGORY_RAID			 = "团队UI"

-- Profile locals 
ACE_PROFILE_DEFAULT			 = "default" 
ACE_PROFILE_LOADED_CHAR		 = "人物独立配置文件已经为 %s 加载."
ACE_PROFILE_LOADED_CLASS	 = "%s 职业的配置文件已经为 %s 加载."
ACE_PROFILE_LOADED_DEFAULT	 = "默认配置文件已经为 %s 加载."

-- Information locals 
ACE_INFO_HEADER				 = "|cffffff78Ace Information|r" 
ACE_INFO_NUM_ADDONS			 = "插件已加载"
ACE_INFO_PROFILE_LOADED		 = "配置文件已加载"

-- Chat handler locals 
ACE_COMMANDS				 = {"/ace"} 

ACE_CMD_OPT_HELP			 = "?"
ACE_CMD_OPT_HELP_DESC		 = "显示此插件额外信息."
ACE_CMD_OPT_STANDBY			 = "standby" 
ACE_CMD_OPT_STANDBY_DESC	 = "切换插件的挂起模式."
ACE_CMD_OPT_REPORT			 = "report" 
ACE_CMD_OPT_REPORT_DESC		 = "显示所有设置状态."
ACE_CMD_OPT_INVALID			 = "你输入的参数 '%s' 无效."
ACE_CMD_OPT_LIST_ADDONS		 = "插件列表"
ACE_CMD_OPT_LOAD_IS_LOADED	 = "%s 已经加载."
ACE_CMD_OPT_LOAD_ERROR		 = "%s 无法加载，因为 %s."
ACE_CMD_OPT_LOAD_LOADED		 = "%s 当前已加载."
ACE_CMD_OPT_AUTO_OFF_MSG	 = "%s 当游戏启动时将不再加载."
ACE_CMD_ERROR 				 = "|cffff6060[error]|r" 

ACE_CMD_ADDON_NOTFOUND		 = "未发现插件 '%s'."
ACE_CMD_ADDON_ENABLED		 = "%s 已标记启用. 你必须重新启动游戏来加载此插件." 
ACE_CMD_ADDON_ENABLED_ALL	 = "所有插件都已标记启用. 你必须重新启动游戏来加载先前未加载的插件 "
ACE_CMD_ADDON_DISABLED		 = "%s 已标记禁用 .但在你重新启动游戏前仍将保持加载状态." 
ACE_CMD_ADDON_DISABLED_ALL	 = "除Ace外的所有插件都已标记禁用,但在你重新启动游戏前它们仍将保持加载状态. " 

ACE_CMD_PROFILE_ADDON_ADDED = "%s 已经迁入配置. 当前配置文件: %s." 
ACE_CMD_PROFILE_ALL_ADDED	 = "所有插件都已迁入配置.当前配置文件: %s." 
ACE_CMD_PROFILE_ALL			 = "all" 
ACE_CMD_PROFILE_NO_PROFILE	 = "%s 没有可用的配置项目."

ACE_CMD_USAGE_ADDON_DESC	 = "|cffffff78[%s v%s]|r : %s" 
ACE_CMD_USAGE_HEADER		 = "|cffffff78用法:|r |cffd8c7ff%s|r %s"
ACE_CMD_USAGE_OPT_DESC		 = " - |cffffff78%s:|r %s" 
ACE_CMD_USAGE_OPT_SEP		 = " | " 
ACE_CMD_USAGE_OPT_OPEN		 = "[" 
ACE_CMD_USAGE_OPT_CLOSE		 = "]" 
ACE_CMD_USAGE_OPTION		 = "|cffd8c7ff%s %s|r %s" 
ACE_CMD_USAGE_NOINFO		 = "无补充信息"

ACE_CMD_RESULT				 = "|cffffff78%s:|r %s" 

ACE_CMD_REPORT_STATUS		 = "状态"
ACE_CMD_REPORT_LINE			 = "%s [|cfff5f530%s|r]" 
ACE_CMD_REPORT_LINE_PRE		 = " - " 
ACE_CMD_REPORT_LINE_INDENT	 = "   " 

ACE_CMD_REPORT_NO_VAL		 = "|cffc7c7c7no value|r" 

ACE_CMD_OPTIONS				 = { 
	 { 
		 option	 = "enable", 
		 desc	 = "将一个插件标记为启用.", 
		 method	 = "EnableAddon" 
	 }, 
	 { 
		 option	 = "disable", 
		 desc	 = "将一个插件标记为禁用.", 
		 method	 = "DisableAddon" 
	 }, 
	 { 
		 option	 = "info", 
		 desc	 = "显示插件和当前配置文件信息.", 
		 method	 = "DisplayInfo" 
	 }, 
	 { 
		 option	 = "list", 
		 desc	 = "列出当前已经加载的插件. 你还可以在该命令后输入插件名称来搜索它.", 
		 method	 = "ListAddons", 
		 args	 = { 
			 { 
				 option	 = "ace", 
				 desc	 = "列出当前已加载的 ace 插件.", 
				 method	 = "ListAddonsAce" 
			 }, 
			 { 
				 option	 = "other", 
				 desc	 = "列出所有其它插件.", 
				 method	 = "ListAddonsOther" 
			 }, 
			 { 
				 option	 = "loadable", 
				 desc	 = "列出所有可以被加载的插件.", 
				 method	 = "ListAddonsLoadable" 
			 } 
		 } 
	 }, 
	 { 
		 option	 = "load", 
		 desc	 = "加载一个当前未加载的被要求加载插件.", 
		 input	 = 1, 
		 method	 = "LoadAddon", 
		 args	 = { 
			 { 
				 option	 = "auto", 
				 desc	 = "加载一个插件并且标记其在游戏启动时自动加载.", 
				 method	 = "LoadAddonAuto" 
			 }, 
			 { 
				 option	 = "off", 
				 desc	 = "关闭被要求加载插件在游戏启动时自动加载.", 
				 method	 = "LoadAddonOff" 
			 } 
		 } 
	 }, 
	 { 
		 option	 = "loadmsg", 
		 desc	 = "更改游戏启动或者重新加载时的加载信息.", 
		 args	 = { 
			 { 
				 option	 = "addon", 
				 desc	 = "为每一个插件显示一个加载信息.", 
				 method	 = "ChangeLoadMsgAddon" 
			 }, 
			 { 
				 option	 = "none", 
				 desc	 = "不显示加载信息.", 
				 method	 = "ChangeLoadMsgNone" 
			 }, 
			 { 
				 option	 = "sum", 
				 desc	 = "显示概要信息.", 
				 method	 = "ChangeLoadMsgSum" 
			 } 
		 }, 
	 }, 
	 { 
		 option	 = "profile", 
		 desc	 = "加载以下三种之一的配置文件: Char(人物), class(职业), 或者 default(默认). 如果指"..
				   "定的配置文件不存在,将会创建一个新的空配置文件. 你的人物以及职业配置文件将"..
				   "继续使用默认的插件设置直到你将插件迁入到其中. 一旦你迁入了一个插件到配置"..
				   "文件中, 任何对该插件设置的更改, 都将被设置在当前的配置文件中.", 
		 args	 = { 
			 { 
				 option	 = "char", 
				 desc	 = "加载所用人物的配置文件. 输入 'all' 或者指定一个插件"..
						   "名称将插件迁入到配置文件中.", 
				 method	 = "UseProfileChar", 
			 }, 
			 { 
				 option	 = "class", 
				 desc	 = "加载所用人物职业的配置文件. 输入 'all' 或者指定一个插件"..
						   "名称将插件迁入到配置文件中.", 
				 method	 = "UseProfileClass" 
			 }, 
			 { 
				 option	 = ACE_PROFILE_DEFAULT, 
				 desc	 = "加载所用人物的默认配置文件. 此配置文件自动将所有插件"..
						   "迁入到其中.", 
				 method	 = "UseProfileDefault" 
			 }, 
		 }, 
	 } 
} 

end

