{
  lib,
  fetchFromGitHub,
  buildLua,
}:
buildLua {
  pname = "skiptosilence";
  version = "2022-02-27";

  src = fetchFromGitHub {
    owner = "detuur";
    repo = "mpv-scripts";
    rev = "0125d5eaaa6614464fbb0ee4fb7aa22a942367e8";
    hash = "sha256-b3Z9T1NfNdUzUF3to1DhBm6CpiXnoBDfaRqzXrIE8ds=";
  };
  # TODO: figure out what this does
  # passthru.updateScript = gitUpdate/unstableGitUpdater {};

  meta = with lib; {
    description = "Skips to the next silence in the currently playing media";
    homepage = "https://github.com/detuur/mpv-scripts";
    platforms = platforms.all;
    license = licenses.mit;
    maintainers = with maintainers; [diniamo];
  };
}
