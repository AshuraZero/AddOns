--[[ simpleMinimap ]]--

smmVersion,smmSubVersion = "18",""
smmInside = true
smmSkins = {
  { square = false,
    texture = "Interface\\Minimap\\UI-Minimap-Border",
    mask = "textures\\MinimapMask",
  },
  { square = false,
    texture = nil,
    mask = "textures\\MinimapMask",
  },
  { square = true,
    texture = "Interface\\AddOns\\simpleMinimap\\skins\\SquareMinimap",
    mask = "Interface\\AddOns\\simpleMinimap\\skins\\SquareMinimapMask",
  },
  { square = true,
    texture = nil,
    mask = "Interface\\AddOns\\simpleMinimap\\skins\\SquareMinimapMask",
  },
  { square = true,
    texture = "Interface\\AddOns\\simpleMinimap\\skins\\dLxTopRight",
    mask = "Interface\\AddOns\\simpleMinimap\\skins\\dLxTopRightMask",
  },
  { square = true,
    texture = "nil",
    mask = "Interface\\AddOns\\simpleMinimap\\skins\\dLxTopRightMask",
  },
}
smmFrames = {
  frames = {
    map = "MinimapCluster",
    quest = "QuestWatchFrame",
    doll = "DurabilityFrame",
    timer = "QuestTimerFrame",
  },
  movers = {
    quest = "smm_questMover",
    doll = "smm_dollMover",
    timer = "smm_timerMover",
  },
  frameDef = {
    map = { anchor = UIParent, point = "TOPRIGHT", rpoint = "TOPRIGHT", x = 0, y = 0 },
    quest = { anchor = MinimapCluster, point = "TOPRIGHT", rpoint = "BOTTOMRIGHT", x = 0, y = 10 },
    doll = { anchor = MinimapCluster, point = "TOPRIGHT", rpoint = "BOTTOMRIGHT", x = 40, y = 15 },
    timer = { anchor = MinimapCluster, point = "TOPRIGHT", rpoint = "BOTTOMRIGHT", x = 10, y = 0 },
  },
  buttons = {
    bgs = MiniMapBattlefieldFrame,
    meet = MiniMapMeetingStoneFrame,
    mail = MiniMapMailFrame,
    time = GameTimeFrame,
    track = MiniMapTrackingFrame,
    zoomin = MinimapZoomIn,
    zoomout = MinimapZoomOut,
  },
}


--[[ initialize ]]--
--
-- debug messages
function smm_debug(text)
  if(ChatFrame2) then ChatFrame2:AddMessage(text,0,0.8,1.0) end
end
--
-- info messages
function smm_msg(text)
  DEFAULT_CHAT_FRAME:AddMessage(text,0.9,0.8,0)
end
--
-- default settings
function smm_checkDefaults()
  smmConf = smmConf or {}
    smmConf.alpha = smmConf.alpha or 1
    smmConf.skin = smmConf.skin or 1
    smmConf.lock = smmConf.lock or 0
    smmConf.mouse = smmConf.mouse or "RightButton"
    smmConf.scale = smmConf.scale or 1
  smmConf.buttonPos = smmConf.buttonPos or {}
    smmConf.buttonPos.bgs = smmConf.buttonPos.bgs or 302
    smmConf.buttonPos.meet = smmConf.buttonPos.meet or 189
    smmConf.buttonPos.mail = smmConf.buttonPos.mail or 169
    smmConf.buttonPos.time = smmConf.buttonPos.time or 137
    smmConf.buttonPos.track = smmConf.buttonPos.track or 38
    smmConf.buttonPos.zoomin = smmConf.buttonPos.zoomin or 209
    smmConf.buttonPos.zoomout = smmConf.buttonPos.zoomout or 235
  smmConf.framePos = smmConf.framePos or {}
  smmConf.show = smmConf.show or {}
    smmConf.show.bgs = smmConf.show.bgs or 1
    smmConf.show.location = smmConf.show.location or 1
    smmConf.show.mail = smmConf.show.mail or 1
    smmConf.show.meet = smmConf.show.meet or 1
    smmConf.show.movers = smmConf.show.movers or 0
    smmConf.show.pings = smmConf.show.pings or 1
    smmConf.show.time = smmConf.show.time or 1
    smmConf.show.track = smmConf.show.track or 1
    smmConf.show.zoom = smmConf.show.zoom or 1
