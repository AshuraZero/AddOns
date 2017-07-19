tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_ProphetSkeram_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_PrincessYauj_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Sartura_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Fankriss_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Huhuran_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Emperors_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Viscidus_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ouro_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Defender_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Mindslayer_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_CThun_OnLoad");



-- The Prophet Skeram
function CT_RABoss_ProphetSkeram_OnLoad()
	CT_RABoss_AddMod("Prophet Skeram", CT_RABOSS_SKERAM_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);

	-- MC events
	CT_RABoss_AddEvent("Prophet Skeram", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_ProphetSkeram_EventHandler);
	CT_RABoss_AddEvent("Prophet Skeram", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", CT_RABoss_ProphetSkeram_EventHandler);
	CT_RABoss_AddEvent("Prophet Skeram", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_ProphetSkeram_EventHandler);

	CT_RABoss_AddEvent("Prophet Skeram", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_ProphetSkeram_EventHandler);
	CT_RABoss_AddEvent("Prophet Skeram", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_ProphetSkeram_EventHandler);

	CT_RABoss_AddDropDownButton("Prophet Skeram", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Prophet Skeram", { CT_RABOSS_SKERAM_ARCANE, CT_RABOSS_SKERAM_ARCANE_INFO }, "CT_RABoss_ModInfo", "arcaneExplosion", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Prophet Skeram", { CT_RABOSS_SKERAM_MC, CT_RABOSS_SKERAM_MC_INFO }, "CT_RABoss_ModInfo", "mindControl", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Prophet Skeram", { CT_RABOSS_SKERAM_SPLIT, CT_RABOSS_SKERAM_SPLIT_INFO }, "CT_RABoss_ModInfo", "split", "CT_RABoss_SetInfo");
end

function CT_RABoss_ProphetSkeram_EventHandler(event)
	if ( not CT_RABoss_Mods["Prophet Skeram"] or not CT_RABoss_Mods["Prophet Skeram"]["status"] or not CT_RABoss_Mods["Prophet Skeram"].enabled ) then
		return;
	end

	if ( ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) and CT_RABoss_Mods["Prophet Skeram"]["mindControl"] ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_SKERAM_MC_DETECT);
		if ( sPlayer ) then
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				CT_RABoss_Announce(format(CT_RABOSS_SKERAM_MC_ALERT, UnitName("player")), CT_RABoss_Mods["Prophet Skeram"]["announce"]);
				CT_RABoss_PlaySound(2);
			else
				CT_RABoss_Announce(format(CT_RABOSS_SKERAM_MC_ALERT, sPlayer), CT_RABoss_Mods["Prophet Skeram"]["announce"]);
				CT_RABoss_PlaySound(3);
			end
		end
	end

	-- Arcane Explosion alert
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, CT_RABOSS_SKERAM_ARCANE_DETECT) and CT_RABoss_Mods["Prophet Skeram"]["arcaneExplosion"] ) then
		CT_RABoss_Announce(CT_RABOSS_SKERAM_ARCANE_ALERT, CT_RABoss_Mods["Prophet Skeram"]["announce"]);
		CT_RABoss_PlaySound(3);
	end

	-- Split alert
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" and string.find(arg1, CT_RABOSS_SKERAM_SPLIT_DETECT) and CT_RABoss_Mods["Prophet Skeram"]["split"] ) then
		CT_RABoss_Announce(CT_RABOSS_SKERAM_SPLIT_ALERT, CT_RABoss_Mods["Prophet Skeram"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
end


-- Princess Yauj
function CT_RABoss_PrincessYauj_OnLoad()
	CT_RABoss_AddMod("Princess Yauj", CT_RABOSS_YAUJ_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);

	CT_RABoss_AddEvent("Princess Yauj", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_PrincessYauj_EventHandler);
	CT_RABoss_AddEvent("Princess Yauj", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_PrincessYauj_EventHandler);		-- Fear
	CT_RABoss_AddEvent("Princess Yauj", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_PrincessYauj_EventHandler);			-- Fear
	CT_RABoss_AddEvent("Princess Yauj", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_PrincessYauj_EventHandler);	-- Fear

	CT_RABoss_AddDropDownButton("Princess Yauj", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Princess Yauj", { CT_RABOSS_YAUJ_HEAL, CT_RABOSS_YAUJ_HEAL_INFO }, "CT_RABoss_ModInfo", "heal", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Princess Yauj", { CT_RABOSS_YAUJ_FEAR, CT_RABOSS_YAUJ_FEAR_INFO }, "CT_RABoss_ModInfo", "fear", "CT_RABoss_SetInfo");
end

function CT_RABoss_PrincessYauj_EventHandler(event)
	if ( not CT_RABoss_Mods["Princess Yauj"] or not CT_RABoss_Mods["Princess Yauj"]["status"] or not CT_RABoss_Mods["Princess Yauj"].enabled ) then
		return;
	end

	-- Heal alert
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" and string.find(arg1, CT_RABOSS_YAUJ_HEAL_DETECT) and CT_RABoss_Mods["Princess Yauj"]["heal"] ) then
		CT_RABoss_Announce(CT_RABOSS_YAUJ_HEAL_ALERT, CT_RABoss_Mods["Princess Yauj"]["announce"]);
		CT_RABoss_PlaySound(2);
	end

	-- Fear alert
	if ( event == "preFearWarn" ) then
		CT_RABoss_Mods["Princess Yauj"]["fearTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_YAUJ_FEAR_PREALERT, CT_RABoss_Mods["Princess Yauj"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( CT_RABoss_Mods["Princess Yauj"]["fear"] and  not CT_RABoss_Mods["Princess Yauj"]["fearTrip"] and (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE") and string.find(arg1, CT_RABOSS_YAUJ_FEAR_DETECT) ) then
		CT_RABoss_Mods["Princess Yauj"]["fearTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_YAUJ_FEAR_ALERT, CT_RABoss_Mods["Princess Yauj"]["announce"]);
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_PrincessYauj_EventHandler", 15, "preFearWarn");
		CT_RABoss_VisualTimer.addTimer("YaujFear", 20, CT_RABOSS_YAUJ_FEAR_TIMER);
	end
end


-- Battleguard Sartura
function CT_RABoss_Sartura_OnLoad()
	CT_RABoss_AddMod("Sartura", CT_RABOSS_SARTURA_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);

	CT_RABoss_AddEvent("Sartura", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Sartura_EventHandler);
	CT_RABoss_AddEvent("Sartura", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Sartura_EventHandler);
	CT_RABoss_AddEvent("Sartura", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Sartura_EventHandler);
	CT_RABoss_AddEvent("Sartura", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Sartura_EventHandler);
	CT_RABoss_AddEvent("Sartura", "CHAT_MSG_SPELL_AURA_GONE_OTHER", CT_RABoss_Sartura_EventHandler);

	CT_RABoss_AddDropDownButton("Sartura", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Sartura", { CT_RABOSS_SARTURA_WHIRLWIND, CT_RABOSS_SARTURA_WHIRLWIND_INFO }, "CT_RABoss_ModInfo", "whirlwind", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Sartura", { CT_RABOSS_SARTURA_ENRAGE, CT_RABOSS_SARTURA_ENRAGE_INFO }, "CT_RABoss_ModInfo", "enrage", "CT_RABoss_SetInfo");

	CT_RA_RegisterSlashCmd("/sarturastop", CT_RABOSS_CMD_SARTURASTOP, 30, "SARTURASTOP", function()
		CT_RABoss_UnSchedule("CT_RABoss_Sartura_EventHandler");
		CT_RABoss_UnSchedule("CT_RABoss_Sartura_EventHandler");
		CT_RABoss_VisualTimer.removeTimer("SarturaWhirlwind");
		CT_RABoss_VisualTimer.removeTimer("SarturaEnrage");
	end, "/sarturastop");

end

function CT_RABoss_Sartura_EventHandler(event)
	if ( not CT_RABoss_Mods["Sartura"] or not CT_RABoss_Mods["Sartura"]["status"] or not CT_RABoss_Mods["Sartura"].enabled ) then
		return;
	end

	-- Whirlwind alert
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and string.find(arg1, CT_RABOSS_SARTURA_WHIRLWIND_DETECT) and CT_RABoss_Mods["Sartura"]["whirlwind"] ) then
		CT_RABoss_Announce(CT_RABOSS_SARTURA_WHIRLWIND_ALERT, CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(2);

		CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 21, "preWhirlwind");
		CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 12, "preStun");
		CT_RABoss_VisualTimer.addTimer("SarturaWhirlwind", 15, CT_RABOSS_SARTURA_WHIRLWIND_TIMER);

	end

	-- Pre-Whirlwind alert
	if ( event == "preWhirlwind" and CT_RABoss_Mods["Sartura"]["whirlwind"] ) then
		CT_RABoss_Announce(CT_RABOSS_SARTURA_WHIRLWIND_PREALERT, CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
	
	-- Pre-stun alert
	if ( event == "preStun" and CT_RABoss_Mods["Sartura"]["whirlwind"] ) then
		CT_RABoss_Announce(CT_RABOSS_SARTURA_STUN_PREALERT, CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);
	end
	
	-- Whirlwind fade alert
	if ( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and string.find(arg1, CT_RABOSS_SARTURA_WHIRLWIND_FADE_DETECT) and CT_RABoss_Mods["Sartura"]["whirlwind"] ) then
		CT_RABoss_Announce(CT_RABOSS_SARTURA_WHIRLWIND_FADE_ALERT, CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);

	end

	-- Pre-Crazy alerts
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_SARTURA_BEGIN) and arg2 == CT_RABOSS_NAMES["Sartura"] and CT_RABoss_Mods["Sartura"]["enrage"] ) then
		CT_RABoss_Mods["Sartura"]["totalWarning"] = false;
		CT_RABoss_UnSchedule("CT_RABoss_Sartura_EventHandler");
		CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 120, "totalWarning");
		CT_RABoss_VisualTimer.addTimer("SarturaEnrage", 600, CT_RABOSS_SARTURA_ENRAGE_TIMER, "red");

	elseif ( event == "totalWarning" and CT_RABoss_Mods["Sartura"]["enrage"] and not CT_RABoss_Mods["Sartura"]["totalWarning"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_SARTURA_CRAZY_PREALERT, "8"), CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 180, "totalWarning2");

	elseif ( event == "totalWarning2" and CT_RABoss_Mods["Sartura"]["enrage"] and not CT_RABoss_Mods["Sartura"]["totalWarning"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_SARTURA_CRAZY_PREALERT, "5"), CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 120, "totalWarning3");

	elseif ( event == "totalWarning3" and CT_RABoss_Mods["Sartura"]["enrage"] and not CT_RABoss_Mods["Sartura"]["totalWarning"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_SARTURA_CRAZY_PREALERT, "3"), CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 60, "totalWarning4");

	elseif ( event == "totalWarning4" and CT_RABoss_Mods["Sartura"]["enrage"] and not CT_RABoss_Mods["Sartura"]["totalWarning"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_SARTURA_CRAZY_PREALERT, "2"), CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);
		CT_RABoss_Schedule("CT_RABoss_Sartura_EventHandler", 60, "totalWarning5");

	elseif ( event == "totalWarning5" and CT_RABoss_Mods["Sartura"]["enrage"] and not CT_RABoss_Mods["Sartura"]["totalWarning"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_SARTURA_CRAZY_PREALERT, "1"), CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);

	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and arg1 == CT_RABOSS_SARTURA_CRAZY_DETECT and arg2 == CT_RABOSS_NAMES["Sartura"] and CT_RABoss_Mods["Sartura"]["enrage"] ) then
		CT_RABoss_Announce(CT_RABOSS_SARTURA_CRAZY_ALERT, CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);

	end

	-- Enrage alert
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" and string.find(arg1, CT_RABOSS_SARTURA_ENRAGE_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_SARTURA_ENRAGE_ALERT, CT_RABoss_Mods["Sartura"]["announce"]);
		CT_RABoss_PlaySound(3);

		CT_RABoss_Mods["Sartura"]["totalWarning"] = true;
	end

	-- Sartura Death
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_SARTURA_END) and arg2 == CT_RABOSS_NAMES["Sartura"] ) then
		CT_RABoss_UnSchedule("CT_RABoss_Sartura_EventHandler");
		CT_RABoss_UnSchedule("CT_RABoss_Sartura_EventHandler");
		CT_RABoss_VisualTimer.removeTimer("SarturaWhirlwind");
		CT_RABoss_VisualTimer.removeTimer("SarturaEnrage");
	end
