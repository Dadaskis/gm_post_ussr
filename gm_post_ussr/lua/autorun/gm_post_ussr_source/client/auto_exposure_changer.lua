local GPU = gm_post_ussr

function GPU.Callbacks.SetAutoExposure(args) 
    local min = args[1]
    local max = args[2]
    RunConsoleCommand("mat_autoexposure_min", tostring(min))
    RunConsoleCommand("mat_autoexposure_max", tostring(max))
end