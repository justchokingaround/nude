{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.modules.boot;
in {
  options = {
    modules.boot = {
      windows_entry = mkEnableOption "Whether to add a Windows entry or not";
    };
  };

  config = {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 3;
        };
        # timeout = 0;
        # systemd-boot = {
        #   enable = true;
        #   consoleMode = "auto";
        #   configurationLimit = 3;
        #   extraInstallCommands = mkIf cfg.windows_entry "printf 'auto-entries false' >> /boot/loader/loader.conf";
        #   extraEntries = mkIf cfg.windows_entry {
        #     "windows.conf" = ''
        #       title Windows
        #       efi /EFI/Microsoft/Boot/bootmgfw.efi
        #     '';
        #   };
        # };
        efi.canTouchEfiVariables = true;
      };
      # kernelParams = ["quiet"];
    };
  };
}
