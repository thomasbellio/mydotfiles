# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ modulesPath, pkgs, ... }:

{

  time = {
    timeZone = "America/Denver";
  };
  environment.systemPackages = with pkgs; [
    stow
    git
    neovim
    starship
    wl-clipboard
    openssh # Ensure ssh-agent is installed
    man
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "0xProto" "CascadiaMono" "JetBrainsMono" ]; })
  ];


  # Ensure proper runtime directory setup
  # systemd.services.setup-user-runtime = {
  #   description = "Setup user runtime directories";
  #   wantedBy = [ "multi-user.target" ];
  #   before = [ "systemd-logind.service" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     ExecStart = pkgs.writeShellScript "setup-runtime" ''
  #       mkdir -p /run/user/1000
  #       chown 1000:users /run/user/1000
  #       chmod 700 /run/user/1000
  #     '';
  #   };
  # };

  programs.ssh = {
    startAgent = true;
  };
  #
  # services.dbus.enable = true;
  #
  # # Also ensure systemd user services can work properly
  # systemd.user.services = {
  #   # This helps ensure the user session is properly initialized
  # };

  # Set up PAM to create XDG_RUNTIME_DIR
  # security.pam.services.login.text = ''
  #   session required pam_systemd.so
  # '';

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  users.groups.thomas-devel = {
    gid = 1001;
  };
  users.users.thomas-devel = {
    isNormalUser  = true;
    createHome = true;
    useDefaultShell = true;
    home  = "/home/thomas-devel";
    description  = "Developer User";
    group = "thomas-devel";
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
