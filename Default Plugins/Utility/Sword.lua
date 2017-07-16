local command = {}
command.PermissionLevel = 2
command.Shorthand = nil
command.Params = {"Optional:PlayerList"}
command.Usage = "sword Player"
command.Description = [[Give selected player a sword.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (users == nil or #users == 0) then
		users = {user}
	end
	
	local id = 125013769
	local gear = game:GetService("InsertService"):LoadAsset(id):GetChildren()
	
	if #gear < 1 then
		return false,"Sword could not be loaded"
	end
	
	gear = gear[1]
	if not gear:IsA("Tool") then
		return false, "Sword is not a gear"
	end
	
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		gear:Clone().Parent = player.Backpack
	end
	return true,"Given sword to " .. table.concat(list,", "),list,user.Name .. " given you a sword."
end

return command