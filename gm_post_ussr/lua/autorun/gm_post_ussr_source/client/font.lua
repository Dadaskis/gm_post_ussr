local GPU = gm_post_ussr
GPU.FontsExist = {}

function GPU:GenerateFonts()

    surface.CreateFont(
        "GPU.Font" .. ScrH(),
        {
            font = "DermaDefault",
            extended = true,
            size = ScrH() * 0.045,
            weight = 500,
            blursize = 0,
            scanlines = 0,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = false,
            outline = false
        }
    )

    surface.CreateFont(
        "GPU.SFont" .. ScrH(),
        {
            font = "DermaDefault",
            extended = true,
            size = ScrH() * 0.023,
            weight = 500,
            blursize = 0,
            scanlines = 0,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = false,
            outline = false
        }
    )

    surface.CreateFont(
        "GPU.HUD" .. ScrH(),
        {
            font = "DermaDefault",
            extended = true,
            size = ScrH() * 0.03,
            weight = 500,
            blursize = 0,
            scanlines = 0,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = false,
            outline = true
        }
    )

    surface.CreateFont(
        "GPU.MFont" .. ScrH(),
        {
            font = "DermaDefault",
            extended = true,
            size = ScrH() * 0.015,
            weight = 500,
            blursize = 0,
            scanlines = 0,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = false,
            outline = false
        }
    )

    self.FontsExist[ScrH()] = true
end

GPU:GenerateFonts()

timer.Create("GPU.ResolutionChecker", 1, 0, function()
    if not GPU.FontsExist[ScrH()] then
        GPU:GenerateFonts()
    end
end)