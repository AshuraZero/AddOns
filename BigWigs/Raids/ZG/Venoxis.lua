
----------------------------------
--      Module Declaration      --
----------------------------------

local module, L = BigWigs:ModuleDeclaration("High Priest Venoxis", "Zul'Gurub")


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("zhCN", function() return {
    add_name                        = "拉扎什眼镜蛇",
    renew_trigger                   = "高阶祭司温诺希斯获得了恢复的效果\。",
    renewend_trigger                = "恢复效果效果从高阶祭司温诺希斯身上消失\。",
    enrage_trigger                  = "高阶祭司温诺希斯获得了激怒的效果\。",
    holyfire_trigger                = "高阶祭司温诺希斯开始施放神圣之火\。",
    phase2_trigger                  = "Let the coils of hate unfurl!",
    attack_trigger1                 = "高阶祭司温诺希斯发起攻击",
    attack_trigger2                 = "高阶祭司温诺希斯没有击中",
    attack_trigger3                 = "高阶祭司温诺希斯击中",
    attack_trigger4                 = "高阶祭司温诺希斯的致命一击",
    poisoncloud_trigger             = "毒云",
    poisoncloudhitsyou_trigger      = "你受到(.+)点自然伤害（高阶祭司温诺希斯的毒云）。",
    poisoncloudhitsother_trigger    = "(.+)的(.+)使(.+)受到了(.+)点自然伤害。",
    poisoncloud_on_you              = "你受到了毒云效果的影响。",
    poisoncloudabsorbyou_trigger    = "你吸收了高阶祭司温诺希斯的毒云\。",
    poisoncloudabsorb_trigger       = "高阶祭司温诺希斯的毒云被(.+)吸收了\。",
    poisoncloudresistyou_trigger    = "高阶祭司温诺希斯的毒云被抵抗了\。",
    poisoncloudresist_trigger       = "高阶祭司温诺希斯的毒云被(.+)抵抗了\。",
    poisoncloudimmuneyou_trigger    = "高阶祭司温诺希斯的毒云施放失败。你对此免疫\。",
    poisoncloudimmune_trigger       = "高阶祭司温诺希斯的毒云施放失败。(.+)对此免疫\。",
    deadaddtrigger                  = "拉扎什眼镜蛇死亡了",
    deadbosstrigger                 = "高阶祭司温诺希斯死亡了",

    holyfirebar         = "神圣之火",
    renewbar            = "恢复",
    renew_message       = "恢复! 驱散他!",
    phase1_message      = "巨魔阶段",
    phase2_message      = "蛇阶段",
    enrage_message      = "boss狂怒! 加大治疗!",
    poisonyou_message   = "远离毒云!",
    poison_message      = "远离毒云!",
    addmsg              = "%d/4 拉扎什眼镜蛇死亡!",
    you                 = "你",
	
    cmd                 = "Venoxis",

    adds_cmd            = "adds",
    adds_name           = "小怪死亡通告",
    adds_desc           = "小怪死亡通告",
	
    renew_cmd           = "renew",
    renew_name          = "恢复警报",
    renew_desc          = "恢复警报",

    holyfire_cmd        = "holyfire",
    holyfire_name       = "神圣之火警报",
    holyfire_desc       = "神圣之火警报",

    phase_cmd           = "phase",
    phase_name          = "阶段通报",
    phase_desc          = "阶段通报",

    announce_cmd        = "whispers",
    announce_name       = "密语中毒云的玩家",
    announce_desc       = "密语中毒云的玩家\n\n(需要A或L)\n",

    enrage_cmd          = "enrage",
    enrage_name         = "狂怒警报",
    enrage_desc         = "狂怒警报",
} end )

