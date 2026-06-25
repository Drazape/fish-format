---
comments: true
icon: lucide/refresh-ccw-dot
description: Swap background and text colors
---

# Reverse
Swap the background color and text color

## Properties
|    Name   | Parent |
| :-------: | :----: |
| `reverse` |  None  |

## Format
=== "Format"
    ```fish {title="Format" .no-select .no-copy}
    format reverse <string*>
    ```
=== "`set_color`"
    ```fish {title="Substitution" .no-select .no-copy}
    echo "$(set_color --reverse)"<string*>"$(set_color --reset)"
    ```
    ```fish {title="Queue" .no-select .no-copy}
    set_color --reverse; echo <string*>; set_color --reset
    ```
