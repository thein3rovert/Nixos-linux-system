{ config, ... }:
{
  programs.kitty = {
    enable = true;
    # Use Kitty's built-in theme system,
    # to view enter "kitten themes" in the terminal
    theme = "Catppuccin-Mocha";

    settings = {
      # Non-color settings
      repaint_delay = "60";
      sync_to_monitor = "yes";
      background_opacity = "1.0";
      background_blur = "1";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      font_family = "JetbrainsMono Nerd Font";
      bold_font = "auto";
      italic_font = "JetBrainsMono NFM Italic";
      bold_italic_font = "JetBrainsMono NFM Bold Italic";
      font_size = "10.0";
      cursor_shape = "beam";
      cursor_beam_thickness = "0.5";
      cursor_blink_interval = "0.5";
      strip_trailing_spaces = "always";
      update_check_interval = "0";
    };
  };
}
