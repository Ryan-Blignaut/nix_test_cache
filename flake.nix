{
  description = "Test flake for GitHub Actions + Cachix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.myPackage = pkgs.stdenv.mkDerivation {
      pname = "myPackage";
      version = "1.0.0";

      src = pkgs.writeTextFile {
        name = "hello.c";
        text = ''
          #include <stdio.h>
          int main() {
            printf("Hello from Nix Flake! cool things 12345678901928373645\\n");
            return 0;
          }
        '';
      };

      unpackPhase = "true"; # ✅ skip unpacking

      buildPhase = ''
        ${pkgs.gcc}/bin/gcc $src -o hello
      '';

      installPhase = ''
        mkdir -p $out/bin
        cp hello $out/bin/
      '';
    };

    defaultPackage.${system} = self.packages.${system}.myPackage;
  };
}
