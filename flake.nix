{
  description = "fzf-raindrop";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        fzf-raindrop = pkgs.stdenv.mkDerivation {
          name = "fzf-raindrop";
          src = ./.;
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postFixup = with pkgs; ''
            wrapProgram "$out/bin/fzf-raindrop" \
                --prefix PATH : "${lib.makeBinPath [ duckdb fzf ]}"
          '';
          installPhase = ''
            mkdir -p $out/bin
            cp fzf-raindrop $out/bin/fzf-raindrop
            chmod +x $out/bin/fzf-raindrop
          '';
          meta = {
            description = "fzf-raindrop";
            homepage = "https://github.com/thenbe/fzf-raindrop";
            license = pkgs.lib.licenses.gpl3;
          };
        };
      in
      {
        packages.default = fzf-raindrop;
        apps.default = { program = "${fzf-raindrop}/bin/fzf-raindrop"; type = "app"; };
        devShells.default = with pkgs; mkShell {
          packages = [
            sleek # sql formatter
          ];
        };
        devShells.demo =
          let
            pypkgs = pkgs.python311Packages;
          in
          pkgs.mkShell {
            venvDir = "./venv";
            packages = [
              pypkgs.python
              pypkgs.venvShellHook
              pypkgs.pandas
              pypkgs.faker
            ];
            postVenvCreation = ''
              unset SOURCE_DATE_EPOCH
            '';
            postShellHook = ''
              unset SOURCE_DATE_EPOCH
            '';
            shellHook = ''
              echo "Entering demo environment"
              echo "Setting 'FZF_RAINDROP_DATA_DIR' to $(pwd)/generated"
              export FZF_RAINDROP_DATA_DIR=$(pwd)/generated
              mkdir -p generated
              echo 'Next step: Launch a demo by running: `python fake.py && nix run .`'
            '';
          };
      }
    );
}
