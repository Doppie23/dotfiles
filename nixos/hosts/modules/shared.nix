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

    nix.optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    # Allow dynamicly linked binaries
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [ ];

    programs.fish = {
        enable = true;
        interactiveShellInit = ''
            set fish_greeting # Disable greeting
            direnv hook fish | source
        '';
        shellAliases = {
            "nix-shell" = "nix-shell --run $SHELL";
        };
        promptInit = "starship init fish | source";
    };

    environment.systemPackages = with pkgs; [
        starship
        stow
        tldr
    ];
}
