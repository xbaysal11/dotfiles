local wezterm = require "wezterm"
local act = wezterm.action
local config = {}
local mod = {
    SUPER = "ALT",
    SUPER_CTRL = "CTRL|ALT",
    SUPER_CTRL_SHIFT = "CTRL|ALT|SHIFT"
}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config = {
    automatically_reload_config = true,
    max_fps = 180,
    front_end = "WebGpu",
    webgpu_power_preference = "HighPerformance",

    -- shell
    default_prog = {"C:\\Program Files\\Git\\bin\\bash.exe", "--login"},

    -- font
    font = wezterm.font("Fira Code", {stretch = "Normal", weight = "Regular"}),
    font_size = 8,
    cell_width = 0.8,
    adjust_window_size_when_changing_font_size = false,

    -- cursor
    animation_fps = 180,
    cursor_blink_ease_in = "EaseOut",
    cursor_blink_ease_out = "EaseOut",
    default_cursor_style = "BlinkingBar",
    cursor_blink_rate = 650,

    -- color scheme
    color_scheme = "Night Owl (Gogh)",
    colors = {
        background = "#00031e",
        tab_bar = {
            inactive_tab_edge = "#000000",
            active_tab = {
                bg_color = "#00031e",
                fg_color = "#c0c0c0"
            },
            inactive_tab = {
                bg_color = "#000000",
                fg_color = "#808080"
            },
            inactive_tab_hover = {
                bg_color = "#000000",
                fg_color = "#c0c0c0"
            },
            new_tab = {
                bg_color = "#000000",
                fg_color = "#808080"
            },
            new_tab_hover = {
                bg_color = "#000000",
                fg_color = "#c0c0c0"
            }
        }
    },

    -- scrollbar
    enable_scroll_bar = false,

    -- tab
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = false,
    use_fancy_tab_bar = true,
    tab_max_width = 80,
    show_tab_index_in_tab_bar = true,
    switch_to_last_active_tab_when_closing_tab = false,

    -- window
    window_decorations = "INTEGRATED_BUTTONS|RESIZE",
    integrated_title_button_style = "Windows",
    integrated_title_button_color = "auto",
    integrated_title_button_alignment = "Right",
    initial_cols = 200,
    initial_rows = 40,
    window_padding = {
        left = 5,
        right = 10,
        top = 12,
        bottom = 7
    },
    window_close_confirmation = "AlwaysPrompt",
    window_frame = {
        active_titlebar_bg = "#000000",
        inactive_titlebar_bg = "#000000"
    },
    window_close_confirmation = "NeverPrompt",
    inactive_pane_hsb = {saturation = 1.0, brightness = 1.0},

    -- bell
    visual_bell = {
        fade_in_function = "EaseIn",
        fade_in_duration_ms = 250,
        fade_out_function = "EaseOut",
        fade_out_duration_ms = 250,
        target = "CursorColor"
    },

    -- keys
    keys = {
        {key = "RightArrow", mods = mod.SUPER, action = act.SplitHorizontal {domain = "CurrentPaneDomain"}},
        {key = "DownArrow", mods = mod.SUPER, action = act.SplitVertical {domain = "CurrentPaneDomain"}},
        {
            key = "q",
            mods = mod.SUPER,
            action = act.CloseCurrentPane({confirm = false})
        },
        {key = "UpArrow", mods = mod.SUPER_CTRL, action = act.AdjustPaneSize({"Up", 1})},
        {key = "DownArrow", mods = mod.SUPER_CTRL, action = act.AdjustPaneSize({"Down", 1})},
        {key = "LeftArrow", mods = mod.SUPER_CTRL, action = act.AdjustPaneSize({"Left", 1})},
        {key = "RightArrow", mods = mod.SUPER_CTRL, action = act.AdjustPaneSize({"Right", 1})},
        {key = "UpArrow", mods = mod.SUPER_CTRL_SHIFT, action = act.IncreaseFontSize},
        {key = "DownArrow", mods = mod.SUPER_CTRL_SHIFT, action = act.DecreaseFontSize},
        {key = "r", mods = mod.SUPER_CTRL_SHIFT, action = act.ResetFontSize},
        {key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard")},
        {key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard")},
        {
            key = "e",
            mods = "CTRL|SHIFT",
            action = act.PromptInputLine {
                description = "Enter new name for tab",
                action = wezterm.action_callback(
                    function(window, pane, line)
                        if line then
                            window:active_tab():set_title(line)
                        end
                    end
                )
            }
        }
    }
}

function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return title
    end
    return tab_info.active_pane.title
end

wezterm.on(
    "format-tab-title",
    function(tab)
        local title = tab_title(tab)
        local last_folder = title:match(".+/([^/]+)$") or title
        return {
            {Text = last_folder}
        }
    end
)

wezterm.on(
    "gui-startup",
    function(cmd)
        local main_screen = wezterm.gui.screens().main
        local position = {
            x = main_screen.width - 1800,
            y = main_screen.height - 900,
            origin = "MainScreen"
        }

        cmd = cmd or {position = position}

        wezterm.mux.spawn_window(cmd)
    end
)

return config
