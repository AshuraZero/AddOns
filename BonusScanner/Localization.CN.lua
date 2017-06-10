if (LOCALE_zhCN) then

-- bonus names
BONUSSCANNER_NAMES = {	
	STR 		= "力量",
	AGI 		= "敏捷",
	STA 		= "耐力",
	INT 		= "智力",
	SPI 		= "精神",
	ARMOR 		= "护甲",

	ARCANERES 	= "奥术抗性",	
	FIRERES 	= "火焰抗性",
	NATURERES 	= "自然抗性",
	FROSTRES 	= "冰霜抗性",
	SHADOWRES 	= "暗影抗性",

	FISHING 	= "钓鱼",
	MINING 		= "采矿",
	HERBALISM 	= "草药",
	SKINNING 	= "剥皮",
	DEFENSE 	= "防御",
	
	BLOCK 		= "格挡",
	DODGE 		= "闪避",
	PARRY 		= "招架",
	ATTACKPOWER = "攻击强度",
	CRIT 		= "致命一击",
	RANGEDATTACKPOWER = "远程攻击强度",
	RANGEDCRIT 	= "远程致命一击",
	TOHIT 		= "命中率",

	DMG 		= "法术伤害",
	ARCANEDMG 	= "奥术法术伤害",
	FIREDMG 	= "火焰法术伤害",
	FROSTDMG 	= "冰霜法术伤害",
	HOLYDMG 	= "神圣法术伤害",
	NATUREDMG 	= "自然法术伤害",
	SHADOWDMG 	= "暗影法术伤害",
	SPELLCRIT 	= "法术致命一击",
	SPELLTOHIT 	= "法术命中率",
	HEAL 		= "治疗",
	HOLYCRIT 	= "神圣法术致命一击",

	HEALTHREG 	= "生命恢复",
	MANAREG 	= "法力恢复",
	HEALTH 		= "生命值",
	MANA 		= "法力值"
};

-- equip and set bonus prefixes:
BONUSSCANNER_PREFIX_EQUIP = "装备： ";
BONUSSCANNER_PREFIX_SET = "设定:  ";

-- passive bonus patterns. checked against lines which start with above prefixes
BONUSSCANNER_PATTERNS_PASSIVE = {
	{ pattern = "+(%d+)远程攻击强度。", effect = "RANGEDATTACKPOWER" },
	{ pattern = "使你用盾牌格挡攻击的几率提高(%d+)%%。", effect = "BLOCK" },
	{ pattern = "使你躲闪攻击的几率提高(%d+)%%。", effect = "DODGE" },
	{ pattern = "使你招架攻击的几率提高(%d+)%%。", effect = "PARRY" },
	{ pattern = "使你的法术造成致命一击的几率提高(%d+)%%。", effect = "SPELLCRIT" },
	{ pattern = "使你的神圣系法术的致命一击和极效治疗几率提高(%d+)%%。", effect = "HOLYCRIT" },
	{ pattern = "使你的神圣法术所造成的致命一击伤害(%d+)%%。", effect = "HOLYCRIT" },
	{ pattern = "使你造成致命一击的几率提高(%d+)%%。", effect = "CRIT" },
	{ pattern = "使你远程远程武器致命一击率提高(%d+)%%。", effect = "RANGEDCRIT" },
	{ pattern = "提高奥术法术和效果所造成的伤害，最多(%d+)点。", effect = "ARCANEDMG" },
	{ pattern = "提高火焰法术和效果所造成的伤害，最多(%d+)点。", effect = "FIREDMG" },
	{ pattern = "提高冰霜法术和效果所造成的伤害，最多(%d+)点。", effect = "FROSTDMG" },
	{ pattern = "提高神圣法术和效果所造成的伤害，最多(%d+)点。", effect = "HOLYDMG" },
	{ pattern = "提高自然法术和效果所造成的伤害，最多(%d+)点。", effect = "NATUREDMG" },
	{ pattern = "提高暗影法术和效果所造成的伤害，最多(%d+)点。", effect = "SHADOWDMG" },
	{ pattern = "提高法术所造成的治疗效果，最多(%d+)点。", effect = "HEAL" },
	{ pattern = "提高所有法术和魔法效果所造成的伤害和治疗效果，最多(%d+)点。", effect = {"HEAL", "DMG"} },
	{ pattern = "每5秒回复(%d+)点生命值。", effect = "HEALTHREG" }, 
	{ pattern = "每5秒恢复(%d+)点生命值。", effect = "HEALTHREG" },  -- both versions ('per' and 'every') seem to be used
	{ pattern = "每5秒恢复(%d+)点法力值。", effect = "MANAREG" },
	{ pattern = "每5秒回复(%d+)点法力值。", effect = "MANAREG" },
	{ pattern = "使你击中目标的几率提高(%d+)%%。", effect = "TOHIT" },
	{ pattern = "使你的法术击中敌人的几率提高(%d+)%%。", effect = "SPELLTOHIT" }
};

