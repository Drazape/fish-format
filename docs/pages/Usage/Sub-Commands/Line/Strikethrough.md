---
comments: true
icon: lucide/strikethrough
description: Underline the string
---

# Strikethrough
Strikethrough the string with a line

## Properties
|       Name      | Parent |
| :-------------: | :----: |
| `strikethrough` |  Line  |

## Format
=== "Format"
    ```fish {title="Format" .no-select .no-copy}
    format line strikethrough <string*>
    ```
=== "`set_color`"
    ```fish {title="Substitution" .no-select .no-copy}
    echo "$(set_color --strikethrough)"<string*>"$(set_color --reset)"
    ```
    ```fish {title="Queue" .no-select .no-copy}
    set_color --strikethrough; echo <string*>; set_color --reset
    ```
