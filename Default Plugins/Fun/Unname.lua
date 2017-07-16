--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to remove the selected players custom name.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"PlayerList"}
command.Usage = "unname Player"
command.Description = [[Changes the Players' character name back to what it 
originally was.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (user == nil) then error("No user found") end
	
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		local char = player.Character
		if (char) then
			if (char:findFirstChild("NameModel") and char.NameModel.Value) then
				char.NameModel.Value:Destroy()
				char.NameModel:Destroy()
			end
			if (char:findFirstChild("Head")) then
				char.Head.Transparency = 0
			end
		end
	end
	return true,"Unnamed players " .. table.concat(list,", "),list,user.Name .. " has removed your name."
end

return command
