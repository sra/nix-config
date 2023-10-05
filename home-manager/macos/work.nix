{ pkgs, username, ... }:

let
  adr-tools = import ../../pkgs/adr-tools { inherit pkgs; };
in
{
  imports = [ ./base.nix ];

  home-manager.users.${username} = { pkgs, ... }: {
    home = {
      username = "scottanderson";
      homeDirectory = "/Users/scottanderson";

      packages = with pkgs; [
        # adr-tools
        #dbeaver
        # jetbrains.idea-community
        jwt-cli
        jira-cli-go
        pgformatter
        kubectl
        kubelogin
        k9s
        ssm-session-manager-plugin
        tidyp
        xh
        aws-vault
        awscli2
        eksctl
        aws-iam-authenticator
	jdk17
        maven
      ];

      sessionVariables = {
        JIRA_EDITOR = "nvim";
        JIRA_API_TOKEN = "";
      };
    };

    programs = {
      ssh = {
        controlPersist = "yes";
        controlMaster = "auto";
        controlPath = "/tmp/%r@%h:%p";
        serverAliveInterval = 20;
        serverAliveCountMax = 2;
        extraConfig = ''
          IdentityAgent ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
        '';

        matchBlocks = {
          "xgithub.com" = {
            hostname = "github.com";
            user = "git";
            identitiesOnly = true;
          };
        };
      };
      git = {
        userName = "Scott Anderson";
        userEmail = "scott.anderson@truelook.com";
        #signing = {
          #key = "0902EF0CB4879CEB";
          #signByDefault = true;
        #};
      };
    };
  };
}
