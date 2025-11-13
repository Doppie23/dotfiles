{ pkgs, ... }:
{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };

    environment.systemPackages = with pkgs; [
        gcc
        ripgrep

        # Language server packages
        lua-language-server
    ];
}
