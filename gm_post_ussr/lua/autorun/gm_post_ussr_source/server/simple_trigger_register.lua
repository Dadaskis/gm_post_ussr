local GPU = gm_post_ussr

local insideCall = GPU.RegisterTriggerInsideCallback
local outsideCall = GPU.RegisterTriggerOutsideCallback

GPU.TriggerInsideCallbacks = {}
GPU.TriggerOutsideCallbacks = {}

insideCall("TriggerTest0", function(ent) 
    if ent:IsPlayer() then
        ent:ChatPrint("Welcome to trigger!")
        GPU.SetPlayerAutoExposure(ent, 0.5, 0.7)
    end
end)

outsideCall("TriggerTest0", function(ent) 
    if ent:IsPlayer() then
        ent:ChatPrint("Went out of trigger!")
        GPU.SetPlayerAutoExposure(ent, 0.5, 2.0)
    end
end)

insideCall("Minen", function(ent) 
    if ent:IsPlayer() then
        ent:ChatPrint("Welcome to trap!")
    else
        ent:Remove()
    end
end)

outsideCall("Minen", function(ent) 
    if ent:IsPlayer() then
        --ent:ChatPrint("Went out of trigger!")
        local explode = ents.Create("env_explosion") 
        explode:SetPos(ent:GetPos())
        explode:Spawn()
        explode:SetKeyValue("iMagnitude", "1000")
        explode:Fire("Explode", 0, 0)
        --ent:Kill()
    end
end)

insideCall("KillButton", function(ent) 
    if ent:IsPlayer() then
        local explode = ents.Create("env_explosion") 
        explode:SetPos(ent:GetPos())
        explode:Spawn()
        explode:SetKeyValue("iMagnitude", "1000")
        explode:Fire("Explode", 0, 0)
    end
end)

insideCall("SelfDefense", function(ent) 
    if ent:IsPlayer() then
        local explode = ents.Create("env_explosion") 
        explode:SetPos(ent:GetPos())
        explode:Spawn()
        explode:SetKeyValue("iMagnitude", "1000")
        explode:Fire("Explode", 0, 0)
    end
end)

insideCall("SwitchMap", function(ent) 
    if ent:IsPlayer() then
        RunConsoleCommand("changelevel", "gm_post_ussr_lua_test")
    end
end)

insideCall("CreateBarrel", function(ent) 
    if ent:IsPlayer() then
        if not GPU.IsDelayOver("CreateBarrelButton") then
            return
        end
        local prop = ents.Create("prop_physics")
        prop:SetModel("models/gm_post_ussr/Barrel0.mdl")
        prop:SetPos(GPU.GetRandomPoint("CreateBarrelPoint"))
        prop:Spawn()   
        GPU.SetDelay("CreateBarrelButton", 0.5)
    end
end)

insideCall("TeleportPlayerToRoom", function(ent) 
    if ent:IsPlayer() then 
        ent:SetPos(GPU.GetRandomPoint("SecretRoomPosition"))
    end
end)

insideCall("TeleportPlayerBack", function(ent) 
    if ent:IsPlayer() then 
        ent:SetPos(GPU.GetRandomPoint("OriginalRoomPosition"))
    end
end)