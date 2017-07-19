--
--	Create by iWOW (The Argent Dawn)
--

local iWOWQuery_QuestData = nil;
local SortedTable = nil;
local sizeSortedTable = nil;
local orgQuestHistory_Detail_Update;
local orgQuestHistory_SortComparison;
local iWOWQuery_Inited = false;

function iWOWQuery_OnLoad()
	orgQuestHistory_Detail_Update = QuestHistory_Detail_Update;
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	Sea.util.hook("QuestHistory_BuildSortedTable","iWOWQuery_QH_BuildSortedTable","replace");
--	Sea.util.hook("QuestHistory_SortComparison","iWOWQuery_QH_SortComparison","replace");
	orgQuestHistory_SortComparison = QuestHistory_SortComparison;
	QuestHistory_SortComparison = iWOWQuery_QH_SortComparison;
	Sea.util.hook("QuestHistory_Update","iWOWQuery_QH_Update","replace");
	Sea.util.hook("QuestHistoryListFrame_OnClick","iWOWQuery_QH_ListFrame_OnClick","replace");--button="LeftButton"继续，否则不动作
	Sea.util.hook("QuestHistoryListFrame_OnEnter","iWOWQuery_QH_ListFrame_OnEnter","replace");
	Sea.util.hook("QuestHistory_Detail_Update","iWOWQuery_QH_Detail_Update","replace");
	Sea.util.hook("QuestLog_UpdateQuestDetails","iWOWQuery_QL_Detail_Update","after");
	Sea.util.hook("QuestLog_Update","iWOWQuery_QL_Update","after");
	QuestHistoryFrameTitleText:SetText(IWOWQUERY_QH_TITLE);
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ffff为了联盟，勇敢的前进吧，朋友!");

end

function iWOWQuery_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
		if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
			iWOWQueryMN_ZoneNames = MapNotes_ZoneNames;
			iWOWQueryMN_Data = MapNotes_Data;
			iWOWQueryMN_MinDiff = MapNotes_MinDiff;
			iWOWQueryMN_NotesPerZone = MapNotes_NotesPerZone;
			iWOWQueryMN_ZoneShift = MapNotes_ZoneShift;
			iWOWQueryMN_DeleteNote = MapNotes_DeleteNote;
		elseif (MetaMapNotes_Options) then
			iWOWQueryMN_ZoneNames = MetaMap_ZoneNames;
			iWOWQueryMN_Data = MetaMapNotes_Data;
			iWOWQueryMN_MinDiff = MetaMapNotes_MinDiff;
			iWOWQueryMN_NotesPerZone = MetaMapNotes_NotesPerZone;
			iWOWQueryMN_ZoneShift = MetaMapNotes_ZoneShift;
			iWOWQueryMN_DeleteNote = MetaMapNotes_DeleteNote;
		end
		
		if ( iWOWQueryMN_Data and iWOWQueryMN_ZoneNames ) then
			iWOWQueryWorldMapDeleteButton:Show();
		end
	elseif (event == "UNIT_NAME_UPDATE" and arg1 == "player") or (event == "PLAYER_ENTERING_WORLD") then
		local playerName = UnitName("player");
		if ( not iWOWQuery_Inited and playerName ~= UKNOWNBEING and playerName ~= UNKNOWNOBJECT) then
			local pf=1,qf;
			if (UnitFactionGroup("player")=="Horde") then
				pf=2;
			end
			local index=1;
			while BaseQuestDB[index] do
				_,_,qf = string.find(BaseQuestDB[index].q,"[^`]*`[^`]*`%d*`%d*`(%d*)`.*");
				qf = tonumber(qf);
				if (qf==pf) then
					table.remove(BaseQuestDB,index);
				else
					index = index + 1;
				end
			end
			iWOWQuery_Inited = true;
		end
		if iWOWQuery_Inited then
			this:UnregisterEvent("UNIT_NAME_UPDATE");
		end
	end
end

local function iWOWQuery_DoNothing()
end

local function iWOWQuery_GetQuestByIndex(index)
	local questData = nil;

	if ( not index ) then
		index = 1;
	end

	local _,_,qc,qt,qla,ql,qf,qo = string.find(BaseQuestDB[index].q,"([^`]*)`([^`]*)`(%d*)`(%d*)`(%d*)`(.*)");
	qla = tonumber(qla);
	ql = tonumber(ql);
	qf = tonumber(qf);
	questData = {};
	questData.c = qc;
	questData.t = qt;
	questData.la = qla;
	questData.l = ql;
	questData.o = qo;
	if (BaseQuestDB[index].pa) then
		_,_,questData.g,questData.az,questData.pas = string.find(BaseQuestDB[index].pa,"([^`]*)`([^`]*)`(.*)");
		questData.pa = {};
		for x,y in string.gfind(questData.pas,"(%d+),(%d+)") do
			x,y = tonumber(x),tonumber(y);
			local haspos=false;
			local insertpos=table.getn(questData.pa)+1;
			for k,v in questData.pa do
				if (v.x==x and v.y==y) then
					haspos = true;
					break;
				elseif (v.x>x or (v.x==x and v.y>y)) then
					insertpos = k;
					break;
				end
			end
			if (not haspos) then
				table.insert(questData.pa,insertpos,{x=x,y=y});
			end
		end
		questData.pas = nil;
	end
	
	if (BaseQuestDB[index].pc) then
		_,_,questData.w,questData.cz,questData.pcs = string.find(BaseQuestDB[index].pc,"([^`]*)`([^`]*)`(.*)");
		questData.pc = {};
		for x,y in string.gfind(questData.pcs,"(%d+),(%d+)") do
			x,y = tonumber(x),tonumber(y);
			local haspos=false;
			local insertpos=table.getn(questData.pc)+1;
			for k,v in questData.pc do
				if (v.x==x and v.y==y) then
					haspos = true;
					break;
				elseif (v.x>x or (v.x==x and v.y>y)) then
					insertpos = k;
					break;
				end
			end
			if (not haspos) then
				table.insert(questData.pc,insertpos,{x=x,y=y});
			end
		end
		questData.pcs = nil;
	end
	
	if BaseQuestDB[index].os then
		questData.os = {};
		for j,o in BaseQuestDB[index].os do
			local osd = {};
			osd.t = o.t;
			if (o.n) then
				osd.npc = {};
				for npccode in string.gfind(o.n,"(%d+)") do
					npccode = tonumber(npccode);
					if (BaseNpcDB[npccode]) then
						local _,_,n,c,ll,lm = string.find(BaseNpcDB[npccode].n,"([^`]*)`([^`]*)`(%d*)`(%d*)");
						ll,lm = tonumber(ll),tonumber(lm);
						for xi in BaseNpcDB[npccode].x do
							local _,_,a,pos = string.find(BaseNpcDB[npccode].x[xi],"([^`]*)`(.*)");
							if (not osd.npc[a]) then
								osd.npc[a] = {};
							end
							local npcindex=nil;
							for k,v in osd.npc[a] do
								if (v.n==n and v.c==c) then
									npcindex=k;
									break;
								end
							end
							if (not npcindex) then
								table.insert(osd.npc[a],{n=n,c=c});
								npcindex = table.getn(osd.npc[a]);
							else
								npcindex = nil;
							end
							if (npcindex) then
								osd.npc[a][npcindex].ll = ll;
								osd.npc[a][npcindex].lm = lm;
								if (not osd.npc[a][npcindex].pos) then
									osd.npc[a][npcindex].pos = {};
								end
								for x,y in string.gfind(pos,"(%d+),(%d+)") do
									x,y = tonumber(x),tonumber(y);
									table.insert(osd.npc[a][npcindex].pos,{x=x,y=y});
								end
							end
						end
					end
				end
				for area,npclist in osd.npc do
					table.sort(osd.npc[area],function(n1,n2) return (n1.ll or -1)<(n2.ll or -1) or (n1.ll==n2.ll and (n1.lm or -1)<(n2.lm or -1)); end);
				end
			end
			table.insert(questData.os,osd);
		end
	end
	return questData;
