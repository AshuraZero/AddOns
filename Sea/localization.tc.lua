if (GetLocale()=="zhTW") then

-- Version : Chinese ( by iWOW)
-- Last Update : 03/21/2005

SEA_HERB_LIST = {
		"寧神花",
		"銀葉草",
		"地根草",
		-- Tuatara: removed as I can't find any reference to this in my research
		--"Snakeroot", 
		"魔皇草",
		"石南草",
		"雨燕草",
		"荊棘藻",
		"跌打草",
		"野鋼花",
		"墓地苔",
		"皇血草",
		"活根草",
		"枯葉草",
		"卡德加的胡鬚",
		"冬刺草",
		"火焰花",
		"紫蓮花",
		"太陽草",
		"盲目草",
		"幽靈菇",
		"格羅姆之血",
		"金棘草",
	};

SEA_ORE_LIST = {
		"銅礦石",
		"錫礦石",
		"銀礦石",
		"鐵礦石",
		"金礦石",
		"秘銀礦石",
		"真銀礦石",
		"瑟銀礦石",
	};

SEA_GEM_LIST = {
		"孔雀石",
		"綠瑪瑙",
		"虎眼石",
		"黃水晶",
		"翡翠",
		"暗影石",
		"青綠石",
		"藍珍珠",
		"黑珍珠",
		"金珍珠",
		"紅寶石",
	};

SEA_POTION_LIST = {
		"藥水",
		"藥劑",
		"油",	
		"聖泉之水"
	};

SEA_CLOTH_LIST = {
		"亞麻",
		"布",
		"毛",
		"絲",
		"魔紋",
		"符文布",
		"惡魔布",
		"月布"
	};
SEA_LEATHER_LIST =  {
		"黑龍鱗片",
		"黑色雛龍鱗片",
		"藍龍鱗片",
		"奇美拉皮革",
		"飛蛇鱗片",
		"霜刃豹皮革",
		"綠龍鱗片",
		"綠色幼龍鱗片",
		"重皮",
		"重毛皮",
		"厚蠍鱗",
		"輕皮",
		"輕毛皮",
		"中皮",
		"中毛皮",
		"完美的飛蛇鱗片",
		"紅龍鱗片",
		"紅色雛龍鱗片",
		"硬甲皮",
		"硬甲毛皮",
		"破爛的皮革",
		"蠍殼",
		"暗影獵豹毛皮",
		"厚重的雪人皮",
		"厚皮",
		"厚毛皮",
		"厚狼皮",
		"龜殼",
		"戰熊皮",
		"龍鱗",
	};

SEA_LEATHERWORKING_LIST = {
		"熟化輕毛皮",
		"熟化中毛皮",
		"熟化重毛皮",
		"熟化厚毛皮",
		"熟化毛皮",
	};	

SEA_FISHING_LIST = {
		"閃光的小珠",
		"明亮的小珠",
		"夜色蟲",
		"魚竿",
		"水下誘魚器",
	};

SEA_WARLOCK_LIST = {
		"靈魂碎片",
		"治療石",
		"法術石",
		"靈魂石",
		"火焰石",
	};

SEA_SHAMAN_LIST = {
		"大地圖騰",
		"火焰圖騰",
		"水之圖騰",
		"空氣圖騰",
		"靈契",
	};

SEA_MAGE_LIST =  {
		"法力瑪瑙",
		"法力翡翠",
		"法力黃水晶",
		"法力紅寶石",
	};

