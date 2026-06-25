---
comments: true
icon: lucide/paint-bucket
description: Change the string color
---

# Color
Modify the string color

## Properties
|   Name  | Parent |
| :-----: | :----: |
| `color` |  Text  |

## Arguments
1. [Color](../../Arguments/Colors.md)

## Format
=== "Format"
    ```fish {title="Format" .no-select .no-copy}
    format text <color> (?:`--bright`) <string*>
    ```
=== "`set_color`"
    ```fish {title="Substitution" .no-select .no-copy}
    echo "$(set_color (?:`br`)<color>)"<string*>"$(set_color --reset)"
    ```
    ```fish {title="Queue" .no-select .no-copy}
    set_color --background=(?:`br`)<color>; echo <string*>; set_color --reset
    ```
