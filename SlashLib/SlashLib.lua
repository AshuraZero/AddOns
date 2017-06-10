------------------------------------- VARIABLES ---------------------------------------
SLIB_NOM = "插件命令控制台";
SLIB_VERS = "SlashLib";

------------- valeurs par defaut
SlashLibSaved = {};
SlashLibSaved["showMinimapIcon"] = true;
SlashLibSaved["minimapIconAngle"] = -1.56;
SlashLibSaved["closeRun"] = true;

SlashLibSavedData = {};
SlashLibSavedData[1] = {"初始设置","/run print(\"已为您调整TAB的范围为50\")\n/run print(\"已调整战斗取值的范围为150\")\n/run print(\"已设置最大的视野为50\")\n/console SET targetNearestDistance \"50\"\n/console SET targetNearestDistanceRadius \"50\"\n/console SET CombatLogRangePartyPet \"150\"\n/console SET CombatLogRangeFriendlyPlayers \"150\"\n/console SET CombatLogRangeFriendlyPlayersPets \"150\"\n/console SET CombatLogRangeHostilePlayers \"150\"\n/console SET CombatLogRangeHostilePlayersPets \"150\"\n/console SET CombatLogRangeCreature \"150\"\n/console SET CombatLogRangeParty \"150\"\n/console SET CombatDeathLogRange \"150\"\n/console SET screenshotQuality 10\n/script SetCVar(\"cameraDistanceMax\", 50)",1};

-------------
TABLEVISBTNS = {};
SLIBLIGNE = {};
SLIBSCROLLHEIGHT = 21; -- hauteur ligne
SLIBVISLINE = 14; -- nombre de lignes visibles dans la main UI -- nombre de lignes visibles : SLIBVISLINE * SLIBSCROLLHEIGHT = hauteur ScrollFrame et aussi nombre de boutons-lignes
SLIBVISLINELIST = 21; -- nombre de lignes visibles dans la liste des slash-cmds
SLIBLISTALLCMDS = {};
local SEPLIGNE = "\n";
local enTest = false;

---------------------------------------------------------------------------------------
-------------------------- CHARGEMENT / COMMANDES /BINDINGS ---------------------------
function slibChargement()
	SlashCmdList["SLIBSHOWUI"] = slibUIShow;
		SLASH_SLIBSHOWUI1 = "/slashlib";
		SLASH_SLIBSHOWUI2 = "/cj";

	SlashCmdList["SLIBDOBTN"] = slibDoNomBtn;
		SLASH_SLIBDOBTN1 = "/slashlibdo";
		SLASH_SLIBDOBTN2 = "/slashlibexe";
		SLASH_SLIBDOBTN3 = "/slibdo";
		SLASH_SLIBDOBTN4 = "/slibexe";

	SlashCmdList["SLIBSHOWICON"] = slibMinimapIconShowSwitch;
		SLASH_SLIBSHOWICON1 = "/slashlibshowicon";
		SLASH_SLIBSHOWICON2 = "/slibshow";
		SLASH_SLIBSHOWICON3 = "/slibshowicon";
		SLASH_SLIBSHOWICON4 = "/slibicon";

	SlashCmdList["SLIBRESET"] = slibResetAll;
		SLASH_SLIBRESET1 = "/slibrao";
		SLASH_SLIBRESET2 = "/slashlibreset";

	SlashCmdList["SLIBHELP"] = slibHelpVers;
		SLASH_SLIBHELP1 = "/slashlibhelp";

	SlashCmdList["SLIBDEBUG"] = slibDebugOnOff;
		SLASH_SLIBDEBUG1 = "/slibdebug";

	SlashCmdList["SLIB_TEST"] = slibTest;
		SLASH_SLIB_TEST1 = "/slibx";

	-------------- bindings
	BINDING_HEADER_SLASHLIB = SLIB_NOM;
	BINDING_NAME_SLIBshow = "显示控制台";

	-------------- suite
	slibLigneInit();
	if (SlashLibSaved["showMinimapIcon"]) then slibMinimapIconShow(); end;
	echo(SLIB_NOM.." "..SLIB_VERS.." 已载入 - 输入 /cj 查阅更多的帮助信息.","blue");
end

---------------------------------------------------------------------------------------
------------------------------------------ UI -----------------------------------------
function slibMinimapIconShowSwitch()
	if (forcerVisible or Slib_MinimapBtn:IsVisible()) then
		SlashLibSaved["showMinimapIcon"] = false;
		Slib_MinimapBtn:Hide();
	else
		slibMinimapIconShow();
	end;
