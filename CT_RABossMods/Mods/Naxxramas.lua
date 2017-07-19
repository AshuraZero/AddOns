tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Trash_OnLoad");
	-- Spider Wing
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_AnubRekhan_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Faerlina_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Maexxna_OnLoad");
	-- Necro Wing
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Noth_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Heigan_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Loatheb_OnLoad");
	-- Deathknight Wing
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Razuvious_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Gothik_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_FourHorsemen_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Sapphiron_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Kelthuzad_OnLoad");
	-- Abomination Wing
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Patchwerk_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Grobbulus_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Gluth_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Thaddius_OnLoad");


function CT_RABoss_Trash_OnLoad()
	CT_RABoss_AddMod("Trash", CT_RABOSS_TRASH_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Trash", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Trash_EventHandler);
	CT_RABoss_AddEvent("Trash", "CHAT_MSG_CHANNEL", CT_RABoss_Trash_EventHandler);
	CT_RABoss_AddEvent("Trash", "PLAYER_REGEN_DISABLED", CT_RABoss_Trash_EventHandler);
	CT_RABoss_AddEvent("Trash", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Trash_EventHandler);
	CT_RABoss_AddEvent("Trash", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Trash_EventHandler);
	CT_RABoss_AddEvent("Trash", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Trash_EventHandler);
	CT_RABoss_AddEvent("Trash", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Trash_EventHandler);

	CT_RABoss_AddDropDownButton("Trash", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Trash", { CT_RABOSS_TRASH_PC_ALERT, CT_RABOSS_TRASH_PC_ALERT_INFO }, "CT_RABoss_ModInfo", "enablepc", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Trash", "enablepc", 1);
end

function CT_RABoss_Trash_EventHandler(event)
	if ( not CT_RABoss_Mods["Trash"] or not CT_RABoss_Mods["Trash"]["status"] or not CT_RABoss_Mods["Trash"].enabled ) then
		return;
	end		
	
	if ( event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg2, CT_RABOSS_TRASH_INFECTIOUSN) ) then
		if ( string.find(arg1, CT_RABOSS_TRASH_INFECTIOUS) ) then
			CT_RABoss_Announce(CT_RABOSS_TRASH_INFECTRAGE, CT_RABoss_Mods["Trash"]["announce"]);
			CT_RABoss_PlaySound(2);
		end
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and string.find(arg2, CT_RABOSS_TRASH_PLAGUEDN) ) then
		if ( string.find(arg1, CT_RABOSS_TRASH_PLAGUED) ) then
			CT_RABoss_Announce(CT_RABOSS_TRASH_PLAGUEDRAGE, CT_RABoss_Mods["Trash"]["announce"]);
			CT_RABoss_PlaySound(2);
		end
	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		if ( string.find(arg1, CT_RABOSS_TRASH_GARGOYLE) ) then
			CT_RABoss_Announce(CT_RABOSS_TRASH_GARGOYLEBURN, CT_RABoss_Mods["Trash"]["announce"]);
			CT_RABoss_PlaySound(2);
		end
		
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
		if ( string.find(arg1, CT_RABOSS_TRASH_DKCAPT) ) then
			CT_RABoss_Announce(CT_RABOSS_TRASH_DKCAPTWARN, CT_RABoss_Mods["Trash"]["announce"]);
			CT_RABoss_PlaySound(2);
		end
		
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		if ( string.find(arg1, CT_RABOSS_TRASH_NECROSTALKER) ) then
			if ( CT_RABoss_Mods["Trash"]["enablepc"] and not CT_RABoss_Mods["Trash"]["poisontrip"] ) then
				CT_RABoss_Mods["Trash"]["poisontrip"] = true;
				CT_RABoss_Announce(CT_RABOSS_TRASH_NECROSTALKERWARN, CT_RABoss_Mods["Trash"]["announce"]);
				CT_RABoss_PlaySound(2);
				CT_RABoss_Schedule("CT_RABoss_Trash_EventHandler", 4, "poisonreset");
				CT_RABoss_Mods["Trash"]["lastaction"] = time();
			end
		end
	elseif ( event == "poisonreset" ) then
		CT_RABoss_Mods["Trash"]["poisontrip"] = false;
	end
	
end

-- Anub'Rekhan
function CT_RABoss_AnubRekhan_End()
	CT_RABoss_UnSchedule("CT_RABoss_AnubRekhan_EventHandler");
	CT_RABoss_UnSchedule("CT_RABoss_AnubRekhan_EventHandler");
	CT_RABoss_UnSchedule("CT_RABoss_AnubRekhan_EventHandler");

	CT_RABoss_Mods["AnubRekhan"]["fight"] = nil;
	CT_RABoss_Mods["AnubRekhan"]["lastAction"] = nil;

	CT_RABoss_VisualTimer.removeTimer("AnubLocustSwarm");
end

