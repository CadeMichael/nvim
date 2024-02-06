# Neovim Conf

- the file *lua/included.lua* will not be in the repo as it is part of .gitignore 
    - it specifies what will and will not be configured / installed
- example

```lua
local m = {}

m.Cpp = true
m.Dracula = true
m.Js = false
m.Nim = false
m.Ocaml = false
m.Python = true
m.Rust = true
m.Scala = false
m.Sol = true
m.Sn = true
m.Zig = false

return m
```
