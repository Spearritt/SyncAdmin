--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command change the character appearance of the selected user with the provided userid.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "char"
command.Params = {"PlayerList","Number"}
command.Usage = "character Player1,Player2,Player2,... UserId"
command.Description = [[Changes the Players' character apearance with the selected userId]] 

command.Init = function(main)
end

command.Run = function(main,user,users,id)
	local list = {}
	for _,player in pairs(users) do
		local char = player.CharacterAppearance
		if (char and tonumber(id)) then
			player.CharacterAppearance = "http://assetgame.roblox.com/Asset/CharacterFetch.ashx?userId=" .. id
			wait()
			player:LoadCharacter()
		end
		table.insert(list,player.Name)
	end
	return true,"Changed character appearance of " .. table.concat(list,", ") .. " to " .. id,list,user.Name .. " has changed your character appearance to: " .. id
end

return command
