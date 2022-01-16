local GPU = gm_post_ussr

GPU.TriggerInsideCallbacks = GPU.TriggerInsideCallbacks or {}
GPU.TriggerOutsideCallbacks = GPU.TriggerOutsideCallbacks or {}

function GPU.RegisterTriggerInsideCallback(name, func) 
    local list = GPU.TriggerInsideCallbacks
    if list[name] == nil then
        list[name] = {}
    end
    table.Add(list[name], { func })
end

function GPU.RegisterTriggerOutsideCallback(name, func) 
    local list = GPU.TriggerOutsideCallbacks
    if list[name] == nil then
        list[name] = {}
    end
    table.Add(list[name], { func })
end

function GPU.RunTriggerInsideCallback(name, ent) 
    local list = GPU.TriggerInsideCallbacks
    if list[name] == nil then
        return
    end
    for _, func in ipairs(list[name]) do 
        func(ent)
    end
end

function GPU.RunTriggerOutsideCallback(name, ent) 
    local list = GPU.TriggerOutsideCallbacks
    if list[name] == nil then
        return
    end
    for _, func in ipairs(list[name]) do 
        func(ent)
    end
end