SEA_FOOD_LIST =  {
		"剛出爐的面包",
		"莫高雷香料面包",
		"軟香蕉面包",
		"大塊的硬面包",
		"玉米面包",
		"肉排",
		"羊排",
		"野豬火腿",
		"硬肉干",
		"暴風城奶酪",
		"陳年干酪",
		"奧特蘭克冷酪",
		"金皮蘋果",
		"熟透的西瓜",
		"多汁的西瓜",
		"泰拉比姆香蕉",
		"熏肉",
		"達拉然奶酪",
		"達納蘇斯奶酪",
		"矮人奶酪",
		"燒烤狼肉",
		"香辣狼肉",
		"烤野豬肉",
		"熱狼排",
		"滑皮鯖魚",
		"美味小魚",
		-- Tuatara: Item doesn't exist from my research
		--"Kaldorei Caviar",
		"蠍肉大餐",
		"啤酒烤豬排",
		"熏熊肉",
		"烤科多肉",
		"長嘴泥鰍",
		"彩鰭魚",
		"刺脊比目魚",
		"燉陸行鳥",
		"狂魚肉片",
		"水煮蚌肉",
		"豬肝餡餅",
		"洛克湖狂魚",
		"山狗肉排",
		"血腸",
		"西部荒野燉肉",
		"蟹肉蛋糕",
		"脆炸蜥蜴尾",
		"多汁豬排",
		"鱷魚肉排",
		"美味風蛇",
		"蠍肉大餐",
		"煮蟹爪",
		"掘地鼠燉肉",
		"魚人鰭湯",
		"雜燴蚌肉",
		"干烤狼肉串",
		"蜘蛛蛋糕",
		"大塊的熊排",
		"瘦鹿肉",
		"豬肉干",
		"鱷魚濃湯",
		"烤獅排",
		"哥布林芥末蘸蚌肉",
		"美味煎蛋卷",
		"超級煎蛋卷",
		"香烤獅肉",
		"燒烤禿鷹翅膀",
		"燒烤巨蚌",
		"海龜湯",
		"石鱗鱈魚",
		"美味的洞穴菇",
		"紅斑蘑菇",
		"森林蘑菇",
		"曬干的牛肝菌",
		"多孔蘑菇",
		"新鮮的黑蘑菇",
		"燉陸行鳥",
		"神秘雜燴",
		"烤迅猛龍肉",
		"腐肉大餐",
		"龍息紅椒",
		"辣椒蟹肉",
		"金棘茶",
		"烤魷魚",
		"飽滿的南瓜",
		"小南瓜",
		"提古勒和弗羅爾的草莓冰淇淋",
		"血腸",
		"蜘蛛肉腸",
		"姜餅",
		"Clamlette Surprise",
		"蛋奶酒",
		"風干的香蕉",
		"烤鵪鶉",
		"自制櫻桃餡餅",
		-- conjured stuff
		"魔法面包",
		"魔法松餅",
		"魔法粗面包",
		"魔法黑面包",
		"魔法酵母",
		"魔法甜面包",	
	};
	
SEA_DRINK_LIST = {
		"清涼的泉水",
		"櫻桃酒",
		"草莓汁",
		"冰鎮牛奶",
		"果汁",
		"蜂蜜酒",
		"晨露酒",
		"泡沫水",
		-- conjured stuff
		"魔法晶水",
		"魔法淡水",
		"魔法礦泉水",
		"魔法純淨水",
		"魔法蘇打水",
		"魔法泉水",
		"魔法水",
	};

SEA_REAGENT_ALCHEMY ={
		"聖水晶",
		"阿爾薩斯之淚",
		"黑蓮花",
		"黑色硫酸鹽",
		"黑口魚油",
		"盲目草",
		"石南草",
		"跌打草",
		"水晶瓶",
		"柔軟的羽毛",
		"變異魚",
		"受污染的狼人之心",
		"夢境之塵",
		"夢葉草",
		"地根草",
		"元素空氣",
		"元素之土",
		"元素火焰",
		"元素之水",
		"空瓶",
		"空氣精華",
		"大哥布林華",
		"火焰精華",
		"死靈精華",
		"水之精華",
		"枯葉草",
		"火焰之油",
		"火焰花",
		"火鱗鱔魚",
		"幽靈菇",
		"黃金參",
		"金棘草",
		"墓地苔",
		"格羅姆之血",
		"Heart of the Wild",
		"冰蓋草",
		"鐵錠",
		"卡德加的胡鬚",
		"皇血草",
		"大牙齒",
		"大毒囊",
		"鉛瓶",
		"活根草",
		"生命精華",
		"魔皇草",
		"初級治療藥水",
		"秘銀錠",
		"山鼠草",
		"黑口魚",
		"寧神花",
		"瘟疫花",
		"紫色染料",
		"紫蓮花",
		"暗影之油",
		"鋒利的爪子",
		"銀葉草",
		"火囊",
		"石鱗鰻",
		"石鱗魚油",
		"荊棘藻",
		"太陽草",
		"雨燕草",
		"瑟銀錠",
		"瑟銀礦石",
		"烈性朗姆酒",
		"野鋼花",
		"野葡萄藤",
		"冬刺草",
	};

