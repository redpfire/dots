-- vim: ts=4 sw=4 noet ai cindent syntax=lua

--[[
Conky, a system monitor, based on torsmo
]]

conky.config = {
    out_to_x = false,
    out_to_console = true,
    short_units = true,
    update_interval = 1
}

-- http://fontawesome.io/
FontAwesome = '^fn(Font Awesome 5 Free:style=Solid:pixelsize=10)'

-- icon
preIcon  = '^fg(\\#ffffff)' .. FontAwesome
postIcon = '^fn()^fg()'

--[[
Segment
]]


conkyPre = 'conky\t^fg(\\#ffffff)'
timeIcon     = ' ' .. preIcon .. '' .. postIcon .. ' '
ssidIcon 	 = ' ' .. preIcon .. '' .. postIcon .. ' '

bat 					= '${exec cat /sys/class/power_supply/BAT1/capacity}'
charging             	= '${exec grep -c Charging /sys/class/power_supply/BAT1/status}'
batteryCharging   		= ' ' .. preIcon .. '' .. postIcon .. ' '
batteryFull 			= ' ' .. preIcon .. '' .. postIcon .. ' '
batteryThreeQuarters 	= ' ' .. preIcon .. '' .. postIcon .. ' '
batteryHalf 			= ' ' .. preIcon .. '' .. postIcon .. ' '
batteryQuarter 			= ' ' .. preIcon .. '' .. postIcon .. ' '
batteryCritical 		= ' ' .. preIcon .. '^fg(\\#ee0000)' .. '' .. postIcon .. ' '

memIcon = ' ' .. preIcon .. '' .. postIcon .. ' '

battery = [[\
${if_match ]] .. charging .. [[ == 1}\
]] .. batteryCharging .. '++' .. bat .. '%' .. [[
${else}${if_match ]] .. bat .. [[<=15}\
]] .. batteryCritical .. '++' .. bat .. '%' .. [[
${else}${if_match ]] .. bat .. [[<=25}\
]] .. batteryQuarter .. '++' .. bat .. '%' .. [[
${else}${if_match ]] .. bat .. [[<=50}\
]] .. batteryHalf .. '++' .. bat .. '%' .. [[
${else}${if_match ]] .. bat .. [[<=75}\
]] .. batteryThreeQuarters .. '++' .. bat .. '%' .. [[
${else}${if_match ]] .. bat .. [[>75}\
]] .. batteryFull .. '++' .. bat .. '%' .. [[
${endif}${endif}${endif}${endif}${endif}${endif}\
]]

ssidText = ssidIcon .. '${wireless_essid wlp0s20f3}'

memText = memIcon .. ' ${mem}/${memmax}'

--[[
Execute Conky
]]

conky.text = [[\
]] .. conkyPre .. [[\
 \
]] .. '[${battery_short}]' .. [[\
 \
]] .. battery .. [[\
 \
]] .. memText .. [[\
 \
]] .. ssidText .. [[\
 \
]] .. timeIcon ..[[\
]]