end


-- Fankriss the Unyielding
function CT_RABoss_Fankriss_OnLoad()
	CT_RABoss_AddMod("Fankriss", CT_RABOSS_FANKRISS_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);

	CT_RABoss_AddEvent("Fankriss", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Fankriss_EventHandler);
	CT_RABoss_AddEvent("Fankriss", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Fankriss_EventHandler);
	CT_RABoss_AddEvent("Fankriss", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Fankriss_EventHandler);
	CT_RABoss_AddEvent("Fankriss", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Fankriss_EventHandler);

	CT_RABoss_AddDropDownButton("Fankriss", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Fankriss", { CT_RABOSS_FANKRISS_INVOC, CT_RABOSS_FANKRISS_INVOC_INFO }, "CT_RABoss_ModInfo", "invoc", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Fankriss", { CT_RABOSS_FANKRISS_ENTANGLE, CT_RABOSS_FANKRISS_ENTANGLE_INFO }, "CT_RABoss_ModInfo", "entangle", "CT_RABoss_SetInfo");
end

function CT_RABoss_Fankriss_EventHandler(event)
	if ( not CT_RABoss_Mods["Fankriss"] or not CT_RABoss_Mods["Fankriss"]["status"] or not CT_RABoss_Mods["Fankriss"].enabled ) then
		return;
	end

	-- Snake alert
	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" and string.find(arg1, CT_RABOSS_FANKRISS_INVOC_DETECT) and CT_RABoss_Mods["Fankriss"]["invoc"] ) then
		CT_RABoss_Announce(CT_RABOSS_FANKRISS_INVOC_ALERT, CT_RABoss_Mods["Fankriss"]["announce"]);
		CT_RABoss_PlaySound(2);
	end
	
	-- Entangle alert
	if ( (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") and CT_RABoss_Mods["Fankriss"]["entangle"] ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_FANKRISS_ENTANGLE_DETECT);
		
		if ( sPlayer ) then
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				sPlayer = UnitName("player");
			end
			
			CT_RABoss_Announce(format(CT_RABOSS_FANKRISS_ENTANGLE_ALERT, sPlayer), CT_RABoss_Mods["Fankriss"]["announce"]);
			CT_RABoss_PlaySound(3);
		end
	end
end


-- Princesse Huhuran
function CT_RABoss_Huhuran_OnLoad()
	CT_RABoss_AddMod("Huhuran", CT_RABOSS_HUHURAN_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);

	CT_RABoss_AddEvent("Huhuran", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Huhuran_EventHandler);
	CT_RABoss_AddEvent("Huhuran", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Huhuran_EventHandler);
	CT_RABoss_AddEvent("Huhuran", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Huhuran_EventHandler);
	CT_RABoss_AddEvent("Huhuran", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Huhuran_EventHandler);
	CT_RABoss_AddEvent("Huhuran", "UNIT_HEALTH", CT_RABoss_Huhuran_EventHandler);
	CT_RABoss_AddEvent("Huhuran", "PLAYER_REGEN_DISABLED", CT_RABoss_Huhuran_EventHandler);

	CT_RABoss_AddDropDownButton("Huhuran", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Huhuran", { CT_RABOSS_HUHURAN_FRENZY, CT_RABOSS_HUHURAN_FRENZY_INFO }, "CT_RABoss_ModInfo", "frenzy", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Huhuran", { CT_RABOSS_HUHURAN_BERSERK, CT_RABOSS_HUHURAN_BERSERK_INFO }, "CT_RABoss_ModInfo", "berserk", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Huhuran", { CT_RABOSS_HUHURAN_WYVERN, CT_RABOSS_HUHURAN_WYVERN_INFO }, "CT_RABoss_ModInfo", "wyvern", "CT_RABoss_SetInfo");
	
	CT_RABoss_Mods["Huhuran"]["healthLow"] = 33;
end

function CT_RABoss_Huhuran_EventHandler(event)
	if ( not CT_RABoss_Mods["Huhuran"] or not CT_RABoss_Mods["Huhuran"]["status"] or not CT_RABoss_Mods["Huhuran"].enabled ) then
		return;
	end

	if ( event == "CHAT_MSG_MONSTER_EMOTE" and arg2 == CT_RABOSS_NAMES["Huhuran"] ) then
		-- Frenzy alert
		if ( arg1 == CT_RABOSS_HUHURAN_FRENZY_DETECT and CT_RABoss_Mods["Huhuran"]["frenzy"] ) then
			CT_RABoss_Announce(CT_RABOSS_HUHURAN_FRENZY_ALERT, CT_RABoss_Mods["Huhuran"]["announce"]);
			CT_RABoss_PlaySound(2);

		-- Berserk alert
		elseif ( arg1 == CT_RABOSS_HUHURAN_BERSERK_DETECT and CT_RABoss_Mods["Huhuran"]["berserk"] ) then
			CT_RABoss_Announce(CT_RABOSS_HUHURAN_BERSERK_ALERT, CT_RABoss_Mods["Huhuran"]["announce"]);
			CT_RABoss_PlaySound(2);
		end
	elseif ( event == "PLAYER_REGEN_DISABLED" and not CT_RABoss_Mods["Huhuran"]["wyvernLoop"] and UnitExists("target") and UnitName("target") == CT_RABOSS_NAMES["Huhuran"] and UnitAffectingCombat("target") ) then
		CT_RABoss_Mods["Huhuran"]["wyvernLoop"] = true;
		CT_RABoss_Schedule("CT_RABoss_Huhuran_EventHandler", 27, "wyvernPreWarn");
		CT_RABoss_VisualTimer.addTimer("HuhuranWyvern", 30, CT_RABOSS_HUHURAN_WYVERN_TIMER);
	end

	-- Wyvern Sting alert
	if ( arg1 and string.find(arg1, CT_RABOSS_HUHURAN_WYVERN_DETECT) and not CT_RABoss_Mods["Huhuran"]["wyvernLoop"] and CT_RABoss_Mods["Huhuran"]["wyvern"] ) then
		CT_RABoss_Mods["Huhuran"]["wyvernLoop"] = true;
		CT_RABoss_Announce(CT_RABOSS_HUHURAN_WYVERN_ALERT, CT_RABoss_Mods["Huhuran"]["announce"]);
		CT_RABoss_PlaySound(2);
		CT_RABoss_Schedule("CT_RABoss_Huhuran_EventHandler", 27, "wyvernPreWarn");
		CT_RABoss_VisualTimer.addTimer("HuhuranWyvern", 30, CT_RABOSS_HUHURAN_WYVERN_TIMER);

	-- Wyvern Sting pre-alert
	elseif ( event == "wyvernPreWarn" and CT_RABoss_Mods["Huhuran"]["wyvern"] ) then
		CT_RABoss_Announce(CT_RABOSS_HUHURAN_WYVERN_PREALERT, CT_RABoss_Mods["Huhuran"]["announce"]);
		CT_RABoss_Mods["Huhuran"]["wyvernLoop"] = false;
	end

	-- Berserk pre-alert
	if ( CT_RABoss_Mods["Huhuran"]["berserk"] and UnitName("target") == CT_RABOSS_NAMES["Huhuran"] ) then
		local targetHealth = UnitHealth("target");

		-- Alert near Berserk event
		if ( targetHealth <= CT_RABoss_Mods["Huhuran"]["healthLow"] and targetHealth > 30 and not CT_RABoss_Mods["Huhuran"]["priorWarning"] ) then
			CT_RABoss_Announce(CT_RABOSS_HUHURAN_BERSERK_PREALERT, CT_RABoss_Mods["Huhuran"]["announce"]);
			CT_RABoss_Mods["Huhuran"]["priorWarning"] = true;

		-- Berserk pre-alert deactivation
		elseif (targetHealth <= 30) then
			CT_RABoss_Mods["Huhuran"]["priorWarning"] = false;
		end
	end
end


-- The Twin Emperors
function CT_RABoss_Emperors_Reset()
	CT_RABoss_SetVar("Emperors", "fight", nil);
	CT_RABoss_SetVar("Emperors", "tp", nil);

	CT_RABoss_UnSchedule("CT_RABoss_Emperors_EventHandler");
	CT_RABoss_VisualTimer.removeTimer("EmperorsEnrage");
	CT_RABoss_VisualTimer.removeTimer("EmperorsTeleport");
end

function CT_RABoss_Emperors_OnLoad()
	CT_RABoss_AddMod("Emperors", CT_RABOSS_EMPERORS_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);

	CT_RABoss_AddEvent("Emperors", "CHAT_MSG_ADDON", CT_RABoss_Emperors_EventHandler);
	CT_RABoss_AddEvent("Emperors", "PLAYER_REGEN_DISABLED", CT_RABoss_Emperors_EventHandler);
	CT_RABoss_AddEvent("Emperors", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Emperors_EventHandler);
	CT_RABoss_AddEvent("Emperors", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Emperors_EventHandler);
	CT_RABoss_AddEvent("Emperors", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Emperors_EventHandler);

	CT_RABoss_AddDropDownButton("Emperors", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Emperors", { CT_RABOSS_EMPERORS_TIMER, CT_RABOSS_EMPERORS_TIMER_INFO }, "CT_RABoss_ModInfo", "timerEnrage", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Emperors", { CT_RABOSS_EMPERORS_TP, CT_RABOSS_EMPERORS_TP_INFO }, "CT_RABoss_ModInfo", "teleport", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Emperors", { CT_RABOSS_EMPERORS_EXPLODE, CT_RABOSS_EMPERORS_EXPLODE_INFO }, "CT_RABoss_ModInfo", "alertNearby", "CT_RABoss_SetInfo");

	CT_RA_RegisterSlashCmd("/twinstop", CT_RABOSS_CMD_EMPERORSSTOP, 30, "TWINSTOP", function()
		CT_RABoss_Emperors_Reset();
		if ( CT_RA_Level >= 1 ) then
			CT_RA_AddMessage("TWINSTOPSYNCHRO");
		end
	end, "/twinstop");

	CT_RABoss_SetVar("Emperors", "fight", nil);
	CT_RABoss_SetVar("Emperors", "tp", nil);
end


function CT_RABoss_Emperors_Start()
	CT_RABoss_SetVar("Emperors", "fight", 1);
	CT_RABoss_SetVar("Emperors", "tp", nil);

	CT_RABoss_Announce(CT_RABOSS_EMPERORS_FIRSTTP_ALERT, CT_RABoss_Mods["Emperors"]["announce"]);
	CT_RABoss_PlaySound(1);
	CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 177, "enragePreWarn1");
	CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 15, "tpPreWarn1");
	CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 20, "tpPreWarn2");
	CT_RABoss_VisualTimer.addTimer("EmperorsEnrage", 897, CT_RABOSS_EMPERORS_ENRAGE_TIMER, "red");
	CT_RABoss_VisualTimer.addTimer("EmperorsTeleport", 27, CT_RABOSS_EMPERORS_TP_TIMER);
end

function CT_RABoss_Emperors_TP()
	CT_RABoss_Mods["Emperors"]["tp"] = true;
	CT_RABoss_PlaySound(1);
	CT_RABoss_Announce(CT_RABOSS_EMPERORS_TP_ALERT, CT_RABoss_Mods["Emperors"]["announce"]);
	CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 20, "tpPreWarn1");
	CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 25, "tpPreWarn2");
	CT_RABoss_VisualTimer.addTimer("EmperorsTeleport", 30, CT_RABOSS_EMPERORS_TP_TIMER);