end
--
-- init & feedback for the XML load
function smm_onLoad()
  SLASH_SIMPMM1 = "/smm"
  SlashCmdList["SIMPMM"] = smm_slash
  this:RegisterEvent("MINIMAP_PING")
  this:RegisterEvent("MINIMAP_UPDATE_ZOOM")
  this:RegisterEvent("PLAYER_ENTERING_WORLD")
  this:RegisterEvent("VARIABLES_LOADED")
end
--
-- on event
function smm_onEvent()
  if(event=="MINIMAP_PING") then
    return(smm_minimapPing(arg1))
  elseif(event=="MINIMAP_UPDATE_ZOOM") then
    local z = Minimap:GetZoom()
    if (GetCVar("minimapZoom") == GetCVar("minimapInsideZoom")) then
      if (z < 3) then 
        Minimap:SetZoom(z + 1)
      else
        Minimap:SetZoom(z - 1)
      end
    else
      z = nil
    end
    if (tonumber(GetCVar("minimapInsideZoom")) == Minimap:GetZoom()) then
      smmInside = true
      MinimapCluster:SetAlpha(1)
    else
      smmInside = false
      MinimapCluster:SetAlpha(smmConf.alpha)
    end
    if(z) then Minimap:SetZoom(z) end
  elseif(event=="PLAYER_ENTERING_WORLD") then
    smm_update()
  elseif(event=="VARIABLES_LOADED") then
    smm_checkDefaults()
    if(smmConf.framePos.map) then smm_lockFrame(MinimapCluster,true) end
    MinimapCluster:SetMovable(true)
    Minimap:RegisterForDrag("LeftButton")
    Minimap:SetScript("OnDragStart",function() smm_frameDrag(true,"map") end)
    Minimap:SetScript("OnDragStop",function() smm_frameDrag(false,"map") end)
    Minimap:SetScript("OnMouseUp",function()
      if(arg1==smmConf.mouse) then
        if(not IsAddOnLoaded("simpleMinimap_Options") and not LoadAddOn("simpleMinimap_Options")) then
          smm_debug("smm :: could not load options addon")
          Minimap:SetScript("OnMouseUp",function() Minimap_OnClick() end)
          return(Minimap_OnClick())
        end
        ToggleDropDownMenu(1,nil,simpleMinimap_Options,simpleMinimap)
      else
        Minimap_OnClick()
      end
    end)
    MinimapZoneTextButton:RegisterForDrag("LeftButton")
    MinimapZoneTextButton:SetScript("OnDragStart",function() smm_frameDrag(true,"map") end)
    MinimapZoneTextButton:SetScript("OnDragStop",function() smm_frameDrag(false,"map") end)
    for _,f in pairs(smmFrames.buttons) do
      f:SetMovable(true)
      f:RegisterForDrag("LeftButton")
      f:SetScript("OnDragStart",function() smm_buttonDrag(true) end)
      f:SetScript("OnDragStop",function() smm_buttonDrag(false) end)
    end
    smm_debug(":: simpleMinimap version "..smmVersion..smmSubVersion.." loaded ::")
  end
end


--[[ frame events ]]--
--
-- minimap zoom
function smm_minimapZoom(x)
  if(IsShiftKeyDown()) then
    if(not smmInside) then
      local z = MinimapCluster:GetAlpha()
      if(x > 0) then
        if(z < 1) then smmConf.alpha = z + 0.05 else return end
      else
        if(z > 0) then smmConf.alpha = z - 0.05 else return end
      end
      MinimapCluster:SetAlpha(smmConf.alpha)
    end
  else
    if(x > 0) then
      Minimap_ZoomIn()
    else
      Minimap_ZoomOut()
    end
  end
end
--
-- minimap ping
function smm_minimapPing(x)
  if(smmConf.show.pings and not UnitIsUnit(x,"player")) then
    smm_pingText:SetText("ping by |cFFFFFFCC"..UnitName(x))
    smm_ping:SetWidth(smm_pingText:GetWidth() + 18);
    smm_ping:SetHeight(smm_pingText:GetHeight() + 12);
    smm_ping:Show()
  else
    smm_ping:Hide()
  end
