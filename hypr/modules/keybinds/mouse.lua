local vars = require("modules.core.vars")
local mod = vars.main_mod

-- Workspace Navigation
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Window Manipulation
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Side Button Workspace Shortcuts
hl.bind("mouse:275", hl.dsp.focus({ workspace = 1 }), { mouse = true })
hl.bind("mouse:276", hl.dsp.focus({ workspace = 2 }), { mouse = true })
