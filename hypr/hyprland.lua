local modules = {
    "modules.core.vars",
    "modules.core.env",
    "modules.core.autostart",

    "modules.hardware.monitors",
    "modules.hardware.keyboard",
    "modules.hardware.touchpad",
    "modules.hardware.mouse",
}


local function report(msg)
    print(msg)
end

for _, name in ipairs(modules) do
    local ok, err = pcall(require, name)
    if not ok then
        report("Failed to load " .. name .. ": " .. tostring(err))
    end
end