function CT_RABoss_AnubRekhan_OnLoad()
	CT_RABoss_AddMod("AnubRekhan", CT_RABOSS_ANUBREKHAN_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	
	CT_RABoss_AddEvent("AnubRekhan", "CHAT_MSG_COMBAT_FRIENDLY_DEATH", CT_RABoss_AnubRekhan_EventHandler);
	CT_RABoss_AddEvent("AnubRekhan", "CHAT_MSG_COMBAT_HOSTILE_DEATH", CT_RABoss_AnubRekhan_EventHandler);
	CT_RABoss_AddEvent("AnubRekhan", "CHAT_MSG_MONSTER_YELL", CT_RABoss_AnubRekhan_EventHandler);
	CT_RABoss_AddEvent("AnubRekhan", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_AnubRekhan_EventHandler);
	CT_RABoss_AddEvent("AnubRekhan", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_AnubRekhan_EventHandler);
	CT_RABoss_AddEvent("AnubRekhan", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_AnubRekhan_EventHandler);
 
	CT_RABoss_AddDropDownButton("AnubRekhan", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("AnubRekhan", { CT_RABOSS_ANUBREKHAN_DEATH, CT_RABOSS_ANUBREKHAN_DEATH_INFO}, "CT_RABoss_ModInfo", "playerDeath", "CT_RABoss_SetInfo");

	CT_RA_RegisterSlashCmd("/anubstop", CT_RABOSS_CMD_ANUBSTOP, 30, "ANUBSTOP", function()
		CT_RABoss_AnubRekhan_End();
	end, "/anubstop");

	CT_RABoss_Mods["AnubRekhan"]["fight"] = nil;
	CT_RABoss_Mods["AnubRekhan"]["lastAction"] = nil;

end

function CT_RABoss_AnubRekhan_LocustSwarm()
	CT_RABoss_Announce(format(CT_RABOSS_ANUBREKHAN_SWARM_PREALERT, "90", "100"), CT_RABoss_Mods["AnubRekhan"]["announce"]);
	CT_RABoss_PlaySound(2);

	CT_RABoss_Mods["AnubRekhan"]["fight"] = 1;
	CT_RABoss_Mods["AnubRekhan"]["lastAction"] = GetTime();

	CT_RABoss_Schedule("CT_RABoss_AnubRekhan_EventHandler", 60, "locustSwarmPreWarn30");
	CT_RABoss_Schedule("CT_RABoss_AnubRekhan_EventHandler", 75, "locustSwarmPreWarn15");
	CT_RABoss_Schedule("CT_RABoss_AnubRekhan_EventHandler", 85, "locustSwarmPreWarn5");
end

function CT_RABoss_AnubRekhan_EventHandler(event)
	if ( not CT_RABoss_Mods["AnubRekhan"] or not CT_RABoss_Mods["AnubRekhan"]["status"] or not CT_RABoss_Mods["AnubRekhan"].enabled ) then
		return;
	end

	if ( event == "CHAT_MSG_MONSTER_YELL" and arg2 == CT_RABOSS_NAMES["AnubRekhan"] ) then
		if ( string.find(arg1, CT_RABOSS_ANUBREKHAN_YELL1_DETECT) or string.find(arg1, CT_RABOSS_ANUBREKHAN_YELL2_DETECT) or string.find(arg1, CT_RABOSS_ANUBREKHAN_YELL3_DETECT) ) then
			CT_RABoss_AnubRekhan_LocustSwarm();
		end

	elseif ( (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") and string.find(arg1, CT_RABOSS_ANUBREKHAN_SWARM_CAST_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_ANUBREKHAN_SWARM_IMMINENT_ALERT, CT_RABoss_Mods["AnubRekhan"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_VisualTimer.addTimer("AnubLocustSwarm", 23, CT_RABOSS_ANUBREKHAN_SWARMEND_TIMER);

		CT_RABoss_UnSchedule("CT_RABoss_AnubRekhan_EventHandler", "locustSwarmPreWarn30");
		CT_RABoss_UnSchedule("CT_RABoss_AnubRekhan_EventHandler", "locustSwarmPreWarn15");
		CT_RABoss_UnSchedule("CT_RABoss_AnubRekhan_EventHandler", "locustSwarmPreWarn5");
		CT_RABoss_Schedule("CT_RABoss_AnubRekhan_EventHandler", 13, "locustSwarmEndWarn10");
		CT_RABoss_Schedule("CT_RABoss_AnubRekhan_EventHandler", 20, "locustSwarmEndWarn3");

		CT_RABoss_AnubRekhan_LocustSwarm();

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and string.find(arg1, CT_RABOSS_ANUBREKHAN_SWARM_GAIN_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_ANUBREKHAN_SWARM_ALERT, CT_RABoss_Mods["AnubRekhan"]["announce"]);
		CT_RABoss_Mods["AnubRekhan"]["lastAction"] = GetTime();
		CT_RABoss_PlaySound(3);

	elseif ( event == "locustSwarmPreWarn30" ) then
		CT_RABoss_Announce(format(CT_RABOSS_ANUBREKHAN_SWARM_PREALERT, "30", "40"), CT_RABoss_Mods["AnubRekhan"]["announce"]);

	elseif ( event == "locustSwarmPreWarn15" ) then
		CT_RABoss_Announce(format(CT_RABOSS_ANUBREKHAN_SWARM_PREALERT, "15", "25"), CT_RABoss_Mods["AnubRekhan"]["announce"]);

	elseif ( event == "locustSwarmPreWarn5" ) then
		CT_RABoss_Announce(format(CT_RABOSS_ANUBREKHAN_SWARM_PREALERT, "5", "15"), CT_RABoss_Mods["AnubRekhan"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( event == "locustSwarmEndWarn10" ) then
		CT_RABoss_Announce(format(CT_RABOSS_ANUBREKHAN_SWARM_END_PREALERT, "10"), CT_RABoss_Mods["AnubRekhan"]["announce"]);

	elseif ( event == "locustSwarmEndWarn3" ) then
		CT_RABoss_Announce(format(CT_RABOSS_ANUBREKHAN_SWARM_END_PREALERT, "3"), CT_RABoss_Mods["AnubRekhan"]["announce"]);
		CT_RABoss_PlaySound(1);

	end

	if ( event == "CHAT_MSG_COMBAT_FRIENDLY_DEATH" and CT_RABoss_Mods["AnubRekhan"]["playerDeath"] and CT_RABoss_Mods["AnubRekhan"]["fight"] ) then
		if ( not CT_RABoss_Mods["AnubRekhan"]["lastAction"] or (GetTime() - CT_RABoss_Mods["AnubRekhan"]["lastAction"] > 120) ) then
			CT_RABoss_AnubRekhan_End();
			return;
		end

		local _, _, nameSelf = string.find(arg1, CT_RABOSS_ANUBREKHAN_DEATHSELF_DETECT);
		local _, _, name = string.find(arg1, CT_RABOSS_ANUBREKHAN_DEATHPLAYER_DETECT);

		if ( name ~= nil ) then
			CT_RABoss_Announce(format(CT_RABOSS_ANUBREKHAN_SCARAB_SPAWN_ALERT, name), CT_RABoss_Mods["AnubRekhan"]["announce"]);

		elseif ( nameSelf == CT_RABOSS_SELF1 ) then
			name = UnitName("player");
			CT_RABoss_Announce(format(CT_RABOSS_ANUBREKHAN_SCARAB_SPAWN_ALERT, name), CT_RABoss_Mods["AnubRekhan"]["announce"]);
		end
	end

	if ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" and string.find(arg1, CT_RABOSS_ANUBREKHAN_DEATH_DETECT) ) then
		CT_RABoss_AnubRekhan_End();
	end

end


-- Grand Widow Faerlina
function CT_RABoss_Faerlina_OnLoad()
	CT_RABoss_AddMod("Faerlina", CT_RABOSS_FAERLINA_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Faerlina", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Faerlina_EventHandler);
	CT_RABoss_AddEvent("Faerlina", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", CT_RABoss_Faerlina_EventHandler);

	CT_RABoss_AddDropDownButton("Faerlina", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Faerlina_UnSchedule()
	CT_RABoss_UnSchedule("CT_RABoss_Faerlina_EventHandler", "enrage30");
	CT_RABoss_UnSchedule("CT_RABoss_Faerlina_EventHandler", "enrage15");
	CT_RABoss_UnSchedule("CT_RABoss_Faerlina_EventHandler", "enrage5");
	CT_RABoss_UnSchedule("CT_RABoss_Faerlina_EventHandler", "enrageready");
end

function CT_RABoss_Faerlina_EventHandler(event)
	if ( not CT_RABoss_Mods["Faerlina"] or not CT_RABoss_Mods["Faerlina"]["status"] or not CT_RABoss_Mods["Faerlina"].enabled ) then
		return;
	end

	if ( CT_RABoss_Mods["Faerlina"]["engaged"] and ( not CT_RABoss_Mods["Faerlina"]["lastaction"] or ( time() - CT_RABoss_Mods["Faerlina"]["lastaction"] ) > 120 ) ) then
		CT_RABoss_Mods["Faerlina"]["engaged"] = false;
	end

	if ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( arg1 == CT_RABOSS_FAERLINA_YELL1 or arg1 == CT_RABOSS_FAERLINA_YELL2 or arg1 == CT_RABOSS_FAERLINA_YELL3 or arg1 == CT_RABOSS_FAERLINA_YELL4 ) then
			if ( not CT_RABoss_Mods["Faerlina"]["engaged"] ) then
				CT_RABoss_Announce(CT_RABOSS_FAERLINA_ENGAGE, CT_RABoss_Mods["Faerlina"]["announce"]);
				CT_RABoss_PlaySound(3);
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 30, "enrage30");
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 45, "enrage15");
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 55, "enrage5");
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 60, "enrageready");
				CT_RABoss_VisualTimer.addTimer("FaerlinaEnrage", 60, CT_RABOSS_FAERLINA_ENRAGE_TIMER);
				CT_RABoss_Mods["Faerlina"]["engaged"] = true;
				CT_RABoss_Mods["Faerlina"]["enraged"] = false;
				CT_RABoss_Mods["Faerlina"]["silenced"] = false;
			else
				CT_RABoss_Announce(CT_RABOSS_FAERLINA_ENRAGE_ALERT, CT_RABoss_Mods["Faerlina"]["announce"]);
				CT_RABoss_PlaySound(2);
				CT_RABoss_Faerlina_UnSchedule()
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 30, "enrage30");
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 45, "enrage15");
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 55, "enrage5");
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 60, "enrageready");
				CT_RABoss_VisualTimer.addTimer("FaerlinaEnrage", 60, CT_RABOSS_FAERLINA_ENRAGE_TIMER);
				CT_RABoss_Mods["Faerlina"]["enraged"] = true;
				CT_RABoss_Mods["Faerlina"]["silenced"] = false;
				CT_RABoss_Mods["Faerlina"]["enragetimer"] = time();
			end
		elseif ( arg1 == CT_RABOSS_FAERLINA_END ) then
			CT_RABoss_Mods["Faerlina"]["engaged"] = false;
			CT_RABoss_Faerlina_UnSchedule();
			CT_RABoss_VisualTimer.removeTimer("FaerlinaEnrage");
			CT_RABoss_VisualTimer.removeTimer("FaerlinaSilenced");
		end
		CT_RABoss_Mods["Faerlina"]["lastaction"] = time();

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" and string.find(arg1, CT_RABOSS_FAERLINA_WIDOWEMBRACE_DETECT) ) then
		if ( not CT_RABoss_Mods["Faerlina"]["silenced"] ) then
			CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 5, "silence");
			CT_RABoss_Mods["Faerlina"]["silenced"] = true;
			CT_RABoss_Mods["Faerlina"]["engaged"] = true;
			CT_RABoss_Mods["Faerlina"]["lastaction"] = time();
			CT_RABoss_VisualTimer.addTimer("FaerlinaSilenced", 30, CT_RABOSS_FAERLINA_SILENCE_TIMER, "orange");
			if ( CT_RABoss_Mods["Faerlina"]["enraged"] ) then
				CT_RABoss_Announce(format(CT_RABOSS_FAERLINA_ENRAGE_SILENCE_ALERT, (60-(time() - CT_RABoss_Mods["Faerlina"]["enragetimer"]))), CT_RABoss_Mods["Faerlina"]["announce"]);
				CT_RABoss_PlaySound(3);
				CT_RABoss_Mods["Faerlina"]["enraged"] = false;
			else
				CT_RABoss_Announce(CT_RABOSS_FAERLINA_SILENCE_ALERT, CT_RABoss_Mods["Faerlina"]["announce"]);
				CT_RABoss_PlaySound(3);
				CT_RABoss_Faerlina_UnSchedule()
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 15, "enrage15");
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 25, "enrage5");
				CT_RABoss_Schedule("CT_RABoss_Faerlina_EventHandler", 30, "enrageready");
			end
		end

	elseif ( event == "silence") then
		CT_RABoss_Mods["Faerlina"]["silenced"] = false;

	elseif ( event == "enrage30") then
		CT_RABoss_Announce(format(CT_RABOSS_FAERLINA_ENRAGE_PREALERT, "~30"), CT_RABoss_Mods["Faerlina"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "enrage15") then
		CT_RABoss_Announce(format(CT_RABOSS_FAERLINA_ENRAGE_PREALERT, "~15"), CT_RABoss_Mods["Faerlina"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "enrage5") then
		CT_RABoss_Announce(format(CT_RABOSS_FAERLINA_ENRAGE_PREALERT, "~5"), CT_RABoss_Mods["Faerlina"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "enrageready" ) then
		CT_RABoss_Announce(CT_RABOSS_FAERLINA_ENRAGEREADY, CT_RABoss_Mods["Faerlina"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end


-- Maexxna (29/07/2006) - Changed start script and added sync.
function CT_RABoss_Maexxna_OnLoad()
	CT_RABoss_AddMod("Maexxna", CT_RABOSS_MAEXXNA_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Maexxna", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Maexxna_EventHandler);
	CT_RABoss_AddEvent("Maexxna", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Maexxna_EventHandler);
	CT_RABoss_AddEvent("Maexxna", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Maexxna_EventHandler);
	CT_RABoss_AddEvent("Maexxna", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Maexxna_EventHandler);
	CT_RABoss_AddEvent("Maexxna", "CHAT_MSG_ADDON", CT_RABoss_Maexxna_EventHandler);
	CT_RABoss_AddEvent("Maexxna", "PLAYER_REGEN_DISABLED", CT_RABoss_Maexxna_EventHandler);

	CT_RABoss_AddDropDownButton("Maexxna", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Maexxna", { CT_RABOSS_MAEXXNA_WRAP_ALERT, CT_RABOSS_MAEXXNA_WRAP_ALERT_INFO }, "CT_RABoss_ModInfo", "wrapenable", "CT_RABoss_SetInfo");

	CT_RABoss_SetVar("Maexxna", "wrapenable", 1);
end

function CT_RABoss_Maexxna_Start()
	CT_RABoss_Announce(CT_RABOSS_MAEXXNA_ENGAGE, CT_RABoss_Mods["Maexxna"]["announce"]);
	CT_RABoss_PlaySound(3);
	CT_RABoss_Mods["Maexxna"]["lastaction"] = time();
	CT_RABoss_Mods["Maexxna"]["engaged"] = true;
	CT_RABoss_Schedule("CT_RABoss_Maexxna_EventHandler", 22, "webwarn15");
	CT_RABoss_Schedule("CT_RABoss_Maexxna_EventHandler", 32, "webwarn5");
	CT_RABoss_VisualTimer.addTimer("WebSpray", 37, CT_RABOSS_MAEXXNA_WEBSPRAY_TIMER);
	CT_RABoss_VisualTimer.addTimer("SmallSpiders", 27, CT_RABOSS_MAEXXNA_SPIDERS_TIMER, "orange");
	CT_RABoss_VisualTimer.addTimer("WebRapped", 15, CT_RABOSS_MAEXXNA_WRAPPED_TIMER);
end

function CT_RABoss_Maexxna_EventHandler(event)
	if ( not CT_RABoss_Mods["Maexxna"] or not CT_RABoss_Mods["Maexxna"]["status"] or not CT_RABoss_Mods["Maexxna"].enabled ) then
		return;
	end

	if ( CT_RABoss_Mods["Maexxna"]["engaged"] and ( not CT_RABoss_Mods["Maexxna"]["lastaction"] or ( time() - CT_RABoss_Mods["Maexxna"]["lastaction"] ) > 60 ) ) then
		CT_RABoss_Mods["Maexxna"]["engaged"] = false;
	end

	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		if ( string.find(arg1, CT_RABOSS_MAEXXNA_SPRAYSTRING) ) then
			if ( not CT_RABoss_Mods["Maexxna"]["webtrip"] ) then
				CT_RABoss_Announce(CT_RABOSS_MAEXXNA_SPRAYWARN, CT_RABoss_Mods["Maexxna"]["announce"]);
				CT_RABoss_PlaySound(2);
				CT_RABoss_Mods["Maexxna"]["lastaction"] = time();
				CT_RABoss_Mods["Maexxna"]["webtrip"] = true;
				CT_RABoss_Mods["Maexxna"]["engaged"] = true;
				CT_RABoss_UnSchedule("CT_RABoss_Maexxna_EventHandler");
				CT_RABoss_Schedule("CT_RABoss_Maexxna_EventHandler", 25, "webwarn15");
				CT_RABoss_Schedule("CT_RABoss_Maexxna_EventHandler", 35, "webwarn5");
				CT_RABoss_VisualTimer.addTimer("WebSpray", 40, CT_RABOSS_MAEXXNA_WEBSPRAY_TIMER);
				CT_RABoss_VisualTimer.addTimer("SmallSpiders", 30, CT_RABOSS_MAEXXNA_SPIDERS_TIMER, "orange");
				CT_RABoss_VisualTimer.addTimer("WebRapped", 18, CT_RABOSS_MAEXXNA_WRAPPED_TIMER);
			end
		end
		if ( CT_RABoss_Mods["Maexxna"]["wrapenable"] ) then
			local _, _, playername = string.find(arg1, CT_RABOSS_MAEXXNA_WWEXP);
			if ( playername ) then
				if ( playername == CT_RABOSS_SELF1 ) then
					playername = UnitName("player");
					CT_RABoss_Announce(CT_RABOSS_MAEXXNA_WRAPPED_YOU);
					CT_RABoss_PlaySound(2);
				else
					CT_RABoss_Announce(format(CT_RABOSS_MAEXXNA_WRAPPED, playername));
				end
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Maexxna"]["announce"] ) then
					SendChatMessage(format(CT_RABOSS_MAEXXNA_WRAPPED, playername), "RAID_WARNING");
				end
				CT_RABoss_Mods["Maexxna"]["lastaction"] = time();
			end
		end

	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and arg2 == CT_RABOSS_NAMES["Maexxna"] ) then
		if ( arg1 == CT_RABOSS_MAEXXNA_ENRAGESTRING ) then
			CT_RABoss_Announce(CT_RABOSS_MAEXXNA_ENRAGEWARN, CT_RABoss_Mods["Maexxna"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Mods["Maexxna"]["lastaction"] = time();
		end

	elseif ( event == "PLAYER_REGEN_DISABLED" and not CT_RABoss_Mods["Maexxna"]["engaged"] ) then
		CT_RABoss_Schedule("CT_RABoss_Maexxna_EventHandler", 3, "checkStart");

	elseif ( event == "checkStart" and not CT_RABoss_Mods["Maexxna"]["engaged"] ) then
		if ( UnitExists("target") and UnitName("target") == CT_RABOSS_NAMES["Maexxna"] and UnitAffectingCombat("target") ) then
			CT_RABoss_Maexxna_Start();
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("MAEXXNAENGSYNC");
			end
		end

	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA_BOSS" and arg3 == "RAID" ) then
		if ( arg2 == "MAEXXNAENGSYNC" and not CT_RABoss_Mods["Maexxna"]["engaged"] ) then
			CT_RABoss_Maexxna_Start();
		end

	elseif ( event == "webwarn15" ) then
		CT_RABoss_Announce(CT_RABOSS_MAEXXNA_SPIDERS5SEC, CT_RABoss_Mods["Maexxna"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Mods["Maexxna"]["webtrip"] = false;

	elseif ( event == "webwarn5" ) then
		CT_RABoss_Announce(CT_RABOSS_MAEXXNA_5SEC, CT_RABoss_Mods["Maexxna"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end

-- Noth The Plaguebringer (27/07/2006) - Changed most variables to prevent incompatabilities.
function CT_RABoss_Noth_OnLoad()
	CT_RABoss_AddMod("Noth", CT_RABOSS_NOTH_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Noth", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Noth_EventHandler);
	CT_RABoss_AddEvent("Noth", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Noth_EventHandler);
	CT_RABoss_AddEvent("Noth", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Noth_EventHandler);
	CT_RABoss_AddEvent("Noth", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Noth_EventHandler);
	CT_RABoss_AddEvent("Noth", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Noth_EventHandler);
	CT_RABoss_AddEvent("Noth", "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS", CT_RABoss_Noth_EventHandler);
	CT_RABoss_AddEvent("Noth", "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS", CT_RABoss_Noth_EventHandler);
	CT_RABoss_AddEvent("Noth", "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS", CT_RABoss_Noth_EventHandler);

	CT_RABoss_AddDropDownButton("Noth", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Noth", { CT_RABOSS_NOTH_CURSE_ALERT, CT_RABOSS_NOTH_CURSE_ALERT_INFO }, "CT_RABoss_ModInfo", "enablecurse", "CT_RABoss_SetInfo");
end

function CT_RABoss_Noth_EventHandler(event)
	if ( not CT_RABoss_Mods["Noth"] or not CT_RABoss_Mods["Noth"]["status"] or not CT_RABoss_Mods["Noth"].enabled ) then
		return;
	end

	if ( event == "CHAT_MSG_MONSTER_YELL"  ) then
		if ( arg1 == CT_RABOSS_NOTH_YELL1 or arg1 == CT_RABOSS_NOTH_YELL2 or arg1 == CT_RABOSS_NOTH_YELL3 ) then
			CT_RABoss_Announce(CT_RABOSS_NOTH_ENGAGED, CT_RABoss_Mods["Noth"]["announce"]);
			CT_RABoss_PlaySound(3);
			CT_RABoss_Mods["Noth"]["timeonbalcony"] = 70;
			CT_RABoss_Mods["Noth"]["timeinroom"] = 90;
			CT_RABoss_Schedule("CT_RABoss_Noth_EventHandler", CT_RABoss_Mods["Noth"]["timeinroom"] - 10, "teleportwarn");
			CT_RABoss_Schedule("CT_RABoss_Noth_EventHandler", CT_RABoss_Mods["Noth"]["timeinroom"], "teleport");
			CT_RABoss_Mods["Noth"]["lastaction"] = GetTime();
			CT_RABoss_VisualTimer.addTimer("NothInRoom", CT_RABoss_Mods["Noth"]["timeinroom"], CT_RABOSS_NOTH_INROOM_TIMER);
			CT_RABoss_Schedule("CT_RABoss_Noth_EventHandler", 32, "blinkwarn");
			CT_RABoss_VisualTimer.addTimer("NothBlink", 37, CT_RABOSS_NOTH_BLINK_TIMER, "orange");
		elseif ( arg1 == CT_RABOSS_NOTH_END ) then
			CT_RABoss_UnSchedule("CT_RABoss_Noth_EventHandler");
			CT_RABoss_VisualTimer.removeTimer("NothBlink");
			CT_RABoss_VisualTimer.removeTimer("NothInRoom");
			CT_RABoss_VisualTimer.removeTimer("NothBack");
		end

	elseif ( event == "backinroom" ) then
		if ( not CT_RABoss_Mods["Noth"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["Noth"]["lastaction"] ) > 60 ) then
			return;
		else
			CT_RABoss_Announce(format(CT_RABOSS_NOTH_BACK, CT_RABoss_Mods["Noth"]["timeinroom"]), CT_RABoss_Mods["Noth"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Schedule("CT_RABoss_Noth_EventHandler", CT_RABoss_Mods["Noth"]["timeinroom"] - 10, "teleportwarn");
			CT_RABoss_Schedule("CT_RABoss_Noth_EventHandler", CT_RABoss_Mods["Noth"]["timeinroom"], "teleport");
			CT_RABoss_VisualTimer.addTimer("NothInRoom", CT_RABoss_Mods["Noth"]["timeinroom"], CT_RABOSS_NOTH_INROOM_TIMER);
		end

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( string.find(arg1, CT_RABOSS_NOTH_BLINKSTRING) ) then
			CT_RABoss_Announce(CT_RABOSS_NOTH_BLINKWARNING, CT_RABoss_Mods["Noth"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_UnSchedule("CT_RABoss_Noth_EventHandler", "blinkwarn");
			CT_RABoss_Schedule("CT_RABoss_Noth_EventHandler", 32, "blinkwarn");
			CT_RABoss_VisualTimer.addTimer("NothBlink", 37, CT_RABOSS_NOTH_BLINK_TIMER, "orange");
			CT_RABoss_Mods["Noth"]["lastaction"] = GetTime();
		end

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" )  then
		if ( string.find(arg1, CT_RABOSS_NOTH_CURSESTRING) and not CT_RABoss_Mods["Noth"]["cursetrip"] and CT_RABoss_Mods["Noth"]["enablecurse"] ) then
			CT_RABoss_Mods["Noth"]["cursetrip"] = true;
			CT_RABoss_Announce(CT_RABOSS_NOTH_DISPELL, CT_RABoss_Mods["Noth"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Schedule("CT_RABoss_Noth_EventHandler", 5, "precurse");
			CT_RABoss_Mods["Noth"]["lastaction"] = GetTime();
		end

	elseif ( event == "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS" or event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS" or event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" ) then
		if ( string.find(arg1, CT_RABOSS_NAMES["Noth"]) or string.find(arg1, CT_RABOSS_NOTH_WARRIOR) or string.find(arg1, CT_RABOSS_NOTH_CHAMPION) or string.find(arg1, CT_RABOSS_NOTH_GUARDIAN) ) then
			CT_RABoss_Mods["Noth"]["lastaction"] = GetTime();
		end

	elseif ( event == "teleport" ) then
		CT_RABoss_UnSchedule("CT_RABoss_Noth_EventHandler", "blinkwarn");
		CT_RABoss_VisualTimer.removeTimer("NothBlink");
		if ( not CT_RABoss_Mods["Noth"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["Noth"]["lastaction"] ) > 60 ) then
			return;
		else
			CT_RABoss_Announce(format(CT_RABOSS_NOTH_TELEPORTED, CT_RABoss_Mods["Noth"]["timeonbalcony"]), CT_RABoss_Mods["Noth"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Schedule("CT_RABoss_Noth_EventHandler", CT_RABoss_Mods["Noth"]["timeonbalcony"] - 10, "nothsoon");
			CT_RABoss_Schedule("CT_RABoss_Noth_EventHandler", CT_RABoss_Mods["Noth"]["timeonbalcony"], "backinroom");
			CT_RABoss_VisualTimer.addTimer("NothBack", CT_RABoss_Mods["Noth"]["timeonbalcony"], CT_RABOSS_NOTH_BACK_TIMER);
			if ( CT_RABoss_Mods["Noth"]["timeonbalcony"] == 70 ) then
				CT_RABoss_Mods["Noth"]["timeonbalcony"] = 95;
				CT_RABoss_Mods["Noth"]["timeinroom"] = 110;
			elseif ( CT_RABoss_Mods["Noth"]["timeonbalcony"] == 95 ) then
				CT_RABoss_Mods["Noth"]["timeonbalcony"] = 120;
				CT_RABoss_Mods["Noth"]["timeinroom"] = 180;
			end
		end

	elseif ( event == "precurse" ) then
		CT_RABoss_Mods["Noth"]["cursetrip"] = false;

	elseif ( event == "blinkwarn" ) then
		CT_RABoss_Announce(CT_RABOSS_NOTH_BLINKSOON, CT_RABoss_Mods["Noth"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "teleportwarn" ) then
		CT_RABoss_Announce(CT_RABOSS_NOTH_TELEPORT_10SEC, CT_RABoss_Mods["Noth"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "nothsoon" ) then
		CT_RABoss_Announce(CT_RABOSS_NOTH_BACK_10SEC, CT_RABoss_Mods["Noth"]["announce"]);
		CT_RABoss_PlaySound(3);

	end
end

-- Heigan the Unclean (06/08/2006) - Updated code.
function CT_RABoss_Heigan_OnLoad()
	CT_RABoss_AddMod("Heigan", CT_RABOSS_HEIGAN_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Heigan", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Heigan_EventHandler);
	CT_RABoss_AddEvent("Heigan", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Heigan_EventHandler);

	CT_RABoss_AddDropDownButton("Heigan", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Heigan_EventHandler(event)
	if ( not CT_RABoss_Mods["Heigan"] or not CT_RABoss_Mods["Heigan"]["status"] or not CT_RABoss_Mods["Heigan"].enabled ) then
		return;
	end

	if ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( arg1 == CT_RABOSS_HEIGAN_PHASE1_YELL1 or arg1 == CT_RABOSS_HEIGAN_PHASE1_YELL2 or arg1 == CT_RABOSS_HEIGAN_PHASE1_YELL3 ) then
			CT_RABoss_Announce(CT_RABOSS_HEIGAN_ENGAGED, CT_RABoss_Mods["Heigan"]["announce"]);
			CT_RABoss_PlaySound(3);
			CT_RABoss_UnSchedule("CT_RABoss_Heigan_EventHandler");
			CT_RABoss_VisualTimer.removeTimer("HeiganDance");
			CT_RABoss_VisualTimer.removeTimer("HeiganTeleport");
			CT_RABoss_VisualTimer.removeTimer("HeiganEruption");
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 80, "teleport10warn");
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 85, "teleport5warn");
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 16, "eruption");
			CT_RABoss_Mods["Heigan"]["position"] = 1;
			CT_RABoss_Mods["Heigan"]["direction"] = true;
			CT_RABoss_Mods["Heigan"]["interval"] = 10;
			CT_RABoss_Mods["Heigan"]["time"] = 74;
			CT_RABoss_VisualTimer.addTimer("HeiganTeleport", 90, CT_RABOSS_HEIGAN_TELEPORT_TIMER);
			CT_RABoss_VisualTimer.addTimer("HeiganEruption", 16, string.format(CT_RABOSS_HEIGAN_ERUPTION_TIMER, CT_RABoss_Mods["Heigan"]["position"]), "orange");

		elseif ( arg1 == CT_RABOSS_HEIGAN_PHASE2_YELL1 ) then
			CT_RABoss_Announce(CT_RABOSS_HEIGAN_TELEPORTED, CT_RABoss_Mods["Heigan"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Mods["Heigan"]["position"] = 1;
			CT_RABoss_Mods["Heigan"]["direction"] = true;
			CT_RABoss_Mods["Heigan"]["interval"] = 3;
			CT_RABoss_Mods["Heigan"]["time"] = 42;
			CT_RABoss_UnSchedule("CT_RABoss_Heigan_EventHandler", "teleportwarn");
			CT_RABoss_UnSchedule("CT_RABoss_Heigan_EventHandler", "eruption");
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 42, "backsoon");
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 45, "backinroom");
			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 3, "eruption")
			CT_RABoss_VisualTimer.addTimer("HeiganDance", 45, CT_RABOSS_HEIGAN_DANCE);
			CT_RABoss_VisualTimer.addTimer("HeiganEruption", 3, string.format(CT_RABOSS_HEIGAN_ERUPTION_TIMER, CT_RABoss_Mods["Heigan"]["position"]), "orange");
		end

	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and arg2 == CT_RABOSS_NAMES["Heigan"] ) then
		if ( arg1 == CT_RABOSS_HEIGAN_DEAD ) then
			CT_RABoss_UnSchedule("CT_RABoss_Heigan_EventHandler");
			CT_RABoss_VisualTimer.removeTimer("HeiganTeleport");
			CT_RABoss_VisualTimer.removeTimer("HeiganEruption");
		end

	elseif ( event == "backinroom" ) then
		CT_RABoss_Announce(CT_RABOSS_HEIGAN_BACK, CT_RABoss_Mods["Heigan"]["announce"]);
		CT_RABoss_PlaySound(2);
		CT_RABoss_UnSchedule("CT_RABoss_Heigan_EventHandler", "eruption");
		CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 80, "teleport10warn");
		CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 85, "teleport5warn");
		CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", 11, "eruption");
		CT_RABoss_Mods["Heigan"]["position"] = 1;
		CT_RABoss_Mods["Heigan"]["direction"] = true;
		CT_RABoss_Mods["Heigan"]["interval"] = 10;
		CT_RABoss_Mods["Heigan"]["time"] = 79;
		CT_RABoss_VisualTimer.addTimer("HeiganTeleport", 90, CT_RABOSS_HEIGAN_TELEPORT_TIMER);
		CT_RABoss_VisualTimer.addTimer("HeiganEruption", 11, string.format(CT_RABOSS_HEIGAN_ERUPTION_TIMER, CT_RABoss_Mods["Heigan"]["position"]), "orange");

	elseif ( event == "teleport10warn" ) then
		CT_RABoss_Announce(CT_RABOSS_HEIGAN_TELEPORT_10SEC, CT_RABoss_Mods["Heigan"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "teleport5warn" ) then
		CT_RABoss_Announce(CT_RABOSS_HEIGAN_TELEPORT_5SEC, CT_RABoss_Mods["Heigan"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "backsoon" ) then
		CT_RABoss_Announce(CT_RABOSS_HEIGAN_BACK_3SEC, CT_RABoss_Mods["Heigan"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "eruption" ) then
		if ( CT_RABoss_Mods["Heigan"]["time"] >= CT_RABoss_Mods["Heigan"]["interval"] ) then
			if ( CT_RABoss_Mods["Heigan"]["direction"] ) then
				CT_RABoss_Mods["Heigan"]["position"] = CT_RABoss_Mods["Heigan"]["position"] + 1;
			else
				CT_RABoss_Mods["Heigan"]["position"] = CT_RABoss_Mods["Heigan"]["position"] - 1;
			end

			CT_RABoss_Schedule("CT_RABoss_Heigan_EventHandler", CT_RABoss_Mods["Heigan"]["interval"], "eruption");
			CT_RABoss_VisualTimer.addTimer("HeiganEruption", CT_RABoss_Mods["Heigan"]["interval"], string.format(CT_RABOSS_HEIGAN_ERUPTION_TIMER, CT_RABoss_Mods["Heigan"]["position"]), "orange");

			if ( CT_RABoss_Mods["Heigan"]["position"] == 1 or CT_RABoss_Mods["Heigan"]["position"] == 4) then
				CT_RABoss_Mods["Heigan"]["direction"] = not CT_RABoss_Mods["Heigan"]["direction"];
			end

			CT_RABoss_Mods["Heigan"]["time"] = CT_RABoss_Mods["Heigan"]["time"] - CT_RABoss_Mods["Heigan"]["interval"];
		end
	end
end

-- Loatheb (15/08/2006) - Fixed Doom count string.
function CT_RABoss_Loatheb_OnLoad()
	CT_RABoss_AddMod("Loatheb", CT_RABOSS_LOATHEB_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Loatheb", "CHAT_MSG_ADDON", CT_RABoss_Loatheb_EventHandler);
	CT_RABoss_AddEvent("Loatheb", "RAID_ROSTER_UPDATE", CT_RABoss_Loatheb_EventHandler);
	CT_RABoss_AddEvent("Loatheb", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Loatheb_EventHandler);
	CT_RABoss_AddEvent("Loatheb", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Loatheb_EventHandler);
	CT_RABoss_AddEvent("Loatheb", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Loatheb_EventHandler);
	CT_RABoss_AddEvent("Loatheb", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Loatheb_EventHandler);

	CT_RABoss_AddDropDownButton("Loatheb", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Loatheb", { CT_RABOSS_LOATHEB_HEAL_RAID_ALERT, CT_RABOSS_LOATHEB_HEAL_RAID_INFO }, "CT_RABoss_ModInfo", "AnnounceHealRaid", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Loatheb", { CT_RABOSS_LOATHEB_HEAL_WHISPER_ALERT, CT_RABOSS_LOATHEB_HEAL_WHISPER_INFO }, "CT_RABoss_ModInfo", "AnnounceHealWhisper", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Loatheb", { CT_RABOSS_LOATHEB_SPORE_ALERT, CT_RABOSS_LOATHEB_SPORE_ALERT_INFO }, "CT_RABoss_ModInfo", "sporeAlert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Loatheb", { CT_RABOSS_LOATHEB_POTION_WARNING, CT_RABOSS_LOATHEB_POTION_WARNING_INFO }, "CT_RABoss_ModInfo", "potionWarn", "CT_RABoss_SetInfo");

	CT_RABoss_Mods["Loatheb"]["Healers"] = {};
	CT_RABoss_Mods["Loatheb"]["DeletedHealers"] = {};
	CT_RABoss_Mods["Loatheb"]["LongMsg"] = "";
	CT_RABoss_Mods["Loatheb"]["SpamProt"] = {};
	CT_RABoss_Mods["Loatheb"]["HealersSorted"] = false;
	CT_RABoss_Mods["Loatheb"]["FrameLocked"] = false;
	CT_RABoss_Mods["Loatheb"]["sporeGroup"] = 1;

	local _, class = UnitClass("player");
	if ( class == "PRIEST" or class == "DRUID" or class == "PALADIN" or class == "SHAMAN" ) then
		CT_RABoss_Mods["Loatheb"]["ShowHealFrame"] = true;
	else
		CT_RABoss_Mods["Loatheb"]["ShowHealFrame"] = false;
	end
end

function CT_RABoss_Loatheb_Start()
	CT_RABoss_Announce(CT_RABOSS_LOATHEB_ENGAGE, CT_RABoss_Mods["Loatheb"]["announce"]);
	CT_RABoss_PlaySound(3);
	CT_RABoss_Mods["Loatheb"]["lastaction"] = GetTime();
	CT_RABoss_Mods["Loatheb"]["engaged"] = true;
	CT_RABoss_Mods["Loatheb"]["sporeGroup"] = 1;
	CT_RABoss_Schedule("CT_RABoss_Loatheb_EventHandler", 111, "doom5");
	CT_RABoss_Schedule("CT_RABoss_Loatheb_EventHandler", 3, "spore");
	CT_RABoss_Mods["Loatheb"]["sporeTrip"] = false;
	CT_RABoss_VisualTimer.addTimer("LoathebDoom", 116, string.format(CT_RABOSS_LOATHEB_DOOM_TIMER, 1));
	CT_RABoss_VisualTimer.addTimer("LoathebSpore", 6, string.format(CT_RABOSS_LOATHEB_SPORE_TIMER, CT_RABoss_Mods["Loatheb"]["sporeGroup"]), "orange");
	for i = 1, GetNumRaidMembers(), 1 do
		if ( UnitIsUnit("raid" .. i, "player") ) then
			local _, _, subgroup = GetRaidRosterInfo(i);
			CT_RABoss_Mods["Loatheb"]["currGroup"] = subgroup;
			break;
		end
	end
	if ( CT_RABoss_Mods["Loatheb"]["ShowHealFrame"] and not CT_LoathebFrameDrag:IsShown() ) then
		CT_LoathebFrameDrag:Show();
		CT_RABoss_Mods.Loatheb.AutoShown = true;
	end
end

function CT_RABoss_Loatheb_DetectHeal(index)
	if ( not CT_RABoss_Mods["Loatheb"]["engaged"] ) then
		return;
	end
	if ( not CT_RABoss_Mods.Loatheb.Healers[index].Cooldown ) then
		CT_RABoss_Mods.Loatheb.Healers[index].Cooldown = 60;
		if CT_RABoss_Mods.Loatheb.HealersSorted then
			local nextHealerID, nextHealer = CT_RABoss_Loatheb_GetNextHealer(index);
			local soonHealerID, soonHealer = CT_RABoss_Loatheb_GetNextHealer(nextHealerID);

			if ( nextHealerID and nextHealer ) then
				if ( nextHealer == UnitName("player") ) then
					CT_RABoss_Announce(CT_RABOSS_LOATHEB_YOU_ARE_NEXT);
				end
				if ( CT_RA_Level >= 1 ) then
					if ( CT_RABoss_Mods.Loatheb.AnnounceHealRaid ) then
						SendChatMessage(string.format(CT_RABOSS_LOATHEB_HEAL_WARNING, index, nextHealer), "RAID")
					end
					if CT_RABoss_Mods.Loatheb.AnnounceHealWhisper and soonHealer then
						SendChatMessage(CT_RABOSS_LOATHEB_YOU_ARE_NEXT, "WHISPER", nil, nextHealer);
						SendChatMessage(CT_RABOSS_LOATHEB_YOU_ARE_SOON, "WHISPER", nil, soonHealer);
					end
					if not CT_LoathebArrowRight then
						local arrowRight, arrowRightTexture;
						arrowRight = CreateFrame("Frame", "CT_LoathebArrowRight", CT_LoathebFrameDrag);
						arrowRight:SetWidth(32);
						arrowRight:SetHeight(32);
						arrowRightTexture = arrowRight:CreateTexture("CT_LoathebArrowRightTexture", "BACKGROUND");
						arrowRightTexture:SetTexture("Interface\\AddOns\\CT_RABossMods\\Images\\Arrow-Right");
						arrowRightTexture:SetBlendMode("ALPHAKEY");
						arrowRightTexture:SetAllPoints(arrowRight);
					elseif not CT_LoathebArrowRight:IsShown() then
						CT_LoathebArrowRight:Show();
					end
					CT_LoathebArrowRight:ClearAllPoints();
					if getglobal("CT_LoathebHealerFrame"..nextHealerID) then
						CT_LoathebArrowRight:SetPoint("RIGHT", "CT_LoathebHealerFrame"..nextHealerID, "LEFT", 0, 0);
						local i = 1;
						while getglobal("CT_LoathebHealerFrame"..i.."BarBorder") do
							getglobal("CT_LoathebHealerFrame"..i.."BarBorder"):SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder");
							i = i + 1;
						end
						getglobal("CT_LoathebHealerFrame"..nextHealerID.."BarBorder"):SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorderHighlight");
						CT_LoathebFrameDrag.ArrowPosition = nextHealerID;
						CT_RABoss_Schedule(CT_RABoss_Loatheb_EventHandler, 35, "HideArrow", nextHealerID);
					end
				end
			end
		end
	end
end

function CT_RABoss_Loatheb_GetNextHealer(index)
	if not index then
		return;
	end

	local i = index + 1;
	while CT_RABoss_Mods.Loatheb.Healers[i] do
		if not UnitIsDeadOrGhost("raid" .. CT_RABoss_Mods.Loatheb.Healers[i].ID) and UnitIsConnected("raid" .. CT_RABoss_Mods.Loatheb.Healers[i].ID) then
			return i, CT_RABoss_Mods.Loatheb.Healers[i].Name;
		end
		i = i + 1;
	end
	i = 1;
	while CT_RABoss_Mods.Loatheb.Healers[i] and i < index do
		if not UnitIsDeadOrGhost("raid" .. CT_RABoss_Mods.Loatheb.Healers[i].ID) and UnitIsConnected("raid" .. CT_RABoss_Mods.Loatheb.Healers[i].ID) then
			return i, CT_RABoss_Mods.Loatheb.Healers[i].Name;
		end
		i = i + 1;
	end
end

function CT_RABoss_Loatheb_SendHealList()
	local msg = "";
	if not CT_RABoss_Mods.Loatheb.HealersSorted then
		return;
	end
	for index, value in pairs(CT_RABoss_Mods.Loatheb.Healers) do
		msg = msg..value.Sort..value.Name.." ";
	end
	for index, value in pairs(CT_RABoss_Mods.Loatheb.DeletedHealers) do
		msg = msg.."0"..index.." ";
	end
	while string.len(msg) > 240 do
		SendAddonMessage("LVBMLOALISTL", string.sub(msg, 1, 240), "RAID");
		msg = string.sub(msg, 241);
	end
	SendAddonMessage("LVBMLOALISTS", msg, "RAID");
end

function CT_RABoss_Loatheb_EventHandler(event, param)
	if ( not CT_RABoss_Mods["Loatheb"] or not CT_RABoss_Mods["Loatheb"]["status"] or not CT_RABoss_Mods["Loatheb"].enabled ) then
		return;
	end

	if ( CT_RABoss_Mods["Loatheb"]["engaged"] and ( not CT_RABoss_Mods["Loatheb"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["Loatheb"]["lastaction"] ) > 60 ) ) then
		CT_RABoss_Mods["Loatheb"]["engaged"] = false;
		CT_RABoss_Mods["Loatheb"]["countdoom"] = nil;
		CT_RABoss_Mods["Loatheb"]["sporeGroup"] = 1;
		CT_RABoss_Mods["Loatheb"]["sporeTrip"] = nil;
		if ( CT_RABoss_Mods.Loatheb.AutoShown ) then
			CT_LoathebFrameDrag:Hide();
		end
		CT_RABoss_Mods["Loatheb"]["AutoShown"] = false;
	end

	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") then
		if ( string.find(arg1, CT_RABOSS_LOATHEB_DOOM_STRING) and not CT_RABoss_Mods["Loatheb"]["doomtrip"] ) then
			CT_RABoss_Announce(CT_RABOSS_LOATHEB_DOOM_WARN, CT_RABoss_Mods["Loatheb"]["announce"]);
			CT_RABoss_UnSchedule("CT_RABoss_Loatheb_EventHandler", "doom5");
			CT_RABoss_Schedule("CT_RABoss_Loatheb_EventHandler", 5, "undoom");
			CT_RABoss_Mods["Loatheb"]["doomtrip"] = true;
			CT_RABoss_Mods["Loatheb"]["engaged"] = true;
			CT_RABoss_Mods["Loatheb"]["lastaction"] = GetTime();

			if ( CT_RABoss_Mods["Loatheb"]["countdoom"] ) then
				CT_RABoss_Mods["Loatheb"]["countdoom"] = CT_RABoss_Mods["Loatheb"]["countdoom"] + 1;
			else
				CT_RABoss_Mods["Loatheb"]["countdoom"] = 1;
			end

			if ( CT_RABoss_Mods["Loatheb"]["countdoom"] > 6 ) then
				CT_RABoss_Schedule("CT_RABoss_Loatheb_EventHandler", 10, "doom5");
				CT_RABoss_VisualTimer.addTimer("LoathebDoom", 15, string.format(CT_RABOSS_LOATHEB_DOOM_TIMER, CT_RABoss_Mods["Loatheb"]["countdoom"]+1));
			else
				CT_RABoss_Schedule("CT_RABoss_Loatheb_EventHandler", 25, "doom5");
				CT_RABoss_VisualTimer.addTimer("LoathebDoom", 30, string.format(CT_RABOSS_LOATHEB_DOOM_TIMER, CT_RABoss_Mods["Loatheb"]["countdoom"]+1));
			end
			if ( CT_RABoss_Mods["Loatheb"]["potionWarn"] ) then
				CT_RABoss_Schedule("CT_RABoss_Loatheb_EventHandler", 10, "PotionWarning");
			end

		elseif ( string.find(arg1, CT_RABOSS_LOATHEB_HEAL_STRING) ) then
			local _, _, sPlayer = string.find(arg1, CT_RABOSS_LOATHEB_HEAL_STRING);
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				sPlayer = UnitName("player");
			end

			if ( sPlayer and CT_RABoss_Mods["Loatheb"]["engaged"] ) then
				for i = 1, GetNumRaidMembers(), 1 do
					if UnitName("raid"..i) == sPlayer then
						local _, class = UnitClass("raid"..i);
						if class == "PRIEST" or class == "PALADIN" or class == "DRUID" or class == "SHAMAN" then
							local j, texture, foundDebuff;
							j = 1;
							while UnitDebuff("raid"..i, j) do
								texture = UnitDebuff("raid"..i, j);
								j = j + 1;
								if texture == "Interface\\Icons\\Spell_Shadow_AuraOfDarkness" then
									foundDebuff = true;
									break;
								end
							end
							if not foundDebuff then
								return;
							end
							for index, value in pairs(CT_RABoss_Mods.Loatheb.Healers) do
								if value.Name == sPlayer then
									if not value.Cooldown then
										CT_RABoss_Loatheb_DetectHeal(index);
										if not CT_RABoss_Mods.Loatheb.SpamProt[sPlayer] then
											SendAddonMessage("LVBMLOAHEAL", sPlayer, "RAID");
											CT_RABoss_Mods.Loatheb.SpamProt[sPlayer] = true;
											CT_RABoss_Schedule("CT_RABoss_Loatheb_EventHandler", 6, "unheal", sPlayer);
										end
									end
									break;
								end
							end
						end
						break;
					end
				end
			end
		end

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) then
		if ( string.find(arg1, CT_RABOSS_LOATHEB_DECURSE_STRING) ) then
			CT_RABoss_VisualTimer.addTimer("LoathebDecurse", 30, CT_RABOSS_LOATHEB_DECURSE_TIMER);
			CT_RABoss_Mods["Loatheb"]["lastaction"] = GetTime();
			if ( not CT_RABoss_Mods["Loatheb"]["engaged"] ) then
				CT_RABoss_Loatheb_Start();
				if ( CT_RA_Level >= 1 ) then
					CT_RABoss_SendMessage("LOATHEBSTARTSYNC");
				end
			end

		elseif ( string.find(arg1, CT_RABOSS_LOATHEB_SPORE_STRING) and not CT_RABoss_Mods["Loatheb"]["sporeTrip"] ) then
			if ( CT_RABoss_Mods["Loatheb"]["currGroup"] == CT_RABoss_Mods["Loatheb"]["sporeGroup"] ) then
				CT_RABoss_Announce(CT_RABOSS_LOATHEB_SPORE_SPAWN);
				CT_RABoss_PlaySound(1);
			end
			CT_RABoss_Mods["Loatheb"]["sporeTrip"] = true;

			if ( CT_RABoss_Mods["Loatheb"]["sporeGroup"] == 8 ) then
				CT_RABoss_Mods["Loatheb"]["sporeGroup"] = 1;
			else
				CT_RABoss_Mods["Loatheb"]["sporeGroup"] = CT_RABoss_Mods["Loatheb"]["sporeGroup"] + 1;
			end

			CT_RABoss_VisualTimer.addTimer("LoathebSpore", 12, string.format(CT_RABOSS_LOATHEB_SPORE_TIMER, CT_RABoss_Mods["Loatheb"]["sporeGroup"]), "orange");
			CT_RABoss_Schedule("CT_RABoss_Loatheb_EventHandler", 3, "unspore");
			CT_RABoss_Schedule("CT_RABoss_Loatheb_EventHandler", 9, "spore");
			CT_RABoss_Mods["Loatheb"]["engaged"] = true;
			CT_RABoss_Mods["Loatheb"]["lastaction"] = GetTime();

		end

	elseif ( event == "CHAT_MSG_ADDON" and arg3 == "RAID" ) then
		if ( arg1 == "CTRA_BOSS" ) then
			if ( arg2 == "LOATHEBSTARTSYNC" and not CT_RABoss_Mods["Loatheb"]["engaged"] ) then
				CT_RABoss_Loatheb_Start();
			end

		elseif ( arg1 == "LVBMLOATHEB" ) then
			if ( arg2 == "REQLIST" ) then
				if ( CT_RA_Level >= 1 ) then
					CT_RABoss_Loatheb_SendHealList();
				end
			end

		elseif ( arg1 == "LVBMLOALISTL" and arg2 ) then
			local rank;
			for i = 1, GetNumRaidMembers(), 1 do
				if UnitName("raid"..i) == arg4 then
					_, _, rank = GetRaidRosterInfo(i);
					break;
				end
			end
			if rank >= 1 then
				CT_RABoss_Mods.Loatheb.LongMsg = CT_RABoss_Mods.Loatheb.LongMsg..arg2;
			end

		elseif ( arg1 == "LVBMLOALISTS" and arg2 ) then
			local rank;
			for i = 1, GetNumRaidMembers(), 1 do
				if UnitName("raid"..i) == arg4 then
					_, _, rank = GetRaidRosterInfo(i);
					break;
				end
			end
			if rank >= 1 then
				arg2 = CT_RABoss_Mods.Loatheb.LongMsg..arg2;
				CT_RABoss_Mods.Loatheb.LongMsg = "";
				CT_RABoss_Mods.Loatheb.DeletedHealers = {};
				CT_RABoss_Loatheb_EventHandler("RAID_ROSTER_UPDATE");
				for sort, player in string.gfind(arg2, "(%d+)([^%s]-) ") do
					for index, value in pairs(CT_RABoss_Mods.Loatheb.Healers) do
						if value.Name and value.Name == player and tonumber(sort) then
							CT_RABoss_Mods.Loatheb.Healers[index].Sort = tonumber(sort);
							break;
						end
					end
				end
				for index, value in pairs(CT_RABoss_Mods.Loatheb.Healers) do
					if value and value.Sort == 0 then
						CT_RABoss_Mods.Loatheb.DeletedHealers[value.Name] = true;
						table.remove(CT_RABoss_Mods.Loatheb.Healers, index);
					elseif value and value.Sort ~= 0 and CT_RABoss_Mods.Loatheb.DeletedHealers[value.Name] then
						CT_RABoss_Mods.Loatheb.DeletedHealers[value.Name] = nil;
					end
				end
				CT_RABoss_Loatheb_EventHandler("RAID_ROSTER_UPDATE");
				CT_RABoss_Mods.Loatheb.HealersSorted = true;
				table.sort(CT_RABoss_Mods.Loatheb.Healers, function(v1, v2) return v1.Sort < v2.Sort end);
			end

		elseif ( arg1 == "LVBMLOAHEAL" and arg2 and not CT_RABoss_Mods.Loatheb.SpamProt[arg2] ) then
			CT_RABoss_Mods.Loatheb.SpamProt[arg2] = true;
			CT_RABoss_Schedule("CT_RABoss_Loatheb_EventHandler", 6, "unheal", arg2);
			for index, value in pairs(CT_RABoss_Mods.Loatheb.Healers) do
				if value and value.Name == arg2 then
					CT_RABoss_Loatheb_DetectHeal(index);
					break;
				end
			end
		end

	elseif ( event == "RAID_ROSTER_UPDATE" ) then
		if GetNumRaidMembers() <= 1 then
			CT_RABoss_Mods.Loatheb.Healers = {};
			CT_RABoss_Mods.Loatheb.HealersSorted = false;
		end
		local playersInRaidGrp = {};
		for i = 1, GetNumRaidMembers(), 1 do
			local _, class = UnitClass("raid"..i);
			if class == "PRIEST" or class == "PALADIN" or class == "DRUID" or class == "SHAMAN" then
				local exists;
				playersInRaidGrp[UnitName("raid"..i)] = UnitClass("raid"..i);
				for index, value in pairs(CT_RABoss_Mods.Loatheb.Healers) do
					if value.Name and value.Name == UnitName("raid"..i) then
						exists = true;
						CT_RABoss_Mods.Loatheb.Healers[index].ID = i;
						break;
					end
				end
				if not exists and not CT_RABoss_Mods.Loatheb.DeletedHealers[UnitName("raid"..i)] then
					table.insert(CT_RABoss_Mods.Loatheb.Healers, {["Name"] = UnitName("raid"..i), ["Class"] = UnitClass("raid"..i), ["Cooldown"] = false, ["Sort"] = 99, ["ID"] = i })
					if not CT_RABoss_Mods.Loatheb.HealersSorted then
						table.sort(CT_RABoss_Mods.Loatheb.Healers, function(v1, v2) return v1.Name < v2.Name end)
					end
				end
			end
		end
		for index, value in pairs(CT_RABoss_Mods.Loatheb.Healers) do
			if value and value.Name and not playersInRaidGrp[value.Name] then
				table.remove(CT_RABoss_Mods.Loatheb.Healers, index);
			end
		end
		local frameCount = 1;
		while getglobal("CT_LoathebHealerFrame"..frameCount) and getglobal("CT_LoathebHealerFrame"..frameCount):IsShown() do
			frameCount = frameCount + 1;
		end
		frameCount = frameCount - 1;
		for i = (frameCount + 1), table.getn(CT_RABoss_Mods.Loatheb.Healers) do
			if getglobal("CT_LoathebHealerFrame"..i) then
				getglobal("CT_LoathebHealerFrame"..i):Show();
			else
				local newFrame;
				newFrame = CreateFrame("Frame", "CT_LoathebHealerFrame"..i, CT_LoathebFrameDrag, "CT_LoathebHealerTemplate");
				if i == 1 then
					newFrame:SetPoint("TOP", "CT_LoathebFrameDrag", "BOTTOM", 0, 0);
				else
					newFrame:SetPoint("TOP", "CT_LoathebHealerFrame"..(i - 1), "BOTTOM", 0, 3);
				end
				newFrame:Show();
			end
		end
		for i = frameCount, (table.getn(CT_RABoss_Mods.Loatheb.Healers) + 1), - 1 do
			if i > 0 then
				getglobal("CT_LoathebHealerFrame"..i):Hide();
			end
		end

	elseif ( event == "doom5") then
		CT_RABoss_Announce(CT_RABOSS_LOATHEB_DOOM_5SEC, CT_RABoss_Mods["Loatheb"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "undoom") then
		CT_RABoss_Mods["Loatheb"]["doomtrip"] = false;

	elseif ( event == "unspore" ) then
		CT_RABoss_Mods["Loatheb"]["sporeTrip"] = false;

	elseif ( event == "spore" ) then
		if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Loatheb"]["sporeAlert"] ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_LOATHEB_SPORE_3SEC, CT_RABoss_Mods["Loatheb"]["sporeGroup"]), CT_RABoss_Mods["Loatheb"]["announce"]);
		end

		if ( CT_RABoss_Mods["Loatheb"]["currGroup"] == CT_RABoss_Mods["Loatheb"]["sporeGroup"] ) then
			CT_RABoss_Announce(CT_RABOSS_LOATHEB_SPORE_WARN);
			CT_RABoss_PlaySound(2);
		end

	elseif ( event == "HideArrow" and CT_LoathebFrameDrag.ArrowPosition and param[1] ) then
		getglobal("CT_LoathebHealerFrame"..param[1].."BarBorder"):SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder");
		if CT_LoathebArrowRight and CT_LoathebFrameDrag.ArrowPosition == param[1] then
			CT_LoathebArrowRight:Hide();
		end

	elseif ( event == "unheal" and param[1] ) then
		CT_RABoss_Mods.Loatheb.SpamProt[param[1]] = nil;

	elseif ( event == "PotionWarning" ) then
		local item = { CT_RABOSS_LOATHEB_SHADOW_POTION, CT_RABOSS_LOATHEB_WHIPPER, CT_RABOSS_LOATHEB_BANDAGE, nil, CT_RABOSS_LOATHEB_SHADOW_POTION .. "+" .. CT_RABOSS_LOATHEB_BANDAGE, CT_RABOSS_LOATHEB_STONE, CT_RABOSS_LOATHEB_BANDAGE };
		if ( CT_RABoss_Mods["Loatheb"]["potionWarn"] and item[CT_RABoss_Mods["Loatheb"]["countdoom"]]) then
			CT_RABoss_Announce(item[CT_RABoss_Mods["Loatheb"]["countdoom"]], CT_RABoss_Mods["Loatheb"]["announce"]);
			CT_RABoss_Announce(item[CT_RABoss_Mods["Loatheb"]["countdoom"]], CT_RABoss_Mods["Loatheb"]["announce"]);
			CT_RABoss_Announce(item[CT_RABoss_Mods["Loatheb"]["countdoom"]], CT_RABoss_Mods["Loatheb"]["announce"]);
		end
	end
end

-- Instructor Razuvious (01/09/2006) - Added shieldwall anouncements.
function CT_RABoss_Razuvious_Stop()
	CT_RABoss_Mods["Razuvious"]["combat"] = nil;
	CT_RABoss_Mods["Razuvious"]["lastAction"] = nil;

	CT_RABoss_UnSchedule("CT_RABoss_Razuvious_EventHandler");
end

function CT_RABoss_Razuvious_OnLoad()
	CT_RABoss_AddMod("Razuvious", CT_RABOSS_RAZUVIOUS_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	
	CT_RABoss_AddEvent("Razuvious", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Razuvious_EventHandler);
	CT_RABoss_AddEvent("Razuvious", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Razuvious_EventHandler);
	CT_RABoss_AddEvent("Razuvious", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_Razuvious_EventHandler);
	CT_RABoss_AddEvent("Razuvious", "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS", CT_RABoss_Razuvious_EventHandler);
	CT_RABoss_AddEvent("Razuvious", "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS", CT_RABoss_Razuvious_EventHandler);
	CT_RABoss_AddEvent("Razuvious", "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS", CT_RABoss_Razuvious_EventHandler);
	CT_RABoss_AddEvent("Razuvious", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Razuvious_EventHandler);
	CT_RABoss_AddEvent("Razuvious", "CHAT_MSG_COMBAT_HOSTILE_DEATH", CT_RABoss_Razuvious_EventHandler);
	
	CT_RABoss_AddDropDownButton("Razuvious", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");

	CT_RA_RegisterSlashCmd("/razustop", CT_RABOSS_CMD_RAZUSTOP, 30, "RAZUSTOP", function()
		CT_RABoss_Razuvious_Stop();
	end, "/razustop");
end

function CT_RABoss_Razuvious_ShoutCast()
	CT_RABoss_Schedule("CT_RABoss_Razuvious_EventHandler", 15, "shoutPreWarn10");

	CT_RABoss_Announce(format(CT_RABOSS_RAZUVIOUS_SHOUT_PREALERT, "25"), CT_RABoss_Mods["Razuvious"]["announce"]);
	CT_RABoss_PlaySound(2);
	CT_RABoss_Mods["Razuvious"]["combat"] = 1;
end

function CT_RABoss_Razuvious_EventHandler(event)
	if ( not CT_RABoss_Mods["Razuvious"] or not CT_RABoss_Mods["Razuvious"]["status"] or not CT_RABoss_Mods["Razuvious"].enabled ) then
		return;
	end

	-- Encounter begin
	if ( event == "CHAT_MSG_MONSTER_YELL" and arg2 == CT_RABOSS_NAMES["Razuvious"] and not CT_RABoss_Mods["Razuvious"]["combat"] ) then
		if ( string.find(arg1, CT_RABOSS_RAZUVIOUS_YELL1_DETECT) or string.find(arg1, CT_RABOSS_RAZUVIOUS_YELL2_DETECT) or string.find(arg1, CT_RABOSS_RAZUVIOUS_YELL3_DETECT) or string.find(arg1, CT_RABOSS_RAZUVIOUS_YELL4_DETECT) ) then
			CT_RABoss_Mods["Razuvious"]["lastAction"] = GetTime();
			CT_RABoss_Razuvious_ShoutCast();
		end
	end
	
	-- Disrupting Shout detected
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" ) then
		if ( string.find(arg1, CT_RABOSS_RAZUVIOUS_SHOUT_DETECT) and not CT_RABoss_Mods["Razuvious"]["shoutTrip"] ) then
			CT_RABoss_Mods["Razuvious"]["shoutTrip"] = 1;
			CT_RABoss_Mods["Razuvious"]["lastAction"] = GetTime();

			CT_RABoss_UnSchedule("CT_RABoss_Razuvious_EventHandler", "shoutPreWarn10");
			CT_RABoss_UnSchedule("CT_RABoss_Razuvious_EventHandler", "shoutPreWarn5");
			CT_RABoss_UnSchedule("CT_RABoss_Razuvious_EventHandler", "shoutWarn");

			CT_RABoss_Razuvious_ShoutCast();
		end

	-- Disrupting Shout 10sec pre-alert
	elseif ( event == "shoutPreWarn10" ) then
		CT_RABoss_Mods["Razuvious"]["shoutTrip"] = nil;
		CT_RABoss_Schedule("CT_RABoss_Razuvious_EventHandler", 5, "shoutPreWarn5");
		CT_RABoss_Announce(format(CT_RABOSS_RAZUVIOUS_SHOUT_PREALERT, "10"), CT_RABoss_Mods["Razuvious"]["announce"]);

	-- Disrupting Shout 5sec pre-alert
	elseif ( event == "shoutPreWarn5" ) then
		CT_RABoss_Schedule("CT_RABoss_Razuvious_EventHandler", 5, "shoutWarn");
		CT_RABoss_Announce(format(CT_RABOSS_RAZUVIOUS_SHOUT_PREALERT, "5"), CT_RABoss_Mods["Razuvious"]["announce"]);

	-- Disrupting Shout alert
	elseif ( event == "shoutWarn" ) then
		CT_RABoss_Razuvious_ShoutCast();
	end

	-- Encounter end
	if ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" and string.find(arg1, CT_RABOSS_RAZUVIOUS_DEATH_DETECT) ) then
		CT_RABoss_Razuvious_Stop();
	end

	if ( event == "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS" or event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS" or event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" ) then
		if ( string.find(arg1, CT_RABOSS_NAMES["Razuvious"]) or string.find(arg1, CT_RABOSS_RAZUVIOUS_STUDENT_NAME) ) then
			CT_RABoss_Mods["Razuvious"]["lastAction"] = GetTime();
		end
	end

	if ( CT_RABoss_Mods["Razuvious"]["lastAction"] and (GetTime() - CT_RABoss_Mods["Razuvious"]["lastAction"]) > 20 ) then
		CT_RABoss_Razuvious_Stop();
	end
end

-- Gothik the Harvester (11/08/2006) - Updated timers, by 4 seconds.
function CT_RABoss_Gothik_OnLoad()
	CT_RABoss_AddMod("Gothik", CT_RABOSS_GOTHIK_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Gothik", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Gothik_EventHandler);
	CT_RABoss_AddEvent("Gothik", "CHAT_MSG_COMBAT_HOSTILE_DEATH", CT_RABoss_Gothik_EventHandler);
	CT_RABoss_AddEvent("Gothik", "CHAT_MSG_ADDON", CT_RABoss_Gothik_EventHandler);

	CT_RABoss_AddDropDownButton("Gothik", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");

	CT_RA_RegisterSlashCmd("/gothikstop", CT_RABOSS_CMD_GOTHIKSTOP, 30, "GOTHIKSTOP", function()
		CT_RABoss_Gothik_Reset();
		if ( CT_RA_Level >= 1 ) then
			CT_RA_AddMessage("GOTHIKSTOPSYNC");
		end
	end, "/gothikstop");
end

function CT_RABoss_Gothik_Reset()
	CT_RABoss_UnSchedule("CT_RABoss_Gothik_EventHandler");
	CT_RABoss_VisualTimer.removeTimer("GothikTrainee");
	CT_RABoss_VisualTimer.removeTimer("GothikKnight");
	CT_RABoss_VisualTimer.removeTimer("GothikRider");
	CT_RABoss_VisualTimer.removeTimer("GothikInc");
end

function CT_RABoss_Gothik_EventHandler(event)
	if ( not CT_RABoss_Mods["Gothik"] or not CT_RABoss_Mods["Gothik"]["status"] or not CT_RABoss_Mods["Gothik"].enabled ) then
		return;
	end

	if ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( string.find(arg1, CT_RABOSS_GOTHIK_PHASE1_YELL1) ) then
			CT_RABoss_Announce(CT_RABOSS_GOTHIK_ENGAGED, CT_RABoss_Mods["Gothik"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 30, "inctimer");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 24, "inctrainee");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 74, "incknight");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 134, "incrider");
			CT_RABoss_Mods["Gothik"]["timeleft"] = 4;
			CT_RABoss_Mods["Gothik"]["Trainees"] = 1;
			CT_RABoss_Mods["Gothik"]["Knights"] = 1;
			CT_RABoss_Mods["Gothik"]["Riders"] = 1;
			CT_RABoss_VisualTimer.addTimer("GothikInc", 270, CT_RABOSS_GOTHIK_INC_TIMER, "orange");
			CT_RABoss_VisualTimer.addTimer("GothikRider", 137, string.format(CT_RABOSS_GOTHIK_RIDERS, 1), nil, true);
			CT_RABoss_VisualTimer.addTimer("GothikKnight", 77, string.format(CT_RABOSS_GOTHIK_KNIGHTS, 1), nil, true);
			CT_RABoss_VisualTimer.addTimer("GothikTrainee", 27, string.format(CT_RABOSS_GOTHIK_TRAINEES, 1), nil, true);

		elseif ( arg1 == CT_RABOSS_GOTHIK_PHASE2_YELL1 ) then
			CT_RABoss_Announce(CT_RABOSS_GOTHIK_INC, CT_RABoss_Mods["Gothik"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Gothik_Reset();
		end

	elseif ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
		if ( string.find(arg1, CT_RABOSS_GOTHIK_KNIGHT) ) then
			CT_RABoss_Announce(CT_RABOSS_GOTHIK_KNIGHT_DEAD, CT_RABoss_Mods["Gothik"]["announce"]);

		elseif ( string.find(arg1, CT_RABOSS_GOTHIK_RIDER) ) then
			CT_RABoss_Announce(CT_RABOSS_GOTHIK_RIDER_DEAD, CT_RABoss_Mods["Gothik"]["announce"]);
		end

	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA_BOSS" and arg3 == "RAID" ) then
		if ( arg2 == "GOTHIKSTOPSYNC" ) then
			CT_RABoss_Gothik_Reset();
		end

	elseif ( event == "inctimer") then
		if ( CT_RABoss_Mods["Gothik"]["timeleft"] == 0.5 ) then
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 20, "inc10");
			CT_RABoss_Announce(format(CT_RABOSS_GOTHIK_SECWARN, "30"), CT_RABoss_Mods["Gothik"]["announce"]);
			CT_RABoss_PlaySound(3);
		else
			if ( CT_RABoss_Mods["Gothik"]["timeleft"] == 1 ) then
				CT_RABoss_Announce(CT_RABOSS_GOTHIK_1MINWARN, CT_RABoss_Mods["Gothik"]["announce"]);
			else
				CT_RABoss_Announce(format(CT_RABOSS_GOTHIK_WARN, CT_RABoss_Mods["Gothik"]["timeleft"]));
			end

			CT_RABoss_Mods["Gothik"]["timeleft"] = CT_RABoss_Mods["Gothik"]["timeleft"]-0.5;
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 30, "inctimer");
			CT_RABoss_PlaySound(3);
		end

	elseif ( event == "inctrainee" ) then
		CT_RABoss_Announce(format(CT_RABOSS_GOTHIK_ADD_INC, CT_RABoss_Mods["Gothik"]["Trainees"], CT_RABOSS_GOTHIK_TRAINEE), CT_RABoss_Mods["Gothik"]["announce"]);
		CT_RABoss_PlaySound(3);
		if ( CT_RABoss_Mods["Gothik"]["Trainees"] < 11 ) then
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 20, "inctrainee");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 3, "trainee");
			CT_RABoss_Mods["Gothik"]["Trainees"] = CT_RABoss_Mods["Gothik"]["Trainees"] + 1;
		end

	elseif ( event == "trainee" ) then
		CT_RABoss_VisualTimer.addTimer("GothikTrainee", 20, string.format(CT_RABOSS_GOTHIK_TRAINEES, CT_RABoss_Mods["Gothik"]["Trainees"]), nil, true);

	elseif ( event == "incknight" ) then
		CT_RABoss_Announce(format(CT_RABOSS_GOTHIK_ADD_INC, CT_RABoss_Mods["Gothik"]["Knights"], CT_RABOSS_GOTHIK_KNIGHT), CT_RABoss_Mods["Gothik"]["announce"]);
		CT_RABoss_PlaySound(3);
		if ( CT_RABoss_Mods["Gothik"]["Knights"] < 7 ) then
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 25, "incknight");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 3, "knight");
			CT_RABoss_Mods["Gothik"]["Knights"] = CT_RABoss_Mods["Gothik"]["Knights"] + 1;
		end

	elseif ( event == "knight" ) then
		CT_RABoss_VisualTimer.addTimer("GothikKnight", 25, string.format(CT_RABOSS_GOTHIK_KNIGHTS, CT_RABoss_Mods["Gothik"]["Knights"]), nil, true);

	elseif ( event == "incrider" ) then
		CT_RABoss_Announce(format(CT_RABOSS_GOTHIK_ADD_INC, CT_RABoss_Mods["Gothik"]["Riders"], CT_RABOSS_GOTHIK_RIDER), CT_RABoss_Mods["Gothik"]["announce"]);
		CT_RABoss_PlaySound(3);
		if ( CT_RABoss_Mods["Gothik"]["Riders"] < 4 ) then
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 30, "incrider");
			CT_RABoss_Schedule("CT_RABoss_Gothik_EventHandler", 3, "rider");
			CT_RABoss_Mods["Gothik"]["Riders"] = CT_RABoss_Mods["Gothik"]["Riders"] + 1;
		end

	elseif ( event == "rider" ) then
		CT_RABoss_VisualTimer.addTimer("GothikRider", 30, string.format(CT_RABOSS_GOTHIK_RIDERS, CT_RABoss_Mods["Gothik"]["Riders"]), nil, true);

	elseif ( event == "inc10" ) then
		CT_RABoss_Announce(format(CT_RABOSS_GOTHIK_SECWARN, "10"), CT_RABoss_Mods["Gothik"]["announce"]);
		CT_RABoss_PlaySound(3);

	end
end

--FourHorsemen
function CT_RABoss_FourHorsemen_OnLoad()
	CT_RABoss_AddMod("FourHorsemen", CT_RABOSS_FOURHORSEMEN_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddDropDownButton("FourHorsemen", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("FourHorsemen", { CT_RABOSS_FOURHORSEMEN_MARK_ALERT, CT_RABOSS_FOURHORSEMEN_MARK_INFO }, "CT_RABoss_ModInfo", "markAlert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("FourHorsemen", { CT_RABOSS_FOURHORSEMEN_ABILITY_ALERT, CT_RABOSS_FOURHORSEMEN_ABILITY_INFO }, "CT_RABoss_ModInfo", "abilityWarn", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("FourHorsemen", { CT_RABOSS_FOURHORSEMEN_DPSGROUP_ALERT, CT_RABOSS_FOURHORSEMEN_DPSGROUP_ALERT_INFO }, "CT_RABoss_ModInfo", "groupWarn", "CT_RABoss_SetInfo");

	CT_RABoss_AddEvent("FourHorsemen", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "CHAT_MSG_ADDON", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "PLAYER_REGEN_DISABLED", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "CHAT_MSG_COMBAT_HOSTILE_DEATH", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "RAID_ROSTER_UPDATE", CT_RABoss_FourHorsemen_EventHandler);
	CT_RABoss_AddEvent("FourHorsemen", "PLAYER_ENTERING_WORLD", CT_RABoss_FourHorsemen_EventHandler);
end

function CT_RABoss_FourHorsemen_Start()
	CT_RABoss_Announce(CT_RABOSS_FOURHORSEMEN_ENGAGE_WARN, CT_RABoss_Mods["FourHorsemen"]["announce"]);
	CT_RABoss_Mods["FourHorsemen"]["engaged"] = true;
	CT_RABoss_Mods["FourHorsemen"]["countMark"] = 1;
	CT_RABoss_Mods["FourHorsemen"]["tGroup"] = 5;
	CT_RABoss_Mods["FourHorsemen"]["mGroup"] = 4;
	CT_RABoss_Mods["FourHorsemen"]["tDead"] = false;
	CT_RABoss_Mods["FourHorsemen"]["mDead"] = false;
	CT_RABoss_Mods["FourHorsemen"]["markType"] = CT_RABOSS_FOURHORSEMEN_MARKTYPE2;
	CT_RABoss_VisualTimer.addTimer("HorsemenMark", 15, string.format(CT_RABOSS_FOURHORSEMEN_MARK_TIMER, CT_RABoss_Mods["FourHorsemen"]["countMark"]), "orange");
	if ( CT_RABoss_Mods["FourHorsemen"]["markAlert"] ) then
		CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 10, "mark5");
	end
	CT_RABoss_Mods["FourHorsemen"]["lastaction"] = GetTime();
	for i = 1, GetNumRaidMembers(), 1 do
		if ( UnitIsUnit("raid" .. i, "player") ) then
			local _, _, subgroup = GetRaidRosterInfo(i);
			CT_RABoss_Mods["FourHorsemen"]["Group"] = subgroup;
			break;
		end
	end
	for k,v in CT_RA_MainTanks do
		if ( v == UnitName("player") ) then
			CT_RABoss_Mods["FourHorsemen"]["isMT"] = true;
			break;
		end
	end
end

function CT_RABoss_FourHorsemen_Mark()
	if ( not CT_RABoss_Mods["FourHorsemen"]["countMark"] ) then
		CT_RABoss_FourHorsemen_Reset()
	end
	CT_RABoss_Mods["FourHorsemen"]["engaged"] = true;
	CT_RABoss_Announce(string.format(CT_RABOSS_FOURHORSEMEN_MARK_ANNOUNCE, CT_RABoss_Mods["FourHorsemen"]["countMark"]), CT_RABoss_Mods["FourHorsemen"]["announce"]);
	CT_RABoss_Mods["FourHorsemen"]["markTrip"] = true;

	if ( not CT_RABoss_Mods["FourHorsemen"]["tDead"] and mod(CT_RABoss_Mods["FourHorsemen"]["countMark"], 2) == 0 ) then
		if ( CT_RABoss_Mods["FourHorsemen"]["groupWarn"] ) then
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_Announce(string.format(CT_RABOSS_FOURHORSEMEN_DPSGROUP_THANE, CT_RABoss_Mods["FourHorsemen"]["tGroup"]), CT_RABoss_Mods["FourHorsemen"]["announce"]);
			end
			if ( CT_RABoss_Mods["FourHorsemen"]["tGroup"] ==  CT_RABoss_Mods["FourHorsemen"]["Group"] and not CT_RABoss_Mods["FourHorsemen"]["isMT"] ) then
				CT_RABoss_Announce(CT_RABOSS_FOURHORSEMEN_DPSGROUP_THANE_SELF);
				CT_RABoss_PlaySound(1);
			end
		end
		CT_RABoss_Mods["FourHorsemen"]["tGroup"] = CT_RABoss_Mods["FourHorsemen"]["tGroup"] + 1;
		if (CT_RABoss_Mods["FourHorsemen"]["tGroup"] > 8) then
			CT_RABoss_Mods["FourHorsemen"]["tGroup"] = 4;
		end
	end

	if ( not CT_RABoss_Mods["FourHorsemen"]["mDead"] ) then
		if ( mod(CT_RABoss_Mods["FourHorsemen"]["countMark"], 3) == 0 ) then
			if ( CT_RABoss_Mods["FourHorsemen"]["groupWarn"] ) then
				if ( CT_RA_Level >= 1 ) then
					CT_RABoss_Announce(string.format(CT_RABOSS_FOURHORSEMEN_DPSGROUP_MOGRAINE, CT_RABoss_Mods["FourHorsemen"]["mGroup"]), CT_RABoss_Mods["FourHorsemen"]["announce"]);
				end
				if ( CT_RABoss_Mods["FourHorsemen"]["mGroup"] ==  CT_RABoss_Mods["FourHorsemen"]["Group"] and not CT_RABoss_Mods["FourHorsemen"]["isMT"] ) then
					CT_RABoss_Announce(CT_RABOSS_FOURHORSEMEN_DPSGROUP_MOGRAINE_SELF);
					CT_RABoss_PlaySound(2);
				end
			end
			CT_RABoss_Mods["FourHorsemen"]["mGroup"] = CT_RABoss_Mods["FourHorsemen"]["mGroup"] + 1;
			if (CT_RABoss_Mods["FourHorsemen"]["mGroup"] > 8) then
				CT_RABoss_Mods["FourHorsemen"]["mGroup"] = 4;
			end
		elseif ( CT_RABoss_Mods["FourHorsemen"]["countMark"] > 3 and mod(CT_RABoss_Mods["FourHorsemen"]["countMark"], 3) == 1 ) then
			local round = floor(CT_RABoss_Mods["FourHorsemen"]["countMark"]/3);
			if ( mod(round, 4) == 0 or mod(round, 4) == 3 ) then
				if ( CT_RABoss_Mods["FourHorsemen"]["groupWarn"] ) then
					if ( CT_RA_Level >= 1 ) then
						CT_RABoss_Announce(string.format(CT_RABOSS_FOURHORSEMEN_DPSGROUP_MOGRAINE, CT_RABoss_Mods["FourHorsemen"]["mGroup"]), CT_RABoss_Mods["FourHorsemen"]["announce"]);
					end
					if ( CT_RABoss_Mods["FourHorsemen"]["mGroup"] ==  CT_RABoss_Mods["FourHorsemen"]["Group"] and not CT_RABoss_Mods["FourHorsemen"]["isMT"] ) then
						CT_RABoss_Announce(CT_RABOSS_FOURHORSEMEN_DPSGROUP_MOGRAINE_SELF);
						CT_RABoss_PlaySound(2);
					end
				end
				CT_RABoss_Mods["FourHorsemen"]["mGroup"] = CT_RABoss_Mods["FourHorsemen"]["mGroup"] + 1;
				if (CT_RABoss_Mods["FourHorsemen"]["mGroup"] > 8) then
					CT_RABoss_Mods["FourHorsemen"]["mGroup"] = 4;
				end
			end
		end
	end

	CT_RABoss_Mods["FourHorsemen"]["countMark"] = CT_RABoss_Mods["FourHorsemen"]["countMark"] + 1;
	CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 7, "unmark");
	CT_RABoss_VisualTimer.addTimer("HorsemenMark", 12, string.format(CT_RABOSS_FOURHORSEMEN_MARK_TIMER, CT_RABoss_Mods["FourHorsemen"]["countMark"]), "orange");
	if ( CT_RABoss_Mods["FourHorsemen"]["markAlert"] ) then
		CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 7, "mark5");
	end
	CT_RABoss_Mods["FourHorsemen"]["lastaction"] = GetTime();
end

function CT_RABoss_FourHorsemen_Reset()
	CT_RABoss_Mods["FourHorsemen"]["engaged"] = false;
	CT_RABoss_Mods["FourHorsemen"]["countMark"] = 1;
	CT_RABoss_Mods["FourHorsemen"]["tGroup"] = 5;
	CT_RABoss_Mods["FourHorsemen"]["mGroup"] = 4;
	CT_RABoss_Mods["FourHorsemen"]["tDead"] = false;
	CT_RABoss_Mods["FourHorsemen"]["mDead"] = false;
	CT_RABoss_Mods["FourHorsemen"]["markType"] = CT_RABOSS_FOURHORSEMEN_MARKTYPE2;
end

function CT_RABoss_FourHorsemen_EventHandler(event, param)
	if ( not CT_RABoss_Mods["FourHorsemen"] or not CT_RABoss_Mods["FourHorsemen"]["status"] or not CT_RABoss_Mods["FourHorsemen"].enabled ) then
		return;
	end

	if ( CT_RABoss_Mods["FourHorsemen"]["engaged"] and ( not CT_RABoss_Mods["FourHorsemen"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["FourHorsemen"]["lastaction"] ) > 90 ) ) then
		CT_RABoss_FourHorsemen_Reset();
	end

	if ( event == "PLAYER_REGEN_DISABLED" and not CT_RABoss_Mods["FourHorsemen"]["engaged"] ) then
		CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 3, "checkStart");

	elseif ( event == "checkStart" and not CT_RABoss_Mods["FourHorsemen"]["engaged"] ) then
		if ( UnitExists("target") and (UnitName("target") == CT_RABOSS_FOURHORSEMEN_THANE or UnitName("target") == CT_RABOSS_FOURHORSEMEN_LADY or UnitName("target") == CT_RABOSS_FOURHORSEMEN_MOGRAINE or UnitName("target") == CT_RABOSS_FOURHORSEMEN_ZELIEK) and UnitAffectingCombat("target") ) then
			CT_RABoss_FourHorsemen_Start();
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("HORSEMENSTARTSYNC");
			end
		end

	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		CT_RABoss_FourHorsemen_Reset();

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		if ( string.find(arg1, CT_RABOSS_FOURHORSEMEN_MARK_EXPR) and not CT_RABoss_Mods["FourHorsemen"]["markTrip"] ) then
			local _, _, markType = string.find(arg1, CT_RABOSS_FOURHORSEMEN_MARK_EXPR);
			if ( markType == CT_RABoss_Mods["FourHorsemen"]["markType"] ) then
				CT_RABoss_FourHorsemen_Mark();
				if ( CT_RA_Level >= 1 ) then
					CT_RABoss_SendMessage("HORSEMENMARKSYNC");
				end
			end
		end

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( string.find(arg1, CT_RABOSS_FOURHORSEMEN_SHIELDWALL_EXPR) ) then
			local _, _, sArg1 = string.find(arg1, CT_RABOSS_FOURHORSEMEN_SHIELDWALL_EXPR);
			CT_RABoss_Mods["FourHorsemen"][sArg1 .. "shieldwallTrip"] = true;
			CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 8, "unshieldwall", sArg1);
			CT_RABoss_Announce(string.format(CT_RABOSS_FOURHORSEMEN_SHIELDWALL_ANNOUNCE, sArg1), CT_RABoss_Mods["FourHorsemen"]["announce"]);
			CT_RABoss_VisualTimer.addTimer(sArg1 .. "ShieldWall" , 20, string.format(CT_RABOSS_FOURHORSEMEN_SHIELDWALL_TIMER, sArg1), "yellow" );
			if ( CT_RA_Level >= 1 ) then
				SendAddonMessage("HORSEMENSHIELDWALL", sArg1, "RAID");
			end
		end

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" ) then
		if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, CT_RABOSS_FOURHORSEMEN_VOID_EXPR) and not CT_RABoss_Mods["FourHorsemen"]["voidTrip"]) then
			if ( CT_RABoss_Mods["FourHorsemen"]["abilityWarn"] ) then
				CT_RABoss_Announce(CT_RABOSS_FOURHORSEMEN_VOID_ANNOUNCE, CT_RABoss_Mods["FourHorsemen"]["announce"]);
			end
			CT_RABoss_Mods["FourHorsemen"]["voidTrip"] = true;
			CT_RABoss_VisualTimer.addTimer("HorsemenVoid", 12, CT_RABOSS_FOURHORSEMEN_VOID_TIMER);
			CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 8, "unvoid");
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("HORSEMENVOIDSYNC");
			end
		elseif ( string.find(arg1, CT_RABOSS_FOURHORSEMEN_METEOR_EXPR) and not CT_RABoss_Mods["FourHorsemen"]["meteorTrip"] ) then
			if ( CT_RABoss_Mods["FourHorsemen"]["abilityWarn"] ) then
				CT_RABoss_Announce(CT_RABOSS_FOURHORSEMEN_METEOR_ANNOUNCE, CT_RABoss_Mods["FourHorsemen"]["announce"]);
			end
			CT_RABoss_Mods["FourHorsemen"]["meteorTrip"] = true;
			CT_RABoss_VisualTimer.addTimer("HorsemenMeteor", 12, CT_RABOSS_FOURHORSEMEN_METEOR_TIMER);
			CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 8, "unmeteor");
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("HORSEMENMETEORSYNC");
			end
		elseif ( string.find(arg1, CT_RABOSS_FOURHORSEMEN_HOLYWRATH_EXPR) and not CT_RABoss_Mods["FourHorsemen"]["wrathTrip"] ) then
			if ( CT_RABoss_Mods["FourHorsemen"]["abilityWarn"] ) then
				CT_RABoss_Announce(CT_RABOSS_FOURHORSEMEN_HOLYWRATH_ANNOUNCE, CT_RABoss_Mods["FourHorsemen"]["announce"]);
			end
			CT_RABoss_Mods["FourHorsemen"]["wrathTrip"] = true;
			CT_RABoss_VisualTimer.addTimer("HorsemenHolyWrath", 12, CT_RABOSS_FOURHORSEMEN_HOLYWRATH_TIMER);
			CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 8, "unwrath");
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("HORSEMENWRATHSYNC");
			end
		end

	elseif ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
		local _, _, sArg1 = string.find(arg1, CT_RABOSS_FOURHORSEMEN_DIE_EXP);
		if ( sArg1 == CT_RABOSS_FOURHORSEMEN_MOGRAINE ) then
			CT_RABoss_Mods["FourHorsemen"]["mDead"] = true;
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("MOGRAINEDIESYNC");
			end
		elseif ( sArg1 == CT_RABOSS_FOURHORSEMEN_THANE ) then
			CT_RABoss_Mods["FourHorsemen"]["tDead"] = true;
			CT_RABoss_Mods["FourHorsemen"]["markType"] = CT_RABOSS_FOURHORSEMEN_MARKTYPE3;
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("THANEDIESYNC");
			end
		elseif ( sArg1 == CT_RABOSS_FOURHORSEMEN_LADY ) then
			CT_RABoss_Mods["FourHorsemen"]["markType"] = CT_RABOSS_FOURHORSEMEN_MARKTYPE4;
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("LADYDIESYNC");
			end
		end

	elseif ( event == "RAID_ROSTER_UPDATE" ) then
		for i = 1, GetNumRaidMembers(), 1 do
			if ( UnitIsUnit("raid" .. i, "player") ) then
				local _, _, subgroup = GetRaidRosterInfo(i);
				CT_RABoss_Mods["FourHorsemen"]["Group"] = subgroup;
				break;
			end
		end

	elseif ( event == "mark5" and CT_RABoss_Mods["FourHorsemen"]["markAlert"] ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_FOURHORSEMEN_MARK_WARNING, CT_RABoss_Mods["FourHorsemen"]["countMark"]), CT_RABoss_Mods["FourHorsemen"]["announce"]);

	elseif ( event == "unmark" ) then
		CT_RABoss_Mods["FourHorsemen"]["markTrip"] = false;

	elseif ( event == "unvoid" ) then
		CT_RABoss_Mods["FourHorsemen"]["voidTrip"] = false;

	elseif ( event == "unmeteor" ) then
		CT_RABoss_Mods["FourHorsemen"]["meteorTrip"] = false;

	elseif ( event == "unwrath" ) then
		CT_RABoss_Mods["FourHorsemen"]["wrathTrip"] = false;

	elseif ( event == "unshieldwall" and param[1] ) then
		CT_RABoss_Mods["FourHorsemen"][param[1] .. "shieldwallTrip"] = false;

	elseif ( event == "CHAT_MSG_ADDON" and arg3 == "RAID" ) then
		if ( arg1 == "CTRA_BOSS" ) then
			if ( arg2 == "HORSEMENSTARTSYNC" and not CT_RABoss_Mods["FourHorsemen"]["engaged"] ) then
				CT_RABoss_FourHorsemen_Start();
			elseif ( arg2 == "HORSEMENMARKSYNC" and not CT_RABoss_Mods["FourHorsemen"]["markTrip"] ) then
				CT_RABoss_FourHorsemen_Mark();
			elseif ( arg2 == "HORSEMENVOIDSYNC" and not CT_RABoss_Mods["FourHorsemen"]["voidTrip"] ) then
				CT_RABoss_Mods["FourHorsemen"]["voidTrip"] = true;
				CT_RABoss_VisualTimer.addTimer("HorsemenVoid", 12, CT_RABOSS_FOURHORSEMEN_VOID_TIMER);
				CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 8, "unvoid");
			elseif ( arg2 == "HORSEMENMETEORSYNC" and not CT_RABoss_Mods["FourHorsemen"]["meteorTrip"] ) then
				CT_RABoss_Mods["FourHorsemen"]["meteorTrip"] = true;
				CT_RABoss_VisualTimer.addTimer("HorsemenMeteor", 12, CT_RABOSS_FOURHORSEMEN_METEOR_TIMER);
				CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 8, "unmeteor");
			elseif ( arg2 == "HORSEMENWRATHSYNC" and not CT_RABoss_Mods["FourHorsemen"]["wrathTrip"] ) then
				CT_RABoss_Mods["FourHorsemen"]["wrathTrip"] = true;
				CT_RABoss_VisualTimer.addTimer("HorsemenHolyWrath", 12, CT_RABOSS_FOURHORSEMEN_HOLYWRATH_TIMER);
				CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 8, "unwrath");
			elseif ( arg2 == "MOGRAINEDIESYNC" and not CT_RABoss_Mods["FourHorsemen"]["mDead"] ) then
				CT_RABoss_Mods["FourHorsemen"]["mDead"] = true;
			elseif ( arg2 == "THANEDIESYNC" and not CT_RABoss_Mods["FourHorsemen"]["tDead"] ) then
				CT_RABoss_Mods["FourHorsemen"]["tDead"] = true;
				CT_RABoss_Mods["FourHorsemen"]["markType"] = CT_RABOSS_FOURHORSEMEN_MARKTYPE3;
			elseif ( arg2 == "LADYDIESYNC" ) then
				CT_RABoss_Mods["FourHorsemen"]["markType"] = CT_RABOSS_FOURHORSEMEN_MARKTYPE4;
			end
		elseif ( arg1 == "HORSEMENSHIELDWALL" and arg2 and not CT_RABoss_Mods["FourHorsemen"][arg2 .. "shieldwallTrip"] ) then
			CT_RABoss_Mods["FourHorsemen"][arg2 .. "shieldwallTrip"] = true;
			CT_RABoss_Schedule("CT_RABoss_FourHorsemen_EventHandler", 8, "unshieldwall", arg2);
			CT_RABoss_Announce(string.format(CT_RABOSS_FOURHORSEMEN_SHIELDWALL_ANNOUNCE, arg2), CT_RABoss_Mods["FourHorsemen"]["announce"]);
			CT_RABoss_VisualTimer.addTimer(arg2 .. "ShieldWall" , 20, string.format(CT_RABOSS_FOURHORSEMEN_SHIELDWALL_TIMER, arg2), "yellow" );
		end
	end
end

-- Patchwerk - (04/08/2006) - Tweaked and added exit script.
function CT_RABoss_Patchwerk_OnLoad()
	CT_RABoss_AddMod("Patchwerk", CT_RABOSS_PATCHWERK_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Patchwerk", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Patchwerk_EventHandler);
	CT_RABoss_AddEvent("Patchwerk", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Patchwerk_EventHandler);
	CT_RABoss_AddEvent("Patchwerk", "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS", CT_RABoss_Patchwerk_EventHandler);
	CT_RABoss_AddEvent("Patchwerk", "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS", CT_RABoss_Patchwerk_EventHandler);
	CT_RABoss_AddEvent("Patchwerk", "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS", CT_RABoss_Patchwerk_EventHandler);

	CT_RABoss_AddDropDownButton("Patchwerk", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Patchwerk_EventHandler(event)
	if ( not CT_RABoss_Mods["Patchwerk"] or not CT_RABoss_Mods["Patchwerk"]["status"] or not CT_RABoss_Mods["Patchwerk"].enabled ) then
		return;
	end

	if ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( arg1 == CT_RABOSS_PATCHWERK_YELL1 or arg1 == CT_RABOSS_PATCHWERK_YELL2 ) then
			CT_RABoss_Announce(CT_RABOSS_PATCHWERK_ENGAGED, CT_RABoss_Mods["Patchwerk"]["announce"]);
			CT_RABoss_PlaySound(3);
			CT_RABoss_Schedule("CT_RABoss_Patchwerk_EventHandler", 30, "enragetimer");
			CT_RABoss_VisualTimer.addTimer("PatchwerkBerserk", 420, CT_RABOSS_PATCHWERK_BERSERK_TIMER);
			CT_RABoss_Mods["Patchwerk"]["enrageleft"] = 6.5;
			CT_RABoss_Mods["Patchwerk"]["lastaction"] = time();
		elseif ( arg1 == CT_RABOSS_PATCHWERK_DEAD ) then
			CT_RABoss_UnSchedule("CT_RABoss_Patchwerk_EventHandler");
			CT_RABoss_VisualTimer.removeTimer("PatchwerkBerserk");
		end

	elseif ( event == "enragetimer") then
		if ( not CT_RABoss_Mods["Patchwerk"]["lastaction"] or ( time() - CT_RABoss_Mods["Patchwerk"]["lastaction"] ) > 30 ) then
			return;
		elseif ( CT_RABoss_Mods["Patchwerk"]["enrageleft"] == 0.5 ) then
			CT_RABoss_Schedule("CT_RABoss_Patchwerk_EventHandler", 15, "enrage15");
			CT_RABoss_Schedule("CT_RABoss_Patchwerk_EventHandler", 25, "enrage5");
			CT_RABoss_Announce(format(CT_RABOSS_PATCHWERK_SECWARN, "30"), CT_RABoss_Mods["Patchwerk"]["announce"]);
			CT_RABoss_PlaySound(3);
		else
			if ( CT_RABoss_Mods["Patchwerk"]["enrageleft"] == 1 ) then
				CT_RABoss_Announce(CT_RABOSS_PATCHWERK_1MINWARN, CT_RABoss_Mods["Patchwerk"]["announce"]);
			else
				CT_RABoss_Announce(format(CT_RABOSS_PATCHWERK_MINWARN, CT_RABoss_Mods["Patchwerk"]["enrageleft"]));
			end
			CT_RABoss_Mods["Patchwerk"]["enrageleft"] = CT_RABoss_Mods["Patchwerk"]["enrageleft"]-0.5;
			CT_RABoss_Schedule("CT_RABoss_Patchwerk_EventHandler", 30, "enragetimer");
			CT_RABoss_PlaySound(3);
		end

	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and arg2 == CT_RABOSS_NAMES["Patchwerk"] ) then
		if ( arg1 == CT_RABOSS_PATCHWERK_ENRAGESTRING ) then
			CT_RABoss_Announce(CT_RABOSS_PATCHWERK_ENRAGEWARNING, CT_RABoss_Mods["Patchwerk"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Mods["Patchwerk"]["lastaction"] = time();
		end
		if ( arg1 == CT_RABOSS_PATCHWERK_BERSERKSTRING ) then
			CT_RABoss_Announce(CT_RABOSS_PATCHWERK_BERSERKWARNING, CT_RABoss_Mods["Patchwerk"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_UnSchedule("CT_RABoss_Patchwerk_EventHandler");
			CT_RABoss_Mods["Patchwerk"]["lastaction"] = time();
		end

	elseif ( event == "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS" or event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS" or event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" ) then
		if ( string.find(arg1, CT_RABOSS_NAMES["Patchwerk"]) ) then
			CT_RABoss_Mods["Patchwerk"]["lastaction"] = time();
		end

	elseif ( event == "enrage15" ) then
		CT_RABoss_Announce(format(CT_RABOSS_PATCHWERK_SECWARN, "15"), CT_RABoss_Mods["Patchwerk"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "enrage5" ) then
		CT_RABoss_Announce(format(CT_RABOSS_PATCHWERK_SECWARN, "5"), CT_RABoss_Mods["Patchwerk"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end

-- Grobbulus - (02/08/2006) - Added raid icon marking.
function CT_RABoss_Grobbulus_OnLoad()
	CT_RABoss_AddMod("Grobbulus", CT_RABOSS_GROBBULUS_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Grobbulus", "PLAYER_REGEN_DISABLED", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_ADDON", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Grobbulus_EventHandler);
	CT_RABoss_AddEvent("Grobbulus", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Grobbulus_EventHandler);

	CT_RABoss_AddDropDownButton("Grobbulus", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Grobbulus", { CT_RABOSS_GROBBULUS_ALERT, CT_RABOSS_GROBBULUS_ALERT_INFO }, "CT_RABoss_ModInfo", "alertnearby", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Grobbulus", { CT_RABOSS_GROBBULUS_TELL, CT_RABOSS_GROBBULUS_TELL_INFO }, "CT_RABoss_ModInfo", "sendtell", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Grobbulus", { CT_RABOSS_GROBBULUS_BSLIME, CT_RABOSS_GROBBULUS_BSLIME_INFO }, "CT_RABoss_ModInfo", "bombardslime", "CT_RABoss_SetInfo");

	CT_RABoss_SetVar("Grobbulus", "alertnearby", 1);
end

function CT_RABoss_Grobbulus_EventHandler(event, param)
	if ( not CT_RABoss_Mods["Grobbulus"] or not CT_RABoss_Mods["Grobbulus"]["status"] or not CT_RABoss_Mods["Grobbulus"].enabled ) then
		return;
	end

	if ( CT_RABoss_Mods["Grobbulus"]["engaged"] and ( not CT_RABoss_Mods["Grobbulus"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["Grobbulus"]["lastaction"] ) > 90 ) ) then
		CT_RABoss_Mods["Grobbulus"]["engaged"] = nil;
	end

	if ( event == "PLAYER_REGEN_DISABLED" and not CT_RABoss_Mods["Grobbulus"]["engaged"] ) then
		CT_RABoss_Schedule("CT_RABoss_Grobbulus_EventHandler", 3, "checkStart");

	elseif ( event == "checkStart" and not CT_RABoss_Mods["Grobbulus"]["engaged"] ) then
		if ( UnitExists("target") and UnitName("target") == CT_RABOSS_NAMES["Grobbulus"] and UnitAffectingCombat("target") ) then
			CT_RABoss_Mods["Grobbulus"]["engaged"] = true;
			CT_RABoss_Announce(CT_RABOSS_GROBBULUS_ENGAGED, CT_RABoss_Mods["Grobbulus"]["announce"]);
			CT_RABoss_Schedule("CT_RABoss_Grobbulus_EventHandler", 17, "sspray5sec");
			CT_RABoss_VisualTimer.addTimer("GrobbulusSSpray", 22, CT_RABOSS_GROBBULUS_SSPRAY_TIMER);
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("GROBBULUSSTARTSYNC");
			end
			CT_RABoss_Mods["Grobbulus"]["lastaction"] = GetTime();
		end

	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA_BOSS" and arg3 == "RAID" ) then
		if ( arg2 == "GROBBULUSSTARTSYNC" and not CT_RABoss_Mods["Grobbulus"]["engaged"] ) then
			CT_RABoss_Mods["Grobbulus"]["engaged"] = true;
			CT_RABoss_Schedule("CT_RABoss_Grobbulus_EventHandler", 17, "sspray5sec");
			CT_RABoss_VisualTimer.removeTimer("GrobbulusBSlime");
			CT_RABoss_VisualTimer.addTimer("GrobbulusSSpray", 22, CT_RABOSS_GROBBULUS_SSPRAY_TIMER);
			CT_RABoss_Mods["Grobbulus"]["lastaction"] = GetTime();
		elseif ( arg2 == "GROBBULUSSSPRAYSYNC" and not CT_RABoss_Mods["Grobbulus"]["SSprayTrip"] ) then
			CT_RABoss_Mods["Grobbulus"]["SSprayTrip"] = true;
			CT_RABoss_Announce(CT_RABOSS_GROBBULUS_SSPRAY_WARN);
			CT_RABoss_Schedule("CT_RABoss_Grobbulus_EventHandler", 27, "sspray5sec");
			CT_RABoss_VisualTimer.addTimer("GrobbulusSSpray", 32, CT_RABOSS_GROBBULUS_SSPRAY_TIMER);
			CT_RABoss_Mods["Grobbulus"]["lastaction"] = GetTime();
		elseif ( arg2 == "GROBBULUSBSLIMESYNC" and CT_RABoss_Mods["Grobbulus"]["bombardslime"] and not CT_RABoss_Mods["Grobbulus"]["BSlimeTrip"] ) then
			CT_RABoss_Mods["Grobbulus"]["BSlimeTrip"] = true;
			CT_RABoss_VisualTimer.addTimer("GrobbulusBSlime", 240, CT_RABOSS_GROBBULUS_BSLIME_TIMER, "orange");
			CT_RABoss_Schedule("CT_RABoss_Grobbulus_EventHandler", 20, "unbslime");
		end

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or  event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" ) then
		if ( not CT_RABoss_Mods["Grobbulus"]["SSprayTrip"] and string.find(arg1, CT_RABOSS_GROBBULUS_SSPRAY_DETECT) ) then
			CT_RABoss_Mods["Grobbulus"]["SSprayTrip"] = true;
			CT_RABoss_Announce(CT_RABOSS_GROBBULUS_SSPRAY_WARN, CT_RABoss_Mods["Grobbulus"]["announce"]);
			CT_RABoss_Schedule("CT_RABoss_Grobbulus_EventHandler", 27, "sspray5sec");
			CT_RABoss_VisualTimer.addTimer("GrobbulusSSpray", 32, CT_RABOSS_GROBBULUS_SSPRAY_TIMER);
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("GROBBULUSSSPRAYSYNC");
			end
			CT_RABoss_Mods["Grobbulus"]["lastaction"] = GetTime();
		end

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or ( ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) and CT_RABoss_Mods["Grobbulus"]["alertnearby"] ) ) then
		local _, _, playername = string.find(arg1, CT_RABOSS_GROBBULUS_MIEXP);
		if ( playername ) then
			CT_RABoss_Mods["Grobbulus"]["lastaction"] = GetTime();
			if ( playername == CT_RABOSS_SELF1 ) then
				playername = UnitName("player");
				CT_RABoss_Announce(CT_RABOSS_GROBBULUS_AFFLICTED_YOU);
				CT_RABoss_Announce(CT_RABOSS_GROBBULUS_AFFLICTED_YOU);
				CT_RABoss_PlaySound(2);
			elseif ( CT_RABoss_Mods["Grobbulus"]["alertnearby"] or CT_RABoss_Mods["Grobbulus"]["sendtell"] ) then
				if ( CT_RABoss_Mods["Grobbulus"]["sendtell"] ) then
					SendChatMessage(CT_RABOSS_GROBBULUS_AFFLICTED_YOU, "WHISPER", nil, playername);
				end
				if ( CT_RABoss_Mods["Grobbulus"]["alertnearby"] ) then
					CT_RABoss_Announce(format(CT_RABOSS_GROBBULUS_AFFLICTED, playername));
					CT_RABoss_PlaySound(3);
				end
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Grobbulus"]["announce"] ) then
					SendChatMessage(format(CT_RABOSS_GROBBULUS_AFFLICTED, playername), "RAID_WARNING");
					local i;
					for i = 1, GetNumRaidMembers(), 1 do
						if UnitName("raid"..i) == playername then
							SetRaidTarget("raid"..i, 8);
							break;
						end
					end
					CT_RABoss_Schedule("CT_RABoss_Grobbulus_EventHandler", 10, "clearIcon", playername);
				end
			end
		end

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) then
		if ( not CT_RABoss_Mods["Grobbulus"]["BSlimeTrip"] and string.find(arg1, CT_RABOSS_GROBBULUS_BSLIME_DETECT) and CT_RABoss_Mods["Grobbulus"]["bombardslime"] ) then
			CT_RABoss_Mods["Grobbulus"]["BSlimeTrip"] = true;
			CT_RABoss_VisualTimer.addTimer("GrobbulusBSlime", 240, CT_RABOSS_GROBBULUS_BSLIME_TIMER, "orange");
			CT_RABoss_Schedule("CT_RABoss_Grobbulus_EventHandler", 20, "unbslime");
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("GROBBULUSBSLIMESYNC");
			end
		elseif ( string.find(arg1, CT_RABOSS_GROBBULUS_POISON_CLOUD_DETECT) ) then
			CT_RABoss_VisualTimer.addTimer("GrobbulusCloud", 15, CT_RABOSS_GROBBULUS_POISON_CLOUD_TIMER, "orange");
		end

	elseif ( event == "unbslime" ) then
		CT_RABoss_Mods["Grobbulus"]["BSlimeTrip"] = false;

	elseif ( event == "sspray5sec" ) then
		CT_RABoss_Mods["Grobbulus"]["SSprayTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_GROBBULUS_SSPRAY_5SEC, CT_RABoss_Mods["Grobbulus"]["announce"]);

	elseif ( event == "clearIcon" and param[1] and CT_RA_Level >= 1 ) then
		local i;
		for i = 1, GetNumRaidMembers(), 1 do
			if UnitName("raid"..i) == param[1] then
				SetRaidTarget("raid"..i, 0);
				break;
			end
		end
	end
end

-- Gluth - (04/08/2006)
function CT_RABoss_Gluth_OnLoad()
	CT_RABoss_AddMod("Gluth", CT_RABOSS_GLUTH_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "PLAYER_REGEN_DISABLED", CT_RABoss_Gluth_EventHandler);
	CT_RABoss_AddEvent("Gluth", "CHAT_MSG_ADDON", CT_RABoss_Gluth_EventHandler);

	CT_RABoss_AddDropDownButton("Gluth", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Gluth", { CT_RABOSS_GLUTH_FRENZY_ALERT, CT_RABOSS_GLUTH_FRENZY_ALERT_INFO }, "CT_RABoss_ModInfo", "frenzyalert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Gluth", { CT_RABOSS_GLUTH_FEAR_ALERT, CT_RABOSS_GLUTH_FEAR_ALERT_INFO }, "CT_RABoss_ModInfo", "fearalert", "CT_RABoss_SetInfo");

	CT_RABoss_SetVar("Gluth", "frenzyalert", 1);
	CT_RABoss_SetVar("Gluth", "fearalert", 1);
end

function CT_RABoss_Gluth_Start()
	CT_RABoss_Announce(CT_RABOSS_GLUTH_ENGAGED, CT_RABoss_Mods["Gluth"]["announce"]);
	CT_RABoss_PlaySound(3);
	CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 100, "decimatewarn");
	CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 8, "prefear");
	CT_RABoss_Mods["Gluth"]["lastaction"] = GetTime();
	CT_RABoss_Mods["Gluth"]["engaged"] = true;
	CT_RABoss_VisualTimer.addTimer("GluthDecimate", 100, CT_RABOSS_GLUTH_DECIMATE_TIMER);
	CT_RABoss_VisualTimer.addTimer("GluthFear", 13, CT_RABOSS_GLUTH_FEAR_TIMER);
end

function CT_RABoss_Gluth_EventHandler(event)
	if ( not CT_RABoss_Mods["Gluth"] or not CT_RABoss_Mods["Gluth"]["status"] or not CT_RABoss_Mods["Gluth"].enabled ) then
		return;
	end

	if ( CT_RABoss_Mods["Gluth"]["engaged"] and ( not CT_RABoss_Mods["Gluth"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["Gluth"]["lastaction"] ) > 60 ) ) then
		CT_RABoss_Mods["Gluth"]["engaged"] = false;
	end

	if ( event == "CHAT_MSG_MONSTER_EMOTE" and arg2 == CT_RABOSS_NAMES["Gluth"] ) then
		CT_RABoss_Mods["Gluth"]["lastaction"] = GetTime();
		if ( arg1 == CT_RABOSS_GLUTH_FRENZYSTRING and CT_RABoss_Mods["Gluth"]["frenzyalert"] ) then
			CT_RABoss_Announce(CT_RABOSS_GLUTH_FRENZYWARNING, CT_RABoss_Mods["Gluth"]["announce"]);
			CT_RABoss_PlaySound(2);
		elseif ( arg1 == CT_RABOSS_GLUTH_DEVOURSTRING ) then
			CT_RABoss_VisualTimer.updateTimer("GluthDecimate", "+5");
			CT_RABoss_UnSchedule("CT_RABoss_Gluth_EventHandler", "decimatewarn");
			CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", CT_RABoss_VisualTimer.getTimerCurrent("GluthDecimate") , "decimatewarn");
		end

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" ) then
		if ( string.find(arg1, CT_RABOSS_GLUTH_DECIMATESTRING) and not CT_RABoss_Mods["Gluth"]["decimated"] ) then
			CT_RABoss_Mods["Gluth"]["decimated"] = true;
			CT_RABoss_Announce(CT_RABOSS_GLUTH_DECIMATEWARNING, CT_RABoss_Mods["Gluth"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 105, "decimatewarn");
			CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 5, "undecimate");
			CT_RABoss_Mods["Gluth"]["lastaction"] = GetTime();
			CT_RABoss_VisualTimer.addTimer("GluthDecimate", 105, CT_RABOSS_GLUTH_DECIMATE_TIMER);
		end

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		if ( string.find(arg1, CT_RABOSS_GLUTH_FEARSTRING) and CT_RABoss_Mods["Gluth"]["fearalert"] and not CT_RABoss_Mods["Gluth"]["feartrip"] ) then
			CT_RABoss_Mods["Gluth"]["feartrip"] = true;
			CT_RABoss_Announce(CT_RABOSS_GLUTH_FEARWARNING, CT_RABoss_Mods["Gluth"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 15, "prefear");
			CT_RABoss_Mods["Gluth"]["lastaction"] = GetTime();
			CT_RABoss_VisualTimer.addTimer("GluthFear", 20, CT_RABOSS_GLUTH_FEAR_TIMER);
		end

	elseif ( event == "PLAYER_REGEN_DISABLED" and not CT_RABoss_Mods["Gluth"]["engaged"] ) then
		if ( not CT_RABoss_Mods["Gluth"]["engaged"] ) then
			CT_RABoss_Schedule("CT_RABoss_Gluth_EventHandler", 5, "engagecheck");
		end

	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA_BOSS" and arg3 == "RAID" ) then
		if ( arg2 == "GLUTHSTARTSYNC" and not CT_RABoss_Mods["Gluth"]["engaged"] ) then
			CT_RABoss_Gluth_Start();
		end

	elseif ( event == "engagecheck" and not CT_RABoss_Mods["Gluth"]["engaged"] ) then
		if ( UnitExists("target") and UnitName("target") == CT_RABOSS_NAMES["Gluth"] and UnitAffectingCombat("target") ) then
			CT_RABoss_Gluth_Start();
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("GLUTHSTARTSYNC");
			end
		end

	elseif ( event == "undecimate" ) then
		CT_RABoss_Mods["Gluth"]["decimated"] = false;

	elseif ( event == "decimatewarn" ) then
		CT_RABoss_Announce(CT_RABOSS_GLUTH_DECIMATESOON, CT_RABoss_Mods["Gluth"]["announce"]);
		CT_RABoss_PlaySound(2);

	elseif ( event == "prefear" ) then
		CT_RABoss_Mods["Gluth"]["feartrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_GLUTH_FEAR5SEC, CT_RABoss_Mods["Gluth"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end


-- Thaddius -
function CT_RABoss_Thaddius_OnLoad()
	CT_RABoss_AddMod("Thaddius", CT_RABOSS_THADDIUS_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "PLAYER_AURAS_CHANGED", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_PARTY_DAMAGE", CT_RABoss_Thaddius_EventHandler);
	CT_RABoss_AddEvent("Thaddius", "CHAT_MSG_SPELL_SELF_DAMAGE", CT_RABoss_Thaddius_EventHandler);

	CT_RABoss_AddDropDownButton("Thaddius", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Thaddius", { CT_RABOSS_THADDIUS_SURGE_ALERT, CT_RABOSS_THADDIUS_SURGE_ALERT_INFO }, "CT_RABoss_ModInfo", "surgealert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Thaddius", { CT_RABOSS_THADDIUS_MOVE_ALERT, CT_RABOSS_THADDIUS_MOVE_ALERT_INFO }, "CT_RABoss_ModInfo", "movealert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Thaddius", { CT_RABOSS_THADDIUS_PVPDAMAGE_REPORT, CT_RABOSS_THADDIUS_PVPDAMAGE_REPORT_INFO }, "CT_RABoss_ModInfo", "pvpdamagereport", "CT_RABoss_SetInfo");

	CT_RABoss_Thaddius_PVPDamageCount = { };
end

function CT_RABoss_Thaddius_EventHandler(event)
	if ( not CT_RABoss_Mods["Thaddius"] or not CT_RABoss_Mods["Thaddius"]["status"] or not CT_RABoss_Mods["Thaddius"].enabled ) then
		return;
	end

	if CT_RABoss_Mods["Thaddius"]["pvpdamagereport"] and ( (event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE") or (event == "CHAT_MSG_SPELL_PARTY_DAMAGE") or (event == "CHAT_MSG_SPELL_SELF_DAMAGE") ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_THADDIUS_PVPDAMAGE_DETECT);
		if sPlayer then
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				sPlayer = UnitName("player");
			end
			
			CT_RABoss_Thaddius_PVPDamageCount[sPlayer] = ( tonumber(CT_RABoss_Thaddius_PVPDamageCount[sPlayer]) or 0 ) + 1;
		end
	end

	if ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( arg1 == CT_RABOSS_THADDIUS_PHASE1_YELL1 or arg1 == CT_RABOSS_THADDIUS_PHASE1_YELL2 ) then
			if ( not CT_RABoss_Mods["Thaddius"]["firstyell"] ) then
				CT_RABoss_Announce(CT_RABOSS_THADDIUS_PHASE1, CT_RABoss_Mods["Thaddius"]["announce"]);
				CT_RABoss_PlaySound(3);
				CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 15, "throw5");
				CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 20, "throw");
				CT_RABoss_VisualTimer.addTimer("ThaddiusThrow", 20, CT_RABOSS_THADDIUS_THROWMSG_TIMER);
				CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 5, "yellreset");
				CT_RABoss_Mods["Thaddius"]["firstyell"] = true;
				CT_RABoss_Mods["Thaddius"]["lastaction"] = GetTime();
			end

		elseif ( arg1 == CT_RABOSS_THADDIUS_PHASE2_YELL1 or arg1 == CT_RABOSS_THADDIUS_PHASE2_YELL2 or arg1 == CT_RABOSS_THADDIUS_PHASE2_YELL3 ) then
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_PHASE2, CT_RABoss_Mods["Thaddius"]["announce"]);
			CT_RABoss_PlaySound(3);
			CT_RABoss_UnSchedule("CT_RABoss_Thaddius_EventHandler", "throw5");
			CT_RABoss_UnSchedule("CT_RABoss_Thaddius_EventHandler", "throw");
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 30, "enragetimer");
			CT_RABoss_VisualTimer.addTimer("ThaddiusBerserk", 300, CT_RABOSS_THADDIUS_BERSERKSTRING_TIMER);
			CT_RABoss_Mods["Thaddius"]["enrageleft"] = 4.5;
			CT_RABoss_Mods["Thaddius"]["lastaction"] = GetTime();

			CT_RABoss_Mods["Thaddius"]["position"] = 1;

		elseif ( arg1 == CT_RABOSS_THADDIUS_DEAD ) then
			CT_RABoss_UnSchedule("CT_RABoss_Thaddius_EventHandler");
			CT_RABoss_VisualTimer.removeTimer("ThaddiusBerserk");
			CT_ThaddiusLeftFrame:Hide();
			CT_ThaddiusRightFrame:Hide();
		end

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" ) then
		if ( string.find(arg1, CT_RABOSS_THADDIUS_SURGESTRING) and CT_RABoss_Mods["Thaddius"]["surgealert"] ) then
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_SURGE, CT_RABoss_Mods["Thaddius"]["announce"]);
			CT_RABoss_PlaySound(2);
			CT_RABoss_Mods["Thaddius"]["lastaction"] = GetTime();
		end

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) then
		if ( string.find(arg1, CT_RABOSS_THADDIUS_POLARITYSTRING) ) then
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_POLARITYWARN, CT_RABoss_Mods["Thaddius"]["announce"]);
			CT_RABoss_PlaySound(3);
			CT_RABoss_Mods["Thaddius"]["lastaction"] = GetTime();

		elseif ( string.find(arg1, CT_RABOSS_THADDIUS_SHIFTSTRING) ) then
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_SHIFTWARN, CT_RABoss_Mods["Thaddius"]["announce"]);
			CT_RABoss_PlaySound(1);
			CT_RABoss_Mods["Thaddius"]["lastaction"] = GetTime();
			CT_RABoss_Mods["Thaddius"]["debuffcheck"] = true;
			CT_RABoss_VisualTimer.addTimer("ThaddiusPolarity", 30, CT_RABOSS_THADDIUS_POLARITY_TIMER, "orange");

			if CT_RABoss_Mods["Thaddius"]["pvpdamagereport"] then
				CT_RABoss_Thaddius_PVPDamageCount = { };
				CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 10, "pvpdamagereport");
			end
		end

	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and arg2 == CT_RABOSS_NAMES["Thaddius"] ) then
		if ( arg1 == CT_RABOSS_THADDIUS_BERSERKSTRING ) then
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_BERSERKWARNING, CT_RABoss_Mods["Thaddius"]["announce"]);
			CT_RABoss_PlaySound(1);
			CT_RABoss_UnSchedule("CT_RABoss_Thaddius_EventHandler", "enragetimer");
			CT_RABoss_UnSchedule("CT_RABoss_Thaddius_EventHandler", "enrage15");
			CT_RABoss_UnSchedule("CT_RABoss_Thaddius_EventHandler", "enrage5");
			CT_RABoss_Mods["Thaddius"]["lastaction"] = GetTime();
		end

	elseif ( event == "PLAYER_AURAS_CHANGED" and CT_RABoss_Mods["Thaddius"]["debuffcheck"] ) then
		local i = 1;
		local charge = nil;
		local t,a = UnitDebuff("player", i);
		while t do
			if ( t == CT_RABOSS_THADDIUS_POSITIVE or t == CT_RABOSS_THADDIUS_NEGATIVE ) then
				if ( a > 1 ) then
					return;
				end

				charge = t;
			end
			i = i + 1;
			t,a = UnitDebuff("player", i);
		end

		if ( charge == nil ) then
			return;
		elseif ( charge ) then
			CT_RABoss_Mods["Thaddius"]["debuffcheck"] = false;
			local dir = "";
			if ( charge == CT_RABOSS_THADDIUS_POSITIVE ) then
				CT_RABoss_Announce(CT_RABOSS_THADDIUS_POSITIVEWARN);
				if ( CT_RABoss_Mods["Thaddius"]["position"] == 1 ) then
					dir = "left";
					CT_RABoss_Mods["Thaddius"]["position"] = 3;
				elseif ( CT_RABoss_Mods["Thaddius"]["position"] == 3 ) then
					dir = "right";
					CT_RABoss_Mods["Thaddius"]["position"] = 1;
				elseif ( CT_RABoss_Mods["Thaddius"]["position"] == 2 ) then
					dir = "left";
					CT_RABoss_Mods["Thaddius"]["position"] = 1;
				elseif ( CT_RABoss_Mods["Thaddius"]["position"] == 4 ) then
					dir = "right";
					CT_RABoss_Mods["Thaddius"]["position"] = 3;
				end
			elseif ( charge == CT_RABOSS_THADDIUS_NEGATIVE ) then
				CT_RABoss_Announce(CT_RABOSS_THADDIUS_NEGATIVEWARN);
				if ( CT_RABoss_Mods["Thaddius"]["position"] == 1 ) then
					dir = "right";
					CT_RABoss_Mods["Thaddius"]["position"] = 2;
				elseif ( CT_RABoss_Mods["Thaddius"]["position"] == 3 ) then
					dir = "left";
					CT_RABoss_Mods["Thaddius"]["position"] = 4;
				elseif ( CT_RABoss_Mods["Thaddius"]["position"] == 2 ) then
					dir = "right";
					CT_RABoss_Mods["Thaddius"]["position"] = 4;
				elseif ( CT_RABoss_Mods["Thaddius"]["position"] == 4 ) then
					dir = "left";
					CT_RABoss_Mods["Thaddius"]["position"] = 2;
				end
			end
			if ( not CT_RABoss_Mods["Thaddius"]["movealert"] ) then
				return;
			end
			if ( dir == "left" ) then
				CT_ThaddiusMsgFrame:AddMessage(CT_RABOSS_THADDIUS_LEFTWARN, 1.0, 0.0, 0.0);
				CT_ThaddiusLeftFrame:Show();
			elseif ( dir == "right" ) then
				CT_ThaddiusMsgFrame:AddMessage(CT_RABOSS_THADDIUS_RIGHTWARN, 1.0, 0.0, 0.0);
				CT_ThaddiusRightFrame:Show();
			end
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 6, "hideArrow");
		end

	elseif ( event == "hideArrow" ) then
		CT_ThaddiusLeftFrame:Hide();
		CT_ThaddiusRightFrame:Hide();
		CT_ThaddiusLeftTexture:SetVertexColor(0,1,0);
		CT_ThaddiusRightTexture:SetVertexColor(0,1,0);

	elseif ( event == "enragetimer") then
		if ( not CT_RABoss_Mods["Thaddius"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["Thaddius"]["lastaction"] ) > 60 ) then
			return;

		elseif ( CT_RABoss_Mods["Thaddius"]["enrageleft"] == 0.5 ) then
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 15, "enrage15");
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 25, "enrage5");
			CT_RABoss_Announce(format(CT_RABOSS_THADDIUS_SECWARN, "30"), CT_RABoss_Mods["Thaddius"]["announce"]);
			CT_RABoss_PlaySound(3);
		else
			if ( CT_RABoss_Mods["Thaddius"]["enrageleft"] == 1 ) then
				CT_RABoss_Announce(CT_RABOSS_THADDIUS_1MINWARN, CT_RABoss_Mods["Thaddius"]["announce"]);
			else
				CT_RABoss_Announce(format(CT_RABOSS_THADDIUS_WARN, CT_RABoss_Mods["Thaddius"]["enrageleft"]), CT_RABoss_Mods["Thaddius"]["announce"]);
			end

			CT_RABoss_Mods["Thaddius"]["enrageleft"] = CT_RABoss_Mods["Thaddius"]["enrageleft"]-0.5;
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 30, "enragetimer");
			CT_RABoss_PlaySound(3);
		end

	elseif ( event == "throw5" ) then
		CT_RABoss_Announce(CT_RABOSS_THADDIUS_THROWMSG5, CT_RABoss_Mods["Thaddius"]["announce"]);

	elseif ( event == "throw" ) then
		if ( not CT_RABoss_Mods["Thaddius"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["Thaddius"]["lastaction"] ) > 60 ) then
			return;
		else
			CT_RABoss_Announce(CT_RABOSS_THADDIUS_THROWMSG, CT_RABoss_Mods["Thaddius"]["announce"]);
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 16, "throw5");
			CT_RABoss_Schedule("CT_RABoss_Thaddius_EventHandler", 21, "throw");
			CT_RABoss_VisualTimer.addTimer("ThaddiusThrow", 21, CT_RABOSS_THADDIUS_THROWMSG_TIMER);
		end

	elseif ( event == "yellreset" ) then
		CT_RABoss_Mods["Thaddius"]["firstyell"] = false;

	elseif ( event == "enrage15" ) then
		CT_RABoss_Announce(format(CT_RABOSS_THADDIUS_SECWARN, "15"), CT_RABoss_Mods["Thaddius"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "enrage5" ) then
		CT_RABoss_Announce(format(CT_RABOSS_THADDIUS_SECWARN, "5"), CT_RABoss_Mods["Thaddius"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "pvpdamagereport" ) then
		local i, sPlayer;
		for i = 1, GetNumRaidMembers(), 1 do
			sPlayer = UnitName("raid" .. i);
			if sPlayer then
        			if ( (CT_RABoss_Thaddius_PVPDamageCount[sPlayer] or 0) >= 3 ) then
			        	CT_RABoss_Announce(format(CT_RABOSS_THADDIUS_PVPDAMAGE_MSG, sPlayer, CT_RABoss_Thaddius_PVPDamageCount[sPlayer]), CT_RABoss_Mods["Thaddius"]["announce"]);
					CT_RABoss_PlaySound(3);
				end
			end
		end

	end
end


--Sapphiron
function CT_RABoss_Sapphiron_OnLoad()
	CT_RABoss_AddMod("Sapphiron", CT_RABOSS_SAPPHIRON_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Sapphiron", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Sapphiron_EventHandler);
	CT_RABoss_AddEvent("Sapphiron", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Sapphiron_EventHandler);
	CT_RABoss_AddEvent("Sapphiron", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Sapphiron_EventHandler);
	CT_RABoss_AddEvent("Sapphiron", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Sapphiron_EventHandler);
	CT_RABoss_AddEvent("Sapphiron", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Sapphiron_EventHandler);
	CT_RABoss_AddEvent("Sapphiron", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_Sapphiron_EventHandler);
	CT_RABoss_AddEvent("Sapphiron", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Sapphiron_EventHandler);
	CT_RABoss_AddEvent("Sapphiron", "CHAT_MSG_SPELL_AURA_GONE_SELF", CT_RABoss_Sapphiron_EventHandler);
	CT_RABoss_AddEvent("Sapphiron", "CHAT_MSG_ADDON", CT_RABoss_Sapphiron_EventHandler);

	CT_RABoss_AddDropDownButton("Sapphiron", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Sapphiron", { CT_RABOSS_SAPPHIRON_RANGECHECK, CT_RABOSS_SAPPHIRON_RANGECHECK }, "CT_RABoss_ModInfo", "rangeCheck", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Sapphiron", { CT_RABOSS_SAPPHIRON_LIFEDRAIN_ALERT, CT_RABOSS_SAPPHIRON_LIFEDRAIN_ALERT_INFO }, "CT_RABoss_ModInfo", "drainAlert", "CT_RABoss_SetInfo");
end

function CT_RABoss_Sapphiron_Start()
	CT_RABoss_Announce(CT_RABOSS_SAPPHIRON_ENGAGE_ANNOUNCE, CT_RABoss_Mods["Sapphiron"]["announce"]);
	CT_RABoss_Mods["Sapphiron"]["engaged"] = true;
	CT_RABoss_VisualTimer.addTimer("SapphironEnrage", 898, CT_RABOSS_SAPPHIRON_ENRAGE_TIMER, "orange");
	CT_RABoss_VisualTimer.addTimer("SapphironFly", 32, CT_RABOSS_SAPPHIRON_FLY_TIMER);
	CT_RABoss_Schedule("CT_RABoss_Sapphiron_EventHandler", 807, "enrageWarn", 90);
	CT_RABoss_Schedule("CT_RABoss_Sapphiron_EventHandler", 867, "enrageWarn", 30);
	CT_RABoss_Mods["Sapphiron"]["lastaction"] = GetTime();
	if ( CT_RABoss_Mods["Sapphiron"]["rangeCheck"] ) then
		CT_RABoss_RangeCheck.Enable();
	end
end

function CT_RABoss_Sapphiron_Reset()
	CT_RABoss_UnSchedule("CT_RABoss_Sapphiron_EventHandler");
	CT_RABoss_VisualTimer.removeTimer("SapphironEnrage");
	CT_RABoss_VisualTimer.removeTimer("SapphironFly");
	CT_RABoss_VisualTimer.removeTimer("SapphironLifeDrain");
	CT_RABoss_VisualTimer.removeTimer("SapphironFrostBreath");
	CT_RABoss_Mods["Sapphiron"]["drainTrip"] = false;
	CT_RABoss_Mods["Sapphiron"]["engaged"] = false;
	CT_RABoss_Mods["Sapphiron"]["pingMiniMap"] = false;
	CT_RABoss_Mods["Sapphiron"]["frostBreathTrip"] = false;
end

function CT_RABoss_Sapphiron_EventHandler(event, param)
	if ( not CT_RABoss_Mods["Sapphiron"] or not CT_RABoss_Mods["Sapphiron"]["status"] or not CT_RABoss_Mods["Sapphiron"].enabled ) then
		return;
	end

	if ( CT_RABoss_Mods["Sapphiron"]["engaged"] and ( not CT_RABoss_Mods["Sapphiron"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["Sapphiron"]["lastaction"] ) > 30 ) ) then
		CT_RABoss_Sapphiron_Reset();
	end

	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		if (string.find(arg1, CT_RABOSS_SAPPHIRON_ENGAGE_DETECT) and not CT_RABoss_Mods["Sapphiron"]["engaged"]) then
			CT_RABoss_Sapphiron_Start();

		elseif ( CT_RABoss_Mods["Sapphiron"]["engaged"] and string.find(arg1, CT_RABOSS_SAPPHIRON_FROSTBOLT_GAIN_EXPR) ) then
			SendChatMessage(CT_RABOSS_SAPPHIRON_ICEBLOCK_ANNOUNCE, "YELL");
			CT_RABoss_Mods["Sapphiron"]["pingMiniMap"] = true;
			Minimap:PingLocation(CURSOR_OFFSET_X, CURSOR_OFFSET_Y);
			CT_RABoss_Schedule("CT_RABoss_Sapphiron_EventHandler", 2, "pingminimap");
			CT_RABoss_Schedule("CT_RABoss_Sapphiron_EventHandler", 30, "unping");
		end
	end


	if (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") then
		if ( CT_RABoss_Mods["Sapphiron"]["drainAlert"] and (string.find(arg1, CT_RABOSS_SAPPHIRON_LIFEDRAIN_EXPR1) or string.find(arg1, CT_RABOSS_SAPPHIRON_LIFEDRAIN_EXPR2)) and not CT_RABoss_Mods["Sapphiron"]["drainTrip"] ) then
			CT_RABoss_Mods["Sapphiron"]["drainTrip"] = true;
			CT_RABoss_Announce(CT_RABOSS_SAPPHIRON_LIFEDRAIN_ANNOUNCE, CT_RABoss_Mods["Sapphiron"]["announce"]);
			CT_RABoss_VisualTimer.addTimer("SapphironLifeDrain", 24, CT_RABOSS_SAPPHIRON_LIFEDRAIN_TIMER);
			CT_RABoss_Schedule("CT_RABoss_Sapphiron_EventHandler", 10, "undrain");
			CT_RABoss_Schedule("CT_RABoss_Sapphiron_EventHandler", 19, "lifedrainWarn", 5);

		elseif ( string.find(arg1, CT_RABOSS_SAPPHIRON_FROSTAURA_EXPR) ) then
			CT_RABoss_Mods["Sapphiron"]["lastaction"] = GetTime();
		end

	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or  event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
		if ( string.find(arg1, CT_RABOSS_SAPPHIRON_FROSTBOLT_HIT_EXPR) and not CT_RABoss_Mods["Sapphiron"]["frostBreathTrip"] ) then
			CT_RABoss_Mods["Sapphiron"]["frostBreathTrip"] = true;
			CT_RABoss_UnSchedule("CT_RABoss_Sapphiron_EventHandler", "lifedrainWarn");
			CT_RABoss_VisualTimer.removeTimer("SapphironLifeDrain");
			CT_RABoss_VisualTimer.addTimer("SapphironFrostBreath", 22, CT_RABOSS_SAPPHIRON_DEEPBREATH_TIMER, "red");
			CT_RABoss_Schedule("CT_RABoss_Sapphiron_EventHandler", 30, "unbreath");
			CT_RABoss_SendMessage("SAPPHIRONFROSTBREATHSYNC");
		end

	elseif ( event == "CHAT_MSG_SPELL_AURA_GONE_SELF" and string.find(arg1, CT_RABOSS_SAPPHIRON_FROSTBOLT_FADE_EXPR) ) then
		CT_RABoss_Mods["Sapphiron"]["pingMiniMap"] = false;

	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and arg1 == CT_RABOSS_SAPPHIRON_DEEPBREATH_EXPR ) then
		CT_RABoss_Announce(CT_RABOSS_SAPPHIRON_DEEPBREATH_ANNOUNCE, CT_RABoss_Mods["Sapphiron"]["announce"]);
		CT_RABoss_VisualTimer.updateTimer("SapphironFrostBreath", 7);
		CT_RABoss_Schedule("CT_RABoss_Sapphiron_EventHandler", 10, "land");

	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA_BOSS" and arg3 == "RAID" ) then
		if ( arg2 == "SAPPHIRONFROSTBREATHSYNC" and not CT_RABoss_Mods["Sapphiron"]["frostBreathTrip"]) then
			CT_RABoss_Mods["Sapphiron"]["frostBreathTrip"] = true;
			CT_RABoss_UnSchedule("CT_RABoss_Sapphiron_EventHandler", "lifedrainWarn");
			CT_RABoss_VisualTimer.removeTimer("SapphironLifeDrain");
			CT_RABoss_VisualTimer.addTimer("SapphironFrostBreath", 21, CT_RABOSS_SAPPHIRON_DEEPBREATH_TIMER, "red");
			CT_RABoss_Schedule("CT_RABoss_Sapphiron_EventHandler", 30, "unbreath");
		end

	elseif ( event == "enrageWarn" and param[1] ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_SAPPHIRON_ENRAGE_ANNOUNCE, param[1]), CT_RABoss_Mods["Sapphiron"]["announce"]);

	elseif ( event == "land" ) then
		CT_RABoss_VisualTimer.addTimer("SapphironFly", 70, CT_RABOSS_SAPPHIRON_FLY_TIMER);

	elseif ( event == "undrain" ) then
		CT_RABoss_Mods["Sapphiron"]["drainTrip"] = false;

	elseif ( event == "unbreath" ) then
		CT_RABoss_Mods["Sapphiron"]["frostBreathTrip"] = false;

	elseif ( event == "unping" ) then
		CT_RABoss_Mods["Sapphiron"]["pingMiniMap"] = false;

	elseif ( event == "pingminimap" and CT_RABoss_Mods["Sapphiron"]["pingMiniMap"] ) then
		Minimap:PingLocation(CURSOR_OFFSET_X, CURSOR_OFFSET_Y);
		CT_RABoss_Schedule("CT_RABoss_Sapphiron_EventHandler", 2, "pingminimap");

	elseif ( event == "lifedrainWarn" and param[1] ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_SAPPHIRON_LIFEDRAIN_WARN, param[1]), CT_RABoss_Mods["Sapphiron"]["announce"]);

	end
end

function CT_RABoss_Kelthuzad_OnLoad()
	CT_RABoss_AddMod("Kelthuzad", CT_RABOSS_KELTHUZAD_INFO, 1, CT_RABOSS_LOCATIONS_NAXXRAMAS);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Kelthuzad_EventHandler);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Kelthuzad_EventHandler);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Kelthuzad_EventHandler);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Kelthuzad_EventHandler);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Kelthuzad_EventHandler);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_Kelthuzad_EventHandler);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Kelthuzad_EventHandler);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_SPELL_SELF_DAMAGE", CT_RABoss_Kelthuzad_EventHandler);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Kelthuzad_EventHandler);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_SPELL_PARTY_DAMAGE", CT_RABoss_Kelthuzad_EventHandler);
	CT_RABoss_AddEvent("Kelthuzad", "CHAT_MSG_ADDON", CT_RABoss_Kelthuzad_EventHandler);

	CT_RABoss_AddDropDownButton("Kelthuzad", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Kelthuzad", { CT_RABOSS_KELTHUZAD_RANGECHECK, CT_RABOSS_KELTHUZAD_RANGECHECK }, "CT_RABoss_ModInfo", "rangeCheck", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Kelthuzad", { CT_RABOSS_KELTHUZAD_TELL, CT_RABOSS_KELTHUZAD_TELL_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Kelthuzad", { CT_RABOSS_KELTHUZAD_FROSTBOLT, CT_RABOSS_KELTHUZAD_FROSTBOLT_INFO }, "CT_RABoss_ModInfo", "frostboltAlert", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Kelthuzad", { CT_RABOSS_KELTHUZAD_HIDELOCALALERT, CT_RABOSS_KELTHUZAD_HIDELOCALALERT_INFO }, "CT_RABoss_ModInfo", "hideLocalAlert", "CT_RABoss_SetInfo");
end

function CT_RABoss_Kelthuzad_EventHandler(event, param)
	if ( not CT_RABoss_Mods["Kelthuzad"] or not CT_RABoss_Mods["Kelthuzad"]["status"] or not CT_RABoss_Mods["Kelthuzad"].enabled ) then
		return;
	end

	if ( not CT_RABoss_Mods["Kelthuzad"]["LastMindControl"] ) then
		CT_RABoss_Mods["Kelthuzad"]["LastMindControl"] = 0;
		CT_RABoss_Mods["Kelthuzad"]["LastFrostBlast"] = 0;
		CT_RABoss_Mods["Kelthuzad"]["LastFrostBoltMulti"] = 0;
		CT_RABoss_Mods["Kelthuzad"]["FrostBoltNum"] = 1;
	end

	if ( event == "CHAT_MSG_MONSTER_YELL" ) then
		if ( arg1 == CT_RABOSS_KELTHUZAD_PHASE1_EXPR ) then
			CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_PHASE1_ANNOUNCE, CT_RABoss_Mods["Kelthuzad"]["announce"]);
			CT_RABoss_Mods["Kelthuzad"]["LastMindControl"] = 0;
			CT_RABoss_Mods["Kelthuzad"]["LastFrostBlast"] = 0;
			CT_RABoss_Mods["Kelthuzad"]["LastFrostBoltMulti"] = 0;
			CT_RABoss_Mods["Kelthuzad"]["FrostBoltNum"] = 1;
			CT_RABoss_VisualTimer.removeAllTimers();
			CT_RABoss_VisualTimer.addTimer("KelthuzadPhase1", 320, CT_RABOSS_KELTHUZAD_PHASE1_TIMER);
			CT_RABoss_RangeCheck.Disable();

		elseif ( arg1 ==  CT_RABOSS_KELTHUZAD_PHASE2_EXPR1 or arg1 ==  CT_RABOSS_KELTHUZAD_PHASE2_EXPR2 or arg1 ==  CT_RABOSS_KELTHUZAD_PHASE2_EXPR3 or arg1 ==  CT_RABOSS_KELTHUZAD_PHASE2_EXPR4 ) then
			CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_PHASE2_ANNOUNCE, CT_RABoss_Mods["Kelthuzad"]["announce"]);
			CT_RABoss_VisualTimer.removeTimer("KelthuzadPhase1");
			CT_RABoss_VisualTimer.addTimer("KelthuzadPhase2", 20, CT_RABOSS_KELTHUZAD_PHASE2_TIMER);
			CT_RABoss_VisualTimer.addTimer("KelthuzadFrostBlast", -1, CT_RABOSS_KELTHUZAD_FROSTBLAST_TIMER, nil, true);
			CT_RABoss_VisualTimer.addTimer("KelthuzadMindControl", -1, CT_RABOSS_KELTHUZAD_MC_TIMER, nil, true);
			CT_RABoss_VisualTimer.addTimer("KelthuzadFBMulti", -1, CT_RABOSS_KELTHUZAD_FROSTBOLT_MULTI_TIMER, nil, true);
			if ( CT_RABoss_Mods["Kelthuzad"]["rangeCheck"] ) then
				CT_RABoss_RangeCheck.Enable();
			end

		elseif ( arg1 == CT_RABOSS_KELTHUZAD_PHASE3_EXPR ) then
			CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_PHASE3_ANNOUNCE, CT_RABoss_Mods["Kelthuzad"]["announce"]);

		elseif ( arg1 == CT_RABOSS_KELTHUZAD_GUARDIAN_EXPR ) then
			CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_GUARDIAN_ANNOUNCE, CT_RABoss_Mods["Kelthuzad"]["announce"]);
			CT_RABoss_VisualTimer.addTimer("KelthuzadPhase3", 10, CT_RABOSS_KELTHUZAD_GUARDIAN_TIMER);

		elseif ( (arg1 == CT_RABOSS_KELTHUZAD_MC_EXPR1 or arg1 == CT_RABOSS_KELTHUZAD_MC_EXPR2)
				and (GetTime() - CT_RABoss_Mods["Kelthuzad"]["LastMindControl"] > 10) ) then
			CT_RABoss_Mods["Kelthuzad"]["LastMindControl"] = GetTime();
			CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_MC_ANNOUNCE, CT_RABoss_Mods["Kelthuzad"]["announce"], CT_RABoss_Mods["Kelthuzad"]["hideLocalAlert"]);
			CT_RABoss_VisualTimer.addTimer("KelthuzadMindControl", 70, CT_RABOSS_KELTHUZAD_MC_TIMER, "orange", true);
			CT_RABoss_VisualTimer.addTimer("KelthuzadMindControlEnd", 20, CT_RABOSS_KELTHUZAD_MCEND_TIMER, "red");
			CT_RABoss_UnSchedule("CT_RABoss_Kelthuzad_EventHandler");
			CT_RABoss_Schedule("CT_RABoss_Kelthuzad_EventHandler", 62, "premc");

		elseif ( arg1 == CT_RABOSS_KELTHUZAD_END_EXPR ) then
			CT_RABoss_RangeCheck.Disable();
			CT_RABoss_VisualTimer.removeAllTimers();
			CT_RABoss_UnSchedule("CT_RABoss_Kelthuzad_EventHandler");
		end

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" ) then
		if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, CT_RABOSS_KELTHUZAD_FISSURE_EXPR) ) then
			CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_FISSURE_ANNOUNCE, CT_RABoss_Mods["Kelthuzad"]["announce"], CT_RABoss_Mods["Kelthuzad"]["hideLocalAlert"]);

		elseif ( CT_RABoss_Mods["Kelthuzad"]["frostboltAlert"] and event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, CT_RABOSS_KELTHUZAD_FROSTBOLT_SINGLE_EXPR) ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_KELTHUZAD_FROSTBOLT_SINGLE_WARN, CT_RABoss_Mods["Kelthuzad"]["FrostBoltNum"]), CT_RABoss_Mods["Kelthuzad"]["announce"], CT_RABoss_Mods["Kelthuzad"]["hideLocalAlert"]);
			CT_RABoss_VisualTimer.removeTimer("KelthuzadFrostBolt");
			CT_RABoss_Mods["Kelthuzad"]["Interruptable"] = CT_RABoss_Mods["Kelthuzad"]["FrostBoltNum"];
			CT_RABoss_Mods["Kelthuzad"]["FrostBoltNum"] = CT_RABoss_Mods["Kelthuzad"]["FrostBoltNum"] + 1;
			if (CT_RABoss_Mods["Kelthuzad"]["FrostBoltNum"] == 5) then
				CT_RABoss_Mods["Kelthuzad"]["FrostBoltNum"] = 1;
			end
			CT_RABoss_PlaySound(2);

		elseif ( string.find(arg1, CT_RABOSS_KELTHUZAD_FROSTBOLT_MULTI_EXPR) and (GetTime() - CT_RABoss_Mods["Kelthuzad"]["LastFrostBoltMulti"] > 10) ) then
			local _, _, damage = string.find(arg1, CT_RABOSS_KELTHUZAD_FROSTBOLT_MULTI_EXPR);
			if ( tonumber(damage) < 3500 ) then
				CT_RABoss_Mods["Kelthuzad"]["LastFrostBoltMulti"] = GetTime();
				CT_RABoss_VisualTimer.addTimer("KelthuzadFBMulti", 15, CT_RABOSS_KELTHUZAD_FROSTBOLT_MULTI_TIMER, nil, true);
			end
		end

	elseif ( CT_RABoss_Mods["Kelthuzad"]["frostboltAlert"] and event == "CHAT_MSG_SPELL_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PARTY_DAMAGE" ) then
		if ( CT_RABoss_Mods["Kelthuzad"]["Interruptable"] and string.find(arg1, CT_RABOSS_KELTHUZAD_INTERRUPT_EXPR) ) then
			local _, _, sPlayer = string.find(arg1, CT_RABOSS_KELTHUZAD_INTERRUPT_EXPR);
			local class;
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				sPlayer = UnitName("player");
				_, class = UnitClass("player");
			end
			CT_RABoss_Announce(string.format(CT_RABOSS_KELTHUZAD_INTERRUPT_ANNOUNCE, CT_RABoss_Mods["Kelthuzad"]["Interruptable"], sPlayer), CT_RABoss_Mods["Kelthuzad"]["announce"], CT_RABoss_Mods["Kelthuzad"]["hideLocalAlert"]);
			CT_RABoss_Mods["Kelthuzad"]["Interruptable"] = nil;
			if ( not class ) then
				local i;
				for i = 1, GetNumRaidMembers(), 1 do
					if UnitName("raid"..i) == sPlayer then
						_, class = UnitClass("raid"..i);
						break;
					end
				end
			end
			if ( class == "MAGE" ) then
				CT_RABoss_VisualTimer.addTimer("KelthuzadFrostBolt", 10, CT_RABOSS_KELTHUZAD_FROSTBOLT_SINGLE_TIMER, "green", false, false);
			elseif ( class == "WARRIOR" ) then
				CT_RABoss_VisualTimer.addTimer("KelthuzadFrostBolt", 6, CT_RABOSS_KELTHUZAD_FROSTBOLT_SINGLE_TIMER, "green", false, false);
			end
		end

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		if ( string.find(arg1, CT_RABOSS_KELTHUZAD_FROSTBLAST_EXPR) and (GetTime() - CT_RABoss_Mods["Kelthuzad"]["LastFrostBlast"] > 10) ) then
			CT_RABoss_Mods["Kelthuzad"]["LastFrostBlast"] = GetTime();
			CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_FROSTBLAST_ANNOUNCE, CT_RABoss_Mods["Kelthuzad"]["announce"], CT_RABoss_Mods["Kelthuzad"]["hideLocalAlert"]);
			CT_RABoss_VisualTimer.addTimer("KelthuzadFrostBlast", 30, CT_RABOSS_KELTHUZAD_FROSTBLAST_TIMER, nil, true);
			CT_RABoss_Schedule("CT_RABoss_Kelthuzad_EventHandler", 25, "prefb");
			CT_RABoss_SendMessage("KTFROSTBLASTSYNC");

		elseif ( string.find(arg1, CT_RABOSS_KELTHUZAD_DETONATE_EXPR) ) then
			local _, _, sPlayer = string.find(arg1, CT_RABOSS_KELTHUZAD_DETONATE_EXPR);
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				sPlayer = UnitName("player");
				CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_DETONATE_SELFWARN);
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Kelthuzad"]["announce"] ) then
					SendChatMessage(string.format(CT_RABOSS_KELTHUZAD_DETONATE_ANNOUNCE, sPlayer), "RAID_WARNING");
				end
				CT_RABoss_VisualTimer.addTimer("KelthuzadDetonateMana", 5, CT_RABOSS_KELTHUZAD_DETONATE_TIMER, "red");
			else
				CT_RABoss_Announce(string.format(CT_RABOSS_KELTHUZAD_DETONATE_ANNOUNCE, sPlayer), CT_RABoss_Mods["Kelthuzad"]["announce"], CT_RABoss_Mods["Kelthuzad"]["hideLocalAlert"]);
				if (CT_RABoss_Mods["Kelthuzad"]["sendTell"]) then
					SendChatMessage(CT_RABOSS_KELTHUZAD_DETONATE_WHISPER, "WHISPER", nil, sPlayer);
				end
			end

			if ( CT_RA_Level >= 1 ) then
				local i;
				for i = 1, GetNumRaidMembers(), 1 do
					if UnitName("raid"..i) == sPlayer then
						SetRaidTarget("raid"..i, 8);
						break;
					end
				end
				CT_RABoss_Schedule("CT_RABoss_Kelthuzad_EventHandler", 5, "clearIcon", sPlayer);
			end
		end

	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA_BOSS" and arg3 == "RAID" ) then
		if ( arg2 == "KTFROSTBLASTSYNC" and (GetTime() - CT_RABoss_Mods["Kelthuzad"]["LastFrostBlast"] > 10) ) then
			CT_RABoss_Mods["Kelthuzad"]["LastFrostBlast"] = GetTime();
			CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_FROSTBLAST_ANNOUNCE, CT_RABoss_Mods["Kelthuzad"]["announce"], CT_RABoss_Mods["Kelthuzad"]["hideLocalAlert"]);
			CT_RABoss_VisualTimer.addTimer("KelthuzadFrostBlast", 35, CT_RABOSS_KELTHUZAD_FROSTBLAST_TIMER, nil, true);
			CT_RABoss_Schedule("CT_RABoss_Kelthuzad_EventHandler", 30, "prefb");
		end

	elseif ( event =="premc" ) then
		CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_MC_PREALERT, CT_RABoss_Mods["Kelthuzad"]["announce"], CT_RABoss_Mods["Kelthuzad"]["hideLocalAlert"]);

	elseif ( event =="prefb" ) then
		CT_RABoss_Announce(CT_RABOSS_KELTHUZAD_FROSTBLAST_PREALERT, CT_RABoss_Mods["Kelthuzad"]["announce"], CT_RABoss_Mods["Kelthuzad"]["hideLocalAlert"]);

	elseif ( event == "clearIcon" and param[1] and CT_RA_Level >= 1 ) then
		local i;
		for i = 1, GetNumRaidMembers(), 1 do
			if UnitName("raid"..i) == param[1] then
				SetRaidTarget("raid"..i, 0);
				break;
			end
		end
	end
end