
----------------------------------
--      Module Declaration      --
----------------------------------

local module, L = BigWigs:ModuleDeclaration("Princess Huhuran", "Ahn'Qiraj")


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("zhCN", function() return {
	cmd = "Huhuran",

	wyvern_cmd = "wyvern",
	wyvern_name = "翼龙钉刺警报",
	wyvern_desc = "翼龙钉刺警报",

	frenzy_cmd = "frenzy",
	frenzy_name = "狂乱警报",
	frenzy_desc = "狂乱警报",

	berserk_cmd = "berserk",
	berserk_name = "狂暴警报",
	berserk_desc = "狂暴警报",

	frenzygain_trigger = "哈霍兰公主获得了狂乱的效果。",
    frenzyend_trigger = "狂乱效果从哈霍兰公主身上消失。",
    frenzy_bar = "狂乱",
    frenzy_Nextbar = "可能狂乱",
	frenzy_message = "狂乱 - 立刻宁神!",
            
	berserktrigger = "goes into a berserker rage!",
	frenzytrigger = "goes into a killing frenzy!",
	berserkwarn = "狂暴! 狂暴! 狂暴!",
	berserksoonwarn = "狂暴马上!",
	stingtrigger = "受到了翼龙钉刺效果",
	stingwarn = "翼龙钉刺!",
	stingdelaywarn = "翼龙钉刺大约 ~3 秒!",
	bartext = "翼龙钉刺",

	startwarn = "哈霍兰开始, 5 分钟后狂暴!",
	berserkbar = "狂暴",
	berserkwarn1 = "狂暴 1 分钟!",
	berserkwarn2 = "狂暴 30 秒!",
	berserkwarn3 = "狂暴 5 秒!",

} end )

L:RegisterTranslations("deDE", function() return {
	wyvern_name = "Stich des Fl\195\188geldrachen",
	wyvern_desc = "Warnung, wenn Huhuran Stich des Fl\195\188geldrachen wirkt.",

	frenzy_name = "Raserei",
	frenzy_desc = "Warnung, wenn Huhuran in Raserei ger\195\164t.",

	berserk_name = "Berserkerwut",
	berserk_desc = "Warnung, wenn Huhuran in Berserkerwut verf\195\164llt.",

	--frenzygain_trigger = "Princess Huhuran gains Frenzy.",
	--frenzyend_trigger = "Frenzy fades from Princess Huhuran.",
	frenzygain_trigger = "Prinzessin Huhuran ger\195\164t in Raserei!", -- translation missing
	frenzyend_trigger = "Wutanfall schwindet von Prinzessin Huhuran.",
	frenzy_bar = "Frenzy",
	frenzy_Nextbar = "Next Frenzy",
	frenzy_message = "Frenzy - Tranq Shot!",

	berserktrigger = "Prinzession Huhuran verfällt in Berserkerwut!", -- translation missing
	berserkwarn = "Berserkerwut!",
	berserksoonwarn = "Berserkerwut in K\195\188rze!",
	stingtrigger = "von Stich des Flügeldrachen betroffen",
	stingwarn = "Stich des Fl\195\188geldrachen!",
	stingdelaywarn = "M\195\182glicher Stich des Fl\195\188geldrachen in ~3 Sekunden!",
	bartext = "Stich",

	startwarn = "Huhuran angegriffen! Berserkerwut in 5 Minuten!",
	berserkbar = "Berserkerwut",
	berserkwarn1 = "Berserkerwut in 1 Minute!",
	berserkwarn2 = "Berserkerwut in 30 Sekunden!",
	berserkwarn3 = "Berserkerwut in 5 Sekunden!",

} end )

---------------------------------
--      	Variables 		   --
---------------------------------

-- module variables
module.revision = 20004 -- To be overridden by the module!
module.enabletrigger = module.translatedName -- string or table {boss, add1, add2}
--module.wipemobs = { L["add_name"] } -- adds which will be considered in CheckForEngage
module.toggleoptions = {"wyvern", "frenzy", "berserk", "bosskill"}


-- locals
local timer = {
	berserk = 300,
	firstSting = 18,
	sting = 15,
	frenzyInterval = 25,
	frenzy = 8,
}
local icon = {
	berserk = "INV_Shield_01",
	sting = "INV_Spear_02",
	frenzy = "Ability_Druid_ChallangingRoar",
	tranquil = "Spell_Nature_Drowsy",
}
local syncName = {
	sting = "HuhuranWyvernSting"..module.revision,
	frenzy = "HuhuranFrenzyGain"..module.revision,
	frenzyOver = "HuhuranFrenzyFade"..module.revision,
}

