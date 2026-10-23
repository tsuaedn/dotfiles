local vars = require("modules.core.vars")
local mod = vars.main_mod

-- Focus Navigation
hl.bind(mod .. " + h", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))

-- Workspace Navigation
for i = 1, 10 do
    local key = i % 10

    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special Workspace
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("spw1"))
hl.bind(mod .. " + ALT + S", hl.dsp.window.move({ workspace = "special:spw1" }))

-- Window Actions
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Window State
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + D", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Layout Controls
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + O", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + bracketleft", hl.dsp.layout("splitratio -0.1"), { repeating = true })
hl.bind(mod .. " + bracketright", hl.dsp.layout("splitratio +0.1"), { repeating = true })