end

function slibMinimapIconShow()
	SlashLibSaved["showMinimapIcon"] = true;
	Slib_MinimapBtn:ClearAllPoints();
	slibMinimapButton_SetPositionAngle(SlashLibSaved["minimapIconAngle"]);
	Slib_MinimapBtn:Show();
end

function slibUIShow()
	if (SlibFrame:IsVisible()) then
		slibUIClose();
	else
		slibUIClose(); -- menage
		SlibFrame:Show(); -- ne pas intervertir avec la ligne suivante !
		slibScrollerUpdate(); -- ne pas intervertir avec la ligne precedente !
	end;
end

function slibScrollerUpdate()
	TABLEVISBTNS = {};
	local line; -- 1 through SLIBVISLINE
	local linePlusOffset; -- an index into our data calculated from the scroll offset
	local nbreLiMax = getn(SlashLibSavedData); -- nombre de lignes
	FauxScrollFrame_Update(SlibFrameScroller,nbreLiMax,SLIBVISLINE,SLIBSCROLLHEIGHT);
	if (enTest) then echo(SLIB_NOM.."---Scroll at "..FauxScrollFrame_GetOffset(SlibFrameScroller)); end;
	for line = 1,SLIBVISLINE,1 do
		linePlusOffset = line + FauxScrollFrame_GetOffset(SlibFrameScroller);
		if (linePlusOffset <= nbreLiMax) then
			TABLEVISBTNS[line] = SlashLibSavedData[linePlusOffset];
			TABLEVISBTNS[line][4] = linePlusOffset;
			getglobal("SlibFrameLine_"..line.."_BtnTitre_TxtTitre"):SetText(TABLEVISBTNS[line][1]);
			getglobal("SlibFrameLine_"..line.."_BtnCmd_Tex"):SetTexture(0.3,0.3,0.3,0.4);
			local genre = TABLEVISBTNS[line][3];
			if (genre == 2) then -- emote
				getglobal("SlibFrameLine_"..line.."_BtnTitre_TxtTitre"):SetTextColor(0.4,0.7,0.9);
			elseif (genre == 3) then -- macro
				getglobal("SlibFrameLine_"..line.."_BtnTitre_TxtTitre"):SetTextColor(0.9,0.4,0.4);
			else
				getglobal("SlibFrameLine_"..line.."_BtnTitre_TxtTitre"):SetTextColor(0.9,0.9,0.4);
			end;
			getglobal("SlibFrameLine_"..line.."_BtnCmd_TxtCmd"):SetText(string.gsub(SlashLibSavedData[linePlusOffset][2],SEPLIGNE,"..."));
			getglobal("SlibFrameLine_"..line):Show();
		else
			getglobal("SlibFrameLine_"..line):Hide();
		end;
	end;
	SlibFrameScroller:Show(); -- ???
end

function slibUIDo(nomBouton)
	slibGetLibLigne(nomBouton);
	if (SLIBLIGNE["cmd"] ~= "") then
		if (SlashLibSaved["closeRun"]) then SlibFrame:Hide(); end;
		slibDoSlashCmd(SLIBLIGNE["cmd"]);
	else
		echo(SLIB_NOM..": 错误 - 命令 #"..SLIBLIGNE["numLi"].." 不存在!","red");
	end;
end

function slibUINew()
	slibUIEditResetTex();
	SlibNameDef:SetText("");
	SlibCmdDef:SetText("");
	slibUIEditAllumeRadios(1); -- genre "slash-cmd" par defaut
	slibLigneInit();
	placementMainFrame("TOP",180); -- 180 = hauteur frame edit
	SlibEditFrame:Show();
	SlibNameDef:SetFocus();
end

function slibUIClose()
	SlibListCmdsFrame:Hide();
	SlibEditFrame:Hide();
	SlibNameDef:SetText("");
	SlibCmdDef:SetText("");
	SlibFrame:Hide();
end

function slibUIEdit(nomBouton)
	slibGetLibLigne(nomBouton);
	if (SLIBLIGNE["numLi"] > 0) then
		slibUIEditResetTex();
		getglobal("SlibFrameLine_"..SLIBLIGNE["numLi"].."_BtnCmd_Tex"):SetTexture(1,1,0,0.9);
		SlibNameDef:SetText(SLIBLIGNE["nom"]);
		SlibCmdDef:SetText(SLIBLIGNE["cmd"]);
		slibUIEditAllumeRadios(SLIBLIGNE["genre"]);
		placementMainFrame("TOP",180); -- 180 = hauteur frame edit
		SlibEditFrame:Show();
		SlibNameDef:SetFocus();
	end;
