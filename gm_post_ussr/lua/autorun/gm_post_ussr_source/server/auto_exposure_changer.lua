local GPU = gm_post_ussr

function GPU.SetPlayerAutoExposure(ply, min, max, bloomScale) 
    GPU:RunCallback("SetAutoExposure", { min, max, bloomScale }, ply)
end