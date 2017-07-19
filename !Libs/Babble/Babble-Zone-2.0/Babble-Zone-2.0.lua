--[[
Name: Babble-Zone-2.0
Revision: $Rev: 14112 $
Author(s): ckknight (ckknight@gmail.com)
Website: http://ckknight.wowinterface.com/
Documentation: http://wiki.wowace.com/index.php/Babble-Zone-2.0
SVN: http://svn.wowace.com/root/trunk/BabbleLib/Babble-Zone-2.0
Description: A library to provide localizations for zones.
Dependencies: AceLibrary, AceLocale-2.0
]]

local MAJOR_VERSION = "Babble-Zone-2.0"
local MINOR_VERSION = tonumber(string.sub("$Revision: 14112 $", 12, -3))

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end

if not AceLibrary:HasInstance("AceLocale-2.0") then error(MAJOR_VERSION .. " requires AceLocale-2.0") end

local _, x = AceLibrary("AceLocale-2.0"):GetLibraryVersion()
MINOR_VERSION = MINOR_VERSION * 100000 + x

if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local BabbleZone = AceLibrary("AceLocale-2.0"):new(MAJOR_VERSION)

-- uncomment below for debug information
-- BabbleZone:EnableDebugging()

BabbleZone:RegisterTranslations("enUS", function()
	return {
		["Ahn'Qiraj"] = true,
		["Alterac Mountains"] = true,
		["Alterac Valley"] = true,
		["Arathi Basin"] = true,
		["Arathi Highlands"] = true,
		["Ashenvale"] = true,
		["Azshara"] = true,
		["Badlands"] = true,
		["The Barrens"] = true,
		["Blackfathom Deeps"] = true,
		["Blackrock Depths"] = true,
		["Blackrock Mountain"] = true,
		["Blackrock Spire"] = true,
		["Blackwing Lair"] = true,
		["Blasted Lands"] = true,
		["Booty Bay"] = true,
		["Burning Steppes"] = true,
		["Caverns of Time"] = true,
		["Darkshore"] = true,
		["Darnassus"] = true,
		["The Deadmines"] = true,
		["Deadwind Pass"] = true,
		["Deeprun Tram"] = true,
		["Desolace"] = true,
		["Dire Maul"] = true,
		["Dire Maul (East)"] = true,
		["Dire Maul (West)"] = true,
		["Dire Maul (North)"] = true,
		["Dun Morogh"] = true,
		["Durotar"] = true,
		["Duskwood"] = true,
		["Dustwallow Marsh"] = true,
		["Eastern Kingdoms"] = true,
		["Eastern Plaguelands"] = true,
		["Elwynn Forest"] = true,
		["Everlook"] = true,
		["Felwood"] = true,
		["Feralas"] = true,
		["The Forbidding Sea"] = true,
		["Gadgetzan"] = true,
		["Gnomeregan"] = true,
		["The Great Sea"] = true,
		["Hall of Legends"] = true,
		["Hillsbrad Foothills"] = true,
		["The Hinterlands"] = true,
		["Hyjal"] = true,
		["Ironforge"] = true,
		["Kalimdor"] = true,
		["Loch Modan"] = true,
		["Maraudon"] = true,
		["Molten Core"] = true,
		["Moonglade"] = true,
		["Mulgore"] = true,
		["Naxxramas"] = true,
		["Onyxia's Lair"] = true,
		["Orgrimmar"] = true,
		["Ratchet"] = true,
		["Ragefire Chasm"] = true,
		["Razorfen Downs"] = true,
		["Razorfen Kraul"] = true,
		["Redridge Mountains"] = true,
		["Ruins of Ahn'Qiraj"] = true,
		["Scarlet Monastery"] = true,
		["Scholomance"] = true,
		["Searing Gorge"] = true,
		["Shadowfang Keep"] = true,
		["Silithus"] = true,
		["Silverpine Forest"] = true,
		["The Stockade"] = true,
		["Stonetalon Mountains"] = true,
		["Stormwind City"] = true,
		["Stranglethorn Vale"] = true,
		["Stratholme"] = true,
		["Swamp of Sorrows"] = true,
		["Tanaris"] = true,
		["Teldrassil"] = true,
		["Temple of Ahn'Qiraj"] = true,
		["The Temple of Atal'Hakkar"] = true,
		["Thousand Needles"] = true,
		["Thunder Bluff"] = true,
		["Tirisfal Glades"] = true,
		["Uldaman"] = true,
		["Un'Goro Crater"] = true,
		["Undercity"] = true,
		["Wailing Caverns"] = true,
		["Warsong Gulch"] = true,
		["Western Plaguelands"] = true,
		["Westfall"] = true,
		["Wetlands"] = true,
		["Winterspring"] = true,
		["Zul'Farrak"] = true,
		["Zul'Gurub"] = true,
		
		-- Burning Crusade
		["Azuremyst Isle"] = true,
		["Bloodmyst Isle"] = true,
		["Eversong Woods"] = true,
		["Ghostlands"] = true,
		["The Exodar"] = true,
		["Shadowmoon Valley"] = true,
		["Black Temple"] = true,
		["Terokkar Forest"] = true,
		["Auchindoun"] = true,
		["Hellfire Peninsula"] = true,
		["Hellfire Citadel"] = true,
		["Nagrand"] = true,
		["Zangarmarsh"] = true,
		["Coilfang Reservoir"] = true,
		["Blade's Edge Mountains"] = true,
		["Gruul's Lair"] = true,
		["Netherstorm"] = true,
		["Tempest Keep"] = true,
	}
end)

