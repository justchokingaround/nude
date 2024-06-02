{
  programs.git = {
    enable = true;
    userName = "justchokingaround";
    userEmail = "ivanonarch@tutanota.com";
    delta.enable = true;

    extraConfig = {
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
        core = {
          sshCommand = "ssh -i ~/.ssh/github_main.pub -o IdentitiesOnly=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
        };
      };
    };
  };
}
