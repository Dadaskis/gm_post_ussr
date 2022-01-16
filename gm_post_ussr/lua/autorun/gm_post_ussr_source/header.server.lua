local GPU = gm_post_ussr

GPU.DebugPrint("Server header")
local files, directories = file.Find("autorun/" .. GPU.ProjectData.SourceFolderName .. "/server/*.lua", "LUA")
for _, file in pairs(files) do 
    GPU.DebugPrint(file)
    include("server/" .. file)
end

GPU.DebugPrint("Client-Side Lua")
local files, directories = file.Find("autorun/" .. GPU.ProjectData.SourceFolderName .. "/client/*.lua", "LUA")
for _, file in pairs(files) do 
    GPU.DebugPrint(file)
    AddCSLuaFile("client/" .. file)
end