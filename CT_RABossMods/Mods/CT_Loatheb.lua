function CT_Loatheb_InitializeMenu()
	local info = {};
	info.text = CT_RABOSS_NAMES["Loatheb"];
	info.notClickable = 1;
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info, 1);

	local info = {};
	info.text = CT_RABOSS_LOATHEB_LOCK;
	info.value = CT_RABoss_Mods.Loatheb.FrameLocked;
	info.func = function() CT_RABoss_Mods.Loatheb.FrameLocked = not CT_RABoss_Mods.Loatheb.FrameLocked; end;
	info.checked = CT_RABoss_Mods.Loatheb.FrameLocked;
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info, 1);

	local info = {};
	info.text = CT_RABOSS_LOATHEB_CLOSE;
	info.func = function() CT_LoathebFrameDrag.ConfigMode = false; CT_LoathebFrameDrag:Hide() end;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info, 1);
end

function CT_Loatheb_OnUpdate(arg1)
	for index, value in pairs(CT_RABoss_Mods.Loatheb.Healers) do
		if type(CT_RABoss_Mods.Loatheb.Healers[index].Cooldown) == "number" then
			CT_RABoss_Mods.Loatheb.Healers[index].Cooldown = CT_RABoss_Mods.Loatheb.Healers[index].Cooldown - arg1;
			if CT_RABoss_Mods.Loatheb.Healers[index].Cooldown <= 0 then
				CT_RABoss_Mods.Loatheb.Healers[index].Cooldown = nil;
			end
		end
	end
	if CT_LoathebFrameDrag:IsShown() then
		local i = arg1 + 1;
		if table.getn(CT_RABoss_Mods.Loatheb.Healers) == 0 then
			CT_RABoss_Loatheb_EventHandler("RAID_ROSTER_UPDATE");
		end
		local frameID = 0;
		for index, value in pairs(CT_RABoss_Mods.Loatheb.Healers) do
			frameID = frameID + 1;
			local frame = getglobal("CT_LoathebHealerFrame"..frameID);
			local frameName = getglobal("CT_LoathebHealerFrame"..frameID.."BarName");
			local frameCooldown = getglobal("CT_LoathebHealerFrame"..frameID.."BarCooldown");
			local frameSpark = getglobal("CT_LoathebHealerFrame"..frameID.."BarSpark");
			local frameBar = getglobal("CT_LoathebHealerFrame"..frameID.."Bar");
			if frame then
				frameName:SetText(value.Name.." ("..value.Class..")");
				if value.Name == UnitName("player") then
					frameName:SetTextColor(0, 0.82, 1);
					frameCooldown:SetTextColor(0, 0.82, 1);
				else
					frameName:SetTextColor(1, 0.82, 0);
					frameCooldown:SetTextColor(1, 0.82, 0);
				end
				if UnitIsDeadOrGhost("raid" .. value.ID) or not UnitIsConnected("raid" .. value.ID) then
					if UnitIsDeadOrGhost("raid" .. value.ID) then
						frameCooldown:SetText(CT_RABOSS_DEAD);
					elseif not UnitIsConnected("raid" .. value.ID) then
						frameCooldown:SetText(CT_RABOSS_OFFLINE);
					end
					frameBar:SetValue(0);
					frameSpark:Hide();
					frame:SetAlpha(0.5);
				else
					frame:SetAlpha(1);
					if type(value.Cooldown) == "number" and value.Cooldown > 0 then
						frameCooldown:SetText(string.format("%.1f", value.Cooldown));
						frameBar:SetValue(value.Cooldown);
						frameSpark:ClearAllPoints();
						frameSpark:SetPoint("CENTER", frameBar, "LEFT", ((frameBar:GetValue() / 60) * frameBar:GetWidth()), 0);
						frameSpark:Show();
					else
						frameCooldown:SetText(CT_RABOSS_LOATHEB_NO_CD);
						frameBar:SetValue(0);
						frameSpark:Hide();
					end
				end
			end
			if CT_LoathebFrameDrag.ConfigMode then
				local editBox;
				if not getglobal("CT_LoathebHealerFrame"..frameID.."EditBox") then
					CreateFrame("Frame", "CT_LoathebHealerFrame"..frameID.."EditBox", CT_LoathebFrameDrag, "CT_LoathebEditBoxTemplate")
				end
				editBox = getglobal("CT_LoathebHealerFrame"..frameID.."EditBox");
				editBox:SetID(frameID);
				editBox:SetPoint("LEFT", "CT_LoathebHealerFrame"..frameID, "RIGHT", -4, 0);
				editBox:Show();
				local i = 1;
				while getglobal("CT_LoathebHealerFrame"..i) and getglobal("CT_LoathebHealerFrame"..i):IsShown() do
					i = i + 1;
				end
				i = i - 1;
				CT_LoathebButton:ClearAllPoints()
				CT_LoathebButton:SetPoint("TOP", "CT_LoathebHealerFrame"..i, "BOTTOM", 0, 0);
				if not CT_LoathebButton:IsShown() then
					CT_LoathebButton:Show();
				end
			end
		end
	end
end

function CT_Loatheb_OnLoad()
	SLASH_CTLoatheb1 = "/loatheb";
	SlashCmdList["CTLoatheb"] = function (cmd) CT_Loatheb_SlashHandler(cmd) end
end

function CT_Loatheb_SlashHandler(cmd)
	cmd = string.lower(cmd);
	if ( cmd == "show" ) then
		CT_LoathebFrameDrag:Show();
	elseif ( cmd == "hide" ) then
		CT_LoathebFrameDrag:Hide();
	elseif ( cmd == "setup" or cmd == "config" ) then
		CT_LoathebFrameDrag:Show();
		CT_LoathebFrameDrag.ConfigMode = true;
		if CT_RA_Level >= 1 then
			CT_LoathebButton:SetText(CT_RABOSS_LOATHEB_SET_HEAL_ROTATION);
		else
			DEFAULT_CHAT_FRAME:AddMessage(CT_RABOSS_LOATHEB_NO_BC_INFO);
			CT_LoathebButton:SetText(CT_RABOSS_LOATHEB_SET_HEAL_ROTATION_NO_BC);
		end
	elseif ( cmd == "broadcast" or cmd == "bc"  ) then
		local healerSetup = {};
		local i = 1;
		local j = 1;
		while CT_RABoss_Mods.Loatheb.Healers[i] do
			if not healerSetup[j] then
				healerSetup[j] = "";
			end
			if string.len(healerSetup[j]..i..". "..CT_RABoss_Mods.Loatheb.Healers[i].Name.." / ") < 254 then
				healerSetup[j] = healerSetup[j]..i..". "..CT_RABoss_Mods.Loatheb.Healers[i].Name.." / ";
			else
				j = j + 1;
				if not healerSetup[j] then
					healerSetup[j] = "";
				end
				healerSetup[j] = healerSetup[j]..i..". "..CT_RABoss_Mods.Loatheb.Healers[i].Name.." / ";
			end
			i = i + 1;
		end
		for index, value in pairs(healerSetup) do
			healerSetup[index] = string.gsub(healerSetup[index], " / $", "");
			SendChatMessage(healerSetup[index], "RAID");
		end
		CT_RABoss_Loatheb_SendHealList();
		return true;
	elseif ( cmd == "undelete" ) then
		CT_RABoss_Mods.Loatheb.DeletedHealers = {};
		CT_RABoss_Loatheb_EventHandler("RAID_ROSTER_UPDATE");
	else
		DEFAULT_CHAT_FRAME:AddMessage(CT_RABOSS_LOATHEB_CMD_UNKNOWN);
	end
	return true;
end
