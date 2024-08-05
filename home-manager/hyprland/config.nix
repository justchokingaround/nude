{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config.colorScheme) palette;
in {
  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "XDG_SESSION_TYPE, wayland"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_DESKTOP, Hyprland"

        "GDK_BACKEND, wayland, x11"
        "SDL_VIDEODRIVER, wayland"
        "QT_QPA_PLATFORM, wayland;xcb"
      ];
      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle,caps:escape";
        repeat_delay = 300;
        repeat_rate = 50;
        natural_scroll = 0;
        force_no_accel = 1;
        numlock_by_default = 1;
      };
      general = {
        gaps_in = 8;
        gaps_out = 16;
        border_size = 3;

        "col.active_border" = lib.mkForce "rgb(${palette.base01})";
        "col.inactive_border" = lib.mkForce "rgb(${palette.base00})";

        layout = "dwindle";
        apply_sens_to_raw = 0;
        resize_on_border = 1;
      };
      xwayland = {
        force_zero_scaling = true;
      };
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;

        new_window_takes_over_fullscreen = 1;
        enable_swallow = true;
        swallow_regex = "^(foot).*$";
      };
      decoration = {
        rounding = 10;
        drop_shadow = true;
        shadow_range = 20;
        shadow_render_power = 2;
        shadow_ignore_window = true;
        "col.shadow" = lib.mkForce "rgba(${palette.base01}99)";
        "col.shadow_inactive" = lib.mkForce "rgba(${palette.base00}99)";
        shadow_offset = "0 0";
      };
      animations = {
        enabled = false;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.1";

        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 5, default, popin 80%"
          "windowsMove, 1, 5, default, popin 80%"
          "fade, 1, 5, default"
          "border, 1, 5, default"
          "borderangle, 0, 8, default"
          "workspaces, 1, 5, myBezier"
          "specialWorkspace, 1, 5, myBezier, slidevert"
        ];
      };
      dwindle = {
        no_gaps_when_only = false;
        pseudotile = false;
        force_split = 2;
        preserve_split = true;
      };
      workspace = [
        "special:music, on-created-empty:footclient spotify_player"
        "special:matrix, on-created-empty:footclient iamb"
      ];
      windowrule = [
        "pin, dragon-drop"
        "float, SVPManager"

        "tile, resolve"
        "float, title:resolve"
        "float, title:Open Folder"
      ];
      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "float, class:io.github.Qalculate.qalculate-qt"
        "size 70% 55%, class:io.github.Qalculate.qalculate-qt"
        "center, class:io.github.Qalculate.qalculate-qt"
        "float, class:quick"
        "size 80% 75%, class:quick"
        "center, class:quick"
        "size 85% 80%, class:com.gabm.satty"
        "center, class:com.gabm.satty"
        "center, class:pop"
        "tile, class:Nsxiv,xwayland:1"
        "tile, title:Neovide,class:neovide"
      ];
      layerrule = [
        "noanim, selection"
      ];
    };
    # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
    # borders-plus-plus
    # csgo-vulkan-fix
    # hyprwinwrap
    # ];
    extraConfig = ''
      plugin {
        csgo-vulkan-fix {
          res_w = 1280
          res_h = 1024
          class = cs2
        }
      }
    '';
  };
}
