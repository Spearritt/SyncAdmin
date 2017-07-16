local command = {}
command.PermissionLevel = 1
command.Shorthand = {"tp","to"}
command.Params = {"PlayerList","Optional:Player"}
command.Usage = "teleport Player1,Player2,Player3,... Target"
command.Description = [[Teleports all specified users to the target user.]] 

command.Init = function(main)
end

command.Run = function(main,user,users,target)
	if (target == nil) then
		if (#users < 1) then
			return false,"No target given"
		end
		target = users[1]
		users = {user}
	end
	
	if (target.Character and target.Character:findFirstChild("HumanoidRootPart") and target.Character.HumanoidRootPart:IsA("BasePart")) then
		local list = {}
		for _,player in pairs(users) do
			if (player.Character and player.Character:findFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart:IsA("BasePart")) then
				player.Character.HumanoidRootPart.Velocity = Vector3.new()
				player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
			end
			table.insert(list,player.Name)
		end
		return true,"Teleported users " .. table.concat(list,", ") .. " to " .. target.Name,
				list,user.Name .. " has teleported you to " .. target.Name,
				{target.Name},user.Name .. " has teleported " .. #list .. (#list > 1 and " users " or " user ") .. "to you"
	elseif (target.Character == nil) then
		return false,"Cannot teleport to " .. target.Name .. " at this time. They do not have a character."
	elseif (target.Character:findFirstChild("HumanoidRootPart") == nil or not target.Character.HumanoidRootPart:IsA("BasePart")) then
		return false,"Cannot teleport to " .. target.Name .. " at this time. They do not have a HumanoidRootPart."
	end
end

return command
