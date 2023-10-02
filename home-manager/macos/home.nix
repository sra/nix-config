{ config, lib, pkgs, ... }:

{
  imports = [ ./base.nix ];

  programs = {
    git = {
      userName = "Scott Anderson";
      userEmail = "sra@diem.net";
      #signing = {
        #key = "0902EF0CB4879CEB";
        #signByDefault = true;
      #};
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
}
