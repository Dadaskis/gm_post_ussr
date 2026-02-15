include("shared.lua")

local GPU = gm_post_ussr
GPU.PlayingSounds = GPU.PlayingSounds or {}

function ENT:Draw() 
	self:DrawModel()
end

function ENT:Think() 
    if self.Enabled == false then
        return
    end
    local distance = LocalPlayer():GetPos():Distance(self:GetPos())
    if distance > 3000 then
        self.OutOfDistance = true
    elseif self.OutOfDistance then
        self.OutOfDistance = false
        self:PlayMusic()
    end
end

function ENT:Initialize() 
    self.Enabled = true
    self:PlayMusic()
end

local function PlayMusic(self) 
    if self.Enabled == false then
        return
    end

    local musicList = {
        {"music_radio_0", 3 * 60 + 42},
        {"music_radio_1", 3 * 60 + 42},
        {"music_radio_2", 3 * 60 + 29},
        {"music_radio_3", 3 * 60 + 29}
    }

    local transitionList = {
        {"transition_radio_0", 3},
        {"transition_radio_0", 3},
        {"transition_radio_0", 3}
    }
    local function EntityPlaySound(name) 
        if self ~= nil then
            if IsValid(self) then 
                if GPU.PlayingSounds[self:EntIndex()]~= nil then
                    GPU.PlayingSounds[self:EntIndex()]:Stop()
                    GPU.PlayingSounds[self:EntIndex()] = nil
                end
                GPU.PlayingSounds[self:EntIndex()] = CreateSound(self, Sound("gm_post_ussr_radio/" .. name .. ".mp3"))
                GPU.PlayingSounds[self:EntIndex()]:Play()
                self.playingSound = GPU.PlayingSounds[self:EntIndex()]
            end
        end
    end
    local transition = transitionList[math.random(1, #transitionList)]
    EntityPlaySound(transition[1])
    timer.Create("GPU.RadioSound" .. self:EntIndex(), transition[2], 1, function() 
        local music = musicList[math.random(1, #musicList)]
        EntityPlaySound(music[1])
        timer.Create("GPU.RadioSound" .. self:EntIndex(), music[2], 1, function()  
            if IsValid(self) then
                self:PlayMusic()
            end
        end)
    end)
end

local function StopMusic(self) 
    if GPU.PlayingSounds[self:EntIndex()]~= nil then
        GPU.PlayingSounds[self:EntIndex()]:Stop()
        GPU.PlayingSounds[self:EntIndex()] = nil
    end
end

function ENT:PlayMusic() 
    PlayMusic(self)
end

function ENT:StopMusic() 
    GPU.PlayingSounds[self:EntIndex()]:Stop()
    GPU.PlayingSounds[self:EntIndex()] = nil
end

function ENT:OnRemove() 
    StopMusic(self)
end