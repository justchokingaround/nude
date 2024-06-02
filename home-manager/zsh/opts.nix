{concatStringsSep}: let
  set = [
    "AUTO_CD"
    "CORRECT"
    "HIST_REDUCE_BLANKS"
    "NOTIFY"
    "LONG_LIST_JOBS"
    "INTERACTIVECOMMENTS"
  ];
  unset = [
    "BEEP"
    "HIST_BEEP"
  ];
in ''
  setopt ${concatStringsSep " " set}
  unsetopt ${concatStringsSep " " unset}
''
