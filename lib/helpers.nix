{lib}: let
  nameToSlug = name: lib.strings.toLower (builtins.replaceStrings [" "] ["-"] name);
  boolToNum = bool:
    if bool
    then 1
    else 0;
  overrideError = pkgName: "A new version of ${pkgName} has been released, remove this overlay/override";
in {
  inherit nameToSlug boolToNum overrideError;
}