local berserkannounced = false
local lastFrenzy = 0
local _, playerClass = UnitClass("player")

------------------------------
--      Initialization      --
------------------------------

-- called after module is enabled
function module:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "checkSting")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "checkSting")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "checkSting")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", "FrenzyCheck")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER", "FrenzyCheck")

	self:ThrottleSync(5, syncName.sting)
end

-- called after module is enabled and after each wipe
function module:OnSetup()
	berserkannounced = false
	self.started = nil
end

-- called after boss is engaged
function module:OnEngage()
	if self.db.profile.berserk then
		self:Message(L["startwarn"], "Important")
		self:Bar(L["berserkbar"], timer.berserk, icon.berserk)
		self:DelayedMessage(timer.berserk - 60, L["berserkwarn1"], "Attention", nil, nil, true)
		self:DelayedMessage(timer.berserk - 30, L["berserkwarn2"], "Urgent", nil, nil, true)
		self:DelayedMessage(timer.berserk - 5, L["berserkwarn3"], "Important", nil, nil, true)
	end
	if self.db.profile.wyvern then
		self:Bar(L["bartext"], timer.firstSting, icon.sting)
		self:DelayedMessage(timer.firstSting - 3, L["stingdelaywarn"], "Urgent", nil, nil, true)
	end
	if self.db.profile.frenzy then
		self:Bar(L["frenzy_Nextbar"], timer.frenzyInterval, icon.frenzy, true, "white")
	end
end

-- called after boss is disengaged (wipe(retreat) or victory)
function module:OnDisengage()
end


------------------------------
--      Event Handlers      --
------------------------------

function module:FrenzyCheck(msg)
	if msg == L["frenzygain_trigger"] then
		self:Sync(syncName.frenzy)
	elseif msg == L["frenzyend_trigger"] then
		self:Sync(syncName.frenzyOver)
	end
end

function module:CHAT_MSG_MONSTER_EMOTE(arg1)
	--[[if self.db.profile.frenzy and arg1 == L["frenzytrigger"] then
	self:Message(L["frenzywarn"], "Urgent")
	else]]
	if self.db.profile.berserk and arg1 == L["berserktrigger"] then
		self:CancelDelayedMessage(L["berserkwarn1"])
		self:CancelDelayedMessage(L["berserkwarn2"])
		self:CancelDelayedMessage(L["berserkwarn3"])
		self:RemoveBar(L["berserkbar"])

		self:Message(L["berserkwarn"], "Urgent", false, "Beware")
		berserkannounced = true
	end
end

function module:UNIT_HEALTH(arg1)
	if self.db.profile.berserk then
		if UnitName(arg1) == module.translatedName then
			local health = UnitHealth(arg1)
			if health > 30 and health <= 33 and not berserkannounced then
				self:Message(L["berserksoonwarn"], "Important", false, "Alarm")
				berserkannounced = true
			elseif (health > 40 and berserkannounced) then
				berserkannounced = false
			end
		end
	end
end

function module:checkSting(arg1)
	if string.find(arg1, L["stingtrigger"]) then
		self:Sync(syncName.sting)
	end
end


------------------------------
--      Synchronization	    --
------------------------------

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.sting then
		if self.db.profile.wyvern then
			self:Message(L["stingwarn"], "Urgent")
			self:Bar(L["bartext"], timer.sting, icon.sting)
			self:DelayedMessage(timer.sting - 3, L["stingdelaywarn"], "Urgent", nil, nil, true)
		end
	elseif sync == syncName.frenzy then
		self:FrenzyGain()
	elseif sync == syncName.frenzyOver then
		self:FrenzyFade()
	end
end

------------------------------
--      Sync Handlers	    --
------------------------------

function module:FrenzyGain()
	if self.db.profile.frenzy then
		self:Message(L["frenzy_message"], "Important", nil, true, "Alert")
		self:Bar(L["frenzy_bar"], timer.frenzy, icon.frenzy, true, "red")
		if playerClass == "HUNTER" then
			self:WarningSign(icon.tranquil, timer.frenzy, true)
		end
		lastFrenzy = GetTime()
	end
end

function module:FrenzyFade()
	if self.db.profile.frenzy then
		self:RemoveBar(L["frenzy_bar"])
		self:RemoveWarningSign(icon.tranquil, true)
		if lastFrenzy ~= 0 then
			local NextTime = (lastFrenzy + timer.frenzyInterval) - GetTime()
			self:Bar(L["frenzy_Nextbar"], NextTime, icon.frenzy, true, "white")
		end
	end
end
