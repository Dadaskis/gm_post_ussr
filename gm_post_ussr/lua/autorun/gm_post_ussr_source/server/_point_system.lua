local GPU = gm_post_ussr

GPU.PointsList = GPU.PointsList or {}

hook.Add("InitPostEntity", "gm_post_ussr.RememberPoints", function() 
    local points = ents.FindByClass("gm_post_ussr_point")
    for _, point in pairs(points) do 
        if GPU.PointsList[point.PointName] == nil then
            GPU.PointsList[point.PointName] = {}
        end
        local pointsTable = GPU.PointsList[point.PointName]
        table.Add(pointsTable, { point:GetPos() })
    end
end)

function GPU.GetPoints(name) 
    return GPU.PointsList[name]
end

function GPU.GetRandomPoint(name)
    local tbl = GPU.PointsList[name]
    local index = math.random(1, #tbl)
    return tbl[index]
end