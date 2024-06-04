{config, ...}: let
  inherit (config.programs.hyprland) scripts;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "swww kill ; swww init"
      "swww img ~/nude/modules/shared/wallpapers/nix.png --transition-type random --transition-step 5 --transition-fps 165"
      "vesktop"
      "[workspace 2] schizofox"
      "${scripts.socket}"
    ];
  };
}
