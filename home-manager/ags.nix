{pkgs, ...}: {
  home.packages = [
    pkgs.bun # Requirement for typescript ;)
    pkgs.material-symbols # Generalized symbols for all sorts of display ;)
    pkgs.ags
    pkgs.libsoup_3
  ];
}
