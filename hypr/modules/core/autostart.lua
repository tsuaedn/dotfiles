hl.on("hyprland.start", function()
    -- Quickshell
    hl.exec_cmd("qs -p ~/.config/quickshell/")

    -- Clipboard Services
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
