local GPU = gm_post_ussr
local Label = {}

function Label:Init() 
    self:SetFont("GPU.SFont" .. ScrH())
end

vgui.Register("gm_post_ussr.Label", Label, "DLabel")