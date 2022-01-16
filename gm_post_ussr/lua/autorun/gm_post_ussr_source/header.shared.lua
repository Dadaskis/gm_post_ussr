local GPU = gm_post_ussr

GPU.DebugPrint("Shared header")
local files, directories = file.Find("autorun/" .. GPU.ProjectData.SourceFolderName .. "/shared/*.lua", "LUA")
for _, file in pairs(files) do 
    GPU.DebugPrint(file)
    include("shared/" .. file)
end

GPU.DebugPrint("Client-Side Lua")
local files, directories = file.Find("autorun/" .. GPU.ProjectData.SourceFolderName .. "/shared/*.lua", "LUA")
for _, file in pairs(files) do 
    GPU.DebugPrint(file)
    AddCSLuaFile("shared/" .. file)
end