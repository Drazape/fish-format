---
comments: true
icon: lucide/repeat
description: Nesting format commands
---

# Nesting
The UNIX philosophy—do one thing, and do it well—is followed throughout all Fish commands—except `set_color`, which merely makes the ANSI sequences readable.

To format something with `set_color`, you pass it all the formatting you need with flags. This is not the case with Format.  
To further modify the formatting of the string, you nest Format commands together to do that.

!!! example "Blue background with Green text"
    ```fish {title="set_color" .no-select}
    echo (set_color --background=blue green)foo(set_color --reset)
    ```
    ```fish {title="Format" .no-select}
    format background blue (format text color green 'foo')
    ```
