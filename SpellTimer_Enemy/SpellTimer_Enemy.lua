ENEMY_BAR_MAX_NUMBER = 6
Enemy_Default_Config = {
    ["Color"] ={
         ["gains"] = {["r"] = 1.0, ["g"] = 0.0, ["b"] = 1.0},
	 ["performs"]  = {["r"] = 1.0, ["g"] = 0.7, ["b"] = 0.0},
    },
    ["EnemyEnable"] = nil,
    ["EnableP"] = 1,
    ["EnableG"] = 1,
    ["EnableF"] = 1,
    ["EnableO"] = nil,
    ["Spells"] = {
         ["performs"] = {n=0},
	 ["gains"] = {n=0},
    },
 }
function SpellTimer_Enemy_OnLoad()	
    this:RegisterEvent("VARIABLES_LOADED")	  
end
-----------------------------------------------------------------------------------------
--只显示目标施法
-----------------------------------------------------------------------------------------
function ST_Enable_Target_Only_OnClick()
    if (this:GetChecked() == 1) then
         EnemyConfig.EnableO = 1
    else
         EnemyConfig.EnableO = nil
    end
end
function ST_Enable_Target_Only_OnShow()
    getglobal(this:GetName().."Text"):SetText(ST_ENABLE_TARGET_ONLY) 
    if ( not EnemyConfig.EnemyEnable) then
    	 MobElement_Disable(this) 
    else
         MobElement_Enable(this)  
    end
    if (EnemyConfig.EnableO) then
    	 this:SetChecked(1)
    else
         this:SetChecked(0)
    end
end
-----------------------------------------------------------------------------------------
--显示施放类法术
-----------------------------------------------------------------------------------------
function ST_Enable_Performs_OnClick()
    if (this:GetChecked() == 1) then
         EnemyConfig.EnableP = 1
    else
         EnemyConfig.EnableP = nil
    end
end
function ST_Enable_Performs_OnShow()
    getglobal(this:GetName().."Text"):SetText(ST_ENABLE_PERFORMS) 
    if ( not EnemyConfig.EnemyEnable) then
    	 MobElement_Disable(this) 
    else
         MobElement_Enable(this)  
    end
    if (EnemyConfig.EnableP) then
    	 this:SetChecked(1)
    else
         this:SetChecked(0)
    end
end
-----------------------------------------------------------------------------------------
--显示友方计时
-----------------------------------------------------------------------------------------
function ST_Enable_Friends_OnClick()
    SpellTimer_EnemyBar_Toggle(nil)
    if (this:GetChecked() == 1) then
         EnemyConfig.EnableF = 1
    else
         EnemyConfig.EnableF = nil
    end    
    SpellTimer_EnemyBar_Toggle(1)
end
function ST_Enable_Friend_OnShow()
    getglobal(this:GetName().."Text"):SetText(ST_ENABLE_FRIENDS) 
    if ( not EnemyConfig.EnemyEnable) then
    	 MobElement_Disable(this) 
    else
         MobElement_Enable(this)  
    end
    if (EnemyConfig.EnableF) then
    	 this:SetChecked(1)
    else
         this:SetChecked(0)
    end
end
-----------------------------------------------------------------------------------------
--显示获得类计时 
-----------------------------------------------------------------------------------------
function ST_Enable_Gains_OnClick()
    if (this:GetChecked() == 1) then
         EnemyConfig.Enableg = 1
    else
         EnemyConfig.Enableg = nil
    end
end
function ST_Enable_Gains_OnShow()
    getglobal(this:GetName().."Text"):SetText(ST_ENABLE_GAINS) 
    if ( not EnemyConfig.EnemyEnable) then
    	 MobElement_Disable(this) 
    else
         MobElement_Enable(this)  
    end
    if (EnemyConfig.EnableG) then
    	 this:SetChecked(1)
    else
         this:SetChecked(0)
    end
