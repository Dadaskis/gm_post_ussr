local soundsList = {
    "ambient_music_0",
    "ambient_music_1",
    "ambient_music_2",
    "ambient_music_3",
    "ambient_music_4",
    "ambient_music_5",
    "ambient_music_6",
    "ambient_music_7",
    "ambient_music_8",
    "ambient_music_9"
}

local musicPlayedMask = {}

for _, fileName in ipairs(soundsList) do
    resource.AddFile("sound/gm_post_ussr_ambient_music/" .. fileName .. ".mp3")
    util.PrecacheSound("gm_post_ussr_ambient_music/" .. fileName .. ".mp3")
end

if CLIENT and game.GetMap() == "gm_post_ussr" then
    local enabled = true
    local delay = 300
    local volume = 0.2

    local AwaitForMusic = nil
    local PlayMusic = nil

    local soundObject = nil

    CreateClientConVar("gm_post_ussr_ambient_enabled", 1, true, false, "[gm_post_ussr ambient music] If the value will be more than 0, then ambient will be played", 0, 1)
    CreateClientConVar("gm_post_ussr_ambient_volume", 0.2, true, false, "[gm_post_ussr ambient music] Volume is a number from 0 to 1 which describes how loud is the ambient music. 0 means its absolutely quiet, and 1 means maximum volume. By default equals to 0.2", 0.0, 1.0)
    CreateClientConVar("gm_post_ussr_ambient_delay", 300, true, false, "[gm_post_ussr ambient music] Value is amount of seconds you need to wait to get another ambient music. By default equals to 300", 0, 99999)

    hook.Add( "AddToolMenuCategories", "gm_post_ussr_custom_category", function()
        spawnmenu.AddToolCategory("gm_post_ussr ambient music", "gm_post_ussr ambient music", "#gm_post_ussr_ambient music")
    end)

    hook.Add( "PopulateToolMenu", "gm_post_ussr_populate_menu", function()
        spawnmenu.AddToolMenuOption( 'gm_post_ussr ambient music', 'gm_post_ussr ambient music', 'gm_post_ussr_ambient_music', 'gm_post_ussr Ambient Music', "", "", function(panel) 
            panel:CheckBox('Enable music', 'gm_post_ussr_ambient_enabled')
            panel:NumSlider("Volume", "gm_post_ussr_ambient_volume", 0.0, 1.0, 2)
            panel:NumSlider("Cooldown", "gm_post_ussr_ambient_delay", 0.0, 1000.0)
        end)
    end)

    AwaitForMusic = function() 
        delay = GetConVar("gm_post_ussr_ambient_delay"):GetInt()
        timer.Simple(delay, function() 
            PlayMusic() 
        end)
    end

    local playing = false

    PlayMusic = function() 
        enabled = GetConVar("gm_post_ussr_ambient_enabled"):GetBool()
        if not enabled then
            return
        end

        if playing then
            return
        end

        local musicList = {
            { "ambient_music_0", 4 * 60 + 34 },
            { "ambient_music_1", 5 * 60 + 27 },
            { "ambient_music_2", 5 * 60 + 40 },
            { "ambient_music_3", 3 * 60 + 08 },
            { "ambient_music_4", 4 * 60 + 32 },
            { "ambient_music_5", 4 * 60 + 45 },
            { "ambient_music_6", 5 * 60 + 52 },
            { "ambient_music_7", 6 * 60 + 22 },
            { "ambient_music_8", 4 * 60 + 06 },
            { "ambient_music_9", 6 * 60 + 40 },
        }

        local function PlayerPlaySound(name) 
            if LocalPlayer() == nil then
                return
            end
            if CreateSound == nil then
                return
            end
            soundObject = CreateSound(LocalPlayer(), Sound("gm_post_ussr_ambient_music/" .. name .. ".mp3"))
            if soundObject == nil then
                return
            end
            soundObject:Play()
            volume = GetConVar("gm_post_ussr_ambient_volume"):GetFloat()
            soundObject:ChangeVolume(volume, 0)
        end

        if #table.GetKeys(musicPlayedMask) >= #musicList then
            musicPlayedMask = {}
        end

        local function PickRandomMusic() 
            local music = musicList[math.random(1, #musicList)]
            if musicPlayedMask[music[1]] then
                return PickRandomMusic()
            end
            return music
        end

        local music = PickRandomMusic()
        PlayerPlaySound(music[1])
        playing = true
        timer.Create("gm_post_ussr_ambient_music.Music", music[2], 1, function()  
            AwaitForMusic() 
            playing = false
        end)
        musicPlayedMask[music[1]] = true
    end

    timer.Simple(15, function() 
        PlayMusic()
    end)

    cvars.AddChangeCallback("gm_post_ussr_ambient_volume", function(convar_name, value_old, value_new) 
        volume = tonumber(value_new)
        if soundObject then
            soundObject:ChangeVolume(volume, 0)
        end
    end)

    cvars.AddChangeCallback("gm_post_ussr_ambient_enabled", function(convar_name, value_old, value_new) 
        enabled = tonumber(value_new) > 0
        if enabled then
            playing = false
            PlayMusic()
        elseif soundObject then
            soundObject:Stop()
            timer.Remove("gm_post_ussr_ambient_music.Music")
            playing = false
        end
    end)

end