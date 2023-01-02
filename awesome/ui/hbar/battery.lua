
-- █▄▄ ▄▀█ ▀█▀ ▀█▀ █▀▀ █▀█ █▄█ 
-- █▄█ █▀█ ░█░ ░█░ ██▄ █▀▄ ░█░ 

local wibox     = require("wibox")
local beautiful = require("beautiful")
local colorize  = require("helpers.ui").colorize_text

local charging_color  = beautiful.wibar_bat_grn
local low_color       = beautiful.wibar_bat_red
local normal_color    = beautiful.wibar_bat_nrml

local percentage = wibox.widget({
  markup  = "50%",
  align   = "center",
  valign  = "center",
  font    = beautiful.font_name .. "10",
  widget  = wibox.widget.textbox,
})

require("signal.battery")

awesome.connect_signal("signal::battery", function(value, state)
  local last_value = value

  local percent_color
  if state == 1 then
		percent_color = charging_color
	elseif last_value <= 20 then
    percent_color = low_color
  else
    percent_color = normal_color
  end

  percentage:set_markup(colorize(math.floor(value) .. "%", percent_color))
end)

return percentage
