{config, ...}: let
  inherit (config.programs.hyprland) scripts;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "pgrep waybar || waybar &"
      "foot --server &"
      "swww-daemon --format xrgb"
      "wl-paste --type text --watch cliphist store &"
      "wl-paste --type image --watch cliphist store &"
      "[workspace 2] schizofox"
      # "${scripts.socket}"
    ];
  };
}
