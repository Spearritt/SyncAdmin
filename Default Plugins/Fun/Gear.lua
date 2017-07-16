--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to give the selected gear ID to the selected player.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 2
command.Shorthand = nil
command.Params = {"PlayerList","Number"}
command.Usage = "gear Player ID"
command.Description = [[Give selected player a gear item.]] 

command.Init = function(main)
end

command.Run = function(main,user,users,id)
	if (user == nil) then error("No user found") end
	local gear = game:GetService("InsertService"):LoadAsset(id):GetChildren()
	if #gear < 1 then
		return false,"ID could not be loaded"
	end
	gear = gear[1]
	if not gear:IsA("Tool") then
		return false, "ID is not a gear"
	end
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		gear:Clone().Parent = player.Backpack
	end
	return true,"Given gear item to " .. table.concat(list,", "),list,user.Name .. " given you a gear item."
end

return command