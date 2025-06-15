# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ modulesPath, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    stow
    git
    wl-clipboard
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };
  users.users.thomas-devel = {
    isNormalUser  = true;
    home  = "/home/thomas-devel";
    description  = "Developer User";
    extraGroups  = [ "wheel" "networkmanager" ];
    uid = 1000; # this is the same user id as my user on the host
  };
  security.sudo.wheelNeedsPassword = false;
  users.defaultUserShell = pkgs.zsh;

  nix.settings.sandbox  = false;
  imports = [
    # Include the default incus configuration.
    "${modulesPath}/virtualisation/lxc-container.nix"
  ];


  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };
  system.stateVersion = "24.11"; # Did you read the comment?

}