end

local function iWOWQuery_GetQuest(title,level,objective)
	if ( not title ) then
		title = "";
	end
	if ( not level ) then
		level = "";
	else
		level = tonumber(level);
	end
	if ( not objective ) then
		objective = "";
	end
	
	for i,q in BaseQuestDB do
		local _,_,qt,ql,qo = string.find(q.q,"[^`]*`([^`]*)`%d*`(%d*)`%d*`(.*)");
		ql = tonumber(ql);
		if (qt==title and ql==level and qo==objective) then
			return iWOWQuery_GetQuestByIndex(i);
		end
	end
	return nil;
end

-- Converts the zone into the continent/zone numbers used by MapNotes
local function iWOWQuery_MapNotes_GetZone(zone)
	for i = 1, 2, 1 do
		for j, value in iWOWQueryMN_ZoneNames[i] do
			if ( value == zone ) then
				return i, j;
			end
		end
	end
	return 0, 0;
end

local function iWOWQuery_Make_MapNote(zonename,title,tcolor,info1,i1color,info2,i2color,icon,x,y)
	local rl =  0;
	if ( iWOWQueryMN_Data and iWOWQueryMN_ZoneNames ) then
		local old_WorldMapButton_OnUpdate;
		if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
			old_WorldMapButton_OnUpdate = MapNotes_WorldMapButton_OnUpdate;
			MapNotes_WorldMapButton_OnUpdate = iWOWQuery_DoNothing;
		elseif (MetaMapNotes_Options) then
			old_WorldMapButton_OnUpdate = MetaMapNotes_WorldMapButton_OnUpdate;
			MetaMapNotes_WorldMapButton_OnUpdate = iWOWQuery_DoNothing;
		end

		local continent, zone = iWOWQuery_MapNotes_GetZone(zonename);
		local xpos,ypos=(x+0)/100,(y+0)/100;
		local c, hasnear = 1, false;
		for l, value in iWOWQueryMN_Data[continent][zone] do
			if (abs(value.xPos - xpos) <= 0.0009765625 * iWOWQueryMN_MinDiff and abs(value.yPos - ypos) <= 0.0013020833 * iWOWQueryMN_MinDiff) then
				hasnear=true;
				break;
			end
			c = l+1;
		end
		if ( not hasnear and c < iWOWQueryMN_NotesPerZone) then
			iWOWQueryMN_Data[continent][zone][c] = {};
			iWOWQueryMN_Data[continent][zone][c].name = title;
			iWOWQueryMN_Data[continent][zone][c].ncol = tcolor;
			iWOWQueryMN_Data[continent][zone][c].inf1 = info1;
			iWOWQueryMN_Data[continent][zone][c].in1c = i1color;
			iWOWQueryMN_Data[continent][zone][c].inf2 = info2;
			iWOWQueryMN_Data[continent][zone][c].in2c = i2color;
			iWOWQueryMN_Data[continent][zone][c].creator = "iWOW";
			iWOWQueryMN_Data[continent][zone][c].icon = icon;
			iWOWQueryMN_Data[continent][zone][c].xPos = xpos;
			iWOWQueryMN_Data[continent][zone][c].yPos = ypos;
		elseif (hasnear) then
			rl = 1;
		else
			rl = 2;
		end

		if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
			MapNotes_WorldMapButton_OnUpdate = old_WorldMapButton_OnUpdate;
		elseif (MetaMapNotes_Options) then
			MetaMapNotes_WorldMapButton_OnUpdate = old_WorldMapButton_OnUpdate;
		end
		old_WorldMapButton_OnUpdate = nil;
	end
	return rl;
end

