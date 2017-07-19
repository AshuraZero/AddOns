CT_RATab_AutoPromotions = { };

UnitPopupButtons["CTRAID_DEFAULT_LOOT_TYPE"] = { text = "缺省分配方式", dist = 0, nested = 1 };
UnitPopupButtons["CTRAID_LOOTMETHOD_FREEFORALL"] = { text = TEXT(LOOT_FREE_FOR_ALL), dist = 0 };
UnitPopupButtons["CTRAID_LOOTMETHOD_ROUNDROBIN"] = { text = TEXT(LOOT_ROUND_ROBIN), dist = 0 };
UnitPopupButtons["CTRAID_LOOTMETHOD_MASTER"] = { text = TEXT(LOOT_MASTER_LOOTER), dist = 0 };
UnitPopupButtons["CTRAID_LOOTMETHOD_GROUP"] = { text = TEXT(LOOT_GROUP_LOOT), dist = 0 };
UnitPopupButtons["CTRAID_LOOTMETHOD_NEEDBEFOREGREED"] = { text = TEXT(LOOT_NEED_BEFORE_GREED), dist = 0 };
UnitPopupMenus["CTRAID_DEFAULT_LOOT_TYPE"] = { "CTRAID_LOOTMETHOD_FREEFORALL", "CTRAID_LOOTMETHOD_ROUNDROBIN", "CTRAID_LOOTMETHOD_MASTER", "CTRAID_LOOTMETHOD_GROUP", "CTRAID_LOOTMETHOD_NEEDBEFOREGREED", "CANCEL" };
NEWBIE_TOOLTIP_UNIT_CTRAID_LOOTMETHOD_FREEFORALL = "把缺省分配方式改为自由拾取，当你创建一个团队时团队助手将自动设置所选择的分配方式。";
NEWBIE_TOOLTIP_UNIT_CTRAID_LOOTMETHOD_ROUNDROBIN = "把缺省分配方式改为轮流拾取，当你创建一个团队时团队助手将自动设置所选择的分配方式。";
NEWBIE_TOOLTIP_UNIT_CTRAID_LOOTMETHOD_MASTER = "把缺省分配方式改为队长分配，当你创建一个团队时团队助手将自动设置所选择的分配方式。";
NEWBIE_TOOLTIP_UNIT_CTRAID_LOOTMETHOD_GROUP = "把缺省分配方式改为队伍分配，当你创建一个团队时团队助手将自动设置所选择的分配方式。";
NEWBIE_TOOLTIP_UNIT_CTRAID_LOOTMETHOD_NEEDBEFOREGREED = "把缺省分配方式改为需求优先，当你创建一个团队时团队助手将自动设置所选择的分配方式。";
tinsert(UnitPopupMenus["SELF"], getn(UnitPopupMenus["SELF"]), "CTRAID_DEFAULT_LOOT_TYPE");
tinsert(UnitPopupShown, 1);
local lootTypeTable = UnitPopupMenus["CTRAID_DEFAULT_LOOT_TYPE"];

local oldUnitPopup_OnClick = UnitPopup_OnClick;
function UnitPopup_OnClick()
	local button = this.value;
	oldUnitPopup_OnClick();
	if ( strsub(button, 1, 17) == "CTRAID_LOOTMETHOD" ) then
		local id = this:GetID();
		CT_RATab_DefaultLootMethod = id;
		if ( CT_RA_Level >= 2 and GetNumRaidMembers() > 0 ) then
			local lootType = strsub(button, 19);
			if ( lootType == "MASTER" ) then
				SetLootMethod(lootType, UnitName("player"));
			else
				SetLootMethod(lootType);
			end
		end
	end
end
local metaFunction = function(tbl, key, val)
	if ( key == "selectedLootMethod" and type(tbl) == "table" ) then
		local defaultLoot = CT_RATab_DefaultLootMethod or 4;
		if ( defaultLoot ) then
			local k, v = next(lootTypeTable);
			for i = 1, (defaultLoot-1) do
				k, v = next(lootTypeTable, k);
			end
			rawset(tbl, "selectedLootMethod", UnitPopupButtons[v].text);
			return;
		end
	end
	rawset(tbl, key, val);
end

local oldUnitPopup_ShowMenu = UnitPopup_ShowMenu;
function UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData)
	local metatable = getmetatable(dropdownMenu);
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 and UIDROPDOWNMENU_MENU_VALUE == "CTRAID_DEFAULT_LOOT_TYPE" ) then
		dropdownMenu.selectedLootMethod = nil;
		metatable.__newindex = metaFunction;
	else
		dropdownMenu.selectedLootMethod = UnitLootMethod[GetLootMethod()].text;
		metatable.__newindex = nil;
	end
	oldUnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData);
end

local oldUnitPopup_HideButtons = UnitPopup_HideButtons;
function UnitPopup_HideButtons()
	oldUnitPopup_HideButtons();
	local dropdownMenu = getglobal(UIDROPDOWNMENU_INIT_MENU);
	if ( GetNumPartyMembers() == 0 ) then
		for index, value in UnitPopupMenus[dropdownMenu.which] do
			if ( value == "CTRAID_DEFAULT_LOOT_TYPE" ) then
				UnitPopupShown[index] = 0;
				return;
			end
		end
	end
end


function CT_RATab_newRaidFrameDropDown_Initialize()
	UnitPopup_ShowMenu(getglobal(UIDROPDOWNMENU_OPEN_MENU), "RAID", this.unit, this.name, this.id);
	local info = {};
	info.text = "自动提升";
	info.tooltipTitle = "自动提升";
	info.tooltipText = "选中后，此玩家在加入团队时将自动被提升为助理。";
	info.checked = CT_RATab_AutoPromotions[this.name];
	info.value = this.id;
	info.func = CT_RATab_AutoPromote_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CT_RATab_AutoPromote_OnClick()
	local name, rank = GetRaidRosterInfo(this.value);
	CT_RATab_AutoPromotions[name] = not CT_RATab_AutoPromotions[name];
	if ( CT_RA_Level and CT_RA_Level >= 2 and CT_RATab_AutoPromotions[name] and rank < 1 ) then
		PromoteToAssistant(name);
		CT_RA_Print("<团队助手> 自动提升 |c00FFFFFF" .. name .. "|r。", 1, 0.5, 0);
	end
end
