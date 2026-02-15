local GPU = gm_post_ussr
local Panel = {}

function Panel:Paint(width, height) 
    draw.RoundedBox(0, 0, 0, width, height, GPU.Colors.PanelBackground)
end

vgui.Register("gm_post_ussr.Panel", Panel, "DPanel")