SEA_REAGENT_BLACKSMITHING = {
		"青綠石",
		"奧金錠",
		"艾澤拉斯鉆石",
		"黑珍珠",
		"山脈之血",
		"藍色能量水晶",
		"藍寶石",
		"風之氣息",
		"青銅錠",
		"黃水晶",
		"粗制砂輪",
		"粗糙的石頭",
		"銅錠",
		"大地之核",
		"黑鐵錠",
		"惡魔符文",
		"致密砂輪",
		"厚重的石頭",
		"元素空氣",
		"元素之土",
		"元素火焰",
		"元素之水",
		"食人魔力量藥劑",
		"魔化皮",
		"附魔瑟銀錠",
		"大哥布林華",
		"火焰精華",
		"死靈精華",
		"水之精華",
		"細線",
		"冰霜之油",
		"金錠",
		"綠色染料",
		"綠色皮甲",
		"綠色能量水晶",
		"守護手套",
		"守護之石",
		"火焰之心",
		"重砂輪",
		"重皮",
		"沉重的石頭",
		"巨型綠寶石",
		"不死族腐液",
		"彩色珍珠",
		"鐵錠",
		"翡翠",
		"烏黑的羽毛",
		"大牙齒",
		"大貓眼石",
		"次級隱形藥水",
		"次級月亮石",
		"輕皮",
		"亞麻布",
		"生命精華",
		"魔紋布",
		"孔雀石",
		"中皮",
		"秘銀錠",
		"綠瑪瑙",
		"強力蟑螂油",
		"紅色能量水晶",
		"正義寶珠",
		"劣質砂輪",
		"劣質的石頭",
		"硬甲皮",
		"符文布",
		"暗影之油",
		"暗影石",
		"鋒利的爪子",
		"絲綢",
		"銀錠",
		"有光澤的小珍珠",
		"堅固的砂輪",
		"堅固的石頭",
		"紅寶石",
		"鋼錠",
		"強效助熔劑",
		"迅捷藥水",
		"厚皮",
		"瑟銀錠",
		"虎眼石",
		"真銀錠",
		"弱效助熔劑",
		"邪惡之爪",
		"野葡萄藤",
		"毛料",
		"黃色能量水晶",
	};

SEA_REAGENT_ENCHANTING = {
		"青綠石",
		"奧金棒",
		"黑珍珠",
		"黑口魚油",
		"山脈之血",
		"風之氣息",
		"銅棒",
		"大地之核",
		"夢境之塵",
		"元素之土",
		"元素火焰",
		"屠魔藥劑",
		"空氣精華",
		"火焰精華",
		"死靈精華",
		"水之精華",
		"火焰之油",
		"冰霜之油",
		"純水之球",
		"金珍珠",
		"金棒",
		"強效星界精華",
		"強效不滅精華",
		"強效魔法精華",
		"強效秘法精華",
		"強效虛空精華",
		"綠色幼龍鱗片",
		"火焰之心",
		"冰蓋草",
		"不死族腐液",
		"幻影之塵",
		"彩色珍珠",
		"鐵礦石",
		"皇血草",
		"大塊魔光碎片",
		"大牙齒",
		"大塊微光碎片",
		"大塊閃光碎片",
		"大塊強光碎片",
		"次級星界精華",
		"次級不滅精華",
		"次級魔法精華",
		"次級秘法精華",
		"次級虛空精華",
		"生命精華",
		"正義寶珠",
		"硬甲皮",
		"暗影防護藥水",
		"暗影石",
		"銀棒",
		"普通木柴",
		"普通木柴",
		"小塊魔光碎片",
		"小塊微光碎片",
		"小塊閃光碎片",
		"小塊強光碎片",
		"靈魂之塵",
		"星木",
		"奇異之塵",
		"太陽草",
		"瑟銀錠",
		"真銀錠",
		"真銀棒",
		"幻象之塵",
		"野葡萄藤",
		"冬刺草",
 };

