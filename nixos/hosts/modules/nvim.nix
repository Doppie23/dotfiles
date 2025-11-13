{ pkgs, ... }:
{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };

    environment.systemPackages = with pkgs; [
        ripgrep

        # Language server packages
        lua-language-server
    ];
}
