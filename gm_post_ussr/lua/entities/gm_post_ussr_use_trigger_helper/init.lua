local GPU = gm_post_ussr

ENT.Base = "base_gmodentity"
ENT.Type = "Anim"

function ENT:Initialize() 
    self:PhysicsInitBox(self.BoxMin, self.BoxMax)
    self:SetMoveType(MOVETYPE_NONE)
end

function ENT:Use(ply) 
    GPU.RunTriggerInsideCallback(self.TriggerName, ply)
end