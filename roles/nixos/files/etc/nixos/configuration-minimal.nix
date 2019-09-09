# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config 
 , pkgs
 , ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  system = {
    stateVersion = "18.09";
    copySystemConfiguration = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
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
      enable = false;
    };

    opengl = {
      enable = false;
    };
  };


  # Sound settings
  sound = {
    enable = false;
    enableOSSEmulation = false;
  };


  # Energy settings
  powerManagement = {
    enable = false;
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
      enable = false;
      exportConfiguration = true;
      layout = "de";

      displayManager = {
        slim = {
          enable = false;
          autoLogin = true;
          defaultUser = "scameronde";
        };
      };

      desktopManager = {
        gnome3 = {
          enable = false;
        };
      };
    };

    gnome3 = {
      chrome-gnome-shell = {
        enable = false;
      };

      gpaste = {
        enable = false;
      };

      sushi = {
        enable = false;
      };

      gnome-documents = {
        enable = false;
      };
    };

    vmwareGuest = {
      enable = false;
    };
  };


  # Configure virtualization / docker
  virtualisation = {
    docker = { 
      enable = false;
    };
  };
 
 
  # Environment for system (inherited by users)
  environment = {
    systemPackages = with pkgs; [
      wget 
      vim 
      tmux 
      maven 
      openjdk8 
      zsh 
      oh-my-zsh 
      iptables
      bridge-utils
      bind
      unzip
      ag
    ];
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
      enable = false;
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
