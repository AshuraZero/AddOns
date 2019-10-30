--localization for CN Classic

	CT_ITEMREG = "(|c%x+|Hitem:%d+:%d+:%d+:%d+:%d+:%d+:(%-?%d+):(%-?%d+):%d+|h%[.-%]|h|r)%";
	CT_ITEMREG_MULTI = "(|c%x+|Hitem:%d+:%d+:%d+:%d+:%d+:%d+:(%-?%d+):(%-?%d+):%d+|h%[.-%]|h|r)x(%d+)%";

	CT_RaidTracker_lang_LeftGroup = "([^%s]+)离开了团队。";
	CT_RaidTracker_lang_JoinedGroup = "([^%s]+)加入了团队。";
	CT_RaidTracker_lang_ReceivesLoot1 = "([^%s]+)获得了物品："..CT_ITEMREG.."。";
	CT_RaidTracker_lang_ReceivesLoot2 = "你获得了物品："..CT_ITEMREG.."。";
	CT_RaidTracker_lang_ReceivesLoot3 = "([^%s]+)得到了物品："..CT_ITEMREG_MULTI.."。";
	CT_RaidTracker_lang_ReceivesLoot4 = "你得到了物品："..CT_ITEMREG_MULTI.."。";
	CT_RaidTracker_lang_ReceivesLootYou = "你";

	CT_RaidTracker_lang_BossKills_Majordomo_Yell = "不……不可能！等一下……我投降！我投降！";
	CT_RaidTracker_lang_BossKills_Majordomo_BossName = "管理者埃克索图斯";
	CT_RaidTracker_lang_BossKills_Ignore_Razorgore_Yell = "我自由了！ 那个东西再也不能折磨我了！";

	PlayerGroupsIndexes = {"战士","牧师","法师","潜行者","圣骑士","德鲁伊","术士","萨满祭司","猎人","未知职业"};

	RAID_CLASS_COLORS_CN = {
              ["猎人"] = { r = 0.67, g = 0.83, b = 0.45 },
              ["术士"] = { r = 0.58, g = 0.51, b = 0.79 },
              ["牧师"] = { r = 1.0, g = 1.0, b = 1.0 },
              ["圣骑士"] = { r = 0.96, g = 0.55, b = 0.73 },
              ["法师"] = { r = 0.41, g = 0.8, b = 0.94 },
              ["潜行者"] = { r = 1.0, g = 0.96, b = 0.41 },
              ["德鲁伊"] = { r = 1.0, g = 0.49, b = 0.04 },
              ["萨满祭司"] = { r = 0.14, g = 0.35, b = 1.0 },
              ["战士"] = { r = 0.78, g = 0.61, b = 0.43 },
              ["未知职业"] = { r = 1.0, g = 1.0, b = 1.0 },
	}

	CT_RaidTracker_Zones = {
        "熔火之心",
        "黑翼之巢",
        "祖尔格拉布",
        "奥妮克希亚的巢穴",
        "安其拉神殿",
        "安其拉废墟",
        "纳克萨玛斯"
    };

	CT_RaidTracker_Bosses = {
		["熔火之心"] = {
			"鲁西弗隆",
			"玛格曼达",
			"基赫纳斯",
			"加尔",
			"沙斯拉尔",
			"迦顿男爵",
			"焚化者古雷曼格",
			"萨弗隆先驱者",
			"管理者埃克索图斯",
			"拉格纳罗斯",
		},
		["黑翼之巢"] = {
			"狂野的拉佐格尔",
			"堕落的瓦拉斯塔兹",
			"勒什雷尔",
			"费尔默",
			"埃博诺克",
			"弗莱格尔",
			"克洛玛古斯",
			"奈法利安",
		},
		["祖尔格拉布"] = {
			"高阶祭司耶克里克",
			"高阶祭司温诺希斯",
			"高阶祭司玛尔里",
			"高阶祭司塞卡尔",
			"高阶祭司娅尔罗",
			"哈卡",
			"血领主曼多基尔",
			"哈扎拉尔",
			"加兹兰卡",
			"乌苏雷",
			"妖术师金度",
			"格里雷克",
			"雷纳塔基",
		},
		["安其拉废墟"] = {
			"库林纳克斯",
			"拉贾克斯将军",
			"吞咽者布鲁",
			"狩猎者阿亚米斯",
			"莫阿姆",
			"无疤者奥斯里安",
		},
		["安其拉"] = {
			"预言者斯克拉姆",
			"克里勋爵",
			"亚尔基公主",
			"维姆",
			"沙尔图拉",
			"顽强的范克瑞斯",
			"哈霍兰公主",
			"维希度斯",
			"维克尼拉斯大帝",
			"维克洛尔大帝",
			"奥罗",
			"克苏恩",
		},
		["纳克萨玛斯"] = {
			"阿努布雷坎",
			"教官拉苏维奥斯",
			"收割者戈提克",
			"大领主莫格莱尼",
			"瘟疫使者诺斯",
			"肮脏的希尔盖",
			"洛欧塞布",
			"迈克斯纳",
			"黑女巫法琳娜",
			"帕奇维克",
			"格罗布鲁斯",
			"格拉斯",
			"塔迪乌斯",
			"萨菲隆",
			"克尔苏加德",
			"大领主莫格莱尼",
			"库尔塔兹领主",
			"女公爵布劳缪克斯",
			"瑟里耶克爵士",
		},
		["奥妮克希亚的巢穴"] = {
			"奥妮克希亚",
		},
        ["奥妮克希亚"] = 1,
		["世界首领"] = {
            "卡扎克",
            "艾索雷葛斯",
            "莱索恩",
            "泰拉尔",
            "艾莫莉丝",
            "伊森德雷",
		},
		["小怪掉落"] = 1,
	};

	CT_RaidTracker_ZoneTriggers = {
			["熔火之心"] = "熔火之心",
			["黑翼之巢"] = "黑翼之巢",
			["祖尔格拉布"] = "祖尔格拉布",
			["奥妮克希亚的巢穴"] = "奥妮克希亚的巢穴",
			["安其拉"] = "安其拉",
			["安其拉废墟"] = "安其拉废墟",
			["纳克萨玛斯"] = "纳克萨玛斯",
	};
	CT_RaidTracker_BossUnitTriggers = {

	--MC
		["鲁西弗隆"] = "鲁西弗隆", --Lucifron
		["玛格曼达"] = "玛格曼达", --Magmadar
		["基赫纳斯"] = "基赫纳斯", --Gehennas
		["加尔"] = "加尔", --Garr
		["迦顿男爵"] = "迦顿男爵", --Baron Geddon
		["沙斯拉尔"] = "沙斯拉尔", --Shazzrah
		["萨弗隆先驱者"] = "萨弗隆先驱者", --Sulfuron Harbinger
		["焚化者古雷曼格"] = "焚化者古雷曼格", --Golemagg the Incinerator
		["管理者埃克索图斯"] = "管理者埃克索图斯", --Majordomo Executus
		["拉格纳罗斯"] = "拉格纳罗斯", --Ragnaros
		["熔火恶犬"] = "IGNORE", --Core Hound
		["火誓者"] = "IGNORE", --Firesworn
		["熔火怒犬"] = "IGNORE", --Core Rager
		["烈焰行者医师"] = "IGNORE", --Flamewaker Healer
		["烈焰行者精英"] = "IGNORE", --Flamewaker Elite
		["烈焰之子"] = "IGNORE", --Son of Flame
		["上古熔火恶犬"] = "IGNORE",
		["火焰之王"] = "IGNORE",
		["火焰行者"] = "IGNORE",
		["烈焰小鬼"] = "IGNORE",
		["烈焰之子"] = "IGNORE",
		["烈焰守卫"] = "IGNORE",
		["烈焰行者祭司"] = "IGNORE",
		["烈焰行者护卫"] = "IGNORE",
		["熔岩元素"] = "IGNORE",
		["熔岩爪牙"] = "IGNORE",
		["熔岩奔腾者"] = "IGNORE",
		["熔岩掠夺者"] = "IGNORE",
		["熔岩歼灭者"] = "IGNORE",
		["熔核巨人"] = "IGNORE",
		["熔核摧毁者"] = "IGNORE",
		
	--BWL
		["狂野的拉佐格尔"] = "狂野的拉佐格尔", --Razorgore the Untamed"
		["堕落的瓦拉斯塔兹"] = "堕落的瓦拉斯塔兹", --Vaelastrasz the Corrupt
		["勒什雷尔"] = "勒什雷尔", --Broodlord Lashlayer
		["费尔默"] = "费尔默", --Firemaw
		["埃博诺克"] = "埃博诺克", --Ebonroc
		["弗莱格尔"] = "弗莱格尔", --Flamegor
		["克洛玛古斯"] = "克洛玛古斯", --Chromaggus
		["奈法利安"] = "奈法利安", --Nefarian
		["维克多·奈法里奥斯"] = "奈法利安", --Lord Victor Nefarius
		["黑翼控制者"] = "IGNORE", --Grethok the Controller
		["黑翼卫士"] = "IGNORE", --Blackwing Guardsman
		["黑翼军团士兵"] = "IGNORE", --Blackwing Legionnaire
		["黑翼法师"] = "IGNORE", --Blackwing Mage
		["死爪龙人"] = "IGNORE", --Death Talon Dragonspawn
		["黑色龙兽"] = "IGNORE", --Black Drakonid
		["蓝色龙兽"] = "IGNORE", --Blue Drakonid
		["青铜龙兽"] = "IGNORE", --Bronze Drakonid
		["绿色龙兽"] = "IGNORE", --Green Drakonid
		["红色龙兽"] = "IGNORE", --Red Drakonid
		["多彩龙兽"] = "IGNORE", --Chromatic Drakonid
		["白骨魔像"] = "IGNORE", --Bone Construct
		["堕落地狱火"] = "IGNORE", --Corrupted Infernal
		["腐化的蓝色雏龙"] = "IGNORE", --Corrupted Blue Whelp
		["腐化的红色雏龙"] = "IGNORE", --Corrupted Red Whelp
		["腐化的绿色雏龙"] = "IGNORE", --Corrupted Green Whelp
		["腐化的青铜雏龙"] = "IGNORE", --Corrupted Bronze Whelp
		["死爪地卜师"] = "IGNORE", --Death Talon Hatcher
		["黑翼工头"] = "IGNORE", --Blackwing Taskmaster
		
	--ZG
		["高阶祭司耶克里克"] = "高阶祭司耶克里克", --High Priestess Jeklik
		["高阶祭司温诺希斯"] =	"高阶祭司温诺希斯", --High Priest Venoxis
		["高阶祭司玛尔里"] =	"高阶祭司玛尔里", --High Priestess Mar'li
		["高阶祭司塞卡尔"] = "高阶祭司塞卡尔", --High Priest Thekal
		["高阶祭司娅尔罗"] = "高阶祭司娅尔罗", --High Priestess Arlokk
		["哈卡"] = "哈卡", --Hakkar
		["血领主曼多基尔"] = "血领主曼多基尔", --Bloodlord Mandokir
		["妖术师金度"] = "妖术师金度", --Jin'do the Hexxer
		["加兹兰卡"] = "加兹兰卡", --Gahz'ranka
		["哈扎拉尔"] = "哈扎拉尔", --Hazza'rah
		["格里雷克"] = "格里雷克", --Gri'lek
		["雷纳塔基"] = "雷纳塔基", --Renataki
		["乌苏雷"] = "乌苏雷", --Wushoolay
		["祖利安徘徊者"] = "IGNORE", --Zulian Prowler
		["祖利安守护者"] = "IGNORE", --Zulian Guardian
		["寄居蛇"] = "IGNORE", --Parasitic Serpent
		["玛尔里的爪牙"] = "IGNORE", --Spawn of Mar'li
		["奥根"] = "IGNORE", --Ohgan
		["疯狂的觅血蝙蝠"] = "IGNORE", --Frenzied Bloodseeker Bat
		["毒性云雾"] = "IGNORE", --Poisonous Cloud
		["古拉巴什狂暴者"] = "IGNORE",
		["古拉巴什勇士"] = "IGNORE",
		["古拉巴什乘蝠者"] = "IGNORE",
		["古拉巴什饮血者"] = "IGNORE",
		["古拉巴什掷斧者"] = "IGNORE",
		["古拉巴什猎头者"] = "IGNORE",
		["巨型喷泉"] = "IGNORE",
		["血顶食人妖大使"] = "IGNORE",
		["血顶部族演讲者"] = "IGNORE",
		["巫毒奴隶"] = "IGNORE",
		["沙怒食人妖大使"] = "IGNORE",
		["沙怒部族演讲者"] = "IGNORE",
		["狂热者札斯"] = "IGNORE",
		["邪枝食人妖大使"] = "IGNORE",
		["邪枝部族演讲者"] = "IGNORE",
		["拉札希迅猛龙"] = "IGNORE",
		["拉札希奎蛇"] = "IGNORE",
		["拉札希毒液蜘蛛"] = "IGNORE",
		["拉札希寡妇蜘蛛"] = "IGNORE",
		["拉札希诱捕者"] = "IGNORE",
		["拉沙希毒蛇"] = "IGNORE",
		["拉沙希眼镜蛇"] = "IGNORE",
		["金度之影"] = "IGNORE",
		["阿塔莱侍女"] = "IGNORE",
		["哈卡之子"] = "IGNORE",
		["哈卡莱巫医"] = "IGNORE",
		["哈卡莱高阶祭司"] = "IGNORE",
		["哈卡莱祭司"] = "IGNORE",
		["哈卡莱暗影法师"] = "IGNORE",
		["枯木食人妖大使"] = "IGNORE",
		["枯木部族演讲者"] = "IGNORE",
		["洗脑图腾"] = "IGNORE",
		["祖利安幼虎"] = "IGNORE",
		["祖利安守护者"] = "IGNORE",
		["祖利安捕猎者"] = "IGNORE",
		["祖利安徘徊者"] = "IGNORE",
		["祖利安猛虎"] = "IGNORE",
		["祖利安雌猎虎"] = "IGNORE",
		["祖利安鳄鱼"] = "IGNORE",
		["衰老的侍女"] = "IGNORE",
		["强力治疗结界"] = "IGNORE",
		["眼镜王蛇"] = "IGNORE",
		["祭品食人妖"] = "IGNORE",
		["被召唤的骷髅"] = "IGNORE",
		["被禁锢的灵魂"] = "IGNORE",
		["觅血蝙蝠"] = "IGNORE",
		["无眠者赞札"] = "IGNORE",
		["超强治疗结界"] = "IGNORE",
		["梦魔幻象"] = "IGNORE",
		["玛尔里的爪牙"] = "IGNORE",
		["疯狂虚空行者"] = "IGNORE",
		["疯狂仆从"] = "IGNORE",
		["劈颅食人妖大使"] = "IGNORE",
		["劈颅部族演讲者"] = "IGNORE",
		["灵魂掠夺者"] = "IGNORE",

	--Onyx	
		["奥妮克希亚"] = "奥妮克希亚", --Onyxia
		["奥妮克希亚雏龙"] = "IGNORE", --Onyxian Whelp
		["奥妮克希亚守卫"] = "IGNORE", --Onyxian Warder
		
		["卡扎克"] = "卡扎克", --Lord Kazzak
		["艾索雷葛斯"] = "艾索雷葛斯", --Azuregos
		["伊森德雷"] = "伊森德雷", --Ysondre
		["泰拉尔"] = "泰拉尔", --Taerar
		["艾莫莉丝"] = "艾莫莉丝", --Emeriss
		["莱索恩"] = "莱索恩", --Lethon

		["泰拉尔之影"] = "IGNORE", --Shade of Taerar
		["灵魂之影"] = "IGNORE", --Spirit Shade
		["疯狂的德鲁伊灵魂"] = "IGNORE", --Demented Druid Spirit
		
	--RAQ
		["库林纳克斯"] = "库林纳克斯", --Kurinnaxx
		["拉贾克斯将军"] = "拉贾克斯将军", --General Rajaxx
		["狩猎者阿亚米斯"] = "狩猎者阿亚米斯", --Ayamiss the Hunter
		["吞咽者布鲁"] = "吞咽者布鲁", --Buru The Gorger
		["莫阿姆"] = "莫阿姆", --Moam
		["无疤者奥斯里安"] = "无疤者奥斯里安", --Ossirian The Unscarred
		["布鲁的卵"] = "IGNORE", --Buru Egg
		["运河狂鱼"] = "IGNORE", --Canal Frenzy
		["法力恶魔"] = "IGNORE", --Mana Fiend
		["硅酸盐吞噬者"] = "IGNORE", --Silicate Feeder
		["札拉雏虫"] = "IGNORE", --Hive'Zara Hatchling
		["维克尼斯雏虫"] = "IGNORE", --Vekniss Hatchling
		["阿努比萨斯战士"] = "IGNORE", --Anubisath Warrior
		["甲壳虫"] = "IGNORE",
		["卡多雷精英"] = "IGNORE",
		["札拉士兵"] = "IGNORE",
		["札拉幼虫"] = "IGNORE",
		["札拉沙行者"] = "IGNORE",
		["札拉毒蝎"] = "IGNORE",
		["札拉采集者"] = "IGNORE",
		["札拉异种蝎"] = "IGNORE",
		["札拉雄蜂"] = "IGNORE",
		["札拉黄蜂"] = "IGNORE",
		["札拉虫群"] = "IGNORE",
		["安多洛夫中将"] = "IGNORE",
		["血肉猎手"] = "IGNORE",
		["邪恶的甲虫"] = "IGNORE",
		["其拉角斗士"] = "IGNORE",
		["其拉战士"] = "IGNORE",
		["其拉虫群卫士"] = "IGNORE",
		["阿努比萨斯守卫者"] = "IGNORE",
		["阿努比萨斯战士"] = "IGNORE",
		["阿努比萨斯虫群卫士"] = "IGNORE",
		["黑曜石毁灭者"] = "IGNORE",
		["喷液甲虫"] = "IGNORE",
		["食脑甲虫"] = "IGNORE",
		["虫群守卫尼德勒"] = "IGNORE",
		["帕康少校"] = "IGNORE",
		["德兰上尉"] = "IGNORE",
		["泽朗上校"] = "IGNORE",
		["叶吉斯少校"] = "IGNORE",
		["瑟瑞姆上尉"] = "IGNORE",
		["奎兹上尉"] = "IGNORE",

	--taq	
		["预言者斯克拉姆"] = "预言者斯克拉姆",
		["克里勋爵"] = "克里勋爵",
		["亚尔基公主"] = "亚尔基公主",
		["维姆"] = "维姆",
		["沙尔图拉"] = "沙尔图拉",
		["顽强的范克瑞斯"] = "顽强的范克瑞斯",
		["哈霍兰公主"] = "哈霍兰公主",
		["维希度斯"] = "维希度斯",
		["维克尼拉斯大帝"] = "维克尼拉斯大帝",
		["维克洛尔大帝"] = "维克洛尔大帝",
		["奥罗"] = "奥罗",
		["克苏恩"] = "克苏恩",
		["其拉甲虫"] = "IGNORE",
		["其拉蝎虫"] = "IGNORE",
		["奥罗甲虫"] = "IGNORE", --Ouro Scarab
		["范克里斯的爪牙"] = "IGNORE", --Spawn of Fankriss
		["其拉蝎虫"] = "IGNORE", --Qiraji Scorpion
		["其拉甲虫"] = "IGNORE", --Qiraji Scarab
		["邪恶的甲虫 "] = "IGNORE", --Vile Scarab
		["亚尔基的子嗣"] = "IGNORE", --Yauj Brood
		["沙尔图拉皇家卫士"] = "IGNORE", --Sartura's Royal Guard
		["毒性云雾"] = "IGNORE", --Poison Cloud
		["维克尼斯雄蜂"] = "IGNORE", --Vekniss Drone
		["维希度斯水滴"] = "IGNORE", --Glob of Viscidus

	--nax		
		["阿努布雷坎"] = "阿努布雷坎",
		["教官拉苏维奥斯"] = "教官拉苏维奥斯",
		["收割者戈提克"] = "收割者戈提克",
		["大领主莫格莱尼"] = "大领主莫格莱尼",
		["瘟疫使者诺斯"] = "瘟疫使者诺斯",
		["肮脏的希尔盖"] = "肮脏的希尔盖",
		["洛欧塞布"] = "洛欧塞布",
		["迈克斯纳"] = "迈克斯纳",
		["黑女巫法琳娜"] = "黑女巫法琳娜",
		["帕奇维克"] = "帕奇维克",
		["格罗布鲁斯"] = "格罗布鲁斯",
		["格拉斯"] = "格拉斯",
		["塔迪乌斯"] = "塔迪乌斯",
		["萨菲隆"] = "萨菲隆",
		["克尔苏加德"] = "克尔苏加德",
		["大领主莫格莱尼"] = "大领主莫格莱尼",
		["库尔塔兹领主"] = "库尔塔兹领主",
		["女公爵布劳缪克斯"] = "女公爵布劳缪克斯",
		["瑟里耶克爵士"] = "瑟里耶克爵士",

		["棕色蟒蛇"] = "IGNORE",
		["青蛙"] = "IGNORE",
		["老鼠"] = "IGNORE",
		["蟑螂"] = "IGNORE",
		["小蛇"] = "IGNORE",
		["蛇"] = "IGNORE",
		["蝎子"] = "IGNORE",
		["修理机器人74A型"] = "IGNORE", --Field Repair Bot 74A
		["战地修理机器人110G"]= "IGNORE",

		["杂斑野猪"] = "IGNORE",
		
		["DEFAULTBOSS"] = "小怪掉落",
	};

--end