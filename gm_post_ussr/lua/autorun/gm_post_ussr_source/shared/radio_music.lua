local soundsList = {
    "music_radio_0",
    "music_radio_1",
    "music_radio_2",
    "music_radio_3",
    "transition_radio_0",
    "transition_radio_1",
    "transition_radio_2"
}

for _, fileName in ipairs(soundsList) do
    resource.AddFile("sound/gm_post_ussr_radio/" .. fileName .. ".mp3")
    util.PrecacheSound("gm_post_ussr_radio/" .. fileName .. ".mp3")
end