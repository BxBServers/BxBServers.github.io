{
  description = "rust dev shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs { inherit system; };

        nativeBuildInputs = with pkgs; [just minijinja watchexec imagemagick];
        buildInputs = with pkgs; [];
      in
        with pkgs; {
          formatter = alejandra;

          devShells.default = mkShell {
            inherit buildInputs nativeBuildInputs;
          };
        }
    );
}
