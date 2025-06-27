{
  description = "A flake for gemini-cli";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages."x86_64-linux".gemini-cli = pkgs.stdenv.mkDerivation {
      pname = "gemini-cli";
      version = "0.1.0"; # You might want to get the actual version from the npm package

      buildInputs = [
        pkgs.nodejs_20
        pkgs.coreutils
      ];

      installPhase = ''
        mkdir -p $out/bin
        npm install -g @google/gemini-cli
        mv $out/bin/gemini $out/bin/gemini-cli # Rename to avoid potential conflicts
      '';

      meta = with pkgs.lib; {
        description = "A command-line interface for Google Gemini";
        homepage = "https://github.com/google-gemini/gemini-cli";
        license = licenses.free;
        platforms = platforms.linux;
      };
    };
  };
}
