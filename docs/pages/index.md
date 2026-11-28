---
comments: true
icon: lucide/house
description: Home Page
---

# Home
*fish-format* is a [Fish](https://fishshell.com/ "smart & user-friendly commandline shell") library that streamlines [ANSI](https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797 "formatting escape sequences for console output") formatting used in the terminal


## `set_color` drawbacks
Though Fish has a built-in command to perform these operations: [`set_color`](https://fishshell.com/docs/current/cmds/set_color.html "Fish documentation"){data-preview}, it merely makes the existing sequences readable instead of trying to become the formatting tool by implementing a syntax.

### Unintuitive
The user experience provided by `set_color` has room for extensive improvements; following are some of the recognised enhancements:
#### Text Color focused
Formatting options other than the text color, as suggested by the name, isn't the *main* operation of the program.
Other formatting options — background, lines — are accessed with flags.
#### Vague
`set_color` works disparately than the other well-designed Fish commands.
##### Color for every variant
`set_color` has a *bright* variant as a color option for every color it offers.
This is more convenient because of the following reasons:
Doubled Clutter
:   It is harder to select a color from completions, because there are double the options than their could be

Unclear
:   Meaning of `brred` is unclear to anyone who doesn't know what `br` stands for.

!!! note "Retains Capabilities"
    This library counters this design by having you simply pick a color, and modify the variant with flags—if needed.

##### All at once
Unlike the other Fish commands that nest themselves for further changes, `set_color` makes all the changes together by printing ANSI sequences that come before the string, while still requiring two commands to be used.
##### Not self-contained
Instead of accepting the whole string that needs to be formatted, it mimics the standard ANSI sequences by surrounding the string and separately generating sequences with two different commands.
##### Repetitive
Each time you need to format a string, you first need to make the formatting with `set_color`, followed by an `echo` with the string, with a `set_color --reset`.

### Unexpandable
The architecture of `set_color` makes it tedious to be expanded upon; the following sections describe how:
#### Flags
Because [Set Color is text-color focused](#text-color-focused){data-preview}, any new functionality needs to be added as new flags.  
So for underlines, you first need to enable them with one flag (`underline`), and then change it's color with another (`underline-color=`).
#### Limited
All ANSI sequences aren't covered. This library additionally includes [formatting options for hypertext](./Reference/Sub-Commands/Hyper-text.md){data-preview}

All of these issues are solved in this library.

Head over to [Reference](./Reference/){data-preview} to learn how to use the library (with examples from `set_color` alongside).  
See [Guides](./Guides/) to learn clever ways of using the library.
---
comments: true
icon: lucide/house
description: Home Page
---

# Home
Generate formatted console help reference texts. Primarily used by Fish programs.

## Features
Modern view
:   The layout doesn't follow any of the legacy traditions

Colored text
:   Each pixel is taken special care of

Minuscule details
:   You will notice that the color of `:` and the underlines is slightly lighter than the main text. The pointers are dimmed to avoid unnecessary attention.

Section division
:   Each section is a [DRY](https://en.wikipedia.org/wiki/Don't_repeat_yourself "reducing repetition of information"){data-preview} division by categories

Adaptive spacing and column lengths
:   Each of the columns are dynamically spaced and underlined depending on the lengths of the text input

Multiple sorts of positional arguments supported
:   Programs that take fixed or variable number of arguments — or even a mix of both — are all supported

Automatically formatted description substrings
:   The Positional Arguments mentioned are in descriptions are automatically italicized, while punctuation is slightly dimmed

Clean [syntax](Arguments/index.md){data-preview}
:   It uses a very easy and readable syntax, and avoids it by using Fish's built-in data structures where possible

Built-in Fish data structures
:   Use of syntax and manual parsing is minimized with the use of Fish built-in data-structures

## Discoverability
Make your program visible by allowing users to discover it with the [topic](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/classifying-your-repository-with-topics#adding-topics-to-your-repository){data-preview}: [fish-helpText](https://github.com/topics/fish-helpText){data-preview}.

It might be used as a [demonstration in the Readme](https://github.com/Drazape/fish-subAbbr#uses){data-preview} if at least one of the following 2 conditions are met:
- It showcases a feature / usage that is not already demonstrated
- It showcases a feature better / stands-out more than an existing demonstration
