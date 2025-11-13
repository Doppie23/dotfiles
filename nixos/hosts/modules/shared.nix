{ pkgs, ... }:
{
    users.users.daniel = {
        isNormalUser = true;
        description = "daniel";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.fish;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Allow dynamicly linked binaries
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [ ];

    programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting

          function nix
              if test "$argv[1]" = "develop"
                  command nix develop -c $SHELL $argv[2..]
              else
                  command nix $argv
              end
          end
        '';
        shellAliases = {
            "nix-shell" = "nix-shell --run $SHELL";
            "dev" = "nix develop -c $SHELL";
        };
        promptInit = "starship init fish | source";
    };

    environment.systemPackages = with pkgs; [
        starship
        stow
        tldr
    ];
}