end

function slibUIEditResetTex()
	for i = 1,SLIBVISLINE,1 do
		getglobal("SlibFrameLine_"..i.."_BtnCmd_Tex"):SetTexture(0.3,0.3,0.3,0.4);
	end;
end

function slibUIEditSave()
	local nom = SlibNameDef:GetText();
	if (nom ~= "") then
		local commande = SlibCmdDef:GetText();
		local novoLigne = {nom,commande,slibUIEditGetNumRadio()};
		if (SLIBLIGNE["numLi"] == 0) then -- new
			if (enTest) then echo(SLIB_NOM.."----保存新命令行="..SLIBLIGNE["numLi"].."---NumRad="..slibUIEditGetNumRadio().."."); end;
			table.insert(SlashLibSavedData,novoLigne);
		else
			if (enTest) then echo(SLIB_NOM.."----保存编辑命令行="..SLIBLIGNE["numLi"].."---NumRad="..slibUIEditGetNumRadio().."."); end;
			SlashLibSavedData[SLIBLIGNE["numLiOr"]] = novoLigne;
		end;
		---------
		SlashLibSavedData = sortTable(SlashLibSavedData,1,"A","A");
		---------
		slibScrollerUpdate();
		slibUIEditResetTex();
		SlibListCmdsFrame:Hide();
		SlibEditFrame:Hide();
	else
		echo(SLIB_NOM..": 键入个名字，定义为这个新的命令行!","red");
	end;
end

function slibUIEditDelete(nomBouton)
	if (nomBouton ~= nil and nomBouton ~= "") then -- si appel depuis l'UI principale (clic liste)
		slibGetLibLigne(nomBouton);
	end;
	if (SLIBLIGNE["numLi"] > 0) then -- appel normal : btn "delete" UI edition
		if (enTest) then echo(SLIB_NOM..":编辑删除---SLIB[numLi]="..SLIBLIGNE["numLi"].."---SLIB[numLiOr]="..SLIBLIGNE["numLiOr"].."---"); end;
		table.remove(SlashLibSavedData,SLIBLIGNE["numLiOr"]);
		slibScrollerUpdate();
		SlibEditFrame:Hide();
	else
		echo(SLIB_NOM..": 空的不能删除!","red");
	end;
end

function slibUIEditCancel()
	SlibListCmdsFrame:Hide();
	SlibEditFrame:Hide();
	SlibNameDef:SetText("");
	SlibCmdDef:SetText("");
	slibUIEditResetTex();
	slibLigneInit(); -- secu
end

function slibUIEditAllumeRadios(numBtn)
	SlibRadBtn1:SetChecked(0);
	SlibRadBtn2:SetChecked(0);
	SlibRadBtn3:SetChecked(0);
	if (numBtn ~= nil and numBtn ~= "") then
		local nbre = strToNumber(numBtn);
		if (nbre > 1 and nbre <= 3) then
			getglobal("SlibRadBtn"..numBtn):SetChecked(1);
		else
			SlibRadBtn1:SetChecked(1);
		end;
	else
		echo(SLIB_NOM..": 错误 - 无效按钮!","red");
	end;
end

function slibUIEditGetNumRadio()
	local i;
	for i = 1,3,1 do
		if (getglobal("SlibRadBtn"..i):GetChecked() == 1) then return i; end;
	end;
	return 1; -- defaut
end

function slibUIEditListShow()
	if (SlibListCmdsFrame:IsVisible()) then
		SlibListCmdsFrame:Hide();
	else
		listeAllSlashCmd(); -- remplissage SLIBLISTALLCMDS
		placementMainFrame("LEFT",196);-- 216 = largeur frame liste cmds
		SlibListCmdsFrame:Show(); -- ne pas intervertir avec la ligne suivante !
		slibScrollerListUpdate(); -- ne pas intervertir avec la ligne precedente !
	end;
end

