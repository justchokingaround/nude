{
  lib,
  fetchFromGitHub,
  buildLua,
}:
buildLua rec {
  pname = "SimpleUndo";
  version = "25-09-2023";

  src = fetchFromGitHub {
    owner = "Eisa01";
    repo = "mpv-scripts";
    rev = version;
    hash = "sha256-tChANE37jKX2IMF3TC1QIBeDqZeCJ7Cf7LxKFXeS2dg=";
  };
  # TODO: figure out what this does
  # passthru.updateScript = gitUpdate/unstableGitUpdater {};

  scriptPath = "scripts/${pname}.lua";

  meta = with lib; {
    description = "Accidentally seeked? No worries, simply undo..";
    homepage = "https://github.com/Eisa01/mpv-scripts";
    platforms = platforms.all;
    license = licenses.bsd2;
    maintainers = with maintainers; [diniamo];
  };
}
