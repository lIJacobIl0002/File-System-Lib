local http = game:GetService("HttpService");
local format, match = ('').format, ('').match;
local Settings = {};
Settings.__index = Settings;

function Settings.new(folder)

    if(not isfolder(folder)) then
        makefolder(folder)
    end;

    return setmetatable({
        folder = folder,

    }, Settings);
end;

function Settings:load_files()
    self.files = {}

    for i, v in pairs(listfiles(self.folder)) do
        local file = match(v, "\\([%w%s%p]+)$");
        local _, fc = pcall(http.JSONDecode, http, readfile(v))

        self.files[file] = _ and fc or nil

    end

end;

function Settings:write_file(file, contents)
    assert(type(contents) == "table", 'table required')
    
    if(not self:create_temp(file)) then
        return;
    end

    self.files[file] = contents

    writefile(self:create_temp(file), http:JSONEncode(contents))
end;

function Settings:create_temp(file)
    do
        return format('%s\\%s', self.folder, file);
    end;
end;

function Settings:read_file(file)
    assert(self.files[file], 'file does not exist')

    return self.files[file]
end;


return Settings
