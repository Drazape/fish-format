---
comments: true
icon: lucide/italic
description: Italicize the string
---

# Italics
Italicize the string

## Properties
|    Name   | Parent |
| :-------: | :----: |
| `italics` |  Text  |

## Format
=== "Format"
    ```fish {title="Format" .no-select .no-copy}
    format text italics <string*>
    ```
=== "`set_color`"
    ```fish {title="Substitution" .no-select .no-copy}
    echo "$(set_color --italics)"<string*>"$(set_color --reset)"
    ```
    ```fish {title="Queue" .no-select .no-copy}
    set_color --italics; echo <string*>; set_color --reset
    ```