end

function CT_RABoss_Emperors_EventHandler(event)
	if ( not CT_RABoss_Mods["Emperors"] or not CT_RABoss_Mods["Emperors"]["status"] or not CT_RABoss_Mods["Emperors"].enabled ) then
		return;
	end

	if ( CT_RABoss_Mods["Emperors"]["fight"] and ( not CT_RABoss_Mods["Emperors"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["Emperors"]["lastaction"] ) > 120 ) ) then
		CT_RABoss_Mods["Emperors"]["fight"] = nil;
	end

	-- Encounter begin
	if ( event == "PLAYER_REGEN_DISABLED" and not CT_RABoss_Mods["Emperors"]["fight"] ) then
		CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 3, "checkStart");

	elseif ( event == "checkStart" and not CT_RABoss_Mods["Emperors"]["fight"] ) then
		if ( UnitExists("target") and (UnitName("target") == CT_RABOSS_EMPERORS_VEKNILASH or UnitName("target") == CT_RABOSS_EMPERORS_VEKLOR) and UnitAffectingCombat("target") ) then
			CT_RABoss_Emperors_Start();
			CT_RABoss_Mods["Emperors"]["lastaction"] = GetTime();

			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("TWINSTARTSYNCHRO");
			end
		end

	-- Channel message synchronisation
	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA_BOSS" and arg3 == "RAID" ) then
		if ( arg2 == "TWINSTARTSYNCHRO" and not CT_RABoss_Mods["Emperors"]["fight"] ) then
			CT_RABoss_Emperors_Start();
			CT_RABoss_Mods["Emperors"]["lastaction"] = GetTime();

		elseif ( arg2 == "TWINTPSYNCHRO" and not CT_RABoss_Mods["Emperors"]["tp"] ) then
			CT_RABoss_Emperors_TP();
			CT_RABoss_Mods["Emperors"]["lastaction"] = GetTime();

		elseif ( arg2 == "TWINSTOPSYNCHRO" ) then
			CT_RABoss_Emperors_Reset();

		end

	-- Reseting mod when zoning
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		CT_RABoss_Emperors_Reset();

	-- 12 min
	elseif ( event == "enragePreWarn1" and CT_RABoss_Mods["Emperors"]["timerEnrage"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_EMPERORS_ENRAGE_PREALERT, "12"), CT_RABoss_Mods["Emperors"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 240, "enragePreWarn2");

	-- 8 min
	elseif ( event == "enragePreWarn2" and CT_RABoss_Mods["Emperors"]["timerEnrage"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_EMPERORS_ENRAGE_PREALERT, "8"), CT_RABoss_Mods["Emperors"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 180, "enragePreWarn3");

	-- 5 min
	elseif ( event == "enragePreWarn3" and CT_RABoss_Mods["Emperors"]["timerEnrage"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_EMPERORS_ENRAGE_PREALERT, "5"), CT_RABoss_Mods["Emperors"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 120, "enragePreWarn4");

	-- 3 min
	elseif ( event == "enragePreWarn4" and CT_RABoss_Mods["Emperors"]["timerEnrage"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_EMPERORS_ENRAGE_PREALERT, "3"), CT_RABoss_Mods["Emperors"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 60, "enragePreWarn5");

	-- 2 min
	elseif ( event == "enragePreWarn5" and CT_RABoss_Mods["Emperors"]["timerEnrage"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_EMPERORS_ENRAGE_PREALERT, "2"), CT_RABoss_Mods["Emperors"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_Emperors_EventHandler", 60, "enragePreWarn6");

	-- 1 min
	elseif ( event == "enragePreWarn6" and CT_RABoss_Mods["Emperors"]["timerEnrage"] ) then
		CT_RABoss_Announce(format(CT_RABOSS_EMPERORS_ENRAGE_PREALERT, "1"), CT_RABoss_Mods["Emperors"]["announce"]);

	end

	-- Emperor Teleport alert
	if ( CT_RABoss_Mods["Emperors"]["teleport"] and event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" ) then
		if ( string.find(arg1, CT_RABOSS_EMPERORS_TP_CASTER) or string.find(arg1, CT_RABOSS_EMPERORS_TP_MELEE) and not CT_RABoss_Mods["Emperors"]["tp"] ) then
			CT_RABoss_Emperors_TP();
			CT_RABoss_Mods["Emperors"]["lastaction"] = GetTime();

			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("TWINTPSYNCHRO");
			end
		end

	-- Emperor Teleport pre-alert
	elseif ( CT_RABoss_Mods["Emperors"]["teleport"] and event == "tpPreWarn1" ) then
		CT_RABoss_Mods["Emperors"]["tp"] = nil;
		CT_RABoss_Announce(string.format(CT_RABOSS_EMPERORS_TP_PREALERT, "10"), CT_RABoss_Mods["Emperors"]["announce"]);
		CT_RABoss_PlaySound(1);

	elseif ( CT_RABoss_Mods["Emperors"]["teleport"] and event == "tpPreWarn2" ) then
		CT_RABoss_Announce(string.format(CT_RABOSS_EMPERORS_TP_PREALERT, "5"), CT_RABoss_Mods["Emperors"]["announce"]);
		CT_RABoss_PlaySound(1);

	-- Detect Exploding Bug, must be in proximity of the exploding bug.
	elseif ( CT_RABoss_Mods["Emperors"]["alertNearby"] and (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" or event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") ) then
		local _, _, bugType = string.find(arg1, CT_RABOSS_EMPERORS_EXPLODE_DETECT);

		if ( bugType ) then
			CT_RABoss_Announce(string.format(CT_RABOSS_EMPERORS_EXPLODE_ALERT, bugType));
			CT_RABoss_PlaySound(3);
			CT_RABoss_Mods["Emperors"]["lastaction"] = GetTime();
		else
			local _, _, bugType = string.find(arg1, CT_RABOSS_EMPERORS_MUTATE_DETECT);
			if ( bugType ) then
				CT_RABoss_Announce(string.format(CT_RABOSS_EMPERORS_MUTATE_ALERT, bugType));
				CT_RABoss_PlaySound(3);
				CT_RABoss_Mods["Emperors"]["lastaction"] = GetTime();
			end
		end
	end
end


-- Viscidus
function CT_RABoss_Viscidus_OnLoad()
	CT_RABoss_AddMod("Viscidus", CT_RABOSS_VISCIDUS_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);

	CT_RABoss_AddEvent("Viscidus", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Viscidus_EventHandler);
	CT_RABoss_AddEvent("Viscidus", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Viscidus_EventHandler);
	CT_RABoss_AddEvent("Viscidus", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Viscidus_EventHandler);
	CT_RABoss_AddEvent("Viscidus", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Viscidus_EventHandler);

	CT_RABoss_AddDropDownButton("Viscidus", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Viscidus", { CT_RABOSS_VISCIDUS_CLOUD, CT_RABOSS_VISCIDUS_CLOUD_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
end

function CT_RABoss_Viscidus_EventHandler(event)
	if ( not CT_RABoss_Mods["Viscidus"] or not CT_RABoss_Mods["Viscidus"]["status"] or not CT_RABoss_Mods["Viscidus"].enabled ) then
		return;

	end

	if ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		if ( arg1 == CT_RABOSS_VISCIDUS_FREEZE_DETECT ) then
			CT_RABoss_Announce(CT_RABOSS_VISCIDUS_FREEZE_ALERT, CT_RABoss_Mods["Viscidus"]["announce"]);
		end

	else
		local _, _, playerName = string.find(arg1, CT_RABOSS_VISCIDUS_TOXIN_DETECT);

		if ( playerName ) then
			if ( playerType == CT_RABOSS_SELF1 ) then
				playerName = UnitName("player");
				CT_RABoss_Announce(CT_RABOSS_VISCIDUS_TOXIN_ALERT);
				CT_RABoss_Announce(CT_RABOSS_VISCIDUS_TOXIN_ALERT);
				CT_RABoss_Announce(CT_RABOSS_VISCIDUS_TOXIN_ALERT);
				CT_RABoss_PlaySound(2);

			elseif ( CT_RABoss_Mods["Viscidus"]["sendTell"] ) then
				SendChatMessage(CT_RABOSS_VISCIDUS_TOXIN_ALERT, "WHISPER", nil, playerName);

			end
		end
	end
end


-- Ouro
function CT_RABoss_Ouro_OnLoad()
	CT_RABoss_AddMod("Ouro", CT_RABOSS_OURO_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);

	CT_RABoss_AddEvent("Ouro", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Ouro_EventHandler);
	CT_RABoss_AddEvent("Ouro", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Ouro_EventHandler);
	CT_RABoss_AddEvent("Ouro", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_Ouro_EventHandler);
	CT_RABoss_AddEvent("Ouro", "PLAYER_REGEN_DISABLED", CT_RABoss_Ouro_EventHandler);
	CT_RABoss_AddEvent("Ouro", "CHAT_MSG_ADDON", CT_RABoss_Ouro_EventHandler);

	CT_RABoss_AddDropDownButton("Ouro", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Ouro_Start()
	CT_RABoss_Mods["Ouro"]["fight"] = true;
	CT_RABoss_Announce(CT_RABOSS_OURO_ENGAGE_ALERT, CT_RABoss_Mods["Ouro"]["announce"]);
	CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 10, "sweepWarning");
	CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 12, "sandblastWarning");
	CT_RABoss_VisualTimer.addTimer("OuroSweep", 15, CT_RABOSS_OURO_SWEEP_TIMER);
	CT_RABoss_VisualTimer.addTimer("OuroSandblast", 17, CT_RABOSS_OURO_SANDBLAST_TIMER);
	CT_RABoss_Mods["Ouro"]["lastaction"] = GetTime();
end

function CT_RABoss_Ouro_Submerge()
	CT_RABoss_Mods["Ouro"]["submergeTrip"] = true;
	CT_RABoss_Announce(CT_RABOSS_OURO_SUBMERGE_ALERT, CT_RABoss_Mods["Ouro"]["announce"]);
	CT_RABoss_UnSchedule("CT_RABoss_Ouro_EventHandler", "sweepWarning");
	CT_RABoss_UnSchedule("CT_RABoss_Ouro_EventHandler", "sandblastWarning");
	CT_RABoss_VisualTimer.removeTimer("OuroSweep");
	CT_RABoss_VisualTimer.removeTimer("OuroSandblast");
	CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 20, "emergeWarning");
	CT_RABoss_VisualTimer.addTimer("OuroSubmerge", 30, CT_RABOSS_OURO_SUBMERGE_TIMER, "orange");
	CT_RABoss_PlaySound(2);
	CT_RABoss_Mods["Ouro"]["lastaction"] = GetTime();
end

function CT_RABoss_Ouro_Emerge()
	CT_RABoss_Mods["Ouro"]["emergeTrip"] = true;
	CT_RABoss_Announce(CT_RABOSS_OURO_EMERGE_ALERT, CT_RABoss_Mods["Ouro"]["announce"]);
	CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 15, "sweepWarning");
	CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 17, "sandblastWarning");
	CT_RABoss_VisualTimer.addTimer("OuroSweep", 20, CT_RABOSS_OURO_SWEEP_TIMER);
	CT_RABoss_VisualTimer.addTimer("OuroSandblast", 22, CT_RABOSS_OURO_SANDBLAST_TIMER);
	CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 45, "scarabs15");
	CT_RABoss_VisualTimer.addTimer("OuroSandblast", 60, CT_RABOSS_OURO_BUGS_TIMER, "orange");
	CT_RABoss_Mods["Ouro"]["lastaction"] = GetTime();
end

local MoundRepeat = 0
function CT_RABoss_Ouro_EventHandler(event)
	if ( not CT_RABoss_Mods["Ouro"] or not CT_RABoss_Mods["Ouro"]["status"] or not CT_RABoss_Mods["Ouro"].enabled ) then
		return;
	end

	if ( CT_RABoss_Mods["Ouro"]["fight"] and ( not CT_RABoss_Mods["Ouro"]["lastaction"] or ( GetTime() - CT_RABoss_Mods["Ouro"]["lastaction"] ) > 120 ) ) then
		CT_RABoss_Mods["Ouro"]["fight"] = nil;
	end

	if ( event == "PLAYER_REGEN_DISABLED" and not CT_RABoss_Mods["Ouro"]["fight"] ) then
		CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 5, "checkStart");

	elseif ( event == "checkStart" and not CT_RABoss_Mods["Ouro"]["fight"] ) then
		if ( UnitExists("target") and UnitName("target") == CT_RABOSS_NAMES["Ouro"] and UnitAffectingCombat("target") ) then
			CT_RABoss_Ouro_Start();
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("OUROSTARTSYNCHRO");
			end
		end

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" ) then
		if ( string.find(arg1, CT_RABOSS_OURO_SWEEP_DETECT) ) then
			CT_RABoss_Announce(CT_RABOSS_OURO_SWEEP_ALERT, CT_RABoss_Mods["Ouro"]["announce"]);
			CT_RABoss_Mods["Ouro"]["sweepTrip"] = true;
			CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 15, "sweepWarning");
			CT_RABoss_VisualTimer.addTimer("OuroSweep", 20, CT_RABOSS_OURO_SWEEP_TIMER);
			CT_RABoss_PlaySound(1);
			CT_RABoss_Mods["Ouro"]["lastaction"] = GetTime();
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("OUROSWEEPSYNCHRO");
			end

		elseif ( string.find(arg1, CT_RABOSS_OURO_SANDBLAST_DETECT) ) then
			CT_RABoss_Announce(CT_RABOSS_OURO_SANDBLAST_ALERT, CT_RABoss_Mods["Ouro"]["announce"]);
			CT_RABoss_Mods["Ouro"]["sandblastTrip"] = true;
			CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 17, "sandblastWarning");
			CT_RABoss_VisualTimer.addTimer("OuroSandblast", 22, CT_RABOSS_OURO_SANDBLAST_TIMER);
			CT_RABoss_PlaySound(1);
			CT_RABoss_Mods["Ouro"]["lastaction"] = GetTime();
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("OUROSANDBLASTSYNCHRO");
			end
		end

	elseif ( event == "sweepWarning" ) then
			CT_RABoss_Announce(format(CT_RABOSS_OURO_SWEEP_PREALERT, "5"), CT_RABoss_Mods["Ouro"]["announce"]);
			CT_RABoss_Mods["Ouro"]["sweepTrip"] = false;

	elseif ( event == "sandblastWarning" ) then
			CT_RABoss_Announce(format(CT_RABOSS_OURO_SANDBLAST_PREALERT, "5"), CT_RABoss_Mods["Ouro"]["announce"]);
			CT_RABoss_Mods["Ouro"]["sandblastTrip"] = false;

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" ) then
		if ( string.find(arg1, CT_RABOSS_OURO_MOUNDS_DETECT) ) then
			CT_RABoss_Ouro_Submerge();
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("OUROSUBMERGESYNCHRO");
			end

		elseif ( string.find(arg1, CT_RABOSS_OURO_SCARABS_DETECT) ) then
			if ( MoundRepeat < GetTime()- 2 ) then
				if ( OuroBerserk ) then
					CT_RABoss_Announce(CT_RABOSS_OURO_BUGSSPAWN_ALERT, CT_RABoss_Mods["Ouro"]["announce"]);
					MoundRepeat = GetTime();
					CT_RABoss_Mods["Ouro"]["lastaction"] = GetTime();

				else
					CT_RABoss_Ouro_Emerge();
					if ( CT_RA_Level >= 1 ) then
						CT_RABoss_SendMessage("OUROEMERGESYNCHRO");
					end
					MoundRepeat = GetTime();
				end
			end
		end

	elseif ( event == "emergeWarning" ) then
		CT_RABoss_Announce(format(CT_RABOSS_OURO_EMERGE_PREALERT, "10"), CT_RABoss_Mods["Ouro"]["announce"]);
		CT_RABoss_Mods["Ouro"]["submergeTrip"] = false;

	elseif ( event == "scarabs15" ) then
		CT_RABoss_Announce(format(CT_RABOSS_OURO_BUGSDESPAWN_PREALERT, "15"), CT_RABoss_Mods["Ouro"]["announce"]);
		CT_RABoss_Mods["Ouro"]["emergeTrip"] = false;

	elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA_BOSS" and arg3 == "RAID" ) then
		if ( arg1 == "OUROSTARTSYNCHRO" and not CT_RABoss_Mods["Ouro"]["fight"] ) then
			CT_RABoss_Ouro_Start();

		elseif ( arg1 == "OUROSUBMERGESYNCHRO" and not CT_RABoss_Mods["Ouro"]["submergeTrip"] ) then
			CT_RABoss_Ouro_Submerge();

		elseif ( arg1 == "OUROEMERGESYNCHRO" and not CT_RABoss_Mods["Ouro"]["emergeTrip"] ) then
			CT_RABoss_Ouro_Emerge();

		elseif ( arg1 == "OUROSWEEPSYNCHRO" and not CT_RABoss_Mods["Ouro"]["sweepTrip"] ) then
			CT_RABoss_Announce(CT_RABOSS_OURO_SWEEP_ALERT, CT_RABoss_Mods["Ouro"]["announce"]);
			CT_RABoss_Mods["Ouro"]["sweepTrip"] = true;
			CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 15, "sweepWarning");
			CT_RABoss_VisualTimer.addTimer("OuroSweep", 20, CT_RABOSS_OURO_SWEEP_TIMER);
			CT_RABoss_PlaySound(1);
			CT_RABoss_Mods["Ouro"]["lastaction"] = GetTime();

		elseif ( arg1 == "OUROSANDBLASTSYNCHRO" and not CT_RABoss_Mods["Ouro"]["sandblastTrip"] ) then
			CT_RABoss_Announce(CT_RABOSS_OURO_SANDBLAST_ALERT, CT_RABoss_Mods["Ouro"]["announce"]);
			CT_RABoss_Mods["Ouro"]["sandblastTrip"] = true;
			CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 17, "sandblastWarning");
			CT_RABoss_VisualTimer.addTimer("OuroSandblast", 22, CT_RABOSS_OURO_SANDBLAST_TIMER);
			CT_RABoss_PlaySound(1);
			CT_RABoss_Mods["Ouro"]["lastaction"] = GetTime();

		end

	elseif ( event == "CHAT_MSG_MONSTER_EMOTE" and arg1 == CT_RABOSS_OURO_BERSERK_DETECT and arg2 == CT_RABOSS_NAMES["Ouro"] ) then
		CT_RABoss_Announce(CT_RABOSS_OURO_BERSERK_ALERT, CT_RABoss_Mods["Ouro"]["announce"]);
		OuroBerserk = true;
		CT_RABoss_Schedule("CT_RABoss_Ouro_EventHandler", 240, "BerserkReset");

	-- Wipe
	elseif ( event == "BerserkReset" ) then
		OuroBerserk = false;

	end
