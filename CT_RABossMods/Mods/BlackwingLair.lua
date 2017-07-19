tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Razorgore_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Vaelastrasz_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Firemaw_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ebonroc_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Flamegor_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Chromaggus_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Nefarian_OnLoad");
tinsert(CT_RABoss_ModsToLoad,"CT_RABoss_Broodlord_OnLoad");

-- Razorgore
function CT_RABoss_Razorgore_OnLoad()
	CT_RABoss_AddMod("Razorgore", CT_RABOSS_RAZOR_INFO, 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);

	CT_RABoss_AddEvent("Razorgore", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Razorgore_EventHandler);
	CT_RABoss_AddEvent("Razorgore", "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF", CT_RABoss_Razorgore_EventHandler);
	CT_RABoss_AddEvent("Razorgore", "CHAT_MSG_ADDON", CT_RABoss_Razorgore_EventHandler);
	
	CT_RABoss_AddDropDownButton("Razorgore", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Razorgore", { CT_RABOSS_RAZOR_MC, CT_RABOSS_RAZOR_MC_INFO }, "CT_RABoss_ModInfo", "mindControl", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Razorgore", { CT_RABOSS_RAZOR_EGGS, CT_RABOSS_RAZOR_EGGS_INFO }, "CT_RABoss_ModInfo", "eggsCount", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Razorgore", { CT_RABOSS_RAZOR_EGGSSYNC, CT_RABOSS_RAZOR_EGGSSYNC_INFO }, "CT_RABoss_ModInfo", "eggsSync", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Razorgore", { CT_RABOSS_RAZOR_EGGSEST, CT_RABOSS_RAZOR_EGGSEST_INFO }, "CT_RABoss_ModInfo", "eggsTime", "CT_RABoss_SetInfo");
end

