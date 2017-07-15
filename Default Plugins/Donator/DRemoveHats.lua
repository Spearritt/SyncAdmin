--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to remove the selected players hat they are currently wearing.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"dnohats"}
command.Params = nil
command.Usage = "dremovehats"
command.Description = [[Removes your hats]] 
command.AllowDonators = true

command.Init = function(main)
end

command.Run = function(main,user)
	if (user.Character) then
		for _,i in pairs(user.Character:children()) do
			if (i:IsA("Accoutrement")) then
				i:Destroy()
			end
		end
	end
	return true,"Removed your hats."
end

return command