L:RegisterTranslations("deDE", function() return {
	add_name = "Razzashi Cobra",
	renew_trigger = "High Priest Venoxis bekommt 'Erneuerung",
	renewend_trigger = "Erneuerung schwindet von High Priest Venoxis\.",
	enrage_trigger = "High Priest Venoxis bekommt \'Wutanfall",
	holyfire_trigger = "High Priest Venoxis beginnt Heiliges Feuer zu wirken\.",
	phase2_trigger = "Let the coils of hate unfurl!",
	attack_trigger1 = "High Priest Venoxis greift an",
	attack_trigger2 = "High Priest Venoxis verfehlt",
	attack_trigger3 = "High Priest Venoxis trifft",
	attack_trigger4 = "High Priest Venoxis trifft (.+) kritisch",
	poisoncloud_trigger = "Giftwolke",
	poisoncloudhitsyou_trigger = "Ihr erleidet (.+) Naturschaden von High Priest Venoxis (durch Giftwolke)\.",
	poisoncloudhitsother_trigger = "(.+) erleidet (.+) Naturschaden von High Priest Venoxis (durch Giftwolke)\.",
	poisoncloud_on_you              = "You are afflicted by Poison Cloud.",
	poisoncloudabsorbyou_trigger = "Ihr absorbiert High Priest Venoxiss Giftwolke\.",
	poisoncloudabsorb_trigger = "Giftwolke von High Priest Venoxis wird absorbiert von\: (.+)\.",
	poisoncloudresistyou_trigger = "High Priest Venoxis versucht es mit Giftwolke\.\.\. widerstanden\.",
	poisoncloudresist_trigger = "High Priest Venoxiss Giftwolke wurde von (.+) widerstanden\.",
	poisoncloudimmuneyou_trigger = "High Priest Venoxis versucht es mit Giftwolke\.\.\. ein Fehlschlag. Ihr seid immun\.",
	poisoncloudimmune_trigger = "High Priest Venoxis versucht es mit Giftwolke. Ein Fehlschlag, denn (.+) ist immun\.",
	deadaddtrigger = "Razzashi Cobra stirbt",
	deadbosstrigger = "High Priest Venoxis stirbt",

	holyfirebar = "Heiliges Feuer",
	renewbar = "Erneuerung",
	renew_message = "Erneuerung! Entferne magie!",
	phase1_message = "Troll-Phase",
	phase2_message = "Schlange-Phase",
	enrage_message = "Boss ist in Raserei! Spam Heilung!",
	poisonyou_message = "Beweg\' dich aus dem Giftwolke!",
	poison_message = "Move away from poison cloud!",
	addmsg = "%d/4 Razzashi Cobra tot!",
	you = "Ihr",

	cmd = "Venoxis",

	adds_cmd = "adds",
	adds_name = "Z\195\164hler f\195\188r tote Adds",
	adds_desc = "Verk\195\188ndet Razzashi Cobras Tod",

	renew_cmd = "renew",
	renew_name = "Alarm f\195\188r Erneuerung",
	renew_desc = "Warnung, wenn Venoxis Erneuerung auf sich wirkt",

	holyfire_cmd = "holyfire",
	holyfire_name = "Alarm f\195\188r Heiliges Feuer",
	holyfire_desc = "Warnen, wenn Heiliges Feuer gewirkt wird",

	phase_cmd = "phase",
	phase_name = "Phasen-Benachrichtigung",
	phase_desc = "Verk\195\188ndet den Phasenwechsel des Bosses",

	announce_cmd = "whispers",
	announce_name = "Brennenden Personen fl\195\188stern",
	announce_desc = "Fl\195\188ster der Person, die im Giftwolken steht\n\n(Ben\195\182tigt Schlachtzugleiter oder Assistent)\n\n(Dementi: um \195\188berfl\195\188ssiges Fl\195\188stern zu vermeiden, wird es nur den Personen fl\195\188stern, die tats\195\164chlichen Schaden von den Giftwolken bekommen.)",

	enrage_cmd = "enrage",
	enrage_name = "Verk\195\188ndet Boss' Raserei",
	enrage_desc = "L\195\164sst dich wissen, wenn Boss h\195\164rter zuschl\195\164gt",
} end )


