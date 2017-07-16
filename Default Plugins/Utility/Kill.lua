local command = {}
command.PermissionLevel = 1
command.Shorthand = nil 
command.Params = {"Optional:PlayerList"}
command.Usage = "kill Player"
command.Description = [[Kill a selected player.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (user == nil) then error("No user found") end
	
	if (users == nil or #users == 0) then
		users = {user}
	end
	
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		local char = player.Character
        
        if char ~= nil then
            player.Character:BreakJoints()
        end
	end
	return true,"Killed players: " .. table.concat(list,", "),list,user.Name .. " has killed you."
end

return command
