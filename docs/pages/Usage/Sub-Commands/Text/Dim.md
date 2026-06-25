---
comments: true
icon: lucide/sun-dim
description: Dim the string
---

# Dim
Dim the string

## Properties
|  Name | Parent |
| :---: | :----: |
| `dim` |  Text  |

## Format
=== "Format"
    ```fish {title="Format" .no-select .no-copy}
    format text dim <string*>
    ```
=== "`set_color`"
    ```fish {title="Substitution" .no-select .no-copy}
    echo "$(set_color --dim)"<string*>"$(set_color --reset)"
    ```
    ```fish {title="Queue" .no-select .no-copy}
    set_color --dim; echo <string*>; set_color --reset
    ```