end


-- Anubisath Defender
function CT_RABoss_Defender_OnLoad()
	CT_RABoss_AddMod("Anubisath Defender", CT_RABOSS_DEFENDER_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);

	CT_RABoss_AddEvent("Anubisath Defender", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defender", "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defender", "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defender", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defender", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defender", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defender", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Defender_EventHandler);
	CT_RABoss_AddEvent("Anubisath Defender", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Defender_EventHandler);

	CT_RABoss_AddDropDownButton("Anubisath Defender", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Anubisath Defender", { CT_RABOSS_DEFENDER_ABILITIES, CT_RABOSS_DEFENDER_ABILITIES }, "CT_RABoss_ModInfo", "abilities", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Anubisath Defender", { CT_RABOSS_DEFENDER_SUMMON, CT_RABOSS_DEFENDER_SUMMON_INFO }, "CT_RABoss_ModInfo", "notifySummon", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Anubisath Defender", { CT_RABOSS_DEFENDER_PLAGUETELL, CT_RABOSS_DEFENDER_PLAGUETELL_INFOM }, "CT_RABoss_ModInfo", "sendPlagueTells", "CT_RABoss_SetInfo");

end


function CT_RABoss_Defender_EventHandler(event)
	if ( not CT_RABoss_Mods["Anubisath Defender"] or not CT_RABoss_Mods["Anubisath Defender"]["status"] or not CT_RABoss_Mods["Anubisath Defender"].enabled ) then
		return;
	end

	-- Ability alerts
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and CT_RABoss_Mods["Anubisath Defender"]["abilities"] ) then
		-- Explode
		if ( string.find(arg1, CT_RABOSS_DEFENDER_EXPLODE_DETECT) ) then
			CT_RABoss_Announce(CT_RABOSS_DEFENDER_EXPLODE_ALERT, CT_RABoss_Mods["Anubisath Defender"]["announce"]);

		-- Enrage
		elseif ( string.find(arg1, CT_RABOSS_DEFENDER_ENRAGE_DETECT) ) then
			CT_RABoss_Announce(CT_RABOSS_DEFENDER_ENRAGE_ALERT, CT_RABoss_Mods["Anubisath Defender"]["announce"]);
		end

	-- Summonning alerts
	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF" and CT_RABoss_Mods["Anubisath Defender"]["notifySummon"]) then
		-- Summonning Anubisath Swarmguard alert
		if ( string.find(arg1, CT_RABOSS_DEFENDER_GUARD_DETECT) ) then
			CT_RABoss_Announce(CT_RABOSS_DEFENDER_GUARD_ALERT, CT_RABoss_Mods["Anubisath Defender"]["announce"]);

		-- Summon Anubisath Warrior alert
		elseif ( string.find(arg1, CT_RABOSS_DEFENDER_WARRIOR_DETECT) ) then
			CT_RABoss_Announce(CT_RABOSS_DEFENDER_WARRIOR_ALERT, CT_RABoss_Mods["Anubisath Defender"]["announce"]);
		end
	elseif ( (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") and CT_RABoss_Mods["Anubisath Defender"]["abilities"] ) then
		local _, _, playerName = string.find(arg1, CT_RABOSS_DEFENDER_PLAGUE_DETECT);

		if ( playerName ) then
			if ( playerName == CT_RABOSS_SELF1 ) then
				playerName = UnitName("player");
				CT_RABoss_Announce(string.format(CT_RABOSS_DEFENDER_PLAGUE_ALERT, CT_RABOSS_DEFENDER_YOUHAVE));
				CT_RABoss_Announce(string.format(CT_RABOSS_DEFENDER_PLAGUE_ALERT, CT_RABOSS_DEFENDER_YOUHAVE));
				CT_RABoss_PlaySound(2);

			else
				if ( CT_RABoss_Mods["Anubisath Defender"]["sendPlagueTells"] ) then
					SendChatMessage(CT_RABOSS_DEFENDER_PLAGUE_TELL, "WHISPER", nil, playerName);
				end
				CT_RABoss_PlaySound(1);
			end

			if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Anubisath Defender"]["announce"] ) then
				SendChatMessage(string.format(CT_RABOSS_DEFENDER_PLAGUE_ALERT, playerName .. CT_RABOSS_DEFENDER_HAS), "RAID_WARNING");
			end
		end
	end
end


-- Qiraji Mindslayer
function CT_RABoss_Mindslayer_OnLoad()
	CT_RABoss_AddMod("Qiraji Mindslayer", CT_RABOSS_MINDSLAYER_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);
	
	CT_RABoss_AddEvent("Qiraji Mindslayer", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Mindslayer_EventHandler);
	CT_RABoss_AddEvent("Qiraji Mindslayer", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Mindslayer_EventHandler);
	CT_RABoss_AddEvent("Qiraji Mindslayer", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Mindslayer_EventHandler);
	
	CT_RABoss_AddDropDownButton("Qiraji Mindslayer", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end


function CT_RABoss_Mindslayer_EventHandler(event)
	if ( not CT_RABoss_Mods["Qiraji Mindslayer"] or not CT_RABoss_Mods["Qiraji Mindslayer"]["status"] or not CT_RABoss_Mods["Qiraji Mindslayer"].enabled ) then
		return;
	end

	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) then
		local _, _, playerName = string.find(arg1, CT_RABOSS_MINDSLAYER_MINDFLAY_DETECT);

		if ( playerName ) then
			if ( playerName == CT_RABOSS_SELF1 ) then
				playerName = UnitName("player");
			end

			CT_RABoss_PlaySound(2);
			if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Qiraji Mindslayer"]["announce"] ) then
			SendChatMessage(string.format(CT_RABOSS_MINDSLAYER_MINDFLAY_ALERT, playerName), "RAID_WARNING");
		    end
		end
	end
end


-- C'Thun
function CT_RABoss_CThun_Reset()
	CT_RABoss_SetVar("CThun", "fight", nil);
	CT_RABoss_SetVar("CThun", "phase", 1);
	CT_RABoss_SetVar("CThun", "type", nil);

	CT_RABoss_UnSchedule("CT_RABoss_CThun_EventHandler");
	CT_RABoss_VisualTimer.removeTimer("CThunTentakle");
	CT_RABoss_VisualTimer.removeTimer("CThunDarkGlare");
	CT_RABoss_VisualTimer.removeTimer("CThunGiantTentacle");
	CT_RABoss_RangeCheck.Disable()
end

function CT_RABoss_CThun_OnLoad()
	CT_RABoss_AddMod("CThun", CT_RABOSS_CTHUN_INFO, 1, CT_RABOSS_LOCATIONS_AHNQIRAJ);

	CT_RABoss_AddEvent("CThun", "CHAT_MSG_ADDON", CT_RABoss_CThun_EventHandler);
	CT_RABoss_AddEvent("CThun", "PLAYER_ENTERING_WORLD", CT_RABoss_CThun_EventHandler);
	CT_RABoss_AddEvent("CThun", "PLAYER_REGEN_DISABLED", CT_RABoss_CThun_EventHandler);
	CT_RABoss_AddEvent("CThun", "CHAT_MSG_MONSTER_EMOTE", CT_RABoss_CThun_EventHandler);
	CT_RABoss_AddEvent("CThun", "CHAT_MSG_COMBAT_HOSTILE_DEATH", CT_RABoss_CThun_EventHandler);
	CT_RABoss_AddEvent("CThun", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", CT_RABoss_CThun_EventHandler);

	CT_RABoss_AddDropDownButton("CThun", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("CThun", { CT_RABOSS_CTHUN_RANGECHECK, CT_RABOSS_CTHUN_RANGECHECK }, "CT_RABoss_ModInfo", "rangeCheck", "CT_RABoss_SetInfo");

	CT_RA_RegisterSlashCmd("/cthunstop", CT_RABOSS_CMD_CTHUNSTOP, 30, "CTHUNSTOP", function()
		CT_RABoss_CThun_Reset();
		if ( CT_RA_Level >= 1 ) then
			CT_RABoss_SendMessage("CTHUNDIESYNCHRO");
		end
	end, "/cthunstop");

	CT_RABoss_SetVar("CThun", "fight", nil);
	CT_RABoss_SetVar("CThun", "phase", 1);
end

function CT_RABoss_CThun_Start()
	CT_RABoss_SetVar("CThun", "fight", 1);
	CT_RABoss_SetVar("CThun", "phase", 1);

	CT_RABoss_Announce(CT_RABOSS_CTHUN_START_ALERT, CT_RABoss_Mods["CThun"]["announce"]);
	CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 40, "tentacle5");
	CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 43, "darkglare5");
	CT_RABoss_VisualTimer.addTimer("CThunTentakle", 45, CT_RABOSS_CTHUN_TENTAKLE_TIMER);
	CT_RABoss_VisualTimer.addTimer("CThunDarkGlare", 48, CT_RABOSS_CTHUN_DARKGLARE_TIMER);
	if ( CT_RABoss_Mods["CThun"]["rangeCheck"] ) then
		CT_RABoss_RangeCheck.Enable();
	end
end

function CT_RABoss_CThun_Phase2()
	CT_RABoss_SetVar("CThun", "phase", 2);
	CT_RABoss_SetVar("CThun", "type", 1);

	CT_RABoss_Announce(CT_RABOSS_CTHUN_PHASE2_ALERT, CT_RABoss_Mods["CThun"]["announce"]);
	CT_RABoss_UnSchedule("CT_RABoss_CThun_EventHandler");
	CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 35, "tentacle5");
	CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 5, "gianttentacle5");
	CT_RABoss_VisualTimer.removeTimer("CThunTentakle");
	CT_RABoss_VisualTimer.removeTimer("CThunDarkGlare");
	CT_RABoss_VisualTimer.addTimer("CThunTentakle", 40, CT_RABOSS_CTHUN_TENTAKLE_TIMER);
	CT_RABoss_VisualTimer.addTimer("CThunGiantTentacle", 10, CT_RABOSS_CTHUN_GIANTTENTACLE[CT_RABoss_Mods["CThun"]["type"]], "orange");
	CT_RABoss_RangeCheck.Disable();