SEA_REAGENT_ENGINEERING = 
{
		"精確瞄準鏡",
		"青綠石",
		"奧金錠",
		"艾澤拉斯鉆石",
		"重磅鐵制炸彈",
		"黑色魔紋之靴",
		"空白的羊皮紙",
		"藍珍珠",
		"藍寶石",
		"魔紋布卷",
		"青銅錠",
		"青銅框架",
		"青銅管",
		"貓眼藥劑",
		"黃水晶",
		"粗制火藥粉",
		"粗糙的石頭",
		"銅錠",
		"銅質調節器",
		"銅管",
		"大地之核",
		"黑鐵錠",
		"致命瞄準鏡",
		"致密炸藥粉",
		"厚重的石頭",
		"暗色皮帶",
		"元素之土",
		"元素火焰",
		"魔化皮",
		"附魔瑟銀錠",
		"墨水",
		"大哥布林華",
		"火焰精華",
		"死靈精華",
		"火焰護目鏡",
		"蟑螂油",
		"燈油",
		"飛虎護目鏡",
		"冰霜之油",
		"保險絲",
		"哥布林施工頭盔",
		"哥布林火箭燃油",
		"金錠",
		"黃金能量核心",
		"綠色護目鏡",
		"發條式同步協調陀螺儀",
		"一把螺栓",
		"火焰之心",
		"野性之心",
		"烈性火藥",
		"重皮",
		"Heavy Stock",
		"沉重的石頭",
		"巨型綠寶石",
		"不死族腐液",
		"秘銀桿",
		"鐵錠",
		"鐵棒",
		"鐵網蛛絲",
		"翡翠",
		"大貓眼石",
		"次級月亮石",
		"輕皮",
		"亞麻布",
		"生命精華",
		"魔紋布",
		"孔雀石",
		"中皮",
		"初級靈魂石",
		"秘銀錠",
		"秘銀外殼",
		"秘銀機械幼龍",
		"秘銀管",
		"綠瑪瑙",
		"夜色蟲",
		"銳鋒箭",
		"清涼的泉水",
		"劣質火藥",
		"劣質的石頭",
		"硬甲皮",
		"符文布",
		"暗影蛛絲",
		"暗影石",
		"絲綢",
		"銀錠",
		"銀錠",
		"銀觸媒",
		"火囊",
		"雪球",
		"實心炸藥",
		"實心炸彈",
		"堅固的石頭",
		"法術能量護目鏡超級版",
		"紅寶石",
		"鋼錠",
		"厚皮",
		"粗蜘蛛絲",
		"瑟銀錠",
		"瑟銀管",
		"瑟銀零件",
		"虎眼石",
		"真銀錠",
		"不牢固的扳機",
		"弱效助熔劑",
		"Whirring Bronze Gizmo",
		"野葡萄藤",
		"木柴",
		"毛料",
};

SEA_REAGENT_LEATHERWORKING = {
		"黑龍鱗片",
		"黑色染料",
		"黑珍珠",
		"黑色雛龍鱗片",
		"漂白液",
		"藍龍鱗片",
		"絲綢卷",
		"毛布卷",
		"奇美拉皮革",
		"黃水晶",
		"粗糙的猩猩毛發",
		"粗線",
		"大地之核",
		"熟化重毛皮",
		"熟化輕毛皮",
		"熟化中毛皮",
		"熟化毛皮",
		"熟化厚毛皮",
		"石中鹽",
		"飛蛇鱗片",
		"魔暴龍皮",
		"元素之土",
		"元素之水",
		"敏捷藥劑",
		"防禦藥劑",
		"強效防禦藥劑",
		"次級敏捷藥劑",
		"初級敏捷藥劑",
		"智慧藥劑",
		"魔化皮",
		"空氣精華",
		"大哥布林華",
		"火焰精華",
		"水之精華",
		"細線",
		"惡魔布",
		"優質皮帶",
		"優質皮手套",
		"優質皮外套",
		"細線",
		"大蟑螂油",
		"蟑螂油",
		"霜刃豹皮革",
		"純水之球",
		"灰色染料",
		"暴怒藥水",
		"綠龍鱗片",
		"綠色染料",
		"綠色幼龍鱗片",
		"火焰之心",
		"重毛皮",
		"重皮",
		"厚蠍鱗",
		"粗絲線",
		"彩色珍珠",
		"鐵扣環",
		"鐵羽毛",
		"翡翠",
		"烏黑的羽毛",
		"皇血草",
		"大牙齒",
		"輕毛皮",
		"輕皮",
		"生命精華",
		"細長的尾羽",
		"好運符",
		"魔紋布",
		"中毛皮",
		"中皮",
		"月布",
		"綠瑪瑙",
		"完美的飛蛇鱗片",
		"迅猛龍的外皮",
		"紅龍鱗片",
		"紅色雛龍鱗片",
		"精煉石中鹽",
		"硬甲毛皮",
		"硬甲皮",
		"破爛的皮革",
		"符文線",
		"符文布",
		"鹽",
		"蠍殼",
		"暗影之油",
		"暗影獵豹毛皮",
		"絲線",
		"粘糊糊的魚人鱗片",
		"有光澤的小珍珠",
		"蜘蛛絲",
		"迅捷藥水",
		"厚毛皮",
		"厚皮",
		"厚魚人鱗片",
		"粗蜘蛛絲",
		"厚狼皮",
		"薄科多獸皮",
		"龜殼",
		"戰熊皮",
		"邪惡之爪",
		"野葡萄藤",
		"龍鱗",
};

