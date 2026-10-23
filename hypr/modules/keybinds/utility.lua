local vars = require("modules.core.vars")
local mod = vars.main_mod

hl.bind(mod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))                             -- Color Picker
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy')) -- Screenshots
