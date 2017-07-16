local command = {}
command.PermissionLevel = 1
command.Shorthand = "ref"
command.Params = {"Optional:PlayerList"}
command.Usage = "refresh Player"
command.Description = [[Refresh the selected users character.]] 

command.Init = function(main)
end

command.Run = function(main,user,users,...)
    if (user == nil) then error("No user found") end
    local name = table.concat({...}," ")
    
    if (users == nil or #users == 0) then
        users = {user}
    end
    
    local list = {}
    for _,player in pairs(users) do
        table.insert(list,player.Name)
        
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local cf = player.Character.HumanoidRootPart.CFrame
            player:LoadCharacter()
            player.Character.HumanoidRootPart.CFrame = cf
        end        
        
    end
    return true,"Refreshed the following users: " .. table.concat(list,", "),list,user.Name .. " has refreshed you."
end

return command