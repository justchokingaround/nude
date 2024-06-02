{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    coreutils-full
    htop
    man-pages
    man-pages-posix
    ripgrep
    fd
    tldr
    duf
    jq
    wget
    comma
    eza
    sesh
    rmapi
    docker-compose
    gh
    nh
    nix-tree
  ];
}
