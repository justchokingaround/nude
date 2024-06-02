{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation {
  pname = "fonts";
  version = "1";

  src = fetchzip {
    url = "https://github.com/justchokingaround/fonts/archive/refs/tags/1.zip";
    stripRoot = false;
    hash = "sha256-TEpB9LiGy4XkGjXsOsjhJQDrPHOuSs33XODPZ+I5IfM=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    install -Dm444 fonts-1/* $out/share/fonts/
  '';
  meta = with lib; {
    description = "my fonts";
    homepage = "http://github.com/justchokingaround/fonts";
    platforms = platforms.unix;
    maintainers = with maintainers; [justchokingaround];
  };
}
