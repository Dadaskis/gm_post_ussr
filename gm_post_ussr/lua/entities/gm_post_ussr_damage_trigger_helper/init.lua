local GPU = gm_post_ussr

ENT.Base = "base_gmodentity"
ENT.Type = "Anim"

function ENT:Initialize() 
    self:PhysicsInitBox(self.BoxMin, self.BoxMax)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolidFlags(1)

    --self:PhysicsInit(SOLID_VPHYSICS)
    --self:SetMoveType(MOVETYPE_VPHYSICS)
    --self:SetSolid(SOLID_VPHYSICS)
end

function ENT:OnTakeDamage(dmg)
    GPU.RunTriggerInsideCallback(self.TriggerName, dmg:GetAttacker())
end