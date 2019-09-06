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
    stateVersion = "19.03";
    copySystemConfiguration = true;
  };

  nixpkgs = {
    config = {
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
      wget 
      vim 
      git 
      tig 
      chromium 
      chrome-gnome-shell
      tmux 
      zsh 
      oh-my-zsh 
      groff 
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
      ohMyZsh = {
        enable = true;
        theme = "muse";
      };
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