SEA_REAGENT_MINING = {
		"煤塊",
		"銅礦石",
		"黑鐵礦石",
		"金礦石",
		"鐵礦石",
		"秘銀礦石",
		"銀礦石",
		"瑟銀礦石",
		"錫礦石",
		"真銀礦石",
};
 
SEA_REAGENT_FIRSTAID = {
		"大毒囊",
		"亞麻布",
		"魔紋布",
		"符文布",
		"絲綢",
		"小毒囊",
		"毛料",
};

SEA_REAGENT_COOKING = {
		"熊肉",
		"大塊的熊肉",
		"豬大腸",
		"豬排",
		"禿鷲的翅膀",
		"大塊野豬肉",
		"蚌肉",
		"山狗肉",
		"峭壁野豬肋排",
		"蟹爪",
		"蟹肉",
		"香脆蜘蛛肉",
		"鱷魚肉",
		"黑爪龍蝦",
		"變異魚",
		"掘地鼠",
		"巨蚌肉",
		"巨蛋",
		"金棘草",
		"粘糊的蜘蛛腿",
		"血牙野豬的肝",
		"血牙野豬的頭",
		"科多獸肉",
		"節日香料",
		"節日美酒",
		"辣椒",
		"冰鎮牛奶",
		"科多獸的肉",
		"Large Raw Mightfish",
		"狼肋排",
		"獅肉",
		"蝙蝠肉翅",
		"甜香料",
		"魚人的眼球",
		"魚人的鰭",
		"神秘的肉",
		"迅猛龍蛋",
		"迅猛龍肉",
		"新鮮的美味小魚",
		"新鮮的刺鬚鯰魚",
		"新鮮的光滑大魚",
		"新鮮的洛克湖狂魚",
		"新鮮的長嘴泥鰍",
		"新鮮的銀頭鮭魚",
		"新鮮的夜鱗鯛魚",
		"新鮮的彩鰭魚",
		"新鮮的紅腮魚",
		"新鮮的石鱗鱈魚",
		"新鮮的滑皮鯖魚",
		"新鮮的斑點黃尾魚",
		"新鮮的夏日鱸魚",
		"新鮮的陽鱗鮭魚",
		"新鮮的白鱗鮭魚",
		"新鮮的刺脊比目魚",
		"紅狼肉",
		"清涼的泉水",
		"狂想麥酒",
		"蠍刺",
		"新鮮的紅蘋果",
		"矮人烈酒",
		"小蛋",
		"火囊",
		"小蜘蛛腿",
		"柔軟的狂魚肉",
		"舒心草",
		"蜘蛛的毒液",
		"鹿肉",
		"暴風城特產調料",
		"陸行鳥肉",
		"禿鷲肉條",
		"嫩狼肉",
		"雨燕草",
		"有腥味的蚌肉",
		"嫩螃蟹肉",
		"嫩鱷魚肉",
		"雷霆蜥蜴的尾巴",
		"虎肉",
		"硬禿鷲肉",
		"海龜肉",
		"白蜘蛛肉",
		"冬魷魚",
		"美味的蚌肉",
};