---------------------------------
--      	Variables 		   --
---------------------------------

-- module variables
module.revision = 20004 -- To be overridden by the module!
module.enabletrigger = module.translatedName -- string or table {boss, add1, add2}
module.wipemobs = { L["add_name"] } -- adds which will be considered in CheckForEngage
module.toggleoptions = {"phase", "adds", "renew", "holyfire", "enrage", "announce", "bosskill"}


-- locals
local timer = {
	holyfireCast = 3.5,
	holyfire = 8,
	renew = 20,
}
local icon = {
	addDead = "INV_WAEPON_BOW_ZULGRUB_D_01",
	cloud = "Ability_Creature_Disease_02",
	renew = "Spell_Holy_Renew",
	holyfire = "Spell_Holy_SearingLight",
}
local syncName = {
	phase2 = "VenoxisPhaseTwo"..module.revision,
	renew = "VenoxisRenewStart"..module.revision,
	renewOver = "VenoxisRenewStop"..module.revision,
	holyfire = "VenoxisHolyFireStart"..module.revision,
	holyfireOver = "VenoxisHolyFireStop"..module.revision,
	enrage = "VenoxisEnrage"..module.revision,
	addDead = "VenoxisAddDead"..module.revision,
}

local berserkannounced = nil


------------------------------
--      Initialization      --
------------------------------

--module:RegisterYellEngage(L["start_trigger"])

-- called after module is enabled
function module:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS", "Event")
	self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES", "Event")
	self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS", "Event")
	self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES", "Event")
	self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS", "Event")
	self:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", "Event")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF")

	self:ThrottleSync(10, syncName.phase2)
	self:ThrottleSync(2, syncName.renew)
	self:ThrottleSync(2, syncName.renewOver)
	self:ThrottleSync(2, syncName.holyfire)
	self:ThrottleSync(2, syncName.holyfireOver)
	self:ThrottleSync(5, syncName.enrage)
end

-- called after module is enabled and after each wipe
function module:OnSetup()
	self.started = nil
	self.cobra = 0

	castingholyfire = 0
	holyfiretime = 0

	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
end

-- called after boss is engaged
function module:OnEngage()
	if self.db.profile.phase then
		self:Message(L["phase1_message"], "Attention")
	end
	--self:TriggerEvent("BigWigs_StartCounterBar", self, "Snakes dead", 4, icon.addDead)
	--self:TriggerEvent("BigWigs_SetCounterBar", self, "Snakes dead", (4 - 0.1))
end

-- called after boss is disengaged (wipe(retreat) or victory)
function module:OnDisengage()
end


------------------------------
--      Events              --
------------------------------

function module:CHAT_MSG_COMBAT_HOSTILE_DEATH(msg)
	BigWigs:CheckForBossDeath(msg, self)

	if string.find(msg, L["deadaddtrigger"]) then
		self:Sync(syncName.addDead .. " " .. tostring(self.cobra + 1))
	end
end

function module:CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS(msg)
	if string.find(msg, L["renew_trigger"]) then
		self:Sync(syncName.renew)
	elseif string.find(msg, L["enrage_trigger"]) then
		self:Sync(syncName.enrage)
	end
end

