--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to set the selected user into a Roblox guest avatar.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"Optional:PlayerList"}
command.Usage = "guest Player1,Player2,..."
command.Description = [[Makes the selected user a guest]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (users == nil or #users == 0) then users = {user} end
	local list = {}
	for _,player in pairs(users) do
		local char = player.CharacterAppearance
		if (char) then
			player.CharacterAppearance = "http://assetgame.roblox.com/Asset/CharacterFetch.ashx?userId=1"
			wait()
			player:LoadCharacter()
		end
		table.insert(list,player.Name)
	end
	return true,"Made the following users a guest: " .. table.concat(list,", "),list,user.Name .. " has made you a guest"
end

return command
