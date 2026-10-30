--
-- HYPRLAND CONFIGURATION
--
local catpuccin = require "macchiato"


-- Monitors
local monitorR = "HDMI-A-1"
local monitorL = "HDMI-A-2"

hl.monitor({
	output = monitorR,
	mode = "2560x1440@60",
	position = "0x0",
	scale = 1,
	bitdepth = 10
})

hl.monitor({
	output = monitorL,
	mode = "2560x1440@60",
	position = "auto-left",
	scale = 1,
	bitdepth = 10
})


-- MY Programs
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "yofi"
local webBrowser = "zen"

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("quickshell")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("swaync")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

-- Environment Variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("XDG_MENU_PREFIX", "plasma- kbuildsyscoca6")


-- Look and feel
hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 16,
		border_size = 3,
		col = {
			active_border = { colors = { catpuccin.sky, catpuccin.sapphire }, angle = 34 },
			inactive_border = catpuccin.subtext0,
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding         = 8,
		rounding_power   = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity   = 1.0,
		inactive_opacity = 1.0,

		shadow           = {
			enabled      = true,
			range        = 4,
			render_power = 3,
			color        = catpuccin.surface1,
		},

		blur             = {
			enabled  = true,
			size     = 3,
			passes   = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Animations
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Layouts
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

-- Misc
hl.config({
	misc = {
		-- force_default_Wallpaper = -1,
		-- display_hyprland_logo = true,
		session_lock_xray = true,
		initial_workspace_tracking = 1,
	}
})

-- Input
hl.config({
	input = {
		kb_layout          = "us",
		kb_variant         = "altgr-intl",
		kb_model           = "",
		kb_options         = "compose:ralt",
		kb_rules           = "",
		numlock_by_default = true,

		follow_mouse       = 1,

		sensitivity        = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad           = {
			natural_scroll = false,
		},
	},
})

-- Keybindings
local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(webBrowser))
-- hl.bind("CTRL + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())       --({ action = "toggle" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))

-- move focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- move windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- switch between workspaces
-- move windows to workspace
for i = 1, 20 do
	local key = i == 20 and 10 or i % 10
	local modifier = (i <= 10) and "" or "F"
	hl.bind(mainMod .. " + " .. modifier .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. modifier .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Windows and workspaces
for i = 1, 10 do
	hl.workspace_rule({ workspace = tostring(i), monitor = monitorR })
end
for i = 11, 20 do
	hl.workspace_rule({ workspace = tostring(i), monitor = monitorL })
end

-- Window rules
hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name           = "suppress-maximize-events",
	match          = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name     = "fix-xwayland-drags",
	match    = {
		class      = "^$",
		title      = "^$",
		xwayland   = true,
		float      = true,
		fullscreen = false,
		pin        = false,
	},
	no_focus = true,
})

hl.window_rule({ name = "NoMachine", match = { title = "NoMachine" }, workspace = "20" })
hl.window_rule({ name = "MSTeams", match = { title = "^.*Teams" }, workspace = "2" })
hl.window_rule({ name = "MSTeamsStartup", match = { title = "^Waiting for network.+$" }, workspace = "2" })
hl.window_rule({ name = "Discord", match = { title = "Discord" }, workspace = "10" })
hl.window_rule({ name = "Cider", match = { title = "Cider" }, workspace = "10" })

hl.window_rule({ name = "HyprlandPlaceholder", match = { title = "HyprlandPlaceholder" }, opacity = "0.1", no_blur = true })

hl.window_rule({ name = "ActiveFullscreen", match = { fullscreen = true, focus = true }, border_color = catpuccin.red })
hl.window_rule({
	name = "InactiveFullscreen",
	match = { fullscreen = true, focus = false },
	border_color = catpuccin
			.peach
})
