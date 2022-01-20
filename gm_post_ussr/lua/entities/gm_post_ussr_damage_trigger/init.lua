local GPU = gm_post_ussr

ENT.Base = "base_brush"
ENT.Type = "Brush"

function ENT:Initialize() 
    local mins = self:LocalToWorld(self:OBBMins())
    local maxs = self:LocalToWorld(self:OBBMaxs())

    local ent = ents.Create("gm_post_ussr_damage_trigger_helper")
    ent.BoxMax = maxs
    ent.BoxMin = mins
    ent.TriggerName = self.TriggerName
    ent.ParentName = self.ParentName
    ent:Spawn()
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
    end
end