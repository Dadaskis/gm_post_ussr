local GPU = gm_post_ussr

ENT.Base = "base_brush"
ENT.Type = "Brush"

function ENT:KeyValue(key, value)
    local function keyCheck(expected) 
        if key == expected then
            return true
        end
        return false
    end

    if keyCheck("targetname") then
        self.PointName = value
    end    
end