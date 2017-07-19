tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Rajaxx_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Moam_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Buru_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ayamiss_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ossirian_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Guardian_OnLoad");



-- General Rajaxx
function CT_RABoss_Rajaxx_OnLoad()
	CT_RABoss_AddMod("Rajaxx", CT_RABOSS_RAJAXX_INFO, 1, CT_RABOSS_LOCATIONS_RUINSOFAHNQIRAJ );
	
	CT_RABoss_AddEvent("Rajaxx", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Rajaxx_EventHandler);
	
	CT_RABoss_AddDropDownButton("Rajaxx", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Rajaxx_EventHandler(event)
	if ( not CT_RABoss_Mods["Rajaxx"] or not CT_RABoss_Mods["Rajaxx"]["status"] or not CT_RABoss_Mods["Rajaxx"].enabled ) then
		return;
	end
	
	if ( arg2 == CT_RABOSS_RAJAXX_LIEUTENANT or arg2 == CT_RABOSS_NAMES["Rajaxx"] ) then
		if ( string.find(arg1, CT_RABOSS_RAJAXX_WAVE_DETECT1) ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_WAVE_ALERT, 1), CT_RABoss_Mods["Rajaxx"]["announce"]);
			
		elseif ( string.find(arg1, CT_RABOSS_RAJAXX_WAVE_DETECT3) ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_WAVE_ALERT, 3), CT_RABoss_Mods["Rajaxx"]["announce"]);
			
		elseif ( string.find(arg1, CT_RABOSS_RAJAXX_WAVE_DETECT4) ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_WAVE_ALERT, 4), CT_RABoss_Mods["Rajaxx"]["announce"]);
			
		elseif ( string.find(arg1, CT_RABOSS_RAJAXX_WAVE_DETECT5) ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_WAVE_ALERT, 5), CT_RABoss_Mods["Rajaxx"]["announce"]);
			
		elseif ( string.find(arg1, CT_RABOSS_RAJAXX_WAVE_DETECT6) ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_WAVE_ALERT, 6), CT_RABoss_Mods["Rajaxx"]["announce"]);
			
		elseif ( string.find(arg1, CT_RABOSS_RAJAXX_WAVE_DETECT7) ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_WAVE_ALERT, 7), CT_RABoss_Mods["Rajaxx"]["announce"]);
			
		elseif ( string.find(arg1, CT_RABOSS_RAJAXX_WAVE_DETECT8) ) then
			CT_RABoss_Announce(CT_RABOSS_RAJAXX_FINALWAVE_ALERT, CT_RABoss_Mods["Rajaxx"]["announce"]);
			
		end
	end
	
	if ( arg2 == CT_RABOSS_RAJAXX_TUUBID ) then
		local _, _, playerName = string.find(arg1, CT_RABOSS_RAJAXX_KILL_DETECT);

		if ( playerName ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_RAJAXX_KILL_ALERT, playerName), CT_RABoss_Mods["Rajaxx"]["announce"]);
			CT_RABoss_PlaySound(3);
		end
	end
end


