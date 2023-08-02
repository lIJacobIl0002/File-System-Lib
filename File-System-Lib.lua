local http = game:GetService("HttpService");
local Settings = { };
Settings.__index = Settings;

function Settings.new(folder)
    local self = {};

    self.files = {};
    self.folder = folder;
    
    
    

    if(not isfolder(folder)) then
        makefolder(folder)
    else
        Settings.load_files(self);
    end;

    return setmetatable(self, Settings);
end;

function Settings:load_files()

    for i, v in pairs(listfiles(self.folder)) do
        local file = string.match(v, "\\([%w%s%p]+)$");
        local _, fc = pcall(http.JSONDecode, http, readfile(v))

        self.files[file] = _ and fc or nil

        -- in case it fails to read it
        if not _ then
            print(('failed to read %s due to \'%s\''):format(file, fc))
        end;

    end

end;

function Settings:write_file(file, contents)
    assert(type(contents) == "table", 'table required')

    self.files[file] = contents

    local temp = ('%s\\%s'):format(self.folder, file)

    writefile(temp, http:JSONEncode(contents))
end;

function Settings:read_file(file)
    assert(self.files[file], 'file does not exist')

    return self.files[file]
end;

return Settings
