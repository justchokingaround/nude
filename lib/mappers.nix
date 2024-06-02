let
  inputsToPackages = inputs: system: builtins.mapAttrs (_name: value: value.packages.${system} or null) inputs;
in {
  inherit inputsToPackages;
}
