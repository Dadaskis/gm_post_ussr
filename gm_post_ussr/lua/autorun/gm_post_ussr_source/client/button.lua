local GPU = gm_post_ussr
local Button = {}

function Button:Init() 
    self:SetTextColor(GPU.Colors.Text)
    self:SetFont("GPU.SFont" .. ScrH())

    self.Color = GPU.Colors.ButtonIdle
end

function Button:OnMousePressed() 
    self.GPUMousePressed = true
    self.Color = GPU.Colors.ButtonPressed
    self:DoClick()
end

function Button:OnMouseReleased() 
    self.SMousePressed = false
end

function Button:OnCursorEntered() 
    self.SMouseEntered = true
end

function Button:OnCursorExited() 
    self.SMouseEntered = false
end

function Button:Paint(width, height) 
    draw.RoundedBox(0, 0, 0, width, height, GPU.Colors.ButtonBorder)
    if not self.SMouseEntered then
        self.Color = GPU.ColorLerp(self.Color, GPU.Colors.ButtonIdle, 0.3)
    else
        self.Color = GPU.ColorLerp(self.Color, GPU.Colors.ButtonSelected, 0.4)
    end
    draw.RoundedBox(0, width * 0.01, height * 0.03, width * 0.99, height * 0.93, self.Color)
end

vgui.Register("gm_post_ussr.Button", Button, "DButton")