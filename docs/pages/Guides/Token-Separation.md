---
comments: true
icon: lucide/table-columns-split
description: Separating tokens parsed with the same preset
---

# Token Separation
Normally, when you use a `format` command, the whole string is formatted the same way.  
This does not restrict us from using multiple `format` commands with the same preset (options), but there would often be cases where we want to use a formatting preset multiple times, with other strings in between.

!!! note "Exceptions"
    ## [Hyper-text](../Reference/Sub-Commands/Hyper-text.md)
    The sub-command accepts fixed positionals; therefore, it would make the command structure complicated if it were to accept multiple tokens.  
    There also isn't much of a usecase for separation of two hyper-texts, and hence, it doesn't support token separation.
    ## Multi-line outputs
    The token-separation depends on the output spanning multiple-lines.  
    If one of the strings itself have multiple lines, we can no longer distinguish between the different tokens.  

This is possible with token separation; that is, providing multiple tokens (arguments) for the same `format` command.

!!! example "Tokens: Multiple versus Single"
    ```fish {title="Single"}
    format background blue 'first-string second-string'
    ```
    Rendered as a single string
    > ==first-string second-string==

    ---

    ```fish {title="Multiple"}
    format background blue 'first-string' 'second-string'
    ```
    Rendered as two different strings, separated by a new line
    > ==first-string==  
    > ==second-string==

    Once a string is separated by a new line, Fish makes it trivial to deliminate them however we want.

## Separations
Following are guides on how to separate tokens with different sorts of strings
### New Line
To separate a string with a new line, you can simply use `format` without piping its output.
!!! example
    ```fish {title"Single"}
    format line under 'first-word second-word'
    ```
    > ^^first-word second-word^^

    ---

    ```fish {title="Multiple"}
    format line under 'first line' 'second line'
    ```
    > ^^first line^^  
    > ^^second line^^

### Space
In this special case, you can use command substitution to separate the tokens by space.
!!! example
    ```fish {title="Single"}
    echo (format line strikethrough 'first-word second-word')
    ```
    > ~~first-word second-word~~

    ---

    ```fish {title="Multiple"}
    echo (format line strikethrough 'first word' 'second line')
    ```
    > ~~first word~~ ~~second word~~

### Arbitrary
If you want to use any other arbitrary string as a separator, pipe the output of `format` to `string join <separator>`
!!! example
    ```fish {title="Format"}
    format background blue '17' '45' '29' | string join ' + '
    ```
    > ==17== + ==45== + ==29==
