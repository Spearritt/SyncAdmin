local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"Optional:PlayerList","Optional:Number"}
command.Usage = "heal Player1,Player2,Player3,... [Amount]"
command.Description = [[Heals the users either to full health or by the given amount]] 

command.Init = function(main)
end

command.Run = function(main,user,users,amount)
	if (users == nil or #users == 0) then
		users = {user}
	end
	
	if (amount and amount < 0) then
		return false,"Cannot heal by negative amount"
	end
	
	local list = {}
	for _,player in pairs(users) do
		if (player.Character and player.Character:FindFirstChild("Humanoid")) then
			local hum = player.Character.Humanoid
			if (amount) then
				hum.Health = hum.Health + amount
			else
				hum.Health = hum.MaxHealth
			end
		end
		table.insert(list,player.Name)
	end
	
	if (amount == nil) then
		return true,"Healed users " .. table.concat(list,", "),
			list,user.Name .. " has healed you"
	else
		return true,"Healed users " .. table.concat(list,", ") .. " by " .. amount .. " health",
			list,user.Name .. " has healed you by " .. amount .. " health"
	end
end

return command
