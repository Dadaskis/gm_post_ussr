local GMP = gm_post_ussr
GMP.Callbacks = GMP.Callbacks or {}

net.Receive("gm_post_ussr.RunCallback", function() 
    local functionName = net.ReadString()
    local args = net.ReadTable()
    GMP.Callbacks[functionName](args)
end) 

function GMP:RunCallback(functionName, tbl) 
    net.Start("gm_post_ussr.RunCallBack")
        net.WriteString(functionName)
        net.WriteTable(tbl)
    net.SendToServer()
end