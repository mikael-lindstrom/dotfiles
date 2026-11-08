{ user, pkgs, ... }:

{
  home-manager.users.${user} = {
    home.packages = [ pkgs.azure-cli ];
    programs.zsh.oh-my-zsh.plugins = [ "azure" ];

    home.sessionVariables = {
      NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates.crt";
    };
  };
}
