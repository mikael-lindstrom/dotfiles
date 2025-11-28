{ user, ... }:

{
  home-manager.users.${user} = {
    home.sessionVariables = {
      NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates.crt";
    };
  };
}
