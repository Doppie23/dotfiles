{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        zen-browser = {
            url = "github:youwen5/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, zen-browser }: {
        nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
                inherit zen-browser;
            };
            modules = [
                ./hosts/pc/configuration.nix
            ];
        };

        nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/wsl/configuration.nix
            ];
        };
    };
}
