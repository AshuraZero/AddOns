-- GLOBALS: CustomNameplatesHandleEvent, CustomNameplatesUpdate
local _G = getfenv(0)
local ADDON = {}

-- Settings block
-- DO NOT EDIT THIS, look at _settings.lua file for instructions
ADDON.genSettings = _G.CustomNameplatesSettings and _G.CustomNameplatesSettings.genSettings
  or {["showPets"]=false,["enableAddOn"]=true,["showFriendly"]=false,["combatOnly"]=false,["hbwidth"]=90,["hbheight"]=12,
      ["texture"]="Interface\\AddOns\\CustomNameplates\\barSmall",["refreshRate"]=1/60}
ADDON.raidicon = _G.CustomNameplatesSettings and _G.CustomNameplatesSettings.raidicon
  or {["size"]=15,["point"]="BOTTOMLEFT",["anchorpoint"]="BOTTOMLEFT",["xoffs"]=-18,["yoffs"]=1}
ADDON.classicon = _G.CustomNameplatesSettings and _G.CustomNameplatesSettings.classicon
  or {["hide"]=false,["size"]=17,["point"]="LEFT",["anchorpoint"]="LEFT",["xoffs"]=-3,["yoffs"]=4.5}
ADDON.targetindicator = _G.CustomNameplatesSettings and _G.CustomNameplatesSettings.targetindicator
  or {["hide"]=false,["size"]=50,["point"]="BOTTOM",["anchorpoint"]="TOP",["xoffs"]=0,["yoffs"]=10}
ADDON.nametext = _G.CustomNameplatesSettings and _G.CustomNameplatesSettings.nametext
  or {["size"]=13,["point"]="TOPLEFT",["anchorpoint"]="TOP",["xoffs"]=-30,["yoffs"]=8,
      ["font"]=STANDARD_TEXT_FONT}
ADDON.leveltext = _G.CustomNameplatesSettings and _G.CustomNameplatesSettings.leveltext
  or {["hide"]=false,["size"]=14,["point"]="TOPRIGHT",["anchorpoint"]="CENTER",["xoffs"]=27,["yoffs"]=15,
      ["font"]=STANDARD_TEXT_FONT}

-- Caches: Don't edit
ADDON.Players = {}
ADDON.Targets = {}

