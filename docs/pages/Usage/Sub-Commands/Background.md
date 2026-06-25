---
comments: true
icon: lucide/wallpaper
description: Change background color
---

# Background
Modify the background color

## Properties
|     Name     | Parent |
| :----------: | :----: |
| `background` |  None  |

## Arguments
[Color](../Arguments/Colors.md){data-preview}

## Format
=== "Format"
    ```fish {title="Format" .no-select .no-copy}
    format background <color> (?:`--bright`) <string*>
    ```
=== "`set_color`"
    ```fish {title="Substitution" .no-select .no-copy}
    echo "$(set_color --background=(?:`br`)<color>)"<string*>"$(set_color --reset)"
    ```
    ```fish {title="Queue" .no-select .no-copy}
    set_color --background=(?:`br`)<color>; echo <string*>; set_color --reset
    ```