function slibScrollerListUpdate()
	local line; -- 1 through nbreLiVis
	local linePlusOffset; -- an index into our data calculated from the scroll offset
	local nbreLiMax = getn(SLIBLISTALLCMDS); -- nombre de lignes
	FauxScrollFrame_Update(SlibListFrameScroller,nbreLiMax,SLIBVISLINELIST,SLIBSCROLLHEIGHT);
	if (enTest) then echo(SLIB_NOM.."---Scroll at "..FauxScrollFrame_GetOffset(SlibListFrameScroller)); end;
	for line = 1,SLIBVISLINELIST,1 do
		linePlusOffset = line + FauxScrollFrame_GetOffset(SlibListFrameScroller);
		if (linePlusOffset <= nbreLiMax) then
			getglobal("SlibListLigneBtn_"..line.."_Texte"):SetText(SLIBLISTALLCMDS[linePlusOffset]);
			getglobal("SlibListLigneBtn_"..line):Show();
		else
			getglobal("SlibListLigneBtn_"..line):Hide();
		end;
	end;
	SlibListFrameScroller:Show(); -- ???
end

function slibUIEditListClick(txtBouton)
	if (txtBouton ~= nil) then
		if (string.sub(txtBouton,1,1) == "/") then
			if (IsControlKeyDown()) then -- DO (TEST)
				SlibCmdDef:SetText(SlibCmdDef:GetText()..txtBouton);
			else -- AJOUT EDIT
				slibDoSlashCmd(txtBouton);
			end;
		else
			echo(SLIB_NOM..": 错误 - "..txtBouton.." 不是个有效命令行!","red");
		end;
	else
		echo(SLIB_NOM..": 错误 - 无效命令行(NIL)!","red");
	end;
end

---------------------------------------------------------------------------------------
------------------------------------ FCNS INTERNES ------------------------------------
function slibDoNomBtn(arg)
	if (arg ~= nil and arg ~= "") then
		local trouvePas = true;
		local nomSlash = string.upper(string.gsub(string.gsub(arg,"\"",""),"\'",""));
		for i = 1,getn(SlashLibSavedData),1 do
			if (string.upper(SlashLibSavedData[i][1]) == nomSlash) then
				trouvePas = false;
				slibDoSlashCmd(SlashLibSavedData[i][2]);
				break;
			end;
		end;
		if (trouvePas) then echo(SLIB_NOM..": 错误 - 无法找到脚本 "..nilSiNul(nomSlash).."!","red"); end;
	else
		echo(SLIB_NOM..": 错误 - 参数不能为空!","red");
	end;
end

function slibResetAll()
	SlashLibSaved = {};
	SlashLibSaved["showMinimapIcon"] = true;
	SlashLibSaved["minimapIconAngle"] = -1.23;
	SlashLibSaved["closeRun"] = true;

	SlibFrame:ClearAllPoints();
	SlibFrame:SetPoint("CENTER","UIParent","CENTER",0,100);
	slibMinimapIconShow();
	slibUIClose();
	slibUIShow();
	echo(SLIB_NOM..": 选项重置为默认值.","green");
end

function slibLigneInit()
	SLIBLIGNE = {};
	SLIBLIGNE["numLi"] = 0;
	SLIBLIGNE["nom"] = "";
	SLIBLIGNE["cmd"] = "";
	SLIBLIGNE["genre"] = 1; -- genre : 1 = slash-cmd, 2 = Emote et 3 = Macro
	SLIBLIGNE["numLiOr"] = 0;
end

function slibGetLibLigne(nomBouton)
	if (nomBouton ~= nil) then
		local numBtn = strToNumber(extractValeur(nomBouton,"_"));
		if (enTest) then echo(SLIB_NOM..":GETLIBLIGNE---BtnName="..nomBouton.."---LineNumber="..numBtn.."---"); end;
		if (numBtn > 0 and numBtn <= getn(TABLEVISBTNS)) then
			SLIBLIGNE["numLi"] = numBtn;
			SLIBLIGNE["nom"] = TABLEVISBTNS[numBtn][1];
			SLIBLIGNE["cmd"] = TABLEVISBTNS[numBtn][2];
			SLIBLIGNE["genre"] = TABLEVISBTNS[numBtn][3];
			SLIBLIGNE["numLiOr"] = TABLEVISBTNS[numBtn][4];
		else
			slibLigneInit();
			echo(SLIB_NOM..": 错误 - 无法找到 #"..nilSiNul(numBtn).."!","red");
		end;
	else
		slibLigneInit();
		echo(SLIB_NOM..": 错误 - 空行!","red");
	end;
end

