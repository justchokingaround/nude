{
  lib,
  fetchFromGitHub,
  pkgs,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  pname = "kew";
  version = "2.6.0";

  src = fetchFromGitHub {
    owner = "ravachol";
    repo = "kew";
    rev = "v${version}";
    hash = "";
  };

  nativeBuildInputs = with pkgs; [pkg-config];
  buildInputs = with pkgs; [ffmpeg freeimage fftwFloat chafa glib];

  installFlags = [
    "MAN_DIR=${placeholder "out"}/share/man"
    "PREFIX=${placeholder "out"}"
  ];

  meta = with lib; {
    description = "Command-line music player for Linux";
    homepage = "https://github.com/ravachol/kew";
    platforms = platforms.linux;
    license = licenses.gpl2Only;
    maintainers = with maintainers; [demine];
    mainProgram = "kew";
  };
}
