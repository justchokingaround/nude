{config, ...}: let
  inherit (config.colorScheme) palette;
in {
  stylix.targets.zathura.enable = false;
  programs.zathura = {
    enable = true;
    options = {
      smooth-scroll = true;
      selection-clipboard = "clipboard";
      recolor = "true";
      recolor-keephue = "true";
      font = "Liga SFMono Nerd Font 16";
      completion-bg = "#${palette.base02}";
      completion-fg = "#${palette.base0C}";
      completion-highlight-bg = "#${palette.base0C}";
      completion-highlight-fg = "#${palette.base02}";
      default-bg = "#${palette.base00}";
      default-fg = "#${palette.base01}";
      highlight-active-color = "#${palette.base0D}";
      highlight-color = "#${palette.base0A}";
      index-active-bg = "#${palette.base0D}";
      inputbar-bg = "#${palette.base00}";
      inputbar-fg = "#${palette.base05}";
      notification-bg = "#${palette.base0B}";
      notification-error-bg = "#${palette.base08}";
      notification-error-fg = "#${palette.base00}";
      notification-fg = "#${palette.base00}";
      notification-warning-bg = "#${palette.base08}";
      notification-warning-fg = "#${palette.base00}";
      recolor-darkcolor = "#${palette.base06}";
      recolor-lightcolor = "#${palette.base00}";
      statusbar-bg = "#${palette.base01}";
    };
    mappings = {
      h = "feedkeys '<C-Left>'";
      j = "feedkeys '<C-Down>'";
      k = "feedkeys '<C-Up>'";
      l = "feedkeys '<C-Right>'";
      i = "recolor";
      "[fullscreen] i" = "recolor";
      f = "toggle_fullscreen";
      "[fullscreen] f" = "toggle_fullscreen";
    };
  };
}
