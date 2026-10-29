{
	description = "ANSI formatting for Fish";

	inputs = {
		flake-parts = { type="github"; owner="hercules-ci"; repo="flake-parts"; };
		nixpkgs = { type="github"; owner="NixOS"; repo="nixpkgs"; ref="nixpkgs-unstable"; };
	};

	outputs = inputs@{ flake-parts, ... }:
		flake-parts.lib.mkFlake { inherit inputs; } {
			systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
			perSystem = { self', pkgs, system, lib, ... }: {
				packages = let pkgName = "fish-format"; in {
					default = self'.packages.${pkgName};
					${pkgName} = pkgs.stdenvNoCC.mkDerivation {
						name = pkgName;
						inherit system;

						src = ./.;
						installPhase = ''${pkgs.lib.getExe pkgs.fish} --no-config --private -- ${./install.fish} ${./.}'';

						meta = {
							description = "Fish plugin: intuitive ANSI formatter alternative to `set_color`";
							homepage = "https://github.com/Drazape/fish-format";
							license = lib.licenses.mit;
							platforms = lib.platforms.linux;
						};
					};
				};
			};
		};
}
