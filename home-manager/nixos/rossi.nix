{ pkgs, ... }:

let
  waybar = import ./waybar.nix {
    height = 40;
    modules-right = [
      "network"
      "memory"
      "cpu"
      "disk"
      "wireplumber"
      "clock"
    ];
  };
in
{
  imports = [ ./base.nix ];

  home-manager.users.mryall = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        jetbrains.idea-community
      ];
    };

    wayland.windowManager.sway = {
      extraConfig = ''
        input "type:keyboard" {
          xkb_options ctrl:nocaps
        }

        input "type:touchpad" {
          middle_emulation disabled
          click_method clickfinger
        }

        output DVI-D-1 transform 270

        bindsym XF86AudioMute exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindsym XF86AudioRaiseVolume exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+
        bindsym XF86AudioLowerVolume exec --no-startup-id ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
        bindsym XF86AudioPlay exec --no-startup-id swaymsg "output * dpms on"
      '';
      config = {
        menu = "wofi";
        assigns = {
          "1" = [{ app_id = "^Alacritty$"; }];
          "4" = [{ class = "^Slack$"; }];
          "6" = [{ app_id = "^firefox$"; }];
        };
        workspaceOutputAssign = [
          { workspace = "1"; output = "DP-2"; }
          { workspace = "2"; output = "DP-2"; }
          { workspace = "3"; output = "DP-2"; }
          { workspace = "4"; output = "DP-2"; }
          { workspace = "5"; output = "DP-2"; }
          { workspace = "6"; output = "DVI-D-1"; }
        ];
        bars = [ ];
        fonts = {
          size = 14.0;
        };
      };
    };

    programs = {
      alacritty = {
        settings = {
          font = {
            size = 14;
          };
        };
      };

      waybar = {
        settings = [ waybar ];
      };

      ssh = {
        controlPersist = "yes";
        controlMaster = "auto";
        controlPath = "/tmp/%r@%h:%p";
        serverAliveInterval = 20;
        serverAliveCountMax = 2;

        matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "~/mnt/k/id_rsa_moj";
            identitiesOnly = true;
          };
          "*.delius-core-dev.internal *.delius.probation.hmpps.dsd.io *.delius-core.probation.hmpps.dsd.io 10.161.* 10.162.* !*.pre-prod.delius.probation.hmpps.dsd.io !*.stage.delius.probation.hmpps.dsd.io !*.perf.delius.probation.hmpps.dsd.io" = {
            user = "mryall";
            identityFile = "~/mnt/k/id_rsa_delius";
            proxyCommand = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p moj_dev_bastion";
            identitiesOnly = true;
          };
          "ssh.bastion-dev.probation.hmpps.dsd.io moj_dev_bastion awsdevgw" = {
            hostname = "ssh.bastion-dev.probation.hmpps.dsd.io";
            forwardAgent = true;
            user = "mryall";
            identityFile = "~/mnt/k/id_rsa_delius";
            proxyCommand = "sh -c \"aws ssm start-session --target i-094ea35e707a320d4 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
            identitiesOnly = true;
          };
          "*.probation.service.justice.gov.uk *.pre-prod.delius.probation.hmpps.dsd.io *.stage.delius.probation.hmpps.dsd.io 10.160.*" = {
            user = "mryall";
            identityFile = "~/mnt/k/id_rsa_delius_prod";
            proxyCommand = "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -W %h:%p moj_prod_bastion";
            identitiesOnly = true;
          };
          "ssh.bastion-prod.probation.hmpps.dsd.io moj_prod_bastion awsprodgw" = {
            hostname = "ssh.bastion-prod.probation.hmpps.dsd.io";
            forwardAgent = true;
            user = "mryall";
            identityFile = "~/mnt/k/id_rsa_delius_prod";
            proxyCommand = "sh -c \"aws ssm start-session --target i-0fba91ad072312e75 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'\"";
            identitiesOnly = true;
          };
        };
      };

      firefox = {
        profiles = {
          mryall = {
            settings = {
              "browser.uidensity" = 1;
            };
            userChrome = ''
              #TabsToolbar { visibility: collapse !important; }

              #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
                  display:none;
              }

              #urlbar { font-size: 12pt !important }
              #statuspanel { font-size: 12pt !important }
              #main-menubar { font-size: 12pt !important }

              menubar, menubutton, menulist, menu, menuitem,
              textbox, findbar, toolbar, tab, tree, tooltip {
                font-size: 12pt !important;
              }

              .tabbrowser-tab {
                 min-height: var(--tab-min-height) !important;
                 overflow: visible !important;
                 font-size: 12pt !important;
                 background: 0 !important;
                 border: 0 !important;
              }
            '';
          };
        };
      };
      git = {
        userName = "Matthew Ryall";
        userEmail = "matthew.ryall@digital.justice.gov.uk";
        signing = { key = "0902EF0CB4879CEB"; signByDefault = true; };
      };
    };
  };
}
