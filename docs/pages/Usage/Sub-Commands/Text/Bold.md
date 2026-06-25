---
comments: true
icon: lucide/bold
description: Bolden the string
---

# Bold
Bolden the string

## Properties
|  Name  | Parent |
| :----: | :----: |
| `bold` |  Text  |

## Format
=== "Format"
    ```fish {title="Format" .no-select .no-copy}
    format text bold <string*>
    ```
=== "`set_color`"
    ```fish {title="Substitution" .no-select .no-copy}
    echo "$(set_color --bold)"<string*>"$(set_color --reset)"
    ```
    ```fish {title="Queue" .no-select .no-copy}
    set_color --bold; echo <string*>; set_color --reset
    ```
