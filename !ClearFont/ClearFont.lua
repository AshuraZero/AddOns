-- =============================================================================
--  CLEARFONT BY KIRKBURN  v11200-1 ������������޸İ棩
--  Official website:  http://www.clearfont.co.uk/
--  06.08.26
-- =============================================================================
--  CLEARFONT.LUA - STANDARD WOW UI FONTS
--  Home page:  http://bbs.ngacn.com/read.php?tid=538596
--  �ڴ�ҳ�����ز��鿴��ϸ˵����
-- =============================================================================




-- =============================================================================
--  һ�������ܺ͸�Ϊ���ı������� 
--  �������������Լ��ı�������,���µľ�������(���һ��) 
-- =============================================================================

ClearFont = CreateFrame("Frame", "ClearFont");

-- �������ʹ�����ɸ߶ȺͿ�ȵĻ�,�ɽ�'Fonts' �ĳ�'Fonts 2'
local CLEAR_FONT_BASE = "Fonts\\";

local CLEAR_FONT = CLEAR_FONT_BASE .. "FZLBJW.TTF";
local CLEAR_FONT_NUMBER = CLEAR_FONT_BASE .. "ARIALN.TTF";
local CLEAR_FONT_ZONE = CLEAR_FONT_BASE .. "FZL2JW.TTF";
local CLEAR_FONT_DAMAGE = CLEAR_FONT_BASE .. "FZJZJW.TTF";
local CLEAR_FONT_QUESTTITLE = CLEAR_FONT_BASE .. "LBJW.TTF";
local CLEAR_FONT_QUEST = CLEAR_FONT_BASE .. "FZBWJW.TTF";

-- ��������Լ�������
local YOUR_FONT_STYLE = CLEAR_FONT_BASE .. "msyhbd.ttf";

-- ����ı���:����,���������������С��80%,��ô���Խ�"1"�ĳ�"0.8"
local CF_SCALE = 1




-- �鿴���е����岢�仯����
-----------------------------------------------------

local function CanSetFont(object) 
   return (type(object)=="table" 
	   and object.SetFont and object.IsObjectType 
	      and not object:IsObjectType("SimpleHTML")); 
end




-- =============================================================================
--  ��׼WOW�û�������һ����
-- =============================================================================
--  ��������Ҫ�༭��һ������  
--  ��Ҫ�������Ѿ��г�,���ಿ�����尴����ĸ��˳������ 
--  ����ڲ����ı�������,����(����)���ܻ���������
-- =============================================================================
--  �ٸ�����:��Ϸ��ʼ��������:SetFont(CLEAR_FONT, 13 * CF_SCALE)
--  ��������ĵ�һ��������������,�ڶ������������С
--  ���ݸ���������ı�
-- =============================================================================


function ClearFont:ApplySystemFonts()


-- ���绷���С�3D����� (Dark Imakuni)
--------------------------------------------

-- ��������
   STANDARD_TEXT_FONT = CLEAR_FONT;

-- ��ͷ�ϵ�����
   UNIT_NAME_FONT = CLEAR_FONT;
   NAMEPLATE_FONT = CLEAR_FONT;

-- ��ʾ�ڱ�����Ŀ��ͷ�ϵ�Ч�� (�Ͳ��SCT/SDT�޹�)
   DAMAGE_TEXT_FONT = CLEAR_FONT_DAMAGE;

-- ʰȡ�˵������С
   UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12 * CF_SCALE;


-- ϵͳ����
--------------

   if (CanSetFont(SystemFont)) then 		SystemFont:SetFont(CLEAR_FONT, 14 * CF_SCALE); end


-- ��Ҫ����: ��ʾ�ڸ����Ŀɼ���Ҫ���岿��
-------------------------------------------------------

   if (CanSetFont(GameFontNormal)) then 		GameFontNormal:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontHighlight)) then 	GameFontHighlight:SetFont(CLEAR_FONT, 14 * CF_SCALE); end

   if (CanSetFont(GameFontDisable)) then 		SystemFont:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontDisable)) then 		GameFontDisable:SetTextColor(0.6, 0.6, 0.6); end

   if (CanSetFont(GameFontGreen)) then 		GameFontGreen:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontRed)) then 		GameFontRed:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontWhite)) then 		GameFontWhite:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameFontBlack)) then 		GameFontBlack:SetFont(CLEAR_FONT, 12 * CF_SCALE); end


-- С����: Ҳ����̩̹������壨�����
---------------------------------------------

   if (CanSetFont(GameFontNormalSmall)) then 		GameFontNormalSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end

   if (CanSetFont(GameFontDisableSmall)) then 		GameFontDisableSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameFontDisableSmall)) then 		GameFontDisableSmall:SetTextColor(0.6, 0.6, 0.6); end

   if (CanSetFont(GameFontDarkGraySmall)) then 		GameFontDarkGraySmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameFontDarkGraySmall)) then 		GameFontDarkGraySmall:SetTextColor(0.4, 0.4, 0.4); end

   if (CanSetFont(GameFontGreenSmall)) then 		GameFontGreenSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameFontRedSmall)) then 		GameFontRedSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameFontHighlightSmall)) then 	GameFontHighlightSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameFontHighlightSmallOutline)) then GameFontHighlightSmallOutline:SetFont(CLEAR_FONT, 12 * CF_SCALE, "OUTLINE"); end


