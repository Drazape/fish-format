---
comments: true
icon: lucide/download
desription: Installation procedure and methods
---

# Installation
## Dependencies

- [fish-helpText](https://github.com/Drazape/fish-helpText "Generate formatted console help reference texts"){data-preview} (`help-text`)

## Procedure
The installation involves moving Fish files from the directories

- [`functions`](https://github.com/Drazape/fish-format/tree/main/functions){data-preview} (→ `$fish_function_path`)
- [`conf.d`](https://github.com/Drazape/fish-format/tree/main/conf.d){data-preview}

to the appropriate paths in the host system, depending on the installation type.

## Scope
### User
#### Automatic: Package Manager
Auto-updates via the package manager  
[**Fisher**](https://github.com/jorgebucaran/fisher "Fish plugin manager"){data-preview}: `#!fish fisher install Drazape/fish-format`
#### Manual
Move the directories into your Fish configuration in the home directory (`~/.config/fish/`):

### System
#### Automatic
##### Script (local)
This locally installs the program and updates each time it is run
```fish {title="curl-to-fish script" .no-select}
curl -fsSL 'https://raw.githubusercontent.com/Drazape/fish-helpText/main/install.fish' | run0 fish -NP
```
##### Package Manager
As of now, no distribution package manager is supported.

###### NixOS
!!! warning "Manual Dependency"
    You'll need to manually install the [dependencies](#dependencies){data-preview}.
		!!! info "Future Fish dependencies automation"
				For the package, a special wrapper for Fish dependencies (planned) needs to be made.

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
{ inputs, … }: {
	…
	environment.systemPackages = [
		…
		inputs.fish-format.packages."${stdenv.hostPlatform.system}".default
		…
	]
	…
};
```

#### Manual
The files must be moved to the vendor (`vendor_*.d`) system-wide path

- **Package Manager**: Normal system path managed by the package manager
- **Local**: Local directory for non-packaged programs
