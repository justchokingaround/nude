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
    base16Scheme = {
      base00 = "#161616";
      base01 = "#262626";
      base02 = "#393939";
      base03 = "#525252";
      base04 = "#dde1e6";
      base05 = "#f2f4f8";
      base06 = "#ffffff";
      base07 = "#08bdba";
      base08 = "#3ddbd9";
      base09 = "#78a9ff";
      base0A = "#ee5396";
      base0B = "#33b1ff";
      base0C = "#ff7eb6";
      base0D = "#42be65";
      base0E = "#be95ff";
      base0F = "#82cfff";
    };
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
        package = pkgs.iosevka-comfy.comfy;
        name = "Iosevka Comfy";
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
