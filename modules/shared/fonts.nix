{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation {
  pname = "fonts";
  version = "2";

  src = fetchzip {
    url = "https://github.com/justchokingaround/fonts/archive/refs/tags/2.zip";
    stripRoot = false;
    hash = "sha256-Xr1GkfobeVZ936ctPVtO9G6/wjpCyzrphByUM1fbuGI=";
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    install -Dm444 fonts-2/* $out/share/fonts/
  '';
  meta = with lib; {
    description = "my fonts";
    homepage = "http://github.com/justchokingaround/fonts";
    platforms = platforms.unix;
    maintainers = with maintainers; [justchokingaround];
  };
}
