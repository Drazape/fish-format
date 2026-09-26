---
comments: true
icon: lucide/download
desription: Installation procedure and methods
---

# Installation
Miscallanous information on installation of the *fish-format* library.
## Dependency
- [fish-helpText](https://github.com/Drazape/fish-helpText "Generate formatted console help reference texts"){data-preview} (`help-text`)

## Procedure
The installation involves moving Fish files from the directories

- [`functions`](https://github.com/Drazape/fish-format/tree/main/functions){data-preview} (→ `$fish_function_path`)
- [`conf.d`](https://github.com/Drazape/fish-format/tree/main/conf.d){data-preview}

to the appropriate paths in the host system, depending on the installation type.

## Scope
The installation type determines the availability of the program to users
### User
Under this scope, this program is only available to the user the installation is performed for.
#### Automatic: Package Manager
Auto-updates from the package manager  
[**Fisher**](https://github.com/jorgebucaran/fisher "Fish plugin manager"){data-preview}: `#!fish fisher install Drazape/fish-format`
#### Manual
Move the directories into your Fish configuration in the home directory (`~/.config/fish/`)

### System
Install *fish-format* system-wide; that is, for all users.
#### Automatic
Automated installation without user intervention
##### Script (local)
This locally installs the program and updates each time it is run
```fish {title="curl-to-fish script" .no-select}
curl -fsSL 'https://raw.githubusercontent.com/Drazape/fish-helpText/main/install.fish' | run0 fish -NP
```
##### Package Manager
Use a package manager previously installed in your system to manage the installation of the package.
###### NixOS
!!! warning "Manual Dependency"
    You'll need to manually install the cyclic [dependency](#dependency){data-preview}.

```nix {hl_lines="4" title="flake.nix"}
{
	inputs = {
		…
		fish-format = { type="github"; owner="Drazape"; repo="fish-format";	};
		…
	};
	outputs = inputs@{ self, nixpkgs, …, ... }: {
		nixosConfigurations."yourHost" = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			…
		};
		…
	};
}
```
```nix {hl_lines="5" title="Module with the Fish configuration"}
{ inputs, pkgs, …, ... }: {
	…
	environment.systemPackages = [
		…
		inputs.fish-format.packages."${pkgs.stdenv.hostPlatform.system}".default
		…
	]
	…
};
```

#### Manual
The files must be moved to the vendor (`vendor_*.d`) system-wide path

Package Manager
:   Normal system path managed by the package manager

Local
:   Local directory for non-packaged programs
