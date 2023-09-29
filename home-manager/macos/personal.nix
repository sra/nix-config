{ config, lib, pkgs, username, ... }:

{
  imports = [ ./base.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    home = {
      username = "sra";
      homeDirectory = "/Users/sra";
    };

    programs = {
      git = {
        userName = "Scott Anderson";
        userEmail = "sra@diem.net";
      };
      ssh = {
        matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "~/.ssh/id_rsa";
            identitiesOnly = true;
          };
        };
      };
    };
  };
}
