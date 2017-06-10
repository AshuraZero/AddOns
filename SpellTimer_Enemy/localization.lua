if ( GetLocale() == "zhCN" ) then
    SpellTimer_Enemy_Spells = {	
		-- All Classes
		["炉石"]     = {t = 10.0, c="performs",icontex="INV_Misc_Rune_01"};			
		["脆弱护甲"] = {t=20.0, c="gains", icontex="Spell_Shadow_GrimWard"};
		["能量无常"] = {t=20.0, c="gains", icontex="Spell_Lightning_LightningBolt01"};
		["充沛之力"] = {t=20.0, c="gains", icontex="Spell_Shadow_GrimWard"};
		["短暂强力"] = {t=15.0, c="gains", icontex="Spell_Holy_MindVision"};		
		["大规模杀伤性魔法"] = {t=20.0, c="gains", icontex="Spell_Fire_WindsofWoe"};		
		["能量护盾"] = {t=20.0, c="gains", icontex="Spell_Nature_CallStorm"};
		["辉煌之光"] = {t=20.0, c="gains", icontex="Spell_Holy_MindVision"};
		["亡灵意志"] = {t=5.0, c="gains", icontex="Spell_Shadow_RaiseDead"};
		["感知"]     = {t=20.0, c="gains", icontex="Spell_Nature_Sleep"};
		["石像形态"] = {t=8.0, c="gains", icontex="Spell_Shadow_UnholyStrength"};
		["大地之击"] = {t=20.0, c="gains", icontex="Spell_Nature_AbolishMagic"};		
		["能量灌注"] = {t=15.0, c="gains", icontex="Spell_Holy_PowerInfusion"};
		["辐射之箭"] = {t=3.0, c="performs", icontex="Spell_Holy_PowerInfusion"};
		-- First Aid
		["急救"] = {t=8.0, c="gains", icontex="Spell_Holy_Heal"};	
	        -- Engineering
	        ["冰霜反射器"] = {t=5.0,c="gains", icontex="Spell_Frost_FrostWard"};
	        ["暗影反射器"] = {t=5.0,c="gains", icontex="Spell_Shadow_AntiShadow"};
	        ["火焰反射器"] = {t=5.0,c="gains", icontex="Spell_Fire_SealOfFire"};		
	        -- Druid	 
		["治疗之触"] = {t=2.5, c="performs", icontex="Spell_Nature_HealingTouch"};
		["愈合"] = {t=2.0, c="performs", icontex="Spell_Nature_ResistNature"};
		["星火术"] = {t=3.5, c="performs", icontex="Spell_Arcane_StarFire"};
		["愤怒"] = {t=2.0, c="performs", icontex="Spell_Nature_AbolishMagic"};		
		["急奔"] = {t=15.0, c="gains", icontex="Ability_Druid_Dash"};
		["愤怒"] = {t=2.0, c="performs", icontex="Spell_Nature_AbolishMagic"};
		["激活"] = {t=20.0, c="performs", incontex="Spell_Nature_Lightning"};
		["狂暴回复"] = {t=10.0, c="performs", icontex="Ability_BullRush"};
		["回春术"] = {t=12.0, c="gains", icontex="Spell_Nature_Rejuvenation"};
		["纠缠根须"] = {t=1.5, c="performs", icontex="Spell_Nature_StrangleVines"};             
	        -- Hunter	 
		["瞄准射击"] = {t=3.0, c="performs", icontex="INV_Spear_07"};				
		["急速射击"] = {t=15.0, c="gains", icontex="Ability_Hunter_RunningShot"};		
		["威慑"]     = {t=10.0, c="gains", icontex="Ability_Whirlwind"}; 
		["乱射"] = {t=6.0, c="performs", icontex="Ability_Marksmanship"};
		["解散宠物"] = {t=5.0, c="performs", icontex="Spell_Nature_SpiritWolf"};
                ["复活宠物"] = {t=10.0, c="performs", icontex="Ability_Hunter_BeastSoothe"};
                ["野兽之眼"] = {t=2.0, c="performs", icontex="Ability_EyeOfTheOwl"};
                ["急速射击"] = {t=15.0, c="gains", icontex="Ability_Hunter_RunningShot"}; 
	        -- Mage	 
		["寒冰箭"]   = {t=2.5, c="performs", icontex="Spell_Frost_FrostBolt02"};
		["火球术"]   = {t=3.0, c="performs", icontex="Spell_Fire_FlameBolt"};
		["变形术"]   = {t=1.5, c="performs", icontex="Spell_Nature_Polymorph"};
		["变形术：猪"] = {t=1.5, c="performs", icontex="Spell_Magic_PolymorphPig"};
		["变形术：龟"] = {t=1.5, c="performs", icontex="Ability_Hunter_Pet_Turtle"};
		["炎爆术"]   = {t=6.0, c="performs", icontex="Spell_Fire_Fireball02"};
		["灼烧"]     = {t=1.5, c="performs", icontex="Spell_Fire_SoulBurn"};
		["烈焰风暴"] = {t=1.5, c="performs", icontex="Spell_Fire_SelfDestruct"};
		["寒冰屏障"] = {t=10.0, c="gains", icontex="Spell_Frost_Frost"};
		["奥术能量"] = {t=15.0, c="gains", icontex="Spell_Nature_Lightning"};
		["传送：达纳苏斯"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalDarnassus"},
	        ["传送：雷霆崖"]   = {t=10.0, c="performs", icontex="Spell_Arcane_PortalThunderBluff"},
	        ["传送：铁炉堡"]   = {t=10.0, c="performs", icontex="Spell_Arcane_PortalIronForge"},
	        ["传送：奥格瑞玛"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalOrgrimmar"},
	        ["传送：暴风城"]   = {t=10.0, c="performs", icontex="Spell_Arcane_PortalStormWind"},
	        ["传送：幽暗城"]   = {t=10.0, c="performs", icontex="Spell_Arcane_PortalUnderCity"},
	        ["传送门：达纳苏斯"]={t=10.0, c="performs", icontex="Spell_Arcane_TeleportDarnassus"},
	        ["传送门：雷霆崖"] = {t=10.0, c="performs",  icontex="Spell_Arcane_TeleportThunderBluff"},
	        ["传送门：铁炉堡"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportIronForge"},
	        ["传送门：奥格瑞玛"]={t=10.0, c="performs", icontex="Spell_Arcane_TeleportOrgrimmar"},
	        ["传送门：暴风城"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportStormWind"},
	        ["传送门：幽暗城"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportUnderCity"},
	        ["防护火焰结界"]   = {t=30.0, c="gains", icontex="Spell_Fire_FireArmor"},
	        ["防护冰霜结界"]   = {t=30.0, c="gains", icontex="Spell_Frost_FrostWard"},
	        ["唤醒"]           = {t=8.0, c="gains", icontex="Spell_Nature_Purge"},
		
	        -- Paladin	 
		["圣光术"] = {t=2.5, c="performs", icontex="Spell_Holy_HolyBolt"};
		["圣光闪现"] = {t=1.5, c="performs", icontex="Spell_Holy_FlashHeal"};
		["愤怒之锤"] = {t=1.0, c="performs", icontex="Ability_ThunderClap"};
		["圣盾术"] = {t=12.0, c="gains", icontex="Spell_Holy_DivineIntervention"};
		["自由祝福"] = {t=16.0, c="gains", icontex="Spell_Holy_SealOfValor"};
		["保护祝福"] = {t=10.0, c="gains", icontex="Spell_Holy_HolyBolt"};
		["自律"]      = {t=60, c="gains", icontex="Spell_Holy_RemoveCurse"};
		["圣佑术"] = {t=8.0, c="gains", icontex="Spell_Holy_Restoration"}; 
		["复仇"] = {t=8.0, c="gains", icontex="Ability_Racial_Avatar"};
		["召唤战马"] = {t=3.0, c="performs", icontex="Ability_Mount_Charger"};
                ["召唤军马"] = {t=3.0, c="performs", icontex="Spell_Nature_Swiftness"};
	        -- Priest	 
		["强效治疗术"] = {t=3.0, c="performs", icontex="Spell_Holy_GreaterHeal"};
		["治疗术"]     = {t=2.5, c="performs", icontex="Spell_Holy_Heal"};
		["快速治疗"]   = {t=1.5, c="performs", icontex="Spell_Holy_FlashHeal"};
		["惩击"]       = {t=2.5, c="performs", icontex="Spell_Holy_HolySmite"};
		["心灵震爆"]   = {t=1.5, c="performs", icontex="Spell_Shadow_UnholyFrenzy"};
		["精神控制"]   = {t=3.0, c="performs", icontex="Spell_Shadow_ShadowWordDominate"};
		["神圣之火"]   = {t=4.0, c="performs", icontex="Spell_Holy_SearingLight"};
		["治疗祷言"]   = {t=3.0, c="performs", icontex="Spell_Holy_PrayerOfHealing02"};
		["虚弱灵魂"]   = {t=15, c="gains", icontex="Spell_Holy_AshesToAshes"};
		["法力燃烧"]   = {t=3.0, c="performs", icontex="Spell_Shadow_ManaBurn"};
		["恢复"] = {t=15.0, c="gains", icontex="Spell_Holy_Renew"};
		-- Rogue
		["解除陷阱"] = {t=2.0, c="performs", icontex="Spell_Shadow_GrimWard"};
		["疾跑"] = {t=15.0, c="gains", icontex="Ability_Rogue_Sprint"};
		["闪避"] = {t=15.0, c="gains", icontex="Spell_Shadow_ShadowWard"};
--		["冲动"] = {t=15.0, c="gains"}; 
                ["偷袭"] = {t=4.0, c="gains",icontex="Ability_CheapShot"};
		["凿击"] = {t=4.0, c="gains", icontex="Ability_Gouge"};
		["消失"] = {t=10.0, c="gains", icontex="Ability_Vanish"};
	        -- Shaman	 
		["次级治疗波"] = {t=1.5, c="performs", icontex="Spell_Nature_HealingWaveLesser"};
		["治疗波"]     = {t=2.5, c="performs", icontex="Spell_Nature_MagicImmunity"};
		["闪电链"]     = {t=2.5, c="performs", icontex="Spell_Nature_ChainLightning"};
		["幽魂之狼"]   = {t=1.0, c="performs", icontex="Spell_Nature_SpiritWolf"};
		["治疗链"]     = {t=2.5, c="performs", icontex="Spell_Nature_HealingWaveGreater"};
		["闪电箭"]     = {t=3.0, c="performs", icontex="Spell_Nature_Lightning"};
		["石爪图腾"] = {t=15.0, c="gains", icontex="Spell_Nature_StoneClawTotem"}; 
                ["法力之潮图腾"] = {t=15.0, c="gains", icontex="Spell_Frost_SummonWaterElemental"};
                ["火焰新星图腾"] = {t=5.0, c="gains", icontex="Spell_Fire_SealOfFire"}; 
                ["风暴打击"] = {t=12.0, c="gains", icontex="Spell_Holy_SealOfMight"};                
                ["根基图腾"] = {t=15.0, c="gains", icontex="Spell_Nature_GroundingTotem"};
	        -- Warlock	 
		["暗影箭"]       = {t=2.5, c="performs", icontex="Spell_Shadow_ShadowBolt"};
		["献祭"]         = {t=1.5, c="performs", icontex="Spell_Fire_Immolation"};
		["灵魂之火"]     = {t=4.0, c="performs", icontex="Spell_Fire_Fireball02"};
		["灼热之痛"]     = {t=1.5, c="performs", icontex="Spell_Fire_SoulBurn"};
		["召唤小鬼"]     = {t=10.0, c="performs", icontex="Spell_Shadow_Imp"};
		["召唤魅魔"]     = {t=10.0, c="performs", icontex="Spell_Shadow_SummonSuccubus"};
		["召唤虚空行者"] = {t=10.0, c="performs", icontex="Spell_Shadow_SummonVoidWalker"};
		["召唤地狱猎犬"] = {t=10.0, c="performs", icontex="Spell_Shadow_SummonFelHunter"};
		["恐惧术"]       = {t=1.5, c="performs", icontex="Spell_Shadow_Possession"};
		["恐惧嚎叫"]     = {t=2.0, c="performs", icontex="Spell_Shadow_DeathScream"};
		     ["火焰箭"] = {t=1.5, c="performs", icontex="Spell_Fire_FireBolt"};			
		     -- Succubus
		     ["诱惑"] = {t=1.5, c="performs", icontex="Spell_Shadow_MindSteal"};
		     ["安抚之吻"] = {t=4.0, c="performs", icontex="Spell_Shadow_SoothingKiss"};
		     -- Voidwalker
	             ["吞噬暗影"] = {t=10.0, c="gains", icontex="Spell_Shadow_AntiShadow"};		
	        -- Warrior	 
		["血性狂暴"] = {t=10.0, c="gains", icontex="Ability_Racial_BloodRage"};
		["嗜血"]     = {t=8.0, c="gains", icontex="Spell_Nature_BloodLust"};
		["盾墙"]     = {t=10.0, c="gains", icontex="Ability_Warrior_ShieldWall"};
		["鲁莽"]     = {t=15.0, c="gains", icontex="Ability_CriticalStrike"};
		["反击风暴"] = {t=15.0, c="gains", icontex="Ability_Warrior_Challange"};
--		["猛击"]     = {t=1.0, c="gains"};		
		["狂暴之怒"] = {t=10.0, c="gains", icontex="Spell_Nature_AncestralGuardian"};
		["破釜沉舟"] = {t=20.0, c="gains", icontex="Spell_Holy_AshesToAshes"};
		
	}
        SpellTimer_Enemy_Effcts = {"自律", "偷袭", "凿击", "虚弱灵魂"} 
	
        ST_ENEMY_MOB_DIES	  = "(.+)死亡了。"
        ST_ENEMY_SPELL_GAIN       = "(.+)获得了(.+)的效果。"
        ST_ENEMY_SPELL_CAST 	  = "(.+)开始施放(.+)。"
        ST_ENEMY_SPELL_PERFORM    = "(.+)开始施展(.+)。"
        ST_ENEMY_AURA_GONE_OTHER  = "(.+)效果从(.+)身上消失"
        ST_ENEMY_SPELL_AFFLICTED  = "(.+)受到了(.+)效果的影响。"
	ST_ENEMY_SPELL_TOTEM      = "(.+)施放了(.+)图腾。"
	ST_ENEMY_SPELL_REMOVED    = "(.+)的(.+)被.+移除了。"        
        
	ST_ENABLE_TARGET_ONLY = "只监视目标"
	ST_SPELLTIMER_TOOLTIP = "显示法术计时器配置界面"
	SHOW_SPELLTIMER_OPTION = "法术计时"
	ST_ENABLE_FRIENDS = "启用友方计时"
	ST_ENABLE_GAINS = "获得类计时"
	ST_ENABLE_PERFORMS = "施法类计时"
	ST_YOU = "你"
        ST_TARGET = "|cffff00ff目标:|r"
--      ST_PERFORMER = "|cffff00ff施法者:|r"
	ST_ENEMY_PERFORM  = "--|cffff7d0a施放|r"
        ST_ENEMY_GAIN     = "--|cfff58cba状态|r"
	SPELL_TIMER_ENEMY = "目标法术计时器"
	SPELL_TIMER_ENEMY_TOOLTIP = "点击可以选中目标,按住shift\n用左键拖动前面的图标可以\n拖动窗口"
	ENABLE_SPELL_TIMER_ENEMY  = "开启目标法术计时"
	PERFORM_COLOR_TOOLTIP = "设置施放类法术的进度条颜色"
	GAIN_COLOR_TOOLTIP = "设置状态类法术的进度条颜色"
elseif (GetLocale() == "zhTW") then
    SpellTimer_Enemy_Spells = {	
         ["爐石"] = {t=10.0, icontex="INV_Misc_Rune_01"};

            -- Trinkets & Racials
        ["脆弱護甲"] =              {t=20.0, c="performs", icontex="Spell_Shadow_GrimWard"}; 
        ["能量無常"] =              {t=20.0, c="gains", icontex="Spell_Lightning_LightningBolt01"}; 
        ["充沛之力"] =              {t=20.0, c="gains", icontex="Spell_Shadow_GrimWard"}; 
        ["短暫強力"] =              {t=15.0, c="gains", icontex="Spell_Holy_MindVision"}; 
        ["祕法強化"] =              {t=15.0, c="gains", icontex="Spell_Nature_Lightning"}; 
        ["大規模殺傷性魔法"] =      {t=20.0, c="gains", icontex="Spell_Fire_WindsofWoe"}; 
        ["祕法潛能"] =              {t=20.0, c="gains", icontex="Spell_Arcane_StarFire"}; 
        ["能量護盾"] =              {t=20.0, c="gains", icontex="Spell_Nature_CallStorm"}; 
        ["輝煌之光"] =              {t=20.0, c="gains", icontex="Spell_Holy_MindVision"}; 
        ["亡靈意志"] =              {t=5.0, c="gains", icontex="Spell_Shadow_RaiseDead"}; 
        ["感知"] =                  {t=20.0, c="gains", icontex="Spell_Nature_Sleep"}; 
        ["瑪爾里的思想加速"] =      {t=30.0, c="gains", icontex="INV_ZulGurubTrinket"};
        ["戰爭踐踏"] =              {t=0.5, c="performs", icontex="Ability_WarStomp"};
        ["石像形態"] =              {t=8.0, c="gains", icontex="Spell_Shadow_UnholyStrength"};

        ["大地之擊"] =              {t=20.0, c="gains", icontex="Spell_Nature_AbolishMagic"}; 
        ["生命賜福"] =              {t=20.0, c="gains", icontex="INV_Misc_Gem_Pearl_05"}; 
        ["自然之盟"] =              {t=20.0, c="gains", icontex="Spell_Nature_SpiritArmor"}; 

            -- Engineering      
        ["寒冰偏斜器"] =            {t=5.0, c="gains", icontex="Spell_Frost_FrostWard"}; 
        ["快速暗影反射器"] =        {t=5.0, c="gains", icontex="Spell_Shadow_AntiShadow"}; 
        ["高輻射烈焰反射器"] =      {t=5.0, c="gains", icontex="Spell_Fire_SealOfFire"}; 

            -- First Aid
        ["急救"] =              {t=8.0, c="performs", icontex="Spell_Holy_Heal"}; 
       
        -- Druid
        ["治療之觸"] =    {t=3.0, c="performs", icontex="Spell_Nature_HealingTouch"};
        ["癒合"] =        {t=2.0, c="performs", icontex="Spell_Nature_ResistNature"};
        ["複生"] =        {t=2.0, c="performs", icontex="Spell_Nature_Reincarnation"};
        ["星火術"] =      {t=3.5, c="performs", icontex="Spell_Arcane_StarFire"};
        ["憤怒"] =        {t=2.0, c="performs", icontex="Spell_Nature_AbolishMagic"};
        ["糾纏根鬚"] =    {t=1.5, c="performs", icontex="Spell_Nature_StrangleVines"};
        ["急奔"] =        {t=15.0, c="gains", icontex="Ability_Druid_Dash"}; 
        ["休眠"] =        {t=1.5, c="performs", icontex="Spell_Nature_Sleep"};
        ["安撫動物"] =    {t=1.5, c="performs", icontex="Ability_Hunter_BeastSoothe"};
        ["樹皮術"] =      {t=15.0, c="gains", icontex="Spell_Nature_StoneClawTotem"}; 
        ["啟動"] =        {t=20.0, c="gains", icontex="Spell_Nature_Lightning"}; 
        ["傳送：月光林地"] =   {t=10.0, c="gains", icontex="Spell_Arcane_TeleportMoonglade"};
        ["猛虎之怒"] =    {t=6.0, c="gains", icontex="Ability_Mount_JungleTiger"}; 
        ["狂暴回復"] =    {t=10.0, c="gains", icontex="Ability_BullRush"};
        ["回春術"] =      {t=12.0, c="gains", icontex="Spell_Nature_Rejuvenation"};
        ["驅毒術"] =      {t=8.0, c="gains", icontex="Spell_Nature_NullifyPoison_02"};        

        -- Hunter
        ["瞄準射擊"] = {t=3.0, c="performs", icontex="INV_Spear_07"};
        ["恐嚇野獸"] = {t=1.0, c="performs", icontex="Ability_Druid_Cower"};
        ["亂射"] = {t=6.0, c="performs", icontex="Ability_Marksmanship"};
        ["解散寵物"] = {t=5.0, c="performs", icontex="Spell_Nature_SpiritWolf"};
        ["復活寵物"] = {t=10.0, c="performs", icontex="Ability_Hunter_BeastSoothe"};
        ["野獸之眼"] = {t=2.0, c="performs", icontex="Ability_EyeOfTheOwl"};
        ["急速射擊"] = {t=15.0, c="gains", icontex="Ability_Hunter_RunningShot"}; 
        ["威懾"] = {t=10, c="gains", icontex="Ability_Whirlwind"};        

        -- Mage
        ["寒冰箭"] = {t=2.5, c="performs", icontex="Spell_Frost_FrostBolt02"};
        ["火球術"] = {t=3.0, c="performs", icontex="Spell_Fire_FlameBolt"};
        ["造水術"] = {t=3.0, c="performs", icontex="INV_Drink_18"};
        ["造食術"] = {t=3.0, c="performs", icontex="INV_Misc_Food_33"};
        ["製造魔法紅寶石"] = {t=3.0, c="performs", icontex="INV_Misc_Gem_Ruby_01"};
        ["製造魔法黃水晶"] = {t=3.0, c="performs", icontex="INV_Misc_Gem_Opal_01"};
        ["製造魔法翡翠"] = {t=3.0, c="performs", icontex="INV_Misc_Gem_Emerald_02"};
        ["製造魔法瑪瑙"] = {t=3.0, c="performs", icontex="INV_Misc_Gem_Emerald_01"};
        ["變形術"] = {t=1.5, c="performs", icontex="Spell_Nature_Polymorph"};
        ["變豬術"] = {t=1.5, c="performs", icontex="Spell_Magic_PolymorphPig"};
        ["變龜術"] = {t=1.5, c="performs", icontex="Ability_Hunter_Pet_Turtle"};
        ["炎爆術"] = {t=6.0, c="performs", icontex="Spell_Fire_Fireball02"};
        ["灼燒"] = {t=1.5, c="performs", icontex="Spell_Fire_SoulBurn"};
        ["烈焰風暴"] = {t=3.0, c="performs", icontex="Spell_Fire_SelfDestruct"};
        ["緩落術"] = {t=30.0, icontex="Spell_Magic_FeatherFall"};
        ["傳送：達納蘇斯"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalDarnassus"};
        ["傳送：雷霆崖"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalThunderBluff"};
        ["傳送：鐵爐堡"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalIronForge"};
        ["傳送：奧格瑪"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalOrgrimmar"};
        ["傳送：暴風城"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalStormWind"};
        ["傳送：幽暗城"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalUnderCity"};
        ["傳送門：達納蘇斯"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportDarnassus"};
        ["傳送門：雷霆崖"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportThunderBluff"};
        ["傳送門：鐵爐堡"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportIronForge"};
        ["傳送門：奧格瑪"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportOrgrimmar"};
        ["傳送門：暴風城"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportStormWind"};
        ["傳送門：幽暗城"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportUnderCity"};
        ["防護火焰結界"] = {t=30.0, c="gains", icontex="Spell_Fire_FireArmor"}; 
        ["防護冰霜結界"] = {t=30.0, c="gains", icontex="Spell_Frost_FrostWard"}; 
        ["喚醒"] = {t=8.0, c="performs", icontex="Spell_Nature_Purge"}; 
        ["寒冰屏障"] = {t=10.0, c="gains", icontex="Spell_Frost_Frost"};

        -- Paladin
        ["聖光術"] = {t=2.5, c="performs", icontex="Spell_Holy_HolyBolt"};
        ["聖光閃現"] = {t=1.5, c="performs", icontex="Spell_Holy_FlashHeal"};
        ["召喚戰馬"] = {t=3.0, c="performs", icontex="Ability_Mount_Charger"};
        ["召喚軍馬"] = {t=3.0, c="performs", icontex="Spell_Nature_Swiftness"};
        ["憤怒之錘"] = {t=1.0, c="performs", icontex="Ability_ThunderClap"};
        ["神聖憤怒"] = {t=2.0, c="performs", icontex="Spell_Holy_Excorcism"};
        ["超渡不死生物"] = {t=1.5, c="performs", icontex="Spell_Holy_TurnUndead"};       
        ["聖佑術"] = {t=8.0, c="gains", icontex="Spell_Holy_Restoration"}; 
        ["聖盾術"] = {t=12.0, c="gains", icontex="Spell_Holy_DivineIntervention"};
        ["自由祝福"] = {t=16.0, c="gains", icontex="Spell_Holy_SealOfValor"}; 
        ["保護祝福"] = {t=10.0, c="gains", icontex="Spell_Holy_SealOfProtection"};
        ["犧牲祝福"] = {t=30.0, c="gains", icontex="Spell_Holy_SealOfSacrifice"}; 
        ["復仇"] = {t=8.0, c="gains", icontex="Ability_Racial_Avatar"}; 
        ["自律"]      = {t=60, c="gains", icontex="Spell_Holy_RemoveCurse"};

        -- Priest
        ["強效治療術"] = {t=2.5,c="performs", icontex="Spell_Holy_GreaterHeal"};
        ["治療術"] = {t=2.5, c="performs", icontex="Spell_Holy_Heal"};
        ["快速治療"] = {t=1.5, c="performs", icontex="Spell_Holy_FlashHeal"};
        ["復活術"] = {t=10.0, c="performs", icontex="Spell_Holy_Resurrection"};
        ["懲擊"] = {t=2.0, c="performs", icontex="Spell_Holy_HolySmite"};
        ["心靈震爆"] = {t=1.5, c="performs", icontex="Spell_Shadow_UnholyFrenzy"};
        ["精神控制"] = {t=3.0, c="performs", icontex="Spell_Shadow_ShadowWordDominate"};
        ["法力燃燒"] = {t=3.0, c="performs", icontex="Spell_Shadow_ManaBurn"};
        ["神聖之火"] = {t=3.0, c="performs", icontex="Spell_Holy_SearingLight"};
        ["安撫心靈"] = {t=1.5, c="performs", icontex="Spell_Holy_MindSooth"};
        ["治療禱言"] = {t=3.0, c="performs", icontex="Spell_Holy_PrayerOfHealing02"};
        ["束縛不死生物"] = {t=1.5, c="performs", icontex="Spell_Nature_Slow"};        
        ["恢復"] = {t=15.0, c="gains", icontex="Spell_Holy_Renew"}; 
        ["驅除疾病"] = {t=20.0, c="gains", icontex="Spell_Nature_NullifyDisease"}; 
        ["回饋"] = {t=15.0, c="gains", icontex="Spell_Shadow_RitualOfSacrifice"}; 
        ["注入能量"] = {t=15.0, c="gains", icontex="Spell_Holy_PowerInfusion"}; 
       

        ["真言術：盾"] = {t=30, c="gains", icontex="Spell_Holy_PowerWordShield"};
        ["信仰護盾"] = {t=30.0, c="gains", icontex="Spell_Holy_BlessingOfProtection"};

        -- Rogue
        ["解除陷阱"] = {t=2.0, c="performs", icontex="Spell_Shadow_GrimWard"};
        ["疾跑"] = {t=15.0, c="gains", icontex="Ability_Rogue_Sprint"};
        ["開鎖"] = {t=5.0, c="performs", icontex="Spell_Nature_MoonKey"};
        ["閃避"] = {t=15.0, c="gains", icontex="Spell_Shadow_ShadowWard"};
        ["消失"] = {t=10.0, c="gains", icontex="Ability_Vanish"};
        ["劍刃亂舞"] = {t=15.0, c="gains", icontex="Ability_Rogue_SliceDice"}; 
        ["偷袭"] = {t=4.0, c="gains",icontex="Ability_CheapShot"};
	["凿击"] = {t=4.0, c="gains", icontex="Ability_Gouge"};	
        ["速效毒藥 VI"] = {t=3.0, c="performs", icontex="Ability_Poisons"};
        ["致命毒藥 V"] = {t=3.0, c="performs", icontex="Ability_Rogue_DualWeild"};
        ["致殘毒藥"] = {t=3.0, c="performs", icontex="Ability_PoisonSting"};
        ["致殘毒藥 II"] = {t=3.0, c="performs", icontex="Ability_PoisonSting"};
        ["麻痹毒藥"] = {t=3.0, c="performs", icontex="Spell_Nature_NullifyDisease"};
        ["麻痹毒藥 II"] = {t=3.0, c="performs", icontex="Spell_Nature_NullifyDisease"};
        ["麻痹毒藥 III"] = {t=3.0, c="performs", icontex="Spell_Nature_NullifyDisease"};

        -- Shaman
        ["次級治療波"] = {t=1.5, c="performs", icontex="Spell_Nature_HealingWaveLesser"};
        ["治療波"] = {t=2.5, c="performs", icontex="Spell_Nature_MagicImmunity"};         
        ["閃電鏈"] = {t=2.5,c="performs", icontex="Spell_Nature_ChainLightning"};
        ["幽魂之狼"] = {t=3.0, c="performs", icontex="Spell_Nature_SpiritWolf"};
        ["星界傳送"] = {t=10.0, c="performs", icontex="Spell_Nature_AstralRecal"};
        ["治療鏈"] = {t=2.5, c="performs", icontex="Spell_Nature_HealingWaveGreater"};
        ["閃電箭"] = {t=3.0, c="performs", icontex="Spell_Nature_Lightning"};
        ["視界術"] = {t=2.0, c="performs", icontex="Spell_Nature_FarSight"};
        ["石爪圖騰"] = {t=15.0, c="gains", icontex="Spell_Nature_StoneClawTotem"};
        ["法力之潮圖騰"] = {t=15.0, c="gains", icontex="Spell_Frost_SummonWaterElemental"}; 
        ["火焰新星圖騰"] = {t=5.0, c="gains", icontex="Spell_Fire_SealOfFire"}; 
        ["風暴打擊"] = {t=12.0, c="gains", icontex="Spell_Holy_SealOfMight"}; 
        ["先祖堅韌"] = {t=15.0, c="gains", icontex="Spell_Nature_UndyingStrength"}; 
        ["治療之路"] = {t=15.0, c="gains", icontex="Spell_Nature_HealingWay"};
        ["根基圖騰"] = {d=15.0, c="gains", icontex="Spell_Nature_GroundingTotem"}; 


        -- Warlock
        ["暗影箭"] = {t=2.5, c="performs", icontex="Spell_Shadow_ShadowBolt"};
        ["獻祭"] = {t=1.5, c="performs", icontex="Spell_Fire_Immolation"};
        ["靈魂之火"] = {t=4.0, c="performs", icontex="Spell_Fire_Fireball02"};
        ["灼熱之痛"] = {t=1.5, c="performs", icontex="Spell_Fire_SoulBurn"};
        ["召喚恐懼戰馬"] = {t=3.0, c="performs", icontex="Ability_Mount_Dreadsteed"};
        ["召喚地獄戰馬"] = {t=3.0, c="performs", icontex="Spell_Nature_Swiftness"};
        ["召喚小鬼"] = {t=10.0, c="performs", icontex="Spell_Shadow_Imp"};
        ["召喚魅魔"] = {t=10.0, c="performs", icontex="Spell_Shadow_SummonSuccubus"};
        ["召喚虛空行者"] = {t=10.0, c="performs", icontex="Spell_Shadow_SummonVoidWalker"};
        ["召喚地獄獵犬"] = {t=10.0, c="performs", icontex="Spell_Shadow_SummonFelHunter"};
        ["恐懼術"] = {t=1.5, c="performs", icontex="Spell_Shadow_Possession"};
        ["恐懼嚎叫"] = {t=2.0, c="performs", icontex="Spell_Shadow_DeathScream"};
        ["放逐術"] = {t=1.5, c="performs", icontex="Spell_Shadow_Cripple"};
        ["召喚儀式"] = {t=5.0, c="performs", icontex="Spell_Shadow_Twilight"};
        ["末日儀式"] = {t=10.0, c="performs", icontex="Spell_Shadow_AntiMagicShell"};
        ["製造法術石"] = {t=5.0, c="performs", icontex="INV_Misc_Gem_Sapphire_01"};
        ["製造靈魂石"] = {t=3.0, c="performs", icontex="Spell_Shadow_SoulGem"};
        ["製造治療石"] = {t=3.0, c="performs", icontex="INV_Stone_04"};
        ["製造極效治療石"] = {t=3.0, c="performs", icontex="INV_Stone_04"};
        ["製造火焰石"] = {t=3.0, c="performs", icontex="INV_Ammo_FireTar"};
        ["奴役惡魔"] =  {t=3.0, c="performs", icontex="Spell_Shadow_EnslaveDemon"};
        ["地獄火"] = {t=2.0, c="performs", icontex="Spell_Fire_Incinerate"};
        ["防護暗影結界"] =    {t=30.0, c="gains", icontex="Spell_Shadow_AntiShadow"}; 
        ["詛咒增幅"] =  {t=30.0, c="gains", icontex="Spell_Shadow_Contagion"}; 

            -- Imp
            ["火焰箭"] =   {t=1.5, c="performs", icontex="Spell_Fire_FireBolt"};

            -- Succubus
            ["誘惑"] =    {t=1.5, c="performs", icontex="Spell_Shadow_MindSteal"};
            ["安撫之吻"] =  {t=4.0, c="performs", icontex="Spell_Shadow_SoothingKiss"};

            -- Voidwalker
            ["吞噬暗影"] = {t=10.0, c="gains", icontex="Spell_Shadow_AntiShadow"}; 

        -- Warrior
        ["血性狂暴"] = {t=10.0, c="gains", icontex="Ability_Racial_BloodRage"}; 
        ["嗜血"] = {t=8.0, c="gains", icontex="Spell_Nature_BloodLust"}; 
        ["盾牆"] = {t=10.0, c="gains", icontex="Ability_Warrior_ShieldWall"}; 
        ["魯莽"] = {t=15.0, c="gains", icontex="Ability_CriticalStrike"}; 
        ["反擊風暴"] = {t=15.0, c="gains", icontex="Ability_Warrior_Challange"}; 
        ["狂暴之怒"] = {t=10.0, c="gains", icontex="Spell_Nature_AncestralGuardian"}; 
        ["破釜沉舟"] = {t=20.0, c="gains", icontex="Spell_Holy_AshesToAshes"}; 
        ["死亡之願"] = {t=30.0, c="gains", icontex="Spell_Shadow_DeathPact"}; 
        ["盾牌格擋"] = {t=5.5, c="gains", icontex="Ability_Defend"}; 
    }
        SpellTimer_Enemy_Effcts = {"自律", "偷襲", "凿击", "虛弱靈魂"} 
	
        
        ST_ENEMY_AURA_GONE_OTHER  = "(.+)效果从(.+)身上消失"
        ST_ENEMY_MOB_DIES         = "(.+)死亡"
        ST_ENEMY_SPELL_GAIN       = "(.+)獲得了(.+)的效果。"
        ST_ENEMY_SPELL_CAST       = "(.+)開始施放(.+)。";
        ST_ENEMY_SPELL_PERFORM    = "(.+)開始施展(.+)。"    
        ST_ENEMY_SPELL_AFFLICTED  = "(.+)受到了(.+)效果的影響";
        ST_ENEMY_SPELL_TOTEM      = "(.+)施放了(.+)圖騰。"
        ST_ENEMY_SPELL_REMOVED    = "(.+)的(.+)被.+移除了";
        
	ST_ENABLE_TARGET_ONLY = "只監視目標"
	ST_SPELLTIMER_TOOLTIP = "顯示法術計時器配置界面"
	SHOW_SPELLTIMER_OPTION = "法朮計時"
        ST_ENABLE_FRIENDS = "啓用友方計時"
        ST_ENABLE_GAINS = "獲得類計時"
        ST_ENABLE_PERFORMS = "施法類計時"
        ST_YOU = "你"
        ST_TARGET = "|cffff00ff目標:|r"
--      ST_PERFORMER = "|cffff00ff施法者:|r"
	ST_ENEMY_PERFORM  = "--|cffff7d0a施放|r"
        ST_ENEMY_GAIN     = "--|cfff58cba狀態|r"
	SPELL_TIMER_ENEMY = "目標施法計時器"
	SPELL_TIMER_ENEMY_TOOLTIP = "點擊可以選中目標,按住shift\n用左鍵拖動前面的圖標可以\n拖动窗口"
	ENABLE_SPELL_TIMER_ENEMY  = "開啓目標施法計時器"
	PERFORM_COLOR_TOOLTIP = "設置施放類法術的進度條顔色"
	GAIN_COLOR_TOOLTIP = "設置狀態類法術的進度條顔色"
else
    SpellTimer_Enemy_Spells = {	
                ["Hearthstone"] = {t=10.0, c="performs", icontex="INV_Misc_Rune_01"};

			-- Trinkets & Racials
		["Brittle Armor"] = 		{t=20.0, c="gains", icontex="Spell_Shadow_GrimWard"}; -- gain
		["Unstable Power"] = 		{t=20.0, c="gains", icontex="Spell_Lightning_LightningBolt01"}; -- gain
		["Restless Strength"] = 	{t=20.0, c="gains", icontex="Spell_Shadow_GrimWard"}; -- gain
		["Ephemeral Power"] = 		{t=15.0, c="gains", icontex="Spell_Holy_MindVision"}; -- gain
		["Arcane Power"] = 		{t=15.0, c="gains", icontex="Spell_Nature_Lightning"}; -- gain
		["Massive Destruction"] = 	{t=20.0, c="gains", icontex="Spell_Fire_WindsofWoe"}; -- gain
		["Arcane Potency"] = 		{t=20.0, c="gains", icontex="Spell_Arcane_StarFire"}; -- gain
		["Energized Shield"] = 		{t=20.0, c="gains", icontex="Spell_Nature_CallStorm"}; -- gain
		["Brilliant Light"] = 		{t=20.0, c="gains", icontex="Spell_Holy_MindVision"}; -- gain
		["Will of the Forsaken"] = 	{t=5.0, c="performs", icontex="Spell_Shadow_RaiseDead"}; -- gain
		["Perception"] = 		{t=20.0, c="gains", icontex="Spell_Nature_Sleep"}; -- gain
		["Mar'li's Brain Boost"] = 	{t=30.0, c="gains", icontex="INV_ZulGurubTrinket"}; -- gain
		["War Stomp"] = 		{t=0.5, c="performs", icontex="Ability_WarStomp"};
		["Stoneform"] = 		{t=8.0, c="gains", icontex="Spell_Shadow_UnholyStrength"};

		["Earthstrike"] = 		{t=20.0, c="gains", icontex="Spell_Nature_AbolishMagic"}; -- gain
		["Gift of Life"] = 		{t=20.0, c="gains", icontex="INV_Misc_Gem_Pearl_05"}; -- gain
		["Nature Aligned"] = 		{t=20.0, c="gains", icontex="Spell_Nature_SpiritArmor"}; -- gain

			-- Engineering
		["Frost Reflector"] = 		{t=5.0, c="gains", icontex="Spell_Frost_FrostWard"}; -- gain
		["Shadow Reflector"] = 		{t=5.0, c="gains", icontex="Spell_Shadow_AntiShadow"}; -- gain
		["Fire Reflector"] = 		{t=5.0, c="gains", icontex="Spell_Fire_SealOfFire"}; -- gain
		
			-- First Aid
		["First Aid"] = 		{t=8.0, c="performs", icontex="Spell_Holy_Heal"}; -- gain
		["Linen Bandage"] = 		{t=3.0, c="performs", icontex="INV_Misc_Bandage_15"};
		["Heavy Linen Bandage"] = 	{t=3.0, c="performs", icontex="INV_Misc_Bandage_18"};
		["Wool Bandage"] = 		{t=3.0, c="performs", icontex="INV_Misc_Bandage_14"};
		["Heavy Wool Bandage"] = 	{t=3.0, c="performs", icontex="INV_Misc_Bandage_17"};
		["Silk Bandage"] = 		{t=3.0, c="performs", icontex="INV_Misc_Bandage_01"};
		["Heavy Silk Bandage"] = 	{t=3.0, c="performs", icontex="INV_Misc_Bandage_02"};
		["Mageweave Bandage"] = 	{t=3.0, c="performs", icontex="INV_Misc_Bandage_19"};
		["Heavy Mageweave Bandage"] = 	{t=3.0, c="performs", icontex="INV_Misc_Bandage_20"};
		["Runecloth Bandage"] = 	{t=3.0, c="performs", icontex="INV_Misc_Bandage_11"};
		["Heavy Runecloth Bandage"] = 	{t=3.0, c="performs", icontex="INV_Misc_Bandage_12"};
		
		-- Druid
		["Healing Touch"] = 		{t=3.0, c="performs", icontex="Spell_Nature_HealingTouch"};
		["Regrowth"] = 			{t=2.0, c="performs", icontex="Spell_Nature_ResistNature"};
		["Rebirth"] = 			{t=2.0, c="performs", icontex="Spell_Nature_Reincarnation"};
		["Starfire"] = 			{t=3.5, c="performs", icontex="Spell_Arcane_StarFire"};
		["Wrath"] = 			{t=2.0, c="performs", icontex="Spell_Nature_AbolishMagic"};
		["Entangling Roots"] = 		{t=1.5, c="performs", icontex="Spell_Nature_StrangleVines"};
		["Dash"] = 			{t=15.0, c="gains", icontex="Ability_Druid_Dash"}; -- gain
		["Hibernate"] = 		{t=1.5, c="performs", icontex="Spell_Nature_Sleep"};
		["Soothe Animal"] = 		{t=1.5, c="performs", icontex="Ability_Hunter_BeastSoothe"};
		["Barkskin"] = 			{t=15.0, c="gains", icontex="Spell_Nature_StoneClawTotem"}; -- gain
		["Innervate"] = 		{t=20.0, c="gains", icontex="Spell_Nature_Lightning"}; -- gain
		["Teleport: Moonglade"] = 	{t=10.0, c="gains", icontex="Spell_Arcane_TeleportMoonglade"};
		["Tiger's Fury"] = 		{t=6.0, c="gains", icontex="Ability_Mount_JungleTiger"}; -- gain
		["Frenzied Regeneration"] = 	{t=10.0, c="gains", icontex="Ability_BullRush"}; -- gain
		["Rejuvenation"] = 		{t=12.0, c="gains", icontex="Spell_Nature_Rejuvenation"}; -- gain
		["Abolish Poison"] = 		{t=8.0, c="gains", icontex="Spell_Nature_NullifyPoison_02"}; -- gain

		["Tranquility"] = 		{t=10.0, c="gains", icontex="Spell_Nature_Tranquility"};
		
		-- Hunter
		["Aimed Shot"] = 		{t=3.0, c="performs", icontex="INV_Spear_07"};
		["Scare Beast"] = 		{t=1.0, c="performs", icontex="Ability_Druid_Cower"};
		["Volley"] = 			{t=6.0, c="performs", icontex="Ability_Marksmanship"};
		["Dismiss Pet"] = 		{t=5.0, c="performs", icontex="Spell_Nature_SpiritWolf"};
		["Revive Pet"] = 		{t=10.0, c="performs", icontex="Ability_Hunter_BeastSoothe"};
		["Eyes of the Beast"] = 	{t=2.0, c="performs", icontex="Ability_EyeOfTheOwl"};
		["Rapid Fire"] = 		{t=15.0, c="gains", icontex="Ability_Hunter_RunningShot"}; -- gain
		["Deterrence"] = 		{t=10, c="gains", icontex="Ability_Whirlwind"}; -- gain

		["Multi-Shot"] = 		{d=10.0, c="gains", icontex="Ability_UpgradeMoonGlaive"};

		
		-- Mage
		["Frostbolt"] = {t=2.5, c="performs", icontex="Spell_Frost_FrostBolt02"};
		["Fireball"] = {t=3.0, c="performs", icontex="Spell_Fire_FlameBolt"};
		["Conjure Water"] = {t=3.0, c="performs", icontex="INV_Drink_18"};
		["Conjure Food"] = {t=3.0, c="performs", icontex="INV_Misc_Food_33"};
		["Conjure Mana Ruby"] = {t=3.0, c="performs", icontex="INV_Misc_Gem_Ruby_01"};
		["Conjure Mana Citrine"] = {t=3.0, c="performs",  icontex="INV_Misc_Gem_Opal_01"};
		["Conjure Mana Jade"] = {t=3.0, c="performs", icontex="INV_Misc_Gem_Emerald_02"};
		["Conjure Mana Agate"] = {t=3.0, c="performs", icontex="INV_Misc_Gem_Emerald_01"};
		["Polymorph"] = {t=1.5, c="performs", icontex="Spell_Nature_Polymorph"};
		["Polymorph: Pig"] = {t=1.5, c="performs", icontex="Spell_Magic_PolymorphPig"};
		["Polymorph: Turtle"] = {t=1.5, c="performs", icontex="Ability_Hunter_Pet_Turtle"};
		["Pyroblast"] = {t=6.0, c="performs", icontex="Spell_Fire_Fireball02"};
		["Scorch"] = {t=1.5, c="performs", icontex="Spell_Fire_SoulBurn"};		
		["Portal: Darnassus"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalDarnassus"};
		["Portal: Thunder Bluff"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalThunderBluff"};
		["Portal: Ironforge"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalIronForge"};
		["Portal: Orgrimmar"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalOrgrimmar"};
		["Portal: Stormwind"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalStormWind"};
		["Portal: Undercity"] = {t=10.0, c="performs", icontex="Spell_Arcane_PortalUnderCity"};
		["Teleport: Darnassus"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportDarnassus"};
		["Teleport: Thunder Bluff"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportThunderBluff"};
		["Teleport: Ironforge"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportIronForge"};
		["Teleport: Orgrimmar"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportOrgrimmar"};
		["Teleport: Stormwind"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportStormWind"};
		["Teleport: Undercity"] = {t=10.0, c="performs", icontex="Spell_Arcane_TeleportUnderCity"};
		["Fire Ward"] = {t=30.0, c="gains", icontex="Spell_Fire_FireArmor"}; -- gain
		["Frost Ward"] = {t=30.0, c="gains", icontex="Spell_Frost_FrostWard"}; -- gain
		["Evocation"] = {t=8.0, c="performs", icontex="Spell_Nature_Purge"}; -- gain
		["Ice Block"] = {t=10.0, c="gains", icontex="Spell_Frost_Frost"};		

		
		-- Paladin
		["Holy Light"] = {t=2.5, c="performs", icontex="Spell_Holy_HolyBolt"};
		["Flash of Light"] = {t=1.5, c="performs", icontex="Spell_Holy_FlashHeal"};
		["Summon Charger"] = {t=3.0, c="performs", icontex="Ability_Mount_Charger"};
		["Summon Warhorse"] = {t=3.0, c="performs", icontex="Spell_Nature_Swiftness"};
		["Hammer of Wrath"] = {t=1.0, c="performs", icontex="Ability_ThunderClap"};
		["Holy Wrath"] = {t=2.0, c="performs", icontex="Spell_Holy_Excorcism"};
		["Turn Undead"] = {t=1.5, c="performs", icontex="Spell_Holy_TurnUndead"};
		["Redemption"] = {t=10.0, c="gains", icontex="Spell_Holy_Resurrection"};
		["Divine Protection"] = {t=8.0, c="gains", icontex="Spell_Holy_Restoration"}; -- gain
		["Divine Shield"] = {t=12.0, c="gains", icontex="Spell_Holy_DivineIntervention"}; -- gain
		["Blessing of Freedom"] = {t=16.0, c="gains", icontex="Spell_Holy_SealOfValor"}; -- gain
		["Blessing of Protection"] = {t=10.0, c="gains", icontex="Spell_Holy_SealOfProtection"}; -- gain
		["Blessing of Sacrifice"] = {t=30.0, c="gains", icontex="Spell_Holy_SealOfSacrifice"}; -- gain
		["Vengeance"] = {t=8.0, c="gains", icontex="Ability_Racial_Avatar"}; -- gain, Talent

	
		-- Priest
		["Greater Heal"] = {t=2.5, c="performs", icontex="Spell_Holy_GreaterHeal"};
		["Heal"] = {t=2.5, c="performs", icontex="Spell_Holy_Heal"};
		["Flash Heal"] = {t=1.5, c="performs", icontex="Spell_Holy_FlashHeal"};
		["Resurrection"] = {t=10.0, icontex="Spell_Holy_Resurrection"};
		["Smite"] = {t=2.0, c="performs", icontex="Spell_Holy_HolySmite"};
		["Mind Blast"] = {t=1.5, c="performs", icontex="Spell_Shadow_UnholyFrenzy"};
		["Mind Control"] = {t=3.0, c="performs", icontex="Spell_Shadow_ShadowWordDominate"};
		["Mana Burn"] = {t=3.0, c="performs", icontex="Spell_Shadow_ManaBurn"};
		["Holy Fire"] = {t=3.0, c="performs", icontex="Spell_Holy_SearingLight"};
		["Mind Soothe"] = {t=1.5, c="performs", icontex="Spell_Holy_MindSooth"};
		["Prayer of Healing"] = {t=3.0, c="performs", icontex="Spell_Holy_PrayerOfHealing02"};
		["Shackle Undead"] = {t=1.5, c="performs", icontex="Spell_Nature_Slow"};		
		["Renew"] = {t=15.0, c="gains", icontex="Spell_Holy_Renew"}; -- gain
		["Abolish Disease"] = {t=20.0, c="gains", icontex="Spell_Nature_NullifyDisease"}; -- gain
		["Feedback"] = {t=15.0, c="gains", icontex="Spell_Shadow_RitualOfSacrifice"}; -- gain
		["Inspiration"] = {t=15.0, c="gains", icontex="INV_Shield_06"}; -- gain (target), Talent
		["Power Infusion"] = {t=15.0, c="gains", icontex="Spell_Holy_PowerInfusion"}; -- gain, Talent
		["Focused Casting"] = {t=6.0, c="gains", icontex="Spell_Arcane_Blink"}; -- gain, Talent

		["Power Word: Shield"] = {t=30, c="gains", icontex="Spell_Holy_PowerWordShield"}; -- gain
		["Armor of Faith"] = {t=30.0, c="gains", icontex="Spell_Holy_BlessingOfProtection"}; -- gain, Priest Tier 3 [Vestments of Faith] 4/9 Proc

		
		-- Rogue
		["Disarm Trap"] = {t=2.0, c="performs", icontex="Spell_Shadow_GrimWard"};
		["Sprint"] = {t=15.0, c="gains", icontex="Ability_Rogue_Sprint"}; -- gain
		["Pick Lock"] = {t=5.0, c="performs", icontex="Spell_Nature_MoonKey"};
		["Evasion"] = {t=15.0, c="gains", icontex="Spell_Shadow_ShadowWard"}; -- gain
		["Vanish"] = {t=10.0, c="gains", icontex="Ability_Vanish"}; -- gain
		["Blade Flurry"] = {t=15.0, c="gains", icontex="Ability_Rogue_SliceDice"}; -- gain

		["Instant Poison VI"] = {t=3.0, c="performs", icontex="Ability_Poisons"};
		["Deadly Poison V"] = {t=3.0, c="performs", icontex="Ability_Rogue_DualWeild"};
		["Crippling Poison"] = {t=3.0, c="performs", icontex="Ability_PoisonSting"};
		["Crippling Poison II"] = {t=3.0, c="performs", icontex="Ability_PoisonSting"};
		["Mind-numbing Poison"] = {t=3.0, c="performs", icontex="Spell_Nature_NullifyDisease"};
		["Mind-numbing Poison II"] = {t=3.0, c="performs", icontex="Spell_Nature_NullifyDisease"};
		["Mind-numbing Poison III"] = {t=3.0, c="performs", icontex="Spell_Nature_NullifyDisease"};

		
		-- Shaman
		["Lesser Healing Wave"] = {t=1.5, c="performs", icontex="Spell_Nature_HealingWaveLesser"};		
		["Ancestral Spirit"] = {t=10.0, c="performs", icontex="Spell_Nature_Regenerate"};
		["Chain Lightning"] = {t=2.5, c="performs", icontex="Spell_Nature_ChainLightning"};
		["Ghost Wolf"] = {t=3.0, c="performs", icontex="Spell_Nature_SpiritWolf"};
		["Astral Recall"] = {t=10.0, c="performs", icontex="Spell_Nature_AstralRecal"};
		["Chain Heal"] = {t=2.5, c="performs", icontex="Spell_Nature_HealingWaveGreater"};
		["Lightning Bolt"] = {t=3.0, c="performs", icontex="Spell_Nature_Lightning"};
		["Far Sight"] = {t=2.0, c="performs", icontex="Spell_Nature_FarSight"};
		["Stoneclaw Totem"] = {t=15.0, c="gains", icontex="Spell_Nature_StoneClawTotem"}; -- '?-- works? -- gain
		["Mana Tide Totem"] = {t=15.0, c="gains", icontex="Spell_Frost_SummonWaterElemental"}; -- '?-- works? -- gain
		["Fire Nova Totem"] = {t=5.0, c="gains", icontex="Spell_Fire_SealOfFire"}; -- '?-- works? -- gain
		["Stormstrike"] = {t=12.0, c="gains", icontex="Spell_Holy_SealOfMight"}; -- gain
		["Ancestral Fortitude"] = {t=15.0, c="gains", icontex="Spell_Nature_UndyingStrength"}; -- gain (target), Talent
		["Healing Way"] = {t=15.0, c="gains", icontex="Spell_Nature_HealingWay"}; -- gain (target), Talent

		["Grounding Totem"] = {d=15.0, c="gains", icontex="Spell_Nature_GroundingTotem"}; -- works?

		
		-- Warlock
		["Shadow Bolt"] = {t=2.5, c="performs", icontex="Spell_Shadow_ShadowBolt"};
		["Immolate"] = {t=1.5, c="performs", icontex="Spell_Fire_Immolation"};
		["Soul Fire"] = {t=4.0, c="performs", icontex="Spell_Fire_Fireball02"};
		["Searing Pain"] = {t=1.5, c="performs", icontex="Spell_Fire_SoulBurn"};
		["Summon Dreadsteed"] = {t=3.0, c="performs", icontex="Ability_Mount_Dreadsteed"};
		["Summon Felsteed"] = {t=3.0, c="performs", icontex="Spell_Nature_Swiftness"};
		["Summon Imp"] = {t=6.0, c="performs", icontex="Spell_Shadow_Imp"};
		["Summon Succubus"] = {t=6.0, c="performs", icontex="Spell_Shadow_SummonSuccubus"};
		["Summon Voidwalker"] = {t=6.0, c="performs", icontex="Spell_Shadow_SummonVoidWalker"};
		["Summon Felhunter"] = {t=6.0, c="performs", icontex="Spell_Shadow_SummonFelHunter"};
		["Fear"] = {t=1.5, c="performs", icontex="Spell_Shadow_Possession"};
		["Howl of Terror"] = {t=2.0, c="performs", icontex="Spell_Shadow_DeathScream"};
		["Banish"] = {t=1.5, c="performs", icontex="Spell_Shadow_Cripple"};
		["Ritual of Summoning"] = {t=5.0, c="performs", icontex="Spell_Shadow_Twilight"};
		["Ritual of Doom"] = {t=10.0, c="performs", icontex="Spell_Shadow_AntiMagicShell"};
		["Create Spellstone"] = {t=5.0, c="performs", icontex="INV_Misc_Gem_Sapphire_01"};
		["Create Soulstone"] = {t=3.0,c="performs",  icontex="Spell_Shadow_SoulGem"};
		["Create Healthstone"] = {t=3.0, c="performs", icontex="INV_Stone_04"};
		["Create Major Healthstone"] = {t=3.0, c="performs", icontex="INV_Stone_04"};
		["Create Firestone"] = {t=3.0, c="performs", icontex="INV_Ammo_FireTar"};
		["Enslave Demon"] = {t=3.0, c="performs", icontex="Spell_Shadow_EnslaveDemon"};
		["Inferno"] = {t=2.0, c="performs", icontex="Spell_Fire_Incinerate"};
		["Shadow Ward"] = {t=30.0, c="gains", icontex="Spell_Shadow_AntiShadow"}; -- gain
		["Amplify Curse"] = {t=30.0, c="gains", icontex="Spell_Shadow_Contagion"}; -- gain

			-- Imp
			["Firebolt"] = {t=1.5, c="performs", icontex="Spell_Fire_FireBolt"};
			
			-- Succubus
			["Seduction"] = {t=1.5, c="performs", icontex="Spell_Shadow_MindSteal"};
			["Soothing Kiss"] = {t=4.0, c="performs", icontex="Spell_Shadow_SoothingKiss"};
			
			-- Voidwalker
			["Consume Shadows"] = {t=10.0, c="gains", icontex="Spell_Shadow_AntiShadow"}; -- gain
		
		-- Warrior
		["Bloodrage"] = {t=10.0, c="gains", icontex="Ability_Racial_BloodRage"}; -- gain
		["Bloodthirst"] = {t=8.0, c="gains", icontex="Spell_Nature_BloodLust"}; -- gain
		["Shield Wall"] = {t=10.0, c="gains", icontex="Ability_Warrior_ShieldWall"}; -- gain
		["Recklessness"] = {t=15.0, c="gains", icontex="Ability_CriticalStrike"}; -- gain
		["Retaliation"] = {t=15.0, c="gains", icontex="Ability_Warrior_Challange"}; -- gain
		["Berserker Rage"] = {t=10.0, c="gains", icontex="Spell_Nature_AncestralGuardian"}; -- gain
		["Last Stand"] = {t=20.0, c="gains", icontex="Spell_Holy_AshesToAshes"}; -- gain
		["Death Wish"] = {t=30.0, c="gains", icontex="Spell_Shadow_DeathPact"}; -- gain
		-- ["Enrage"] = {t=12.0, icontex="Spell_Shadow_UnholyFrenzy"}; -- gain
		["Shield Block"] = {t=5.5, c="gains", icontex="Ability_Defend"}; -- gain, 1 Talent point in impr. block
         }
        SpellTimer_Enemy_Effcts = {} -->I don't know the name in english.You must add them by youself.
        
	ST_ENEMY_MOB_DIES				= "(.+) dies"
	ST_ENEMY_SPELL_GAIN			        = "(.+) gains (.+)."
	ST_ENEMY_SPELL_CAST 				= "(.+) begins to cast (.+)."
	ST_ENEMY_SPELL_PERFORM				= "(.+) begins to perform (.+)."
	ST_ENEMY_SPELL_CASTS				= "(.+) casts (.+)."
	ST_ENEMY_SPELL_AFFLICTED     		        = "(.+) (.+) afflicted by (.+)."	
        ST_ENEMY_SPELL_REMOVED 				= "(.+) (.+) is removed."
        ST_ENEMY_AURA_GONE_OTHER                        = "(.+) fades from (.+)"
        ST_ENEMY_SPELL_TOTEM                            = "(.+) casts (.+) Totem."
	
	ST_ENABLE_TARGET_ONLY = "Only target"
	ST_SPELLTIMER_TOOLTIP = "Show the config of SpellTimer"
        SHOW_SPELLTIMER_OPTION = "SpellTimer"
	ST_ENABLE_FRIENDS = "Enable friends"
	ST_ENABLE_GAINS = "Enable Gains"
	ST_ENABLE_PERFORMS = "Enable Performs"
        ST_YOU = "You"
        ST_TARGET = "|cffff00ffTarget:|r"
--      ST_PERFORMER = "|cffff00ff施法者:|r"
	ST_ENEMY_PERFORM  = "--|cffff7d0aPerforms|r"
        ST_ENEMY_GAIN     = "--|cfff58cbaGains|r"
	SPELL_TIMER_ENEMY = "SpellTimer Enemy"
	SPELL_TIMER_ENEMY_TOOLTIP = "Click to target target,Press shift key\nuse LeftButton to move\n the frame(click the icon)"
	ENABLE_SPELL_TIMER_ENEMY  = "Enable SpellTimer Enemy"
	PERFORM_COLOR_TOOLTIP = "Ajust the color of progress bar"
	GAIN_COLOR_TOOLTIP = "Ajust the color of progress bar"
end