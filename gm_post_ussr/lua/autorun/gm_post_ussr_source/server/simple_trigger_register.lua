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

local elevatorMode = false
insideCall("KillButton", function(ent) 
    if ent:IsPlayer() then
        --local explode = ents.Create("env_explosion") 
        --explode:SetPos(ent:GetPos())
        --explode:Spawn()
        --explode:SetKeyValue("iMagnitude", "1000")
        --explode:Fire("Explode", 0, 0)
        if not GPU.IsDelayOver("BrushTestMove") then
            return
        end
        local ply = ent
        local ent = GPU.GetNamedEnts("BrushTest")[1]
        if IsValid(ent) then
            --ent:SetPos(ent:GetPos() + Vector(0, 0, 5))
            --[[local origin_pos = ent:GetPos()
            local dest_pos = ent:GetPos() + Vector(0, 0, 60)
            local progress = 0.0
            local speed = 0.4
            timer.Create("gm_post_ussr.BrushMove", 0.001, 0, function() 
                if IsValid(ent) then 
                    ent:SetPos(LerpVector(progress, origin_pos, dest_pos))
                    progress = progress + (speed * FrameTime())
                    if ent:GetPos():Distance(dest_pos) < 1 then
                        timer.Remove("gm_post_ussr.BrushMove")
                    end
                else
                    timer.Remove("gm_post_ussr.BrushMove")
                end
            end)]]
            --ent:Fire("Toggle")
            ent:Fire("SetSpeed", "16")
            if not elevatorMode then
                ent:Fire("StartForward")
                elevatorMode = not elevatorMode
                ply:ChatPrint("Front")
            else
                ent:Fire("StartBackward")
                elevatorMode = not elevatorMode
                ply:ChatPrint("Back")
            end
        end
        GPU.SetDelay("BrushTestMove", 0.5)
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