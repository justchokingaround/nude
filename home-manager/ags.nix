{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.bun # Requirement for typescript ;)
    pkgs.material-symbols # Generalized symbols for all sorts of display ;)
  ];

  programs.ags = {
    enable = true;
    configDir = inputs.ags-env;
    extraPackages = [pkgs.libsoup_3];
  };
}