BabbleZone:RegisterTranslations("ruRU", function()
	return {
		["Ahn'Qiraj"] = "Ан'Кираж",
		["Alterac Mountains"] = "Альтеракские горы",
		["Alterac Valley"] = "Альтеракская долина",
		["Arathi Basin"] = "Низина Арати",
		["Arathi Highlands"] = "Нагорье Арати",
		["Ashenvale"] = "Ясеневый лес",
		["Azshara"] = "Азшара",
		["Badlands"] = "Бесплодные земли",
		["The Barrens"] = "Степи",
		["Blackfathom Deeps"] = "Непроглядная Пучина",
		["Blackrock Depths"] = "Глубины Черной горы",
		["Blackrock Mountain"] = "Черная гора",
		["Blackrock Spire"] = "Пик Черной горы",
		["Blackwing Lair"] = "Логово Крыла Тьмы",
		["Blasted Lands"] = "Выжженные земли",
		["Booty Bay"] = "Пиратская Бухта",
		["Burning Steppes"] = "Пылающие степи",
		["Caverns of Time"] = "Пещеры Времени",
		["Darkshore"] = "Темные берега",
		["Darnassus"] = "Дарнас",
		["The Deadmines"] = "Мертвые копи",
		["Deadwind Pass"] = "Перевал Мертвого Ветра",
		["Deeprun Tram"] = "Подземный поезд",
		["Desolace"] = "Пустоши",
		["Dire Maul"] = "Забытый Город",
		["Dire Maul (East)"] = "Забытый город (Восток)",
		["Dire Maul (West)"] = "Забытый город (Запад)",
		["Dire Maul (North)"] = "Забытый город (Север)",
		["Dun Morogh"] = "Дун Морог",
		["Durotar"] = "Дуротар",
		["Duskwood"] = "Сумеречный лес",
		["Dustwallow Marsh"] = "Пылевые топи",
		["Eastern Kingdoms"] = "Восточные королевства",
		["Eastern Plaguelands"] = "Восточные Чумные земли",
		["Elwynn Forest"] = "Элвиннский лес",
		["Everlook"] = "Круговзор",
		["Felwood"] = "Оскверненный лес",
		["Feralas"] = "Фералас",
		["The Forbidding Sea"] = "Зловещее море",
		["Gadgetzan"] = "Прибамбасск",
		["Gnomeregan"] = "Гномреган",
		["The Great Sea"] = "Великое море",
		["Hall of Legends"] = "Зал Легенд",
		["Hillsbrad Foothills"] = "Предгорья Хилсбрада",
		["The Hinterlands"] = "Внутренние земли",
		["Hyjal"] = "Хиджал",
		["Ironforge"] = "Стальгорн",
		["Kalimdor"] = "Калимдор",
		["Loch Modan"] = "Лок Модан",
		["Maraudon"] = "Мародон",
		["Molten Core"] = "Огненные Недра",
		["Moonglade"] = "Лунная поляна",
		["Mulgore"] = "Мулгор",
		["Naxxramas"] = "Наксрамас",
		["Onyxia's Lair"] = "Логово Ониксии",
		["Orgrimmar"] = "Оргриммар",
		["Ratchet"] = "Кабестан",
		["Ragefire Chasm"] = "Огненная Пропасть",
		["Razorfen Downs"] = "Курганы Иглошкурых",
		["Razorfen Kraul"] = "Лабиринты Иглошкурых",
		["Redridge Mountains"] = "Красногорье",
		["Ruins of Ahn'Qiraj"] = "Руины Ан'Киража",
		["Scarlet Monastery"] = "Монастырь Алого ордена",
		["Scholomance"] = "Некроситет",
		["Searing Gorge"] = "Тлеющее ущелье",
		["Shadowfang Keep"] = "Крепость Темного Клыка",
		["Silithus"] = "Силитус",
		["Silverpine Forest"] = "Серебряный бор",
		["The Stockade"] = "Тюрьма",
		["Stonetalon Mountains"] = "Когтистые горы",
		["Stormwind City"] = "Штормград",
		["Stranglethorn Vale"] = "Тернистая долина",
		["Stratholme"] = "Стратхольм",
		["Swamp of Sorrows"] = "Болото Печали",
		["Tanaris"] = "Танарис",
		["Teldrassil"] = "Тельдрассил",
		["Temple of Ahn'Qiraj"] = "Храм Ан'Кираж",
		["The Temple of Atal'Hakkar"] = "Храм Атал'Хаккара",
		["Thousand Needles"] = "Тысяча Игл",
		["Thunder Bluff"] = "Громовой Утес",
		["Tirisfal Glades"] = "Тирисфальские леса",
		["Uldaman"] = "Ульдаман",
		["Un'Goro Crater"] = "Кратер Ун'Горо",
		["Undercity"] = "Подгород",
		["Wailing Caverns"] = "Пещеры Стенаний",
		["Warsong Gulch"] = "Ущелье Песни Войны",
		["Western Plaguelands"] = "Западные Чумные земли",
		["Westfall"] = "Западный Край",
		["Wetlands"] = "Болотина",
		["Winterspring"] = "Зимние Ключи",
		["Zul'Farrak"] = "Зул'Фаррак",
		["Zul'Gurub"] = "Зул'Гуруб",
		
		-- Burning Crusade
		["Azuremyst Isle"] = "Остров Лазурной Дымки",
		["Bloodmyst Isle"] = "Остров Кровавой Дымки",
		["Eversong Woods"] = "Леса Вечной Песни",
		["Ghostlands"] = "Призрачные земли",
		["The Exodar"] = "Экзодар",
		["Shadowmoon Valley"] = "Долина Призрачной Луны",
		["Black Temple"] = "Черный храм",
		["Terokkar Forest"] = "Лес Тероккар",
		["Auchindoun"] = "Аукиндон",
		["Hellfire Peninsula"] = "Полуостров Адского Пламени",
		["Hellfire Citadel"] = "Цитадель Адского Пламени",
		["Nagrand"] = "Награнд",
		["Zangarmarsh"] = "Зангартопь",
		["Coilfang Reservoir"] = "Резервуар Кривого Клыка",
		["Blade's Edge Mountains"] = "Острогорье",
		["Gruul's Lair"] = "Логово Груула",
		["Netherstorm"] = "Пустоверть",
		["Tempest Keep"] = "Крепость Бурь",
	}
end)

