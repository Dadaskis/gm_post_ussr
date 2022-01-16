gm_post_ussr = gm_post_ussr or {}
local GPU = gm_post_ussr
GPU.ProjectData = {}
GPU.ProjectData.SourceFolderName = "gm_post_ussr_source"
GPU.ProjectData.ProjectName = "gm_post_ussr"

function GPU.DebugPrint(message) 
    print("[" .. GPU.ProjectData.ProjectName .. "] " .. message)
end

local sourceFolder = GPU.ProjectData.SourceFolderName

include(sourceFolder .. "/header.shared.lua")
if CLIENT then
    include(sourceFolder .. "/header.client.lua")
elseif SERVER then
    AddCSLuaFile(sourceFolder .. "/header.shared.lua")
    AddCSLuaFile(sourceFolder .. "/header.client.lua")
    include(sourceFolder .. "/header.server.lua") 
end         