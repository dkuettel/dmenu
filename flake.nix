{
  description = "dmenu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      make =
        system:
        let
          pkgs = import nixpkgs { system = system; };
          pkg = pkgs.stdenv.mkDerivation rec {
            pname = "dmenu";
            version = "dk";

            src = ./.;

            nativeBuildInputs = [ pkgs.pkg-config ];
            buildInputs = with pkgs; [
              fontconfig
              xorg.libX11
              xorg.libXinerama
              zlib
              xorg.libXft
            ];

            postPatch = ''
              sed -ri -e 's!\<(dmenu|dmenu_path|stest)\>!'"$out/bin"'/&!g' dmenu_run
              sed -ri -e 's!\<stest\>!'"$out/bin"'/&!g' dmenu_path
            '';

            preConfigure = ''
              makeFlagsArray+=(
                PREFIX="$out"
                CC="$CC"
              )
            '';
          };
        in
        {
          packages.default = pkg;
        };
    in
    flake-utils.lib.eachDefaultSystem make;
}
