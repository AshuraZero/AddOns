--[[ simpleMinimap Options ]]--

local smmoMouseOptions = {"LeftButton","MiddleButton","RightButton","Button4","Button5"}
local smmoAlphaOptions = {"0.20","0.30","0.40","0.50","0.60","0.70","0.75","0.80","0.85","0.90","0.95","1.00"}
local smmoScaleOptions = {"0.80","0.90","1.00","1.10","1.15","1.20","1.25","1.30","1.35","1.40","1.50","1.60"}
StaticPopupDialogs["smmo_RESET"] = {text=smmo_RESET_TEXT, button1=TEXT(ACCEPT), button2=TEXT(CANCEL), OnAccept=function() smmConf=nil smm_checkDefaults() smm_update() end, timeout=30, whileDead=1, hideOnEscape=1}

--[[ drop-down menu ]]--
--
function smmo_initialize()
  if(smmConf) then
    if(UIDROPDOWNMENU_MENU_LEVEL==1) then
      UIDropDownMenu_AddButton({text="simpleMinimap |cFFFFFFCCv"..smmVersion..smmSubVersion, isTitle=1, justifyH="CENTER", textHeight=13})
      UIDropDownMenu_AddButton({text="", notClickable=1, notCheckable=1})
      UIDropDownMenu_AddButton({text="|cFFFFCC66"..smmo_SHOW_HEADING, notClickable=1, notCheckable=1, justifyH="CENTER", textHeight=11})
      UIDropDownMenu_AddButton({value=30, text=smmo_BUTTONS, tooltipText=smmo_ALPHA_TOOLTIP, hasArrow=1, func=smmo_update})
      UIDropDownMenu_AddButton({value=2, text=smmo_MOVERS, tooltipText=smmo_MOVERS_TOOLTIP, checked=smmConf.show.movers~=0 or nil, func=smmo_update, keepShownOnClick=1})
      UIDropDownMenu_AddButton({value=3, text=smmo_PING, tooltipText=smmo_PING_TOOLTIP, checked=smmConf.show.pings~=0 or nil, func=smmo_update, keepShownOnClick=1})
      UIDropDownMenu_AddButton({text="", notClickable=1, notCheckable=1})
      UIDropDownMenu_AddButton({value=10, text=smmo_ALPHA, tooltipText=smmo_ALPHA_TOOLTIP, hasArrow=1, func=smmo_update})
      UIDropDownMenu_AddButton({value=11, text=smmo_SCALE, tooltipText=smmo_SCALE_TOOLTIP, hasArrow=1, func=smmo_update})
      UIDropDownMenu_AddButton({value=12, text=smmo_SKIN, tooltipText=smmo_SKIN_TOOLTIP, hasArrow=1, func=smmo_update})
      UIDropDownMenu_AddButton({value=13, text=smmo_MOUSE, tooltipText=smmo_MOUSE_TOOLTIP, hasArrow=1, func=smmo_update})
      UIDropDownMenu_AddButton({text="", notClickable=1, notCheckable=1})
      UIDropDownMenu_AddButton({value=20, text=smmo_LOCK, tooltipText=smmo_LOCK_TOOLTIP, checked=smmConf.lock~=0 or nil, func=smmo_update})
      UIDropDownMenu_AddButton({value=21, text=smmo_RESET, tooltipText=smmo_RESET_TOOLTIP, func=smmo_update})
    else
      if(this.value==10) then
        for i in smmoAlphaOptions do
          if(tonumber(smmoAlphaOptions[i])==tonumber(smmConf.alpha)) then
            UIDropDownMenu_AddButton({text="|cFFFFCC66"..smmoAlphaOptions[i], notCheckable=1, notClickable=1, justifyH="CENTER", owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
          else
            UIDropDownMenu_AddButton({value=i, text=smmoAlphaOptions[i], notCheckable=1, func=smmo_update, justifyH="CENTER", owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
          end
        end
      elseif(this.value==11) then
        for i in smmoScaleOptions do
          if(tonumber(smmoScaleOptions[i])==tonumber(smmConf.scale)) then
            UIDropDownMenu_AddButton({text="|cFFFFCC66"..smmoScaleOptions[i], notCheckable=1, notClickable=1, justifyH="CENTER", owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
          else
            UIDropDownMenu_AddButton({value=i, text=smmoScaleOptions[i], notCheckable=1, func=smmo_update, justifyH="CENTER", owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
          end
        end
      elseif(this.value==12) then
        for i in smmSkins do
          if(i==smmConf.skin) then
            UIDropDownMenu_AddButton({text="|cFFFFCC66"..i.." :: "..smmo_SKIN_OPTIONS[i], notCheckable=1, notClickable=1, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
          else
            UIDropDownMenu_AddButton({value=i, text=i.." :: "..smmo_SKIN_OPTIONS[i], notCheckable=1, func=smmo_update, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
          end
        end
      elseif(this.value==13) then
        for i in smmo_MOUSE_OPTIONS do
          if(smmoMouseOptions[i]==smmConf.mouse) then
            UIDropDownMenu_AddButton({text="|cFFFFCC66"..smmo_MOUSE_OPTIONS[i], notCheckable=1, notClickable=1, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
          else
            UIDropDownMenu_AddButton({value=i, text=smmo_MOUSE_OPTIONS[i], notCheckable=1, func=smmo_update, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
          end
        end
      elseif(this.value==30) then
        UIDropDownMenu_AddButton({value=1, text=smmo_BUTTONS_BGS, checked=smmConf.show.bgs~=0 or nil, func=smmo_update, keepShownOnClick=1, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
        UIDropDownMenu_AddButton({value=2, text=smmo_BUTTONS_MAIL, checked=smmConf.show.mail~=0 or nil, func=smmo_update, keepShownOnClick=1, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
        UIDropDownMenu_AddButton({value=3, text=smmo_BUTTONS_MEET, checked=smmConf.show.meet~=0 or nil, func=smmo_update, keepShownOnClick=1, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
        UIDropDownMenu_AddButton({value=4, text=smmo_BUTTONS_LOCATION, checked=smmConf.show.location~=0 or nil, func=smmo_update, keepShownOnClick=1, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
        UIDropDownMenu_AddButton({value=5, text=smmo_BUTTONS_TIME, checked=smmConf.show.time~=0 or nil, func=smmo_update, keepShownOnClick=1, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
        UIDropDownMenu_AddButton({value=6, text=smmo_BUTTONS_TRACK, checked=smmConf.show.track~=0 or nil, func=smmo_update, keepShownOnClick=1, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
        UIDropDownMenu_AddButton({value=7, text=smmo_BUTTONS_ZOOM, checked=smmConf.show.zoom~=0 or nil, func=smmo_update, keepShownOnClick=1, owner=this.value}, UIDROPDOWNMENU_MENU_LEVEL)
      end
    end
  end
end
--
function smmo_update()
  if(not this.owner) then
    if(this.value==2) then
      if UIDropDownMenuButton_GetChecked() then smmConf.show.movers=0 else smmConf.show.movers=1 end
    elseif(this.value==3) then
      if UIDropDownMenuButton_GetChecked() then smmConf.show.pings=0 else smmConf.show.pings=1 end
    elseif(this.value==20) then
      if UIDropDownMenuButton_GetChecked() then smmConf.lock=0 else smmConf.lock=1 end
    elseif(this.value==21) then
      StaticPopup_Show("smmo_RESET")
    else
      return
    end
  elseif(this.owner==10) then
    smmConf.alpha = tonumber(smmoAlphaOptions[this.value])
  elseif(this.owner==11) then
    local x = tonumber(smmoScaleOptions[this.value])
    if(smmConf.framePos.map) then
      smmConf.framePos.map.x = (smmConf.scale / x) * smmConf.framePos.map.x
      smmConf.framePos.map.y = (smmConf.scale / x) * smmConf.framePos.map.y
    end
    smmConf.scale = x
  elseif(this.owner==12) then
    smmConf.skin = this.value
  elseif(this.owner==13) then
    smmConf.mouse = smmoMouseOptions[this.value]
  elseif(this.owner==30) then
    if(this.value==1) then
      if UIDropDownMenuButton_GetChecked() then smmConf.show.bgs=0 else smmConf.show.bgs=1 end
    elseif(this.value==2) then
      if UIDropDownMenuButton_GetChecked() then smmConf.show.mail=0 else smmConf.show.mail=1 end
    elseif(this.value==3) then
      if UIDropDownMenuButton_GetChecked() then smmConf.show.meet=0 else smmConf.show.meet=1 end
    elseif(this.value==4) then
      if UIDropDownMenuButton_GetChecked() then smmConf.show.location=0 else smmConf.show.location=1 end
    elseif(this.value==5) then
      if UIDropDownMenuButton_GetChecked() then smmConf.show.time=0 else smmConf.show.time=1 end
    elseif(this.value==6) then
      if UIDropDownMenuButton_GetChecked() then smmConf.show.track=0 else smmConf.show.track=1 end
    elseif(this.value==7) then
      if UIDropDownMenuButton_GetChecked() then smmConf.show.zoom=0 else smmConf.show.zoom=1 end
    else
      return
    end
  else
    return
  end
  smm_update()
end
