-- Animation Curves

-- Easing Curves
hl.curve("easeOutQuint", {
    type = "bezier",
    points = { { 0.23, 1 }, { 0.32, 1 } },
})

hl.curve("easeInOutCubic", {
    type = "bezier",
    points = { { 0.65, 0.05 }, { 0.36, 1 } },
})

hl.curve("linear", {
    type = "bezier",
    points = { { 0, 0 }, { 1, 1 } },
})

hl.curve("almostLinear", {
    type = "bezier",
    points = { { 0.5, 0.5 }, { 0.75, 1 } },
})

hl.curve("quick", {
    type = "bezier",
    points = { { 0.15, 0 }, { 0.1, 1 } },
})

-- Spring Curves
hl.curve("easy", {
    type = "spring",
    mass = 1,
    stiffness = 71.2633,
    dampening = 15.8273644,
})


-- Global & Window Animations

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 2,
    bezier = "default",
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5.39,
    bezier = "easeOutQuint",
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 1,
    spring = "easy",
})

hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 1,
    spring = "easy",
    style = "popin 87%",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1,
    bezier = "linear",
    style = "popin 87%",
})


-- Fade Animations

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 1,
    bezier = "quick",
})

hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.73,
    bezier = "almostLinear",
})

hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.46,
    bezier = "almostLinear",
})


-- Layer Animations

hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 1.81,
    bezier = "easeOutQuint",
})

hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 1,
    bezier = "easeOutQuint",
    style = "fade",
})

hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1,
    bezier = "linear",
    style = "fade",
})

hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 1,
    bezier = "almostLinear",
})

hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 1,
    bezier = "almostLinear",
})


-- Workspace Animations

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 1,
    bezier = "almostLinear",
    style = "fade",
})

hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 1,
    bezier = "quick",
    style = "slide",
})

hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 1.94,
    bezier = "quick",
    style = "slide",
})


-- Zoom Animations

hl.animation({
    leaf = "zoomFactor",
    enabled = true,
    speed = 7,
    bezier = "quick",
})