BabbleZone:RegisterTranslations("deDE", function()
	return {
		["Ahn'Qiraj"] = "Ahn'Qiraj",
		["Alterac Mountains"] = "Alteracgebirge",
		["Alterac Valley"] = "Alteractal",
		["Arathi Basin"] = "Arathibecken",
		["Arathi Highlands"] = "Arathihochland",
		["Ashenvale"] = "Ashenvale",
		["Azshara"] = "Azshara",
		["Badlands"] = "\195\150dland",
		["The Barrens"] = "Brachland",
		["Blackfathom Deeps"] = "Blackfathom-Tiefe",
		["Blackrock Depths"] = "Blackrocktiefen",
		["Blackrock Mountain"] = "Der Blackrock",
		["Blackrock Spire"] = "Blackrockspitze",
		["Blackwing Lair"] = "Pechschwingenhort",
		["Blasted Lands"] = "Verw\195\188stete Lande",
		["Booty Bay"] = "Booty Bay",
		["Burning Steppes"] = "Brennende Steppe",
		["Caverns of Time"] = "Die H\195\182hlen der Zeit",
		["Darkshore"] = "Dunkelk\195\188ste",
		["Darnassus"] = "Darnassus",
		["The Deadmines"] = "Die Todesminen",
		["Deadwind Pass"] = "Gebirgspass der Totenwinde",
		["Deeprun Tram"] = "Die Tiefenbahn",
		["Desolace"] = "Desolace",
		["Dire Maul"] = "D\195\188sterbruch",
		["Dun Morogh"] = "Dun Morogh",
		["Durotar"] = "Durotar",
		["Duskwood"] = "D\195\164mmerwald",
		["Dustwallow Marsh"] = "Marschen von Dustwallow",
		["Eastern Plaguelands"] = "\195\150stliche Pestl\195\164nder",
		["Elwynn Forest"] = "Wald von Elwynn",
		["Everlook"] = "Everlook",
		["Felwood"] = "Teufelswald",
		["Feralas"] = "Feralas",
		["The Forbidding Sea"] = "Das verbotene Meer",
		["Gadgetzan"] = "Gadgetzan",
		["Gnomeregan"] = "Gnomeregan",
		["The Great Sea"] = "Das grosse Meer",
		["Hall of Legends"] = "Halle der Legenden",
		["Hillsbrad Foothills"] = "Vorgebirge von Hillsbrad",
		["The Hinterlands"] = "Hinterland",
		["Hyjal"] = "Hyjal",
		["Ironforge"] = "Ironforge",
		["Loch Modan"] = "Loch Modan",
		["Maraudon"] = "Maraudon",
		["Molten Core"] = "Geschmolzener Kern",
		["Moonglade"] = "Moonglade",
		["Mulgore"] = "Mulgore",
		["Naxxramas"] = "Naxxramas",
		["Onyxia's Lair"] = "Onyxias Hort",
		["Orgrimmar"] = "Orgrimmar",
		["Ratchet"] = "Ratchet",
		["Ragefire Chasm"] = "Ragefireabgrund",
		["Razorfen Downs"] = "Die H\195\188gel von Razorfen",
		["Razorfen Kraul"] = "Der Kral von Razorfen",
		["Redridge Mountains"] = "Rotkammgebirge",
		["Ruins of Ahn'Qiraj"] = "Ruinen von Ahn'Qiraj",
		["Scarlet Monastery"] = "Das Scharlachrote Kloster",
		["Scholomance"] = "Scholomance",
		["Searing Gorge"] = "Sengende Schlucht",
		["Shadowfang Keep"] = "Burg Shadowfang",
		["Silithus"] = "Silithus",
		["Silverpine Forest"] = "Silberwald",
		["The Stockade"] = "Das Verlies",
		["Stonetalon Mountains"] = "Steinkrallengebirge",
		["Stormwind City"] = "Stormwind",
		["Stranglethorn Vale"] = "Schlingendorntal",
		["Stratholme"] = "Stratholme",
		["Swamp of Sorrows"] = "S\195\188mpfe des Elends",
		["Tanaris"] = "Tanaris",
		["Teldrassil"] = "Teldrassil",
		["Temple of Ahn'Qiraj"] = "Tempel von Ahn'Qiraj",
		["The Temple of Atal'Hakkar"] = "Der Tempel von Atal'Hakkar",
		["Thousand Needles"] = "Tausend Nadeln",
		["Thunder Bluff"] = "Thunder Bluff",
		["Tirisfal Glades"] = "Tirisfal",
		["Uldaman"] = "Uldaman",
		["Un'Goro Crater"] = "Un'Goro-Krater",
		["Undercity"] = "Undercity",
		["Wailing Caverns"] = "Die H\195\182hlen des Wehklagens",
		["Warsong Gulch"] = "Warsongschlucht",
		["Western Plaguelands"] = "Westliche Pestl\195\164nder",
		["Westfall"] = "Westfall",
		["Wetlands"] = "Sumpfland",
		["Winterspring"] = "Winterspring",
		["Zul'Farrak"] = "Zul'Farrak",
		["Zul'Gurub"] = "Zul'Gurub",
		
		-- Burning Crusade
		["Azuremyst Isle"] = "Azurnebel  Inseln",
		["Bloodmyst Isle"] = "Blutnebel Inseln",
		["Eversong Woods"] = "Immerlied W\195\164lder",
		["Ghostlands"] = "Geisterl\195\164nder",
		["The Exodar"] = "Das Exodar",
		["Shadowmoon Valley"] = "Schattenmondtal",
		["Black Temple"] = "Schwarzer Tempel",
		["Terokkar Forest"] = "Terokkar Wald",
		["Auchindoun"] = "Auchindoun",
		["Hellfire Peninsula"] = "Hllenfeuer Halbinsel",
		["Hellfire Citadel"] = "Hllenfeuer Zitadelle",
		["Nagrand"] = "Nagrand",
		["Zangarmarsh"] = "Zangarsumpf",
		["Coilfang Reservoir"] = "Spulenrei\195\159zahn Reservat",
		["Blade's Edge Mountains"] = "Klingenrand Berge",
		["Gruul's Lair"] = "Gruul's Hort",
		["Netherstorm"] = "Nethersturm",
		["Tempest Keep"] = "Tempest Unterschlupf",
	}
end)

