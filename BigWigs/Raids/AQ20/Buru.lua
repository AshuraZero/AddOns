
----------------------------------
--      Module Declaration      --
----------------------------------

local module, L = BigWigs:ModuleDeclaration("Buru the Gorger", "Ruins of Ahn'Qiraj")


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("zhCN", function() return {
	cmd = "Buru",

	you_cmd = "you",
	you_name = "你被监视着警报",
	you_desc = "你被监视着警报",

	other_cmd = "other",
	other_name = "其他人被监视警报",
	other_desc = "其他人被监视警报",

	icon_cmd = "icon",
	icon_name = "头像图标",
	icon_desc = "图标放在被监视头上 (需要L或A)",

	watchtrigger = "sets eyes on (.+)!",
	watchwarn = " 被监视!",
	watchwarnyou = "你被监视!",
	you = "你",
} end )

L:RegisterTranslations("deDE", function() return {
	you_name = "Du wirst beobachtet",
	you_desc = "Warnung, wenn Du beobachtet wirst.",

	other_name = "X wird beobachtet",
	other_desc = "Warnung, wenn andere Spieler beobachtet werden.",

	icon_name = "Symbol",
	icon_desc = "Platziert ein Symbol \195\188ber dem Spieler, der beobachtet wird. (Ben\195\182tigt Anf\195\188hrer oder Bef\195\182rdert Status.)",

	watchtrigger = "beh\195\164lt (.+) im Blickfeld!",
	watchwarn = " wird beobachtet!",
	watchwarnyou = "Du wirst beobachtet!",
	you = "Euch",
} end )


---------------------------------
--      	Variables 		   --
---------------------------------

-- module variables
module.revision = 20004 -- To be overridden by the module!
module.enabletrigger = module.translatedName -- string or table {boss, add1, add2}
module.toggleoptions = {"you", "other", "icon", "bosskill"}

-- locals
local timer = {}
local icon = {}
local syncName = {}


------------------------------
--      Initialization      --
------------------------------

-- called after module is enabled
function module:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
end

-- called after module is enabled and after each wipe
function module:OnSetup()
end

-- called after boss is engaged
function module:OnEngage()
end

-- called after boss is disengaged (wipe(retreat) or victory)
function module:OnDisengage()
end


------------------------------
--      Event Handlers	    --
------------------------------

function module:CHAT_MSG_MONSTER_EMOTE( msg )
	local _, _, player = string.find(msg, L["watchtrigger"])
	if player then
		if player == L["you"] and self.db.profile.you then
			player = UnitName("player")
			self:Message(L["watchwarnyou"], "Personal", true, "RunAway")
			self:Message(UnitName("player") .. L["watchwarn"], "Attention", nil, nil, true)
		elseif self.db.profile.other then
			self:Message(player .. L["watchwarn"], "Attention")
			self:TriggerEvent("BigWigs_SendTell", player, L["watchwarnyou"])
		end

		if self.db.profile.icon then
			self:Icon(player)
		end
	end
end
