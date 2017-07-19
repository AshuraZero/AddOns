CMP_INV_SLOT={
-- gotten from GlobalStrings.lua
[INVTYPE_2HWEAPON]="16 17",
[INVTYPE_BODY]="4",
[INVTYPE_CHEST]="5",
[INVTYPE_CLOAK]="15",
[INVTYPE_FEET]="8",
[INVTYPE_FINGER]="11 12",
[INVTYPE_HAND]="10",
[INVTYPE_HEAD]="1",
[INVTYPE_HOLDABLE]="17",
[INVTYPE_LEGS]="7",
[INVTYPE_NECK]="2",
[INVTYPE_RANGED]="18",
[INVTYPE_ROBE]="5",
[INVTYPE_SHIELD]="17",
[INVTYPE_SHOULDER]="3",
[INVTYPE_TABARD]="19",
[INVTYPE_TRINKET]="13 14",
[INVTYPE_WAIST]="6",
[INVTYPE_WEAPON]="16 17",
[INVTYPE_WEAPONMAINHAND]="16",
[INVTYPE_WEAPONOFFHAND]="17",
[INVTYPE_WRIST]="9",
-- need localization for following
[INVTYPE_RELIC]="18",
[INVTYPE_GUN]="18",
[INVTYPE_BOW]="18",
[INVTYPE_CROSSBOW]="18",
[INVTYPE_WAND]="18",
[INVTYPE_THROWN]="18",
[INVTYPE_AMMO]="0",
}
--[[
	Locals
--]]
--~ local zDebug = true
--~ local function zDebugMessage(msg)
--~ 	if zDebug then
--~ 		DEFAULT_CHAT_FRAME:AddMessage(msg,1,1,0)
--~ 	end
--~ end

local function GetTooltipInventorySlot(tooltip)
	if not tooltip or type(tooltip) == "string" then return end
	--possible texts starting at 2nd line:
	--bind
	--unique
	--slot
	for i=2,5 do
		--check tooltip for inventory slot
		local text=getglobal(tooltip:GetName().."TextLeft"..i):GetText()
		if CMP_INV_SLOT[text] then
			local match={}
			local i=1
			for slot in string.gfind(CMP_INV_SLOT[text] or "","(%d+)") do
				match[i]=slot
				i=i+1
			end
			return match
		end
	end
end

local function zSetMatch(index, totalMatch, slot)
	-- check slot, return if nothing equipped
	local texture = GetInventoryItemTexture("player", slot)
	if not texture then return end
	
	-- get shopping tip
	local shoptip = getglobal("ShoppingTooltip"..index)
	local shoptiptext = getglobal(shoptip:GetName().."TextLeft1")
	
	-- init tip
	shoptip:SetOwner(this, "ANCHOR_NONE")
	shoptip:SetInventoryItem("player", slot)
	shoptip:SetScale(this:GetScale())
	shoptip:SetBackdropColor(0.02,0,0.06)
	
	-- set compare tip point
	local scale = this:GetScale()
	local screenWidth = UIParent:GetRight()
	local anchor, anchorframe, align, x, y = "TOPLEFT", this, "TOPRIGHT", 0, 0
	
	--correct anchor if tooltip is in right half of screen
	local tipleft = this:GetLeft() or GetCursorPosition()
	if tipleft and tipleft*scale >= screenWidth/2 then
		anchor,align="TOPRIGHT","TOPLEFT"
	end
	local tmp
	if (index == 2) then
		tmp = anchor
		anchor = align
		align = tmp
	end
	
	shoptip:ClearAllPoints()
	shoptip:SetPoint(anchor, anchorframe, align, x, y)

	-- add Currently Equipped befor title
	local oldtext=shoptiptext:GetText() or ""
	local newtext=LIGHTYELLOW_FONT_COLOR_CODE .." ---- "..CURRENTLY_EQUIPPED.." ---- ".. FONT_COLOR_CODE_CLOSE.."\n"
	shoptiptext:SetText(newtext..oldtext)

	shoptip:Show() -- call last, fixes many problems
	
	-- adjust owner position if tip is out of screen
	local left, right = shoptip:GetLeft(), shoptip:GetRight()
	if index == 2 and (left < 0 or right*scale > screenWidth) then
		anchorframe = ShoppingTooltip1
		tmp = anchor anchor = align align = tmp
		shoptip:ClearAllPoints()
		shoptip:SetPoint(anchor, anchorframe, align, x, y)
	end
	local bottom = shoptip:GetBottom()
	if bottom and bottom < 0 then
		y = - bottom
		if anchorframe ~= this then
			y = y - ShoppingTooltip1:GetTop() + this:GetTop()
		end
		shoptip:ClearAllPoints()
		shoptip:SetPoint(anchor, anchorframe, align, x, y)
	end
end