-- Moam
function CT_RABoss_Moam_OnLoad()
	CT_RABoss_AddMod("Moam", CT_RABOSS_MOAM_INFO, 1, CT_RABOSS_LOCATIONS_RUINSOFAHNQIRAJ);

	CT_RABoss_AddEvent("Moam", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Moam_EventHandler);
	CT_RABoss_AddEvent("Moam", "CHAT_MSG_SPELL_AURA_GONE_OTHER", CT_RABoss_Moam_EventHandler);

	CT_RABoss_AddDropDownButton("Moam", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Moam", { CT_RABOSS_MOAM_TIMER, CT_RABOSS_MOAM_TIMER_INFO }, "CT_RABoss_ModInfo", "timerStone", "CT_RABoss_SetInfo");
end

function CT_RABoss_Moam_EventHandler(event)
	if ( not CT_RABoss_Mods["Moam"] or not CT_RABoss_Mods["Moam"]["status"] or not CT_RABoss_Mods["Moam"].enabled ) then
		return;
	end

	-- Stone event pre-alerts
	if ( event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1, CT_RABOSS_MOAM_BEGIN) and arg2 == CT_RABOSS_NAMES["Moam"] and CT_RABoss_Mods["Moam"]["timerStone"] ) then
        CT_RABoss_Announce(format(CT_RABOSS_MOAM_STONE_PREALERT, "90"), CT_RABoss_Mods["Moam"]["announce"]);
	    CT_RABoss_PlaySound(3);
	    CT_RABoss_Schedule("CT_RABoss_Moam_EventHandler", 30, "priorWarning");
	    CT_RABoss_VisualTimer.addTimer("MoamTrans", 90, CT_RABOSS_MOAM_TRANS_TIMER);

	elseif ( event == "priorWarning" and CT_RABoss_Mods["Moam"]["timerStone"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_MOAM_STONE_PREALERT, "60"), CT_RABoss_Mods["Moam"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Schedule("CT_RABoss_Moam_EventHandler", 20, "priorWarning2");

	elseif ( event == "priorWarning2" and CT_RABoss_Mods["Moam"]["timerStone"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_MOAM_STONE_PREALERT, "40"), CT_RABoss_Mods["Moam"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Schedule("CT_RABoss_Moam_EventHandler", 30, "priorWarning3");

	elseif ( event == "priorWarning3" and CT_RABoss_Mods["Moam"]["timerStone"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_MOAM_STONE_PREALERT, "10"), CT_RABoss_Mods["Moam"]["announce"]);
		CT_RABoss_PlaySound(3);
	end

	-- Stone alert
	if ( event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1, CT_RABOSS_MOAM_STONE_DETECT) and arg2 == CT_RABOSS_NAMES["Moam"] and CT_RABoss_Mods["Moam"]["timerStone"] ) then
		CT_RABoss_Mods["Moam"]["transWarn"] = false;
		CT_RABoss_Announce(CT_RABOSS_MOAM_STONE_ALERT, CT_RABoss_Mods["Moam"]["announce"]);
		CT_RABoss_PlaySound(3);
		--CT_RABoss_UnSchedule("CT_RABoss_Moam_EventHandler");
		CT_RABoss_Schedule("CT_RABoss_Moam_EventHandler", 30, "priorWarning4");
		CT_RABoss_VisualTimer.addTimer("MoamStone", 90, CT_RABOSS_MOAM_STONE_TIMER);

	elseif ( event == "priorWarning4" and not CT_RABoss_Mods["Moam"]["transWarn"] and CT_RABoss_Mods["Moam"]["timerStone"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_MOAM_TRANS_PREALERT, "60"), CT_RABoss_Mods["Moam"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Schedule("CT_RABoss_Moam_EventHandler", 20, "priorWarning5");

	elseif ( event == "priorWarning5" and not CT_RABoss_Mods["Moam"]["transWarn"] and CT_RABoss_Mods["Moam"]["timerStone"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_MOAM_TRANS_PREALERT, "40"), CT_RABoss_Mods["Moam"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Schedule("CT_RABoss_Moam_EventHandler", 30, "priorWarning6");

	elseif ( event == "priorWarning6" and not CT_RABoss_Mods["Moam"]["transWarn"] and CT_RABoss_Mods["Moam"]["timerStone"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_MOAM_TRANS_PREALERT, "10"), CT_RABoss_Mods["Moam"]["announce"]);
		CT_RABoss_PlaySound(3);
		
	end

	-- Retransformation alert
	if ( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and string.find(arg1, CT_RABOSS_MOAM_STONE_FADE_DETECT) and CT_RABoss_Mods["Moam"]["timerStone"] ) then
		CT_RABoss_Mods["Moam"]["transWarn"] = true;
		CT_RABoss_UnSchedule("CT_RABoss_Moam_EventHandler");
		CT_RABoss_Announce(CT_RABOSS_MOAM_TRANS_ALERT, CT_RABoss_Mods["Moam"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_VisualTimer.removeTimer("MoamTrans");
		CT_RABoss_VisualTimer.removeTimer("MoamStone");
	end
end


-- Buru
function CT_RABoss_Buru_OnLoad()
	CT_RABoss_AddMod("Buru", CT_RABOSS_BURU_INFO, 1, CT_RABOSS_LOCATIONS_RUINSOFAHNQIRAJ );
	
	CT_RABoss_AddEvent("Buru", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Buru_EventHandler);
	
	CT_RABoss_AddDropDownButton("Buru", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Buru", { CT_RABOSS_BURU_TELL_TARGET, CT_RABOSS_BURU_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
end

function CT_RABoss_Buru_EventHandler(event)
	if ( not CT_RABoss_Mods["Buru"] or not CT_RABoss_Mods["Buru"]["status"] or not CT_RABoss_Mods["Buru"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_MONSTER_EMOTE" and arg2 == CT_RABOSS_NAMES["Buru"] ) then
		local _, _, sPlayer = string.find(arg1, CT_RABOSS_BURU_EYE_DETECT);
		
		if ( sPlayer ) then
			local playerName = UnitName("player");
			CT_RABoss_Announce(string.format(CT_RABOSS_BURU_EYE_ALERT, sPlayer), CT_RABoss_Mods["Buru"]["announce"]);
			
			if ( sPlayer ~= playerName and CT_RABoss_Mods["Buru"]["sendTell"] ) then
				SendChatMessage(CT_RABOSS_BURU_EYE_ALERT_YOU, "WHISPER", nil, sPlayer);
			end
				
			CT_RABoss_PlaySound(2);
		end
	end
end


-- Ayamiss the Hunter
function CT_RABoss_Ayamiss_OnLoad()
	CT_RABoss_AddMod("Ayamiss", CT_RABOSS_AYAMISS_INFO, 1, CT_RABOSS_LOCATIONS_RUINSOFAHNQIRAJ );
	
	CT_RABoss_AddEvent("Ayamiss", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Ayamiss_EventHandler);
	CT_RABoss_AddEvent("Ayamiss", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Ayamiss_EventHandler);
	CT_RABoss_AddEvent("Ayamiss", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Ayamiss_EventHandler);
	
	CT_RABoss_AddDropDownButton("Ayamiss", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Ayamiss_EventHandler(event)
	if ( not CT_RABoss_Mods["Ayamiss"] or not CT_RABoss_Mods["Ayamiss"]["status"] or not CT_RABoss_Mods["Ayamiss"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		local _, _, sPlayer = string.find(arg1, CT_RABOSS_AYAMISS_SACRIFICE_DETECT);
		
		if ( sPlayer ) then
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				sPlayer = UnitName("player");
				
			end
			
			CT_RABoss_PlaySound(1);
			CT_RABoss_Announce(format(CT_RABOSS_AYAMISS_SACRIFICE_ALERT, sPlayer), CT_RABoss_Mods["Ayamiss"]["announce"]);
		end
	end
end


-- Ossirian the Unscarred
function CT_RABoss_Ossirian_OnLoad()
	CT_RABoss_AddMod("Ossirian", CT_RABOSS_OSSIRIAN_INFO, 1, CT_RABOSS_LOCATIONS_RUINSOFAHNQIRAJ);

	CT_RABoss_AddEvent("Ossirian", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddEvent("Ossirian", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddEvent("Ossirian", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddEvent("Ossirian", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddEvent("Ossirian", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddEvent("Ossirian", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddEvent("Ossirian", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddEvent("Ossirian", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Ossirian_EventHandler);
	CT_RABoss_AddEvent("Ossirian", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Ossirian_EventHandler);

	CT_RABoss_AddDropDownButton("Ossirian", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Ossirian", { CT_RABOSS_OSSIRIAN_DOOM, CT_RABOSS_OSSIRIAN_DOOM_INFO }, "CT_RABoss_ModInfo", "doom", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Ossirian", { CT_RABOSS_OSSIRIAN_SENSI, CT_RABOSS_OSSIRIAN_SENSI_INFO }, "CT_RABoss_ModInfo", "sensi", "CT_RABoss_SetInfo");
end

function CT_RABoss_Ossirian_EventHandler(event)
	if ( not CT_RABoss_Mods["Ossirian"] or not CT_RABoss_Mods["Ossirian"]["status"] or not CT_RABoss_Mods["Ossirian"].enabled ) then
		return;
	end

	-- Language doom alerts
	if ( (string.find(arg1, CT_RABOSS_OSSIRIAN_DOOM_DETECT)) and not CT_RABoss_Mods["Ossirian"]["doomTrip"] and CT_RABoss_Mods["Ossirian"]["doom"] ) then
		CT_RABoss_Mods["Ossirian"]["doomTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_OSSIRIAN_DOOM_ALERT, CT_RABoss_Mods["Ossirian"]["announce"]);
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Ossirian_EventHandler", 18, "preDoomWarning");
		CT_RABoss_VisualTimer.addTimer("OssirianDoom", 23, CT_RABOSS_OSSIRIAN_DOOM_TIMER);
		
	elseif ( event == "preDoomWarning" ) then
		CT_RABoss_Mods["Ossirian"]["doomTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_OSSIRIAN_DOOM_PREALERT, CT_RABoss_Mods["Ossirian"]["announce"]);
		CT_RABoss_PlaySound(3);
	end

	-- Sensibility alert
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" and CT_RABoss_Mods["Ossirian"]["sensi"] ) then
		local iStart, iEnd, sType = string.find(arg1, CT_RABOSS_OSSIRIAN_SENSI_DETECT);
		
		if ( sType ) then
			CT_RABoss_Announce(format(CT_RABOSS_OSSIRIAN_SENSI_ALERT, sType), CT_RABoss_Mods["Ossirian"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_UnSchedule("CT_RABoss_Ossirian_EventHandler", "preSupremeWarning");
			CT_RABoss_UnSchedule("CT_RABoss_Ossirian_EventHandler", "preSupremeWarning2");
			CT_RABoss_Schedule("CT_RABoss_Ossirian_EventHandler", 25, "preSupremeWarning");
			CT_RABoss_VisualTimer.addTimer("OssirianSensi", 45, CT_RABOSS_OSSIRIAN_SENSI_TIMER);
		end
	elseif ( event == "preSupremeWarning" and CT_RABoss_Mods["Ossirian"]["sensi"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_OSSIRIAN_FADE_ALERT, 20), CT_RABoss_Mods["Ossirian"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_Ossirian_EventHandler", 10, "preSupremeWarning2");

	elseif ( event == "preSupremeWarning2" and CT_RABoss_Mods["Ossirian"]["sensi"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_OSSIRIAN_FADE_ALERT, 10), CT_RABoss_Mods["Ossirian"]["announce"]);
	end

	-- Strength Buff Alert
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and string.find(arg1, CT_RABOSS_OSSIRIAN_BUFF_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_OSSIRIAN_BUFF_ALERT, CT_RABoss_Mods["Ossirian"]["announce"]);
		CT_RABoss_PlaySound(1);
		CT_RABoss_UnSchedule("CT_RABoss_Ossirian_EventHandler", "preSupremeWarning");
		CT_RABoss_UnSchedule("CT_RABoss_Ossirian_EventHandler", "preSupremeWarning2");
		CT_RABoss_VisualTimer.removeTimer("OssirianSensi");
	end
	
	-- Ossirian Death
	if ( event == "CHAT_MSG_MONSTER_YELL" and arg1 == CT_RABOSS_OSSIRIAN_DEATH_DETECT and arg2 == CT_RABOSS_NAMES["Ossirian"] ) then
		CT_RABoss_UnSchedule("CT_RABoss_Ossirian_EventHandler");
		CT_RABoss_VisualTimer.removeTimer("OssirianDoom");
		CT_RABoss_VisualTimer.removeTimer("OssirianSensi");
	end
end


-- Anubisath Guardian
function CT_RABoss_Guardian_OnLoad()
	CT_RABoss_AddMod("Anubisath Guardian", CT_RABOSS_GUARDIAN_INFO, 1, CT_RABOSS_LOCATIONS_RUINSOFAHNQIRAJ);
	
	CT_RABoss_AddEvent("Anubisath Guardian", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardian", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardian", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardian", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardian", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardian", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardian", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Guardian_EventHandler);
	CT_RABoss_AddEvent("Anubisath Guardian", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Guardian_EventHandler);
	
	CT_RABoss_AddDropDownButton("Anubisath Guardian", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Anubisath Guardian", { CT_RABOSS_GUARDIAN_ABILITIES, CT_RABOSS_GUARDIAN_ABILITIES_INFO }, "CT_RABoss_ModInfo", "abilities", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Anubisath Guardian", { CT_RABOSS_GUARDIAN_SUMMON, CT_RABOSS_GUARDIAN_SUMMON_INFO }, "CT_RABoss_ModInfo", "notifySummon", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Anubisath Guardian", { CT_RABOSS_GUARDIAN_PLAGUETELL, CT_RABOSS_GUARDIAN_PLAGUETELL_INFO }, "CT_RABoss_ModInfo", "sendPlagueTells", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Anubisath Guardian", "sendPlagueTells", 0);
end


function CT_RABoss_Guardian_EventHandler(event)
	if ( not CT_RABoss_Mods["Anubisath Guardian"] or not CT_RABoss_Mods["Anubisath Guardian"]["status"] or not CT_RABoss_Mods["Anubisath Guardian"].enabled ) then
		return;
	end
	
	-- Ability alerts
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and CT_RABoss_Mods["Anubisath Guardian"]["abilities"] ) then
		-- Explode
		if ( string.find(arg1, CT_RABOSS_GUARDIAN_EXPLODE_DETECT) ) then
			CT_RABoss_Announce(CT_RABOSS_GUARDIAN_EXPLODE_ALERT, CT_RABoss_Mods["Anubisath Guardian"]["announce"]);
			
		-- Enrage
		elseif ( string.find(arg1, CT_RABOSS_GUARDIAN_ENRAGE_DETECT) ) then
			CT_RABoss_Announce(CT_RABOSS_GUARDIAN_ENRAGE_ALERT, CT_RABoss_Mods["Anubisath Guardian"]["announce"]);
		end
	
	-- Summonning alerts
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" and CT_RABoss_Mods["Anubisath Guardian"]["notifySummon"] ) then
		-- Summonning Anubisath Swarmguard alert
		if ( string.find(arg1, CT_RABOSS_GUARDIAN_GUARD_DETECT) ) then
			CT_RABoss_Announce(CT_RABOSS_GUARDIAN_GUARD_ALERT, CT_RABoss_Mods["Anubisath Guardian"]["announce"]);
			
		-- Summon Anubisath Warrior alert
		elseif ( string.find(arg1, CT_RABOSS_GUARDIAN_WARRIOR_DETECT) ) then
			CT_RABoss_Announce(CT_RABOSS_GUARDIAN_WARRIOR_ALERT, CT_RABoss_Mods["Anubisath Guardian"]["announce"]);
		end
	
	-- Plague alerts
	elseif ( (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") and CT_RABoss_Mods["Anubisath Guardian"]["sendPlagueTells"] ) then
		local _, _, playerName = string.find(arg1, CT_RABOSS_GUARDIAN_PLAGUE_DETECT);
		
		if ( playerName ) then
			if ( playerName == CT_RABOSS_SELF1 ) then
				playerName = UnitName("player");
				CT_RABoss_Announce(string.format(CT_RABOSS_GUARDIAN_PLAGUE_ALERT, CT_RABOSS_GUARDIAN_YOUHAVE));
				CT_RABoss_Announce(string.format(CT_RABOSS_GUARDIAN_PLAGUE_ALERT, CT_RABOSS_GUARDIAN_YOUHAVE));
				CT_RABoss_PlaySound(2);
				
			else
				SendChatMessage(CT_RABOSS_GUARDIAN_PLAGUE_TELL, "WHISPER", nil, playerName);
				CT_RABoss_PlaySound(1);
			end
			
			if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Anubisath Guardian"]["announce"] ) then
				SendChatMessage(string.format(CT_RABOSS_GUARDIAN_PLAGUE_ALERT, playerName .. CT_RABOSS_GUARDIAN_HAS), "RAID_WARNING");
			end
		end
	end
end
