# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix ../../nix-base.nix ../nixos-base.nix ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/nvme0n1"; # or "nodev" for efi only
      };
    };
  };

  networking = {
    hostName = "sanchez";
    domain = "mexico86.co.uk";
    networkmanager = {
      enable = true;
      enableStrongSwan = true;
    };
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.wlp0s20f3.useDHCP = true;
    firewall = { checkReversePath = "loose"; };
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Packages
  environment = {
    systemPackages = with pkgs;
      [ brightnessctl ];

    etc."ipsec.secrets".text = ''
      include ipsec.d/ipsec.nm-l2tp.secrets
    '';
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
