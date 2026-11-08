{ user, pkgs, ... }:

{
  home-manager.users.${user} = {
    home.packages = [ pkgs.azure-cli ];
    programs.zsh.oh-my-zsh.plugins = [ "azure" ];
  };
}
