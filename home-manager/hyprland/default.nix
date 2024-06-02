{
  inputs,
  system,
  flakePkgs,
  pkgs,
  ...
}: let
  inherit (inputs) hyprland;
in {
  imports = [
    hyprland.homeManagerModules.default

    ./config.nix
    ./binds.nix
    ./exec.nix
    ./scripts.nix
  ];

  home.packages = [
    flakePkgs.hyprwm-contrib.grimblast
    pkgs.hyprpicker
    pkgs.swww
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland.packages.${system}.default;

    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };

  xdg.configFile."hypr/hyprland.conf".onChange = "hyprctl reload";
}
