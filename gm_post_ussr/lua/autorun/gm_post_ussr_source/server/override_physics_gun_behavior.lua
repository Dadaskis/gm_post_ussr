hook.Add("PhysgunPickup", "gm_post_ussr.OverridePhysgunForMapEntities", function(ply, ent) 
    local classNames = {
        "gm_post_ussr_damage_trigger_helper",
        "gm_post_ussr_use_trigger_helper"
    }
    for _, class in ipairs(classNames) do
        if ent:GetClass() == class then
            return false
        end
    end
end)