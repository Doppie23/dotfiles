{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        wezterm
    ];

    fonts.packages = with pkgs; [
        cascadia-code
    ];
}
