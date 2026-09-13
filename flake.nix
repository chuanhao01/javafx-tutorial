{
  description = "Java 25 JavaFX Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      jdkWithFX = pkgs.openjdk25.override {
        enableJavaFX = true; # for JavaFX
      };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          # Packages available inside `nix develop` or via direnv
          buildInputs = with pkgs; [
            maven
            gradle
            # jdkWithFX
            openjdk25
            gtk3
            glib
            libGL
            fontconfig
            libXxf86vm
            libXext
            libXi
            libXrender
            libXtst
            alsa-lib
          ];

          # Make JavaFX native libraries find their system dependencies on NixOS.
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
            gtk3
            glib
            libGL
            fontconfig
            libXxf86vm
            libXext
            libXi
            libXrender
            libXtst
            alsa-lib
          ]);

          # JAVA_HOME = jdkWithFX;

          shellHook = ''
            echo "☕ Java 25 JavaFX environment loaded"
            java -version
          '';
        };
      };
    };
}
