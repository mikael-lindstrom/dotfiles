{ user, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  programs.zsh.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    home = "/home/${user}";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