-- generic patterns have the form "+xx bonus" or "bonus +xx" with an optional % sign after the value.

-- first the generic bonus string is looked up in the following table
BONUSSCANNER_PATTERNS_GENERIC_LOOKUP = {
	["所有属性"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
	["力量"]			    = "STR",
	["敏捷"]				= "AGI",
	["耐力"]				= "STA",
	["智力"]			    = "INT",
	["精神"] 				= "SPI",

	["所有抗性"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},

	["钓鱼"]				= "FISHING",
	["鱼饵"]		= "FISHING",
	["钓鱼技能提高"]	= "FISHING",
	["采矿"]				= "MINING",
	["草药"]			= "HERBALISM",
	["剥皮"]			= "SKINNING",
	["防御"]				= "DEFENSE",
	["防御技能"]	= "DEFENSE",

	["攻击强度"] 		= "ATTACKPOWER",
	["躲闪"] 				= "DODGE",
	["格挡"]				= "BLOCK",
	["命中"] 				= "TOHIT",
	["法术命中"]			= "SPELLTOHIT",
	["格挡"]			= "BLOCK",
	["远程攻击强度"] = "RANGEDATTACKPOWER",
	["每5秒回复生命"] = "HEALTHREG",
	["治疗法术"] 		= "HEAL",
	["提高治疗"] 	= "HEAL",
	["治疗效果和法术伤害"] = {"HEAL", "DMG"},
	["治疗效果和伤害"] = {"HEAL", "DMG"},
	["治疗效果和法术伤害"] = {"HEAL", "DMG"},	
	["每5秒恢复法力"] 	= "MANAREG",
	["法力恢复"] 			= "MANAREG",
	["法术伤害"] 		= "DMG",
	["致命一击"] 			= "CRIT",
	["致命一击"] 		= "CRIT",
	["伤害"] 				= "DMG",
	["治疗"]				= "HEALTH",
	["生命值"]					= "HEALTH",
	["法力值"]				= "MANA",
	["护甲"]				= "ARMOR",
	["强化护甲"]	= "ARMOR",
};	

-- next we try to match against one pattern of stage 1 and one pattern of stage 2 and concatenate the effect strings
BONUSSCANNER_PATTERNS_GENERIC_STAGE1 = {
	{ pattern = "奥术", 	effect = "ARCANE" },	
	{ pattern = "火焰", 	effect = "FIRE" },	
	{ pattern = "冰霜", 	effect = "FROST" },	
	{ pattern = "神圣", 	effect = "HOLY" },	
	{ pattern = "暗影",	effect = "SHADOW" },	
	{ pattern = "自然", 	effect = "NATURE" }
}; 	

BONUSSCANNER_PATTERNS_GENERIC_STAGE2 = {
	{ pattern = "抗性", 	effect = "RES" },	
	{ pattern = "伤害", 	effect = "DMG" },
	{ pattern = "效果", 	effect = "DMG" },
}; 	

-- finally if we got no match, we match against some special enchantment patterns.
BONUSSCANNER_PATTERNS_OTHER = {
	{ pattern = "每5秒恢复法力(%d+)。", effect = "MANAREG" },
	{ pattern = "赞达拉力量徽记", effect = "ATTACKPOWER", value = 30 },
	{ pattern = "赞达拉魔法徽记", effect = {"DMG", "HEAL"}, value = 18 },
	{ pattern = "赞达拉宁静徽记", effect = "HEAL", value = 33 },
	
	{ pattern = "初级巫师之油", effect = {"DMG", "HEAL"}, value = 8 },
	{ pattern = "次级巫师之油", effect = {"DMG", "HEAL"}, value = 16 },
	{ pattern = "巫师之油", effect = {"DMG", "HEAL"}, value = 24 },
	{ pattern = "卓越巫师之油", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

	{ pattern = "初级法力之油", effect = "MANAREG", value = 4 },
	{ pattern = "次级法力之油", effect = "MANAREG", value = 8 },
	{ pattern = "卓越法力之油", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
};


end