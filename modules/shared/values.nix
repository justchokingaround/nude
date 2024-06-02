{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.values = {
    mainUser = mkOption {
      description = "The name of the main user";
      type = types.str;
      default = "chomsky";
    };
    terminal = mkOption {
      description = "The terminal command to run";
      type = types.str;
      default = "foot";
    };
  };
}