function slibDoSlashCmd(chaineCmd)
	local chaine = chaineCmd..SEPLIGNE;
	local pos1,pos2,chaineTemp;
	local i = 1;
	while string.find(chaine,SEPLIGNE,1,true) ~= nil do
		pos1,pos2 = string.find(chaine,SEPLIGNE,1,true);
		chaineTemp = string.sub(chaine,1,pos1 - 1);
		if (enTest) then echo(SLIB_NOM.."---执行字串 "..i..":"..chaineTemp.."---"); end;
		-------- envoi ligne de commande
		if (string.sub(chaineTemp,1,1) == "/") then
			DEFAULT_CHAT_FRAME.editBox:SetText(chaineTemp);
			ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox,0);
		else
			echo(SLIB_NOM..": 错误 - "..chaineTemp.." 不是有效命令!","red");
		end;
		--------
		chaine = string.sub(chaine,pos2 + 1);
		i = i + 1;
		if (i > 50) then return; end; -- secu
	end;
end

function XXXXXXXXXXXXXXXXXXXXXslibDoSlashCmd(chaineCmd)
	local commande = strupper(chaineCmd);
	for index, value in SlashCmdList do
		local i = 1;
		local cmdString = TEXT(getglobal("SLASH_"..index..i));
		while ( cmdString ) do
			cmdString = strupper(cmdString);
			if ( cmdString == commande ) then
				value(commande);
				return;
			end
			i = i + 1;
			cmdString = TEXT(getglobal("SLASH_"..index..i));
		end
	end
	echo(SLIB_NOM..": 错误 - 未知命令 "..nilSiNul(chaineCmd)..".","red");
end

function listeAllSlashCmd()
	SLIBLISTALLCMDS = {};
	local prevCommande = "";
	for index,value in pairs(SlashCmdList) do -- SlashCmdList = table Blizzard des slash-cmds
		local i = 1;
		local cmdString = TEXT(getglobal("SLASH_"..index..i));
		while (cmdString) do
			if (cmdString ~= prevCommande) then
				table.insert(SLIBLISTALLCMDS,cmdString);
				prevCommande = cmdString;
			end;
			i = i + 1;
			cmdString = TEXT(getglobal("SLASH_"..index..i));
		end;
	end;
	table.sort(SLIBLISTALLCMDS);
end

function slibHelpVers()
	echo(SLIB_NOM.." 版本 "..SLIB_VERS..".","blue");
	slibSlashListe();
end

function slibDebugOnOff()
	enTest = not enTest;
	echo(SLIB_NOM..": 除错 "..booleanToSr(enTest)..".","green");
end

function slibTest(arg)
	local chaine;
	if (SlashLibSavedData ~= nil and SlashLibSavedData ~= "" or getn(SlashLibSavedData) < 1) then
		for i = 1,getn(SlashLibSavedData),1 do
			chaine = nilSiNul(SlashLibSavedData[i][2]);	echo("保存数据:"..i.."---"..nilSiNul(SlashLibSavedData[i][1]).."---"..string.sub(string.gsub(chaine,SEPLIGNE,"..."),1,10).."---"..nilSiNul(SlashLibSavedData[i][3]).."---","green");
		end;
	else
		echo("保存数据: 为零或空!!!","red");
	end;
end

---------------------------------------------------------------------------------------
-------------------------------------- LIBRAIRIE --------------------------------------
function sortTable(tableOr,cle,sens,genre)
	local tableTemp = {};
	for i in ipairs(tableOr)do
		table.insert(tableTemp,i);
	end;
	if (sens == nil) then sens = "A"; end;
	sens = string.upper(string.sub(sens,1,1));
	if (genre == nil) then genre = "N"; end;
	genre = string.upper(string.sub(genre,1,1));
	if (sens == "D") then
		if (genre == "A") then
			table.sort(tableTemp, function(a,b) return string.lower(tableOr[a][cle]) > string.lower(tableOr[b][cle]) end);
		else -- numerique par defaut
			table.sort(tableTemp, function(a,b) return tableOr[a][cle] > tableOr[b][cle] end);
		end;
	else -- ascendant par defaut
		if (genre == "A") then
			table.sort(tableTemp, function(a,b) return string.lower(tableOr[a][cle]) < string.lower(tableOr[b][cle]) end);
		else -- numerique par defaut
			table.sort(tableTemp, function(a,b) return tableOr[a][cle] < tableOr[b][cle] end);
		end;
	end;
	for i in ipairs(tableTemp)do
		tableTemp[i] = tableOr[tableTemp[i]];
	end
	return tableTemp;
end

