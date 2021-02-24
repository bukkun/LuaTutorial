--[[
FTPUpload.lua

Copyright (c) 2019 Toshiba Memory Corporation.

All sample code on this page is licensed under BSD 2-Clause License
https://github.com/FlashAirDevelopers/LuaTutorial/blob/master/LICENSE
]]

local folder    = "/Upload"         -- Folder to upload file is located
local server    = "192.168.1.1"     -- IP address of FTP server
local serverDir = "/LuaTutorial"    -- FTP server upload folder
local user      = "ftp"             -- FTP user name
local passwd    = "abc123"          -- FTP password

-- Assemble our FTP command string
-- example: "ftp://user:pass@192.168.1.1/LuaTutorial"
local ftpstring = "ftp://"..user..":"..passwd.."@"..server..serverDir

-- For each file in folder...
for file in lfs.dir(folder) do
    -- Skip dot files
    if string.sub(file,1,1) == "." then
        goto continue
    end
    -- Get that file's attributes
    attr = lfs.attributes(folder .. "/" .. file)
--    print( "Found "..attr.mode..": " .. file )

    -- Don't worry about directories (yet)
    if attr.mode == "file" then
        --Attempt to upload the file!
        --ex ftp("put", "ftp://user:pass@192.168.1.1/LuaTutorial/test.jpg", "Upload/test.jpg")
        response = fa.ftp("put", ftpstring .. "/" .. attr.modification .. "_" .. file, folder .. "/" .. file)

        --Check to see if it worked, and log the result!
        if response ~= nil then
--              print("Success!")
        else
--              print("Fail :(")
        end
    end

    ::continue::
end
