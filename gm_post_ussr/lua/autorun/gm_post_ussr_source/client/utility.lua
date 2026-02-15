local GPU = gm_post_ussr

function GPU.ColorLerp(from, to, ratio) 
    local first = Vector(from.r, from.g, from.b)
    local second = Vector(to.r, to.g, to.b)
    local result = LerpVector(ratio, first, second)
    local alpha = Lerp(ratio, from.a, to.a)
    return Color(result.x, result.y, result.z, alpha)
end