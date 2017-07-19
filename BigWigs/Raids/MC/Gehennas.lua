
----------------------------------
--      Module Declaration      --
----------------------------------

local module, L = BigWigs:ModuleDeclaration("Gehennas", "Molten Core")

module.revision = 20007 -- To be overridden by the module!
module.enabletrigger = module.translatedName -- string or table {boss, add1, add2}
module.toggleoptions = {"adds", "curse", "rain", "bosskill"}

module.defaultDB = {
	adds = false,
}

---------------------------------
--      Module specific Locals --
---------------------------------

local timer = {
	firstCurse = 8,
	firstRain = 7,
	rainTick = 2,
	rainDuration = 6,
	nextRain = 19, -- 12, 18
	curse = 22,
}
local icon = {
	curse = "Spell_Shadow_BlackPlague",
	rain = "Spell_Shadow_RainOfFire",
}
local syncName = {
	curse = "GehennasCurse"..module.revision,
	add = "GehennasAddDead"
}

local flamewaker = 0


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("zhCN", function() return {
	curse_trigger = "受到了基赫纳斯",
	--bolt_trigger = "Gehennas begins to cast Shadow Bolt",
	rain_trigger = "你获得了火焰之雨效果的影响。",
	rain_run_trigger = "你受到(%d+)点(.+)伤害（基赫纳斯的火焰之雨）。",
	curse_trigger2 = "基赫纳斯的诅咒被抵抗了。",
	dead1 = "烈焰行者死亡了。",
	addmsg = "%d/2 烈焰行者死亡!",
	flamewaker_name = "烈焰行者",

    barNextRain = "下次火焰之雨",
            
	curse_warn_soon = "5秒后诅咒!",
	curse_warn_now = "基赫纳斯的诅咒 - 快驱散!",

	curse_bar = "基赫纳斯的诅咒",
	firewarn = "离开火雨!",

	cmd = "Gehennas",
	
	adds_cmd = "adds",
	adds_name = "小怪死亡",
	adds_desc = "通告小怪死亡",
	
	curse_cmd = "curse",
	curse_name = "基赫纳斯的诅咒警报",
	curse_desc = "基赫纳斯的诅咒警报",
            
    rain_cmd = "rain",
    rain_name = "火雨警报",
    rain_desc = "显示火雨的警报标志",
            
    ["Rain of Fire"] = "火焰之雨",
} end)

L:RegisterTranslations("deDE", function() return {
	curse_trigger = "von Gehennas(.+)Fluch betroffen",
	--bolt_trigger = "Gehennas beginnt Schattenblitz",
	rain_trigger = "Ihr seid von Feuerregen betroffen",
	rain_run_trigger = "Ihr erleidet (%d+) (.+) von " .. module.translatedName .. " Feuerregen.",

	curse_trigger2 = "Gehennas\' Fluch(.+) widerstanden",
	dead1 = "Feuerschuppe stirbt",
	addmsg = "%d/2 Feuerschuppe tot!",
	flamewaker_name = "Feuerschuppe",

	barNextRain = "N\195\164chster Regen",

	curse_warn_soon = "5 Sekunden bis Gehennas' Fluch!",
	curse_warn_now = "Gehennas' Fluch - JETZT Entfluchen!",

	curse_bar = "Gehennas' Fluch",
	firewarn = "Raus aus dem Feuer!",

	cmd = "Gehennas",

	adds_cmd = "adds",
	adds_name = "Z\195\164hler f\195\188r tote Adds",
	adds_desc = "Verk\195\188ndet Feuerschuppe Tod",

	curse_cmd = "curse",
	curse_name = "Alarm f\195\188r Gehennas' Fluch",
	curse_desc = "Warnen vor Gehennas' Fluch",

	rain_cmd = "rain",
	rain_name = "Feuerregen",
	rain_desc = "Zeigt ein Warnzeichen bei Feuerregen",

	["Rain of Fire"] = "Feuerregen",
} end)


------------------------------
--      Initialization      --
------------------------------

module.wipemobs = { L["flamewaker_name"] }

-- called after module is enabled
function module:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE",        "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",            "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_FRIENDLYPLAYER_DAMAGE",  "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE",              "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE",     "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",               "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF")

	self:ThrottleSync(10, syncName.curse)
end

-- called after module is enabled and after each wipe
function module:OnSetup()
	self.started = false
	flamewaker = 0

	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
end

-- called after boss is engaged
function module:OnEngage()
	if self.db.profile.curse then
		self:DelayedMessage(timer.firstCurse - 5, L["curse_warn_soon"], "Urgent", nil, nil, true)
		self:Bar(L["curse_bar"], timer.firstCurse, icon.curse)
	end
	--self:Bar(L["barNextRain"], timer.firstRain, icon.rain)
end

-- called after boss is disengaged (wipe(retreat) or victory)
function module:OnDisengage()
end


------------------------------
--      Event Handlers      --
------------------------------

function module:Event(msg)
	if string.find(msg, L["rain_run_trigger"]) then
		if self.db.profile.rain then
			-- I found no better way to trigger this, it will autohide after 2s which is the time between Rain of Fire ticks
			self:WarningSign(icon.rain, timer.rainTick)
		end
	elseif ((string.find(msg, L["curse_trigger"])) or (string.find(msg, L["curse_trigger2"]))) then
		self:Sync(syncName.curse)
	elseif (string.find(msg, L["rain_trigger"])) then
		-- this will not trigger, but I will leave it in case they fix this combatlog event/message
		if self.db.profile.rain then
			self:Message(L["firewarn"], "Attention", true, "Alarm")
			self:WarningSign(icon.rain, timer.rainDuration)
			--self:DelayedBar(timer.rainDuration, L["barNextRain"], timer.nextRain - timer.rainDuration, icon.rain) -- variance too high
		end
	end
end

function module:CHAT_MSG_SPELL_AURA_GONE_SELF(msg)
	if string.find(msg, L["Rain of Fire"]) then
		-- this will not trigger, but I will leave it in case they fix this combatlog event/message
		self:RemoveWarningSign(icon.rain)
	end
end

function module:CHAT_MSG_COMBAT_HOSTILE_DEATH(msg)
	BigWigs:CheckForBossDeath(msg, self)

	--DEFAULT_CHAT_FRAME:AddMessage("CHAT_MSG_COMBAT_HOSTILE_DEATH: " .. msg)
	if string.find(msg, L["dead1"]) then
		self:Sync(syncName.add .. " " .. tostring(flamewaker + 1))
	end
end


------------------------------
--      Synchronization	    --
------------------------------

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.curse and self.db.profile.curse then
		self:DelayedMessage(timer.curse - 5, L["curse_warn_soon"], "Urgent", nil, nil, true)
		self:Bar(L["curse_bar"], timer.curse, icon.curse)
	elseif sync == syncName.add and rest and rest ~= "" then
		rest = tonumber(rest)
		if rest <= 2 and flamewaker < rest then
			flamewaker = rest
			if self.db.profile.adds then
				self:Message(string.format(L["addmsg"], flamewaker), "Positive")
			end
		end
	end
end