function CT_RABoss_Razorgore_EventHandler(event)
	if ( not CT_RABoss_Mods["Razorgore"] or not CT_RABoss_Mods["Razorgore"]["status"] or not CT_RABoss_Mods["Razorgore"].enabled ) then
		return;
	end
	-- Mind Control alert
	if ( event == "CHAT_MSG_MONSTER_YELL" and CT_RABoss_Mods["Razorgore"]["mindControl"] ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_RAZOR_MC_DETECT);
		if ( sPlayer ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAZOR_MC_WARN, sPlayer), CT_RABoss_Mods["Razorgore"]["announce"]);
			CT_RABoss_PlaySound(3);
		end
	end
	-- Init eggs count
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_RAZOR_BEGIN_DETECT) and CT_RABoss_Mods["Razorgore"]["eggsCount"] ) then
		CT_RABoss_Counter.initialize("Razorgore", "EggCount", CT_RABoss_Mods["Razorgore"]["eggsSync"], CT_RABoss_Mods["Razorgore"]["announce"], 30, CT_RABOSS_RAZOR_MOBNAME, CT_RABOSS_RAZOR_EGG_WARN, CT_RABOSS_RAZOR_EGG_COUNTHEADER);
		CT_RABoss_Counter.setOptions("Razorgore", "EggCount", {["displayEstEnd"] = CT_RABoss_Mods["Razorgore"]["eggsTime"], ["discardTime"] = 1000});

		CT_RABoss_Announce(CT_RABOSS_RAZOR_BEGIN_WARN, CT_RABoss_Mods["Razorgore"]["announce"]);
		CT_RABoss_PlaySound(2);
	end
	-- Eggs count alerts
	if ( event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" and CT_RABoss_Mods["Razorgore"]["eggsCount"] ) then
		local iStart, iEnd, mobName = string.find(arg1, CT_RABOSS_RAZOR_EGG_DETECT);
		
		if ( mobName ) then
			CT_RABoss_Counter.sendSync(mobName, "Razorgore", "EggCount");
		end
	elseif ( event == "CHAT_MSG_ADDON" and CT_RABoss_Mods["Razorgore"]["eggsCount"] and arg1 == "CTRA" and arg3 == "RAID" ) then
		CT_RABoss_Counter.receiveSync(arg2, arg4, "Razorgore", "EggCount");
	end

end


-- Vaelastrasz
function CT_RABoss_Vaelastrasz_OnLoad()
	CT_RABoss_AddMod("Vaelastrasz", CT_RABOSS_VAEL_INFO, 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);

	CT_RABoss_AddEvent("Vaelastrasz", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Vaelastrasz_EventHandler);
	CT_RABoss_AddEvent("Vaelastrasz", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Vaelastrasz_EventHandler);
	CT_RABoss_AddEvent("Vaelastrasz", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Vaelastrasz_EventHandler);
	
	CT_RABoss_AddDropDownButton("Vaelastrasz", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Vaelastrasz", { CT_RABOSS_VAEL_ALERT_NEARBY, CT_RABOSS_VAEL_ALERT_NEARBY_INFO }, "CT_RABoss_ModInfo", "alertNearby", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Vaelastrasz", { CT_RABOSS_VAEL_TELL_TARGET, CT_RABOSS_VAEL_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Vaelastrasz", "alertNearby", 1);
end

function CT_RABoss_Vaelastrasz_EventHandler(event)
	if ( not CT_RABoss_Mods["Vaelastrasz"] or not CT_RABoss_Mods["Vaelastrasz"]["status"] or not CT_RABoss_Mods["Vaelastrasz"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or ( ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) and CT_RABoss_Mods["Vaelastrasz"]["alertNearby"] ) ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_VAEL_AFFLICT_BURNING);
		if ( sPlayer ) then
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				CT_RABoss_Announce(CT_RABOSS_VAEL_BOMBWARNYOU);
				CT_RABoss_Announce(CT_RABOSS_VAEL_BOMBWARNYOU);
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Vaelastrasz"]["announce"] ) then
					SendChatMessage("*** " .. UnitName("player") .. CT_RABOSS_VAEL_BURNINGWARNRAID, "RAID_WARNING");
				end
				CT_RABoss_PlaySound(2);
			elseif ( CT_RABoss_Mods["Vaelastrasz"]["alertNearby"] or CT_RABoss_Mods["Vaelastrasz"]["sendTell"] ) then
				if ( CT_RABoss_Mods["Vaelastrasz"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_VAEL_BURNINGWARNTELL, "WHISPER", nil, sPlayer);
				end
				if ( CT_RABoss_Mods["Vaelastrasz"]["alertNearby"] ) then
					CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_VAEL_BURNINGWARNRAID, CT_RABoss_Mods["Vaelastrasz"]["announce"]);
					CT_RABoss_PlaySound(3);
				end
			end
		end
	end
end


-- Broodlord
function CT_RABoss_Broodlord_OnLoad()
	CT_RABoss_AddMod("Broodlord", CT_RABOSS_BROODLORD_INFO, 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);
	
	CT_RABoss_AddEvent("Broodlord", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Broodlord_EventHandler);
	CT_RABoss_AddEvent("Broodlord", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Broodlord_EventHandler);
	CT_RABoss_AddEvent("Broodlord", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Broodlord_EventHandler);
	
	CT_RABoss_AddDropDownButton("Broodlord", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Broodlord_EventHandler(event)
	if ( not CT_RABoss_Mods["Broodlord"] or not CT_RABoss_Mods["Broodlord"]["status"] or not CT_RABoss_Mods["Broodlord"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		local _, _, playerName = string.find(arg1, CT_RABOSS_BROODLORD_SACRIFICE_DETECT);
		
		if ( playerName ) then
			if ( playerName == CT_RABOSS_SELF1 ) then
				sPlayer = UnitName("player");
				
			end
			
			CT_RABoss_PlaySound(1);
			CT_RABoss_Announce(format(CT_RABOSS_BROODLORD_SACRIFICE_ALERT, playerName), CT_RABoss_Mods["Broodlord"]["announce"]);
		end
	end
end



-- Firemaw Wing Buffet and Shadowflame (Thanks to Puddy and Sting of Blood Legion - Illidan Horde)
function CT_RABoss_Firemaw_OnLoad()
	CT_RABoss_AddMod("Firemaw", CT_RABOSS_FIREMAW_INFO, 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);

	CT_RABoss_AddEvent("Firemaw", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Firemaw_EventHandler);
	CT_RABoss_AddEvent("Firemaw", "PLAYER_REGEN_DISABLED", CT_RABoss_Firemaw_EventHandler);

	CT_RABoss_AddDropDownButton("Firemaw", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");	
	CT_RABoss_AddDropDownButton("Firemaw", { CT_RABOSS_SHADOWFLAME, CT_RABOSS_SHADOWFLAME_INFO }, "CT_RABoss_ModInfo", "shadowflame", "CT_RABoss_SetInfo");

	CT_RABoss_SetVar("Firemaw", "shadowflame", 1);
end

function CT_RABoss_Firemaw_EventHandler(event)
	if ( not CT_RABoss_Mods["Firemaw"] or not CT_RABoss_Mods["Firemaw"]["status"] or not CT_RABoss_Mods["Firemaw"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, CT_RABOSS_FIREMAW_BUFFET) and not CT_RABoss_Mods["Firemaw"]["BuffetTrip"] ) then
		CT_RABoss_Announce(CT_RABOSS_FIREMAW_BUFFET_WARN, CT_RABoss_Mods["Firemaw"]["announce"]);
		CT_RABoss_Mods["Firemaw"]["BuffetTrip"] = true;
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Firemaw_EventHandler", 29, "preBuffetWarning");
		CT_RABoss_VisualTimer.addTimer("FiremawBuffet", 30, CT_RABOSS_FIREMAW_BUFFET_TIMER);

	elseif ( event == "preBuffetWarning" ) then
		CT_RABoss_Mods["Firemaw"]["BuffetTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_FIREMAW_3SECWARN, CT_RABoss_Mods["Firemaw"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and string.find(arg1, CT_RABOSS_FIREMAW_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Firemaw"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_FIREMAW_SHADOWFLAME_WARN, CT_RABoss_Mods["Firemaw"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "PLAYER_REGEN_DISABLED" ) then
		CT_RABoss_Schedule("CT_RABoss_Firemaw_EventHandler", 5, "checkStart");


	elseif ( event == "checkStart" ) then
		if ( UnitExists("target") and UnitName("target") == CT_RABOSS_NAMES["Firemaw"] and UnitAffectingCombat("target") ) then
			CT_RABoss_Announce(CT_RABOSS_FIREMAW_BUFFET_WARN_FIRST, CT_RABoss_Mods["Firemaw"]["announce"]);
			CT_RABoss_Mods["Firemaw"]["BuffetTrip"] = true;
			CT_RABoss_PlaySound(2);
			CT_RABoss_Schedule("CT_RABoss_Firemaw_EventHandler", 23, "preBuffetWarning");
			CT_RABoss_VisualTimer.addTimer("FiremawBuffet", 27, CT_RABOSS_FIREMAW_BUFFET_TIMER);
		end

	end
end


-- Ebonroc Wing Buffet and Shadowflame (Thanks to Sting of Blood Legion - Illidan Horde)
function CT_RABoss_Ebonroc_OnLoad()
	CT_RABoss_AddMod("Ebonroc", CT_RABOSS_EBONROC_INFO, 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);

	CT_RABoss_AddEvent("Ebonroc", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Ebonroc_EventHandler);
	CT_RABoss_AddEvent("Ebonroc", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Ebonroc_EventHandler);
	CT_RABoss_AddEvent("Ebonroc", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Ebonroc_EventHandler);
	CT_RABoss_AddEvent("Ebonroc", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Ebonroc_EventHandler);
	CT_RABoss_AddEvent("Ebonroc", "PLAYER_REGEN_DISABLED", CT_RABoss_Ebonroc_EventHandler);

	CT_RABoss_AddDropDownButton("Ebonroc", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");	
	CT_RABoss_AddDropDownButton("Ebonroc", { CT_RABOSS_SHADOWFLAME, CT_RABOSS_SHADOWFLAME_INFO }, "CT_RABoss_ModInfo", "shadowflame", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Ebonroc", { CT_RABOSS_EBONROC_SHADOW, CT_RABOSS_EBONROC_SHADOW_INFO }, "CT_RABoss_ModInfo", "shadowEbonroc", "CT_RABoss_SetInfo");

	CT_RABoss_SetVar("Ebonroc", "shadowflame", 1);
	CT_RABoss_SetVar("Ebonroc", "shadowEbonroc", 1);
end

function CT_RABoss_Ebonroc_EventHandler(event)
	if ( not CT_RABoss_Mods["Ebonroc"] or not CT_RABoss_Mods["Ebonroc"]["status"] or not CT_RABoss_Mods["Ebonroc"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, CT_RABOSS_EBONROC_BUFFET) and not CT_RABoss_Mods["Ebonroc"]["BuffetTrip"] ) then
		CT_RABoss_Announce(CT_RABOSS_EBONROC_BUFFET_WARN, CT_RABoss_Mods["Ebonroc"]["announce"]);
		CT_RABoss_Mods["Ebonroc"]["BuffetTrip"] = true;
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Ebonroc_EventHandler", 29, "preBuffetWarning");
		CT_RABoss_VisualTimer.addTimer("EbonrocBuffet", 30, CT_RABOSS_EBONROC_BUFFET_TIMER);

	elseif ( event == "preBuffetWarning" ) then
		CT_RABoss_Mods["Ebonroc"]["BuffetTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_EBONROC_3SECWARN, CT_RABoss_Mods["Ebonroc"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and string.find(arg1, CT_RABOSS_EBONROC_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Ebonroc"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_EBONROC_SHADOWFLAME_WARN, CT_RABoss_Mods["Ebonroc"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or ( ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) and CT_RABoss_Mods["Ebonroc"]["shadowEbonroc"] ) ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_EBONROC_AFFLICT_BOMB);

		if ( sPlayer ) then
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				CT_RABoss_Announce(CT_RABOSS_EBONROC_SOEYOU);
				CT_RABoss_Announce(CT_RABOSS_EBONROC_SOEYOU);

				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Ebonroc"]["announce"] ) then
					SendChatMessage(format(CT_RABOSS_EBONROC_SOEOTHER, UnitName("player")), "RAID_WARNING");
				end
				CT_RABoss_PlaySound(1);
			elseif ( CT_RABoss_Mods["Ebonroc"]["shadowEbonroc"] ) then
				if ( CT_RABoss_Mods["Ebonroc"]["shadowEbonroc"] ) then
					CT_RABoss_Announce(format(CT_RABOSS_EBONROC_SOEOTHER, sPlayer), CT_RABoss_Mods["Ebonroc"]["announce"]);
					CT_RABoss_PlaySound(1);
				end
			end
		end

	elseif ( event == "PLAYER_REGEN_DISABLED" ) then
		CT_RABoss_Schedule("CT_RABoss_Ebonroc_EventHandler", 5, "checkStart");

	elseif ( event == "checkStart" ) then
		if ( UnitName("target") == CT_RABOSS_NAMES["Ebonroc"] and UnitAffectingCombat("target") ) then
			CT_RABoss_Announce(CT_RABOSS_EBONROC_BUFFET_WARN_FIRST, CT_RABoss_Mods["Ebonroc"]["announce"]);
			CT_RABoss_Mods["Ebonroc"]["BuffetTrip"] = true;
			CT_RABoss_PlaySound(2);
			CT_RABoss_Schedule("CT_RABoss_Ebonroc_EventHandler", 23, "preBuffetWarning");
			CT_RABoss_VisualTimer.addTimer("EbonrocBuffet", 27, CT_RABOSS_EBONROC_BUFFET_TIMER);
		end
	end
end


-- Flamegor Wing Buffet, Shadowflame, and Frenzy (Thanks to Sting of Blood Legion - Illidan Horde)
function CT_RABoss_Flamegor_OnLoad()
	CT_RABoss_AddMod("Flamegor", CT_RABOSS_FLAMEGOR_INFO, 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);

	CT_RABoss_AddEvent("Flamegor", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Flamegor_EventHandler);
	CT_RABoss_AddEvent("Flamegor", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Flamegor_EventHandler);				-- Frenzy
	CT_RABoss_AddEvent("Flamegor", "PLAYER_REGEN_DISABLED", CT_RABoss_Flamegor_EventHandler);

	CT_RABoss_AddDropDownButton("Flamegor", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");	
	CT_RABoss_AddDropDownButton("Flamegor", { CT_RABOSS_FLAMEGOR_FRENZY, CT_RABOSS_FLAMEGOR_FRENZY_INFO }, "CT_RABoss_ModInfo", "frenzyAlert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Flamegor", { CT_RABOSS_SHADOWFLAME, CT_RABOSS_SHADOWFLAME_INFO }, "CT_RABoss_ModInfo", "shadowflame", "CT_RABoss_SetInfo");

	CT_RABoss_SetVar("Flamegor", "shadowflame", 1);
	CT_RABoss_SetVar("Flamegor", "frenzyAlert", 1);
end

function CT_RABoss_Flamegor_EventHandler(event)
	if ( not CT_RABoss_Mods["Flamegor"] or not CT_RABoss_Mods["Flamegor"]["status"] or not CT_RABoss_Mods["Flamegor"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, CT_RABOSS_FLAMEGOR_BUFFET) and not CT_RABoss_Mods["Flamegor"]["BuffetTrip"] ) then
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_BUFFET_WARN, CT_RABoss_Mods["Flamegor"]["announce"]);
		CT_RABoss_Mods["Flamegor"]["BuffetTrip"] = true;
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Flamegor_EventHandler", 29, "preBuffetWarning");
		CT_RABoss_VisualTimer.addTimer("FlamegorBuffet", 30, CT_RABOSS_FLAMEGOR_BUFFET_TIMER);

	elseif ( event == "preBuffetWarning" ) then
		CT_RABoss_Mods["Flamegor"]["BuffetTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_3SECWARN, CT_RABoss_Mods["Flamegor"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and string.find(arg1, CT_RABOSS_FLAMEGOR_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Flamegor"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_SHADOWFLAME_WARN, CT_RABoss_Mods["Flamegor"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( (event == "CHAT_MSG_MONSTER_EMOTE") and string.find(arg1, CT_RABOSS_FLAMEGOR_FRENZY_DETECT) and (CT_RABoss_Mods["Flamegor"]["frenzyAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_TRANQSHOT, CT_RABoss_Mods["Flamegor"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "PLAYER_REGEN_DISABLED" ) then
		CT_RABoss_Schedule("CT_RABoss_Flamegor_EventHandler", 5, "checkStart");

	elseif ( event == "checkStart" ) then
		if ( UnitName("target") == CT_RABOSS_NAMES["Flamegor"] and UnitAffectingCombat("target") ) then
			CT_RABoss_Announce(CT_RABOSS_FLAMEGOR_BUFFET_WARN_FIRST, CT_RABoss_Mods["Flamegor"]["announce"]);
			CT_RABoss_Mods["Flamegor"]["BuffetTrip"] = true;
			CT_RABoss_PlaySound(2);
			CT_RABoss_Schedule("CT_RABoss_Flamegor_EventHandler", 23, "preBuffetWarning");
			CT_RABoss_VisualTimer.addTimer("FlamegorBuffet", 27, CT_RABOSS_FLAMEGOR_BUFFET_TIMER);
		end

	end
end


-- Chromaggus
CT_RABoss_Chromaggus_PlayerDamageEvents =
{
	["CHAT_MSG_SPELL_SELF_DAMAGE"] = true,
	["CHAT_MSG_SPELL_PET_DAMAGE"] = true,
	["CHAT_MSG_SPELL_PARTY_DAMAGE"] = true,
	["CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"] = true
};

function CT_RABoss_Chromaggus_OnLoad() -- Many many thanks to Silmalia of Ebon Order for the majority of code for this mod
	CT_RABoss_AddMod("Chromaggus", CT_RABOSS_CHROMAGGUS_INFO, 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);

	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_CHROMAGGUS_BREATHWARNING, CT_RABOSS_CHROMAGGUS_BREATHWARNING_INFO }, "CT_RABoss_ModInfo", "breathWarning", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_CHROMAGGUS_CASTWARNING, CT_RABOSS_CHROMAGGUS_CASTWARNING_INFO }, "CT_RABoss_ModInfo", "castWarning", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_CHROMAGGUS_SHIELDWARNING, CT_RABOSS_CHROMAGGUS_SHIELDWARNING_INFO }, "CT_RABoss_ModInfo", "shieldWarning", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Chromaggus", { CT_RABOSS_CHROMAGGUS_FRENZYWARNING, CT_RABOSS_CHROMAGGUS_FRENZYWARNING_INFO }, "CT_RABoss_ModInfo", "frenzyWarning", "CT_RABoss_SetInfo");

	CT_RABoss_UnSchedule("CT_RABoss_Chromaggus_OnEvent");

	CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH1] = CT_RABOSS_CHROMAGGUS_BREATH1;
	CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH2] = CT_RABOSS_CHROMAGGUS_BREATH2;
	CT_RABoss_Mods["Chromaggus"]["LastBreath"] = nil;
	CT_RABoss_Mods["Chromaggus"]["Vulnerability"] = nil;
	CT_RABoss_Mods["Chromaggus"]["checkStart"] = nil;

	CT_RABoss_SetVar("Chromaggus", "breathWarning", true);
	CT_RABoss_SetVar("Chromaggus", "castWarning", false);
	CT_RABoss_SetVar("Chromaggus", "frenzyWarning", false);
	CT_RABoss_SetVar("Chromaggus", "shieldWarning", false);

	CT_RABoss_AddEvent("Chromaggus", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Chromaggus_OnEvent); -- Breaths
	CT_RABoss_AddEvent("Chromaggus", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Chromaggus_OnEvent); -- Frenzy
	CT_RABoss_AddEvent("Chromaggus", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Chromaggus_OnEvent); -- Elemental Shield
	CT_RABoss_AddEvent("Chromaggus", "PLAYER_REGEN_DISABLED", CT_RABoss_Chromaggus_OnEvent); -- Start of encounter

	for k, v in CT_RABoss_Chromaggus_PlayerDamageEvents do
		CT_RABoss_AddEvent("Chromaggus", k, CT_RABoss_Chromaggus_OnEvent); -- Detect Elemental Shield vulnerable school
	end
end

function CT_RABoss_Chromaggus_ResetMod()
	CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH1] = CT_RABOSS_CHROMAGGUS_BREATH1;
	CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH2] = CT_RABOSS_CHROMAGGUS_BREATH2;
	CT_RABoss_Mods["Chromaggus"]["LastBreath"] = nil;
	CT_RABoss_Mods["Chromaggus"]["checkStart"] = nil;
	CT_RABoss_Mods["Chromaggus"]["Vulnerability"] = nil;

	CT_RABoss_UnSchedule("CT_RABoss_Chromaggus_OnEvent");
end

function CT_RABoss_Chromaggus_OnEvent(event)
	-- Return if the mod is not enabled
	if ( not CT_RABoss_Mods["Chromaggus"] or not CT_RABoss_Mods["Chromaggus"]["enabled"] or not CT_RABoss_Mods["Chromaggus"]["status"] ) then
		return;
	end
	
	-- Set to current time
	local currTime = GetTime();

	if ( CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH1] and ( not CT_RABoss_Mods["Chromaggus"]["LastAction"] or ( currTime - CT_RABoss_Mods["Chromaggus"]["LastAction"] ) > CT_RABOSS_CHROMAGGUS_COMBATLIMIT ) and not CT_RABoss_Mods["Chromaggus"]["checkStart"] ) then
		CT_RABoss_Debug(1, "Resetting mod", currTime - ( CT_RABoss_Mods["Chromaggus"]["LastAction"] or currTime+1 ));
		CT_RABoss_Chromaggus_ResetMod();
	end
	
	if ( CT_RABoss_Mods["Chromaggus"]["breathWarning"] and ( event == CT_RABOSS_CHROMAGGUS_BREATH1 or event == CT_RABOSS_CHROMAGGUS_BREATH2 ) ) then
		-- Breath warnings
--		local name = event;
--		if ( CT_RABoss_Mods["Chromaggus"][event] ) then
		local name = CT_RABoss_Mods["Chromaggus"][event];
--		end
		CT_RABoss_Debug(2, "Warning for scheduled breath", event, name);
		CT_RABoss_Announce(format(CT_RABOSS_CHROMAGGUS_BREATH10SECWARNING, name), CT_RABoss_Mods["Chromaggus"]["announce"]);
		CT_RABoss_PlaySound(1);
		
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" ) then
		-- Breath attack
		local iStart, iEnd, spellName = string.find(arg1, CT_RABOSS_CHROMAGGUS_BREATHCASTSTRING);
		
		if ( spellName ) then
			-- Set the names if they are not set yet
			if ( CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH1] == CT_RABOSS_CHROMAGGUS_BREATH1 ) then
				CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH1] = spellName;
				CT_RABoss_Debug(3, "Setting breath 1", spellName);
			elseif ( CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH2] == CT_RABOSS_CHROMAGGUS_BREATH2 ) then
				CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH2] = spellName;
				CT_RABoss_Debug(3, "Setting breath 2", spellName);
			end
			
			-- Used to make sure we're still fighting
			CT_RABoss_Mods["Chromaggus"]["LastAction"] = currTime;
			
			if ( CT_RABoss_Mods["Chromaggus"]["castWarning"] ) then
				CT_RABoss_Announce(format(CT_RABOSS_CHROMAGGUS_BREATHCASTINGWARNING, spellName), CT_RABoss_Mods["Chromaggus"]["announce"]);
			end
			
			if ( CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH1] == spellName ) then
				CT_RABoss_Schedule("CT_RABoss_Chromaggus_OnEvent", CT_RABOSS_CHROMAGGUS_BREATHWARNINGTIME, CT_RABOSS_CHROMAGGUS_BREATH1);
				CT_RABoss_VisualTimer.addTimer("ChromaggusBreath", 30, CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH2]);
				CT_RABoss_Debug(2, "Scheduling breath", CT_RABOSS_CHROMAGGUS_BREATH1);
			elseif ( CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH2] == spellName ) then
				CT_RABoss_Schedule("CT_RABoss_Chromaggus_OnEvent", CT_RABOSS_CHROMAGGUS_BREATHWARNINGTIME, CT_RABOSS_CHROMAGGUS_BREATH2);
				CT_RABoss_VisualTimer.addTimer("ChromaggusBreath", 30, CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH1]);
				CT_RABoss_Debug(2, "Scheduling breath", CT_RABOSS_CHROMAGGUS_BREATH2);
			end
		end
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		-- Frenzy
		if ( string.find(arg1, CT_RABOSS_CHROMAGGUS_FRENZYEMOTE) and arg2 == CT_RABOSS_NAMES["Chromaggus"] ) then
			if ( CT_RABoss_Mods["Chromaggus"]["frenzyWarning"] ) then
				CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_FRENZYCASTWARNING, CT_RABoss_Mods["Chromaggus"]["announce"]);
				CT_RABoss_PlaySound(2);
			end
			-- Used to make sure we're still fighting
			CT_RABoss_Mods["Chromaggus"]["LastAction"] = currTime;
			
		-- Elemental Shield
		elseif ( string.find(arg1, CT_RABOSS_CHROMAGGUS_SHIELDEMOTE) and arg2 == CT_RABOSS_NAMES["Chromaggus"] ) then
			if ( CT_RABoss_Mods["Chromaggus"]["shieldWarning"] ) then
				--CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_NEWVULNERABILITYWARNING, CT_RABoss_Mods["Chromaggus"]["announce"]);
				CT_RABoss_Announce(CT_RABOSS_CHROMAGGUS_NEWVULNERABILITYWARNING);
				CT_RABoss_PlaySound(1);
			end
			-- Used to make sure we're still fighting
			CT_RABoss_Mods["Chromaggus"]["LastAction"] = currTime;
			
			-- Since spells that are in the air when Chromaggus changes resists will still hit him with vulnerability bonus, we wait 2.5 seconds before we clear resists.
			CT_RABoss_Schedule( function() CT_RABoss_Mods["Chromaggus"]["Vulnerability"] = nil CT_RABoss_Debug(4, "Resetting vulnerability"); end, CT_RABOSS_CHROMAGGUS_WAITSHIELDCLEAR);
		end
		
	elseif ( CT_RABoss_Chromaggus_PlayerDamageEvents[event] ) then
		-- Check for new vulnerabilities
		if ( not CT_RABoss_Mods["Chromaggus"]["Vulnerability"] ) then
			local iStart, iEnd, hittype, damage, school = string.find(arg1, CT_RABOSS_CHROMAGGUS_SPELLDAMAGESTRING);
			if ( tonumber(damage or "") ) then
				CT_RABoss_Debug(1, "Registered hit", hittype, tonumber(damage), school);
				-- Used to make sure we're still fighting
				CT_RABoss_Mods["Chromaggus"]["LastAction"] = currTime;
				
				if ( 
					( tonumber(damage) >= CT_RABOSS_CHROMAGGUS_ELEMENTALSHIELDLIMIT_HIT and string.find(hittype, CT_RABOSS_CHROMAGGUS_HIT) ) or
					( tonumber(damage) >= CT_RABOSS_CHROMAGGUS_ELEMENTALSHIELDLIMIT_CRIT and string.find(hittype, CT_RABOSS_CHROMAGGUS_CRIT) )
				) then
					CT_RABoss_Debug(4, "Setting vulnerability", school, (tonumber(damage) or -1));
					CT_RABoss_Mods["Chromaggus"]["Vulnerability"] = school;
					
					if ( CT_RABoss_Mods["Chromaggus"]["shieldWarning"] ) then
						CT_RABoss_Announce(format(CT_RABOSS_CHROMAGGUS_NEWVULNERABILITYFOUNDWARNING, school), CT_RABoss_Mods["Chromaggus"]["announce"]);
						CT_RABoss_Announce(format(CT_RABOSS_CHROMAGGUS_NEWVULNERABILITYFOUNDWARNING, school));
						CT_RABoss_PlaySound(2);
					end
				end
			end
		end
			
	elseif ( event == "PLAYER_REGEN_DISABLED" ) then
		if ( UnitExists("target") and UnitName("target") == CT_RABOSS_CHROMAGGUS_BOSSNAME and UnitAffectingCombat("target") ) then
			CT_RABoss_Chromaggus_ResetMod();
			-- Used to make sure we're still fighting
			CT_RABoss_Mods["Chromaggus"]["LastAction"] = currTime;
			
			CT_RABoss_Schedule("CT_RABoss_Chromaggus_OnEvent", CT_RABOSS_CHROMAGGUS_BREATHWARNINGTIME - CT_RABOSS_CHROMAGGUS_BREATHINTERVAL - 5, CT_RABOSS_CHROMAGGUS_BREATH1);
			CT_RABoss_Schedule("CT_RABoss_Chromaggus_OnEvent", CT_RABOSS_CHROMAGGUS_BREATHWARNINGTIME - 5, CT_RABOSS_CHROMAGGUS_BREATH2);
			CT_RABoss_VisualTimer.addTimer("ChromaggusBreath", 25, CT_RABoss_Mods["Chromaggus"][CT_RABOSS_CHROMAGGUS_BREATH1]);
		else
			CT_RABoss_Mods["Chromaggus"]["LastAction"] = nil;
		end		
	end
