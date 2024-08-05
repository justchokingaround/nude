{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
  inherit (config.programs.hyprland) scripts;

  mod = "SUPER";
  ctrl = "CONTROL";
  alt = "ALT";
  shift = "SHIFT";
  secondary = "ALT";

  playerctl = "${getExe pkgs.playerctl}";

  inherit (osConfig.values) terminal;
in {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "${mod}, Return, exec, wezterm"
      "${mod}, d, exec, cool-retro-term"
      "${alt}, Return, exec, ${terminal}"
      "${mod}, n, exec, neovide"
      "${mod}, b, exec, schizofox"
      "${mod}, c, killactive"
      "${mod}${secondary}, c, exec, kill -9 $(hyprctl -j activewindow | ${getExe pkgs.jq} -r '.pid')"
      "${mod}${ctrl}${secondary}, m, exit"
      "${mod}${ctrl}${secondary}, b, exec, sh ~/.mye"

      "${mod}, Space, exec, pkill rofi || rofi -show drun"
      "${mod}${shift}, w, exec, rofi -theme preview -show filebrowser -selected-row 1"
      "${mod}, x, exec, wlogout --show-binds"
      "${mod}${shift}, v, exec, ${scripts.clipShow}"

      "${shift}${mod}, m, exec, ${terminal} -a quick pulsemixer"
      "${mod}, m, exec, lobster -i --rofi"
      # "${mod}, q, exec, ${terminal} -a quick -- qalc"
      "${mod}, q, exec, rofi -show calc -modi calc -no-show-math -no-sort -calc-command 'echo '{result}' | wl-copy'"
      "${mod}, e, exec, ${terminal} -- yazi"
      "${mod}, g, exec, ${scripts.rofiGpt}"
      "${mod}${secondary}, e, exec, nautilus"
      "${mod}${shift}, x, exec, hyprpicker"

      "${mod}, h, movefocus, l"
      "${mod}, j, movefocus, d"
      "${mod}, k, movefocus, u"
      "${mod}, l, movefocus, r"

      "${mod}, 1, workspace, 1"
      "${mod}, 2, workspace, 2"
      "${mod}, 3, workspace, 3"
      "${mod}, 4, workspace, 4"
      "${mod}, 5, workspace, 5"
      "${mod}, 6, workspace, 6"
      "${mod}, 7, workspace, 7"
      "${mod}, 8, workspace, 8"
      "${mod}, 9, workspace, 9"
      "${mod}, s, togglespecialworkspace,"
      "${mod}${shift}, 1, togglespecialworkspace, matrix"
      "${mod}${shift}, 2, togglespecialworkspace, music"

      "${alt}, 1, movetoworkspace, 1"
      "${alt}, 2, movetoworkspace, 2"
      "${alt}, 3, movetoworkspace, 3"
      "${alt}, 4, movetoworkspace, 4"
      "${alt}, 5, movetoworkspace, 5"
      "${alt}, 6, movetoworkspace, 6"
      "${alt}, 7, movetoworkspace, 7"
      "${alt}, 8, movetoworkspace, 8"
      "${alt}, 9, movetoworkspace, 9"
      "${alt}, s, movetoworkspace, special"
      "${mod}${ctrl}, 1, movetoworkspacesilent, special:matrix"
      "${mod}${ctrl}, 2, movetoworkspacesilent, special:music"

      # "${mod}, 49, togglegroup,"
      # "${mod}, tab, changegroupactive,"
      "${mod}, Tab, cyclenext,"
      "${mod}, Tab, bringactivetotop,"

      "${mod}, v, togglefloating"
      "${mod}, f, fullscreen, 1"
      "${mod}${shift}, f, fullscreen, 0"
    ];
    # bindr = ["SUPER, SUPER_L, exec, pkill rofi || rofi -show drun"];
    binde = [
      "${mod}${ctrl}, h, resizeactive, -50 0"
      "${mod}${ctrl}, j, resizeactive, 0 50"
      "${mod}${ctrl}, k, resizeactive, 0 -50"
      "${mod}${ctrl}, l, resizeactive, 50 0"

      "${mod}${shift}, h, movewindow, l"
      "${mod}${shift}, j, movewindow, d"
      "${mod}${shift}, k, movewindow, u"
      "${mod}${shift}, l, movewindow, r"
    ];
    bindel = [
      ", Print, exec, grimblast --notify copy output"
      "${shift}, Print, exec, grimblast --notify --freeze copy area"
      "${alt}, Print, exec, grimblast --notify copy active"
      "${mod}, Print, exec, grimblast --notify edit area"

      ", XF86AudioPrev, exec, ${playerctl} previous"
      ", XF86AudioNext, exec, ${playerctl} next"
      ", XF86AudioStop, exec, ${playerctl} position 0"
      ", XF86AudioPlay, exec, ${playerctl} play-pause"

      "${mod}${shift}, d, exec, ${playerctl} next --player=spotify_player"
      "${mod}${shift}, a, exec, ${playerctl} previous --player=spotify_player"
      "${mod}${shift}, s, exec, ${playerctl} play-pause --player=spotify_player"

      ",XF86AudioRaiseVolume, exec, pulsemixer --change-volume +5"
      ",XF86AudioLowerVolume, exec, pulsemixer --change-volume -5"
    ];
    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];
  };
}
