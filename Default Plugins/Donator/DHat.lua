--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to give the selected player a hat from the Roblox catalog.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"Number"}
command.Usage = "dhat <ID>"
command.Description = "[Donator]: Give yourself a hat." 
command.AllowDonators = true

command.Init = function(main)
end

command.Run = function(main,user,id)
	if (user == nil) then error("No user found") end
	local hat = game:GetService("InsertService"):LoadAsset(id):GetChildren()
	if #hat < 1 then
		return false,"ID could not be loaded"
	end
	hat = hat[1]
	if not hat:IsA("Hat") and not hat:IsA("Accoutrement") then
		return false, "ID is not a hat"
	end
	hat:Clone().Parent = user.Character
	return true,"Given hat to you."
end

return command