local function iWOWQuery_DeleteMapNotes(continent,zone)
	if ( iWOWQueryMN_Data and iWOWQueryMN_ZoneNames and iWOWQueryMN_Data[continent] and iWOWQueryMN_Data[continent][zone]) then
		local i = 1;

		local old_WorldMapButton_OnUpdate;
		if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
			old_WorldMapButton_OnUpdate = MapNotes_WorldMapButton_OnUpdate;
			MapNotes_WorldMapButton_OnUpdate = iWOWQuery_DoNothing;
		elseif (MetaMapNotes_Options) then
			old_WorldMapButton_OnUpdate = MetaMapNotes_WorldMapButton_OnUpdate;
			MetaMapNotes_WorldMapButton_OnUpdate = iWOWQuery_DoNothing;
		end
		local old_SetMapZoom = SetMapZoom;
		SetMapZoom = iWOWQuery_DoNothing;
		
		local orgCont,orgZone = GetCurrentMapContinent(),GetCurrentMapZone();
		old_SetMapZoom(continent, zone);

		while (iWOWQueryMN_Data[continent][zone][i]) do
			if (iWOWQueryMN_Data[continent][zone][i].creator=="iWOW") then
				iWOWQueryMN_DeleteNote(i);
			else
				i = i + 1;
			end
		end
		old_SetMapZoom(orgCont, orgZone);
		SetMapZoom = old_SetMapZoom;
		if (MapNotes_Options) then -- Set to either MapNotes or MetaMapNotes
			MapNotes_WorldMapButton_OnUpdate = old_WorldMapButton_OnUpdate;
		elseif (MetaMapNotes_Options) then
			MetaMapNotes_WorldMapButton_OnUpdate = old_WorldMapButton_OnUpdate;
			MetaMapNotes_MapUpdate();
		end
		old_WorldMapButton_OnUpdate = nil;
	end
end

function iWOWQuery_QL_Update()
	iWOWQueryQLNPCFrame:Hide();
	QuestLogFrameAbandonButton:Show();
	QuestFramePushQuestButton:Show();
end

function iWOWQuery_QL_Detail_Update()
	iWOWQueryQLNPCFrame:Hide();
	QuestLogDetailScrollFrame:Show();
	QuestLogFrameAbandonButton:Show();
	QuestFramePushQuestButton:Show();

	local questID = GetQuestLogSelection();
	local questTitle,level = GetQuestLogTitle(questID);
	local _, questObjectives = GetQuestLogQuestText();
	
	iWOWQuery_QuestData = iWOWQuery_GetQuest(questTitle,level,questObjectives);
	if (iWOWQuery_QuestData and (iWOWQuery_QuestData.az or iWOWQuery_QuestData.cz)) 
	then
		iWOWQueryQLACQueryButton:Show();
	else
		iWOWQueryQLACQueryButton:Hide();
	end
	
	local i;
	for i = 1, 10 do
		local button = getglobal("iWOWQueryQLObjectButton"..i);
		local qlstring = getglobal("QuestLogObjective"..i);
		button:Hide();
		if (qlstring:IsVisible() and iWOWQuery_QuestData and iWOWQuery_QuestData.os) then
 			local text = qlstring:GetText();
			text = string.gsub(text,IWOWQUERY_QUESTOBJECT_FILTER1,"");
			text = string.gsub(text,IWOWQUERY_QUESTOBJECT_FILTER2,"");
 			for k,v in iWOWQuery_QuestData.os do
				local objtext = v.t;
				objtext = string.gsub(objtext,IWOWQUERY_QUESTOBJECT_FILTER1,"");
				objtext = string.gsub(objtext,IWOWQUERY_QUESTOBJECT_FILTER2,"");
 				if (objtext==text and v.npc) then
		 			button:ClearAllPoints();
					button:SetPoint("TOPLEFT","QuestLogObjective"..i,"TOPLEFT", 0, 0);
					button:SetPoint("BOTTOMRIGHT","QuestLogObjective"..i,"BOTTOMRIGHT", 0, 0);
					button:SetID(k);
					button:Show();
					break;
 				end
 			end
		end
	end
end

local function iWOWQuery_QuestNPCTree_OnClick(postable)
	if (not postable or not iWOWQuery_QuestData) then
		return;
	end

	local MapNoteError = 0;
	local text = "["..iWOWQuery_QuestData.t..IWOWQUERY_TEXT_TOOLTIP1..postable.t..IWOWQUERY_TEXT_TOOLTIP2..postable.n..IWOWQUERY_TEXT_TOOLTIP3..postable.a;
	if ( iWOWQueryMN_Data and iWOWQueryMN_ZoneNames and postable.pos and postable.pos[1] and not IsShiftKeyDown()) then
		local continent, zone = iWOWQuery_MapNotes_GetZone(postable.a);
		iWOWQuery_DeleteMapNotes(continent, zone);
	end
	for k,pos in postable.pos do
		text = text.." <"..pos.x..","..pos.y..">";
		if (not (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) and MapNoteError<2) then
			MapNoteError = iWOWQuery_Make_MapNote(postable.a,postable.n,0,IWOWQUERY_TEXT_TOOLTIP4..iWOWQuery_QuestData.t,4,postable.t,8,1,pos.x,pos.y);
			if (MapNoteError==2) then
				Sea.io.print(IWOWQUERY_TEXT_TOOLTIP5..postable.a..IWOWQUERY_TEXT_TOOLTIP6);
			end
		end
	end
	if ( IsShiftKeyDown() ) then
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(text);
		end
	elseif ( iWOWQueryMN_Data and iWOWQueryMN_ZoneNames and postable.pos and postable.pos[1]) then
		local continent, zone = iWOWQuery_MapNotes_GetZone(postable.a);
		ToggleWorldMap();
		SetMapZoom(continent, zone);
	end
end

local function iWOWQuery_GenEarthTreeTable(id)
	if (iWOWQuery_QuestData and iWOWQuery_QuestData.os and iWOWQuery_QuestData.os[id] and iWOWQuery_QuestData.os[id].npc) then
		local eTree={};
		local objtext = iWOWQuery_QuestData.os[id].t;
		objtext = string.gsub(objtext,IWOWQUERY_QUESTOBJECT_FILTER1,"");
		objtext = string.gsub(objtext,IWOWQUERY_QUESTOBJECT_FILTER2,"");
		for z,zn in iWOWQuery_QuestData.os[id].npc do
			local areaentry={};
			areaentry.title = z;
			areaentry.children = {};
			for i,nd in zn do
				local npcentry = {};
				npcentry.title = nd.n;
				npcentry.titleColor={r=1,g=1,b=0};
				npcentry.right = "";
				if (nd.c) then
					npcentry.right = npcentry.right..nd.c;
				end
				if (nd.ll and nd.lm) then
					if (nd.ll==nd.lm) then
						npcentry.right = npcentry.right.." lv "..nd.ll;
					else
						npcentry.right = npcentry.right.." lv "..nd.ll.."-"..nd.lm;
					end
					npcentry.rightColor=GetDifficultyColor(nd.ll);
				else
					npcentry.right = npcentry.right.." "..UNIT_LETHAL_LEVEL_TEMPLATE;
				end
				npcentry.onClick = iWOWQuery_QuestNPCTree_OnClick;
				local tltip=IWOWQUERY_TEXT_TOOLTIP7..objtext.."|r\n|cFFFF0000"..nd.n.."|r\n"..z.."\n";
				local poscount = 0;
				for k,v in nd.pos do
					if (poscount==5) then
						poscount = 0;
						tltip = tltip.."\n";
					end
					tltip = tltip.." <"..v.x..","..v.y..">";
					poscount = poscount+1;
				end
				npcentry.tooltip = tltip;
				npcentry.value = {t=objtext,a=z,n=nd.n,pos=nd.pos};
				table.insert(areaentry.children,npcentry);
			end
			table.insert(eTree,areaentry);
		end
		return eTree;
	end
	return nil;