SEA_REAGENT_ROGUE = {
	  "Blue Hakkari Bijou",
	  "Gold Hakkari Bijou",
	  "Purple Hakkari Bijou",
		"閃光粉",
		"墮落之塵",
		"苦楚精華",
		"喪命草",
		"蝕骨灰",
		"痛苦精華",
		"死草根",
		"致盲粉",
	  "Primal Hakkari Aegis",
	  "Primal Hakkari Armsplint",
	  "Primal Hakkari Girdle",
	  "Primal Hakkari Kossack"
	  };

SEA_REAGENT_POISON =  {
		"水晶瓶",
		"喪命草",
		"蝕骨灰",
		"墮落之塵",
		"空瓶",
		"枯葉草",
		"空瓶",
		"苦楚精華",
		"痛苦精華",
		"鉛瓶",
	};

SEA_POISON = {
		"速效毒藥",
		"致殘毒藥",
		"麻痹毒藥",
		"致傷毒藥",
		"致命毒藥",
	  };
SEA_REAGENT_TAILORING = {
		"艾澤拉斯鉆石",
		"黑色染料",
		"黑珍珠",
		"漂白液",
		"藍色染料",
		"亞麻布卷",
		"魔紋布卷",
		"符文布卷",
		"絲綢卷",
		"毛布卷",
		"黃水晶",
		"粗線",
		"惡魔符文",
		"夢境之塵",
		"元素空氣",
		"元素之土",
		"元素火焰",
		"元素之水",
		"智慧藥劑",
		"魔化皮",
	-- Tuatara removed as I don't think their is such a thing from my research
	--"Enchanted Thread",
		"空氣精華",
		"大哥布林華",
		"火焰精華",
		"死靈精華",
		"水之精華",
		"惡魔布",
		"細線",
		"火焰之油",
		"冰霜之油",
		"幻象染料",
		"純水之球",
		"金錠",
		"金珍珠",
		"灰色染料",
		"綠色染料",
		"治療藥水",
		"火焰之心",
		"野性之心",
		"重皮",
		"粗絲線",
		"巨型綠寶石",
		"彩色珍珠",
		"鐵扣環",
		"鐵網蛛絲",
		"翡翠",
		"大塊魔光碎片",
		"次級月亮石",
		"輕皮",
		"亞麻布",
		"細長的獅鷲羽毛",
		"魔紋布",
		"法力藥水",
		"中皮",
		"月布",
		"納迦鱗片",
		"橙色染料",
		"粉紅染料",
		"紫色染料",
		"紅色染料",
		"正義寶珠",
		"硬甲皮",
		"符文線",
		"符文布",
		"暗影之油",
		"暗影防護藥水",
		"暗影蛛絲",
		"絲綢",
		"絲線",
		"有光澤的小珍珠",
		"蜘蛛絲",
		"紅寶石",
		"厚皮",
		"粗蜘蛛絲",
		"真銀錠",
		"野葡萄藤",
		"毛料",
		"黃色染料",
};

SEA_REAGENT_PALADIN = {
	  "Gold Hakkari Bijou",
	  "Purple Hakkari Bijou",
	  "Red Hakkari Bijou",
	  "神聖符印",
	  "Primal Hakkari Bindings",
	  "Primal Hakkari Shawl",
	  "Primal Hakkari Tabard"
	  };

SEA_REAGENT_MAGE = {
	"Blue Hakkari Bijou",
	"Orange Hakkari Bijou",
	"Silver Hakkari Bijou",
		"輕羽毛",
		"傳送門符文",
		"傳送符文",
	"Primal Hakkari Bindings",
	"Primal Hakkari Girdle",
	"Primal Hakkari Kossack",
	"Primal Hakkari Shawl"
	};

SEA_REAGENT_PRIEST = {
	"Bronze Hakkari Bijou",
	"Orange Hakkari Bijou",
	"Yellow Hakkari Bijou",
	"輕羽毛",
	"Primal Hakkari Aegis",
	"Primal Hakkari Sash",
	"Primal Hakkari Stanchion",
	"Primal Hakkari Tabard"
	};