local function QuickCompare_Tooltip_OnShow(obj)

	local frame = GetMouseFocus() and GetMouseFocus():GetName() or ""
	
	--buttons and frames to skip
	--player's paperdoll
	--weapon enchants
	--world frame (z)
	if frame == "WorldFrame" and not obj -- unit
	or getglobal(frame.."HotKey") -- action button
	or strfind(frame,"^Character.*Slot$")
	or strfind(frame,"^TempEnchant%d+$")
	then return end

	if not this then
		this = GameTooltip
		--supports other tooltips/frames
	end
	if obj then this = obj end

	local match = GetTooltipInventorySlot(this)
	if not match then return end
	
	local totalMatch = getn(match)
	
	zSetMatch(1, totalMatch, match[1])
	if (totalMatch == 1) then
		ShoppingTooltip2:Hide()	
	elseif (totalMatch == 2) then
		zSetMatch(2, totalMatch, match[2])
	end
end
--[[
	Override
--]]
local function QuickCompare_MerchantOnEnter()
	GameTooltip:SetOwner(this,"ANCHOR_RIGHT")
	if ( MerchantFrame.selectedTab==1) then
		GameTooltip:SetMerchantItem(this:GetID())
		MerchantFrame.itemHover=this:GetID()
	else
		GameTooltip:SetBuybackItem(this:GetID())
		ShowBuybackSellCursor(this:GetID())
	end
end

local zOld_AuctionFrameItem_OnEnter
local function zNew_AuctionFrameItem_OnEnter(type, index)
	zOld_AuctionFrameItem_OnEnter(type, index)
	ShoppingTooltip1:Hide()
	ShoppingTooltip2:Hide()
	QuickCompare_Tooltip_OnShow(GameTooltip)
end
--[[
	Hook
--]]
--~ hook when tooltip hide (by Zero Fire)
local function zGameTooltipOnHide()
	ShoppingTooltip1:Hide()
	ShoppingTooltip2:Hide()
	if (ItemRefTooltip:IsShown()) then
		QuickCompare_Tooltip_OnShow(ItemRefTooltip)
	end
end
--~ hook for hyperlink (by Zero Fire)
local zOld_ChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow
function ChatFrame_OnHyperlinkShow(arg1,arg2,arg3)
	zOld_ChatFrame_OnHyperlinkShow(arg1,arg2,arg3)
	if (ItemRefTooltip:IsShown()) then
		QuickCompare_Tooltip_OnShow(ItemRefTooltip)
	end	
end
--~	hook function (z)
local function zHook(frame, handler, hookFunc)
	local origFunc = frame:GetScript(handler) or function() end
	frame:SetScript(handler, function() origFunc() hookFunc() end)
end
--[[
	The Frame
--]]
local EventFrame
local function QuickCompareFrame_OnEvent()
	if event == "PLAYER_ENTERING_WORLD" then
		--GameTooltip OnShow OnHide
		zHook(GameTooltip, "OnShow", QuickCompare_Tooltip_OnShow)
		zHook(GameTooltip, "OnHide", zGameTooltipOnHide)
		--ItemRefTooltip OnHide
		zHook(ItemRefTooltip, "OnHide", zGameTooltipOnHide)
		--AtlasLoot Tooltip
		if (AtlasLootTooltip) then
			zHook(AtlasLootTooltip, "OnShow", QuickCompare_Tooltip_OnShow)
			zHook(AtlasLootTooltip, "OnHide", zGameTooltipOnHide)
		end
		--Merchant compares
		for i=1, 12 do
			local frame=getglobal("MerchantItem"..i.."ItemButton")
			frame:SetScript("OnEnter", QuickCompare_MerchantOnEnter)
		end
		-- adjust the shopping tool tip text font
		for i=1,2 do
			local tip = getglobal("ShoppingTooltip"..i)		
			local text = getglobal("ShoppingTooltip"..i.."TextLeft1")
			text:SetFontObject("GameTooltipHeaderText")
			for j=2,24 do
				text = getglobal("ShoppingTooltip"..i.."TextLeft"..j)
				text:SetFontObject("GameTooltipText")
				text = getglobal("ShoppingTooltip"..i.."TextRight"..j)
				text:SetFontObject("GameTooltipText")
			end
		end
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "AUCTION_HOUSE_SHOW" then
		--AuctionHouse compares
		zOld_AuctionFrameItem_OnEnter = AuctionFrameItem_OnEnter
		AuctionFrameItem_OnEnter = zNew_AuctionFrameItem_OnEnter
		this:UnregisterEvent("AUCTION_HOUSE_SHOW")
		EventFrame:SetScript("OnEvent",nil)
		EventFrame = nil
		QuickCompareFrame_OnEvent = nil
	end
end
EventFrame = CreateFrame("Frame", nil, UIParent)
EventFrame:SetScript("OnEvent", QuickCompareFrame_OnEvent)
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("AUCTION_HOUSE_SHOW")