--[[ default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/ ]]

hl.curve("easeOutQuint", {
	type = "bezier",
	points = { {0.16, 1}, {0.3, 1} } 
})

hl.curve("easeInOutCubic", {
	type = "bezier",
	points = { {0.65, 0}, {0.35, 1} }
})

hl.curve("linear", {
	type = "bezier",
	points = { {0, 0}, {1, 1} }
})

hl.curve("almostLinear", {
	type = "bezier",
	points = { {0.45, 0.45}, {0.8, 1} }
})

hl.curve("quick", {
	type = "bezier",
	points = { {0.12, 0}, {0.05, 1} }
})

--[[ default springs ]]
hl.curve("easy", {
	type = "spring",
	mass = 0.8,
	stiffness = 120,
	dampening = 14
})

hl.animation({
	leaf = "global",
	enabled = true,
	speed = 12,
	bezier = "default"
})

hl.animation({
	leaf = "border",
	enabled = true,
	speed = 8,
	bezier = "easeOutQuint"
})

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 7.5,
	spring = "easy"
})

hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 6.5,
	spring = "easy",
	style = "popin 92%"
})

hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 4,
	bezier = "quick",
	style = "popin 92%"
})

hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 3,
	bezier = "quick"
})

hl.animation({
	leaf = "fadeOut",
	enabled = true,
	speed = 2.5,
	bezier = "quick"
})

hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 5,
	bezier = "quick"
})

hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 6,
	bezier = "easeOutQuint"
})

hl.animation({
	leaf = "layersIn",
	enabled = true,
	speed = 5,
	bezier = "easeOutQuint",
	style = "fade"
})

hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 3,
	bezier = "quick",
	style = "fade"
})

hl.animation({
	leaf = "fadeLayersIn",
	enabled = true,
	speed = 3,
	bezier = "quick"
})

hl.animation({
	leaf = "fadeLayersOut",
	enabled = true,
	speed = 2,
	bezier = "quick"
})

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 4.5,
	bezier = "quick",
	style = "slidefade"
})

hl.animation({
	leaf = "workspacesIn",
	enabled = true,
	speed = 4,
	bezier = "quick",
	style = "slidefade"
})

hl.animation({
	leaf = "workspacesOut",
	enabled = true,
	speed = 4,
	bezier = "quick",
	style = "slidefade"
})

hl.animation({
	leaf = "zoomFactor",
	enabled = true,
	speed = 8,
	bezier = "quick"
})
