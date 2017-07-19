tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Jeklik_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Venoxis_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Marli_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_BloodlordMandokir_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Jindo_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Arlokk_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Hakkar_OnLoad");



-- Jeklik
function CT_RABoss_Jeklik_OnLoad()
	CT_RABoss_AddMod("Jeklik", CT_RABOSS_JEKLIK_INFO, 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	
	CT_RABoss_AddEvent("Jeklik", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Jeklik_EventHandler);
	CT_RABoss_AddEvent("Jeklik", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Jeklik_EventHandler);
	
	CT_RABoss_AddDropDownButton("Jeklik", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Jeklik_EventHandler(event)
	if ( not CT_RABoss_Mods["Jeklik"] or not CT_RABoss_Mods["Jeklik"]["status"] or not CT_RABoss_Mods["Jeklik"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_JEKLIK_BAT_TRIG) ) then
		CT_RABoss_Announce(CT_RABOSS_JEKLIK_BAT_WARN, CT_RABoss_Mods["Jeklik"]["announce"]);
		CT_RABoss_PlaySound(2);
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg1, CT_RABOSS_JEKLIK_HEAL_TRIG) ) then
		CT_RABoss_Announce(CT_RABOSS_JEKLIK_HEAL_WARN, CT_RABoss_Mods["Jeklik"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end


-- Venoxis
function CT_RABoss_Venoxis_OnLoad()
	CT_RABoss_AddMod("Venoxis", CT_RABOSS_VENOXIS_INFO, 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	
	CT_RABoss_AddEvent("Venoxis", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Venoxis_EventHandler);
	
	CT_RABoss_AddDropDownButton("Venoxis", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Venoxis_EventHandler(event)
	if ( not CT_RABoss_Mods["Venoxis"] or not CT_RABoss_Mods["Venoxis"]["status"] or not CT_RABoss_Mods["Venoxis"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and string.find(arg1, CT_RABOSS_VENOXIS_TRIG) ) then
		CT_RABoss_Announce(CT_RABOSS_VENOXIS_WARN, CT_RABoss_Mods["Venoxis"]["announce"]);
		CT_RABoss_PlaySound(2);
	end
end


-- Mar'li
function CT_RABoss_Marli_OnLoad()
	CT_RABoss_AddMod("Mar'li", CT_RABOSS_MARLI_INFO, 1, CT_RABOSS_LOCATIONS_ZULGURUB);

	CT_RABoss_AddEvent("Mar'li", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Marli_EventHandler);

	CT_RABoss_AddDropDownButton("Mar'li", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Marli_EventHandler(event)
	if ( not CT_RABoss_Mods["Mar'li"] or not CT_RABoss_Mods["Mar'li"]["status"] or not CT_RABoss_Mods["Mar'li"].enabled ) then
		return;
	end

	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_MARLI_CHILDS_TRIG) ) then
		CT_RABoss_Announce( CT_RABOSS_MARLI_CHILDS_WARN, CT_RABoss_Mods["Mar'li"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_MARLI_SPIDER_TRIG) and not CT_RABoss_Mods["Mar'li"]["TransTroll"] ) then
		CT_RABoss_Mods["Mar'li"]["TransTroll"] = true;
		CT_RABoss_Announce( CT_RABOSS_MARLI_SPIDER_WARN, CT_RABoss_Mods["Mar'li"]["announce"]);
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Marli_EventHandler", 58, "PreTransTrollWarning");
		CT_RABoss_VisualTimer.addTimer("MarliTrans", 63, CT_RABOSS_MARLI_SPIDER_TIMER);

	elseif ( event == "PreTransTrollWarning" ) then
		CT_RABoss_Mods["Mar'li"]["TransTroll"] = false;
		CT_RABoss_Announce(CT_RABOSS_MARLI_5SECWARN, CT_RABoss_Mods["Mar'li"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end


-- Bloodlord Mandokir
function CT_RABoss_BloodlordMandokir_OnLoad()
	CT_RABoss_AddMod("Bloodlord Mandokir", CT_RABOSS_MANDOKIR_INFO, 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	CT_RABoss_AddEvent("Bloodlord Mandokir", "CHAT_MSG_MONSTER_YELL", CT_RABoss_BloodlordMandokir_EventHandler);
	
	CT_RABoss_AddDropDownButton("Bloodlord Mandokir", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Bloodlord Mandokir", { CT_RABOSS_MANDOKIR_TELL_TARGET, CT_RABOSS_MANDOKOIR_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Bloodlord Mandokir", "alertNearby", 1);
end

function CT_RABoss_BloodlordMandokir_EventHandler(event)
	if ( not CT_RABoss_Mods["Bloodlord Mandokir"] or not CT_RABoss_Mods["Bloodlord Mandokir"]["status"] or not CT_RABoss_Mods["Bloodlord Mandokir"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_MANDOKIR_REGEXP) ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_MANDOKIR_REGEXP);
		if ( sPlayer ) then
			if ( sPlayer == UnitName("player") ) then
				CT_RABoss_Announce(CT_RABOSS_MANDOKIR_WATCHWARNYOU);
				CT_RABoss_Announce(CT_RABOSS_MANDOKIR_WATCHWARNYOU);
				CT_RABoss_PlaySound(2);
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Bloodlord Mandokir"]["announce"] ) then
					SendChatMessage("*** " .. UnitName("player") .. CT_RABOSS_MANDOKIR_WATCHWARNRAID .. " ***", "RAID_WARNING");
				end
				
			else
				if ( CT_RABoss_Mods["Bloodlord Mandokir"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_MANDOKIR_WATCHWARNTELL, "WHISPER", nil, sPlayer);
				end
				CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_MANDOKIR_WATCHWARNRAID .. " ***", CT_RABoss_Mods["Bloodlord Mandokir"]["announce"]);
				CT_RABoss_PlaySound(3);
			end
		end
	end
end


-- Jin'do
function CT_RABoss_Jindo_OnLoad()
	CT_RABoss_AddMod("Jin'do", CT_RABOSS_JINDO_INFO, 1, CT_RABOSS_LOCATIONS_ZULGURUB);

	CT_RABoss_AddEvent("Jin'do", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Jindo_EventHandler);
	CT_RABoss_AddEvent("Jin'do", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Jindo_EventHandler);
	CT_RABoss_AddEvent("Jin'do", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Jindo_EventHandler);
	
	CT_RABoss_AddEvent("Jin'do", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_ProphetSkeram_EventHandler);
	CT_RABoss_AddEvent("Jin'do", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_ProphetSkeram_EventHandler);

	CT_RABoss_AddDropDownButton("Jin'do", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Jin'do", { CT_RABOSS_JINDO_ALERT_NEARBY, CT_RABOSS_JINDO_ALERT_NEARBY_INFO }, "CT_RABoss_ModInfo", "alertNearby", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Jin'do", { CT_RABOSS_JINDO_TELL_TARGET, CT_RABOSS_JINDO_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Jin'do", { CT_RABOSS_JINDO_MC, CT_RABOSS_JINDO_MC_INFO }, "CT_RABoss_ModInfo", "healing", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Jin'do", { CT_RABOSS_JINDO_SPLIT, CT_RABOSS_JINDO_SPLIT_INFO }, "CT_RABoss_ModInfo", "washtotem", "CT_RABoss_SetInfo");
end

function CT_RABoss_Jindo_EventHandler(event)
	if ( not CT_RABoss_Mods["Jin'do"] or not CT_RABoss_Mods["Jin'do"]["status"] or not CT_RABoss_Mods["Jin'do"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_JINDO_AFFLICT_CURSE);
		if ( sPlayer ) then
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Jin'do"]["announce"] ) then
					SendChatMessage("*** " .. UnitName("player") .. CT_RABOSS_JINDO_CURSEWARNRAID, "RAID_WARNING");
				end
				CT_RABoss_Announce(CT_RABOSS_JINDO_CURSEWARNYOU);
				CT_RABoss_Announce(CT_RABOSS_JINDO_CURSEWARNYOU);
				CT_RABoss_PlaySound(2);
				
			else
				if ( CT_RABoss_Mods["Jin'do"]["sendTell"] and CT_RA_Level >= 1 ) then
					SendChatMessage(CT_RABOSS_JINDO_CURSEWARNTELL, "WHISPER", nil, sPlayer);
				end
				if ( CT_RABoss_Mods["Jin'do"]["alertNearby"] ) then
					CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_JINDO_CURSEWARNRAID, CT_RABoss_Mods["Jin'do"]["announce"]);
					CT_RABoss_PlaySound(3);
				end
			end
		end
	end
		-- Arcane Explosion alert
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and arg1 == CT_RABOSS_JINDO_ARCANE_DETECT and CT_RABoss_Mods["Jin'do"]["healing"] ) then
		CT_RABoss_Announce(CT_RABOSS_JINDO_ARCANE_ALERT, CT_RABoss_Mods["金度"]["announce"]);
		CT_RABoss_PlaySound(3);
	end

	-- Split alert
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" and arg1 == CT_RABOSS_JINDO_SPLIT_DETECT and CT_RABoss_Mods["Jin'do"]["washtotem"] ) then
		CT_RABoss_Announce(CT_RABOSS_JINDO_SPLIT_ALERT, CT_RABoss_Mods["金度"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end


-- Hakkar
function CT_RABoss_Hakkar_OnLoad()
	CT_RABoss_AddMod("Hakkar", CT_RABOSS_HAKKAR_INFO, 1, CT_RABOSS_LOCATIONS_ZULGURUB);

	CT_RABoss_AddEvent("Hakkar", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Hakkar_EventHandler);
	CT_RABoss_AddEvent("Hakkar", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Hakkar_EventHandler);
	CT_RABoss_AddEvent("Hakkar", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Hakkar_EventHandler);
	CT_RABoss_AddEvent("Hakkar", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Hakkar_EventHandler);
	CT_RABoss_AddEvent("Hakkar", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", CT_RABoss_Hakkar_EventHandler);
	CT_RABoss_AddEvent("Hakkar", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", CT_RABoss_Hakkar_EventHandler);
	CT_RABoss_AddEvent("Hakkar", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Hakkar_EventHandler);

	CT_RABoss_AddDropDownButton("Hakkar", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Hakkar", { CT_RABOSS_HAKKAR_LD, CT_RABOSS_HAKKAR_LD_INFO }, "CT_RABoss_ModInfo", "lifeDrain", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Hakkar", { CT_RABOSS_HAKKAR_FRENESIE, CT_RABOSS_HAKKAR_FRENESIE_INFO }, "CT_RABoss_ModInfo", "frenzy", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Hakkar", { CT_RABOSS_HAKKAR_MC, CT_RABOSS_HAKKAR_MC_INFO }, "CT_RABoss_ModInfo", "crazy", "CT_RABoss_SetInfo");

	CT_RA_RegisterSlashCmd("/hakkarstop", CT_RABOSS_CMD_HAKKARSTOP, 30, "HAKKARSTOP", function()
		CT_RABoss_UnSchedule("CT_RABoss_Hakkar_EventHandler");
		CT_RABoss_UnSchedule("CT_RABoss_Hakkar_EventHandler");
		CT_RABoss_VisualTimer.removeTimer("HakkarEnrage");
		CT_RABoss_VisualTimer.removeTimer("HakkarPoison");
		CT_RABoss_VisualTimer.removeTimer("HakkarCrazy");
	end, "/hakkarstop");
end

function CT_RABoss_Hakkar_EventHandler(event)
	if ( not CT_RABoss_Mods["Hakkar"] or not CT_RABoss_Mods["Hakkar"]["status"] or not CT_RABoss_Mods["Hakkar"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE" and CT_RABoss_Mods["Hakkar"]["crazy"] ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_HAKKAR_AFFLICT_MC);
		if ( sPlayer ) then
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				CT_RABoss_Announce("*** " .. UnitName("player") .. CT_RABOSS_HAKKAR_MC_WARN, CT_RABoss_Mods["Hakkar"]["announce"]);
			else
				CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_HAKKAR_MC_WARN, CT_RABoss_Mods["Hakkar"]["announce"]);
			end
			CT_RABoss_PlaySound(2);
			CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 16, "preCrazyWarn");
			CT_RABoss_VisualTimer.addTimer("HakkarCrazy", 20, CT_RABOSS_HAKKAR_MC_TIMER);
		end

	elseif ( event == "preCrazyWarn" and CT_RABoss_Mods["Hakkar"]["crazy"] ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_MC_PREWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
	if  ( (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") and string.find(arg1, CT_RABOSS_HAKKAR_MC_RESIST) and CT_RABoss_Mods["Hakkar"]["crazy"] ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_MC_RESIST_WARN, CT_RABoss_Mods["Hakkar"]["announce"]) 
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 16, "preCrazyWarn");
		CT_RABoss_VisualTimer.addTimer("HakkarCrazy", 20, CT_RABOSS_HAKKAR_MC_TIMER);
	end

	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" and not CT_RABoss_Mods["Hakkar"]["priorWarning"] and CT_RABoss_Mods["Hakkar"]["lifeDrain"] ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_HAKKAR_AFFLICT_POISON);
		if ( sPlayer ) then
			CT_RABoss_Mods["Hakkar"]["priorWarning"] = true;
			CT_RABoss_Announce(CT_RABOSS_HAKKAR_LIFE_DRAIN, CT_RABoss_Mods["Hakkar"]["announce"]);
			CT_RABoss_PlaySound(3);
			CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 30, "priorWarning");
			CT_RABoss_VisualTimer.addTimer("HakkarPoison", 90, CT_RABOSS_HAKKAR_LD_TIMER);
		end
		
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_HAKKAR_YELL) and ( CT_RABoss_Mods["Hakkar"]["lifeDrain"] or CT_RABoss_Mods["Hakkar"]["frenzy"] ) ) then
		CT_RABoss_UnSchedule("CT_RABoss_Hakkar_EventHandler");
		CT_RABoss_UnSchedule("CT_RABoss_Hakkar_EventHandler");

		if ( CT_RABoss_Mods["Hakkar"]["lifeDrain"] ) then
	   		CT_RABoss_Mods["Hakkar"]["priorWarning"] = true;
	        	CT_RABoss_Announce(CT_RABOSS_HAKKAR_90SECWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		    	CT_RABoss_PlaySound(3);
		    	CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 30, "priorWarning");
			CT_RABoss_VisualTimer.addTimer("HakkarPoison", 90, CT_RABOSS_HAKKAR_LD_TIMER);
		end
		
		if ( CT_RABoss_Mods["Hakkar"]["frenzy"] ) then
			CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 120, "totalWarning");
			CT_RABoss_VisualTimer.addTimer("HakkarEnrage", 600, CT_RABOSS_HAKKAR_FRENESIE_TIMER);
		end

	elseif ( event == "priorWarning" and CT_RABoss_Mods["Hakkar"]["lifeDrain"] ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_60SECWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 20, "priorWarning2");

	elseif ( event == "priorWarning2" and CT_RABoss_Mods["Hakkar"]["lifeDrain"] ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_40SECWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 30, "priorWarning3");

	elseif ( event == "priorWarning3" and CT_RABoss_Mods["Hakkar"]["lifeDrain"] ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_10SECWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Mods["Hakkar"]["priorWarning"] = false;

	elseif ( event == "totalWarning" and CT_RABoss_Mods["Hakkar"]["frenzy"] ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_8MINWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
	    	CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 180, "totalWarning2");

	elseif ( event == "totalWarning2" and CT_RABoss_Mods["Hakkar"]["frenzy"] ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_5MINWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
	    	CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 120, "totalWarning3");

	elseif ( event == "totalWarning3" and CT_RABoss_Mods["Hakkar"]["frenzy"] ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_3MINWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
	    	CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 60, "totalWarning4");

	elseif ( event == "totalWarning4" and CT_RABoss_Mods["Hakkar"]["frenzy"] ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_2MINWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
	    	CT_RABoss_Schedule("CT_RABoss_Hakkar_EventHandler", 60, "totalWarning5");

	elseif ( event == "totalWarning5" and CT_RABoss_Mods["Hakkar"]["frenzy"] ) then
		CT_RABoss_Announce(CT_RABOSS_HAKKAR_1MINWARN, CT_RABoss_Mods["Hakkar"]["announce"]);
		CT_RABoss_PlaySound(3);
    end
end


-- Arlokk
function CT_RABoss_Arlokk_OnLoad()
	CT_RABoss_AddMod("Arlokk", CT_RABOSS_ARLOKK_INFO, 1, CT_RABOSS_LOCATIONS_ZULGURUB);
	CT_RABoss_AddEvent("Arlokk", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Arlokk_EventHandler);

	CT_RABoss_AddDropDownButton("Arlokk", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Arlokk", { CT_RABOSS_ARLOKK_TELL_TARGET, CT_RABOSS_ARLOKK_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Arlokk", "alertNearby", 1);
end

function CT_RABoss_Arlokk_EventHandler(event)
	if ( not CT_RABoss_Mods["Arlokk"] or not CT_RABoss_Mods["Arlokk"]["status"] or not CT_RABoss_Mods["Arlokk"].enabled ) then
		return;
	end
	
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_ARLOKK_REGEXP) ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_ARLOKK_REGEXP);
		if ( sPlayer ) then
			if ( sPlayer == UnitName("player") ) then
				CT_RABoss_Announce(CT_RABOSS_ARLOKK_WATCHWARNYOU);
				CT_RABoss_Announce(CT_RABOSS_ARLOKK_WATCHWARNYOU);
				CT_RABoss_PlaySound(2);
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Arlokk"]["announce"] ) then
					SendChatMessage("*** " .. UnitName("player") .. CT_RABOSS_ARLOKK_WATCHWARNRAID .. " ***", "RAID_WARNING");
				end
				
			else
				if ( CT_RABoss_Mods["Arlokk"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_ARLOKK_WATCHWARNTELL, "WHISPER", nil, sPlayer);
				end
				CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_ARLOKK_WATCHWARNRAID .. " ***", CT_RABoss_Mods["Arlokk"]["announce"]);
				CT_RABoss_PlaySound(3);
			end
		end

	end
end
