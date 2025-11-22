{ config, lib, pkgs, ... }:

# uses: https://github.com/nix-community/NixOS-WSL

{
    imports = [
        <nixos-wsl/modules>
        ../modules/shared.nix
        ../modules/nvim.nix
        ../modules/git.nix
        ../modules/flakes.nix
    ];

    wsl.enable = true;
    wsl.defaultUser = "daniel";

    services.syncthing = {
        enable = true;
        user = "daniel";
        configDir = "/home/daniel/.config/syncthing";
        openDefaultPorts = true;
        guiAddress = "127.0.0.1:8385";
        settings = {
            folders = {
                "Universiteit-Utrecht" = {
                    path = "/home/daniel/universiteit-utrecht";
                    devices = ["Datacentrum"];
                    ignorePatterns = [
                        "(?d).stack-work"
                        "/blackboard-takeout/"
                        "/Jaar 1/"
                        "/Jaar 2/"
                        "/Jaar 3/"
                    ];
                };
            };
            devices = {
                "Datacentrum" = {
                    id = "J3EPKU5-P7IQRT3-A4NZZHE-CS633Y7-QGCMOVK-ZTZXXTV-TKTLQ66-7EEEKQS";
                };
            };
        };
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?
}