end

function CT_RABoss_CThun_EventHandler(event)
	if ( not CT_RABoss_Mods["CThun"] or not CT_RABoss_Mods["CThun"]["status"] or not CT_RABoss_Mods["CThun"].enabled ) then
		return;
	end
	-- Encounter begin
	if ( event == "PLAYER_REGEN_DISABLED" and not CT_RABoss_Mods["CThun"]["fight"] ) then
		if ( UnitExists("target") and UnitName("target") == CT_RABOSS_CTHUN_BOSSNAME_PHASE1 ) then
			CT_RABoss_CThun_Start();

			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("CTHUNSTARTSYNCHRO");
			end
		end
	end

	-- Eye tentacle pop alert
	if ( event == "tentacle" ) then
		if ( CT_RABoss_Mods["CThun"]["phase"] == 2 ) then
			CT_RABoss_Announce(CT_RABOSS_CTHUN_TENTACLE_ALERT, CT_RABoss_Mods["CThun"]["announce"]);
		end

		-- Phase 1 => 45 sec
		if ( CT_RABoss_Mods["CThun"]["phase"] == 1 ) then
			CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 40, "tentacle5");
			CT_RABoss_VisualTimer.addTimer("CThunTentakle", 45, CT_RABOSS_CTHUN_TENTAKLE_TIMER);

		-- Phase 2 => 30 sec
		elseif ( CT_RABoss_Mods["CThun"]["phase"] == 2 ) then
			CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 25, "tentacle5");
			CT_RABoss_VisualTimer.addTimer("CThunTentakle", 30, CT_RABOSS_CTHUN_TENTAKLE_TIMER);
		end

	-- Eye tentacle 5sec prealert
	elseif ( event == "tentacle5" ) then
		if ( CT_RABoss_Mods["CThun"]["phase"] == 2 ) then
			CT_RABoss_Announce(format(CT_RABOSS_CTHUN_TENTACLE_PREALERT, "5"), CT_RABoss_Mods["CThun"]["announce"]);
		end
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 5, "tentacle");
	end

	-- Darkglare pop alert
	if ( event == "darkglare" and CT_RABoss_Mods["CThun"]["phase"] == 1 ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_DARKGLARE_ALERT, CT_RABoss_Mods["CThun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 28, "darkglareEnd10");
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 38, "darkglareEnd");
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 81, "darkglare5");
		CT_RABoss_VisualTimer.addTimer("CThunDarkGlare", 38, CT_RABOSS_CTHUN_DARKGLARE_TIMER, "orange");

	-- Darkglare 5sec prealert
	elseif ( event == "darkglare5" and CT_RABoss_Mods["CThun"]["phase"] == 1 ) then
		CT_RABoss_Announce(format(CT_RABOSS_CTHUN_DARKGLARE_PREALERT, "5"), CT_RABoss_Mods["CThun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 5, "darkglare");

		local CThunTarget = nil;

		-- Get name and raid group of CThun's target before Dark Glare cast
		for i = 1, GetNumRaidMembers(), 1 do
			name, _, subgroup, _, _, _, _, _ = GetRaidRosterInfo(i);
			if ( UnitExists("raid"..i.."target") and UnitName("raid"..i.."target") == CT_RABOSS_CTHUN_BOSSNAME_PHASE1 ) then
				CThunTarget = UnitName("raid"..i.."targettarget")
				break;
			end
		end

		if ( CThunTarget and subgroup ) then
			CT_RABoss_Announce(format(CT_RABOSS_CTHUN_DARKGLARE_ONGROUP, subgroup.."("..CThunTarget..")"), CT_RABoss_Mods["CThun"]["announce"]);
		end

	-- Darkglare 5sec until end
	elseif ( event == "darkglareEnd10" and CT_RABoss_Mods["CThun"]["phase"] == 1 ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_DARKGLARE_END_PREALERT, CT_RABoss_Mods["CThun"]["announce"]);

	-- Darkglare end
	elseif ( event == "darkglareEnd" and CT_RABoss_Mods["CThun"]["phase"] == 1 )then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_DARKGLARE_END_ALERT, CT_RABoss_Mods["CThun"]["announce"]);
		CT_RABoss_VisualTimer.addTimer("CThunDarkGlare", 48, CT_RABOSS_CTHUN_DARKGLARE_TIMER);
	end

	if ( event == "gianttentacle") then
		CT_RABoss_Announce(format(CT_RABOSS_CTHUN_GIANTTENTACLE_ALERT, CT_RABOSS_CTHUN_GIANTTENTACLE[CT_RABoss_Mods["CThun"]["type"]]), CT_RABoss_Mods["CThun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 25, "gianttentacle5");
		if ( CT_RABoss_Mods["CThun"]["type"] == 1) then
			CT_RABoss_SetVar("CThun", "type", 2);
		else
			CT_RABoss_SetVar("CThun", "type", 1);
		end
		CT_RABoss_VisualTimer.addTimer("CThunGiantTentacle", 30, CT_RABOSS_CTHUN_GIANTTENTACLE[CT_RABoss_Mods["CThun"]["type"]], "orange");
	elseif ( event == "gianttentacle5" ) then
		CT_RABoss_Announce(format(CT_RABOSS_CTHUN_GIANTTENTACLE_PREALERT, "5", CT_RABOSS_CTHUN_GIANTTENTACLE[CT_RABoss_Mods["CThun"]["type"]]), CT_RABoss_Mods["CThun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 5, "gianttentacle");
	end

	-- Phase 2 begin
	if ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
		if ( string.find(arg1, CT_RABOSS_CTHUN_PHASE1_DIE_DETECT) ) then
			CT_RABoss_CThun_Phase2();
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("CTHUNPHASE2SYNCHRO");
			end
		elseif ( string.find(arg1, CT_RABOSS_CTHUN_PHASE2_DIE_DETECT) ) then
			CT_RABoss_CThun_Reset();
			if ( CT_RA_Level >= 1 ) then
				CT_RABoss_SendMessage("CTHUNDIESYNCHRO");
			end
		end
	end

	-- Phase 1&2 begin by synchronisation
	if ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA_BOSS" and arg3 == "RAID" ) then
		if ( arg2 == "CTHUNSTARTSYNCHRO" and not CT_RABoss_Mods["CThun"]["fight"] ) then
			CT_RABoss_CThun_Start();
		elseif ( arg2 == "CTHUNPHASE2SYNCHRO" and CT_RABoss_Mods["CThun"]["phase"] == 1 ) then
			CT_RABoss_CThun_Phase2();
		elseif ( arg2 == "CTHUNDIESYNCHRO" ) then
			CT_RABoss_CThun_Reset();
		end
	end

	-- C'Thun weakened
	if ( event == "CHAT_MSG_MONSTER_EMOTE" and arg1 == CT_RABOSS_CTHUN_WEAKENED_DETECT ) then
		CT_RABoss_UnSchedule("CT_RABoss_CThun_EventHandler");
		PlaySoundFile("Interface\\AddOns\\CT_RABossMods\\alarm.mp3");
		CT_RABoss_VisualTimer.removeTimer("CThunTentakle");
		CT_RABoss_VisualTimer.removeTimer("CThunGiantTentacle");
		CT_RABoss_Announce(CT_RABOSS_CTHUN_WEAK_ALERT, CT_RABoss_Mods["CThun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 35, "invul10");
		CT_RABoss_VisualTimer.addTimer("CThunWeakened", 45, CT_RABOSS_CTHUN_WEAKENED_TIMER);
		CT_RABoss_SetVar("CThun", "type", 1);

	-- C'Thun weakened end 10 sec
	elseif ( event == "invul10" ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_INVUL_PREALERT, CT_RABoss_Mods["CThun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 10, "invul");

	-- C'Thun weakened end
	elseif ( event == "invul" ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_INVUL_ALERT, CT_RABoss_Mods["CThun"]["announce"]);
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 32, "tentacle5");
		CT_RABoss_Schedule("CT_RABoss_CThun_EventHandler", 2, "gianttentacle5");
		CT_RABoss_VisualTimer.addTimer("CThunTentakle", 37, CT_RABOSS_CTHUN_TENTAKLE_TIMER);
		CT_RABoss_VisualTimer.addTimer("CThunGiantTentacle", 7, CT_RABOSS_CTHUN_GIANTTENTACLE[CT_RABoss_Mods["CThun"]["type"]], "orange");
	end

	if ( event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" and string.find(arg1, CT_RABOSS_CTHUN_EYE_BEAM_DETECT) ) then
		CT_RABoss_Announce(CT_RABOSS_CTHUN_EYE_BEAM_ALERT, CT_RABoss_Mods["CThun"]["announce"]);
	end

	-- Reseting mod when zoning
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		CT_RABoss_CThun_Reset();
	end
end
