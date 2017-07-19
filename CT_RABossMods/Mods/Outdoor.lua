tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Azuregos_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Drakes_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Emeriss_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Lethon_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Ysondre_OnLoad");
tinsert(CT_RABoss_ModsToLoad, "CT_RABoss_Taerar_OnLoad");


-- Azuregos
function CT_RABoss_Azuregos_OnLoad()
	CT_RABoss_AddMod("Azuregos", CT_RABOSS_AZUREGOS_INFO, 1, CT_RABOSS_LOCATIONS_OUTDOOR);
	
	CT_RABoss_AddEvent("Azuregos", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Azuregos_EventHandler);
	CT_RABoss_AddEvent("Azuregos", "CHAT_MSG_SPELL_AURA_GONE_OTHER", CT_RABoss_Azuregos_EventHandler);
	CT_RABoss_AddEvent("Azuregos", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS", CT_RABoss_Azuregos_EventHandler);
	
	CT_RABoss_AddDropDownButton("Azuregos", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
end

function CT_RABoss_Azuregos_EventHandler(event)
	if ( not CT_RABoss_Mods["Azuregos"] or not CT_RABoss_Mods["Azuregos"]["status"] or not CT_RABoss_Mods["Azuregos"].enabled ) then
		return;
	end
	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS" and string.find(arg1, CT_RABOSS_AZUREGOS_REFLECTION) ) then
		CT_RABoss_Announce(CT_RABOSS_AZUREGOS_SHIELDWARN, CT_RABoss_Mods["Azuregos"]["announce"]);
		CT_RABoss_PlaySound(3);
		
	elseif ( event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" and string.find(arg1, CT_RABOSS_AZUREGOS_REFLECTION_END) ) then
		CT_RABoss_Announce(CT_RABOSS_AZUREGOS_SHIELDDOWN, CT_RABoss_Mods["Azuregos"]["announce"]);
		CT_RABoss_PlaySound(2);
		
	elseif ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_AZUREGOS_TELEPORT) ) then
		CT_RABoss_Announce(CT_RABOSS_AZUREGOS_PORTWARN, CT_RABoss_Mods["Azuregos"]["announce"]);
		CT_RABoss_PlaySound(1);
	end
end


-- Emerald drakes
function CT_RABoss_Drakes_OnLoad()
	CT_RABoss_AddMod("Drakes", CT_RABOSS_DRAKES_INFO, 1, CT_RABOSS_LOCATIONS_OUTDOOR);
	
	CT_RABoss_AddEvent("Drakes", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Drakes_EventHandler);
	CT_RABoss_AddEvent("Drakes", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Drakes_EventHandler);
	CT_RABoss_AddEvent("Drakes", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Drakes_EventHandler);
	
	CT_RABoss_AddDropDownButton("Drakes", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Drakes", { CT_RABOSS_DRAKES_BREATH, CT_RABOSS_DRAKES_BREATH_INFO }, "CT_RABoss_ModInfo", "enableBreath", "CT_RABoss_SetInfo");
end

function CT_RABoss_Drakes_EventHandler(event)
	if ( not CT_RABoss_Mods["Drakes"] or not CT_RABoss_Mods["Drakes"]["status"] or not CT_RABoss_Mods["Drakes"].enabled ) then
		return;
	end

	-- Breath alert
	if ( event == "breathWarning" and CT_RABoss_Mods["Drakes"]["enableBreath"] ) then
		CT_RABoss_Mods["Drakes"]["BreathTrip"] = false;
		CT_RABoss_Announce(CT_RABOSS_DRAKES_BREATH_PREALERT, CT_RABoss_Mods["Drakes"]["announce"]);
		CT_RABoss_PlaySound(3);
	
	-- Breath prealert
	elseif ( ( string.find(arg1, CT_RABOSS_DRAKES_BREATH_DETECT) ) and not CT_RABoss_Mods["Drakes"]["BreathTrip"] and CT_RABoss_Mods["Drakes"]["enableBreath"] ) then
		CT_RABoss_Mods["Drakes"]["BreathTrip"] = true;
		CT_RABoss_Announce(CT_RABOSS_DRAKES_BREATH_ALERT, CT_RABoss_Mods["Drakes"]["announce"]);
		CT_RABoss_PlaySound(1);
		CT_RABoss_Schedule("CT_RABoss_Drakes_EventHandler", 25, "breathWarning");
		CT_RABoss_VisualTimer.addTimer("DrakesBreath", 30, CT_RABOSS_DRAKES_BREATH_TIMER);
	end
end


-- Emeriss
function CT_RABoss_Emeriss_OnLoad()
	CT_RABoss_AddMod("Emeriss", CT_RABOSS_EMERISS_INFO, 1, CT_RABOSS_LOCATIONS_OUTDOOR);

	CT_RABoss_AddEvent("Emeriss", "UNIT_HEALTH", CT_RABoss_Lethon_EventHandler);
	CT_RABoss_AddEvent("Emeriss", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Emeriss_EventHandler);
	CT_RABoss_AddEvent("Emeriss", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", CT_RABoss_Emeriss_EventHandler);
	CT_RABoss_AddEvent("Emeriss", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", CT_RABoss_Emeriss_EventHandler);
	CT_RABoss_AddEvent("Emeriss", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", CT_RABoss_Emeriss_EventHandler);

	CT_RABoss_AddDropDownButton("Emeriss", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Emeriss", { CT_RABOSS_EMERISS_ALERT_NEARBY, CT_RABOSS_EMERISS_ALERT_NEARBY_INFO }, "CT_RABoss_ModInfo", "alertNearby", "CT_RABoss_SetInfo");
	CT_RABoss_AddDropDownButton("Emeriss", { CT_RABOSS_EMERISS_TELL_TARGET, CT_RABOSS_EMERISS_TELL_TARGET_INFO }, "CT_RABoss_ModInfo", "sendTell", "CT_RABoss_SetInfo");
	
	CT_RABoss_SetVar("Emeriss", "alertNearby", 1);
	CT_RABoss_Mods["Emeriss"]["healthLow"] = 80;
	CT_RABoss_Mods["Emeriss"]["preAlert"] = true;
end

function CT_RABoss_Emeriss_EventHandler(event)
	if ( not CT_RABoss_Mods["Emeriss"] or not CT_RABoss_Mods["Emeriss"]["status"] or not CT_RABoss_Mods["Emeriss"].enabled ) then
		return;
	end
	
	-- Disease alert
	if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" or ( ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE" ) and CT_RABoss_Mods["Emeriss"]["alertNearby"] ) ) then
		local iStart, iEnd, sPlayer = string.find(arg1, CT_RABOSS_EMERISS_AFFLICT_BOMB);
		if ( sPlayer ) then
			if ( sPlayer == CT_RABOSS_SELF1 ) then
				CT_RABoss_Announce(CT_RABOSS_EMERISS_DISEASE_ALERT_YOU);
				CT_RABoss_Announce(CT_RABOSS_EMERISS_DISEASE_ALERT_YOU);
				CT_RABoss_PlaySound(2);
				if ( CT_RA_Level >= 1 and CT_RABoss_Mods["Emeriss"]["announce"] and CT_RABoss_Mods["Emeriss"]["alertNearby"] ) then
					SendChatMessage("*** " .. UnitName("player") .. CT_RABOSS_EMERISS_DISEASE_ALERT, "RAID_WARNING");
				end
				
			elseif ( CT_RABoss_Mods["Emeriss"]["alertNearby"] or CT_RABoss_Mods["Emeriss"]["sendTell"] ) then
				if ( CT_RABoss_Mods["Emeriss"]["sendTell"] ) then
					SendChatMessage(CT_RABOSS_EMERISS_DISEASE_TELL, "WHISPER", nil, sPlayer);
				end
				if ( CT_RABoss_Mods["Emeriss"]["alertNearby"] ) then
					CT_RABoss_Announce("*** " .. sPlayer .. CT_RABOSS_EMERISS_DISEASE_ALERT, CT_RABoss_Mods["Emeriss"]["announce"]);
					CT_RABoss_PlaySound(2);
				end
			end
		end
	end

	-- Begin  initialization
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_EMERISS_BEGIN) and arg2 == CT_RABOSS_NAMES["Emeriss"] ) then
		CT_RABoss_Mods["Emeriss"]["healthLow"] = 80;
		CT_RABoss_Mods["Emeriss"]["preAlert"] = true;
	end

	-- Event alert
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_EMERISS_EVENT) and arg2 == CT_RABOSS_NAMES["Emeriss"] ) then
		CT_RABoss_Announce(CT_RABOSS_EMERISS_EVENT_ALERT, CT_RABoss_Mods["Emeriss"]["announce"]);
		CT_RABoss_Mods["Emeriss"]["healthLow"] = CT_RABoss_Mods["Emeriss"]["healthLow"] - 25;
		CT_RABoss_Mods["Emeriss"]["preAlert"] = true;
	end

	-- Event pre-alert
	if ( UnitName("target") == CT_RABOSS_NAMES["Emeriss"] and CT_RABoss_Mods["Emeriss"]["preAlert"] ) then
		local targetHealth = UnitHealth("target");
		
		-- Alert near event
		if ( targetHealth <= CT_RABoss_Mods["Emeriss"]["healthLow"] and targetHealth > CT_RABoss_Mods["Emeriss"]["healthLow"]-3 and targetHealth > 15 ) then
			CT_RABoss_Mods["Emeriss"]["preAlert"] = false;
			CT_RABoss_Announce(CT_RABOSS_EMERISS_EVENT_PREALERT, CT_RABoss_Mods["Emeriss"]["announce"]);
		end
	end
