{
  flakePkgs,
  config,
  ...
}: {
  home.packages = [
    (flakePkgs.lobster.lobster.override {mpv = config.programs.mpv.package;})
  ];
}
