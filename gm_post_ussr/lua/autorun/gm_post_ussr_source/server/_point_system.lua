local GPU = gm_post_ussr

GPU.PointsList = GPU.PointsList or {}

function GPU.InitializePoints() 
    local points = ents.FindByClass("gm_post_ussr_point")
    for _, point in pairs(points) do 
        if GPU.PointsList[point.PointName] == nil then
            GPU.PointsList[point.PointName] = {}
        end
        local pointsTable = GPU.PointsList[point.PointName]
        table.Add(pointsTable, { point })
    end
end

hook.Add("InitPostEntity", "gm_post_ussr.RememberPoints", function() 
    GPU.InitializePoints()
end)

function GPU.GetPoints(name) 
    return GPU.PointsList[name]
end

function GPU.GetRandomPoint(name)
    local tbl = GPU.PointsList[name]
    local index = math.random(1, #tbl)
    if tbl[index] then
        return tbl[index]:GetPos()
    end
    return nil
end

hook.Add("PostCleanupMap", "gm_post_ussr.PointsOnMapCleanup", function() 
    GPU.PointsList = {}
    GPU.InitializePoints()
end)