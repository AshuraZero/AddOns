UIPanelWindows["IEDKPForm"] = { area = "left", pushable = 1, whileDead = 1 };
IEDKP = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "FuBarPlugin-2.0");
IEDKP.hasIcon = "Interface\\Addons\\IEDKP\\mblogo.tga"
IEDKP.cannotDetachTooltip = true;
IEDKP.cannotHideText = false;


SLASH_IEDKP1 = "/iedkp"
SLASH_IEDKP2 = "/ie"

 SlashCmdList["IEDKP"] = function(msg)
    local _, _, command, args = string.find(msg, "(%w+)%s?(.*)");
    if(command) then
        command = strlower(command);
    end

    if(command == "toggleminimap") then
        if (IEDKP.miniminimapFrame) then
            if (IEDKP.minimapFrame:IsVisible()) then
                IEDKP:Hide()
            else
                IEDKP:Show()
            end
        else
            IEDKP.OnMenuRequest = IEDKP.Options.fubar
            IEDKP:Show()
        end
    else
        ShowUIPanel(IEDKPForm);
    end
end;



--region variable
IEDKP_FuBarOptions = { };
IEDKP:RegisterDB("IEDKP_FuBarOptions")

IEDKP.Options = {}
IEDKP.Options.fubar = {
    type = 'group',
    args = {
        CT_RaidTracker = {
            type = 'execute',
            name = "显示记录",
            desc = "显示团队活动记录",
            func = function() ShowUIPanel(CT_RaidTrackerFrame) end,
            order = 10
        },
        MerDKP = {
            type = 'execute',
            name = "显示分数",
            desc = "显示团队分数查询",
            func = function() ShowUIPanel(MerDKPFrame) end,
            order = 20
        },
        config = {
            type = 'group',
            name = "配置",
            desc = "配置选项",
            args = {
                showitemoptions = {
                    type = 'execute',
                    name = "显示战利品选项",
                    desc = "显示战利品选项",
                    func = function() CT_RaidTrackerItemOptionsFrame:Show() end
                },
                showoptions = {
                    type = 'execute',
                    name = "显示设置",
                    desc = "显示活动记录设置",
                    func = function() CT_RaidTrackerOptionsFrame:Show() end
                },
            },
            order = 30
        },
    }
}


--end region variable


--region event
function IEDKP_OnLoad(this)
    CT_RaidTrackerTitleText:SetText("团队活动记录");
    -- Register events

end

function IEDKP_Minimap_OnClick()
	ShowUIPanel(IEDKPForm);

end

function IEDKP:OnInitialize()
    IEDKP.OnMenuRequest = IEDKP.Options.fubar
end
--end region event


--region function


--end region function
