local GPU = gm_post_ussr

local insideCall = GPU.RegisterTriggerInsideCallback
local outsideCall = GPU.RegisterTriggerOutsideCallback

GPU.TriggerInsideCallbacks = {}
GPU.TriggerOutsideCallbacks = {}

--[[insideCall("TriggerTest0", function(ent) 
    if ent:IsPlayer() then
        ent:ChatPrint("Welcome to trigger!")
        GPU.SetPlayerAutoExposure(ent, 0.5, 0.7, 1.0)
    end
end)

outsideCall("TriggerTest0", function(ent) 
    if ent:IsPlayer() then
        ent:ChatPrint("Went out of trigger!")
        GPU.SetPlayerAutoExposure(ent, 0.5, 2.0, 1.0)
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
            end)]]--[[
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
end)]]

if game.GetMap() == "gm_post_ussr" then

    insideCall("UndergroundLocation", function(ent) 
        if ent:IsPlayer() then
            --ent:ChatPrint("Underground")
            GPU.SetPlayerAutoExposure(ent, 0.5, 4.0, 0.4)
        end
    end)

    insideCall("OutsideArea0Location", function(ent) 
        if ent:IsPlayer() then
            --ent:ChatPrint("District 52")
            GPU.SetPlayerAutoExposure(ent, 0.5, 0.7, 0.7)
        end
    end)

    insideCall("OutsideArea1Location", function(ent) 
        if ent:IsPlayer() then
            --ent:ChatPrint("Old Streets")
            GPU.SetPlayerAutoExposure(ent, 0.5, 0.7, 1.0)
        end
    end)

    insideCall("FactoryPartLocation", function(ent) 
        if ent:IsPlayer() then
            --ent:ChatPrint("Factory Complex")
            GPU.SetPlayerAutoExposure(ent, 0.5, 0.7, 1.0)
        end
    end)

    insideCall("FactoryInsideLocation", function(ent) 
        if ent:IsPlayer() then
            --ent:ChatPrint("Factory Complex inside in")
            GPU.SetPlayerAutoExposure(ent, 0.5, 2.0, 1.5)
        end
    end)

    outsideCall("FactoryInsideLocation", function(ent) 
        if ent:IsPlayer() then
            --ent:ChatPrint("Factory Complex inside out")
            GPU.SetPlayerAutoExposure(ent, 0.5, 0.7, 1.0)
        end
    end)

    insideCall("KillTrigger", function(ent) 
        if ent:IsPlayer() then
            ent:KillSilent()
            ent:Spawn()
        else
            ent:SetPos(Vector(-1000000, -1000000, -1000000))
            ent:Remove()
        end
    end)

    local outside_area_0_teleports = {
        Vector(-9141.778320, 4612.766113, 16.031250),
        Vector(-9075.700195, 7481.905762, 16.423023),
        Vector(-9062.656250, 9196.487305, 16.031250),
        Vector(-7497.221680, 9194.128906, 16.031250),
        Vector(-4828.161133, 9169.349609, 16.031250),
        Vector(-4708.232910, 7662.873047, 16.031250),
        Vector(-4672.194824, 5437.756836, 16.031250),
        Vector(-5526.728516, 4896.995117, 16.031250),
        Vector(-6736.184570, 4913.269531, 16.031250),
    }

    local outside_area_1_teleports = {
        Vector(3544.27734375, 9388.5859375, 128.03125),
        Vector(4866.1791992188, 9358.4658203125, 128.03125),
        Vector(6584.9790039063, 9324.578125, 131.29945373535),
        Vector(7185.306640625, 9746.626953125, 128.03125),
        Vector(7248.5141601563, 10898.020507813, 128.03125),
        Vector(7238.5234375, 11902.484375, 128.03125),
        Vector(7678.78515625, 9350.3779296875, 128.03125),
        Vector(8627.57421875, 9277.9638671875, 128.03125),
        Vector(10314.505859375, 9281.2724609375, 128.03125),
        Vector(7281.5083007813, 8805.01953125, 128.03125),
        Vector(7235.2021484375, 7935.2319335938, 128.03125),
        Vector(7256.412109375, 6817.5717773438, 128.03125),
    }

    local factory_part_teleports = {
        Vector(-8143.4155273438, -11233.799804688, 376.03125),
        Vector(-11803.283203125, -11962.361328125, 248.32055664063),
        Vector(-7008.3823242188, -9714.796875, 376.03125),
        Vector(-5365.9887695313, -8338.0595703125, 248.03125),
        Vector(-4890.3989257813, -7514.8149414063, 597.21417236328),
        Vector(-4874.6333007813, -9573.6787109375, 597.21417236328),
        Vector(-2006.4217529297, -10097.737304688, 128.00402832031),
        Vector(-1958.3640136719, -6855.9858398438, 128.03125),
        Vector(-1875.0270996094, -4711.1899414063, 128.03125),
    }

    local outside_teleports = {}
    table.Add(outside_teleports, outside_area_0_teleports)
    table.Add(outside_teleports, outside_area_1_teleports)
    table.Add(outside_teleports, factory_part_teleports)


    insideCall("BriefcaseGoToOutsideArea0", function(ent) 
        if not GPU.IsDelayOver("BriefcaseGoToOutsideArea0") then
            return
        end
        if ent:IsPlayer() then
            GPU.SetDelay("BriefcaseGoToOutsideArea0", 0.5)
            local index = math.random(1, #outside_area_0_teleports)
            local pos = outside_area_0_teleports[index]
            ent:SetPos(pos)
        end
    end)

    insideCall("BriefcaseGoToOutsideArea1", function(ent) 
        if not GPU.IsDelayOver("BriefcaseGoToOutsideArea1") then
            return
        end
        if ent:IsPlayer() then
            GPU.SetDelay("BriefcaseGoToOutsideArea1", 0.5)
            local index = math.random(1, #outside_area_1_teleports)
            local pos = outside_area_1_teleports[index]
            ent:SetPos(pos)
        end
    end)

    insideCall("BriefcaseGoToFactoryPart", function(ent) 
        if not GPU.IsDelayOver("BriefcaseGoToFactoryPart") then
            return
        end
        if ent:IsPlayer() then
            GPU.SetDelay("BriefcaseGoToFactoryPart", 0.5)
            local index = math.random(1, #factory_part_teleports)
            local pos = factory_part_teleports[index]
            ent:SetPos(pos)
        end
    end)

    insideCall("BriefcaseGoToOutside", function(ent) 
        if not GPU.IsDelayOver("BriefcaseGoToOutside") then
            return
        end
        if ent:IsPlayer() then
            GPU.SetDelay("BriefcaseGoToOutside", 0.5)
            local index = math.random(1, #outside_teleports)
            local pos = outside_teleports[index]
            ent:SetPos(pos)
        end
    end)

end