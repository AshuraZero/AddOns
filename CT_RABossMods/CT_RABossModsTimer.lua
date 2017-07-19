-- CTRaidAssist - Boss Mods - visual timer frame

-- Visual Timer class
CT_RABoss_VisualTimer = {
	-- default values
	defaultColor = {["red"] = {[0] = 1.0; [1] = 0; [2] = 0; },
			["green"] = {[0] = 0; [1] = 1.0; [2] = 0; },
			["blue"] = {[0] = 0; [1] = 0; [2] = 1.0; },
			["yellow"] = {[0] = 1.0; [1] = 1.0; [2] = 0; },
			["orange"] = {[0] = 1.0; [1] = 0.5; [2] = 0; },
			["white"] = {[0] = 1.0; [1] = 1.0; [2] = 1.0; },
			["gray"] = {[0] = 0.8; [1] = 0.8; [2] = 0.8; },
			},
	defaultInfoText = "BossMod Timer",

	-- initialize variables
	barSetup = {},
	maxBars = 10,
	barSpacing = 17,
	currentBars = 0,
	elapsed = 0,
	elapsedFrameShow = 0,
	updateTime = 0.1,
	updateTimeFrameShow = 1.0,
	overrideTime = 2.0,
	preventUpdate = false,

	-- onLoad timer frame
	onLoad = function()
		-- position the bars
		local y = -3;
		for i=1, CT_RABoss_VisualTimer.maxBars do
			local bar = getglobal("CT_RABossVisualTimerFrameBar" .. i);
			local text = getglobal("CT_RABossVisualTimerFrameText" .. i);
			local status = getglobal("CT_RABossVisualTimerFrameStatus" .. i);
			bar:SetPoint("TOPLEFT", "CT_RABossVisualTimerFrame", "TOPLEFT", 3, y);
			text:SetPoint("CENTER", "CT_RABossVisualTimerFrameBar" .. i, "CENTER", 0, 1);
			status:SetPoint("TOPLEFT", "CT_RABossVisualTimerFrameBar" .. i, "TOPRIGHT", 3, -1);
			bar:SetID(i);
			y = y - CT_RABoss_VisualTimer.barSpacing;
		end

		this:RegisterEvent("VARIABLES_LOADED");
		this:RegisterEvent("CHAT_MSG_ADDON");
	end,

	-- onEvent counter frame
	onEvent = function()
		if ( event == "VARIABLES_LOADED" ) then
			UIDropDownMenu_Initialize(CT_RABossVisualTimerFrame_DropDown, CT_RABoss_VisualTimer.initializeMenuArray, "MENU");

			CT_RABossVisualTimerFrame:SetAlpha(CT_RABoss_Options["VTimerAlpha"]);
		elseif ( event == "CHAT_MSG_ADDON" and arg1 == "CTRA_BOSS" and arg3 == "RAID" ) then
			CT_RABoss_VisualTimer.receiveSync(arg2, arg4);
		end
	end,

	-- onUpdate counter frame
	onUpdate = function()
		if ( CT_RABossVisualTimerFrame:IsVisible() ) then
			if ( CT_RABoss_VisualTimer.currentBars > 0 ) then
				CT_RABoss_VisualTimer.elapsed = CT_RABoss_VisualTimer.elapsed + arg1;
				if ( CT_RABoss_VisualTimer.elapsed >= CT_RABoss_VisualTimer.updateTime ) then
					CT_RABoss_VisualTimer.elapsed = 0;
					CT_RABoss_VisualTimer.updateBars();
				end
			elseif ( CT_RABoss_VisualTimer.currentBars == 0 and not CT_RABossVisualTimerFrameBar1:IsVisible() ) then
				CT_RABossVisualTimerFrame:SetHeight(CT_RABoss_VisualTimer.barSpacing + 5);

				CT_RABossVisualTimerFrameText1:SetText(CT_RABOSS_VTIMER_NOTIMERS);
				CT_RABossVisualTimerFrameBar1:SetMinMaxValues(0, 1);
				CT_RABossVisualTimerFrameBar1:SetValue(0);

				CT_RABossVisualTimerFrameBar1:Show();
				CT_RABossVisualTimerFrameText1:Show();
			end
		end
	end,

	-- onUpdate periodic verification
	onUpdatePeriodic = function()
		CT_RABoss_VisualTimer.elapsedFrameShow = CT_RABoss_VisualTimer.elapsedFrameShow + arg1;
		if ( CT_RABoss_VisualTimer.elapsedFrameShow >= CT_RABoss_VisualTimer.updateTimeFrameShow ) then
			CT_RABoss_VisualTimer.elapsedFrameShow = 0;

			if ( not CT_RABossVisualTimerFrame:IsVisible() and CT_RABoss_Options["VTimerShow"] and GetNumRaidMembers() > 0 ) then
				CT_RABossVisualTimerFrame:Show();
			elseif ( ( CT_RABossVisualTimerFrame:IsVisible() and not CT_RABoss_Options["VTimerShow"] ) or GetNumRaidMembers() <= 0 ) then
				CT_RABossVisualTimerFrame:Hide();
			end
		end
	end,

	updateBars = function()
		if ( not CT_RABoss_VisualTimer.preventUpdate ) then
			local setupUpdate = false;

			for i=1, CT_RABoss_VisualTimer.maxBars do
				if ( CT_RABoss_VisualTimer.barSetup[i] ) then
					local newBarValue = CT_RABoss_VisualTimer.barSetup[i]["duration"] - (GetTime() - CT_RABoss_VisualTimer.barSetup[i]["start"]);

					local bar = getglobal("CT_RABossVisualTimerFrameBar" .. i);
					local status = getglobal("CT_RABossVisualTimerFrameStatus" .. i);
					if ( newBarValue > 0 ) then
						CT_RABoss_VisualTimer.barSetup[i]["current"] = newBarValue;

						bar:SetValue(CT_RABoss_VisualTimer.barSetup[i]["current"]);
						status:SetText(CT_RABoss_VisualTimer.getTimeString(CT_RABoss_VisualTimer.barSetup[i]["current"]));
					elseif ( CT_RABoss_VisualTimer.barSetup[i]["persist"] ) then
						CT_RABoss_VisualTimer.barSetup[i]["current"] = 0;
						bar:SetValue(0);
						status:Hide();
					else
						CT_RABoss_VisualTimer.barSetup[i] = nil;
						setupUpdate = true;
					end
				end
			end

			if ( setupUpdate ) then
				CT_RABoss_VisualTimer.updateBarSetup();
			end
		end
	end,

	updateBarSetup = function()
		local newBarSetup = {};
		local count = 0;

		-- prevent onEvent updates while we rearrange the bars
		CT_RABoss_VisualTimer.preventUpdate = true;

		for i=1, CT_RABoss_VisualTimer.maxBars do
			if ( CT_RABoss_VisualTimer.barSetup[i] ) then
				table.insert(newBarSetup, CT_RABoss_VisualTimer.barSetup[i]);
				count = count + 1;
			end
		end

		CT_RABoss_VisualTimer.barSetup = newBarSetup;
		CT_RABoss_VisualTimer.currentBars = count;

		for i=1, CT_RABoss_VisualTimer.maxBars do
			local bar = getglobal("CT_RABossVisualTimerFrameBar" .. i);
			local text = getglobal("CT_RABossVisualTimerFrameText" .. i);
			local status = getglobal("CT_RABossVisualTimerFrameStatus" .. i);

			if ( CT_RABoss_VisualTimer.barSetup[i] ) then
				text:SetText(CT_RABoss_VisualTimer.barSetup[i]["info"]);
				text:Show();
				bar:SetMinMaxValues(0, 1);
				bar:SetValue(0);
				if ( CT_RABoss_VisualTimer.barSetup[i]["duration"] > 0 ) then
					bar:SetStatusBarColor(CT_RABoss_VisualTimer.barSetup[i]["color"][0], CT_RABoss_VisualTimer.barSetup[i]["color"][1], CT_RABoss_VisualTimer.barSetup[i]["color"][2]);
					bar:SetMinMaxValues(0, CT_RABoss_VisualTimer.barSetup[i]["duration"]);
					bar:SetValue(CT_RABoss_VisualTimer.barSetup[i]["current"]);
				end
				bar:Show();
				if (CT_RABoss_VisualTimer.barSetup[i]["current"] > 0) then
					status:SetText(CT_RABoss_VisualTimer.getTimeString(CT_RABoss_VisualTimer.barSetup[i]["current"]));
					status:Show();
				end
			else
				bar:SetValue(0);
				bar:Hide();
				text:SetText("");
				text:Hide();
				status:SetText("");
				status:Hide();
			end
		end

		CT_RABossVisualTimerFrame:SetHeight(CT_RABoss_VisualTimer.currentBars * CT_RABoss_VisualTimer.barSpacing + 5);

		--release onEvent bar lock
		CT_RABoss_VisualTimer.preventUpdate = false;
	end,

	addTimer = function(id, duration, info, color, persist, override)
		if ( override == nil ) then override = true; end

		if ( id and (duration > 0 or duration == -1)) then
			local overrideId = 0;
			local newBarNum = 0;

			-- check for already existing timer id
			for i=1, CT_RABoss_VisualTimer.maxBars do
				if ( CT_RABoss_VisualTimer.barSetup[i] ) then
					if ( CT_RABoss_VisualTimer.barSetup[i]["id"] == id ) then
						local timeDiff = GetTime() - CT_RABoss_VisualTimer.barSetup[i]["start"];
						if ( override and timeDiff >= CT_RABoss_VisualTimer.overrideTime ) then
							overrideId = i;
						else
							return;
						end
						break;
					end
				end
			end

			if ( overrideId > 0 ) then
				newBarNum = overrideId;
			else
				newBarNum = CT_RABoss_VisualTimer.currentBars + 1;
			end
			if ( not CT_RABoss_VisualTimer.barSetup[newBarNum] or overrideId > 0 and newBarNum <= CT_RABoss_VisualTimer.maxBars ) then
				CT_RABoss_VisualTimer.barSetup[newBarNum] = {};

				CT_RABoss_VisualTimer.barSetup[newBarNum]["id"] = id;
				CT_RABoss_VisualTimer.barSetup[newBarNum]["start"] = GetTime();
				CT_RABoss_VisualTimer.barSetup[newBarNum]["duration"] = duration;
				CT_RABoss_VisualTimer.barSetup[newBarNum]["current"] = duration;
				if ( not info ) then info = CT_RABoss_VisualTimer.defaultInfoText; end
				CT_RABoss_VisualTimer.barSetup[newBarNum]["info"] = info;
				if ( color ) then color = string.lower(color); end
				if ( not CT_RABoss_VisualTimer.defaultColor[color] ) then color = "gray"; end
				CT_RABoss_VisualTimer.barSetup[newBarNum]["color"] = CT_RABoss_VisualTimer.defaultColor[color];
				CT_RABoss_VisualTimer.barSetup[newBarNum]["persist"] = persist;

				CT_RABoss_VisualTimer.updateBarSetup();

				if ( CT_RABoss_Options["VTimerSync"] and CT_RA_Level >= 1 ) then
					CT_RABoss_SendMessage("BMT " .. id .. "<>" .. duration .. "<>" .. info .. "<>" .. color);
					CT_RABoss_Debug(3, "Timer Sync Broadcasted", "<" .. id .. "> <" .. duration .. "> <" .. info .. "> <" .. color .. ">");
				end
			end
		end
	end,

	removeTimer = function(id)
		-- check for already existing timer id
		for i=1, CT_RABoss_VisualTimer.maxBars do
			if ( CT_RABoss_VisualTimer.barSetup[i] ) then
				if ( CT_RABoss_VisualTimer.barSetup[i]["id"] == id ) then
					CT_RABoss_VisualTimer.barSetup[i] = nil;

					CT_RABoss_VisualTimer.updateBarSetup();
					break;
				end
			end
		end
	end,

	updateTimer = function(id, current)
		--update current time for already existing timer id
		for i=1, CT_RABoss_VisualTimer.maxBars do
			if ( CT_RABoss_VisualTimer.barSetup[i] and CT_RABoss_VisualTimer.barSetup[i]["id"] == id ) then
				if ( type(current) == "number" ) then
					CT_RABoss_VisualTimer.barSetup[i]["current"] = current;
					CT_RABoss_VisualTimer.barSetup[i]["start"] = current + GetTime() -  CT_RABoss_VisualTimer.barSetup[i]["duration"];
				elseif ( type(current) == "string" and (string.byte(current) == 43 or string.byte(current) == 45) ) then
					CT_RABoss_VisualTimer.barSetup[i]["current"] = CT_RABoss_VisualTimer.barSetup[i]["current"] + tonumber(current);
					if ( CT_RABoss_VisualTimer.barSetup[i]["current"] > CT_RABoss_VisualTimer.barSetup[i]["duration"] ) then
						CT_RABoss_VisualTimer.barSetup[i]["duration"] = CT_RABoss_VisualTimer.barSetup[i]["current"];
					end
					CT_RABoss_VisualTimer.barSetup[i]["start"] = CT_RABoss_VisualTimer.barSetup[i]["current"] + GetTime() -  CT_RABoss_VisualTimer.barSetup[i]["duration"];
				end
				CT_RABoss_VisualTimer.updateBarSetup();
				break;
			end
		end
	end,

	getTimerCurrent = function (id)
		for i=1, CT_RABoss_VisualTimer.maxBars do
			if ( CT_RABoss_VisualTimer.barSetup[i] and CT_RABoss_VisualTimer.barSetup[i]["id"] == id ) then
				return CT_RABoss_VisualTimer.barSetup[i]["current"];
			end
		end
		return nil;
	end,

	removeAllTimers = function ()
		CT_RABoss_VisualTimer.barSetup = {};
		CT_RABoss_VisualTimer.updateBarSetup()
	end,

	receiveSync = function(sMessage, sSender)
		local bTrustedSync = false;
		local _, _, cId, cDuration, cInfo, cColor = string.find(sMessage, "^BMT (.*)<>(.*)<>(.*)<>(.*)");
		if ( cId and cDuration and cInfo and cColor ) then
			local numRaidMembers = GetNumRaidMembers();
			for i = 1, numRaidMembers, 1 do
				if ( UnitName("raid" .. i) == sSender ) then
					local _, rank = GetRaidRosterInfo(i);
					if ( rank >= 1 ) then
						bTrustedSync = true;
					end
					break;
				end
			end
			if ( bTrustedSync ) then
				CT_RABoss_Debug(3, "Timer Sync Received", "<" .. cId .. "> <" .. cDuration .. "> <" .. cInfo .. "> <" .. cColor .. "> @ " .. sMessage, sSender);
				CT_RABoss_VisualTimer.addTimer(cId, tonumber(cDuration), cInfo, cColor);
			end
		end
	end,

	getTimeString = function(duration)
		if ( duration > 0 ) then
			if ( duration <= 60 ) then
				return math.ceil(duration) .. CT_RABOSS_VTIMER_SECONDS;
			else
				local minutes = math.floor(duration / 60);
				local seconds = math.ceil(duration - (minutes * 60));

				return minutes .. CT_RABOSS_VTIMER_MINUTES .. " " .. seconds .. CT_RABOSS_VTIMER_SECONDS;
			end
		else
			return "0" .. CT_RABOSS_VTIMER_SECONDS;
		end
	end,

	initializeMenuArray = function()
		local info = { };
		table.insert(info, { text = "- " .. CT_RABOSS_VTIMER_MENU_HEADER .. " -", isTitle = 1, notCheckable = 1; });

		if ( CT_RABoss_Options["VTimerLocked"] ) then
			table.insert(info, { text = CT_RABOSS_VTIMER_MENU_UNLOCK, func = CT_RABoss_VisualTimer.frameOptions, value = "framelock", notCheckable = 1; });
		else
			table.insert(info, { text = CT_RABOSS_VTIMER_MENU_LOCK, func = CT_RABoss_VisualTimer.frameOptions, value = "framelock", notCheckable = 1; });
		end

		table.insert(info, { text = CT_RA_RS_MENU_OPACITY, func = CT_RABoss_VisualTimer.frameOptions, value = "Opacity", notCheckable = 1; });

		if ( CT_RABoss_VisualTimer.currentBars > 0 ) then
			table.insert(info, { text = CT_RABOSS_VTIMER_MENU_RESETTIMER, func = CT_RABoss_VisualTimer.frameOptions, value = "resetAll", notCheckable = 1; });
		end

		table.insert(info, { text = "|c00FF8080" .. CT_RABOSS_VTIMER_MENU_HIDE .. "|r", func = CT_RABoss_VisualTimer.frameOptions, value = "hide", notCheckable = 1; });

		for index, menuLine in info do
			UIDropDownMenu_AddButton(menuLine);
		end
	end,

	frameOptions = function()
		if ( this.value == "framelock" ) then
			if ( CT_RABoss_Options["VTimerLocked"] ) then
				CT_RABoss_Options["VTimerLocked"] = false;
				this:SetText(CT_RABOSS_VTIMER_MENU_LOCK);
			else
				CT_RABoss_Options["VTimerLocked"] = true;
				this:SetText(CT_RABOSS_VTIMER_MENU_UNLOCK);
			end
		elseif ( this.value == "hide" ) then
			CT_RABossOptions_Toggle("VTimerShow");
		elseif ( this.value == "resetAll" ) then
			CT_RABoss_VisualTimer.removeAllTimers();
		elseif ( this.value == "Opacity" ) then
			if ( not OpacityFrame:IsVisible() ) then
				CT_RABoss_VisualTimer.frameOpacityShow();
			else
				OpacityFrame:Hide();
			end
		end
	end,

	frameOpacityShow = function()
		OpacityFrame:ClearAllPoints();
		OpacityFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		OpacityFrameSlider:SetValue(CT_RABoss_Options["VTimerAlpha"]);
		OpacityFrame.opacityFunc = CT_RABoss_VisualTimer.frameOpacitySet;
		OpacityFrame.saveOpacityFunc = CT_RABoss_VisualTimer.frameOpacitySave;
		OpacityFrame:Show();
	end,

	frameOpacitySet = function()
		local alpha = OpacityFrameSlider:GetValue();
		if ( alpha < 0.2 ) then
			alpha = 0.2;
		end

		CT_RABossVisualTimerFrame:SetAlpha(alpha);
	end,

	frameOpacitySave = function()
		local alpha = OpacityFrameSlider:GetValue();

		CT_RABoss_Options["VTimerAlpha"] = alpha;
	end,
};