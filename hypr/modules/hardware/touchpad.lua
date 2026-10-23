hl.config({
    input = {
        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            clickfinger_behavior = true,
        },
    },
})

hl.device({
    name = "asue1a04:00-04f3:32cd-touchpad",
    sensitivity = 0.5,
})

-- Gestures
hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "workspace",
})

hl.gesture({
    fingers = 3,
    direction = "swipe",
    action = "move",
})

hl.gesture({
    fingers = 3,
    direction = "pinch",
    action = "cursorZoom",
    zoom_level = 1,
    mode = "live",
})