BabbleZone:RegisterTranslations("frFR", function()
	return {
		["Ahn'Qiraj"] = "Ahn'Qiraj",
		["Alterac Mountains"] = "Montagnes d'Alterac",
		["Alterac Valley"] = "Vall\195\169e d'Alterac",
		["Arathi Basin"] = "Bassin d'Arathi",
		["Arathi Highlands"] = "Hautes-terres d'Arathi",
		["Ashenvale"] = "Ashenvale",
		["Azshara"] = "Azshara",
		["Badlands"] = "Terres ingrates",
		["The Barrens"] = "Les Tarides",
		["Blackfathom Deeps"] = "Profondeurs de Brassenoire",
		["Blackrock Depths"] = "Profondeurs de Blackrock",
		["Blackrock Mountain"] = "Mont Blackrock",
		["Blackrock Spire"] = "Pic Blackrock",
		["Blackwing Lair"] = "Repaire de l'Aile noire",
		["Blasted Lands"] = "Terres foudroy\195\169es",
		["Booty Bay"] = "Baie-du-Butin",
		["Burning Steppes"] = "Steppes Ardentes",
		["Caverns of Time"] = "Grottes du temps",
		["Darkshore"] = "Sombrivage",
		["Darnassus"] = "Darnassus",
		["The Deadmines"] = "Les mortemines",
		["Deadwind Pass"] = "D\195\169fil\195\169 de Deuillevent",
		["Deeprun Tram"] = "Tram des profondeurs",
		["Desolace"] = "D\195\169solace",
		["Dire Maul"] = "Hache-Tripes",
		["Dun Morogh"] = "Dun Morogh",
		["Durotar"] = "Durotar",
		["Duskwood"] = "Bois de la p\195\169nombre",
		["Dustwallow Marsh"] = "Mar\195\169cage d'\195\130prefange",
		["Eastern Plaguelands"] = "Maleterres de l'est",
		["Elwynn Forest"] = "For\195\170t d'Elwynn",
		["Everlook"] = "Long-guet",
		["Felwood"] = "Gangrebois",
		["Feralas"] = "Feralas",
		["The Forbidding Sea"] = "La Mer interdite",
		["Gadgetzan"] = "Gadgetzan",
		["Gnomeregan"] = "Gnomeregan",
		["The Great Sea"] = "La Grande mer",
		["Hall of Legends"] = "Hall des L\195\169gendes",
		["Hillsbrad Foothills"] = "Contreforts d'Hillsbrad",
		["The Hinterlands"] = "Les Hinterlands",
		["Hyjal"] = "Hyjal", -- CHECK
		["Ironforge"] = "Ironforge",
		["Loch Modan"] = "Loch Modan",
		["Maraudon"] = "Maraudon",
		["Molten Core"] = "C\197\147ur du Magma",
		["Moonglade"] = "Reflet-de-lune",
		["Mulgore"] = "Mulgore",
		["Onyxia's Lair"] = "Repaire d'Onyxia",
		["Naxxramas"] = "Naxxramas",
		["Orgrimmar"] = "Orgrimmar",
		["Ratchet"] = "Ratchet",
		["Ragefire Chasm"] = "Gouffre de Ragefeu",
		["Razorfen Downs"] = "Souilles de Tranchebauge",
		["Razorfen Kraul"] = "Kraal de Tranchebauge",
		["Redridge Mountains"] = "Les Carmines",
		["Ruins of Ahn'Qiraj"] = "Ruines d'Ahn'Qiraj",
		["Scarlet Monastery"] = "Monast\195\168re Ecarlate",
		["Scholomance"] = "Scholomance",
		["Searing Gorge"] = "Gorge des Vents br\195\187lants",
		["Shadowfang Keep"] = "Donjon d'Ombrecroc",
		["Silithus"] = "Silithus",
		["Silverpine Forest"] = "For\195\170t des pins argent\195\169s",
		["The Stockade"] = "La Prison",
		["Stonetalon Mountains"] = "Les Serres-Rocheuses",
		["Stormwind City"] = "Cit\195\169 de Stormwind",
		["Stranglethorn Vale"] = "Vall\195\169e de Strangleronce",
		["Stratholme"] = "Stratholme",
		["Swamp of Sorrows"] = "Marais des Chagrins",
		["Tanaris"] = "Tanaris",
		["Teldrassil"] = "Teldrassil",
		["Temple of Ahn'Qiraj"] = "Le temple d'Ahn'Qiraj",
		["The Temple of Atal'Hakkar"] = "Le Temple d'Atal'Hakkar",
		["Thousand Needles"] = "Mille pointes",
		["Thunder Bluff"] = "Thunder Bluff",
		["Tirisfal Glades"] = "Clairi\195\168res de Tirisfal",
		["Uldaman"] = "Uldaman",
		["Un'Goro Crater"] = "Crat\195\168re d'Un'Goro",
		["Undercity"] = "Undercity",
		["Wailing Caverns"] = "Cavernes des lamentations",
		["Warsong Gulch"] = "Goulet des Warsong",
		["Western Plaguelands"] = "Maleterres de l'ouest",
		["Westfall"] = "Marche de l'Ouest",
		["Wetlands"] = "Les Paluns",
		["Winterspring"] = "Berceau-de-l'Hiver",
		["Zul'Farrak"] = "Zul'Farrak",
		["Zul'Gurub"] = "Zul'Gurub",
		
		-- Burning Crusade
		["Azuremyst Isle"] = "Azuremyst Isle",
		["Bloodmyst Isle"] = "Bloodmyst Isle",
		["Eversong Woods"] = "Eversong Woods",
		["Ghostlands"] = "Ghostlands",
		["The Exodar"] = "The Exodar",
		["Shadowmoon Valley"] = "Shadowmoon Valley",
		["Black Temple"] = "Black Temple",
		["Terokkar Forest"] = "Terokkar Forest",
		["Auchindoun"] = "Auchindoun",
		["Hellfire Peninsula"] = "Hellfire Peninsula",
		["Hellfire Citadel"] = "Hellfire Citadel",
		["Nagrand"] = "Nagrand",
		["Zangarmarsh"] = "Zangarmarsh",
		["Coilfang Reservoir"] = "Coilfang Reservoir",
		["Blade's Edge Mountains"] = "Blade's Edge Mountains",
		["Gruul's Lair"] = "Gruul's Lair",
		["Netherstorm"] = "Netherstorm",
		["Tempest Keep"] = "Tempest Keep",
	}
end)

