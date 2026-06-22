---
comments: true
icon: lucide/case-sensitive
description: The string to be formatted
---

# String
The string to be formatted. This is the string that is returned after being formatted.

## Properties
| Position |  Minimum Arguments |
| :------: | :----------------: |
|   `…-1`  |          1         |

## Details
- **Last Argument**: This is the last argument of every sub-command
- **Variable Arguments**: The string can be passed into multiple arguments. The arguments will be outputted separated by space.

## Usage
```fish {title="Format" .no-copy .no-select}
format <sub-command> <other_args> <string*>
```
