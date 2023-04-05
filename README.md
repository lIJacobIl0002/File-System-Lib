# File-System-Lib

This is a fairly simple file system library i made for roblox. The executor you are using must support:
`readfile`, `writefile`, and `listfiles`

## Examples on how to use the file system

This only works for json files!

```lua
-- creating a new class for each folder
local folder = Settings.new('config');

-- loads files in the folder (if the foler exists)
folder:load_files()


-- write files: when writing files they get stored in the folder so you don't have to do "config/file_name.json"
folder:write_file("file_name.json", {
    ['contents'] = 'here'
});

-- read files: same with this
folder:read_file('file_name.json');
```