BabbleZone:RegisterTranslations("zhCN", function()
	return {
		["Ahn'Qiraj"] = "安其拉",
		["Alterac Mountains"] = "奥特兰克山脉",
		["Alterac Valley"] = "奥特兰克山谷",
		["Arathi Basin"] = "阿拉希盆地",
		["Arathi Highlands"] = "阿拉希高地",
		["Ashenvale"] = "灰谷",
		["Azshara"] = "艾萨拉",
		["Badlands"] = "荒芜之地",
		["The Barrens"] = "贫瘠之地",
		["Blackfathom Deeps"] = "黑暗深渊",
		["Blackrock Depths"] = "黑石深渊",
		["Blackrock Mountain"] = "黑石山",
		["Blackrock Spire"] = "黑石塔",
		["Blackwing Lair"] = "黑翼之巢",
		["Blasted Lands"] = "诅咒之地",
		["Booty Bay"] = "藏宝海湾",
		["Burning Steppes"] = "燃烧平原",
		["Caverns of Time"] = "时光之穴",
		["Darkshore"] = "黑海岸",
		["Darnassus"] = "达纳苏斯",
		["The Deadmines"] = "死亡矿井",
		["Deadwind Pass"] = "逆风小径",
		["Deeprun Tram"] = "矿道地铁",
		["Desolace"] = "凄凉之地",
		["Dire Maul"] = "厄运之槌",
		["Dire Maul (East)"] = "厄运之槌(东)",
		["Dire Maul (West)"] = "厄运之槌(西)",
		["Dire Maul (North)"] = "厄运之槌(北)",
		["Dun Morogh"] = "丹莫罗",
		["Durotar"] = "杜隆塔尔",
		["Duskwood"] = "暮色森林",
		["Dustwallow Marsh"] = "尘泥沼泽",
		["Eastern Plaguelands"] = "东瘟疫之地",
		["Elwynn Forest"] = "艾尔文森林",
		["Everlook"] = "永望镇",
		["Felwood"] = "费伍德森林",
		["Feralas"] = "菲拉斯",
		["The Forbidding Sea"] = "禁忌之海",
		["Gadgetzan"] = "加基森",
		["Gnomeregan"] = "诺莫瑞根",
		["The Great Sea"] = "无尽之海",
		["Hall of Legends"] = "传说大厅",
		["Hillsbrad Foothills"] = "希尔斯布莱德丘陵",
		["The Hinterlands"] = "辛特兰",
		["Hyjal"] = "海加尔",
		["Ironforge"] = "铁炉堡",
		["Loch Modan"] = "洛克莫丹",
		["Maraudon"] = "玛拉顿",
		["Molten Core"] = "熔火之心",
		["Moonglade"] = "月光林地",
		["Mulgore"] = "莫高雷",
		["Naxxramas"] = "纳克萨玛斯",
		["Onyxia's Lair"] = "奥妮克希亚的巢穴",
		["Orgrimmar"] = "奥格瑞玛",
		["Ratchet"] = "棘齿城",
		["Ragefire Chasm"] = "怒焰裂谷",
		["Razorfen Downs"] = "剃刀高地",
		["Razorfen Kraul"] = "剃刀沼泽",
		["Redridge Mountains"] = "赤脊山",
		["Ruins of Ahn'Qiraj"] = "安其拉废墟",
		["Scarlet Monastery"] = "血色修道院",
		["Scholomance"] = "通灵学院",
		["Searing Gorge"] = "灼热峡谷",
		["Shadowfang Keep"] = "影牙城堡",
		["Silithus"] = "希利苏斯",
		["Silverpine Forest"] = "银松森林",
		["The Stockade"] = "暴风城监狱",
		["Stonetalon Mountains"] = "石爪山脉",
		["Stormwind City"] = "暴风城",
		["Stranglethorn Vale"] = "荆棘谷",
		["Stratholme"] = "斯坦索姆",
		["Swamp of Sorrows"] = "悲伤沼泽",
		["Tanaris"] = "塔纳利斯",
		["Teldrassil"] = "泰达希尔",
		["Temple of Ahn'Qiraj"] = "安其拉神殿",
		["The Temple of Atal'Hakkar"] = "阿塔哈卡神庙",
		["Thousand Needles"] = "千针石林",
		["Thunder Bluff"] = "雷霆崖",
		["Tirisfal Glades"] = "提瑞斯法林地",
		["Uldaman"] = "奥达曼",
		["Un'Goro Crater"] = "安戈洛环型山",
		["Undercity"] = "幽暗城",
		["Wailing Caverns"] = "哀嚎洞穴",
		["Warsong Gulch"] = "战歌峡谷",
		["Western Plaguelands"] = "西瘟疫之地",
		["Westfall"] = "西部荒野",
		["Wetlands"] = "湿地",
		["Winterspring"] = "冬泉谷",
		["Zul'Farrak"] = "祖尔法拉克",
		["Zul'Gurub"] = "祖尔格拉布",
		
		-- Burning Crusade
--		["Azuremyst Isle"] = true,
--		["Bloodmyst Isle"] = true,
--		["Eversong Woods"] = true,
--		["Ghostlands"] = true,
--		["The Exodar"] = true,
--		["Shadowmoon Valley"] = true,
--		["Black Temple"] = true,
--		["Terokkar Forest"] = true,
--		["Auchindoun"] = true,
--		["Hellfire Peninsula"] = true,
--		["Hellfire Citadel"] = true,
--		["Nagrand"] = true,
--		["Zangarmarsh"] = true,
--		["Coilfang Reservoir"] = true,
--		["Blade's Edge Mountains"] = true,
--		["Gruul's Lair"] = true,
--		["Netherstorm"] = true,
--		["Tempest Keep"] = true,
	}
end)