end
--
-- frame drag
function smm_frameDrag(x,y)
  local frame = getglobal(smmFrames.frames[y])
  if(x and smmConf.lock==0) then
    frame.isMoving = true
    frame:StartMoving()
  elseif(frame.isMoving) then
    frame.isMoving = false
    frame:StopMovingOrSizing()
    smmConf.framePos[y] = {}
    smmConf.framePos[y].x,smmConf.framePos[y].y = frame:GetCenter()
    smm_update()
  end
end
--
-- button drag
function smm_buttonDrag(x)
  local function getPos()
    local cx,cy = GetCursorPosition(UIParent)
    local mx,my = Minimap:GetLeft(),Minimap:GetBottom()
    local z = Minimap:GetEffectiveScale()
    return(math.deg(math.atan2(cy/z-my-70,mx-cx/z+70)))
  end
  if(x and smmConf.lock==0) then
    this.isMoving = true
    this:SetScript("OnUpdate",function()
      local x,y,z = 0,0,getPos()
      this:ClearAllPoints()
      if(smmSkins[smmConf.skin]["square"]) then
        x = math.max(-81,math.min(110*cos(z),81))
        y = math.max(-81,math.min(110*sin(z),81))
      else
        x = 81*cos(z)
        y = 81*sin(z)
      end
      this:SetPoint("TOPLEFT",Minimap,"TOPLEFT",52-x,y-54)
    end)
    this:StartMoving()
  elseif(this.isMoving) then
    this.isMoving = false
    this:StopMovingOrSizing()
    this:SetScript("OnUpdate",nil)
    for n,f in pairs(smmFrames.buttons) do
      if(f==this) then smmConf.buttonPos[n] = getPos() end
    end
  end
end


--[[ minimap update ]]--
--
-- lock / unlock frame movement
function smm_lockFrame(frame,lock)
  if(lock) then
    if(not frame.smmTouched) then
      frame.smm_ClearAllPoints = frame.ClearAllPoints
      frame.smm_SetAllPoints = frame.SetAllPoints
      frame.smm_SetPoint = frame.SetPoint
      frame.ClearAllPoints = function() end
      frame.SetAllPoints = function() end
      frame.SetPoint = function() end
      frame.smmTouched = true
    end
  elseif(frame.smmTouched) then
    frame.ClearAllPoints = frame.smm_ClearAllPoints
    frame.SetAllPoints = frame.smm_SetAllPoints
    frame.SetPoint = frame.smm_SetPoint
    frame.smm_ClearAllPoints = nil
    frame.smm_SetAllPoints = nil
    frame.smm_SetPoint = nil
    frame.smmTouched = nil
  end
