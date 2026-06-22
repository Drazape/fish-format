---
comments: true
icon: lucide/house
description: Home Page
---

# Home
[Fish](https://fishshell.com/ "smart & user-friendly commandline shell") library that streamlines [ANSI](https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797 "formatting escape sequences for console output") formatting used in the terminal


## `set_color` drawbacks
Though Fish has a built-in command to perform these operations: [`set_color`](https://fishshell.com/docs/current/cmds/set_color.html "Fish documentation"){data-preview}, it merely makes the existing sequences readable instead of trying to become the formatting tool by implementing a syntax.

### Unintuitive
#### Text Color focused
Formatting options other than the text color, as suggested by the name, isn't the *main* operation of the program.
Other formatting options — background, lines — are accessed via flags.
#### Vague
`set_color` works disparately than the other well-designed Fish commands.
##### Color for every variant
`set_color` has a *bright* variant as a color option for every color it offers.
Because of this:
- It is harder to select a color from completions, because there are double the options than their could be
- Meaning of `brred` is unclear to anyone who doesn't know what `br` stands for.

!!! note "Retains Functionality"
    This library counters this such that you simply pick the color, and modify the variant with flags—if needed.

##### All at once
Unlike the other Fish commands that nest themselves for further changes, `set_color` makes all the changes together by printing ANSI sequences that come before the string, While still requiring two commands to be used.
##### Not self-contained
Instead of accepting the whole string that needs to be formatted, it mimics the standard ANSI sequences by surrounding the string and seperately genarating sequences with two different commands.
##### Repetitive
Each time you need to format a string, you first need to make the formatting with `set_color`, followed by an `echo` with the string, with a `set_color --reset`.

### Inexpandible
#### Flags
Since [Set Color is text-color focused](#text-color-focused){data-preview}, any new functionality needs to be added as new flags.  
So for underlines, you first need to enable them with one flag (`underline`), and then change it's color with another (`underline-color=`).
#### Limited
All ANSI sequences aren't covered. This library additionality includes [formatting options for hypertext](Usage/Sub-Commands/Hyper-Text.md){data-preview}

!!! example "`set_color` horror"
    This is a help text file from an old, abandoned, learning project of mine 
    [View File](https://github.com/Drazape/SymP/blob/main/src/lib/arg/switch/indi/help-text.fish "A real, abandoned, program (made for learning only) setting an example"){ .md-button .md-button--primary }

All of these issues are solved in this library.

Head over to [Usage](Usage/){data-preview} to learn how to use the library (with examples from `set_color` alongside).  
See [Tips](Tips/) to learn clever ways of using the library.
