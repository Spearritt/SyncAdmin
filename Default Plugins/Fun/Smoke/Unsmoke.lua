--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to remove smoke from the selected user.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"PlayerList"}
command.Usage = "unsmoke Player1,Player2,..."
command.Description = [[Removes someone's smoke]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	local list = {}
	for _,player in pairs(users) do
		if (player.Character and player.Character:findFirstChild("HumanoidRootPart")) then
			for _,fire in pairs(player.Character.HumanoidRootPart:children()) do
				if (fire:IsA("Smoke")) then fire:Destroy() end
			end
			table.insert(list,player.Name)
		end
	end
	return true,"Removed the following people's smoke: " .. table.concat(list,", "),list,user.Name .. " removed your smoke."
end

return command