-- ������: ����
---------------------------

   if (CanSetFont(GameFontNormalLarge)) then 		GameFontNormalLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontHighlightLarge)) then 	GameFontHighlightLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end

   if (CanSetFont(GameFontDisableLarge)) then 		GameFontDisableLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontDisableLarge)) then 		GameFontDisableLarge:SetTextColor(0.6, 0.6, 0.6); end

   if (CanSetFont(GameFontGreenLarge)) then 		GameFontGreenLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(GameFontRedLarge)) then 		GameFontRedLarge:SetFont(CLEAR_FONT, 14 * CF_SCALE); end


-- ��������: Raid����
---------------------------------

   if (CanSetFont(GameFontNormalHuge)) then 		GameFontNormalHuge:SetFont(CLEAR_FONT, 21 * CF_SCALE); end


-- ս����: in-built SCT-style ��Ϣ (��1.12����)
------------------------------------------------------

   if (CanSetFont(CombatTextFont)) then 			CombatTextFont:SetFont(CLEAR_FONT, 26 * CF_SCALE); end


-- ��������: �����С���Ǯ�����̡��������ӵ��û�����
------------------------------------------------------------------------------

   if (CanSetFont(NumberFontNormal)) then 		NumberFontNormal:SetFont(CLEAR_FONT_NUMBER, 13 * CF_SCALE, "OUTLINE"); end
   if (CanSetFont(NumberFontNormalYellow)) then 	NumberFontNormalYellow:SetFont(CLEAR_FONT_NUMBER, 13 * CF_SCALE, "OUTLINE"); end
   if (CanSetFont(NumberFontNormalSmall)) then 		NumberFontNormalSmall:SetFont(CLEAR_FONT_NUMBER, 11 * CF_SCALE, "OUTLINE"); end
   if (CanSetFont(NumberFontNormalSmallGray)) then 	NumberFontNormalSmallGray:SetFont(CLEAR_FONT_NUMBER, 11 * CF_SCALE, "OUTLINE"); end
   if (CanSetFont(NumberFontNormalLarge)) then 		NumberFontNormalLarge:SetFont(CLEAR_FONT_NUMBER, 15 * CF_SCALE, "OUTLINE"); end

   if (CanSetFont(NumberFontNormalHuge)) then 		NumberFontNormalHuge:SetFont(CLEAR_FONT_DAMAGE, 24 * CF_SCALE, "THICKOUTLINE"); end
   if (CanSetFont(NumberFontNormalHuge)) then 		NumberFontNormalHuge:SetAlpha(30); end


-- ���촰��������������촰�������С
--------------------------------------------------

   if (CanSetFont(ChatFontNormal)) then 			ChatFontNormal:SetFont(CLEAR_FONT, 14 * CF_SCALE); end

   CHAT_FONT_HEIGHTS = {
      [1] = 7,
      [2] = 8,
      [3] = 9,
      [4] = 10,
      [5] = 11,
      [6] = 12,
      [7] = 13,
      [8] = 14,
      [9] = 15,
      [10] = 16,
      [11] = 17,
      [12] = 18,
      [13] = 19,
      [14] = 20,
      [15] = 21,
      [16] = 22,
      [17] = 23,
      [18] = 24
   };


-- ������־: �����鼮��
----------------------------------------------------

   if (CanSetFont(QuestTitleFont)) then 			QuestTitleFont:SetFont(CLEAR_FONT_QUESTTITLE, 18 * CF_SCALE); end
   if (CanSetFont(QuestTitleFont)) then 			QuestTitleFont:SetShadowColor(0.54, 0.4, 0.1); end

   if (CanSetFont(QuestFont)) then 		   		QuestFont:SetFont(CLEAR_FONT_QUEST, 14 * CF_SCALE); end
   if (CanSetFont(QuestFont)) then 		   		QuestFont:SetTextColor(0.15, 0.09, 0.04); end

   if (CanSetFont(QuestFontNormalSmall)) then 		QuestFontNormalSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(QuestFontNormalSmall)) then 		QuestFontNormalSmall:SetShadowColor(0.54, 0.4, 0.1); end

   if (CanSetFont(QuestFontHighlight)) then 		QuestFontHighlight:SetFont(CLEAR_FONT_QUEST, 13 * CF_SCALE); end


-- �Ի���: ��ͬ�⡱������
---------------------------------

   if (CanSetFont(DialogButtonNormalText)) then 	DialogButtonNormalText:SetFont(CLEAR_FONT, 13 * CF_SCALE); end
   if (CanSetFont(DialogButtonHighlightText)) then 	DialogButtonHighlightText:SetFont(CLEAR_FONT, 13 * CF_SCALE); end


-- ��������: ����һ���������ڽ����С�������
-------------------------------------------------------------

   if (CanSetFont(ErrorFont)) then 	   			ErrorFont:SetFont(CLEAR_FONT, 14 * CF_SCALE); end
   if (CanSetFont(ErrorFont)) then 	   			ErrorFont:SetAlpha(60); end