end

function iWOWQuery_QHObjectButton_OnClick(button,id)
	if (iWOWQuery_QuestData and iWOWQuery_QuestData.os and iWOWQuery_QuestData.os[id] and iWOWQuery_QuestData.os[id].npc) then
		local ETree = iWOWQuery_GenEarthTreeTable(id);
		if (ETree) then
			QuestHistoryDetailScrollFrame:Hide();
			QuestHistoryDetailPreviousButton:Hide();
			QuestHistoryDetailFrameNextButton:Hide();
			EarthTree_LoadEnhanced(iWOWQueryQHNPCTree,ETree);
			EarthTree_UpdateFrame(iWOWQueryQHNPCTree); 
			iWOWQueryQHNPCFrame:Show();
		end
	end
end

function iWOWQuery_QLObjectButton_OnClick(button,id)
	if (iWOWQuery_QuestData and iWOWQuery_QuestData.os and iWOWQuery_QuestData.os[id] and iWOWQuery_QuestData.os[id].npc) then
		local ETree = iWOWQuery_GenEarthTreeTable(id);
		if (ETree) then
			QuestLogDetailScrollFrame:Hide();
			QuestLogFrameAbandonButton:Hide();
			QuestFramePushQuestButton:Hide();
			EarthTree_LoadEnhanced(iWOWQueryQLNPCTree,ETree);
			EarthTree_UpdateFrame(iWOWQueryQLNPCTree); 
			iWOWQueryQLNPCFrame:Show();
		end
	end
end

function iWOWQuery_WorldMapDeleteButton_OnClick()
	local zone = iWOWQueryMN_ZoneShift[GetCurrentMapContinent()][GetCurrentMapZone()];
	local continent = GetCurrentMapContinent();
	iWOWQuery_DeleteMapNotes(continent,zone);
end

function iWOWQuery_QH_SendToMapNotes(button, locationType)
	if (iWOWQuery_QuestData) then
		local title;
		local info1,info2 = "","";
		local icon;
		local p;
		local zone;
		if ( locationType == "a" ) then
			title = iWOWQuery_QuestData.t;
			info1 = IWOWQUERY_TEXT_ACCEPTQUEST;
			info2 = iWOWQuery_QuestData.g;
			p = iWOWQuery_QuestData.pa;
			zone = iWOWQuery_QuestData.az;
			icon = 2;
		else
			title = iWOWQuery_QuestData.t;
			info1 = IWOWQUERY_TEXT_COMPLETEQUEST;
			info2 = iWOWQuery_QuestData.w;
			p = iWOWQuery_QuestData.pc;
			zone = iWOWQuery_QuestData.cz;
			icon = 3;
		end
		if ( iWOWQueryMN_Data and iWOWQueryMN_ZoneNames and p and p[1] and not IsShiftKeyDown()) then
			local continent, zone1 = iWOWQuery_MapNotes_GetZone(zone);
			iWOWQuery_DeleteMapNotes(continent, zone1);
		end
		local text = "["..title.."]"..info1..": "..info2..IWOWQUERY_TEXT_TOOLTIP3..zone;
		local MapNoteError = 0;
		for k,v in p do
			text = text.." <"..v.x..","..v.y..">";
			if (not (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) and MapNoteError<2) then
				MapNoteError = iWOWQuery_Make_MapNote(zone,title,0,info1,4,info2,8,icon,v.x,v.y);
				if (MapNoteError==2) then
					Sea.io.print(IWOWQUERY_TEXT_TOOLTIP5..zone..IWOWQUERY_TEXT_TOOLTIP6);
				end
			end
		end
		if ( IsShiftKeyDown() ) then
			if ( ChatFrameEditBox:IsVisible() ) then
				ChatFrameEditBox:Insert(text);
			end
		elseif ( iWOWQueryMN_Data and iWOWQueryMN_ZoneNames and p and p[1]) then
			local continent, zone1 = iWOWQuery_MapNotes_GetZone(zone);
			ToggleWorldMap();
			SetMapZoom(continent, zone1);
		end
	end
end

local function iWOWQuery_QuestACTree_OnClick(value)
	if (not value or not iWOWQuery_QuestData) then
		return;
	end
	iWOWQuery_QH_SendToMapNotes("LeftButton",value.l);
end