end
--
-- update the UI elements
function smm_update()
  MinimapBorder:SetTexture(smmSkins[smmConf.skin]["texture"])
  Minimap:SetMaskTexture(smmSkins[smmConf.skin]["mask"])
  for n,f in pairs(smmFrames.frames) do
    local frame = getglobal(f)
    if(smmConf.framePos[n]) then
      smm_lockFrame(frame,true)
      frame:smm_ClearAllPoints()
      frame:smm_SetPoint("CENTER",UIParent,"BOTTOMLEFT",smmConf.framePos[n].x,smmConf.framePos[n].y)
    elseif(getglobal(f).smmTouched) then
      smm_lockFrame(frame,false)
      frame:ClearAllPoints()
      frame:SetPoint(smmFrames.frameDef[n].point,smmFrames.frameDef[n].anchor,smmFrames.frameDef[n].rpoint,smmFrames.frameDef[n].x,smmFrames.frameDef[n].y)
      frame:SetUserPlaced(false)
    end
  end
  for n,f in pairs(smmFrames.buttons) do
    local x,y = 0,0
    if(smmConf.skin and smmSkins[smmConf.skin]["square"]) then
      x = math.max(-81,math.min(110*cos(smmConf.buttonPos[n]),81))
      y = math.max(-81,math.min(110*sin(smmConf.buttonPos[n]),81))
    else
      x = 81*cos(smmConf.buttonPos[n])
      y = 81*sin(smmConf.buttonPos[n])
    end
    f:ClearAllPoints()
    f:SetPoint("TOPLEFT",Minimap,"TOPLEFT",52-x,y-54)
  end
  MinimapCluster:SetScale(smmConf.scale)
  for n in smmConf.show do
    if(n=="location") then
      if(smmConf.show.location==0) then
        MinimapZoneTextButton:Disable()
        MinimapToggleButton:Disable()
        MinimapZoneTextButton:Hide()
        MinimapToggleButton:Hide()
        MinimapBorderTop:Hide()
      else
        MinimapZoneTextButton:Show()
        MinimapToggleButton:Show()
        MinimapBorderTop:Show()
        MinimapZoneTextButton:Enable()
        MinimapToggleButton:Enable()
      end
    elseif(n=="movers") then
      if(smmConf.lock==0 and smmConf.show.movers~=0) then
        for n in smmFrames.movers do
          local frame = getglobal(smmFrames.movers[n])
          frame:Show()
          frame:ClearAllPoints()
          frame:SetPoint("CENTER",getglobal(smmFrames.frames[n]),"CENTER")
        end
      else
        for n in smmFrames.movers do getglobal(smmFrames.movers[n]):Hide() end
      end
    elseif(n=="zoom") then
      if(smmConf.show.zoom==0) then
        MinimapZoomIn:Hide()
        MinimapZoomOut:Hide()
      else
        MinimapZoomIn:Show()
        MinimapZoomOut:Show()
      end
    elseif(smmFrames.buttons[n]) then
      if(smmConf.show[n]==0) then
        if(not smmFrames.buttons[n].smmTouched) then
          smmFrames.buttons[n].smmShow = smmFrames.buttons[n]:IsShown()
          smmFrames.buttons[n].smm_Hide = smmFrames.buttons[n].Hide
          smmFrames.buttons[n].Hide = function() this.smmShow = nil end
          smmFrames.buttons[n].smm_Show = smmFrames.buttons[n].Show
          smmFrames.buttons[n].Show = function() this.smmShow = true end
          smmFrames.buttons[n].smmTouched = true
        end
        smmFrames.buttons[n]:smm_Hide()
      else
        if(smmFrames.buttons[n].smmTouched) then
          smmFrames.buttons[n].Hide = smmFrames.buttons[n].smm_Hide
          smmFrames.buttons[n].smm_Hide = nil
          smmFrames.buttons[n].Show = smmFrames.buttons[n].smm_Show
          smmFrames.buttons[n].smm_Show = nil
          smmFrames.buttons[n].smmTouched = nil
          if(smmFrames.buttons[n].smmShow) then smmFrames.buttons[n]:Show() end
        end
      end
    end
  end
  if(smmInside) then
    MinimapCluster:SetAlpha(1)
  else
    MinimapCluster:SetAlpha(smmConf.alpha)
  end
end


--[[ slash command handler ]]--
--
function smm_slash(x)
  local _,_,y,z = string.find(x,"(%w+)%s*(.*)")
  if(y=="hide" and smmConf.show[z]) then
    smmConf.show[z]=0
    smm_debug("smm :: hiding "..z)
  elseif(y=="show" and smmConf.show[z]) then
    smmConf.show[z]=1
    smm_debug("smm :: showing "..z)
  elseif(y=="alpha" and tonumber(z)) then
    z=tonumber(z)
    if (z<0) then z=0 elseif(z>1) then z=1 end
    smmConf.alpha = z
    smm_debug("smm :: setting minimap alpha ("..z..")")
  elseif(y=="scale" and tonumber(z)>0) then
    z=tonumber(z)
    if(smmConf.framePos.map) then
      smmConf.framePos.map.x = (smmConf.scale / z) * smmConf.framePos.map.x
      smmConf.framePos.map.y = (smmConf.scale / z) * smmConf.framePos.map.y
    end
    smmConf.scale = z
    smm_debug("smm :: setting minimap scale ("..z..")")
  elseif(y=="lock") then
    if(smmConf.lock~=0) then
      smmConf.lock = 0
      smm_debug("smm :: unlocking minimap")
    else
      smmConf.lock = 1
      smm_debug("smm :: locking minimap")
    end
  elseif(y=="skin") then
    if(smmConf.skin) then
      smmConf.skin = smmConf.skin + 1
    end
    if(not smmSkins[smmConf.skin]) then smmConf.skin = 1 end
    smm_debug("smm :: changing the minimap skin ("..smmConf.skin..")")
  elseif(y=="reset") then
    smmConf = nil
    smm_checkDefaults()
    smm_debug("smm :: resetting minimap")
  else
    for _,t in pairs(sm_HELP) do smm_msg(t) end
    return
  end
  smm_update()
end
