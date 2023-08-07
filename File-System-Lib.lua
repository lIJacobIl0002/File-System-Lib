local http = game:GetService("HttpService");
local Settings = { };

Settings.__index = Settings;

-- editing all files
Settings.__gc = function(self)
    for _, file in pairs(self.fileChanges) do
        writefile(temp(self.folder, file), http:JSONEncode(self.files[file]))
    end;
end;

function temp(folder, file)
    return ('%s\\%s'):format(folder, file);
end;

function Settings.new(folder)
    local self = {};

    self.files = {};
    self.folder = folder;
    self.fileChanges = {};

    if(not isfolder(folder)) then
        makefolder(folder)
    else
        Settings.load_files(self);
    end;

    return setmetatable(self, Settings);
end;

-- load files in folder (if folder does exist)
function Settings:load_files()

    for i, v in pairs(listfiles(self.folder)) do
        local file = string.match(v, "\\([%w%s%p]+)$");
        local _, fc = pcall(http.JSONDecode, http, readfile(v))

        self.files[file] = _ and fc or nil

        -- in case it fails to read it
        if not _ then
            print(('failed to read %s due to \'%s\''):format(file, fc))
        end;
    end;
end;

-- write to file
function Settings:write_file(file, contents)
    assert(type(contents) == "table", 'table required')
    table.insert(self.fileChanges, file);

    self.files[file] = contents;
end;

-- read from file
function Settings:read_file(file)
    assert(self.files[file], 'file does not exist')

    return self.files[file]
end;

-- delete file
function Settings:delete_file(file)
    if self.files[file] then
        self.files[file] = nil;
        
        delfile(temp(self.folder, file));
    end;
end;

-- if file eixsts
function Settings:isfile(file)
    return self.files[file] and true or false;
end;

--[[
    * This makes modifications only to the table, but once garbage-collected it applies all changes.
    * Since i didn't wanna apply changes to all files i kept track of file that are changed.
]]

return Settings;