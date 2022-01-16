local GPU = gm_post_ussr
GPU.Callbacks = GPU.Callbacks or {}

util.AddNetworkString("gm_post_ussr.RunCallBack")

net.Receive("gm_post_ussr.RunCallback", function(byteLength, player) 
    local functionName = net.ReadString()
    local args = net.ReadTable()
    GPU.Callbacks[functionName](args, player)
end) 

function GPU:RunCallback(functionName, tbl, player) 
    net.Start("gm_post_ussr.RunCallBack")
        net.WriteString(functionName)
        net.WriteTable(tbl)
    if player and IsValid(player) then
        net.Send(player)
    else
        net.Broadcast()
    end
end