ADDON.Icons = {
  ["DRUID"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Druid",
  ["HUNTER"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Hunter",
  ["MAGE"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Mage",
  ["PALADIN"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Paladin",
  ["PRIEST"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Priest",
  ["ROGUE"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Rogue",
  ["SHAMAN"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Shaman",
  ["WARLOCK"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Warlock",
  ["WARRIOR"] = "Interface\\AddOns\\CustomNameplates\\Class\\ClassIcon_Warrior",
  ["TargetIcon"] = "Interface\\AddOns\\CustomNameplates\\Arrow"
}
ADDON.PetsRU = {["Рыжая полосатая кошка"]=true,["Серебристая полосатая кошка"]=true,["Бомбейская кошка"]=true,["Корниш-рекс"]=true,
  ["Ястребиная сова"]=true,["Большая рогатая сова"]=true,["Макао"]=true,["Сенегальский попугай"]=true,["Черная королевская змейка"]=true,
  ["Бурая змейка"]=true,["Багровая змейка"]=true,["Луговая собачка"]=true,["Тараканище"]=true,["Анконская курица"]=true,["Щенок ворга"]=true,
  ["Паучок Дымной Паутины"]=true,["Механическая курица"]=true,["Птенец летучего хамелеона"]=true,["Зеленокрылый ара"]=true,["Гиацинтовый ара"]=true,
  ["Маленький темный дракончик"]=true,["Маленький изумрудный дракончик"]=true,["Маленький багровый дракончик"]=true,["Сиамская кошка"]=true,
  ["Пещерная крыса без сознания"]=true,["Механическая белка"]=true,["Крошечная ходячая бомба"]=true,["Крошка Дымок"]=true,["Механическая жаба"]=true,
  ["Заяц-беляк"]=true}
ADDON.PetsENG = {["Orange Tabby"]=true,["Silver Tabby"]=true,["Bombay"]=true,["Cornish Rex"]=true,["Hawk Owl"]=true,["Great Horned Owl"]=true,
  ["Cockatiel"]=true,["Senegal"]=true,["Black Kingsnake"]=true,["Brown Snake"]=true,["Crimson Snake"]=true,["Prairie Dog"]=true,["Cockroach"]=true,
  ["Ancona Chicken"]=true,["Worg Pup"]=true,["Smolderweb Hatchling"]=true,["Mechanical Chicken"]=true,["Sprite Darter"]=true,["Green Wing Macaw"]=true,
  ["Hyacinth Macaw"]=true,["Tiny Black Whelpling"]=true,["Tiny Emerald Whelpling"]=true,["Tiny Crimson Whelpling"]=true,["Siamese"]=true,
  ["Unconscious Dig Rat"]=true,["Mechanical Squirrel"]=true,["Pet Bombling"]=true,["Lil' Smokey"]=true,["Lifelike Mechanical Toad"]=true}

-- upvalue some oft-called API for performance (scope upvalue limit = 32, damn you Lua 5.0)
local UnitDebuff, UnitClass, UnitName, UnitIsPlayer, UnitExists, UnitIsDeadOrGhost, UnitAffectingCombat = 
  UnitDebuff, UnitClass, UnitName, UnitIsPlayer, UnitExists, UnitIsDeadOrGhost, UnitAffectingCombat
local string_len, string_find, ipairs, table_insert = 
  string.len, string.find, ipairs, table.insert

-- addon utility functions
function ADDON.Print(msg)
  local out = "|cff008800CustomPlates: |r"..tostring(msg)
  if not DEFAULT_CHAT_FRAME:IsVisible() then
    FCF_SelectDockFrame(DEFAULT_CHAT_FRAME)
  end
  DEFAULT_CHAT_FRAME:AddMessage(out)
end

function ADDON.IsNamePlateFrame(frame)
 local overlayRegion = frame:GetRegions()
  if not overlayRegion or overlayRegion:GetObjectType() ~= "Texture" or overlayRegion:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
    return false
  end
  return true
end

function ADDON.isPet(name)
  return ADDON.PetsENG[name] or ADDON.PetsRU[name] or false
end

function ADDON.fillPlayerDB(name)
  if ADDON.Players[name] ~= nil then return end
  if ADDON.Targets[name] == nil then
    TargetByName(name, true)
    table_insert(ADDON.Targets, name)
    ADDON.Targets[name] = "_"
    if UnitIsPlayer("target") then
      local _, class = UnitClass("target") -- use the locale-agnostic value
      table_insert(ADDON.Players, name)
      ADDON.Players[name] = {["class"] = class}
    end   
  end
end

function ADDON.targetIndicatorShow(namePlate)
  if (ADDON.targetindicator.hide) then return end
  if CustomNameplates.scanningPlayers then return end
  namePlate.targetIndicator:ClearAllPoints()
  namePlate.targetIndicator:SetPoint(ADDON.targetindicator.point,namePlate,ADDON.targetindicator.anchorpoint, ADDON.targetindicator.xoffs, ADDON.targetindicator.yoffs)
  namePlate.targetIndicator:Show()
end

function ADDON.targetIndicatorHide(namePlate)
  namePlate.targetIndicator:Hide()
end

function ADDON.CustomNameplates_OnUpdate(elapsed)
  CustomNameplates.ticker = CustomNameplates.ticker + elapsed
  if not (CustomNameplates.ticker > ADDON.genSettings.refreshRate) then return end  -- cap at 60fps by default
  CustomNameplates.ticker = 0
  local frames = { WorldFrame:GetChildren() }
  for _, namePlate in ipairs(frames) do
    if ADDON.IsNamePlateFrame(namePlate) then
      local HealthBar = namePlate:GetChildren()
      local Border, Glow, Name, Level, Boss, RaidTargetIcon = namePlate:GetRegions()

      --Healthbar
      HealthBar:SetStatusBarTexture(ADDON.genSettings.texture)
      HealthBar:ClearAllPoints()
      HealthBar:SetPoint("CENTER", namePlate, "CENTER", 0, 3)
      HealthBar:SetWidth(ADDON.genSettings.hbwidth) 
      HealthBar:SetHeight(ADDON.genSettings.hbheight)
      
      --HealthbarBackground
      if HealthBar.bg == nil then
        HealthBar.bg = HealthBar:CreateTexture(nil, "BORDER")
        HealthBar.bg:SetTexture(0,0,0,0.85)
        HealthBar.bg:ClearAllPoints()
        HealthBar.bg:SetPoint("CENTER", namePlate, "CENTER", 0, 3)
        HealthBar.bg:SetWidth(HealthBar:GetWidth() + 1.5)
        HealthBar.bg:SetHeight(HealthBar:GetHeight() + 1.5)
      end
      
      --RaidTarget
      RaidTargetIcon:ClearAllPoints()
      RaidTargetIcon:SetWidth(ADDON.raidicon.size)
      RaidTargetIcon:SetHeight(ADDON.raidicon.size) 
      RaidTargetIcon:SetPoint(ADDON.raidicon.point, HealthBar, ADDON.raidicon.anchorpoint, ADDON.raidicon.xoffs, ADDON.raidicon.yoffs)
      
      -- TargetIndicator
      if namePlate.targetIndicator == nil then
        namePlate.targetIndicator = namePlate:CreateTexture(nil, "OVERLAY")
        namePlate.targetIndicator:SetTexture(ADDON.Icons.TargetIcon)
        namePlate.targetIndicator:SetWidth(ADDON.targetindicator.size)
        namePlate.targetIndicator:SetHeight(ADDON.targetindicator.size + 10)
        namePlate.targetIndicator:Hide()
      end

      --DebuffIcons on TargetPlates 

      
      if UnitExists("target") and HealthBar:GetAlpha() == 1 then --Sets the texture of debuffs to debufficons
        ADDON.targetIndicatorShow(namePlate)
      else
        ADDON.targetIndicatorHide(namePlate)
      end
      
      if namePlate.classIcon == nil then --ClassIcon
        namePlate.classIcon = namePlate:CreateTexture(nil, "BORDER")
        namePlate.classIcon:SetTexture(0,0,0,0)
        namePlate.classIcon:ClearAllPoints()
        namePlate.classIcon:SetPoint(ADDON.classicon.point, namePlate, ADDON.classicon.anchorpoint, ADDON.classicon.xoffs, ADDON.classicon.yoffs)
        namePlate.classIcon:SetWidth(ADDON.classicon.size)
        namePlate.classIcon:SetHeight(ADDON.classicon.size)
      end   

      if namePlate.classIconBorder == nil then --ClassIconBackground
        namePlate.classIconBorder = namePlate:CreateTexture(nil, "BACKGROUND")
        namePlate.classIconBorder:SetTexture(0,0,0,0.9)
        namePlate.classIconBorder:SetPoint("CENTER", namePlate.classIcon, "CENTER", 0, 0)
        namePlate.classIconBorder:SetWidth(ADDON.classicon.size + 1.5)
        namePlate.classIconBorder:SetHeight(ADDON.classicon.size + 1.5)
      end   
      namePlate.classIconBorder:Hide()
      namePlate.classIcon:SetTexture(0,0,0,0)
      Border:Hide()
      Glow:Hide()

      Name:SetFontObject(GameFontNormal)
      Name:SetFont(ADDON.nametext.font,ADDON.nametext.size)
      Name:SetPoint(ADDON.nametext.point, namePlate, ADDON.nametext.anchorpoint, ADDON.nametext.xoffs, ADDON.nametext.yoffs)
      
      Level:SetFontObject(GameFontNormal)
      Level:SetFont(ADDON.leveltext.font,ADDON.leveltext.size)
      Level:SetPoint(ADDON.leveltext.point, namePlate.classIcon, ADDON.leveltext.anchorpoint,ADDON.leveltext.xoffs,ADDON.leveltext.yoffs)

      HealthBar:Show()
      Name:Show()

      local red, green, blue, _ = Name:GetTextColor() --Set Color of Namelabel
      -- Print(red.." "..green.." "..blue)
      if red > 0.99 and green == 0 and blue == 0 then
        Name:SetTextColor(1,0.4,0.2,0.85)
      elseif red > 0.99 and green > 0.81 and green < 0.82 and blue == 0 then
        Name:SetTextColor(1,1,1,0.85)
      end

      local red, green, blue, _ = HealthBar:GetStatusBarColor() --Set Color of Healthbar
      if blue > 0.99 and red == 0 and green == 0 then
        HealthBar:SetStatusBarColor(0.2,0.6,1,0.85)
      elseif red == 0 and green > 0.99 and blue == 0 then
        HealthBar:SetStatusBarColor(0.6,1,0,0.85)
      end

      local red, green, blue, _ = Level:GetTextColor() --Set Color of Level
      
      if red > 0.99 and green == 0 and blue == 0 then
        Level:SetTextColor(1,0.4,0.2,0.85)
      elseif red > 0.99 and green > 0.81 and green < 0.82 and blue == 0 then
        Level:SetTextColor(1,1,1,0.85)
      end

      if (ADDON.leveltext.hide) then
        Level:Hide()
      else
        Level:Show()
      end

      local name = Name:GetText()
      if ADDON.genSettings.showPets ~= true then
        if ADDON.isPet(name) then
          HealthBar:Hide()
          Name:Hide()
          Level:Hide()
        end
      end
      if UnitName("target") == nil and string_find(name, "%s") == nil and string_len(name) <= 12 and ADDON.Targets[name] == nil then --Set Name text and save it in a list
        CustomNameplates.scanningPlayers = true
        ADDON.fillPlayerDB(name)
        ClearTarget()
        CustomNameplates.scanningPlayers = false
      end
      
      --if currently one of the nameplates is an actual player, draw ADDON.classicon
      if (ADDON.classicon.hide) then
      else
        if ADDON.Players[name] ~= nil and namePlate.classIcon:GetTexture() == "Solid Texture" and string_find(namePlate.classIcon:GetTexture(), "Interface") == nil then
          namePlate.classIcon:SetTexture(ADDON.Icons[ADDON.Players[name]["class"]])
          namePlate.classIcon:SetTexCoord(.078, .92, .079, .937)
          namePlate.classIcon:SetAlpha(0.9)
          namePlate.classIconBorder:Show()
        end        
      end

      namePlate:EnableMouse(true)

    end
  end  
end

-- xml script handlers (need to be globals)
function CustomNameplatesHandleEvent(event) --Handles wow events
  
  if event == "PLAYER_ENTERING_WORLD" then
    if (ADDON.genSettings.enableAddOn and not ADDON.genSettings.combatOnly) then
      ShowNameplates()
    else
      HideNameplates()
    end
    if (ADDON.genSettings.showFriendly) then
      ShowFriendNameplates()
    else
      HideFriendNameplates()
    end    
    if (ADDON.genSettings.combatOnly) and (UnitAffectingCombat("player") or UnitAffectingCombat("pet")) then
      ShowNameplates()
    end
  end
  
  if event == "PLAYER_TARGET_CHANGED" or event == "UNIT_AURA" then
    if UnitExists("target") then
      if UnitIsPlayer("target") then
        local name = UnitName("target")
        ADDON.fillPlayerDB(name)
      end
    end
  end

  if (ADDON.genSettings.combatOnly) then
    if event == "PLAYER_REGEN_DISABLED" then -- incombat
      ShowNameplates()
    elseif event == "PLAYER_REGEN_ENABLED" then -- exiting combat
      HideNameplates()
    end
  end

end

function CustomNameplatesUpdate(elapsed) --updates the frames
  ADDON.CustomNameplates_OnUpdate(elapsed)
end