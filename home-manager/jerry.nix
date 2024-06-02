{
  flakePkgs,
  config,
  ...
}: {
  home.packages = [
    (flakePkgs.jerry.jerry.override {mpv = config.programs.mpv.package;})
  ];
}
