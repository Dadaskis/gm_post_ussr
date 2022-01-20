local GPU = gm_post_ussr

GPU.NamedEntities = nil

function GPU.InitializeNamedEntities() 
    GPU.NamedEntities = {}
    local namedEnts = GPU.NamedEntities
    for index = 1, 65535 do 
        local ent = Entity(index)
        if IsValid(ent) then
            local name = ent:GetName()
            if name ~= nil then
                if namedEnts[name] == nil then
                    namedEnts[name] = {}
                end
                table.Add(namedEnts[name], { ent })
            end
        end
    end
end

function GPU.GetNamedEnts(name) 
    if not GPU.NamedEntities then
        GPU.InitializeNamedEntities()
    end
    return GPU.NamedEntities[name]
end

hook.Add("PreCleanupMap", "gm_post_ussr.NamedEntitiesOnMapCleanup", function() 
    GPU.NamedEntities = nil
end)

--hook.Add("InitPostEntity", "gm_post_ussr.NamedEntitiesOnInit", function() 
    --GPU.InitializeNamedEntities() 
--end)
