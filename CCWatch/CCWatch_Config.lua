function CCWatch_Config()

CCWATCH.CCS = {}

-- required attributes: GROUP, LENGTH, DIMINISHES
--  ETYPE = Effect Type : 0 Pure CC(Stun/Root), 1 Debuff(Snare/DoT,...), 2 Buff
--  GROUP = Bar this CC is placed on
--  LENGTH = Duration of CC
--  DIMINISHES = 0 never diminishes, 1 = always diminishes, 2 = diminishes on players only
-- optional attributes PVPCC, COMBO
--  PVPCC = if PVPCC exists this value will be used as the base max for a Player target
--  COMBO = if COMBO exists then Combo Points will be added to CC duration
--
-- TARGET, PLAYER, TIMER_START, TIMER_END, DIMINISH are required for all and should be initialized empty
-- MONITOR is required for all and should be initialized to true
-- Rogue

-- Rogue - Stun/Root CCs
CCWATCH.CCS[CCWATCH_GOUGE] = {
	GROUP = 2,
	ETYPE = 0,
	LENGTH = 5.5,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_BLIND] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 10,
	DIMINISHES = 1,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_SAP] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 45,
	PVPCC = 15,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_KS] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 1,
	COMBO = true,
	DIMINISHES = 1,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CS] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 4,
	DIMINISHES = 1,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Rogue - Debuffs
-- Rogue - Target Buffs

-- Priest - Stun/Root CCs
CCWATCH.CCS[CCWATCH_SHACKLE] = {
	ETYPE = 0,
	GROUP = 4,
	LENGTH = 30,	-- 40 50
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_PSYCHICSCREAM] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 8,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_BLACKOUT] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 2,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 0,
	MONITOR = true
}

-- Priest - Debuffs
-- Priest - Buffs

-- Mage - Stun/Root CCs
CCWATCH.CCS[CCWATCH_POLYMORPH] = {
	ETYPE = 0,
	GROUP = 4,
	LENGTH = 20, -- 30 40 50
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_FROSTNOVA] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 8,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_FROSTBITE] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 5,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_ICEBLOCK] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 10,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Mage - Debuffs
CCWATCH.CCS[CCWATCH_FROSTBOLT] = {
	ETYPE = 1,
	GROUP = 5,
	LENGTH = 5,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CONEOFCOLD] = {
	ETYPE = 1,
	GROUP = 5,
	LENGTH = 8,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_COUNTERSPELL] = {
	ETYPE = 1,
	GROUP = 4,
	LENGTH = 4,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_FIREBALL] = {
	ETYPE = 1,
	GROUP = 1,
	LENGTH = 4,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_PYROBLAST] = {
	ETYPE = 1,
	GROUP = 3,
	LENGTH = 12,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_IGNITE] = {
	ETYPE = 1,
	GROUP = 4,
	LENGTH = 4,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_FLAMESTRIKE] = {
	ETYPE = 1,
	GROUP = 3,
	LENGTH = 8,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_BLASTWAVE] = {
	ETYPE = 1,
	GROUP = 5,
	LENGTH = 6,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_FROSTARMOR] = {
	ETYPE = 1,
	GROUP = 5,
	LENGTH = 8,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}


-- Mage - Buffs

-- Druid - Stun/Root CCs
CCWATCH.CCS[CCWATCH_ROOTS] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 12, -- 15 18 21 24 27
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_HIBERNATE] = {
	ETYPE = 0,
	GROUP = 4,
	LENGTH = 20, -- 30 40
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_FERALCHARGE] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 4,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_IMPSTARFIRE] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 3,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_POUNCE] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 2,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_BASH] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 2, -- 2, 3, 4
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Druid - Debuffs
-- Druid - Buffs

-- Hunter - Stun/Root CCs
CCWATCH.CCS[CCWATCH_FREEZINGTRAP] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 10, -- 15 20
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_IMPCS] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 3,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_SCAREBEAST] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 10, -- 15 20
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR	= true
}

