local GPU = gm_post_ussr

function GPU.SetPlayerAutoExposure(ply, min, max) 
    GPU:RunCallback("SetAutoExposure", { min, max }, ply)
end