function iWOWQuery_QLACQueryButton_OnClick()
	if (iWOWQuery_QuestData and (iWOWQuery_QuestData.az or iWOWQuery_QuestData.cz)) then
		local ETree = {};
		if (iWOWQuery_QuestData.az) then
			local tltip=IWOWQUERY_TEXT_TOOLTIP8;
			if (iWOWQuery_QuestData.g) then
				tltip=tltip.."|cFF00FF00"..iWOWQuery_QuestData.g.."|r\n";
			end
			tltip=tltip..iWOWQuery_QuestData.az.."\n";
			local poscount = 0;
			for k,v in iWOWQuery_QuestData.pa do
				if (poscount==5) then
					poscount = 0;
					tltip = tltip.."\n";
				end
				tltip = tltip.." <"..v.x..","..v.y..">";
				poscount = poscount+1;
			end	
			local ctitle = iWOWQuery_QuestData.az;
			if (iWOWQuery_QuestData.pa and iWOWQuery_QuestData.pa[1]) then
				ctitle = ctitle.." ("..iWOWQuery_QuestData.pa[1].x..", "..iWOWQuery_QuestData.pa[1].y..")";
			end
			local entry = {
				title = IWOWQUERY_TEXT_ACCEPTQUESTLOCATION,
				children = {
					{
						title = ctitle,
						titleColor={r=1,g=1,b=0},
						tooltip = tltip,
						right = iWOWQuery_QuestData.g,
						rightColor={r=0,g=1,b=0},
						onClick = iWOWQuery_QuestACTree_OnClick,
						value = {l="a"},
					}
				},
			};
			table.insert(ETree,entry);
		end
		if (iWOWQuery_QuestData.cz) then
			local tltip=IWOWQUERY_TEXT_TOOLTIP9;
			if (iWOWQuery_QuestData.w) then
				tltip=tltip.."|cFF00FF00"..iWOWQuery_QuestData.w.."|r\n";
			end
			tltip=tltip..iWOWQuery_QuestData.cz.."\n";
			local poscount = 0;
			for k,v in iWOWQuery_QuestData.pc do
				if (poscount==5) then
					poscount = 0;
					tltip = tltip.."\n";
				end
				tltip = tltip.." <"..v.x..","..v.y..">";
				poscount = poscount+1;
			end
			local ctitle = iWOWQuery_QuestData.cz;
			if (iWOWQuery_QuestData.pc and iWOWQuery_QuestData.pc[1]) then
				ctitle = ctitle.." ("..iWOWQuery_QuestData.pc[1].x..", "..iWOWQuery_QuestData.pc[1].y..")";
			end
			local entry = {
				title = IWOWQUERY_TEXT_COMPLETEQUESTLOCATION,
				children = {
					{
						title = ctitle,
						titleColor={r=1,g=1,b=0},
						tooltip = tltip,
						right = iWOWQuery_QuestData.w,
						rightColor={r=0,g=1,b=0},
						onClick = iWOWQuery_QuestACTree_OnClick,
						value = {l="c"},
					}
				},
			};
			table.insert(ETree,entry);
		end
		QuestLogDetailScrollFrame:Hide();
		QuestLogFrameAbandonButton:Hide();
		QuestFramePushQuestButton:Hide();
		EarthTree_LoadEnhanced(iWOWQueryQLNPCTree,ETree);
		EarthTree_UpdateFrame(iWOWQueryQLNPCTree);
		iWOWQueryQLNPCFrame:Show();
	end
end

local function iWOWQuery_Quest_MatchesSearch(value,searchText)
	searchText = strupper(searchText);
	if (not searchText or searchText=="") then
		return true;
	end
	
	local _,_,qf = string.find(value.q,"[^`]*`[^`]*`%d*`%d*`(%d*)`.*");
	local playerfaction=UnitFactionGroup("player");
	if (playerfaction=="Horde") then
		playerfaction = "1";
	else
		playerfaction = "2";
	end
	if (qf~="3" and qf~=playerfaction) then
		return false;
	end
	if (value.q and string.find(strupper(value.q), searchText) ) then
		return true;
	end
	if (value.pa and string.find(strupper(value.pa), searchText) ) then
		return true;
	end
	if (value.pc and string.find(strupper(value.pc), searchText) ) then
		return true;
	end
	if (value.os) then
		for i,o in value.os do
			if (o.n) then
				for npccode in string.gfind(o.n,"(%d+)") do
					npccode = tonumber(npccode);
					if (BaseNpcDB[npccode]) then
						if (BaseNpcDB[npccode].n and string.find(strupper(BaseNpcDB[npccode].n),searchText)) then
							return true;
						end
						if (BaseNpcDB[npccode].x) then
							for k,v in BaseNpcDB[npccode].x do
								if (string.find(strupper(v),searchText)) then
									return true;
								end
							end
						end
					end
				end
			end
		end
	end
	return false;
end

function iWOWQuery_QH_BuildSortedTable()
	local searchText = QuestHistory_GetSearchText();
	if ( not searchText ) then
		return true;
	end

	-- Initialize blank table
	SortedTable = { };
	-- Populate table with quest IDs that match current criteria
	for index, value in BaseQuestDB do
		if ( iWOWQuery_Quest_MatchesSearch(value, searchText) ) then
			table.insert(SortedTable,index);
		end
	end
	
	local DisplayedRealmName,DisplayedPlayerCharacterName = QuestHistory_GetQuestIndexString();
	for k,index in SortedTable do
		BaseQuestDB[index].qh = nil;
		local _,_,qt,ql,qo = string.find(BaseQuestDB[index].q,"[^`]*`([^`]*)`%d*`(%d*)`%d*`(.*)");
		ql = tonumber(ql);
		for i,v in QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName] do
			if (qt==v.t and ql==v.l and qo==v.o) then
				BaseQuestDB[index].qh = i;
				break;
			end
		end
	end

	sizeSortedTable = table.getn(SortedTable);
	QuestHistory_SetSortedTable(SortedTable);
	
	return false;
end

function iWOWQuery_QH_SortComparison(index1, index2)
	if ( not QuestHistory_GetSearchText() ) then
		return orgQuestHistory_SortComparison(index1, index2);
