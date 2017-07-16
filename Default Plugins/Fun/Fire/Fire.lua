--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to set the selected user on fire.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"burn"}
command.Params = {"PlayerList"}
command.Usage = "fire Player1,Player2,..."
command.Description = [[Sets the players' torso on fire!!]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	local list = {}
	for _,player in pairs(users) do
		if (player.Character) then
			Instance.new("Fire",player.Character:findFirstChild("HumanoidRootPart"))
			table.insert(list,player.Name)
		end
	end
	return true,"Set the following people ablaze: " .. table.concat(list,", "),list,user.Name .. " set your torso on fire."
end

return command
