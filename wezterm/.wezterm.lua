local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Gruvbox Material (Gogh)"
config.font_size = 11
-- config.font = wezterm.font 'JetBrainsMono NF'
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"Symbols Nerd Font Mono",
})

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false

config.window_padding = {
	left = 2,
	right = 2,
	top = 1,
	bottom = 1,
}

config.window_background_opacity = 0.95
-- config.window_background_opacity = 0.3
config.macos_window_background_blur = 20

return config