--		return true;
	end
	local currentSortType,currentSortOrder = QuestHistory_GetCurrentSortOption();
	local DisplayedRealmName,DisplayedPlayerCharacterName = QuestHistory_GetQuestIndexString();
	
	if ( currentSortType ~= "accepted" ) then
		-- Get the sort values that are to be compared
		local sort1,sort2;
		local _,_,qc1,qt1,ql1,qo1 = string.find(BaseQuestDB[index1].q,"([^`]*)`([^`]*)`%d*`(%d*)`%d*`(.*)");
		local _,_,qc2,qt2,ql2,qo2 = string.find(BaseQuestDB[index2].q,"([^`]*)`([^`]*)`%d*`(%d*)`%d*`(.*)");
		ql1,ql2 = tonumber(ql1),tonumber(ql2);
		if (currentSortType=="t") then
			sort1 = qt1;
			sort2 = qt2;
		elseif (currentSortType=="l") then
			sort1 = ql1;
			sort2 = ql2;
		elseif (currentSortType=="c") then
			sort1 = qc1;
			sort2 = qc2;
		elseif (currentSortType=="g") then
			if (BaseQuestDB[index1].pa) then
				_,_,sort1 = string.find(BaseQuestDB[index1].pa,"([^`]*)`[^`]*`.*");
			end
			if (BaseQuestDB[index2].pa) then
				_,_,sort2 = string.find(BaseQuestDB[index2].pa,"([^`]*)`[^`]*`.*");
			end
		elseif (currentSortType=="w") then
			if (BaseQuestDB[index1].pc) then
				_,_,sort1 = string.find(BaseQuestDB[index1].pc,"([^`]*)`[^`]*`.*");
			end
			if (BaseQuestDB[index2].pc) then
				_,_,sort2 = string.find(BaseQuestDB[index2].pc,"([^`]*)`[^`]*`.*");
			end
		else
			if (BaseQuestDB[index1].qh) then
				sort1 = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index1].qh][currentSortType];
			end
			if (BaseQuestDB[index2].qh) then
				sort2 = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index2].qh][currentSortType];
			end
		end
		if ( currentSortOrder == "dec" ) then
			-- Swap sort values if sorting in decremented order
			sort1, sort2 = sort2, sort1;
		end
		-- Make sure sort1 is not nil and is compatible with sort2
		if ( sort1 == nil ) then
			if ( type(sort2) == "string" ) then
				sort1 = "";
			else
				sort1 = 0;
			end
		end
		-- Make sure sort2 is not nil and is compatible with sort1
		if ( sort2 == nil ) then
			if ( type(sort1) == "string" ) then
				sort2 = "";
			else
				sort2 = 0;
			end
		end
		-- If sorting by completed order, make sure incomplete quests are valued more than completed quests
		-- and that current quests are valued more than abandoned quests
		if ( currentSortType == "co" ) then
			if ( sort1 ~= sort2 ) then
				if ( sort1 == 0 ) then
					sort1 = sort2 + 1;
				elseif ( sort2 == 0 ) then
					sort2 = sort1 + 1;
				end
			else
				if ( BaseQuestDB[index1].qh and QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index1].qh].a ) then
					sort1 = -1;
				end
				if ( BaseQuestDB[index2].qh and QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index2].qh].a ) then
					sort2 = -1;
				end
			end
		end
		-- If sort1 is different from sort2, return comparison of sort values
		if ( sort1 ~= sort2 ) then
--			return false,sort1 < sort2;
			return sort1 < sort2;
		end
	else
		if ( currentSortOrder == "dec" ) then
			-- Swap index values if sorting in decremented order
			index1, index2 = index2, index1;
		end
	end
	-- Return comparison of index values
--	return false,index1 < index2;
	return index1 < index2;
end

function iWOWQuery_QH_Update()
	if ( not QuestHistory_GetSearchText() ) then
		return true;
	end
	-- Build sorted table if it hasn't been created yet
	if ( not SortedTable ) then
		QuestHistory_BuildSortedTable();
	end
	-- Highlight currently selected quest if it is visible in the scrollframe
	local currentTitleListID = QuestHistory_GetCurrentSortedID() - FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame);
	if ( currentTitleListID >= 1 and currentTitleListID <= 31 ) then
		QuestHistoryListHighlightFrame:SetPoint("LEFT", "QuestHistoryListFrame"..currentTitleListID, "LEFT", 0, -2);
		QuestHistoryListHighlightFrame:Show();
	else
		-- Hide the highlight frame since selected quest is not visible in the scrollframe
		QuestHistoryListHighlightFrame:Hide();
	end
	-- Format QuestHistory title appropriately depending on how many quests are logged
	QuestHistoryTitleText:SetText(IWOWQUERY_QH_QUERYRESULT1..sizeSortedTable..IWOWQUERY_QH_QUERYRESULT2);
	-- Update the scroll frame and add the quest data
	local DisplayedRealmName,DisplayedPlayerCharacterName = QuestHistory_GetQuestIndexString();
	FauxScrollFrame_Update(QuestHistoryListScrollFrame, sizeSortedTable, QUESTHISTORY_ITEMS_SHOWN, QUESTHISTORY_ITEM_HEIGHT);
	for iQuest = 1, QUESTHISTORY_ITEMS_SHOWN, 1 do
		local questIndex = iQuest + FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame);
		local listFrame = "QuestHistoryListFrame"..iQuest;
		if ( questIndex <= sizeSortedTable ) then
			local color;
			-- Get quest information
			local index = SortedTable[questIndex];
			local title;
			local level;
			local category;
			local tag;
			local completed;
			if (BaseQuestDB[index].qh and QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index].qh]) then
				title = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index].qh].t;
				level = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index].qh].l;
				category = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index].qh].c;
				tag = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index].qh].y;
				completed = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index].qh].co;
			else
				_,_,category,title,level = string.find(BaseQuestDB[index].q,"([^`]*)`([^`]*)`%d*`(%d*)`%d*`.*");
			end
			-- Check to make sure none of the data is nil
			if ( not title ) then
				title = "";
			end
			if ( not level ) then
				level = "";
			end
			if ( not category ) then
				category = "";
			end
			if ( not tag ) then
				tag = "";
			end
			-- Add quest data to frame
			getglobal(listFrame.."AcceptedText"):SetText(index);
			getglobal(listFrame.."TitleText"):SetText(title);
			getglobal(listFrame.."LevelText"):SetText(level);
			getglobal(listFrame.."CategoryText"):SetText(category);
			getglobal(listFrame.."TagText"):SetText(tag);
			if ( completed ) then
				-- If quest has been completed, show checkmark and completed number in brackets
				getglobal(listFrame.."CompletedText"):SetText("["..completed.."]");
				getglobal(listFrame.."CheckMark"):Show();
			else
				-- Otherwise, hide checkmark and display nothing for completed
				getglobal(listFrame.."CompletedText"):SetText("");
				getglobal(listFrame.."CheckMark"):Hide();
			end
			-- Set color depending on quest status
			if (completed) then
				color = QuestHistoryStatusColor["completed"];
			elseif (BaseQuestDB[index].qh and 
					 QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index].qh] and 
					 QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index].qh].a ) 
			then
				color = QuestHistoryStatusColor["abandoned"];
			elseif (BaseQuestDB[index].qh and 
					 QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index].qh] and 
					 QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][BaseQuestDB[index].qh].f ) 
			then
				color = QuestHistoryStatusColor["failed"];
			else
				if ( level == "" ) then
					level = 0;
				end
				color = GetDifficultyColor(level);
			end
			-- Apply color to text
			getglobal(listFrame.."AcceptedText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame.."TitleText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame.."LevelText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame.."CategoryText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame.."TagText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame.."CompletedText"):SetTextColor(color.r, color.g, color.b);
			getglobal(listFrame):Show();
		else
			-- Hide the list frame if there is no data for it
			getglobal(listFrame):Hide();
		end
	end
	return false;
end

function iWOWQuery_QH_ListFrame_OnClick(button)
	if ( not QuestHistory_GetSearchText() or button == "LeftButton" ) then
		return true;
	end
	
	return false;
end

function iWOWQuery_QH_ListFrame_OnEnter()
	if ( not QuestHistory_GetSearchText() ) then
		return true;
	end
	
	local index = SortedTable[this:GetID() + FauxScrollFrame_GetOffset(QuestHistoryListScrollFrame)];
	index = BaseQuestDB[index].qh;
	local note;
	local DisplayedRealmName,DisplayedPlayerCharacterName = QuestHistory_GetQuestIndexString();
	if (QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index]) then
		note = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][index].n;
	end
	if ( note ~= nil and note ~= "" ) then
		QuestHistoryTooltip:SetPoint("TOPLEFT", "QuestHistoryListFrame"..this:GetID().."CompletedText", "TOPRIGHT", 15, 0);
		QuestHistoryTooltipText:SetText(note);
		QuestHistoryTooltip:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
		QuestHistoryTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);
		QuestHistoryTooltip:Show();
	end

	return false;
