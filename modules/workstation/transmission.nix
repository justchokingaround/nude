{config, ...}: {
  services.transmission = {
    enable = false;
    settings = {
      download-dir = "/home/${config.values.mainUser}}/torrents/";
      incomplete-dir = "/home/${config.values.mainUser}/torrents/.incomplete/";
      incomplete-dir-enabled = true;
      rpc-whitelist = "127.0.0.1,192.168.1.*";
      rpc-host-whitelist = "*";
      ratio-limit = 2;
      ratio-limit-enabled = true;
      rpc-bind-address = "0.0.0.0"; # web server
    };
  };

  systemd.tmpfiles.rules = let
    user = "transmission";
    group = "transmission";
    downloadDir = config.services.transmission.settings.download-dir;
  in [
    #Type Path                      Mode UID     GID      Age Argument
    "d    ${downloadDir}            0755 ${user} ${group} -   -"
  ];
}
