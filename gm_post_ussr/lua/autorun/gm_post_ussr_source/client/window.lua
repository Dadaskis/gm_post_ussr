local GPU = gm_post_ussr

local Window = {}

function Window:Init() 
    self:SetTitle("")
end

function Window:OnScreenSizeChanged() 
    self:Close()
end

function Window:Paint(width, height) 
    draw.RoundedBox(0, 0, 0, width, height, GPU.Colors.WindowBackground)
end

vgui.Register("gm_post_ussr.Window", Window, "DFrame") 