--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to set the name of the selected player.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"PlayerList","..."}
command.Usage = "name Player Name"
command.Description = [[Changes the Players' character name to Name.]] 

command.Init = function(main)
end

command.Run = function(main,user,users,...)
	if (user == nil) then error("No user found") end
	local name = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
	
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		local char = player.Character
		--// Detect R15
		if char:FindFirstChild("Humanoid").RigType == Enum.HumanoidRigType.R15 then
			return false,"This plugin is not compatible with R15 characters"
		else
			if (char) then
				if (char:findFirstChild("NameModel") and char.NameModel.Value) then
					char.NameModel.Value.Name = name
				else
					local m = Instance.new("Model")
					m.Name = name
					
					local head = char.Head:clone()
					head.Transparency = 0
					head.Parent = m
					
					local h = Instance.new("Humanoid")
					h.MaxHealth = 100
					h.Parent = m
					
					local v = Instance.new("ObjectValue")
					v.Value = m
					v.Name = "NameModel"
					v.Parent = char
					
					local w = Instance.new("Weld")
					w.C0 = CFrame.new(0,1.5,0)
					w.Part0 = char.Torso
					w.Part1 = head
					w.Parent = char
					
					char.Head.Transparency = 1
					m.Parent = char
				end
			end
			return true,"Renamed players " .. table.concat(list,", ") .. " to " .. name,list,user.Name .. " has named you to: " .. name
		end
	end
end

return command