SEA_REAGENT_SHAMAN = {
	"Blue Hakkari Bijou",
	"Gold Hakkari Bijou",
	"Purple Hakkari Bijou",
		"閃亮的魚鱗",
		"魚油",
		"十字章",
	"Primal Hakkari Armsplint",
	"Primal Hakkari Girdle",
	"Primal Hakkari Sash",
	"Primal Hakkari Tabard"
	};

SEA_REAGENT_WARLOCK = {
	"Orange Hakkari Bijou",
	"Red Hakkari Bijou",
	"Silver Hakkari Bijou",
		"地獄火石",
		"惡魔雕像",
		"靈魂碎片",
	"Primal Hakkari Armsplint",
	"Primal Hakkari Kossack",
	"Primal Hakkari Sash",
	"Primal Hakkari Stanchion"
	};

SEA_REAGENT_DRUID = {
	"Bronze Hakkari Bijou",
	"Green Hakkari Bijou",
	"Red Hakkari Bijou",
		"楓樹種子",
	"Primal Hakkari Bindings",
	"Primal Hakkari Sash",
	"Primal Hakkari Stanchion",
	"Primal Hakkari Tabard",
		"荊棘種子",
		"灰木種子",
		"角樹種子",
		"鐵木種子",
		"野生漿果",
	};

SEA_REAGENT_HUNTER = {
	"Green Hakkari Bijou",
	"Silver Hakkari Bijou",
	"Yellow Hakkari Bijou",
	"Primal Hakkari Aegis",
	"Primal Hakkari Bindings",
	"Primal Hakkari Shawl",
	"Primal Hakkari Stanchion"
	};

SEA_REAGENT_WARRIOR = {
	"Bronze Hakkari Bijou",
	"Green Hakkari Bijou",
	"Yellow Hakkari Bijou",
	"Primal Hakkari Aegis",
	"Primal Hakkari Armsplint",
	"Primal Hakkari Girdle",
	"Primal Hakkari Kossack"
	};

SEA_SELF_CAST_LIST = {
		-- Druid
		["廢毒術"] = 1;
		["消毒術"] = 1;
		["治療之觸"] = 1;
		["野性印記"] = 1;
		["愈合"] = 1;
		["回春術"] = 1;
		["解除詛咒"] = 1;
		["荊棘術"] = 1;
		["啟動"] = 1;
		-- Mage
		["魔法增效"] = 1;
		["秘法智慧"] = 1;
		["魔法抑制"] = 1;
		["解除次級詛咒"] = 1;
		-- Paladin
		["清潔術"] = 1;
		["聖光閃現"] = 1;
		["聖光術"] = 1;
		["純淨術"] = 1;
		["聖療術"] = 1;
		["自由祝福"] = 1;
		["列王祝福"] = 1;
		["光明祝福"] = 1;
		["力量祝福"] = 1;
		["保護祝福"] = 1;
		["犧牲祝福"] = 1;
		["拯救祝福"] = 1;
		["庇護祝福"] = 1;
		["智慧祝福"] = 1;
		-- Priest
		["廢除疾病"] = 1;
		["祛病術"] = 1;
		["驅散魔法"] = 1;
		["神聖之靈"] = 1;
		["快速治療"] = 1;
		["強效治療術"] = 1;
		["次級治療術"] = 1;
		["治療術"] = 1;
		["真言術：韌"] = 1;
		["真言術：盾"] = 1;
		["恢復"] = 1;
		["防護暗影"] = 1;
		-- Shaman
		["治療鏈"] = 1;
		["祛病術"] = 1;
		["消毒術"] = 1;
		["治療波"] = 1;
		["次級治療波"] = 1;
		["水下呼吸"] = 1;
		["水上行走"] = 1;
		-- Warlock
		["偵測強效隱形"] = 1;
		["偵測隱形"] = 1;
		["偵測次級隱形"] = 1;
		["魔息術"] = 1;
		-- First Aid
		["亞麻繃帶"] = 1;
		["厚亞麻繃帶"] = 1;
		["絨線繃帶"] = 1;
		["厚絨線繃帶"] = 1;
		["絲質繃帶"] = 1;
		["厚絲質繃帶"] = 1;
		["魔紋繃帶"] = 1;
		["厚魔紋繃帶"] = 1;
		["符文布繃帶"] = 1;
		["厚符文布繃帶"] = 1;
		["抗毒藥劑"] = 1;
		["強力抗毒藥劑"] = 1
	};

end