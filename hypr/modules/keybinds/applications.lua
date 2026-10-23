local vars = require("modules.core.vars")
local mod = vars.main_mod

hl.bind(mod .. " + T", hl.dsp.exec_cmd(vars.terminal))
hl.bind(mod .. " + W", hl.dsp.exec_cmd(vars.browser))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(vars.file_manager))