end
-----------------------------------------------------------------------------------------
--点击事件
-----------------------------------------------------------------------------------------
function SpellTimer_EnemyBar_OnClick()
    if (this:GetParent().targetname) then
         TargetByName(this:GetParent().targetname) 
    end       
end

function SpellTimer_Enemy_OnClick()
    if (this:GetParent():GetParent().targetname) then
         TargetByName(this:GetParent():GetParent().targetname) 
    end    	
end
--------------------------------------------------------------------------------------------
--鼠标进入显示
--------------------------------------------------------------------------------------------
function SpellTimer_EnemyBar_OnEnter()    
    GameTooltip:SetOwner(this, "ANCHOR_TOPLEFT")
    if (this:GetParent().targetname) then
         GameTooltip:AddLine(ST_TARGET..this:GetParent().targetname, 1, 1, 0)	 
    elseif (this:GetParent():GetParent().targetname) then
         GameTooltip:AddLine(ST_TARGET..this:GetParent():GetParent().targetname, 1, 1, 0)       
    else
         GameTooltip:AddLine(SPELL_TIMER_ENEMY,1,1,1) 
    end
    if (not SpellTimer_Config.TooltipInfo) then
         GameTooltip:AddLine(SPELL_TIMER_ENEMY_TOOLTIP)
    end
    GameTooltip:Show()
end
----------------------------------------------------------------------------------------
--改为按照人名,法术名,类型来隐藏
----------------------------------------------------------------------------------------
function SpellTimer_EnemyBar_Remove(targetname, spellname,ctype)
    local framecast, frame
    if (ctype) then
    	 framecast = getglobal("SpellTimer_EnemyCast")    
         if (framecast and framecast:IsVisible() and (framecast.name == targetname or not targetname) and (not spell or (framecast.spell == spellname))) then
	      SpellTimer_EnemyBar_Hide(framecast)
         end
    end
    for i = 1, ENEMY_BAR_MAX_NUMBER do         	
	 frame = getglobal("SpellTimer_Enemy"..i)	   	 
	 if (frame and frame:IsVisible() and (frame.name == targetname or not targetname) and (not spell or (frame.spell == spellname))) then
	      SpellTimer_EnemyBar_Hide(frame)
	 end
    end
end

function SpellTimer_EnemyBar_Hide(frame)
    if (frame and frame:IsShown()) then         
         local bar = getglobal(frame:GetName().."Bar")
         local spark = getglobal(bar:GetName().."Spark")
         local flash = getglobal(bar:GetName().."Flash")
	 bar:SetValue(frame.max) 
	 bar:SetStatusBarColor(0.0, 1.0, 0.0) 
         spark:Hide() 
	 flash:SetAlpha(0.0) 
	 flash:Show() 
	 frame.flash = 1 
    end   
    frame.casting = nil 
    frame.fadeOut = 1      
end	
--------------------------------------------------------------------------------------------------
--初试化显示
--------------------------------------------------------------------------------------------------
function InitSpellTimer_EnemyBar(frame,spellname,duration,ctype)
     local bar = getglobal(frame:GetName().."Bar") 
     local Icon = getglobal(frame:GetName().."IconTexture")
     local Text = getglobal(frame:GetName().."Text") 
     frame.now = GetTime() 
     frame.max = frame.now + duration
     local spark = getglobal(bar:GetName().."Spark")
     local flash = getglobal(bar:GetName().."Flash") 
     local r, g, b
     if (ctype == "performs") then
          r, g, b = EnemyConfig["Color"]["performs"].r, EnemyConfig["Color"]["performs"].g, EnemyConfig["Color"]["performs"].b
     else 
          r, g, b = EnemyConfig["Color"]["gains"].r, EnemyConfig["Color"]["gains"].g, EnemyConfig["Color"]["gains"].b
     end
     bar:SetStatusBarColor(r, g, b)           
     bar:SetMinMaxValues(frame.now, frame.max) 
     bar:SetValue(frame.now) 
     flash:Hide() 
     bar:Show() 
     spark:SetPoint("CENTER", bar, "LEFT", 0, 0) 
     spark:Show() 
     Text:ClearAllPoints() 
     Text:SetPoint("TOPLEFT", frame, "TOPLEFT", 35, -6.0) 
     Text:SetText(spellname.." - "..SpellTimer_Format(duration))  
     local texture = SpellTimer_Enemy_Spells[spellname].icontex
     Icon:SetTexture("Interface\\Icons\\"..texture)
     frame:SetAlpha(1.0) 
     frame.Enable = 1 
     frame.casting = 1 
     frame.fadeOut = nil 
     frame:Show()      
