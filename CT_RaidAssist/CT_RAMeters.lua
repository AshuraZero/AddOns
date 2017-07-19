-- CTRaidAssist - visual raid status bars

-- Raid Status class
CT_RARaidOverview = {
	-- default values
	typeClasses = {
		[CT_RA_WARRIOR]	= "WARRIOR",
		[CT_RA_ROGUE]	= "ROGUE",
		[CT_RA_HUNTER]	= "HUNTER",
		[CT_RA_MAGE]	= "MAGE",
		[CT_RA_WARLOCK]	= "WARLOCK",
		[CT_RA_DRUID]	= "DRUID",
		[CT_RA_PRIEST]	= "PRIEST",
		[CT_RA_SHAMAN]	= "SHAMAN",
		[CT_RA_PALADIN] = "PALADIN",
	};

	-- initialize variables
	maxBars = 20,
	maxListLength = 20;
	barSpacing = 17,
	elapsed = 0,
	updateTime = 1.0,
	statusTable = {},
	barSetup = {},
	numRaidMembers = 0,
	numPartyMembers = 0,

	-- onLoad raid status frame
	onLoad = function()
		-- position the bars
		local y = -3;
		for i=1, CT_RARaidOverview.maxBars do
			local bar = getglobal("CT_RARaidOverviewFrameBar" .. i);
			local text = getglobal("CT_RARaidOverviewFrameText" .. i);
			local tcount = getglobal("CT_RARaidOverviewFrameCount" .. i);
			local status = getglobal("CT_RARaidOverviewFrameStatus" .. i);
			bar:SetPoint("TOPLEFT", "CT_RARaidOverviewFrame", "TOPLEFT", 3, y);
			text:SetPoint("TOPLEFT", "CT_RARaidOverviewFrameBar" .. i, "TOPLEFT", 3, 0);
			tcount:SetPoint("TOPRIGHT", "CT_RARaidOverviewFrameBar" .. i, "TOPRIGHT", -3, 0);
			status:SetPoint("TOPLEFT", "CT_RARaidOverviewFrameBar" .. i, "TOPRIGHT", 3, -1);
			bar:SetID(i);
			y = y - CT_RARaidOverview.barSpacing;
		end

		this:RegisterEvent("VARIABLES_LOADED");
	end,

	-- onEvent raid status frame
	onEvent = function()
		if ( event == "VARIABLES_LOADED" ) then
			UIDropDownMenu_Initialize(CT_RARaidOverviewFrame_DropDown, CT_RARaidOverview.initializeMenuArray, "MENU");

			if ( CT_RAMenu_Options["temp"]["StatusMeters"] ) then
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Background"] ) then
					if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["a"] ) then
						CT_RARaidOverviewFrame:SetAlpha(CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["a"]);
					end
					if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["s"] ) then
						CT_RARaidOverviewFrame:SetScale(CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["s"]);
					end
				end
			else
				CT_RAMenu_Options["temp"]["StatusMeters"] = {
					["Health Display"] = { },
					["Mana Display"] = { },
					["Health Combined"] = { },
					["Mana Combined"] = { },
					["Raid Health"] = { },
					["Raid Mana"] = { },
					["Background"] = {
						["a"] = 0.7,
						["s"] = 1.0
					}
				};
			end
		end
	end,

	-- onUpdate raid status frame
	onUpdate = function()
		CT_RARaidOverview.elapsed = CT_RARaidOverview.elapsed + arg1;
		if ( CT_RARaidOverview.elapsed >= CT_RARaidOverview.updateTime ) then
			CT_RARaidOverview.elapsed = 0;
			CT_RARaidOverview.numRaidMembers = GetNumRaidMembers();
			CT_RARaidOverview.numPartyMembers = GetNumPartyMembers();

			if ( CT_RARaidOverviewFrame:IsVisible() ) then
				CT_RARaidOverview.updateBars();
			end

			if ( CT_RARaidOverview.isShowStatus() and not CT_RARaidOverviewFrame:IsVisible() ) then
				CT_RARaidOverviewFrame:Show();
			elseif ( not CT_RARaidOverview.isShowStatus() and CT_RARaidOverviewFrame:IsVisible() ) then
				CT_RARaidOverviewFrame:Hide();
			end
		end
	end,

	-- onEnter raid status bar frame
	onEnter = function()
		local id = this:GetID();
		local name = this:GetName();
		if (id < 1) or (not string.find(name, "^CT_RARaidOverviewFrameBar")) or CT_RARaidOverviewFrame_DropDown:IsVisible() then
			return;
		end
		
		local cx, cy = this:GetCenter();
		if (cx < (GetScreenWidth() / 2)) then
			if (cy < (GetScreenHeight() / 2)) then
				CT_RARaidOverviewTooltip:SetOwner(this, "ANCHOR_RIGHT");
			else
				CT_RARaidOverviewTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
			end
		else
			if (cy < (GetScreenHeight() / 2)) then
				CT_RARaidOverviewTooltip:SetOwner(this, "ANCHOR_LEFT");
			else
				CT_RARaidOverviewTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
			end
		end

		if ( id < 99 ) then
			if ( CT_RARaidOverview.barSetup[id] ~= nil ) then
				if ( type(CT_RARaidOverview.barSetup[id]) == "table" ) then
					for k, v in CT_RARaidOverview.barSetup[id] do
						if ( k == "CH" and CT_RARaidOverview.typeClasses[v] ~= nil ) then
							CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_HEALTH .. " " .. v);
							if ( CT_RARaidOverview.statusTable[v]["healthMax"] > 0 ) then
								local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[v]];

								for name, data in CT_RARaidOverview.statusTable[v]["players"] do
									if ( data["healthMax"] > 0 ) then
										local percent = floor(data["health"] / data["healthMax"] * 100);
										
										CT_RARaidOverviewTooltip:AddDoubleLine(name,
														       data["health"] .. " / " ..  data["healthMax"] .. " (" .. percent .. "%)", c.r, c.g, c.b, 1, 1, 1);
									end
								end
							end

						elseif ( k == "CM" ) then
							CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_MANA .. " " .. v);
							if ( CT_RARaidOverview.statusTable[v]["manaMax"] > 0 ) then
								local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[v]];

								for name, data in CT_RARaidOverview.statusTable[v]["players"] do
									if ( data["manaMax"] == nil ) then data["manaMax"] = 0; end
									if ( data["manaMax"] > 0 ) then
										local percent = floor(data["mana"] / data["manaMax"] * 100);
										
										CT_RARaidOverviewTooltip:AddDoubleLine(name,
														       data["mana"] .. " / " ..  data["manaMax"] .. " (" .. percent .. "%)", c.r, c.g, c.b, 1, 1, 1);
									end
								end
							end

						elseif ( k == "COH" and v ) then
							CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_HEALTH .. " " .. CT_RA_RS_COMBINED);
							for k2, v2 in v do
								if ( CT_RARaidOverview.typeClasses[v2] ~= nil ) then
									local data = CT_RARaidOverview.statusTable[v2];

									if ( data["healthMax"] > 0 ) then
										local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[v2]];
										local percent = floor(data["health"] / data["healthMax"] * 100);
									
										CT_RARaidOverviewTooltip:AddDoubleLine(v2 .. " (" .. data["num"] .. ")",
														       data["health"] .. " / " ..  data["healthMax"] .. " (" .. percent .. "%)", c.r, c.g, c.b, 1, 1, 1);
									end
								end
							end
						elseif ( k == "COM" and v ) then
							CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_MANA .. " " .. CT_RA_RS_COMBINED);
							for k2, v2 in v do
								if ( CT_RARaidOverview.typeClasses[v2] ~= nil ) then
									local data = CT_RARaidOverview.statusTable[v2];

									if ( data["manaMax"] == nil ) then data["manaMax"] = 0; end
									if ( data["manaMax"] > 0 ) then
										local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[v2]];
										local percent = floor(data["mana"] / data["manaMax"] * 100);
									
										CT_RARaidOverviewTooltip:AddDoubleLine(v2 .. " (" .. data["num"] .. ")",
														       data["mana"] .. " / " ..  data["manaMax"] .. " (" .. percent .. "%)", c.r, c.g, c.b, 1, 1, 1);
									end
								end
							end
						end
					end
				else
					if ( CT_RARaidOverview.barSetup[id] == "RH" ) then
						CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_HEALTH .. " " .. CT_RA_RS_TOTAL);
						for class, data in CT_RARaidOverview.statusTable do
							if ( CT_RARaidOverview.typeClasses[class] ~= nil ) then
								if ( data["healthMax"] > 0 ) then
									local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[class]];
									local percent = floor(data["health"] / data["healthMax"] * 100);
									
									CT_RARaidOverviewTooltip:AddDoubleLine(class .. " (" .. data["num"] .. ")",
													       data["health"] .. " / " ..  data["healthMax"] .. " (" .. percent .. "%)", c.r, c.g, c.b, 1, 1, 1);
								end
							end
						end
					elseif ( CT_RARaidOverview.barSetup[id] == "RM" ) then
						CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_MANA .. " " .. CT_RA_RS_TOTAL);
						for class, data in CT_RARaidOverview.statusTable do
							if ( CT_RARaidOverview.typeClasses[class] ~= nil ) then
								if ( data["manaMax"] == nil ) then data["manaMax"] = 0; end
								if ( data["manaMax"] > 0 ) then
									local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[class]];
									local percent = floor(data["mana"] / data["manaMax"] * 100);
									
									CT_RARaidOverviewTooltip:AddDoubleLine(class .. " (" .. data["num"] .. ")",
													       data["mana"] .. " / " ..  data["manaMax"] .. " (" .. percent .. "%)", c.r, c.g, c.b, 1, 1, 1);
								end
							end
						end
					end
				end
			end

			CT_RARaidOverviewTooltip:Show();
		elseif ( id == 99 ) then
			local showTooltip = false;
			CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_GENERAL_TOOLTIP_TITLE);

			if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Offline Count"] and CT_RARaidOverview.statusTable["Generic"]["isOffline"]["num"] > 0 ) then
				CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_OFFLINE_TEXT);
				showTooltip = true;
				
				for k, data in CT_RARaidOverview.statusTable["Generic"]["isOffline"]["players"] do
					local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[data["class"]]];
					if ( not data["offlineTime"] ) then data["offlineTime"] = ""; end
					CT_RARaidOverviewTooltip:AddDoubleLine( data["name"],
										data["offlineTime"], c.r, c.g, c.b, 1, 1, 1);
				end
			end

			if ( CT_RAMenu_Options["temp"]["StatusMeters"]["PvP Count"] and CT_RARaidOverview.statusTable["Generic"]["isPvP"]["num"] > 0 ) then
				if ( showTooltip ) then
					CT_RARaidOverviewTooltip:AddLine("\n");
				end
				CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_PVP_TEXT);
				showTooltip = true;
				
				for k, data in CT_RARaidOverview.statusTable["Generic"]["isPvP"]["players"] do
					local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[data["class"]]];
					if ( not data["pvpName"] ) then data["pvpName"] = ""; end
					CT_RARaidOverviewTooltip:AddDoubleLine( data["name"],
										data["pvpName"], c.r, c.g, c.b, 1, 1, 1);
				end
			end

			if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Dead Count"] and CT_RARaidOverview.statusTable["Generic"]["isDead"]["num"] > 0 ) then
				if ( showTooltip ) then
					CT_RARaidOverviewTooltip:AddLine("\n");
				end
				CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_DEAD_TEXT);
				showTooltip = true;
				local count = 0;

				for k, data in CT_RARaidOverview.statusTable["Generic"]["isDead"]["players"] do
					count = count + 1;
					if ( count <= CT_RARaidOverview.maxListLength) then
						local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[data["class"]]];
						local timeString = " " .. data["deadTime"];
						if ( not data["deadTime"] ) then timeString = ""; end
						if ( data["status"] == 1 ) then
							timeString = "(" .. CT_RA_RS_DEAD_RELEASED .. ")" .. timeString;
						end
						CT_RARaidOverviewTooltip:AddDoubleLine( data["name"],
											timeString, c.r, c.g, c.b, 1, 1, 1);
					else
						CT_RARaidOverviewTooltip:AddLine("[...]", 1, 1, 1);
						break;
					end
				end
			end

			if ( CT_RAMenu_Options["temp"]["StatusMeters"]["AFK Count"] and CT_RARaidOverview.statusTable["Generic"]["TYPE"] == "RAID" and CT_RARaidOverview.statusTable["Generic"]["isAfk"]["num"] > 0 ) then
				if ( showTooltip ) then
					CT_RARaidOverviewTooltip:AddLine("\n");
				end
				CT_RARaidOverviewTooltip:AddLine(CT_RA_RS_AFK_TEXT);
				showTooltip = true;

				for k, data in CT_RARaidOverview.statusTable["Generic"]["isAfk"]["players"] do
					local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[data["class"]]];
					if ( not data["afkTime"] ) then data["afkTime"] = ""; end
					CT_RARaidOverviewTooltip:AddDoubleLine( data["name"],
										data["afkTime"], c.r, c.g, c.b, 1, 1, 1);
				end
			end

			if ( not showTooltip ) then
				CT_RARaidOverviewTooltip:AddLine("- " .. CT_RA_RS_ALLOK_TEXT .. " -", 1, 1, 1);
			end
			CT_RARaidOverviewTooltip:Show();
		end
	end,

	-- onLeave raid status bar frame
	onLeave = function()
		local id = this:GetID();
		local name = this:GetName();

		if ( id < 1 ) or not string.find(name, "^CT_RARaidOverviewFrameBar") then
			return;
		end

		CT_RARaidOverviewTooltip:Hide();
	end,

	-- onMouseDown raid status bar frame
	onMouseDown = function()
		if ( arg1 == "LeftButton" and not CT_RAMenu_Options["temp"]["StatusMeters"]["Lock"] ) then
			CT_RARaidOverviewFrame:StartMoving();
		elseif ( arg1 == "RightButton" ) then
			if CT_RARaidOverviewTooltip:IsVisible() then
				CT_RARaidOverviewTooltip:Hide();
			end

			local cx, cy = this:GetCenter();
			if ( cx < (GetScreenWidth() / 2 ) ) then
				if (cy < (GetScreenHeight() / 2)) then
					UIDropDownMenu_SetAnchor(0, 0, CT_RARaidOverviewFrame_DropDown, "BOTTOMLEFT", this, "TOPRIGHT");
				else
					UIDropDownMenu_SetAnchor(0, 0, CT_RARaidOverviewFrame_DropDown, "TOPLEFT", this, "BOTTOMRIGHT");
				end
			else
				if (cy < (GetScreenHeight() / 2)) then
					UIDropDownMenu_SetAnchor(0, 0, CT_RARaidOverviewFrame_DropDown, "BOTTOMRIGHT", this, "TOPLEFT");
				else
					UIDropDownMenu_SetAnchor(0, 0, CT_RARaidOverviewFrame_DropDown, "TOPRIGHT", this, "BOTTOMLEFT");
				end
			end

			ToggleDropDownMenu(1, nil, CT_RARaidOverviewFrame_DropDown);
		end
	end,

	-- onMouseUp raid status bar frame
	onMouseUp = function()
		if ( arg1 == "LeftButton" ) then
			CT_RARaidOverviewFrame:StopMovingOrSizing();
		end
	end,

	addMember = function(id)
		local name = UnitName(id);
		local class = UnitClass(id);
		
		CT_RARaidOverview.statusTable["Generic"]["total"] = CT_RARaidOverview.statusTable["Generic"]["total"] + 1;
		if ( UnitIsConnected(id) ) then
			local powerType = UnitPowerType(id);	-- -1=Health, 0=Mana, 1=Rage, 2=Focus, 3=Energy, 4=Happiness
			local isDead = UnitIsDead(id);
			local isGhost = UnitIsGhost(id);
			local isAfk = ( CT_RA_Stats[name] and CT_RA_Stats[name]["AFK"] );
			local isPvP = ( UnitIsPVP(id) or UnitIsPVPFreeForAll(id) );
			local health, maxHealth = UnitHealth(id), UnitHealthMax(id);
			local mana, maxMana = UnitMana(id), UnitManaMax(id);

			-- override variables in case (why ever) important requests got nil
			if ( powerType == nil ) then powerType = -2; end
			if ( health == nil ) then health = 0; end
			if ( maxHealth == nil ) then maxHealth = 0; end
			if ( mana == nil ) then mana = 0; end
			if ( maxMana == nil ) then maxMana = 0; end

			CT_RARaidOverview.statusTable["Generic"]["health"] = CT_RARaidOverview.statusTable["Generic"]["health"] + health;
			CT_RARaidOverview.statusTable["Generic"]["healthMax"] = CT_RARaidOverview.statusTable["Generic"]["healthMax"] + maxHealth;
			if ( powerType == 0 ) then
				CT_RARaidOverview.statusTable["Generic"]["mana"] = CT_RARaidOverview.statusTable["Generic"]["mana"] + mana;
				CT_RARaidOverview.statusTable["Generic"]["manaMax"] = CT_RARaidOverview.statusTable["Generic"]["manaMax"] + maxMana;
			end
			if ( isDead or isGhost ) then
				local dgStatus = 0;
				if ( isGhost ) then dgStatus = 1; end
				local deadTime = CT_RA_RS_NA_TEXT;
				if ( CT_RA_Stats[name] and CT_RA_Stats[name]["Dead"] ) then
					deadTime = CT_RA_FormatTime(CT_RA_Stats[name]["Dead"]);
				end
				CT_RARaidOverview.statusTable["Generic"]["isDead"]["num"] = CT_RARaidOverview.statusTable["Generic"]["isDead"]["num"] + 1;
				tinsert(CT_RARaidOverview.statusTable["Generic"]["isDead"]["players"], {["name"] = name, ["class"] = class, ["status"] = dgStatus, ["deadTime"] = deadTime} );
			end
			if ( isAfk ) then
				local afkTime = CT_RA_RS_NA_TEXT;
				if ( type( CT_RA_Stats[name]["AFK"][1]) == "string" ) then
					afkTime = CT_RA_Stats[name]["AFK"][1];
				else
					afkTime = CT_RA_FormatTime(CT_RA_Stats[name]["AFK"][2]);
				end
				CT_RARaidOverview.statusTable["Generic"]["isAfk"]["num"] = CT_RARaidOverview.statusTable["Generic"]["isAfk"]["num"] + 1;
				tinsert(CT_RARaidOverview.statusTable["Generic"]["isAfk"]["players"], {["name"] = name, ["class"] = class, ["afkTime"] = afkTime});
			end
			if ( isPvP ) then
				local pvpName = UnitPVPName(id);
				CT_RARaidOverview.statusTable["Generic"]["isPvP"]["num"] = CT_RARaidOverview.statusTable["Generic"]["isPvP"]["num"] + 1;
				tinsert(CT_RARaidOverview.statusTable["Generic"]["isPvP"]["players"], {["name"] = name, ["class"] = class, ["pvpName"] = pvpName});
			end

			if ( class and CT_RARaidOverview.statusTable[class] ) then
				CT_RARaidOverview.statusTable[class]["num"] = CT_RARaidOverview.statusTable[class]["num"] + 1;
				CT_RARaidOverview.statusTable[class]["players"][name] = {};
				CT_RARaidOverview.statusTable[class]["players"][name]["health"] = health;
				CT_RARaidOverview.statusTable[class]["players"][name]["healthMax"] = maxHealth;
				CT_RARaidOverview.statusTable[class]["health"] = CT_RARaidOverview.statusTable[class]["health"] + health;
				CT_RARaidOverview.statusTable[class]["healthMax"] = CT_RARaidOverview.statusTable[class]["healthMax"] + maxHealth;
				if ( powerType == 0 ) then
					CT_RARaidOverview.statusTable[class]["players"][name]["mana"] = mana;
					CT_RARaidOverview.statusTable[class]["players"][name]["manaMax"] = maxMana;
					CT_RARaidOverview.statusTable[class]["mana"] = CT_RARaidOverview.statusTable[class]["mana"] + mana;
					CT_RARaidOverview.statusTable[class]["manaMax"] = CT_RARaidOverview.statusTable[class]["manaMax"] + maxMana;
				end
			end
		else
			local offlineTime = CT_RA_RS_NA_TEXT;
			if ( CT_RA_Stats[name] and CT_RA_Stats[name]["Offline"] ) then
				offlineTime = CT_RA_FormatTime(CT_RA_Stats[name]["Offline"]);
			end
			CT_RARaidOverview.statusTable["Generic"]["isOffline"]["num"] = CT_RARaidOverview.statusTable["Generic"]["isOffline"]["num"] + 1;
			tinsert(CT_RARaidOverview.statusTable["Generic"]["isOffline"]["players"], {["name"] = name, ["class"] = class, ["offlineTime"] = offlineTime});
		end
	end,

	updateBars = function()
		if ( not CT_RAMenu_Options["temp"]["StatusMeters"] or not CT_RARaidOverviewFrame:IsVisible() ) then
			if ( CT_RARaidOverviewFrame:IsVisible() ) then
				CT_RARaidOverviewFrame:Hide();
			end
			CT_RARaidOverview.statusTable = {};
			return;
		end

		if ( not CT_RARaidOverviewFrame:IsVisible() ) then
			CT_RARaidOverviewFrame:Show();
		end
		CT_RARaidOverview.statusTable = {
			["Generic"] = {
				["type"] = "",
				["isDead"] = { ["num"] = 0, ["players"] = {} },
				["isAfk"] = { ["num"] = 0, ["players"] = {} },
				["isOffline"] = { ["num"] = 0, ["players"] = {} },
				["isPvP"] = { ["num"] = 0, ["players"] = {} },
				["total"] = 0,
				["health"] = 0,
				["healthMax"] = 0,
				["mana"] = 0,
				["manaMax"] = 0,
			},
			[CT_RA_WARRIOR] = { ["health"] = 0, ["healthMax"] = 0, ["mana"] = 0, ["manaMax"] = 0, ["num"] = 0, ["players"] = {} },
			[CT_RA_DRUID] = { ["health"] = 0, ["healthMax"] = 0, ["mana"] = 0, ["manaMax"] = 0, ["num"] = 0, ["players"] = {} },
			[CT_RA_MAGE] = { ["health"] = 0, ["healthMax"] = 0, ["mana"] = 0, ["manaMax"] = 0, ["num"] = 0, ["players"] = {} },
			[CT_RA_WARLOCK] = { ["health"] = 0, ["healthMax"] = 0, ["mana"] = 0, ["manaMax"] = 0, ["num"] = 0, ["players"] = {} },
			[CT_RA_ROGUE] = { ["health"] = 0, ["healthMax"] = 0, ["mana"] = 0, ["manaMax"] = 0, ["num"] = 0, ["players"] = {} },
			[CT_RA_HUNTER] = { ["health"] = 0, ["healthMax"] = 0, ["mana"] = 0, ["manaMax"] = 0, ["num"] = 0, ["players"] = {} },
			[CT_RA_PRIEST] = { ["health"] = 0, ["healthMax"] = 0, ["mana"] = 0, ["manaMax"] = 0, ["num"] = 0, ["players"] = {} },
			[CT_RA_PALADIN] = { ["health"] = 0, ["healthMax"] = 0, ["mana"] = 0, ["manaMax"] = 0, ["num"] = 0, ["players"] = {} },
			[CT_RA_SHAMAN] = { ["health"] = 0, ["healthMax"] = 0, ["mana"] = 0, ["manaMax"] = 0, ["num"] = 0, ["players"] = {} },
		};

		if ( CT_RARaidOverviewFrame:IsVisible() ) then
			local barCount = 0;

			if ( CT_RARaidOverview.numRaidMembers > 0 ) then
				CT_RARaidOverview.statusTable["Generic"]["TYPE"] = "RAID"; 		

				for i=1, CT_RARaidOverview.numRaidMembers do
					CT_RARaidOverview.addMember("raid" .. i);
				end

			elseif ( CT_RARaidOverview.numPartyMembers > 0 ) then
				CT_RARaidOverview.statusTable["Generic"]["TYPE"] = "PARTY";

				CT_RARaidOverview.addMember("player");
				for i=1, CT_RARaidOverview.numPartyMembers do
					CT_RARaidOverview.addMember("party" .. i);
				end
			end

			if ( CT_RARaidOverview.statusTable["Generic"]["total"] > 0 ) then
				local bar = nil;
				local text = nil;
				local tcount = nil;
				local status = nil;

				-- Update header text
				if ( CT_RARaidOverview.statusTable["Generic"]["TYPE"] == "RAID" ) then
					CT_RARaidOverviewFrameHeader:SetText(CT_RA_RS_RAID_TITLE);
				elseif ( CT_RARaidOverview.statusTable["Generic"]["TYPE"] == "PARTY" ) then
					CT_RARaidOverviewFrameHeader:SetText(CT_RA_RS_GROUP_TITLE);
				else
					CT_RARaidOverviewFrameHeader:SetText("N/A");
				end

				-- Total player count
				local countString = CT_RARaidOverview.statusTable["Generic"]["total"] .. " " .. CT_RA_RS_PLAYER_TEXT;
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Offline Count"] and CT_RARaidOverview.statusTable["Generic"]["isOffline"]["num"] > 0 ) then
					countString = countString .. " (" .. CT_RARaidOverview.statusTable["Generic"]["isOffline"]["num"] .. " " .. CT_RA_RS_OFFLINE_TEXT .. ")";
				end
				CT_RARaidOverviewFrameTextPlayer:SetText(countString);
				CT_RARaidOverviewFrameTextPlayer:Show();
				
				-- Dead count
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Dead Count"] ) then
					CT_RARaidOverviewFrameTextDead:SetText(CT_RA_RS_DEAD_TEXT .. ": " .. CT_RARaidOverview.statusTable["Generic"]["isDead"]["num"]);
					CT_RARaidOverviewFrameTextDead:Show();
				else
					CT_RARaidOverviewFrameTextDead:SetText("");
					CT_RARaidOverviewFrameTextDead:Hide();
				end

				-- PvP count
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["PvP Count"] and CT_RARaidOverview.statusTable["Generic"]["isPvP"]["num"] > 0 ) then
					CT_RARaidOverviewFrameTextPvP:SetText(CT_RA_RS_PVP_TEXT .. ": " .. CT_RARaidOverview.statusTable["Generic"]["isPvP"]["num"]);
					CT_RARaidOverviewFrameTextPvP:Show();
				else
					CT_RARaidOverviewFrameTextPvP:SetText("");
					CT_RARaidOverviewFrameTextPvP:Hide();
				end
				
				-- Afk count
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["AFK Count"] and CT_RARaidOverview.statusTable["Generic"]["TYPE"] == "RAID" ) then
					CT_RARaidOverviewFrameTextAfk:SetText(CT_RARaidOverview.statusTable["Generic"]["isAfk"]["num"] .. " :" .. CT_RA_RS_AFK_TEXT);			
					CT_RARaidOverviewFrameTextAfk:Show();
				else
					CT_RARaidOverviewFrameTextAfk:SetText("");
					CT_RARaidOverviewFrameTextAfk:Hide();
				end

				-- Raid health
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Health"] ) then
					barCount = barCount + 1;
					CT_RARaidOverview.barSetup[barCount] = {};
					CT_RARaidOverview.barSetup[barCount] = "RH";
					bar = getglobal("CT_RARaidOverviewFrameBar" .. barCount);
					text = getglobal("CT_RARaidOverviewFrameText" .. barCount);
					tcount = getglobal("CT_RARaidOverviewFrameCount" .. barCount);
					status = getglobal("CT_RARaidOverviewFrameStatus" .. barCount);

					local healthRaw = 0;
					local health = 0;
					if ( CT_RARaidOverview.statusTable["Generic"]["healthMax"] > 0 ) then
						healthRaw = CT_RARaidOverview.statusTable["Generic"]["health"] / CT_RARaidOverview.statusTable["Generic"]["healthMax"];
						health = floor(healthRaw * 100);
					end
					bar:SetMinMaxValues(0, 100);
					bar:SetValue(health);
					bar:SetStatusBarColor(1.0 - healthRaw, healthRaw, 0);
					text:SetText(CT_RA_RS_TOTAL);
					tcount:SetText("");
					status:SetText(health .. "%");

					bar:Show();
					text:Show();
					tcount:Hide();
					status:Show();
				end

				-- Raid mana
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Mana"] and CT_RARaidOverview.statusTable["Generic"]["manaMax"] > 0 ) then
					barCount = barCount + 1;
					CT_RARaidOverview.barSetup[barCount] = {};
					CT_RARaidOverview.barSetup[barCount] = "RM";
					bar = getglobal("CT_RARaidOverviewFrameBar" .. barCount);
					text = getglobal("CT_RARaidOverviewFrameText" .. barCount);
					tcount = getglobal("CT_RARaidOverviewFrameCount" .. barCount);
					status = getglobal("CT_RARaidOverviewFrameStatus" .. barCount);

					local mana = floor(CT_RARaidOverview.statusTable["Generic"]["mana"] / CT_RARaidOverview.statusTable["Generic"]["manaMax"] * 100);
					bar:SetMinMaxValues(0, 100);
					bar:SetValue(mana);
					bar:SetStatusBarColor(0, 0, 1.0);
					text:SetText(CT_RA_RS_TOTAL);
					tcount:SetText("");
					status:SetText(mana .. "%");

					bar:Show();
					text:Show();
					tcount:Hide();
					status:Show();
				end

				-- Player health
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Health Display"] ) then
					for k, v in CT_RAMenu_Options["temp"]["StatusMeters"]["Health Display"] do
						if ( v and CT_RARaidOverview.statusTable[k] and barCount < CT_RARaidOverview.maxBars and CT_RARaidOverview.statusTable[k]["healthMax"] > 0 ) then
							barCount = barCount + 1;
							CT_RARaidOverview.barSetup[barCount] = {};
							CT_RARaidOverview.barSetup[barCount]["CH"] = k;
							bar = getglobal("CT_RARaidOverviewFrameBar" .. barCount);
							text = getglobal("CT_RARaidOverviewFrameText" .. barCount);
							tcount = getglobal("CT_RARaidOverviewFrameCount" .. barCount);
							status = getglobal("CT_RARaidOverviewFrameStatus" .. barCount);

							local healthRaw = CT_RARaidOverview.statusTable[k]["health"] / CT_RARaidOverview.statusTable[k]["healthMax"];
							local health = floor(healthRaw * 100);
							local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[k]];
							bar:SetMinMaxValues(0, 100);
							bar:SetValue(health);
							bar:SetStatusBarColor(1.0 - healthRaw, healthRaw, 0);
							text:SetText(k);
							text:SetTextColor(c.r, c.g, c.b);
							tcount:SetText("(" .. CT_RARaidOverview.statusTable[k]["num"] .. ")");
							tcount:SetTextColor(c.r, c.g, c.b);
							status:SetText(health .. "%");

							bar:Show();
							text:Show();
							tcount:Show();
							status:Show();
						end
					end
				end

				-- Player mana
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Mana Display"]) then
					for k, v in CT_RAMenu_Options["temp"]["StatusMeters"]["Mana Display"] do
						if ( v and CT_RARaidOverview.statusTable[k] and barCount < CT_RARaidOverview.maxBars and CT_RARaidOverview.statusTable[k]["manaMax"] > 0 ) then
							barCount = barCount + 1;
							CT_RARaidOverview.barSetup[barCount] = {};
							CT_RARaidOverview.barSetup[barCount]["CM"] = k;
							bar = getglobal("CT_RARaidOverviewFrameBar" .. barCount);
							text = getglobal("CT_RARaidOverviewFrameText" .. barCount);
							tcount = getglobal("CT_RARaidOverviewFrameCount" .. barCount);
							status = getglobal("CT_RARaidOverviewFrameStatus" .. barCount);

							local mana = floor(CT_RARaidOverview.statusTable[k]["mana"] / CT_RARaidOverview.statusTable[k]["manaMax"] * 100);
							local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[k]];
							bar:SetMinMaxValues(0, 100);
							bar:SetValue(mana);
							bar:SetStatusBarColor(0, 0, 1.0);
							text:SetText(k);
							text:SetTextColor(c.r, c.g, c.b);
							tcount:SetText("(" .. CT_RARaidOverview.statusTable[k]["num"] .. ")");
							tcount:SetTextColor(c.r, c.g, c.b);
							status:SetText(mana .. "%");

							bar:Show();
							text:Show();
							tcount:Show();
							status:Show();
						end
					end
				end

				-- Combined player health
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Health Combined"] ) then
					local health = 0;
					local healthRaw = 0;
					local playerCount = 0;
					local playerString = "";
					local playerStringLong = "";
					local playerFirst = true;
					local entryCount = 0;

					barCount = barCount + 1;
					CT_RARaidOverview.barSetup[barCount] = {};
					CT_RARaidOverview.barSetup[barCount]["COH"] = {};
					for k, v in CT_RAMenu_Options["temp"]["StatusMeters"]["Health Combined"] do
						if ( v and CT_RARaidOverview.statusTable[k] and barCount < CT_RARaidOverview.maxBars and CT_RARaidOverview.statusTable[k]["healthMax"] > 0 ) then
							entryCount = entryCount + 1;

							local healthRawC = CT_RARaidOverview.statusTable[k]["health"] / CT_RARaidOverview.statusTable[k]["healthMax"];
							if ( entryCount <= 1 ) then
								health = floor(healthRawC * 100);
								healthRaw = healthRawC;
							else
								health = floor((health + floor(healthRawC * 100)) / 2);
								healthRaw = (healthRaw + healthRawC) / 2;
							end
							playerCount = playerCount + CT_RARaidOverview.statusTable[k]["num"];
							
							local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[k]];
							if ( playerFirst ) then
								playerFirst = false;
							else
								playerString = playerString .. ", ";
								playerStringLong = playerStringLong .. ", ";
							end
							playerString = playerString .. "|c00" .. string.format("%.2x",c.r * 255) .. string.format("%.2x",c.g * 255) .. string.format("%.2x",c.b * 255) .. string.sub(k, 1, 3) .. "|r";
							playerStringLong = playerStringLong .. "|c00" .. string.format("%.2x",c.r * 255) .. string.format("%.2x",c.g * 255) .. string.format("%.2x",c.b * 255) .. k .. "|r";
						
							tinsert(CT_RARaidOverview.barSetup[barCount]["COH"], k);
						end
					end

					if ( playerCount > 0 ) then							
						bar = getglobal("CT_RARaidOverviewFrameBar" .. barCount);
						text = getglobal("CT_RARaidOverviewFrameText" .. barCount);
						tcount = getglobal("CT_RARaidOverviewFrameCount" .. barCount);
						status = getglobal("CT_RARaidOverviewFrameStatus" .. barCount);

						bar:SetMinMaxValues(0, 100);
						bar:SetValue(health);
						bar:SetStatusBarColor(1.0 - healthRaw, healthRaw, 0);
						if ( playerCount <= 2 ) then
							text:SetText(playerStringLong);
						else
							text:SetText(playerString);
						end
						tcount:SetText("(" .. playerCount .. ")");
						status:SetText(health .. "%");

						bar:Show();
						text:Show();
						tcount:Show();
						status:Show();
					else
						barCount = barCount - 1;
					end
				end

				-- Combined player mana
				if ( CT_RAMenu_Options["temp"]["StatusMeters"]["Mana Combined"] ) then
					local mana = 0;
					local playerCount = 0;
					local playerString = "";
					local playerStringLong = "";
					local playerFirst = true;
					local entryCount = 0;

					barCount = barCount + 1;
					CT_RARaidOverview.barSetup[barCount] = {};
					CT_RARaidOverview.barSetup[barCount]["COM"] = {};
					for k, v in CT_RAMenu_Options["temp"]["StatusMeters"]["Mana Combined"] do
						if ( v and CT_RARaidOverview.statusTable[k] and barCount < CT_RARaidOverview.maxBars and CT_RARaidOverview.statusTable[k]["manaMax"] > 0 ) then
							entryCount = entryCount + 1;
							
							local manaRawC = CT_RARaidOverview.statusTable[k]["mana"] / CT_RARaidOverview.statusTable[k]["manaMax"];
							if ( entryCount <= 1 ) then
								mana = floor(manaRawC * 100);
							else
								mana = floor((mana + floor(manaRawC * 100)) / 2);
							end
							playerCount = playerCount + CT_RARaidOverview.statusTable[k]["num"];
							
							local c = RAID_CLASS_COLORS[CT_RARaidOverview.typeClasses[k]];
							if ( playerFirst ) then
								playerFirst = false;
							else
								playerString = playerString .. ", ";
								playerStringLong = playerStringLong .. ", ";
							end
							playerString = playerString .. "|c00" .. string.format("%.2x",c.r * 255) .. string.format("%.2x",c.g * 255) .. string.format("%.2x",c.b * 255) .. string.sub(k, 1, 3) .. "|r";
							playerStringLong = playerStringLong .. "|c00" .. string.format("%.2x",c.r * 255) .. string.format("%.2x",c.g * 255) .. string.format("%.2x",c.b * 255) .. k .. "|r";
							
							tinsert(CT_RARaidOverview.barSetup[barCount]["COM"], k);
						end
					end

					if ( playerCount > 0 ) then							
						bar = getglobal("CT_RARaidOverviewFrameBar" .. barCount);
						text = getglobal("CT_RARaidOverviewFrameText" .. barCount);
						tcount = getglobal("CT_RARaidOverviewFrameCount" .. barCount);
						status = getglobal("CT_RARaidOverviewFrameStatus" .. barCount);

						bar:SetMinMaxValues(0, 100);
						bar:SetValue(mana);
						bar:SetStatusBarColor(0, 0, 1.0);
						if ( playerCount <= 2 ) then
							text:SetText(playerStringLong);
						else
							text:SetText(playerString);
						end
						tcount:SetText("(" .. playerCount .. ")");
						status:SetText(mana .. "%");

						bar:Show();
						text:Show();
						tcount:Show();
						status:Show();
					else
						barCount = barCount - 1;
					end
				end

				CT_RARaidOverviewFrame:SetHeight(CT_RARaidOverview.barSpacing * barCount + 5);
			end

			-- clear other bars
			local start = barCount + 1;
			if ( barCount <= 0 ) then
				local bar = getglobal("CT_RARaidOverviewFrameBar1");
				local text = getglobal("CT_RARaidOverviewFrameText1");
				local tcount = getglobal("CT_RARaidOverviewFrameCount1");
				local status = getglobal("CT_RARaidOverviewFrameStatus1");

				bar:SetValue(0);
				text:SetText(CT_RA_RS_NOTRACK);
				tcount:SetText("");
				status:SetText("");

				bar:Show();
				text:Show();
				tcount:Hide();
				status:Hide();

				start = 2;
				CT_RARaidOverviewFrame:SetHeight(CT_RARaidOverview.barSpacing + 5);
			end
			if ( start <= CT_RARaidOverview.maxBars ) then
				for i=start, CT_RARaidOverview.maxBars do
					local bar = getglobal("CT_RARaidOverviewFrameBar" .. i);
					local text = getglobal("CT_RARaidOverviewFrameText" .. i);
					local tcount = getglobal("CT_RARaidOverviewFrameCount" .. i);
					local status = getglobal("CT_RARaidOverviewFrameStatus" .. i);

					bar:SetValue(0);
					text:SetText("");
					tcount:SetText("");
					status:SetText("");

					bar:Hide();
					text:Hide();
					tcount:Hide();
					status:Hide();
				end
			end
		end
	end,

	initializeMenuArray = function()
		local info;
		if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
			local subTitle = "";
			if ( UIDROPDOWNMENU_MENU_VALUE == "Health Display" or UIDROPDOWNMENU_MENU_VALUE == "Health Combined" ) then
				subTitle = CT_RA_RS_HEALTH;
			elseif ( UIDROPDOWNMENU_MENU_VALUE == "Mana Display" or UIDROPDOWNMENU_MENU_VALUE == "Mana Combined" ) then
				subTitle = CT_RA_RS_MANA;
			else
				subTitle = UIDROPDOWNMENU_MENU_VALUE;
			end

			info = {};
			info.text = "- " .. subTitle .. " -";
			info.justifyH = "CENTER";
			info.isTitle = 1;
			info.notCheckable = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			
			local nonManaUsers = {
				[CT_RA_ROGUE] = 1,
				[CT_RA_WARRIOR] = 1
			};
			for k, v in CT_RA_ClassPositions do
				if ( UIDROPDOWNMENU_MENU_VALUE == "Health Display" or UIDROPDOWNMENU_MENU_VALUE == "Health Combined" or not nonManaUsers[k] ) then
					if ( ( k ~= CT_RA_SHAMAN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Horde" ) ) and ( k ~= CT_RA_PALADIN or ( UnitFactionGroup("player") and UnitFactionGroup("player") == "Alliance" ) ) ) then
						info = { };
						info.text = k;
						info.value = { UIDROPDOWNMENU_MENU_VALUE, k };
						info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"][UIDROPDOWNMENU_MENU_VALUE] and CT_RAMenu_Options["temp"]["StatusMeters"][UIDROPDOWNMENU_MENU_VALUE][k] );
						info.keepShownOnClick = 1;
						info.func = CT_RARaidOverview.menuOptions;
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					end
				end
			end
			return;
		end
		info = {};
		info.text = "- " .. CT_RA_RS_TITLE .. " -";
		info.justifyH = "CENTER";
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = CT_RA_RS_HEALTH .. " " .. CT_RA_RS_TOTAL;
		info.value = "Raid Health";
		info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Health"] );
		info.keepShownOnClick = 1;
		info.func = CT_RARaidOverview.menuOptions;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.text = CT_RA_RS_MANA .. " " .. CT_RA_RS_TOTAL;
		info.value = "Raid Mana";
		info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Raid Mana"] );
		info.keepShownOnClick = 1;
		info.func = CT_RARaidOverview.menuOptions;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = CT_RA_RS_HEALTH .. " " .. CT_RA_RS_COMBINED;
		info.value = "Health Combined";
		info.hasArrow = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.text = CT_RA_RS_MANA .. " " .. CT_RA_RS_COMBINED;
		info.value = "Mana Combined";
		info.hasArrow = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.text = CT_RA_RS_HEALTH .. " " .. CT_RA_RS_PER_CLASS;
		info.value = "Health Display";
		info.hasArrow = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.text = CT_RA_RS_MANA .. " " .. CT_RA_RS_PER_CLASS;
		info.value = "Mana Display";
		info.hasArrow = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.disabled = 1;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.text = CT_RA_RS_AFK;
		info.value = "AFK Count";
		info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["AFK Count"] );
		info.keepShownOnClick = 1;
		info.func = CT_RARaidOverview.menuOptions;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.text = CT_RA_RS_DEAD;
		info.value = "Dead Count";
		info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Dead Count"] );
		info.keepShownOnClick = 1;
		info.func = CT_RARaidOverview.menuOptions;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.text = CT_RA_RS_OFFLINE;
		info.value = "Offline Count";
		info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Offline Count"] );
		info.keepShownOnClick = 1;
		info.func = CT_RARaidOverview.menuOptions;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = CT_RA_RS_PVP;
		info.value = "PvP Count";
		info.checked = ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["PvP Count"] );
		info.keepShownOnClick = 1;
		info.func = CT_RARaidOverview.menuOptions;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.disabled = 1;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		if ( CT_RAMenu_Options["temp"]["StatusMeters"] and CT_RAMenu_Options["temp"]["StatusMeters"]["Lock"] ) then
			info.text = CT_RA_RS_MENU_UNLOCK;
		else
			info.text = CT_RA_RS_MENU_LOCK;
		end
		info.value = "LockMeter";
		info.notCheckable = 1;
		info.func = CT_RARaidOverview.menuOptions;
		UIDropDownMenu_AddButton(info);
		
		info = { };
		info.text = CT_RA_RS_MENU_OPACITY;
		info.value = "Opacity";
		info.func = CT_RARaidOverview.menuOptions;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		
		info = {};
		info.text = "|c00FF8080" .. CT_RA_RS_MENU_HIDE .. "|r";
		info.value = "Hide";
		info.notCheckable = 1;
		info.func = CT_RARaidOverview.menuOptions;
		UIDropDownMenu_AddButton(info);
	end,

	menuOptions = function()
		-- Create the table if we haven't already
		if ( not CT_RAMenu_Options["temp"]["StatusMeters"]  ) then
			CT_RAMenu_Options["temp"]["StatusMeters"] = {
				["Health Display"] = { },
				["Mana Display"] = { },
				["Raid Health"] = true,
				["Raid Mana"] = true,
				["Dead Count"] = true,
				["Offline Count"] = true,
				["PvP Count"] = false,
				["Background"] = {
					["a"] = 0.7
				}
			};
		end
		if ( this.value == "LockMeter" ) then
			CT_RAMenu_Options["temp"]["StatusMeters"]["Lock"] = not CT_RAMenu_Options["temp"]["StatusMeters"]["Lock"];
			return;
		elseif ( this.value == "Hide" ) then
			CT_RAMenuFrameGeneralMiscShowMetersCB:SetChecked(false);
			CT_RAMenu_Options["temp"]["StatusMeters"]["Show"] = nil;
			CT_RARaidOverviewFrame:Hide();
			return;
		elseif ( this.value == "Opacity" ) then
			if ( not OpacityFrame:IsVisible() ) then
				CT_RARaidOverview.menuOpacityShow();
			else
				OpacityFrame:Hide();
			end
		end
		
		if ( type(this.value) == "table" ) then
			-- We have either HP or Mana Display/Totals/Combined
			if ( CT_RAMenu_Options["temp"]["StatusMeters"][this.value[1]] == nil ) then CT_RAMenu_Options["temp"]["StatusMeters"][this.value[1]] = { }; end
			CT_RAMenu_Options["temp"]["StatusMeters"][this.value[1]][this.value[2]] = not CT_RAMenu_Options["temp"]["StatusMeters"][this.value[1]][this.value[2]];
		else
			-- Just AFK Count/Dead Count
			CT_RAMenu_Options["temp"]["StatusMeters"][this.value] = not CT_RAMenu_Options["temp"]["StatusMeters"][this.value];
		end
		CT_RARaidOverview.updateBars();
	end,

	menuOpacityShow = function()
		OpacityFrame:ClearAllPoints();
		OpacityFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		OpacityFrameSlider:SetValue(CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["a"]);
		OpacityFrame.opacityFunc = CT_RARaidOverview.menuOpacitySet;
		OpacityFrame.saveOpacityFunc = CT_RARaidOverview.menuOpacitySave;
		OpacityFrame:Show();
	end,

	menuOpacitySet = function()
		local alpha = 1 - OpacityFrameSlider:GetValue();			
		if ( alpha < 0.2 ) then
			alpha = 0.2;
		end
			
		CT_RARaidOverviewFrame:SetAlpha(alpha);
	end,

	menuOpacitySave = function()
		local alpha = 1 - OpacityFrameSlider:GetValue();			
		if ( alpha < 0.2 ) then
			alpha = 0.2;
		end

		CT_RAMenu_Options["temp"]["StatusMeters"]["Background"]["a"] = alpha;
	end,

	isShowStatus = function()
		if ( ( CT_RARaidOverview.numRaidMembers > 0 or CT_RARaidOverview.numPartyMembers > 0 ) and CT_RAMenu_Options["temp"]["StatusMeters"]["Show"] ) then
			return true;
		elseif ( ( CT_RARaidOverview.numRaidMembers <= 0 and CT_RARaidOverview.numPartyMembers <= 0 ) or not CT_RAMenu_Options["temp"]["StatusMeters"]["Show"] ) then
			return false;
		end
	end,
};