function extractValeur(chaine,sep)
	-- renvoit la portion de la chaine passee situee entre les 2 premiers sep (ou vide si sep n'est pas trouve)
	if (chaine ~= nil and sep ~= nil) then
		local pos = string.find(chaine,"_",1,true);
		if (pos ~= nil) then
			local chaineTemp = string.sub(chaine,pos + 1);
			pos = string.find(chaineTemp,"_",1,true);
			if (pos ~= nil) then
				return (string.sub(chaineTemp,1,pos - 1));
			else
				return chaineTemp;
			end;
		else
			return "";
		end;
	else
		return nil;
	end;
end

function strToNumber(chaine)
	local valeur = tonumber(string.gsub(string.gsub(chaine,"\"",""),"\'",""),10);
	if (valeur == nil) then valeur = 0; end;
	return valeur;
end

function booleanToSr(valeur)
	if (valeur) then return "true"; else return "false"; end;
end

function booleanToBin(valeur)
	return (valeur == 1);
end

function videSiNul(valeur)
	if (valeur == nil) then return ""; else return valeur; end;
end

function nilSiNul(valeur)
	if (valeur == nil) then return "NIL"; else return valeur; end;
end

function placementMainFrame(sens,distance)
	--***
end

function XXXXXXXXXXXXXXXXplacementMainFrame(sens,distance) -- fais planter wow ? ***
	local largeurMainFrame,hauteurMainFrame = 352,384;
	local margeH,margeB,margeG,margeD = 10,50,10,10;
	local point,relativeTo,relativePoint,xOfs,yOfs = SlibFrame:GetPoint();

	if (string.upper(sens) == "TOP") then
		local ecran = GetScreenHeight();
		if ((ecran - (hauteurMainFrame + abs(yOfs))) < (distance + margeB)) then
			SlibFrame:ClearAllPoints();
			SlibFrame:SetPoint("TOPLEFT","UIParent","TOPLEFT",xOfs,(ecran - distance) - ecran);
		end;
	elseif (string.upper(sens) == "BOTTOM") then
		local ecran = GetScreenHeight();
		if (abs(yOfs) < (distance + margeH)) then
			SlibFrame:ClearAllPoints();
			SlibFrame:SetPoint("TOPLEFT","UIParent","TOPLEFT",xOfs,distance + margeH);
		end;
	elseif (string.upper(sens) == "LEFT") then
		local ecran = GetScreenWidth();
		if ((ecran - (largeurMainFrame + abs(xOfs))) < (distance + margeD)) then
			SlibFrame:ClearAllPoints();
			SlibFrame:SetPoint("TOPLEFT","UIParent","TOPLEFT",ecran - (largeurMainFrame + distance + margeD),yOfs);
		end;
	elseif (string.upper(sens) == "RIGHT") then
		local ecran = GetScreenWidth();
		if (abs(yOfs) < (distance + margeG)) then
			SlibFrame:ClearAllPoints();
			SlibFrame:SetPoint("TOPLEFT","UIParent","TOPLEFT",distance + margeG,yOfs);
		end;
	end;
end

function echo(chaine,nomCouleur)
	local coulr,coulg,coulb = 1,1,1 ; -- couleurs
	if (nomCouleur == "red") then
		coulr,coulg,coulb = 1,0,0;
	elseif (nomCouleur == "green") then
		coulr,coulg,coulb = 0,1,0;
	elseif (nomCouleur == "blue") then
		coulr,coulg,coulb = 0.5,0.5,0.8;
	elseif (nomCouleur == "orange") then
		coulr,coulg,coulb = 0.8,0.3,0.1;
	elseif (nomCouleur == "yellow") then
		coulr,coulg,coulb = 0.9,0.9,0.1;
	elseif (nomCouleur == "grey" or nomCouleur == "gray") then
		coulr,coulg,coulb = 0.6,0.6,0.6;
	end;
	if (DEFAULT_CHAT_FRAME) then DEFAULT_CHAT_FRAME:AddMessage(chaine,coulr,coulg,coulb); end;
end

---------------------------------------------------------------------------------------
------------------------------------- AIDE ONLINE -------------------------------------
function slibSlashListe()
	local i;
	local aideOnline =  {};
	aideOnline[1] = "/cj: 显示命令行";
	aideOnline[2] = "/slashlibshowicon: 显示或隐藏小地图按钮";
	echo("------------------------","grey");
	for i = 1,getn(aideOnline),1 do
		echo("   "..aideOnline[i].."\n","grey");
	end;
	echo("------------------------","grey");
end

---------------------------------------------------------------------------------------