end

function iWOWQuery_QH_Detail_Update(questIndex)
	iWOWQueryQHNPCFrame:Hide();
	QuestHistoryDetailScrollFrame:Show();
	QuestHistoryDetailPreviousButton:Show();
	QuestHistoryDetailFrameNextButton:Show();

	local spacerFrame = QuestHistoryDetailSpacerFrame;
	local qhIndex;
	if ( not QuestHistory_GetSearchText() ) then
		qhIndex = questIndex;
		local DisplayedRealmName,DisplayedPlayerCharacterName = QuestHistory_GetQuestIndexString();
		local questTitle = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].t;
		local level = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].l;
		local questObjectives = QuestHistory_List[DisplayedRealmName][DisplayedPlayerCharacterName][questIndex].o;
		iWOWQuery_QuestData = iWOWQuery_GetQuest(questTitle,level,questObjectives);
	else
		qhIndex = BaseQuestDB[questIndex].qh;
		iWOWQuery_QuestData = iWOWQuery_GetQuestByIndex(questIndex);
	end

	if (qhIndex) then
		QuestHistoryDetailEditButton:Show();
		orgQuestHistory_Detail_Update(qhIndex);
	else
		QuestHistoryDetailNotesScrollFrame:Hide();
		QuestHistoryDetailSaveButton:Hide();
		QuestHistoryDetailListScrollFrame:Show();
		QuestHistoryDetailEditButton:Show();
		-- Get information for frame title
		local questTitle = iWOWQuery_QuestData.t;
		local level = iWOWQuery_QuestData.l;
		-- Set variables to default values if the corresponding data is not in log
		if ( not questTitle ) then
			questTitle = "";
		end
		if ( not level ) then
			level = "";
		end
		-- Set the title of the frame to show quest title, level and tag
		QuestHistoryDetailTitle:SetText(format(TEXT(QUESTHISTORY_DETAIL_TITLE_FORMAT), questTitle, level, ""));
		QuestHistoryDetailTitle:Show();
		-- Display the level of player when quest was accepted/logged
		local levelAccepted = iWOWQuery_QuestData.la;
		QuestHistoryDetailLevelAcceptedTitle:SetText(QUESTHISTORY_LEVEL_ACCEPTED_TITLE);
		if ( levelAccepted ) then
			QuestHistoryDetailLevelAcceptedText:SetText(levelAccepted);
			QuestHistoryDetailLevelAcceptedText:Show();
		else
			QuestHistoryDetailLevelAcceptedText:Hide();
		end
		QuestHistoryDetailLevelCompletedText:Hide();
		QuestHistoryDetailMoneyRewardedText:Hide();
		QuestHistoryDetailXPRewardedText:Hide();
		QuestHistoryDetailQuestGiverText:Hide();
		QuestHistoryDetailQuestCompleterText:Hide();
		QuestHistoryDetailAcceptedLocationButton:Hide();
		QuestHistoryDetailCompletedLocationButton:Hide();
		QuestHistoryDetailTimeAcceptedTitle:SetText(QUESTHISTORY_TIME_ACCEPTED_TITLE);
		QuestHistoryDetailTimeAcceptedText:Hide();
		QuestHistoryDetailTimeCompletedText:Hide();
		QuestHistoryDetailTimesAbandonedText:Hide();
		QuestHistoryDetailTimesFailedText:Hide();
		QuestHistoryDetailListNotes:Hide();
		QuestHistoryDetailEditButton:Hide();
		QuestHistoryDetailQuestTitle:SetText(questTitle);
		-- Display the quest objective
		local questObjectives = iWOWQuery_QuestData.o;
		if ( not questObjectives ) then
			questObjectives = "";
		end
		QuestHistoryDetailObjectivesText:SetText(questObjectives);
		for i = 1, MAX_OBJECTIVES, 1 do
			getglobal("QuestHistoryDetailObjective"..i):Hide();
		end
		QuestHistoryDetailRequiredMoneyText:Hide();
		QuestHistoryDetailRequiredMoneyFrame:Hide();
		QuestHistoryDetailDescriptionTitle:SetPoint("TOPLEFT", "QuestHistoryDetailObjectivesText", "BOTTOMLEFT", 0, -10);
		QuestHistoryDetailQuestDescription:SetText("");
		QuestFrame_SetAsLastShown(QuestHistoryDetailQuestDescription, spacerFrame);
		QuestHistoryDetailRewardTitleText:Hide();
		QuestHistoryDetailMoneyFrame:Hide();
		for i = 1, MAX_NUM_ITEMS, 1 do
			getglobal("QuestHistoryDetailItem"..i):Hide();
		end
		QuestHistoryDetailItemReceiveText:Hide();
		QuestHistoryDetailItemChooseText:Hide();
	end
	
	-- Display the name of the quest giver
	if (iWOWQuery_QuestData and iWOWQuery_QuestData.g) then
		QuestHistoryDetailQuestGiverText:SetText(iWOWQuery_QuestData.g);
		QuestHistoryDetailQuestGiverText:Show();
	end
	-- Display the name of the quest completer
	if (iWOWQuery_QuestData and iWOWQuery_QuestData.w) then
		QuestHistoryDetailQuestCompleterText:SetText(iWOWQuery_QuestData.w);
		QuestHistoryDetailQuestCompleterText:Show();
	end
	-- Display the location where quest was accepted
	if (iWOWQuery_QuestData and iWOWQuery_QuestData.az) then
		QuestHistoryDetailAcceptedLocationButton:Hide();
		local text = iWOWQuery_QuestData.az;
		if (iWOWQuery_QuestData.pa and iWOWQuery_QuestData.pa[1]) then
			text = text.." ("..iWOWQuery_QuestData.pa[1].x..", "..iWOWQuery_QuestData.pa[1].y..")";
		end
		iWOWQueryQHDetailAcceptedLocationText:SetText(text);
		local tltip=IWOWQUERY_TEXT_TOOLTIP8;
		if (iWOWQuery_QuestData.g) then
			tltip=tltip.."|cFF00FF00"..iWOWQuery_QuestData.g.."|r\n";
		end
		tltip=tltip..iWOWQuery_QuestData.az.."\n";
		local poscount = 0;
		for k,v in iWOWQuery_QuestData.pa do
			if (poscount==5) then
				poscount = 0;
				tltip = tltip.."\n";
			end
			tltip = tltip.."<"..v.x..","..v.y..">";
			poscount = poscount+1;
		end
		iWOWQueryQHDetailAcceptedLocationButton.tooltip = tltip;
		iWOWQueryQHDetailAcceptedLocationButton:Show();
	else
		iWOWQueryQHDetailAcceptedLocationButton.tooltip = nil;
		iWOWQueryQHDetailAcceptedLocationButton:Hide();
	end
	-- Display the location where quest was completed
	if (iWOWQuery_QuestData and iWOWQuery_QuestData.cz) then
		QuestHistoryDetailCompletedLocationButton:Hide();
		local text = iWOWQuery_QuestData.cz;
		if (iWOWQuery_QuestData.pc and iWOWQuery_QuestData.pc[1]) then
			text = text.." ("..iWOWQuery_QuestData.pc[1].x..", "..iWOWQuery_QuestData.pc[1].y..")";
		end
		iWOWQueryQHDetailCompletedLocationText:SetText(text);
		local tltip=IWOWQUERY_TEXT_TOOLTIP9;
		if (iWOWQuery_QuestData.w) then
			tltip=tltip.."|cFF00FF00"..iWOWQuery_QuestData.w.."|r\n";
		end
		tltip=tltip..iWOWQuery_QuestData.cz.."\n";
		local poscount = 0;
		for k,v in iWOWQuery_QuestData.pc do
			if (poscount==5) then
				poscount = 0;
				tltip = tltip.."\n";
			end
			tltip = tltip.."<"..v.x..","..v.y..">";
			poscount = poscount+1;
		end
		iWOWQueryQHDetailCompletedLocationButton.tooltip = tltip;
		iWOWQueryQHDetailCompletedLocationButton:Show();
	else
		iWOWQueryQHDetailCompletedLocationButton.tooltip = nil;
		iWOWQueryQHDetailCompletedLocationButton:Hide();
	end
	
	local i;
	for i = 1, 10 do
		local button = getglobal("iWOWQueryQHObjectButton"..i);
		local qhstring = getglobal("QuestHistoryDetailObjective"..i);
		if (not qhstring:IsVisible() and iWOWQuery_QuestData and iWOWQuery_QuestData.os and iWOWQuery_QuestData.os[i] and iWOWQuery_QuestData.os[i].t) then
			qhstring:SetTextColor(0, 0, 0);
			qhstring:SetText(iWOWQuery_QuestData.os[i].t);
			qhstring:Show();
			QuestHistoryDetailDescriptionTitle:SetPoint("TOPLEFT", "QuestHistoryDetailObjective"..i, "BOTTOMLEFT", 0, -10);
		end
		button:Hide();
		if (qhstring:IsVisible() and iWOWQuery_QuestData and iWOWQuery_QuestData.os) then
 			local text = qhstring:GetText();
			text = string.gsub(text,IWOWQUERY_QUESTOBJECT_FILTER1,"");
			text = string.gsub(text,IWOWQUERY_QUESTOBJECT_FILTER2,"");
 			for k,v in iWOWQuery_QuestData.os do
				local objtext = v.t;
				objtext = string.gsub(objtext,IWOWQUERY_QUESTOBJECT_FILTER1,"");
				objtext = string.gsub(objtext,IWOWQUERY_QUESTOBJECT_FILTER2,"");
 				if (objtext==text and v.npc) then
		 			button:ClearAllPoints();
					button:SetPoint("TOPLEFT","QuestHistoryDetailObjective"..i,"TOPLEFT", 0, 0);
					button:SetPoint("BOTTOMRIGHT","QuestHistoryDetailObjective"..i,"BOTTOMRIGHT", 0, 0);
					button:SetID(k);
					button:Show();
					break;
 				end
 			end
		end
	end
	
	QuestHistoryDetailListScrollFrameScrollBar:SetValue(0);
	QuestHistoryDetailListScrollFrame:UpdateScrollChildRect();
	QuestHistoryDetailScrollFrameScrollBar:SetValue(0);
	QuestHistoryDetailScrollFrame:UpdateScrollChildRect();
	
	return false;
end
