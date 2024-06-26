{
  customPkgs,
  inputs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib) mkDefault;
  inherit (osConfig) values;
in {
  imports = [
    ./hyprland
    ./anyrun
    ./btop.nix
    ./mpv
    # ./lazyvim
    ./neovim-flake
    ./zsh

    ./ags.nix
    ./zathura.nix
    ./bat.nix
    ./xdg.nix
    ./foot.nix
    ./schizofox.nix
    ./git.nix
    ./bash.nix
    ./imv.nix
    # ./nixvim.nix
    ./vscode.nix
    # ./helix.nix
    ./yazi.nix
    ./starship.nix
    # ./spicetify.nix
    ./zoxide.nix
    ./wlogout.nix
    ./jerry.nix
    ./lobster.nix
    ./direnv.nix
    ./mako.nix
    ./tmux.nix
    # ./walker.nix
    ./rofi.nix

    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.oxocarbon-dark;
  home = {
    username = "${values.mainUser}";
    homeDirectory = "/home/${values.mainUser}";
    stateVersion = mkDefault "23.11";
  };

  gtk = {
    enable = true;
    theme = {
      name = lib.mkForce "phocus";
      package = lib.mkForce customPkgs.phocus-oxocarbon;
    };
    iconTheme = {
      name = "win11-dark";
      package = customPkgs.win11-icon-theme;
    };
  };
}