function module:Event(msg)
	local _,_,poisoncloudhitsother,_ = string.find(msg, L["poisoncloudhitsother_trigger"])
	local _,_,poisoncloudabsorb,_ = string.find(msg, L["poisoncloudabsorb_trigger"])
	local _,_,poisoncloudresist,_ = string.find(msg, L["poisoncloudresist_trigger"])
	local _,_,poisoncloudimmune,_ = string.find(msg, L["poisoncloudimmune_trigger"])
	if string.find(msg, L["holyfire_trigger"]) then
		self:Sync(syncName.holyfire)
	elseif string.find(msg, L["attack_trigger1"]) or string.find(msg, L["attack_trigger2"]) or string.find(msg, L["attack_trigger3"]) or string.find(msg, L["attack_trigger4"]) then
		if castingholyfire == 1 then
			if (GetTime() - holyfiretime) < timer.holyfireCast then
				self:Sync("VenoxisHolyFireStop")
			elseif (GetTime() - holyfiretime) >= timer.holyfireCast then
				castingholyfire = 0
			end
		end
	elseif msg == L["poisoncloud_on_you"] then
		self:WarningSign(icon.cloud, 5)
		self:Message(L["poisonyou_message"], "Attention", "Alarm")
	elseif string.find(msg, L["poisoncloud_trigger"]) then
		if self.db.profile.announce then
			if string.find(msg, L["poisoncloudhitsyou_trigger"]) or msg == L["poisoncloudresistyou_trigger"] or msg == L["poisoncloudabsorbyou_trigger"] or msg == L["poisoncloudimmuneyou_trigger"] then
				self:Message(L["poisonyou_message"], "Attention", "Alarm")
			elseif poisoncloudhitsother and poisoncloudhitsother~=L["you"] then
				self:TriggerEvent("BigWigs_SendTell", poisoncloudhitsother, L["poison_message"])
			elseif poisoncloudresist then
				self:TriggerEvent("BigWigs_SendTell", poisoncloudresist, L["poison_message"])
			elseif poisoncloudabsorb then
				self:TriggerEvent("BigWigs_SendTell", poisoncloudabsorb, L["poison_message"])
			elseif poisoncloudimmune then
				self:TriggerEvent("BigWigs_SendTell", poisoncloudimmune, L["poison_message"])
			end
		end
	end
end

function module:CHAT_MSG_MONSTER_YELL(msg)
	if string.find(msg, L["phase2_trigger"]) then
		self:Sync(syncName.phase2)
	end
end

function module:CHAT_MSG_SPELL_AURA_GONE_OTHER(msg)
	if string.find(msg, L["renewend_trigger"]) then
		self:Sync(syncName.renewOver)
	end
end

function module:CHAT_MSG_SPELL_AURA_GONE_SELF(msg)
	if string.find(msg, L["poisoncloud_trigger"]) then
		self:RemoveWarningSign(icon.cloud)
	end
end


------------------------------
--      Synchronization	    --
------------------------------

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.phase2 then
		self:KTM_Reset()
		if self.db.profile.phase then
			self:Message(L["phase2_message"], "Attention")
		end
		if self.db.profile.holyfire then
			self:RemoveBar(L["holyfirebar"])
		end
	elseif sync == syncName.renew then
		if self.db.profile.renew then
			self:Message(L["renew_message"], "Urgent")
			self:Bar(L["renewbar"], timer.renew, icon.renew)
		end
	elseif sync == syncName.renewOver then
		if self.db.profile.renew then
			self:RemoveBar(L["renewbar"])
		end
	elseif sync == syncName.holyfire then
		holyfiretime = GetTime()
		castingholyfire = 1
		if self.db.profile.holyfire then
			self:Bar(L["holyfirebar"], timer.holyfireCast, icon.holyfire, true, "red")
			self:Bar("Next Holy Fire", timer.holyfire, icon.holyfire)
		end
	elseif sync == "VenoxisHolyFireStop" then
		castingholyfire = 0
		if self.db.profile.holyfire then
			self:RemoveBar(L["holyfirebar"])
		end
	elseif sync == syncName.enrage then
		if self.db.profile.enrage then
			self:Message(L["enrage_message"], "Attention")
		end
	elseif sync == syncName.addDead and rest and rest ~= "" then
		rest = tonumber(rest)
		if rest <= 4 and self.cobra < rest then
			self.cobra = rest
			self:Message(string.format(L["addmsg"], self.cobra), "Positive")
			--self:TriggerEvent("BigWigs_SetCounterBar", self, "Snakes dead", (4 - self.cobra))
		end
	end
end
