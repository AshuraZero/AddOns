MINING_NODE_LEVEL = {
    	["铜矿"] = 1,
    	["锡矿"] = 65,
    	["火岩矿脉"] = 65,
    	["银矿"] = 75,
    	["铁矿石"] = 125,
    	["精铁矿脉"] = 150,
    	["次级血石矿脉"] = 155,
    	["金矿石"] = 155,
    	["秘银矿脉"] = 175,
    	["真银矿石"] = 230,
	    ["瑟银矿脉"] = 245,
    	["富瑟银矿"] = 275,
    	["软泥覆盖的富瑟银矿脉"] = 275,
    	["哈卡莱瑟银矿脉"] = 250,
    	["黑铁矿脉"] = 230,
    	["小黑曜石块"] = 305,
    	["大黑曜石块"] = 305
    }

HERBALISM_NODE_LEVEL = {
		["宁神花"] = 1,
		["银叶草"] = 1,
		["地根草"] = 15,
		["魔皇草"] = 50,
		["石南草"] = 70,
		["荆棘藻"] = 85,
		["跌打草"] = 100,
		["野钢花"] = 115,
		["墓地苔"] = 120,
		["皇血草"] = 125,
		["活根草"] = 150,
		["枯叶草"] = 160,
		["金棘草"] = 170,
		["卡德加的胡须"] = 185,
		["冬刺草"] = 195,
		["火焰花"] = 205,
		["紫莲花"] = 210,
		["阿尔萨斯之泪"] = 220,
		["太阳草"] = 230,
		["盲目草"] = 235,
		["幽灵菇"] = 245,
		["格罗姆之血"] = 250,
		["黄金参"] = 260,
		["梦叶草"] = 270,
		["山鼠草"] = 280,
		["瘟疫花"] = 285,
		["冰盖草"] = 290,
		["黑莲花"] = 300
	}

function ProfessionLevel_OnShow()
    local parentFrame = this:GetParent();
    local parentFrameName = parentFrame:GetName();
    local itemName = getglobal(parentFrameName.."TextLeft1"):GetText();
    
    if(MINING_NODE_LEVEL[itemName]) then
    	ProfessionLevel_AddMiningInfo(parentFrame, itemName);
    end
    
    if(HERBALISM_NODE_LEVEL[itemName]) then
    	ProfessionLevel_AddHerbalismInfo(parentFrame, itemName);
    end
    
    if(ProfessionLevel_IsSkinnable()) then
    	ProfessionLevel_AddSkinningInfo(parentFrame, itemName);
	end
end

function ProfessionLevel_GetProfessionLevel(skill)
    local numskills = GetNumSkillLines();
    for c = 1, numskills do
        local skillname, _, _, skillrank = GetSkillLineInfo(c);
        if(skillname == skill) then
            return skillrank;
        end     
    end
    return 0;
end

function ProfessionLevel_AddMiningInfo(frame, itemname)
    if(MINING_NODE_LEVEL[itemname]) then
        local levelreq = MINING_NODE_LEVEL[itemname];
        local MiningLevel = ProfessionLevel_GetProfessionLevel("Mining");
        if(levelreq <= MiningLevel) then
            -- High enough
            frame:AddLine("需要采矿("..levelreq..").",0,1,0); 
        else
            -- Not high enough
            frame:AddLine("需要采矿("..levelreq..").",1,0,0);
        end
        frame:SetHeight(frame:GetHeight() + 14);
        frame:SetWidth(190);
    end
end    

function ProfessionLevel_AddHerbalismInfo(frame, itemname)
    if(HERBALISM_NODE_LEVEL[itemname]) then
        local levelreq = HERBALISM_NODE_LEVEL[itemname];
        local HerbalismLevel = ProfessionLevel_GetProfessionLevel("Herbalism");
        if(levelreq <= HerbalismLevel) then
            -- High enough
            frame:AddLine("需要草药学("..levelreq..").",0,1,0);
        else
            -- Not high enough
            frame:AddLine("需要草药学("..levelreq..").",1,0,0);
        end
        frame:SetHeight(frame:GetHeight() + 14);
        frame:SetWidth(190);
    end
end

function ProfessionLevel_AddSkinningInfo(frame, itemname)
    local levelreq = 5 * UnitLevel("Mouseover");
    if(levelreq < 100) then levelreq = 1; end
    if(levelreq > 0) then
    	local SkinningLevel= ProfessionLevel_GetProfessionLevel("Skinning");
    	if(levelreq <= SkinningLevel) then
            -- High enough
        	frame:AddLine("需要剥皮("..levelreq..").",0,1,0);
    	else
            -- Not high enough
        	frame:AddLine("需要剥皮("..levelreq..").",1,0,0);
    	end
    	frame:SetHeight(frame:GetHeight() + 14);
    	frame:SetWidth(190);
   end 	
end

function ProfessionLevel_IsSkinnable()
    for c = 1, GameTooltip:NumLines() do
        local line = getglobal("GameTooltipTextLeft"..c);
        if(line and line:GetText() == "Skinnable") then return true; end
    end
    return false;
end