-- ��Ʒ��Ϣ: ����ڵ��ۺ�ʹ����ʽ����Ű���������Ʒ�İ������壬�������Я�����鼮��
-------------------------------------

   if (CanSetFont(ItemTextFontNormal)) then 	   	ItemTextFontNormal:SetFont(CLEAR_FONT_QUEST, 15 * CF_SCALE); end


-- �ʼ��ͷ���������: ��Ϸ���ʼ��������з�����
--------------------------------------------------------------

   if (CanSetFont(MailTextFontNormal)) then 	   	MailTextFontNormal:SetFont(CLEAR_FONT_QUEST, 15 * CF_SCALE); end
   if (CanSetFont(MailTextFontNormal)) then 	   	MailTextFontNormal:SetTextColor(0.15, 0.09, 0.04); end
   if (CanSetFont(MailTextFontNormal)) then 	   	MailTextFontNormal:SetShadowColor(0.54, 0.4, 0.1); end
   if (CanSetFont(MailTextFontNormal)) then 	   	MailTextFontNormal:SetShadowOffset(1, -1); end

   if (CanSetFont(InvoiceTextFontNormal)) then 	   	InvoiceTextFontNormal:SetFont(CLEAR_FONT_QUEST, 13 * CF_SCALE); end
   if (CanSetFont(InvoiceTextFontNormal)) then 	   	InvoiceTextFontNormal:SetTextColor(0.15, 0.09, 0.04); end

   if (CanSetFont(InvoiceTextFontSmall)) then 	   	InvoiceTextFontSmall:SetFont(CLEAR_FONT_QUEST, 11 * CF_SCALE); end
   if (CanSetFont(InvoiceTextFontSmall)) then 	   	InvoiceTextFontSmall:SetTextColor(0.15, 0.09, 0.04); end


-- ������: ���ܸ���
--------------------------------

   if (CanSetFont(SubSpellFont)) then 	   		SubSpellFont:SetFont(CLEAR_FONT_QUEST, 12 * CF_SCALE); end


-- ״̬��: ��λ��ܵ����ֺ��˺��������������
---------------------------------------------------------

   if (CanSetFont(TextStatusBarText)) then 	   	TextStatusBarText:SetFont(CLEAR_FONT_NUMBER, 13 * CF_SCALE, "OUTLINE"); end
   if (CanSetFont(TextStatusBarTextSmall)) then 	TextStatusBarTextSmall:SetFont(CLEAR_FONT, 14); end


-- ��ʾ���
-----------

   if (CanSetFont(GameTooltipText)) then 	   		GameTooltipText:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameTooltipTextSmall)) then 	   	GameTooltipTextSmall:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(GameTooltipHeaderText)) then 	   	GameTooltipHeaderText:SetFont(CLEAR_FONT, 14 * CF_SCALE); end


-- �����ͼ: λ������
-----------------------------

   if (CanSetFont(WorldMapTextFont)) then 	   	WorldMapTextFont:SetFont(CLEAR_FONT_ZONE, 102 * CF_SCALE, "THICKOUTLINE"); end
   if (CanSetFont(WorldMapTextFont)) then 	   	WorldMapTextFont:SetShadowColor(0, 0, 0); end
   if (CanSetFont(WorldMapTextFont)) then 	   	WorldMapTextFont:SetShadowOffset(1, -1); end
   if (CanSetFont(WorldMapTextFont)) then 	   	WorldMapTextFont:SetAlpha(40); end


-- �����л���ʾ: ����Ļ����֪ͨ
----------------------------------------

   if (CanSetFont(ZoneTextFont)) then 	   		ZoneTextFont:SetFont(CLEAR_FONT_ZONE, 112 * CF_SCALE, "THICKOUTLINE"); end
   if (CanSetFont(ZoneTextFont)) then 	   		ZoneTextFont:SetShadowColor(0, 0, 0); end
   if (CanSetFont(ZoneTextFont)) then 	   		ZoneTextFont:SetShadowOffset(1, -1); end

   if (CanSetFont(SubZoneTextFont)) then 	   		SubZoneTextFont:SetFont(CLEAR_FONT_ZONE, 26 * CF_SCALE, "THICKOUTLINE"); end


-- ����ȥ���ٱ�ʹ��
---------------------------------------------------

   if (CanSetFont(CombatLogFont)) then 			CombatLogFont:SetFont(CLEAR_FONT, 14 * CF_SCALE); end

end




-- =============================================================================
--  C. FUNCTION TO RELOAD EVERY TIME AN ADDON LOADS
--  They do like to mess up my addon!
-- =============================================================================

ClearFont:SetScript("OnEvent",
		    function() 
		       if (event == "ADDON_LOADED") then
			  ClearFont:ApplySystemFonts()
		       end
		    end);
ClearFont:RegisterEvent("ADDON_LOADED");




-- =============================================================================
--  D. APPLY ALL THE ABOVE ON FIRST RUN
--  To start the ball rolling
-- =============================================================================

ClearFont:ApplySystemFonts()
