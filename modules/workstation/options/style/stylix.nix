{
  pkgs,
  inputs,
  ...
}: let
  fonts = pkgs.callPackage ../../../shared/fonts.nix {};
in {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    polarity = "dark";
    image = ../../../shared/wallpapers/oxocarbon.png;
    base16Scheme = inputs.nix-colors.colorSchemes.oxocarbon-dark;
    fonts = {
      serif = {
        package = fonts;
        name = "Google Sans";
      };
      sansSerif = {
        package = fonts;
        name = "Google Sans";
      };
      monospace = {
        # package = pkgs.iosevka-comfy.comfy;
        package = fonts;
        name = "Martian Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 12;
        popups = 14;
        terminal = 16;
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 22;
    };
  };
}
