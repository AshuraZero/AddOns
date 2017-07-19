StopTheLagness = AceLibrary("AceAddon-2.0"):new("AceHook-2.0", "AceConsole-2.0", "AceDB-2.0")

StopTheLagness:RegisterDB('StopLagDB')
StopTheLagness:RegisterDefaults('profile', {
	tooltips = true,
})
StopTheLagness:RegisterChatCommand({"/stop", "/stl", "/stoplag"}, {
	type = 'group',
	args = {
		tooltips = {
			type = 'toggle', name = 'tooltips',
			desc = "Toggle optimization of the game's tooltips to attempt to reduce memory usage.",
			get = function() return StopTheLagness.db.profile.tooltips end,
			set = function(t)
				StopTheLagness.db.profile.tooltips = t
				StopTheLagness:OptimizeTooltips(t)
			end,
		},
	},
})

StopTheLagness.version = "2.0." .. string.sub("$Revision: 10715 $", 12, -3)
StopTheLagness.date = string.sub("$Date: 2006-09-10 03:43:57 -0400 (Sun, 10 Sep 2006) $", 8, 17)

function StopTheLagness:OnEnable()
	self:OptimizeTooltips(self.db.profile.tooltips)
end

function StopTheLagness:OnDisable()
	self:OptimizeTooltips(false)
end

function StopTheLagness:OptimizeTooltips(state)
	if state then
		self:HookTooltips()
	else
		self:UnhookTooltips()
	end
end

function StopTheLagness:HookTooltips()
	self:Hook("ContainerFrameItemButton_OnEnter", "CFIB_OnEnter")
	self:Hook("ContainerFrameItemButton_OnUpdate", "CFIB_OnUpdate")
	self:HookScript(GameTooltip, "OnHide", "GameTooltipOnHide")
end

function StopTheLagness:UnhookTooltips()
	self:Unhook("ContainerFrameItemButton_OnEnter")
	self:Unhook("ContainerFrameItemButton_OnUpdate")
	self:Unhook(GameTooltip, "OnHide")
end

function StopTheLagness:CFIB_OnEnter(button)
	if not button then button = this end
	if currentBtn ~= button then currentBtn = button end
	currentBtn._hasCooldown = GameTooltip:SetBagItem(button:GetParent():GetID(),button:GetID())
	self.hooks["ContainerFrameItemButton_OnEnter"](button)
end

function StopTheLagness:GameTooltipOnHide(obj)
	elapsed = 0
	self.hooks[obj]["OnHide"]()
end

function StopTheLagness:CFIB_OnUpdate()
	if (this ~= currentBtn) or (not currentBtn) or (not currentBtn._hasCooldown) then return end
	elapsed = elapsed + arg1
	if elapsed >= 1 then
		elapsed	= 0
		StopTheLagness:CFIB_OnEnter(currentBtn)
	end
	--Note: __NOT__ calling the hook.
end