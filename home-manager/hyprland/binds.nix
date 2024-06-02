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
      "${mod}, Return, exec, ${terminal}"
      "${alt}, Return, exec, ${terminal}"
      "${mod}, n, exec, neovide"
      "${mod}, b, exec, schizofox"
      "${mod}, c, killactive"
      "${mod}${secondary}, c, exec, kill -9 $(hyprctl -j activewindow | ${getExe pkgs.jq} -r '.pid')"
      "${mod}${ctrl}${secondary}, m, exit"

      "${mod}, Space, exec, anyrun"
      "${mod}, x, exec, wlogout --show-binds"
      # TODO: cliphist

      "${mod}, m, exec, ${terminal} pulsemixer"
      "${mod}, q, exec, ${terminal} -- qalc"
      "${mod}, e, exec, ${terminal} -- yazi"
      "${mod}, g, exec, ${scripts.rofiGpt}"
      "${mod}${secondary}, e, exec, nautilus"
      "${mod}${shift}, x, exec, hyprpicker"

      ", Print, exec, grimblast --notify copy output"
      "${shift}, Print, exec, grimblast --notify --freeze copy area"
      "${alt}, Print, exec, grimblast --notify copy active"

      ", XF86AudioPrev, exec, ${playerctl} previous"
      ", XF86AudioNext, exec, ${playerctl} next"
      # The stop function is pretty much useless, use it to restart the playing media instead
      ", XF86AudioStop, exec, ${playerctl} position 0"
      ", XF86AudioPlay, exec, ${playerctl} play-pause"

      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

      "${mod}, h, movefocus, l"
      "${mod}, j, movefocus, d"
      "${mod}, k, movefocus, u"
      "${mod}, l, movefocus, r"

      "${mod}${shift}, h, movewindow, l"
      "${mod}${shift}, j, movewindow, d"
      "${mod}${shift}, k, movewindow, u"
      "${mod}${shift}, l, movewindow, r"

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

      "${mod}${shift}, 1, movetoworkspacesilent, 1"
      "${mod}${shift}, 2, movetoworkspacesilent, 2"
      "${mod}${shift}, 3, movetoworkspacesilent, 3"
      "${mod}${shift}, 4, movetoworkspacesilent, 4"
      "${mod}${shift}, 5, movetoworkspacesilent, 5"
      "${mod}${shift}, 6, movetoworkspacesilent, 6"
      "${mod}${shift}, 7, movetoworkspacesilent, 7"
      "${mod}${shift}, 8, movetoworkspacesilent, 8"
      "${mod}${shift}, 9, movetoworkspacesilent, 9"

      "${mod}, 49, togglegroup,"
      "${mod}, tab, changegroupactive,"

      "${mod}, v, togglefloating"
      "${mod}, p, exec, ${scripts.pin}"
      "${mod}, f, fullscreen, 1"
      "${mod}${shift}, f, fullscreen, 0"
    ];
    binde = [
      "${mod}${ctrl}, h, resizeactive, -50 0"
      "${mod}${ctrl}, j, resizeactive, 0 50"
      "${mod}${ctrl}, k, resizeactive, 0 -50"
      "${mod}${ctrl}, l, resizeactive, 50 0"

      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];
    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];
  };
}
