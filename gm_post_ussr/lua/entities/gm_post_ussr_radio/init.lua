AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local GPU = gm_post_ussr

function ENT:Initialize() 
    if self.WasInitialized then
        return
    end
    self.WasInitialized = true

	self:SetModel("models/gm_post_ussr/Radio0.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self.EntityHealth = 20
    self.Timer = 0

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		--physicsObj:SetMass(1)
	end 
end

function ENT:OnTakeDamage(damage) 
    self:TriggerOutput("OnDamaged", self)
    self.EntityHealth = self.EntityHealth - damage:GetDamage()
    self.Timer = os.time() + 60
    local player = damage:GetAttacker()
    if player:IsPlayer() then
        local eyeTrace = player:GetEyeTrace()
        if self.EntityHealth < 0 then
            self:TriggerOutput("OnDestroyedByPlayer", self)
            self:Remove()
            local explode = ents.Create("env_explosion") 
            explode:SetPos(self:GetPos())
            explode:Spawn()
            explode:SetKeyValue("iMagnitude", "20")
            explode:Fire("Explode", 0, 0)
        end
    end
end

function ENT:Think() 
    if self.Timer < os.time() then
        self.EntityHealth = 20
    end
end