end

-- Nefarian (Thanks to Sting of Blood Legion - Illidan Horde)
function CT_RABoss_Nefarian_OnLoad()
	CT_RABoss_AddMod("Nefarian", CT_RABOSS_NEFARIAN_INFO, 1, CT_RABOSS_LOCATIONS_BLACKWINGSLAIR);
	
	CT_RABoss_AddEvent("Nefarian", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Nefarian_EventHandler);
	CT_RABoss_AddEvent("Nefarian", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Nefarian_EventHandler);
	CT_RABoss_AddEvent("Nefarian", "CHAT_MSG_COMBAT_HOSTILE_DEATH", CT_RABoss_Nefarian_EventHandler);
	CT_RABoss_AddEvent("Nefarian", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Nefarian_EventHandler);
	CT_RABoss_AddEvent("Nefarian", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Nefarian_EventHandler);
	CT_RABoss_AddEvent("Nefarian", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Nefarian_EventHandler);
	CT_RABoss_AddEvent("Nefarian", "CHAT_MSG_ADDON", CT_RABoss_Nefarian_EventHandler);
	
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_NEFARIAN_SHADOWFLAME, CT_RABOSS_NEFARIAN_SHADOWFLAME_INFO }, "CT_RABoss_ModInfo", "shadowflame", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_NEFARIAN_FEAR, CT_RABOSS_NEFARIAN_FEAR_INFO }, "CT_RABoss_ModInfo", "fearAlert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_NEFARIAN_VEIL, CT_RABOSS_NEFARIAN_VEIL_INFO }, "CT_RABoss_ModInfo", "veilOfShadow", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_NEFARIAN_KC, CT_RABOSS_NEFARIAN_KC_INFO }, "CT_RABoss_ModInfo", "KillCount", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_NEFARIAN_KCS, CT_RABOSS_NEFARIAN_KCS_INFO }, "CT_RABoss_ModInfo", "KillSync", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_NEFARIAN_KCEST, CT_RABOSS_NEFARIAN_KCEST_INFO }, "CT_RABoss_ModInfo", "KillTime", "CT_RABoss_SetInfo");
	--precast warnings
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_NEFARIAN_PREFEAR, CT_RABOSS_NEFARIAN_PREFEAR_INFO }, "CT_RABoss_ModInfo", "PrefearAlert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_NEFARIAN_PRESHAD, CT_RABOSS_NEFARIAN_PRESHAD_INFO }, "CT_RABoss_ModInfo", "PreShadAlert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Nefarian", { CT_RABOSS_NEFARIAN_PRECLASS, CT_RABOSS_NEFARIAN_PRECLASS_INFO }, "CT_RABoss_ModInfo", "PreClassAlert", "CT_RABoss_SetInfo");
end

