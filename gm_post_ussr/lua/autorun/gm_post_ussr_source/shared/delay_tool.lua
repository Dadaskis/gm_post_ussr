local GPU = gm_post_ussr

GPU.Delays = {}

local delays = GPU.Delays

function GPU.SetDelay(name, length) 
    delays[name] = CurTime() + length
end

function GPU.IsDelayOver(name) 
    local delay = delays[name] or 0
    if CurTime() > delay then
        return true
    end
    return false
end