CCWATCH.CCS[CCWATCH_SCATTERSHOT] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 4, -- 15 20
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_INTIMIDATION] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 3, -- 15 20
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_COUNTERATTACK] = {
	ETYPE = 0,
	GROUP = 5,
	LENGTH = 5,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_IMPROVEDWINGCLIP] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 5,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_WYVERNSTING] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 12,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_ENTRAPMENT] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 5,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Hunter - Debuffs
-- Hunter - Buffs

-- Paladin - Stun/Root CCs
CCWATCH.CCS[CCWATCH_HOJ] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 3, -- 4 5 6
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_REPENTANCE] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 6,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_TURNUNDEAD] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 10, -- 15 20
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Paladin - Debuffs
-- Paladin - Buffs

-- Warlock - Stun/Root CCs
CCWATCH.CCS[CCWATCH_SEDUCE] = {
	ETYPE = 0,
	GROUP = 5,
	LENGTH = 15,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_FEAR] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 10, -- 15 20 
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_HOWLOFTERROR] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 10, -- 15
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_DEATHCOIL] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 3,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_BANISH] = {
	ETYPE = 0,
	GROUP = 4,
	LENGTH = 20, -- 30
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Warlock - Debuffs
CCWATCH.CCS[CCWATCH_IMMOLATE] = {
	ETYPE = 1,
	GROUP = 3,
	LENGTH = 15,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CORRUPTION] = {
	ETYPE = 1,
	GROUP = 2,
	LENGTH = 18,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CURSEOFAGONY] = {
	ETYPE = 1,
	GROUP = 1,
	LENGTH = 24,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CURSEOFEXHAUSTION] = {
	ETYPE = 1,
	GROUP = 1,
	LENGTH = 12,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CURSEOFELEMENTS] = {
	ETYPE = 1,
	GROUP = 1,
	LENGTH = 300,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CURSEOFSHADOW] = {
	ETYPE = 1,
	GROUP = 1,
	LENGTH = 300,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CURSEOFTONGUES] = {
	ETYPE = 1,
	GROUP = 1,
	LENGTH = 30,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CURSEOFWEAKNESS] = {
	ETYPE = 1,
	GROUP = 1,
	LENGTH = 120,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CURSEOFRECKLESSNESS] = {
	ETYPE = 1,
	GROUP = 1,
	LENGTH = 120,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CURSEOFDOOM] = {
	ETYPE = 1,
	GROUP = 1,
	LENGTH = 60,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}


-- Warlock - Buffs

-- Warrior - Stun/Root CCs
CCWATCH.CCS[CCWATCH_INTERCEPT] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 3,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_MACESPE] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 3,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_IMPHAMSTRING] = {
	ETYPE = 0,
	GROUP = 2,
	LENGTH = 3,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_INTIMIDATINGSHOUT] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 8,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_IMPREVENGE] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 3,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

CCWATCH.CCS[CCWATCH_CONCUSSIONBLOW] = {
	ETYPE = 0,
	GROUP = 1,
	LENGTH = 5,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Warrior - Debuffs
-- Warrior - Buffs

-- Specific - Stun/Root CCs

-- Tauren
CCWATCH.CCS[CCWATCH_WARSTOMP] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 2,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Green Whelp Armour
CCWATCH.CCS[CCWATCH_SLEEP] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 30,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Net O Matic
CCWATCH.CCS[CCWATCH_NETOMATIC] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 10,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Reckless Helmet
CCWATCH.CCS[CCWATCH_ROCKETHELM] = {
	ETYPE = 0,
	GROUP = 3,
	LENGTH = 20,
	DIMINISHES = 2,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	DIMINISH = 1,
	MONITOR = true
}

-- Specific - Debuffs

-- Specific - Buffs

-- Forsaken
CCWATCH.CCS[CCWATCH_WOTF] = {
	ETYPE = 2,
	GROUP = 1,
	LENGTH = 5,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	MONITOR = true
}

-- Human
CCWATCH.CCS[CCWATCH_PERCEPTION] = {
	ETYPE = 2,
	GROUP = 1,
	LENGTH = 20,
	DIMINISHES = 0,

	TARGET = "",
	PLAYER = nil,
	TIMER_START = 0,
	TIMER_END = 0,
	MONITOR = true
}

end