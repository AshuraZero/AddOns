-- CTRaidAssist - Boss Mods - Counter synchronization
-- all credits go to Kep and his ccNef AddOn (http://www.curse-gaming.com/mod.php?addid=3237)

CT_RABoss_Counter = {
	-- default values
	discardTime = 380,					-- counts on same item within this time get discarded
	alertDisplayNth = 5,					-- only display every Nth count warning
	alertDisplayLast = 5,					-- always display those last count warnings
	alertMessageDefault = "*** counted: %s/%s ***",		-- default CTRaid warn message for counter
	displayEstEnd = false,					-- switch to enable/disable display of estimated remaining time to reach maxCount
	autoReset = true,					-- switch to enable/disable automatic reset when reaching maxCount

	-- initialized variables
	countData = {},

	initialize = function(boss, event, doSync, doAnnounce, maxCount, mobArray, alertMessage, countHeader)
		if ( boss ~= nil and event ~= nil and maxCount > 0 and mobArray ~= nil ) then
			if ( not CT_RABoss_Counter.countData[boss] ) then
				CT_RABoss_Counter.countData[boss] = {};
			end
			if ( not CT_RABoss_Counter.countData[boss][event] ) then
				CT_RABoss_Counter.countData[boss][event] = {};
			end

			CT_RABoss_Counter.countData[boss][event]["sync"] = doSync;
			CT_RABoss_Counter.countData[boss][event]["announce"] = doAnnounce;
			CT_RABoss_Counter.countData[boss][event]["maxCount"] = maxCount;
			if ( alertMessage ~= "" ) then
				CT_RABoss_Counter.countData[boss][event]["alertMessage"] = alertMessage;
			else
				CT_RABoss_Counter.countData[boss][event]["alertMessage"] = CT_RABoss_Counter.alertMessageDefault;
			end
			CT_RABoss_Counter.countData[boss][event]["mobArray"] = mobArray;
			CT_RABoss_Counter.countData[boss][event]["mobs"] = {};
			CT_RABoss_Counter.countData[boss][event]["discarded"] = 0;
			CT_RABoss_Counter.countData[boss][event]["killcount"] = 0;
			CT_RABoss_Counter.countData[boss][event]["start"] = nil;

			CT_RABoss_Counter.countData[boss][event]["discardTime"] = CT_RABoss_Counter.discardTime;
			CT_RABoss_Counter.countData[boss][event]["alertDisplayNth"] = CT_RABoss_Counter.alertDisplayNth;
			CT_RABoss_Counter.countData[boss][event]["alertDisplayLast"] = CT_RABoss_Counter.alertDisplayLast;
			CT_RABoss_Counter.countData[boss][event]["displayEstEnd"] = CT_RABoss_Counter.displayEstEnd;
			CT_RABoss_Counter.countData[boss][event]["autoReset"] = CT_RABoss_Counter.autoReset;

			if ( countHeader == nil ) then
				CT_RABoss_Counter.countData[boss][event]["countHeader"] = CT_RABOSS_COUNT_TITLE;
			else
				CT_RABoss_Counter.countData[boss][event]["countHeader"] = countHeader;
			end

			-- setup frame
			CT_RABossCountFrame_Label:SetText("- " .. boss .. " -\n" .. CT_RABoss_Counter.countData[boss][event]["countHeader"]);
			CT_RABossCountFrame_Count:SetText( "0" );
			CT_RABossCountFrame_EstEnd:SetText( "|cffffffff" .. format(CT_RABOSS_SYNC_ESTEND, "???") .. "|r" );
		end
	end,

	setOptions = function(boss, event, options)
		if ( boss ~= nil and event ~= nil and options ~= nil and CT_RABoss_Counter.countData[boss] ~= nil ) then
			if (CT_RABoss_Counter.countData[boss][event] ~= nil ) then
				if ( options["discardTime"] ~= nil and tonumber(options["discardTime"]) >= 100 ) then
					CT_RABoss_Counter.countData[boss][event]["discardTime"] = tonumber(options["discardTime"]);
				end
				if ( options["alertDisplayNth"] ~= nil and tonumber(options["alertDisplayNth"]) > 0 ) then
					CT_RABoss_Counter.countData[boss][event]["alertDisplayNth"] = tonumber(options["alertDisplayNth"]);
				end
				if ( options["alertDisplayLast"] ~= nil and tonumber(options["alertDisplayLast"]) > 0 ) then
					CT_RABoss_Counter.countData[boss][event]["alertDisplayLast"] = tonumber(options["alertDisplayLast"]);
				end
				if ( options["displayEstEnd"] ~= nil and (options["displayEstEnd"] == true or options["displayEstEnd"] == false) ) then
					CT_RABoss_Counter.countData[boss][event]["displayEstEnd"] = options["displayEstEnd"];
				end
				if ( options["autoReset"] ~= nil and (options["autoReset"] == true or options["autoReset"] == false) ) then
					CT_RABoss_Counter.countData[boss][event]["autoReset"] = options["autoReset"];
				end
			end
		end
	end,
	
	isDuplicate = function(sMob, sReporter, boss, event)
		local duplicate = true;
		if ( boss ~= nil and event ~= nil ) then
			if ( CT_RABoss_Counter.countData[boss][event]["mobs"][sMob] ~= nil ) then
				if ( CT_RABoss_Counter.countData[boss][event]["mobs"][sMob]["reporter"] == sReporter ) then
					duplicate = false;
				else
					local i = debugprofilestop() - CT_RABoss_Counter.countData[boss][event]["mobs"][sMob]["last"];
					if ( i > CT_RABoss_Counter.countData[boss][event]["discardTime"] ) then
						duplicate = false;
					end
				end
			else
				duplicate = false;
			end
			
			if ( duplicate ) then
				CT_RABoss_Counter.countData[boss][event]["discarded"] = CT_RABoss_Counter.countData[boss][event]["discarded"] + 1;
			end
		end
		return duplicate;
	end,
	
	add = function(sMob, sReporter, boss, event)
		local d = CT_RABoss_Counter.isDuplicate(sMob, sReporter, boss, event);
		if ( boss ~= nil and event ~= nil and not d ) then
			if  ( CT_RABoss_Counter.countData[boss][event]["mobs"][sMob] == nil ) then
				CT_RABoss_Counter.countData[boss][event]["mobs"][sMob] = {alias, total, reporter, last}
				CT_RABoss_Counter.countData[boss][event]["mobs"][sMob]["total"] = 1;
			else
				CT_RABoss_Counter.countData[boss][event]["mobs"][sMob]["total"] = CT_RABoss_Counter.countData[boss][event]["mobs"][sMob]["total"] + 1;
			end
			
			if ( CT_RABoss_Counter.countData[boss][event]["killcount"] <= CT_RABoss_Counter.countData[boss][event]["maxCount"] ) then
				CT_RABoss_Counter.countData[boss][event]["mobs"][sMob]["reporter"] = sReporter;
				CT_RABoss_Counter.countData[boss][event]["mobs"][sMob]["last"] = debugprofilestop();
				CT_RABoss_Counter.countData[boss][event]["killcount"] = CT_RABoss_Counter.countData[boss][event]["killcount"] + 1;
				if ( CT_RABoss_Counter.countData[boss][event]["start"] == nil ) then
					CT_RABoss_Counter.countData[boss][event]["start"] = GetTime();
				end

				local mobName = CT_RABoss_Counter_MobData.getNameById(sMob, boss, event);
				if ( mobName == nil ) then mobName = "???"; end
				CT_RABoss_Debug(3, "Count Added", "[" .. sMob .. "] ".. mobName .. " (" .. CT_RABoss_Counter.countData[boss][event]["mobs"][sMob]["total"] .. ") - " .. CT_RABoss_Counter.countData[boss][event]["killcount"] .. "/" .. CT_RABoss_Counter.countData[boss][event]["maxCount"]);

				-- update count frame
				if ( CT_RABossCountFrame:IsVisible() or CT_RABoss_Options["CounterShow"] ) then
					CT_RABossCountFrame_Count:SetText( CT_RABoss_Counter.countData[boss][event]["killcount"] );

					-- calculate estimated time left
					local est = 0;
					local ks = CT_RABoss_Counter.killspeed(boss, event);
					if ( ks > 0 ) then
						est = (CT_RABoss_Counter.countData[boss][event]["maxCount"] - CT_RABoss_Counter.countData[boss][event]["killcount"]) / ks;
					end
					est = math.floor(est);

					CT_RABossCountFrame_EstEnd:SetText( "|cffffffff" .. format(CT_RABOSS_SYNC_ESTEND, est) .. "|r" );

					-- show frame in case it is hidden why ever
					if ( not CT_RABossCountFrame:IsVisible() ) then
						CT_RABossCountFrame:Show();
					end
				end

				local countLimit = CT_RABoss_Counter.countData[boss][event]["maxCount"] - CT_RABoss_Counter.countData[boss][event]["alertDisplayLast"];
				if ( mod(CT_RABoss_Counter.countData[boss][event]["killcount"], CT_RABoss_Counter.countData[boss][event]["alertDisplayNth"]) == 0 or CT_RABoss_Counter.countData[boss][event]["killcount"] > countLimit or CT_RABoss_Counter.countData[boss][event]["killcount"] == 1) then
					CT_RABoss_Announce(format(CT_RABoss_Counter.countData[boss][event]["alertMessage"], CT_RABoss_Counter.countData[boss][event]["killcount"], CT_RABoss_Counter.countData[boss][event]["maxCount"]), CT_RABoss_Counter.countData[boss][event]["announce"]);
					CT_RABoss_PlaySound(3);

					if ( CT_RABoss_Counter.countData[boss][event]["displayEstEnd"] and CT_RABoss_Counter.countData[boss][event]["killcount"] >= 3 and CT_RABoss_Counter.countData[boss][event]["killcount"] ~= CT_RABoss_Counter.countData[boss][event]["maxCount"] and not CT_RABoss_Options["CounterShow"]) then
						local est = 0;
						local ks = CT_RABoss_Counter.killspeed(boss, event);
						if ( ks > 0 ) then
							est = (CT_RABoss_Counter.countData[boss][event]["maxCount"] - CT_RABoss_Counter.countData[boss][event]["killcount"]) / ks;
						end
						est = math.floor(est);
						CT_RA_Print("<CTRaid " .. boss .. " " .. event .. ">" .. CT_RABoss_Counter.countData[boss][event]["killcount"] .. "/" .. CT_RABoss_Counter.countData[boss][event]["maxCount"] .. " - " .. format(CT_RABOSS_SYNC_ESTEND, est), 1, 1, 0);
					end
				end

				-- automatic reset on reaching maxCount
				if ( CT_RABoss_Counter.countData[boss][event]["autoReset"] and CT_RABoss_Counter.countData[boss][event]["killcount"] >= CT_RABoss_Counter.countData[boss][event]["maxCount"] ) then
					CT_RABoss_Counter.reset(boss, event);
					CT_RABoss_Debug(3, "Count Auto Reset", boss, event);

					if ( CT_RABossCountFrame:IsVisible() ) then
						CT_RABossCountFrame:Hide();
					end
				end

				return true;
			end
		end
		return false;
	end,
	
	reset = function(boss, event)
		if ( boss ~= nil and event ~= nil and CT_RABoss_Counter.countData[boss] ~= nil ) then
			CT_RABoss_Counter.countData[boss][event] = nil;
		end
	end,
	
	killspeed = function(boss, event)
		if ( boss ~= nil and event ~= nil and CT_RABoss_Counter.countData[boss] ~= nil ) then
			if ( CT_RABoss_Counter.countData[boss][event] ) then
				if ( CT_RABoss_Counter.countData[boss][event]["start"] == nil ) then return 0; end;
				local t = GetTime() - CT_RABoss_Counter.countData[boss][event]["start"];
				if ( t <= 0 ) then return 0; end;
				return (CT_RABoss_Counter.countData[boss][event]["killcount"] / t);
			end
		end
		return 0;
	end,

	sendSync = function(mobName, boss, event)
		if ( boss ~= nil and event ~= nil and mobName ~= nil and CT_RABoss_Counter.countData[boss] ~= nil ) then
			if ( CT_RABoss_Counter.countData[boss][event] ~= nil ) then
				local id = CT_RABoss_Counter_MobData.getIdByName(mobName, boss, event);
				if ( id ) then
					mobName = id;
				else
					CT_RABoss_Debug(3, "Sync Send", "Unknown MobName", mobName);
					return false;
				end

				if ( CT_RABoss_Counter.countData[boss][event]["sync"] ) then
					CT_RA_AddMessage("BMY " .. boss .. " # " .. event .. " # " .. mobName);
					CT_RABoss_Debug(3, "Sync Broadcasted", "<" .. boss .. "> <" .. event .. "> " .. mobName);
				else
					CT_RABoss_Counter.add(mobName, nil, boss, event);
				end
			end
		end
	end,

	receiveSync = function(sMessage, sSender, boss, event)
		if ( boss ~= nil and event ~= nil and sSender ~= nil and CT_RABoss_Counter.countData[boss] ~= nil ) then
			if ( CT_RABoss_Counter.countData[boss][event] ~= nil ) then
				--if ( CT_RABoss_Counter.countData[boss][event]["sync"] ) then
					local _, _, cBoss, cEvent, cItem = string.find(sMessage, "^BMY (.*) # (.*) # ([%d])");
					if ( cItem and cBoss == boss and cEvent == event ) then
						if ( CT_RABoss_Counter.countData[boss][event]["maxCount"] > 0 ) then
							CT_RABoss_Debug(3, "Sync Received", cBoss .. ", " .. cEvent .. ", " .. cItem, sSender);

							local name = CT_RABoss_Counter_MobData.getNameById(cItem, boss, event);
							if ( name ~= nil ) then
								CT_RABoss_Counter.add(cItem, sSender, boss, event);
							else
								CT_RABoss_Debug(3, "Sync Received", "Unknown Id", cItem);
							end
							
						end
					end
				--end
			end
		end
	end,
};

CT_RABoss_Counter_MobData = {	
	getNameById = function(id, boss, event)
		if ( boss ~= nil and event ~= nil and id ~= "" ) then
			if ( CT_RABoss_Counter.countData[boss][event]["mobArray"][tonumber(id)] ) then
				return CT_RABoss_Counter.countData[boss][event]["mobArray"][tonumber(id)];
			end
		end
		return nil;
	end,
	
	getIdByName = function(name, boss, event)
		if ( boss ~= nil and event ~= nil and name ~= "" ) then
			for k, v in pairs(CT_RABoss_Counter.countData[boss][event]["mobArray"]) do
				if ( v == name ) then
					return k;
				end
			end
		end
		return nil;
	end
};