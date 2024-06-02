{
  stdenv,
  fetchFromGitHub,
  gtk3,
  jdupes,
  ...
}:
stdenv.mkDerivation {
  pname = "win11-icon-theme";
  version = "2023-05-13";

  src = fetchFromGitHub {
    owner = "yeyushengfan258";
    repo = "Win11-icon-theme";
    rev = "9c69f73b00fdaadab946d0466430a94c3e53ff68";
    hash = "sha256-jN55je9BPHNZi5+t3IoJoslAzphngYFbbYIbG/d7NeU=";
  };

  buildInputs = [gtk3 jdupes];

  dontDropIconThemeCache = true;

  # These fixup steps are slow and unnecessary for this package
  dontPatchELF = true;
  dontRewriteSymlinks = true;

  postPatch = ''
    patchShebangs install.sh
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons

    # Run the install script
    ./install.sh -n win11 -a -d $out/share/icons

    # replace duplicate files with symlinks
    jdupes --quiet --link-soft --recurse $out/share

    runHook postInstall
  '';
}