function CT_RABoss_Nefarian_EventHandler(event)
	if ( not CT_RABoss_Mods["Nefarian"] or not CT_RABoss_Mods["Nefarian"]["status"] or not CT_RABoss_Mods["Nefarian"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_START) and CT_RABoss_Mods["Nefarian"]["KillCount"] ) then
		CT_RABoss_Counter.initialize("Nefarian", "DrakonidCount", CT_RABoss_Mods["Nefarian"]["KillSync"], CT_RABoss_Mods["Nefarian"]["announce"], 42, CT_RABOSS_NEFARIAN_MOBNAME, CT_RABOSS_NEFARIAN_KCOUNT, CT_RABOSS_NEFARIAN_KCOUNT_HEADER);
		CT_RABoss_Counter.setOptions("Nefarian", "DrakonidCount", {["displayEstEnd"] = CT_RABoss_Mods["Nefarian"]["KillTime"]});

		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_BEGIN, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(2);
	
	elseif ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" and CT_RABoss_Mods["Nefarian"]["KillCount"] ) then
		local _, _, mobName = string.find(arg1, CT_RABOSS_NEFARIAN_DRAGONDEATH);
		
		if ( mobName ) then
			CT_RABoss_Counter.sendSync(mobName, "Nefarian", "DrakonidCount");
		end
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_SHAMAN_CALL) and (CT_RABoss_Mods["Nefarian"]["PreClassAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_SHAMAN_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
		--adevent next class in 27
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 27, "CLASS27SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianClassCall", 32, CT_RABOSS_NEFARIAN_CLASS_TIMER);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_DRUID_CALL) and (CT_RABoss_Mods["Nefarian"]["PreClassAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_DRUID_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
		--adevent next class in 27
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 27, "CLASS27SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianClassCall", 32, CT_RABOSS_NEFARIAN_CLASS_TIMER);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_WARLOCK_CALL) and (CT_RABoss_Mods["Nefarian"]["PreClassAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_WARLOCK_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
		--adevent next class in 27
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 27, "CLASS27SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianClassCall", 32, CT_RABOSS_NEFARIAN_CLASS_TIMER);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_PRIEST_CALL) and (CT_RABoss_Mods["Nefarian"]["PreClassAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_PRIEST_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
		--adevent next class in 27
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 27, "CLASS27SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianClassCall", 32, CT_RABOSS_NEFARIAN_CLASS_TIMER);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_HUNTER_CALL) and (CT_RABoss_Mods["Nefarian"]["PreClassAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_HUNTER_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
		--adevent next class in 27
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 27, "CLASS27SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianClassCall", 32, CT_RABOSS_NEFARIAN_CLASS_TIMER);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_WARRIOR_CALL) and (CT_RABoss_Mods["Nefarian"]["PreClassAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_WARRIOR_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
		--adevent next class in 27
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 27, "CLASS27SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianClassCall", 32, CT_RABOSS_NEFARIAN_CLASS_TIMER);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_ROGUE_CALL) and (CT_RABoss_Mods["Nefarian"]["PreClassAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_ROGUE_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
		--adevent next class in 27
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 27, "CLASS27SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianClassCall", 32, CT_RABOSS_NEFARIAN_CLASS_TIMER);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_PALADIN_CALL) and (CT_RABoss_Mods["Nefarian"]["PreClassAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_PALADIN_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
		--adevent next class in 27
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 27, "CLASS27SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianClassCall", 32, CT_RABOSS_NEFARIAN_CLASS_TIMER);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_MAGE_CALL) and (CT_RABoss_Mods["Nefarian"]["PreClassAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_MAGE_ALERT, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
		--adevent next class in 27
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 27, "CLASS27SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianClassCall", 32, CT_RABOSS_NEFARIAN_CLASS_TIMER);

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and string.find(arg1, CT_RABOSS_NEFARIAN_SHADOWFLAME_DETECT) and (CT_RABoss_Mods["Nefarian"]["shadowflame"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_SHADOWFLAME_WARN, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(3);
		--adevent next shad in 8
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 8, "SHAD8SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianShadowflame", 13, CT_RABOSS_NEFARIAN_SHADOWFLAME_TIMER);

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") and string.find(arg1, CT_RABOSS_NEFARIAN_FEAR_DETECT) and (CT_RABoss_Mods["Nefarian"]["fearAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_FEAR_WARN, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(3);
		--adevent next fear in 23
		CT_RABoss_Schedule("CT_RABoss_Nefarian_EventHandler", 23, "FEAR23SEC");
		CT_RABoss_VisualTimer.addTimer("NefarianFear", 28, CT_RABOSS_NEFARIAN_FEAR_TIMER);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_LAND_10SEC_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_LAND_10SEC, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_LANDING_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_LANDING, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_NEFARIAN_ZERG_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_ZERG, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(1);
		
	elseif ( (event == "CLASS27SEC") and (CT_RABoss_Mods["Nefarian"]["PreClassAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_PRECLASS_WARN, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(3);
		
	elseif ( (event == "FEAR23SEC") and (CT_RABoss_Mods["Nefarian"]["PrefearAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_PREFEAR_WARN, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(3);
		
	elseif ( (event == "SHAD8SEC") and (CT_RABoss_Mods["Nefarian"]["PreShadAlert"]) ) then
		CT_RABoss_Announce(CT_RABOSS_NEFARIAN_PRESHAD_WARN, CT_RABoss_Mods["Nefarian"]["announce"]);
		CT_RABoss_PlaySound(3);
		
	elseif ( CT_RABoss_Mods["Nefarian"]["veilOfShadow"] ) and ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_NEFARIAN_AFFLICT_VEIL);
		if ( sPlayer ) then
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				CT_RABoss_Announce("*** " .. UnitName("player") .. CT_RABOSS_NEFARIAN_CURSEWARNRAID, CT_RABoss_Mods["Nefarian"]["announce"]);
				CT_RABoss_PlaySound(2);
			else 
				CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_NEFARIAN_CURSEWARNRAID, CT_RABoss_Mods["Nefarian"]["announce"]);
				CT_RABoss_PlaySound(3);
			end
		end
	elseif ( event == "CHAT_MSG_ADDON" and CT_RABoss_Mods["Nefarian"]["KillCount"] and arg1 == "CTRA" and arg3 == "RAID" ) then
		CT_RABoss_Counter.receiveSync(arg2, arg4, "Nefarian", "DrakonidCount");
	end
end