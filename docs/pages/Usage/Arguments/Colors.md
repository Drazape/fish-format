---
comments: true
icon: lucide/palette
description: Color selection
---

# Colors
The color to change to.

## Properties
| Position |  Minimum Arguments |
| :------: | :----------------: |
|   `-2`   |          1         |

## Uses
1. [Text](../Sub-Commands/Text/Color.md){data-preview}
2. [Background](../Sub-Commands/Background.md){data-preview}

## Choices
### Colors
1. Black
2. Blue
3. Cyan
4. Green
5. Magenta
6. Red
7. White
8. Yellow

### Variant
Variants make subtle changes to the color chosen. 
#### Position
Variants can only be used before or after the used color. If it is used elsewhere, it will be treated as a the string.  
!!! tip "Single Variant syntactic advantages"
    Since there is currently only one variant, We are several advantages we can make use of to make the syntax less error-prone.

    - If it is used once, you don't need to use `--` to use it in the string again, and all flags and `--` be interpreted as part of the string
    - `--bright` or `--` can be used anywhere if it isn't before or after the color
    - All the other flags are interpreted as strings, and not parsed internally

#### List
|  Name  |    long    | short |                 Internal Implementation                 |
| :----: | :--------: | :---: | ------------------------------------------------------- |
| Bright | `--bright` |  `-b` | Appends `br` to the color, and passes it to `set_color` |

## Usage
```fish {title="Format" .no-select .no-copy}
format <sub-command> (0?:`--bright`) <color> (0?:`--bright`) <string*>
```