end


-- Lethon
function CT_RABoss_Lethon_OnLoad()
	CT_RABoss_AddMod("Lethon", CT_RABOSS_LETHON_INFO, 1, CT_RABOSS_LOCATIONS_OUTDOOR);

	CT_RABoss_AddEvent("Lethon", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Lethon_EventHandler);
	CT_RABoss_AddEvent("Lethon", "UNIT_HEALTH", CT_RABoss_Lethon_EventHandler);

	CT_RABoss_AddDropDownButton("Lethon", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");

	CT_RABoss_Mods["Lethon"]["healthLow"] = 80;
	CT_RABoss_Mods["Lethon"]["preAlert"] = true;
end

function CT_RABoss_Lethon_EventHandler(event)
	if ( not CT_RABoss_Mods["Lethon"] or not CT_RABoss_Mods["Lethon"]["status"] or not CT_RABoss_Mods["Lethon"].enabled ) then
		return;
	end

	-- Begin  initialization
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_LETHON_BEGIN) and arg2 == CT_RABOSS_NAMES["Lethon"] ) then
		CT_RABoss_Mods["Lethon"]["healthLow"] = 80;
		CT_RABoss_Mods["Lethon"]["preAlert"] = true;
	end

	-- Event alert
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_LETHON_EVENT) and arg2 == CT_RABOSS_NAMES["Lethon"] ) then
		CT_RABoss_Announce(CT_RABOSS_LETHON_EVENT_ALERT, CT_RABoss_Mods["Lethon"]["announce"]);
		CT_RABoss_Mods["Lethon"]["healthLow"] = CT_RABoss_Mods["Lethon"]["healthLow"] - 25;
		CT_RABoss_Mods["Lethon"]["preAlert"] = true;
	end

	-- Event pre-alert
	if ( UnitName("target") == CT_RABOSS_NAMES["Lethon"] and CT_RABoss_Mods["Lethon"]["preAlert"] ) then
		local targetHealth = UnitHealth("target");
		
		-- Alert near event
		if ( targetHealth <= CT_RABoss_Mods["Lethon"]["healthLow"] and targetHealth > CT_RABoss_Mods["Lethon"]["healthLow"]-3 and targetHealth > 15 ) then
			CT_RABoss_Mods["Lethon"]["preAlert"] = false;
			CT_RABoss_Announce(CT_RABOSS_LETHON_EVENT_PREALERT, CT_RABoss_Mods["Lethon"]["announce"]);
		end
	end
