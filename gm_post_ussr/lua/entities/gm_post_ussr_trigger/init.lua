local GPU = gm_post_ussr

ENT.Base = "base_brush"
ENT.Type = "Brush"

-- Updates the bounds of this collision box
function ENT:SetBounds(min, max)
    self:SetSolid(SOLID_BBOX)
    self:SetCollisionBounds(min, max)
    self:SetTrigger(true)
end

-- Run when any entity starts touching our trigger
function ENT:StartTouch(ent)
    GPU.RunTriggerInsideCallback(self.TriggerName, ent)
end

function ENT:EndTouch(ent)
    GPU.RunTriggerOutsideCallback(self.TriggerName, ent)
end

function ENT:KeyValue(key, value)
    local function keyCheck(expected) 
        if key == expected then
            return true
        end
        return false
    end

    if keyCheck("targetname") then
        self.TriggerName = value
    end

    if keyCheck("parentname") then
        self.ParentName = value
        self:SetParent(GPU.GetNamedEnts(self.ParentName)[1])
    end
end

--function ENT:Use(ply) 
--    ply:ChatPrint("It works")
--end