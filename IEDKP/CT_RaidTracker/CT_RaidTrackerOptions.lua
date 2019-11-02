function CT_RaidTracker_OptionsFrame_OnShow()
    CT_RaidTrackerOptionsFrameMinQualitySlider:SetValue(CT_RaidTracker_Options["MinQuality"]);
    CT_RaidTrackerOptionsFrameAskCostSlider:SetValue(CT_RaidTracker_Options["AskCost"]);
    CT_RaidTrackerOptionsFrameGetDKPValueSlider:SetValue(CT_RaidTracker_Options["GetDkpValue"]);
    CT_RaidTrackerOptionsFrameGroupItemsSlider:SetValue(CT_RaidTracker_Options["GroupItems"]);
	if (CT_RaidTracker_Options["SaveTooltips"] == 1) then 
		CT_RaidTrackerOptionsFrameSaveTooltipsCB:SetChecked(true);
	else
		CT_RaidTrackerOptionsFrameSaveTooltipsCB:SetChecked(false);
	end
	if (CT_RaidTracker_Options["AutoWhisper"] == 1) then 
		CT_RaidTrackerOptionsFrameAutoWhisperCB:SetChecked(true);
	else
		CT_RaidTrackerOptionsFrameAutoWhisperCB:SetChecked(false);
	end
	if (CT_RaidTracker_Options["FilterWhisper"] == 1) then 
		CT_RaidTrackerOptionsFrameFilterWhisperCB:SetChecked(true);
	else
		CT_RaidTrackerOptionsFrameFilterWhisperCB:SetChecked(false);
	end
end

function CT_RaidTracker_OptionsFrame_Save()
    CT_RaidTracker_GetGameTimeOffset();
    CT_RaidTracker_Options["MinQuality"] = CT_RaidTrackerOptionsFrameMinQualitySlider:GetValue();
    CT_RaidTracker_Options["AskCost"] = CT_RaidTrackerOptionsFrameAskCostSlider:GetValue();
    CT_RaidTracker_Options["GetDkpValue"] = CT_RaidTrackerOptionsFrameGetDKPValueSlider:GetValue();
    CT_RaidTracker_Options["GroupItems"] = CT_RaidTrackerOptionsFrameGroupItemsSlider:GetValue();
    if( CT_RaidTrackerOptionsFrameSaveTooltipsCB:GetChecked() ) then
        CT_RaidTracker_Options["SaveTooltips"] = 1;
    else
        CT_RaidTracker_Options["SaveTooltips"] = 0;
    end
    if( CT_RaidTrackerOptionsFrameAutoWhisperCB:GetChecked() ) then
        CT_RaidTracker_Options["AutoWhisper"] = 1;
    else
        CT_RaidTracker_Options["AutoWhisper"] = 0;
    end
    if( CT_RaidTrackerOptionsFrameFilterWhisperCB:GetChecked() ) then
        CT_RaidTracker_Options["FilterWhisper"] = 1;
    else
        CT_RaidTracker_Options["FilterWhisper"] = 0;
    end
end
