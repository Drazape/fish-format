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

## Usage
```fish {title="Format" .no-select .no-copy}
format line under (0?:`--bright`) (?:`--color=<color>`) (0?:`--bright`) <string*>
```
