--[[ simpleMinimap localization file ]]--

-- english defaults
sm_HELP = {
  "/smm show X :: show button / feature X",
  "/smm hide X :: hide button / feature X",
  " >> X = 'bgs', 'mail', 'meet', 'location', 'movers', 'pings', 'time', 'track', or 'zoom'",
  "/smm alpha N :: set minimap alpha to N (0~1)",
  "/smm scale N :: set minimap scale to N (>0)",
  "/smm lock :: lock minimap movement and hide movers",
  "/smm skin :: cycle to next minimap skin",
  "/smm reset :: reset minimap to defaults",
}
BINDING_HEADER_smm_TITLE = "simpleMinimap"
BINDING_NAME_smm_TOGGLE = "Show / Hide Minimap"

-- chinese localization
if ( GetLocale() == "zhCN" ) then
  sm_HELP = {
  "/smm show X :: 显示按钮 / 特征 X",
  "/smm hide X :: 隐藏按钮 / 特征 X",
  " >> X = '战场', '邮件', '集合石', '地址栏', '移动', '标记', '时间', '追踪', 或 '缩放'",
  "/smm alpha N :: 设置迷你地图透明度 N可取(0~1)",
  "/smm scale N :: 设置迷你地图尺度 N可取(>0)",
  "/smm lock :: 锁定/解锁迷你地图和按钮位置",
  "/smm skin :: 切换小地图的样式",
  "/smm reset :: 恢复默认设置",
  }
end