end


-- Ysondre
function CT_RABoss_Ysondre_OnLoad()
	CT_RABoss_AddMod("Ysondre", CT_RABOSS_YSONDRE_INFO, 1, CT_RABOSS_LOCATIONS_OUTDOOR);

	CT_RABoss_AddEvent("Ysondre", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Ysondre_EventHandler);
	CT_RABoss_AddEvent("Ysondre", "UNIT_HEALTH", CT_RABoss_Ysondre_EventHandler);

	CT_RABoss_AddDropDownButton("Ysondre", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");

	CT_RABoss_Mods["Ysondre"]["healthLow"] = 80;
	CT_RABoss_Mods["Ysondre"]["preAlert"] = true;
end

function CT_RABoss_Ysondre_EventHandler(event)
	if ( not CT_RABoss_Mods["Ysondre"] or not CT_RABoss_Mods["Ysondre"]["status"] or not CT_RABoss_Mods["Ysondre"].enabled ) then
		return;
	end

	-- Begin  initialization
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_YSONDRE_BEGIN) and arg2 == CT_RABOSS_NAMES["Ysondre"] ) then
		CT_RABoss_Mods["Ysondre"]["healthLow"] = 80;
		CT_RABoss_Mods["Ysondre"]["preAlert"] = true;
	end

	-- Event alert
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_YSONDRE_EVENT) and arg2 == CT_RABOSS_NAMES["Ysondre"] ) then
		CT_RABoss_Announce(CT_RABOSS_YSONDRE_EVENT_ALERT, CT_RABoss_Mods["Ysondre"]["announce"]);
		CT_RABoss_Mods["Ysondre"]["healthLow"] = CT_RABoss_Mods["Ysondre"]["healthLow"] - 25;
		CT_RABoss_Mods["Ysondre"]["preAlert"] = true;
	end

	-- Event pre-alert
	if ( UnitName("target") == CT_RABOSS_NAMES["Ysondre"] and CT_RABoss_Mods["Ysondre"]["preAlert"] ) then
		local targetHealth = UnitHealth("target");
		
		-- Alert near event
		if ( targetHealth <= CT_RABoss_Mods["Ysondre"]["healthLow"] and targetHealth > CT_RABoss_Mods["Ysondre"]["healthLow"]-3 and targetHealth > 15 ) then
			CT_RABoss_Mods["Ysondre"]["preAlert"] = false;
			CT_RABoss_Announce(CT_RABOSS_YSONDRE_EVENT_PREALERT, CT_RABoss_Mods["Ysondre"]["announce"]);
		end
	end
