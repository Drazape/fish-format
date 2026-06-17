[Fish](https://fishshell.com/ "smart & user-friendly commandline shell") library that streamlines [ANSI](https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797 "formatting escape sequences for console output") formatting used in the terminal

# Birth Story
I was tired of the [unintuitive, repetitive, vague, limited](https://github.com/Drazape/SymP/blob/main/src/lib/arg/switch/indi/help-text.fish "A real, abandoned, program (made for learning only) setting an example") `(set_color --<switches> color) text (set_color --reset)` syntax, and so was born a library to generate Fish help-texts: [fish-helpText][fish-helpText].
While this covered the most common usecase, [fish-helpText][fish-helpText] isn't the only format to create help texts, and help-texts is not the only place where ANSI formatting is used.  

I soon realized the need of something universal — this library. It can do everything `set_color` can (and [more](#URL)), but much more intuitively[^edge-exception], in a way that feels natural.  

# Differences
- **No repetition**: You don't have to call 3 commands or perform command substitutions just to be able to format something — that too in a ugly way. No echo calls, no color resets, it's all built-in.
- **Sub-commands**: everything here is a sub-command; this library is for formatting, not "coloring". Everything is treated equally, not hidden behind repetitive switches. 
> [!NOTE]
> `set_color --background=cyan; echo skyFoo; set_color --reset` → `format background cyan 'skyFoo'`
- **Color Selection**: Instead of digging through colors and their variants — all represented the same way, you simply pick the color, and shade it with flags.
> [!NOTE]
> `echo (set_color brgreen)leaf(set_color --reset)` → `format text color --bright green 'leaf'`

> [!TIP]
> [Discover programs that use this library](https://github.com/topics/fish-format)


[fish-helpText]: https://github.com/Drazape/fish-helpText "Generate modern help-texts with an intuitive syntax"
[^edge-exception]: You cannot (uniformally) transform unknown continous existing unformatted data-streams — an edge case — something I have never seen happening
