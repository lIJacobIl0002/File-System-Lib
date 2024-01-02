-- loading the file system
local Settings = loadstring(game:HttpGet("https://raw.githubusercontent.com/lIJacobIl0002/File-System-Lib/main/File-System-Lib.lua"))()

-- creating a new class for each folder
local folder = Settings.new('config');

-- write files: when writing files they get stored in the folder so you don't have to do "config/file_name.json". return nothings.
folder:write_file("file_name.json", {
    ['contents'] = 'here'
});

-- read files: same with this. returns table (file contents)
print(folder:read_file('file_name.json'));