end


-- Taerar
function CT_RABoss_Taerar_OnLoad()
	CT_RABoss_AddMod("Taerar", CT_RABOSS_TAERAR_INFO, 1, CT_RABOSS_LOCATIONS_OUTDOOR);

	CT_RABoss_AddEvent("Taerar", "CHAT_MSG_MONSTER_YELL", CT_RABoss_Taerar_EventHandler);
	CT_RABoss_AddEvent("Taerar", "UNIT_HEALTH", CT_RABoss_Taerar_EventHandler);

	CT_RABoss_AddDropDownButton("Taerar", { CT_RABOSS_ANNOUNCE, CT_RABOSS_ANNOUNCE_INFO .. CT_RABOSS_REQ_LEADER_OR_PROM }, "CT_RABoss_ModInfo", "announce", "CT_RABoss_SetInfo");

	CT_RABoss_Mods["Taerar"]["healthLow"] = 80;
	CT_RABoss_Mods["Taerar"]["preAlert"] = true;
end

function CT_RABoss_Taerar_EventHandler(event)
	if ( not CT_RABoss_Mods["Taerar"] or not CT_RABoss_Mods["Taerar"]["status"] or not CT_RABoss_Mods["Taerar"].enabled ) then
		return;
	end

	-- Begin  initialization
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_TAERAR_BEGIN) and arg2 == CT_RABOSS_NAMES["Taerar"] ) then
		CT_RABoss_Mods["Taerar"]["healthLow"] = 80;
		CT_RABoss_Mods["Taerar"]["preAlert"] = true;
	end

	-- Event alert
	if ( event == "CHAT_MSG_MONSTER_YELL" and string.find(arg1, CT_RABOSS_TAERAR_EVENT) and arg2 == CT_RABOSS_NAMES["Taerar"] ) then
		CT_RABoss_Announce(CT_RABOSS_TAERAR_EVENT_ALERT, CT_RABoss_Mods["Taerar"]["announce"]);
		CT_RABoss_Mods["Taerar"]["healthLow"] = CT_RABoss_Mods["Taerar"]["healthLow"] - 25;
		CT_RABoss_Mods["Taerar"]["preAlert"] = true;
	end

	-- Event pre-alert
	if ( UnitName("target") == CT_RABOSS_NAMES["Taerar"] and CT_RABoss_Mods["Taerar"]["preAlert"] ) then
		local targetHealth = UnitHealth("target");
		
		-- Alert near event
		if ( targetHealth <= CT_RABoss_Mods["Taerar"]["healthLow"] and targetHealth > CT_RABoss_Mods["Taerar"]["healthLow"]-3 and targetHealth > 15 ) then
			CT_RABoss_Mods["Taerar"]["preAlert"] = false;
			CT_RABoss_Announce(CT_RABOSS_TAERAR_EVENT_PREALERT, CT_RABoss_Mods["Taerar"]["announce"]);
		end
	end
end