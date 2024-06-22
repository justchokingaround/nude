{
  inputs,
  lib,
  config,
  flakePkgs,
  pkgs,
  ...
}: let
  inherit (pkgs) writeShellScript;
  inherit (inputs.nix-gaming.nixosModules) pipewireLowLatency platformOptimizations;

  hyprctl = "'${lib.getExe' flakePkgs.hyprland.default "hyprctl"}' -i 0";
  powerprofilesctl = lib.getExe pkgs.power-profiles-daemon;
  notify-send = lib.getExe pkgs.libnotify;

  startScript = writeShellScript "gamemode-start" ''
    ${hyprctl} --batch "\
      keyword animations:enabled false;\
      keyword decoration:blur:enabled false;\
      keyword decoration:drop_shadow false;\
      keyword misc:vfr false;\
      keyword general:allow_tearing true;\
      keyword input:scroll_method '''"
    ${powerprofilesctl} set performance
    ${notify-send} -u low -a 'Gamemode' 'Optimizations activated'
  '';
  endScript = writeShellScript "gamemode-end" ''
    ${hyprctl} reload
    ${powerprofilesctl} set balanced
    ${notify-send} -u low -a 'Gamemode' 'Optimizations deactivated'
  '';

  cfg = config.modules.gaming;
in {
  imports = [
    pipewireLowLatency
    platformOptimizations
  ];

  options = {
    modules.gaming = {
      enable = lib.mkEnableOption "Enable the gaming module";
    };
  };

  config = lib.mkIf cfg.enable {
    services.pipewire.lowLatency.enable = true;
    services.pipewire.alsa.support32Bit = true;
    security.rtkit.enable = true;
    hardware.xpadneo.enable = true;
    hardware.opengl.driSupport32Bit = true;

    programs = {
      steam = {
        enable = true;
        platformOptimizations.enable = true;
        gamescopeSession.enable = true;

        protontricks.enable = true;
        extraCompatPackages = [pkgs.proton-ge-bin];
      };

      gamescope = {
        enable = true;
        capSysNice = true;
      };

      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          general = {
            renice = 15;
            softrealtime = "auto";
          };

          custom = {
            start = startScript.outPath;
            end = endScript.outPath;
          };
        };
      };
    };
  };
}
