
if game.GetMap() == "gm_post_ussr" then

	CreateClientConVar("gm_post_ussr_one_time_window_v1_was_opened", 0, true, false, "[gm_post_ussr ambient music] If the value will be 0, the window will open in the next time you join the map", 0, 1)

	hook.Add("InitPostEntity", "gm_post_ussr.CreateOneTimeWindow", function()
		local opened = GetConVar("gm_post_ussr_one_time_window_v1_was_opened"):GetBool()
		if not opened then
			local window = vgui.Create("gm_post_ussr.ImagesWindow")
			window:SetImages(
				{
					"gm_post_ussr_window_images/0.png", 
					"gm_post_ussr_window_images/1.png",
					"gm_post_ussr_window_images/2.png",
					"gm_post_ussr_window_images/3.png",
					"gm_post_ussr_window_images/4.png",
					"gm_post_ussr_window_images/5.png",
					"gm_post_ussr_window_images/6.png",
					"gm_post_ussr_window_images/7.png"
				}
			)
			RunConsoleCommand("gm_post_ussr_one_time_window_v1_was_opened", "1")
		end
	end)
	
end