end
-------------------------------------------------------------------------------------------
--显示
-------------------------------------------------------------------------------------------
function SpellTimer_EnemyBar_Show(targetname,targetlevel,spellname,duration,ctype) 
     for i = 1, ENEMY_BAR_MAX_NUMBER, 1 do
         local frame 
	 if (ctype == "performs") then
	      frame = getglobal("SpellTimer_EnemyCast")
	 else
	      frame = getglobal("SpellTimer_Enemy"..i)
	 end
         if (frame and frame:IsVisible() and ( not frame.targetname or (frame.targetname == targetname and frame.targetlevel == targetlevel)) and frame.spell == spellname) then
              InitSpellTimer_EnemyBar(frame, spellname, duration, ctype) 
	      frame.targetname = targetname
	      frame.targetlevel = targetlevel 
	      return 
         end 
     end   
     for i = 1, ENEMY_BAR_MAX_NUMBER, 1 do
         local frame 
	 if (ctype == "performs") then
	      frame = getglobal("SpellTimer_EnemyCast")
	 else
	      frame = getglobal("SpellTimer_Enemy"..i)
	 end         
         if (frame and not frame:IsVisible()) then	    
              frame.spell = spellname 
	      frame.targetname = targetname
	      frame.targetlevel = targetlevel 	     
	      frame.type = ctype   
	      InitSpellTimer_EnemyBar(frame,spellname,duration,ctype)	                
              return 
         end 
     end 
--     Debug("frame.targetname:"..frame.targetname)
end

function SpellTimer_EnemyBar_Toggle(num)
     if (num and not EnemyBar_Disbale) then        
     	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")	 
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS")	
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")	 	 
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")	
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
	 SpellTimer_EnemyMain:RegisterEvent("PLAYER_REGEN_ENABLED")
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")	 
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")	 				
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA")
	 SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
	 if (EnemyConfig.EnableF) then
	      SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE")
	      SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS")
	      SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE")
	      SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF")
	      SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE")
	      SpellTimer_EnemyMain:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE")
	 end
	 EnemyBar_Disbale = 1
     elseif (not num and EnemyBar_Disbale) then
         SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF")	 
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS")	
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")	 	 
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")	 
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
	 SpellTimer_EnemyMain:UnregisterEvent("PLAYER_REGEN_ENABLED")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE")	 
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE")				
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_BREAK_AURA")
	 SpellTimer_EnemyMain:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")		
	 EnemyBar_Disbale = nil
     end
end

function Enemy_Getduration(spellname)
     local duration
     if (SpellTimer_Enemy_Spells[spellname]) then
    	 duration = SpellTimer_Enemy_Spells[spellname].t
	 return duration 
     else
         return 0
     end
end

function Performs_Show(mob, spell)    
     if (UnitExists("target") and not UnitIsCorpse("target") and not UnitIsDeadOrGhost("target")) then     
         if (SpellTimer_Enemy_Spells[spell] and mob == UnitName("target") and Isthis_PEnable(spell) and EnemyConfig.EnableP) then
	      local duration = Enemy_Getduration(spell)
	      local targetlevel = UnitLevel("target")
	      SpellTimer_EnemyBar_Show(mob, targetlevel, spell, duration, "performs") 
	 end	 
     else
         if (SpellTimer_Enemy_Spells[spell] and Isthis_PEnable(spell) and EnemyConfig.EnableP and not EnemyConfig.EnableO) then        
	      local duration = Enemy_Getduration(spell)	 
              SpellTimer_EnemyBar_Show(mob, nil, spell, duration, "performs") 
         end
     end
