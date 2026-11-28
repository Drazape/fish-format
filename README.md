[Fish](https://fishshell.com/ "smart & user-friendly commandline shell") library that streamlines [ANSI](https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797 "formatting escape sequences for console output") formatting used in the terminal

# Reason
I was tired of the [unintuitive, repetitive, vague, limited](https://drazape.github.io/fish-decorate/Format/#set_color-drawbacks "documentation: Set Color drawbacks") `(set_color --<switches> color) text (set_color --reset)` syntax, and so was born a library to generate Fish help-texts: [fish-helpText][fish-helpText].
While this covered the most common use case, [fish-helpText][fish-helpText] isn't the only format to create help texts, and help-texts is not the only place where ANSI formatting is used.  

I soon realized the need of something universal — this library. It can do everything `set_color` can (and [more](https://drazape.github.io/fish-decorate/Format/Usage/Sub-Commands/Hyper-text/ "Documentation")), but much more intuitively[^edge-exception], in a way that feels natural.  

# Differences
- **No repetition**: You don't have to call 3 commands or perform command substitutions just to be able to format something — that too in a ugly way. No echo calls, no color resets, it's all built-in.
- **Sub-commands**: everything here is a sub-command; this library is for formatting, not "coloring". Everything is treated equally, not hidden behind repetitive switches. 
> [!NOTE]
> `set_color --background=cyan; echo skyFoo; set_color --reset` → `format background cyan 'skyFoo'`
- **Color Selection**: Instead of digging through colors and their variants — all represented the same way, you simply pick the color, and shade it with flags.
> [!NOTE]
> `echo (set_color brgreen)leaf(set_color --reset)` → `format text color --bright green 'leaf'`

> [!TIP]
> [Discover programs that use this library](https://github.com/topics/fish-format "GitHub topic")

> [!IMPORTANT]
> See the [documentation](https://drazape.github.io/fish-format "Zensical documentation on GitHub pages") for usage and installation


[fish-helpText]: https://github.com/Drazape/fish-helpText "Generate modern help-texts with an intuitive syntax"
[^edge-exception]: You cannot (uniformly) transform unknown continuous existing unformatted data-streams — an edge case — something I have never seen happening
# Description
Fish library to generate formatted [ANSI](https://github.com/Drazape/SymP/blob/main/src/lib/arg/switch/indi/help-text.fish "formatting escape sequences for console output") help reference texts using an intuitive syntax

# Demonstration
Following are some **outdated** demonstrations of the help-text library's output, along with the Fish code used to generate them.
## help-text (self)
```fish
help-text 'Generate help reference text' https://Drazape.github.io/fish-decorate/helpText/ \
	--position='Description | The purpose of the command' \
	--flag={
		'positional:p | Individual positional arguments',
		'flag:f | Individual switches'
	}
```
<img width="1896" height="781" alt="help-text (self)" src="https://github.com/user-attachments/assets/75a2d35a-5027-4d8a-8531-7ea0fbb5dc52" />

## [fish-subAbbr](https://github.com/Drazape/fish-subAbbr "Simplify abbrevating sub-commands")
```fish
begin
	set --local inherited \ (set_color white)'(inherited from '(set_color --reset --background=red)abbr(set_color --reset white)\)(set_color --reset)
	help-text 'Abbreviate sub-commands' \
		--positional={
			'+Initial Args | All arguments that come before the Sub-Command', 
			'Sub-Command | Comes after the Base Command; replaced by the Expansion',
			'Expansion | Replaces the Sub-Command'
		} \
		--switch={
			'help:h | Show this reference manual',
			'norun0:0 | Disable '(set_color --background=red)run0(set_color --reset)' toleration for abbreviations',
			'regard-flags:s | Acknowledge flags in the Base Command',
			'set-cursor:c | Position the cursor at '(set_color --background=brblack)%(set_color --reset)' post-expansion'{$inherited},
			'regex:r | Match Sub-Command with Regex. Essential for multiple Base Commands'{$inherited}
		}
end
```
<img width="1377" height="342" alt="sub-abbr" src="https://github.com/user-attachments/assets/b677e4ef-660b-40b8-a35e-81fd65d35d46" />

> [!TIP]
> [Discover programs that use this library](https://github.com/topics/fish-helptext "GitHub topic")

> [!IMPORTANT]
> See the [documentation](https://Drazape.github.io/fish-helpText "Zensical documentation @ GitHub Pages") for usage

# Installation
Following are common universal installation methods for each scope:
## User
[**Fisher**](https://github.com/jorgebucaran/fisher "GitHub repository"): `fisher install Drazape/fish-helpText`

## System
```fish
curl -fsSL 'https://raw.githubusercontent.com/Drazape/fish-helpText/main/install.fish' | run0 fish -NP
```

> [!IMPORTANT]
> [More ways to install](http://Drazape.github.io/fish-decorate/helpText/Installation/ "Distribution Package Managers")
