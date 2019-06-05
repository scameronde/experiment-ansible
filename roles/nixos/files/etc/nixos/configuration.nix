# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config 
 , pkgs
 , ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  system = {
    stateVersion = "19.03";
    copySystemConfiguration = true;
  };

  nixpkgs = {
    config = {
      packageOverrides = pkgs: {
        unstable = import unstableTarball {
          config = config.nixpkgs.config;
        };
      };
      allowUnfree = true;
    };
  };


  # Boot loader
  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "/dev/sda";
      };
    };
  };


  # Networking settings
  networking = {
    hostName = "nixos";

    enableIPv6 = false;

    firewall = {
      enable = false;
    };

    networkmanager = {
      enable = true;
    };

    wireless = {
      enable = false;
    };
  };


  # Time settings
  time = {
    timeZone = "Europe/Berlin";
  };


  # Console keyboard and font
  i18n = {
    consoleFont   = "Lat2-Terminus16";
    consoleKeyMap = "de";
    defaultLocale = "de_DE.UTF-8";
  };


  # Additional hardware
  hardware = {
    bluetooth = {
      enable = false;
    };

    pulseaudio = {
      enable = true;
    };

    opengl = {
      enable = true;
    };
  };


  # Sound settings
  sound = {
    enable = true;
    enableOSSEmulation = true;
  };


  # Energy settings
  powerManagement = {
    enable = true;
  };


  # Fonts for graphical UI
  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;

    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      powerline-fonts
    ];
  };


  # System services
  services = {
    openssh = {
      enable = true;
    };

    squid = {
      enable = false;
    };

    printing = {
      enable = false;
    };

    xserver = {
      enable = true;
      exportConfiguration = true;
      layout = "de";

      displayManager = {
        gdm = {
          enable = true;
          wayland = false;
        };
      };

      desktopManager = {
        gnome3 = {
          enable = true;
        };
      };
    };

    gnome3 = {
      chrome-gnome-shell = {
        enable = true;
      };

      gpaste = {
        enable = true;
      };

      sushi = {
        enable = true;
      };

      gnome-documents = {
        enable = true;
      };
    };
  };


  # Configure virtualization / docker
  virtualisation = {
    docker = { 
      enable = false;
    };

    virtualbox.guest = {
      enable = true;
    };
  };
 
 
  # Environment for system (inherited by users)
  environment = {
    systemPackages = with pkgs; [
      unstable.dropbox
      wget 
      vim 
      git 
      tig 
      chromium 
      chrome-gnome-shell
      firefox 
      thunderbird
      tmux 
      keepassx2 
      maven 
      jetbrains.idea-community 
      eclipses.eclipse-platform 
      openjdk8 
      vscode 
      zsh 
      oh-my-zsh 
      libreoffice-fresh 
      pandoc 
      groff 
      iptables
      bridge-utils
      bind
      texlive.combined.scheme-full
      texstudio
      unzip
      ag
    ];
  };


  # Systemd entries
  systemd.user.services = {
    dropbox = {
      description = "Dropbox";
      wantedBy = [ "graphical-session.target" ];
      environment = {
        QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
        QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
      };
      serviceConfig = {
        ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
        ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
        KillMode = "control-group"; # upstream recommends process
        Restart = "on-failure";
        PrivateTmp = true;
        ProtectSystem = "full";
        Nice = 10;
      };
    };
  };


  # Configuration defaults for programs
  programs = {
    bash = {
      enableCompletion = true;
    };

    zsh = {
      enable = true;
    };

    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
  };


  # Users
  users = {
    users = {
      scameronde = {
        isNormalUser = true;
        home = "/home/scameronde";
        extraGroups = [ "wheel" "networkmanager" "users" "audio" "docker" "wireshark" ];
        shell = pkgs.zsh;
      };
    };
  };

}
