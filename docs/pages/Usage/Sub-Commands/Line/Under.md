---
comments: true
icon: lucide/underline
description: Underline the string
---

# Under
Underline the string

## Properties
|   Name  | Parent |
| :-----: | :----: |
| `under` |  Line  |

## Arguments: Switches

| Name | Description | Long | Short |
| :--: | ----------- | :--: | :---: |
| [**Color**](../../Arguments/Colors.md){data-preview} | Used as a flag instead of a positional | `color` | `c` |

## Format
=== "Format"
    ```fish {title="Format" .no-select .no-copy}
    format line under (?:`--color=<color>`) (0?:`--bright`) <string*>
    ```
=== "`set_color`"
    ```fish {title="Substitution" .no-select .no-copy}
    echo "$(set_color (?:--underline-color=<color>) --underline)"<string*>"$(set_color --reset)"
    ```
    ```fish {title="Queue" .no-select .no-copy}
    set_color (?:--underline-color=<color>) --underline; echo <string*>; set_color --reset
    ```
