{config, ...}: let
  inherit (config) values;
in {
  imports = [./hardware.nix];

  modules = {
    boot.windows_entry = true;
  };

  home-manager.users.${values.mainUser} = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "DP-2, 2560x1440@165, 1920x0, 1"
        "HDMI-A-1, 1920x1080@144, 0x0, 1"
      ];
      workspace = [
        "1, monitor:HDMI-A-1, default:true"
        "2, monitor:DP-2"
        "3, monitor:DP-2"
        "4, monitor:DP-2"
        "5, monitor:DP-2"
        "6, monitor:DP-2"
        "7, monitor:DP-2"
        "8, monitor:DP-2"
        "9, monitor:DP-2"
      ];
      windowrule = [
        "workspace 1, vesktop"
      ];
      exec-once = ["vesktop"];
    };
  };

  networking.networkmanager.enable = true;
  networking.hostName = "${values.mainUser}";
  boot.tmp.useTmpfs = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