end

function Gains_Show(mob, spell)
     local duration ,targetlevel
     if (SpellTimer_Enemy_Spells[spell] and mob == UnitName("target") and Isthis_GEnable(spell) and EnemyConfig.EnableG) then
         duration = Enemy_Getduration(spell)
         targetlevel = UnitLevel("target")
         SpellTimer_EnemyBar_Show(mob,targetlevel,spell,duration) 
     end
end

function SpellTimer_EnemyBar_OnEvent(event) 
     local mob, spell;
     if (event == "VARIABLES_LOADED") then    
          if (not EnemyConfig) then      
              EnemyConfig = {}
	      EnemyConfig = ST_Clone(Enemy_Default_Config)
	  end	 
	  if (EnemyConfig.EnemyEnable) then
	      SpellTimer_EnemyBar_Toggle(1)	      
	  end 	
     elseif (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then
	 for spell, mob in string.gfind(arg1, ST_ENEMY_AURA_GONE_OTHER) do
                SpellTimer_EnemyBar_Remove(mob,spell,nil)		
	 end
     elseif (event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
         for mob in string.gfind(arg1, ST_ENEMY_MOB_DIES)do
         	 SpellTimer_EnemyBar_Remove(mob,nil,1)		 
         end
     elseif (event == "PLAYER_REGEN_ENABLED") then
          SpellTimer_EnemyBar_Remove(nil,nil,1)
     elseif (event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") then
         for mob, spell in string.gfind(arg1, ST_ENEMY_SPELL_AFFLICTED) do
	      if (SpellTimer_Enemy_Effcts[spell] and mob == ST_YOU) then
	           Gains_Show(mob, spell)
		   return
	      end	        
         end
     elseif (event == "CHAT_MSG_SPELL_BREAK_AURA") then
         for mob, spell in string.gfind(arg1, ST_ENEMY_SPELL_REMOVED) do
              SpellTimer_EnemyBar_Remove(mob,spell,nil)	
         end
     else
          for mob, spell in string.gfind(arg1, ST_ENEMY_SPELL_CAST) do
	      Performs_Show(mob, spell)
--	      Debug(mob.."><"..spell)
	      return
	  end
	  for mob, spell in string.gfind(arg1, ST_ENEMY_SPELL_TOTEM) do	
	      Gains_Show(mob, spell)	
--	      Debug(mob.."><"..spell)
	      return
	  end
	  for mob, spell in string.gfind(arg1, ST_ENEMY_SPELL_GAIN) do
	      Gains_Show(mob, spell)
--	      Debug(mob.."><"..spell)
	      return
	  end
	  for mob, spell in string.gfind(arg1, ST_ENEMY_SPELL_PERFORM) do
	      Performs_Show(mob, spell)
--	      Debug(mob.."><"..spell)
	      return
	  end
     end    
end
----------------------------------------------------------------------------------------
--检查是否存在和禁止了该法术
----------------------------------------------------------------------------------------
function Isthis_PEnable(spellname)
     if (not EnemyConfig.Spells.performs) then
         return 1
     elseif (not EnemyConfig.Spells.performs[spellname]) then
         return 1
     elseif (not EnemyConfig.Spells.performs[spellname].disabled) then
         return 1    
     end	
end
function Isthis_GEnable(spellname)
      if (not EnemyConfig.Spells.gains) then
      	  return 1
      elseif (not EnemyConfig.Spells.gains[spellname]) then
          return 1
      elseif (not EnemyConfig.Spells.gains[spellname].disabled) then
          return 1      
      end
end
----------------------------------------------------------------------------------------------------
--刷新版面
----------------------------------------------------------------------------------------------------
function SpellTimer_EnemyOnUpdate(elapsed)
   if (this.casting) then
        --[[
        if (not this.CheckTime) then
            this.CheckTime = 0 
        end
        if (this.CheckTime > 0.02) then
            this.CheckTime = 0 
	else 
	    this.CheckTime = this.CheckTime + elapsed 
            return 
        end
	--]]
        local Text = getglobal(this:GetName().."Text")
        local status = GetTime()
        if ( status > this.max ) then
            status = this.max 
        end
        local spelltime = this.max - status
        local bar = getglobal(this:GetName().."Bar")
        local spark = getglobal(bar:GetName().."Spark")
        local flash = getglobal(bar:GetName().."Flash")
	bar:SetValue(status) 
	flash:Hide()
        local SparkPostion 
	SparkPostion = ((status - this.now) / (this.max - this.now)) * 174
        if ( SparkPostion < 0 ) then
            SparkPostion = 0 
        end 
	spark:SetPoint("CENTER", bar, "LEFT", SparkPostion, 0) 
        ShowSpellFrameTime(Text, this.spell.." - "..SpellTimer_Format(spelltime), spelltime, 1) 
        if (status == this.max) then           
	    SpellTimer_EnemyBar_Hide(this)
        end     
    elseif (this.flash) then
        local bar = getglobal(this:GetName().."Bar")
        local flash = getglobal(bar:GetName().."Flash")
        local alpha = flash:GetAlpha() + 0.2
        if ( alpha < 1 ) then
            flash:SetAlpha(alpha) 
        else 
	    flash:SetAlpha(1.0) 
	    this.flash = nil 
        end          
    elseif (this.fadeOut) then
        local alpha = this:GetAlpha() - 0.05
        local bar = getglobal(this:GetName().."Bar")
        local min, max = bar:GetMinMaxValues()
        if (bar:GetValue() ~= max) then
            this:SetAlpha(1.0) 
	    this.fadeOut = nil 
        end
        if ( alpha > 0 ) then
            this:SetAlpha(alpha) 
	else 
	    this.fadeOut = nil 
	    this:Hide() 
        end 
    end    
end
----------------------------------------------------------------------------------------------------
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>以下为配置<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<--
----------------------------------------------------------------------------------------------------
function SpellTimer_EnemyOptionToggle(enable)
     if (enable) then
         local i
         for i = 1, 9, 1 do
             local frame = getglobal("SpellTimer_EnemyOptionFrameSpellOption"..i) 
	     Enemy_Checkboxtoggle(frame, 1) 
         end 
         SpellTimer_EnemyScrollFrameScrollBarScrollUpButton:Enable() 
         SpellTimer_EnemyScrollFrameScrollBarScrollDownButton:Enable() 
	 EnemyConfig.EnemyEnable = 1   
--         if (EnemyConfig.EnableP) then
             MobElement_Enable(ST_EnemyOptionShowPerforms) 
--	 else 
--	     MobElement_Disable(ST_EnemyOptionShowPerforms) 
--         end                               
--         if (EnemyConfig.EnableG) then
             MobElement_Enable(ST_EnemyOptionShowGains) 
--	 else 
--	     MobElement_Disable(ST_EnemyOptionShowGains) 
--         end                            
--         if (EnemyConfig.EnableF) then
             MobElement_Enable(ST_EnemyOptionShowFriends) 
--	 else 
--	     MobElement_Disable(ST_EnemyOptionShowFriends) 
--         end  
--	 if (EnemyConfig.EnableO) then
             MobElement_Enable(ST_EnemyOptionShowTargetOnly) 
--	 else 
--	     MobElement_Disable(ST_EnemyOptionShowTargetOnly) 
--       end
     else
         local i 
	 for i = 1, 9, 1 do
             local frame = getglobal("SpellTimer_EnemyOptionFrameSpellOption"..i) 
	     Enemy_Checkboxtoggle(frame, nil) 
         end 
	 SpellTimer_EnemyScrollFrameScrollBarScrollUpButton:Disable() 
	 SpellTimer_EnemyScrollFrameScrollBarScrollDownButton:Disable() 
	 EnemyConfig.EnemyEnable = nil 
	 MobElement_Disable(ST_EnemyOptionShowPerforms) 
	 MobElement_Disable(ST_EnemyOptionShowGains) 
         MobElement_Disable(ST_EnemyOptionShowFriends) 
	 MobElement_Disable(ST_EnemyOptionShowTargetOnly) 
     end 
end 

function Enemy_Checkboxtoggle(frame, enable)
     if (enable == 1) then
     	MobElement_Enable(getglobal(frame:GetName().."Checkbox"))
     else
        MobElement_Disable(getglobal(frame:GetName().."Checkbox"))
     end
end
--------------------------------------------------------------------------------------------
--开启/关闭插件
--------------------------------------------------------------------------------------------
function SpllTimer_EnemyMain_Toggle()
     if (this:GetChecked() == 1) then
     	 SpellTimer_EnemyOptionToggle(1)
         SpellTimer_EnemyBar_Toggle(1)
     else
         SpellTimer_EnemyOptionToggle(nil)
         SpellTimer_EnemyBar_Toggle(nil)
     end	
end
function SpellTimer_EnemyOptionEnable_OnShow() 
     getglobal(this:GetName().."Text"):SetText(ENABLE_SPELL_TIMER_ENEMY)
     if (EnemyConfig.EnemyEnable) then
         this:SetChecked(1) 
	 SpellTimer_EnemyOptionToggle(1)
     else 
         this:SetChecked(0) 
	 SpellTimer_EnemyOptionToggle(nil)
     end 
end 

---------------------------------------------------------------------------------------------
--把SpellTimer_Enemy_Spells的信息传到EnemyBar_Spells,分为2类
---------------------------------------------------------------------------------------------
function Init_EnemyBar_Spells()
    if (not EnemyBar_Spells) then
         EnemyBar_Spells = {}
         if (not EnemyBar_Spells["performs"] and not EnemyBar_Spells["gains"]) then
         	EnemyBar_Spells["performs"] = {}
                EnemyBar_Spells["gains"] = {}
         end    
         local spellname
         for spellname, info in SpellTimer_Enemy_Spells do
    	      if (info.c == "performs") then
    	           table.insert(EnemyBar_Spells["performs"], spellname)
	      elseif (info.c == "gains") then
	           table.insert(EnemyBar_Spells["gains"], spellname)
    	      end
         end
    end
end

function Get_EnemySpells_Number()
     local performsnumber, gainsnumber
     Init_EnemyBar_Spells()
     performsnumber = table.getn(EnemyBar_Spells["performs"])
     gainsnumber = table.getn(EnemyBar_Spells["gains"])
     return performsnumber, gainsnumber
end
-----------------------------------------------------------------------------------------
--
-----------------------------------------------------------------------------------------
function SetUp_EnemyBar_Spells(frame, spellname, enable)
     if (spellname) then
         local checkbox = getglobal(frame:GetName().."Checkbox")        
         local str = getglobal(checkbox:GetName().."Text") 
	 str:SetText(spellname)
         if (enable) then
             checkbox:SetChecked(1)	   
	 else 
	     checkbox:SetChecked(0)	     
         end
    end 
end
-----------------------------------------------------------------------------------------
--和SetUp_EnemyBar_Spells  SpellTimer_EnemyList_Update 一起理解
-----------------------------------------------------------------------------------------
function Get_Config_EnemySpells(id)     
     local Pnumber, Gnumber = Get_EnemySpells_Number()
     if (id <= Pnumber) then
         if (EnemyConfig.Spells.performs[EnemyBar_Spells.performs[id]]) then
              return EnemyBar_Spells.performs[id], not EnemyConfig.Spells.performs[EnemyBar_Spells.performs[id]].disabled
         else
	      return  EnemyBar_Spells.performs[id], 1
	 end
     else
         id = id - Pnumber
         if (EnemyConfig.Spells.gains[EnemyBar_Spells.gains[id]]) then
              return EnemyBar_Spells.gains[id], not EnemyConfig.Spells.gains[EnemyBar_Spells.gains[id]].disabled
         else
	      return EnemyBar_Spells.gains[id], 1 	     
	 end
     end     
end
----------------------------------------------------------------------------------
--点击配置的选项框<单个法术>
----------------------------------------------------------------------------------
function SpellTimer_EnemyOptionFrameCheckbox_OnClick(id)
     Init_EnemyBar_Spells()
     local Pnumber, Gnumber = Get_EnemySpells_Number()
--     Debug(Pnumber.."and"..Gnumber)
     if (this:GetChecked() == 1) then
         if (id <= Pnumber) then
	      local spellname = EnemyBar_Spells["performs"][id]
--	      Debug(spellname.."ID"..id)
              if (not EnemyConfig.Spells.performs[spellname]) then
	          EnemyConfig.Spells.performs[spellname] = {}		   	
	      end
	      EnemyConfig.Spells.performs[spellname].disabled = nil
	 else
	      local spellname = EnemyBar_Spells["gains"][id-Pnumber]
	      if (not EnemyConfig.Spells.gains[spellname]) then
		   EnemyConfig.Spells.gains[spellname] = {}
	      end
	      EnemyConfig.Spells.gains[spellname].disabled = nil 
         end	 	         
    else
          if (id <= Pnumber) then
	      local spellname = EnemyBar_Spells["performs"][id]	      
--              Debug(spellname.."ID"..id)
              if (not EnemyConfig.Spells.performs[spellname]) then
		   EnemyConfig.Spells.performs[spellname] = {}		   	
              end	    
              EnemyConfig.Spells.performs[spellname].disabled = 1
	 else
	      local spellname = EnemyBar_Spells["gains"][id-Pnumber]
              if (not EnemyConfig.Spells.gains[spellname]) then
		   EnemyConfig.Spells.gains[spellname] = {}
	      end	
	      EnemyConfig.Spells.gains[spellname].disabled = 1 
         end	
    end 
end
---------------------------------------------------------------------------------------------
--配置界面开启时初始化选项信息
---------------------------------------------------------------------------------------------
function SpellTimer_EnemyOptionFrame_OnShow() 
    SpellTimer_EnemyList_Update()
    local text = getglobal("SpellTimer_Option".."TitleText")  
    text:SetText(SPELL_TIMER_ENEMY) 
    ST_ColorPicker_OnShow()
end
---------------------------------------------------------------------------------------------
--是配置界面里最重要的函数
---------------------------------------------------------------------------------------------
function SpellTimer_EnemyList_Update()
     local Pnumber, Gnumber = Get_EnemySpells_Number()
--     Debug(Pnumber.."和"..Gnumber)
     local OffSet = FauxScrollFrame_GetOffset(SpellTimer_EnemyScrollFrame)
--     Debug("OFFSET"..OffSet)
     local number = tonumber(Pnumber+Gnumber)
     local id 
     for i = 1, 9, 1 do
         id = OffSet + i
         local str, enable = Get_Config_EnemySpells(id)
         local SpellOption = getglobal("SpellTimer_EnemyOptionFrameSpellOption"..i) 
	 SpellOption:SetID(id)
	 if (id <= Pnumber) then
	      str = str..ST_ENEMY_PERFORM
	 else
	      str = str..ST_ENEMY_GAIN
	 end
	 SetUp_EnemyBar_Spells(SpellOption, str, enable)
         if ( id > number ) then
             SpellOption:Hide() 
	 else 
	     SpellOption:Show() 
         end 
     end    
     if (EnemyConfig.EnemyEnable) then
         FauxScrollFrame_Update(SpellTimer_EnemyScrollFrame, number , 9, 20) 
     else 
         FauxScrollFrame_Update(SpellTimer_EnemyScrollFrame, 1, 9, 20) 
     end 
end 
--------------------------------------------------------------------------------------------
--debug
--------------------------------------------------------------------------------------------
--[[
function Debug(msg,r,g,b,a)
     if (not r) then r = 1.00 end
     if (not b) then b = 0.85 end
     if (not g) then g = 0.00 end
     if (not a) then a = 1.00 end
     ChatFrame1:AddMessage(msg,r,g,b,a)
end]]
--------------------------------------------------------------------------------------------
--color
--------------------------------------------------------------------------------------------
--set color
function ST_SetColor(name)
     local r,g,b = ColorPickerFrame:GetColorRGB()
     local swatch,frame
     swatch = getglobal(name.."_ColorSwatchNormalTexture")
     frame = getglobal(name)
     swatch:SetVertexColor(r,g,b)
     frame.r = r
     frame.g = g
     frame.b = b     
     E_SetColor(frame.saveName, r, g, b)
end
--cancel color
function ST_CancelColor(name, prev)
     local r,g,b = prev.r,prev.g,prev.b
     local swatch, frame
     swatch = getglobal(name.."_ColorSwatchNormalTexture")
     frame = getglobal(name)
     swatch:SetVertexColor(r, g, b)
     frame.r = r
     frame.g = g
     frame.b = b     
     E_SetColor(frame.saveName, r, g, b)
end
--open color picker frame
function ST_OpenColorPicker(button)	
     if ( not button ) then
    	 button = this
     end
     ColorPickerFrame.func = button.swatchFunc
     ColorPickerFrame:SetColorRGB(button.r, button.g, button.b)
     ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity}
     ColorPickerFrame.cancelFunc = button.cancelFunc
     ColorPickerFrame:Show()
end

function ST_ConfigColorPicker(objname)
     local frame,swatch,sRed,sGreen,sBlue,sColor	
     frame = getglobal(objname)
     swatch = getglobal(objname.."_ColorSwatchNormalTexture")
	
     sColor = ST_nGetColor(frame.saveName)
     sRed = sColor.r
     sGreen = sColor.g
     sBlue = sColor.b

     frame.r = sRed
     frame.g = sGreen
     frame.b = sBlue	
     frame.swatchFunc = function(x) ST_SetColor(frame:GetName()) end
     frame.cancelFunc = function(x) ST_CancelColor(frame:GetName(),x) end
     swatch:SetVertexColor(sRed,sGreen,sBlue)
end

function ST_nGetColor(key)
     local color = {r = 1.0, g = 1.0, b = 1.0};	
     if (EnemyConfig and EnemyConfig["Color"][key]) then
	 color.r = EnemyConfig["Color"][key].r
	 color.g = EnemyConfig["Color"][key].g
	 color.b = EnemyConfig["Color"][key].b		
     else
	 if Enemy_Default_Config["Color"][key] then
	      color.r = Enemy_Default_Config["Color"][key].r
	      color.g = Enemy_Default_Config["Color"][key].g
	      color.b = Enemy_Default_Config["Color"][key].b
	 end		
     end
     return color
end

function E_SetColor(key, r, g, b)
     if (EnemyConfig and EnemyConfig["Color"][key]) then
	 EnemyConfig["Color"][key].r = r
	 EnemyConfig["Color"][key].g = g
	 EnemyConfig["Color"][key].b = b
     else
	 local color = {r = 1.0, g = 1.0, b = 1.0}
	 color.r = Enemy_Default_Config["Color"][key].r
	 color.g = Enemy_Default_Config["Color"][key].g
	 color.b = Enemy_Default_Config["Color"][key].b
	 EnemyConfig["Color"][key] = color
     end
end

function ST_ColorPicker_OnShow()
     ST_ConfigColorPicker("ST_PerformColorFrame")
     ST_ConfigColorPicker("ST_GainColorFrame")
end