BabbleZone:RegisterTranslations("zhTW", function()
	return {
		["Ahn'Qiraj"] = "安其拉",
		["Alterac Mountains"] = "奧特蘭克山脈",
		["Alterac Valley"] = "奧特蘭克山谷",
		["Arathi Basin"] = "阿拉希盆地",
		["Arathi Highlands"] = "阿拉希高地",
		["Ashenvale"] = "梣谷",
		["Azshara"] = "艾薩拉",
		["Badlands"] = "荒蕪之地",
		["The Barrens"] = "貧瘠之地",
		["Blackfathom Deeps"] = "黑暗深淵",
		["Blackrock Depths"] = "黑石深淵",
		["Blackrock Mountain"] = "黑石山",
		["Blackrock Spire"] = "黑石塔",
		["Blackwing Lair"] = "黑翼之巢",
		["Blasted Lands"] = "詛咒之地",
		["Booty Bay"] = "藏寶海灣",
		["Burning Steppes"] = "燃燒平原",
		["Caverns of Time"] = "時光洞穴",
		["Darkshore"] = "黑海岸",
		["Darnassus"] = "達納蘇斯",
		["The Deadmines"] = "死亡礦坑",
		["Deadwind Pass"] = "逆風小徑",
		["Deeprun Tram"] = "礦道地鐵",
		["Desolace"] = "淒涼之地",
		["Dire Maul"] = "厄運之槌",
		["Dun Morogh"] = "丹莫洛",
		["Durotar"] = "杜洛塔",
		["Duskwood"] = "暮色森林",
		["Dustwallow Marsh"] = "塵泥沼澤",
		["Eastern Plaguelands"] = "東瘟疫之地",
		["Elwynn Forest"] = "艾爾文森林",
		["Everlook"] = "永望鎮",
		["Felwood"] = "費伍德森林",
		["Feralas"] = "菲拉斯",
		["The Forbidding Sea"] = "禁忌之海",
		["Gadgetzan"] = "加基森",
		["Gnomeregan"] = "諾姆瑞根",
		["The Great Sea"] = "無盡之海",
		["Hall of Legends"] = "傳說大廳",
		["Hillsbrad Foothills"] = "希爾斯布萊德丘陵",
		["The Hinterlands"] = "辛特蘭",
		["Hyjal"] = "海加爾山",
		["Ironforge"] = "鐵爐堡",
		["Loch Modan"] = "洛克莫丹",
		["Maraudon"] = "瑪拉頓",
		["Molten Core"] = "熔火之心",
		["Moonglade"] = "月光林地",
		["Mulgore"] = "莫高雷",
		["Naxxramas"] = "納克薩瑪斯",
		["Onyxia's Lair"] = "奧妮克希亞的巢穴",
		["Orgrimmar"] = "奧格瑪",
		["Ratchet"] = "棘齒城",
		["Ragefire Chasm"] = "怒焰裂谷",
		["Razorfen Downs"] = "剃刀高地",
		["Razorfen Kraul"] = "剃刀沼澤",
		["Redridge Mountains"] = "赤脊山",
		["Ruins of Ahn'Qiraj"] = "安其拉廢墟",
		["Scarlet Monastery"] = "血色修道院",
		["Scholomance"] = "通靈學院",
		["Searing Gorge"] = "灼熱峽谷",
		["Shadowfang Keep"] = "影牙城堡",
		["Silithus"] = "希利蘇斯",
		["Silverpine Forest"] = "銀松森林",
		["The Stockade"] = "監獄",
		["Stonetalon Mountains"] = "石爪山脈",
		["Stormwind City"] = "暴風城",
		["Stranglethorn Vale"] = "荊棘谷",
		["Stratholme"] = "斯坦索姆",
		["Swamp of Sorrows"] = "悲傷沼澤",
		["Tanaris"] = "塔納利斯",
		["Teldrassil"] = "泰達希爾",
		["Temple of Ahn'Qiraj"] = "安其拉神廟",
		["The Temple of Atal'Hakkar"] = "阿塔哈卡神廟",
		["Thousand Needles"] = "千針石林",
		["Thunder Bluff"] = "雷霆崖",
		["Tirisfal Glades"] = "提里斯法林地",
		["Uldaman"] = "奧達曼",
		["Un'Goro Crater"] = "安戈洛環形山",
		["Undercity"] = "幽暗城",
		["Wailing Caverns"] = "哀嚎洞穴",
		["Warsong Gulch"] = "戰歌峽谷",
		["Western Plaguelands"] = "西瘟疫之地",
		["Westfall"] = "西部荒野",
		["Wetlands"] = "濕地",
		["Winterspring"] = "冬泉谷",
		["Zul'Farrak"] = "祖爾法拉克",
		["Zul'Gurub"] = "祖爾格拉布",
		
		-- Burning Crusade
--		["Azuremyst Isle"] = true,
--		["Bloodmyst Isle"] = true,
--		["Eversong Woods"] = true,
--		["Ghostlands"] = true,
--		["The Exodar"] = true,
--		["Shadowmoon Valley"] = true,
--		["Black Temple"] = true,
--		["Terokkar Forest"] = true,
--		["Auchindoun"] = true,
--		["Hellfire Peninsula"] = true,
--		["Hellfire Citadel"] = true,
--		["Nagrand"] = true,
--		["Zangarmarsh"] = true,
--		["Coilfang Reservoir"] = true,
--		["Blade's Edge Mountains"] = true,
--		["Gruul's Lair"] = true,
--		["Netherstorm"] = true,
--		["Tempest Keep"] = true,
	}
end)

