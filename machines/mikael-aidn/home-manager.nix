{ config, user, ... }: {
  home-manager.users.${user}.imports = [
    ({ config, ... }: {
      home.sessionVariables = {
        NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates.crt";
      };
    })
  ];
}