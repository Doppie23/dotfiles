{ config, pkgs, ... }:

let
    getEnvOrFail = name:
        let value = builtins.getEnv name;
        in if value == "" then
            throw "Environment variable '${name}' is required but not set. Please set it before building."
        else
            value;

    GIT_NAME = getEnvOrFail "GIT_NAME";
    GIT_EMAIL = getEnvOrFail "GIT_EMAIL";
in
{
    environment.systemPackages = with pkgs; [
        lazygit
    ];

    programs.git = {
        enable = true;
        config = {
            user.name = GIT_NAME;
            user.email = GIT_EMAIL;
        };
    };
}