BabbleZone:RegisterTranslations("koKR", function()
	return {
		["Ahn'Qiraj"] = "안퀴라즈",
		["Alterac Mountains"] = "알터랙 산맥",
		["Alterac Valley"] = "알터랙 계곡",
		["Arathi Basin"] = "아라시 분지",
		["Arathi Highlands"] = "아라시 고원",
		["Ashenvale"] = "잿빛 골짜기",
		["Azshara"] = "아즈샤라",
		["Badlands"] = "황야의 땅",
		["The Barrens"] = "불모의 땅",
		["Blackfathom Deeps"] = "검은 심연의 나락",
		["Blackrock Depths"] = "검은바위 나락",
		["Blackrock Mountain"] = "검은바위 산",
		["Blackrock Spire"] = "검은바위 첨탑",
		["Blackwing Lair"] = "검은날개 둥지",
		["Blasted Lands"] = "저주받은 땅",
		["Booty Bay"] = "무법항",
		["Burning Steppes"] = "불타는 평원",
		["Caverns of Time"] = "시간의 동굴",
		["Darkshore"] = "어둠의 해안",
		["Darnassus"] = "다르나서스",
		["The Deadmines"] = "죽음의 폐광",
		["Deadwind Pass"] = "죽음의 고개",
		["Deeprun Tram"] = "깊은굴 지하철",
		["Desolace"] = "잊혀진 땅",
		["Dire Maul"] = "혈투의 전장",
		["Dire Maul (East)"] = "혈투의 전장 (동부)",
		["Dire Maul (West)"] = "혈투의 전장 (서부)",
		["Dire Maul (North)"] = "혈투의 전장 (북부)",
		["Dun Morogh"] = "던 모로",
		["Durotar"] = "듀로타",
		["Duskwood"] = "그늘숲",
		["Dustwallow Marsh"] = "먼지진흙 습지대",
		["Eastern Plaguelands"] = "동부 역병지대",
		["Elwynn Forest"] = "엘윈 숲",
		["Everlook"] = "눈망루 마을", -- By turtl
		["Felwood"] = "악령의 숲",
		["Feralas"] = "페랄라스",
		["The Forbidding Sea"] = "성난폭풍 해안",
		["Gadgetzan"] = "가젯잔",
		["Gnomeregan"] = "놈리건",
		["The Great Sea"] = "대해",
		["Hall of Legends"] = "용사의 전당",
		["Hillsbrad Foothills"] = "힐스브래드 구릉지",
		["The Hinterlands"] = "동부 내륙지",
		["Hyjal"] = "하이잘",
		["Ironforge"] = "아이언포지",
		["Loch Modan"] = "모단 호수",
		["Maraudon"] = "마라우돈",
		["Molten Core"] = "화산 심장부",
		["Moonglade"] = "달의 숲",
		["Mulgore"] = "멀고어",		
		["Naxxramas"] = "낙스라마스",
		["Onyxia's Lair"] = "오닉시아의 둥지",		
		["Orgrimmar"] = "오그리마",
		["Ratchet"] = "톱니항",
		["Ragefire Chasm"] = "성난 불길협곡",
		["Razorfen Downs"] = "가시덩쿨 구릉",
		["Razorfen Kraul"] = "가시덩쿨 우리",
		["Redridge Mountains"] = "붉은마루 산맥",
		["Ruins of Ahn'Qiraj"] = "안퀴라즈 폐허",
		["Scarlet Monastery"] = "붉은 십자군 수도원",
		["Scholomance"] = "스칼로맨스",
		["Searing Gorge"] = "이글거리는 협곡",
		["Shadowfang Keep"] = "그림자 송곳니 성채",
		["Silithus"] = "실리더스",
		["Silverpine Forest"] = "은빛소나무 숲",
		["The Stockade"] = "지하감옥",
		["Stonetalon Mountains"] = "돌발톱 산맥",
		["Stormwind City"] = "스톰윈드",
		["Stranglethorn Vale"] = "가시덤불 골짜기",
		["Stratholme"] = "스트라솔름",
		["Swamp of Sorrows"] = "슬픔의 늪",
		["Tanaris"] = "타나리스",
		["Teldrassil"] = "텔드랏실",
		["Temple of Ahn'Qiraj"] = "안퀴라즈 사원",
		["The Temple of Atal'Hakkar"] = "아탈학카르 신전",
		["Thousand Needles"] = "버섯구름 봉우리",
		["Thunder Bluff"] = "썬더 블러프",
		["Tirisfal Glades"] = "티리스팔 숲",
		["Uldaman"] = "울다만",
		["Un'Goro Crater"] = "운고로 분화구",
		["Undercity"] = "언더시티",
		["Wailing Caverns"] = "통곡의 동굴",
		["Warsong Gulch"] = "전쟁노래 협곡",
		["Western Plaguelands"] = "서부 역병지대",
		["Westfall"] = "서부 몰락지대",
		["Wetlands"] = "저습지",
		["Winterspring"] = "여명의 설원",
		["Zul'Farrak"] = "줄파락",
		["Zul'Gurub"] = "줄구룹",
		
		-- Burning Crusade
		["Azuremyst Isle"] = "하늘안개 섬",
		["Bloodmyst Isle"] = "핏빛안개 섬",
		["Eversong Woods"] = "영원노래 숲",
		["Ghostlands"] = "유령의 땅",
		["The Exodar"] = "엑소다르",
		["Shadowmoon Valley"] = "어둠달 골짜기",
		["Black Temple"] = "검은 사원",
		["Terokkar Forest"] = "테로카르 숲",
		["Auchindoun"] = "아킨둔",
		["Hellfire Peninsula"] = "지옥불 반도",
		["Hellfire Citadel"] = "지옥불 성채",
		["Nagrand"] = "나그란드",
		["Zangarmarsh"] = "장가르 슾지대",
		["Coilfang Reservoir"] = "갈퀴송곳니 저수지",
		["Blade's Edge Mountains"] = "칼날 산맥",
		["Gruul's Lair"] = "그룰의 둥지",
		["Netherstorm"] = "황천의 폭풍",
		["Tempest Keep"] = "폭풍우 요새",
	}
end)

BabbleZone:Debug()
BabbleZone:SetStrictness(true)

AceLibrary:Register(BabbleZone, MAJOR_VERSION, MINOR_VERSION)
BabbleZone = nil
