# Neovim Conf

- the file *lua/included.lua* will not be in the repo as it is part of .gitignore 
    - it specifies what will and will not be configured / installed
- example

```lua
local m = {}

m.Dracula = true
m.Scala = false
m.Sn = true

return m
```
